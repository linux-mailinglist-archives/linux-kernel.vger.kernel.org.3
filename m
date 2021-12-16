Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2CA477AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhLPRfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:35:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54454 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhLPRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:35:15 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id C523C20B7179;
        Thu, 16 Dec 2021 09:35:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C523C20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639676114;
        bh=oARjDRfZQWY3Cme8+4IVbUVjfvrWPS9qIDnFNjaj9kM=;
        h=From:To:Cc:Subject:Date:From;
        b=SGnYE798AcJmegirNcwtOPag1zPT/CG8JPFNw59StQftymVd9om+XjByExognvaA1
         KObI+QeI09zUV9gMrQInjpCBb2Kh1pf5G+QZjnDZBpglbp27O3kOCY0q0COyDUafwb
         NDFESm2VjIj8siLrqJDqfECEQTAwNJ/gEh0nvvUA=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v8 00/12] user_events: Enable user processes to create and write to trace events
Date:   Thu, 16 Dec 2021 09:34:59 -0800
Message-Id: <20211216173511.10390-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User mode processes that wish to use trace events to get data into
ftrace, perf, eBPF, etc are limited to uprobes today. The user events
features enables an ABI for user mode processes to create and write to
trace events that are isolated from kernel level trace events. This
enables a faster path for tracing from user mode data as well as opens
managed code to participate in trace events, where stub locations are
dynamic.

User processes often want to trace only when it's useful. To enable this
a set of pages are mapped into the user process space that indicate the
current state of the user events that have been registered. User
processes can check if their event is hooked to a trace/probe, and if it
is, emit the event data out via the write() syscall.

Two new files are introduced into tracefs to accomplish this:
user_events_status - This file is mmap'd into participating user mode
processes to indicate event status.

user_events_data - This file is opened and register/delete ioctl's are
issued to create/open/delete trace events that can be used for tracing.

The typical scenario is on process start to mmap user_events_status. Processes
then register the events they plan to use via the REG ioctl. The ioctl reads
and updates the passed in user_reg struct. The status_index of the struct is
used to know the byte in the status page to check for that event. The
write_index of the struct is used to describe that event when writing out to
the fd that was used for the ioctl call. The data must always include this
index first when writing out data for an event. Data can be written either by
write() or by writev().

For example, in memory:
int index;
char data[];

Psuedo code example of typical usage:
struct user_reg reg;

int page_fd = open("user_events_status", O_RDWR);
char *page_data = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, page_fd, 0);
close(page_fd);

int data_fd = open("user_events_data", O_RDWR);

reg.size = sizeof(reg);
reg.name_args = (__u64)"test";

ioctl(data_fd, DIAG_IOCSREG, &reg);
int status_id = reg.status_index;
int write_id = reg.write_index;

struct iovec io[2];
io[0].iov_base = &write_id;
io[0].iov_len = sizeof(write_id);
io[1].iov_base = payload;
io[1].iov_len = sizeof(payload);

if (page_data[status_id])
	writev(data_fd, io, 2);

User events are also exposed via the dynamic_events tracefs file for
both create and delete. Current status is exposed via the user_events_status
tracefs file.

Simple example to register a user event via dynamic_events:
	echo u:test >> dynamic_events
	cat dynamic_events
	u:test

If an event is hooked to a probe, the probe hooked shows up:
	echo 1 > events/user_events/test/enable
	cat user_events_status
	1:test # Used by ftrace

	Active: 1
	Busy: 1
	Max: 4096

If an event is not hooked to a probe, no probe status shows up:
	echo 0 > events/user_events/test/enable
	cat user_events_status
	1:test

	Active: 1
	Busy: 0
	Max: 4096

Users can describe the trace event format via the following format:
	name[:FLAG1[,FLAG2...] [field1[;field2...]]

Each field has the following format:
	type name

Example for char array with a size of 20 named msg:
	echo 'u:detailed char[20] msg' >> dynamic_events
	cat dynamic_events
	u:detailed char[20] msg

Data offsets are based on the data written out via write() and will be
updated to reflect the correct offset in the trace_event fields. For dynamic
data it is recommended to use the new __rel_loc data type. This type will be
the same as __data_loc, but the offset is relative to this entry. This allows
user_events to not worry about what common fields are being inserted before
the data.

The above format is valid for both the ioctl and the dynamic_events file.

V2:
Fixed kmalloc vs kzalloc for register_page.
Renamed user_event_mmap to user_event_status.
Renamed user_event prefix from ue to u.
Added seq_* operations to user_event_status to enable cat output.
Aligned field parsing to synth_events format (+ size specifier for
custom/user types).
Added uapi header user_events.h to align kernel and user ABI definitions.

V3:
Updated ABI to handle single FD into many events via an int header.
Added iovec/writev support to enable int header without payload changes.
Updated bpf context to describe if data is coming from user, kernel or
raw iovec.
Added flag support for registering event, allows forcing BPF to always
recieve the direct iovecs for sensitive code paths that do not want
copies.

V4:
Moved to struct user_reg for registering events via ioctl.
Added unit tests for ftrace, dyn_events and perf integration.
Added print_fmt generation and proper dyn_events matching statements.
Reduced time in preemption disabled paths.
Added documentation file.
Pre-fault in data when preemption is enabled and use no-fault copy in probes.
Fixed MIPs missing PAGE_READONLY define.

V5:
Rebase to linux-trace for-next branch.
Added sample code into samples/user_events.
Switched to str_has_prefix in various locations.
Allow hex in array sizes and ensure reasonable sizes are used.
Moved lifetime of name buffer when parsing to the caller for failure paths.
Fixed documentation nits and index.
Ensure event isn't busy before freeing through dyn_events.
Properly handle failure case for ftrace and perf in fault cases for buffers.
Ensure write data is over min size and null terminated for dynamic arrays.

V6:
Fixed endian issue with dyn loc decoding (use u32).
Fixed size_t conversion warning on hexagon arch (min vs min_t).
Handle cases for __get_str vs __get_rel_str in print_fmt generation.
Add additional comments around various event member lifetimes.
Reduced max field array size to 1K.

V7:
Acquire reg_mutex during release, ensure refs cannot change under any situation.
Remove default n from Kconfig.
Move from static 0644 mode to TRACE_MODE_WRITE.

V8:
Squashed UABI header into ftrace minimal patch thread.
Moved pagefault_disable/enable into copy_nofault.
Moved to strscpy vs custom copy when getting array size from type.
Made patch bisect friendly by ensuring tests are split from kernel code.

Beau Belgrave (12):
  user_events: Add minimal support for trace_event into ftrace
  user_events: Add print_fmt generation support for basic types
  user_events: Handle matching arguments from dyn_events
  user_events: Add basic perf and eBPF support
  user_events: Add self-test for ftrace integration
  user_events: Add self-test for dynamic_events integration
  user_events: Add self-test for perf_event integration
  user_events: Optimize writing events by only copying data once
  user_events: Add documentation file
  user_events: Add sample code for typical usage
  user_events: Validate user payloads for size and null termination
  user_events: Add self-test for validator boundaries

 Documentation/trace/index.rst                 |    1 +
 Documentation/trace/user_events.rst           |  195 ++
 include/uapi/linux/user_events.h              |   71 +
 kernel/trace/Kconfig                          |   14 +
 kernel/trace/Makefile                         |    1 +
 kernel/trace/trace_events_user.c              | 1618 +++++++++++++++++
 samples/user_events/Makefile                  |    5 +
 samples/user_events/example.c                 |   91 +
 tools/testing/selftests/user_events/Makefile  |    9 +
 .../testing/selftests/user_events/dyn_test.c  |  130 ++
 .../selftests/user_events/ftrace_test.c       |  452 +++++
 .../testing/selftests/user_events/perf_test.c |  168 ++
 tools/testing/selftests/user_events/settings  |    1 +
 13 files changed, 2756 insertions(+)
 create mode 100644 Documentation/trace/user_events.rst
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 kernel/trace/trace_events_user.c
 create mode 100644 samples/user_events/Makefile
 create mode 100644 samples/user_events/example.c
 create mode 100644 tools/testing/selftests/user_events/Makefile
 create mode 100644 tools/testing/selftests/user_events/dyn_test.c
 create mode 100644 tools/testing/selftests/user_events/ftrace_test.c
 create mode 100644 tools/testing/selftests/user_events/perf_test.c
 create mode 100644 tools/testing/selftests/user_events/settings


base-commit: 67d4f6e3bf5dddced226fbf19704cdbbb0c98847
-- 
2.17.1

