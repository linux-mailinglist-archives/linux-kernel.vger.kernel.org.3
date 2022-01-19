Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75257493657
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352495AbiASIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiASIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:32:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556A8C061574;
        Wed, 19 Jan 2022 00:32:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64226146E;
        Wed, 19 Jan 2022 08:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D5CC004E1;
        Wed, 19 Jan 2022 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642581127;
        bh=bGoedu0kGZwIikqRA501BSdU7IIF01dnNErhdh8beBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IRaNFJc0ZANSrEQlilmAOKDGIzW2JFqrEwDHA1S/movd4iBYCbrnj53qifIeoP2fZ
         PsuXA8OhUqeFp4MMZ5jfF/5HhCODOkji3VKNsYLTMc6AdSjubNo0HF3CUyLsy/2W4g
         RaBwC5TWEnzOhcTMta0nf66K6qBAdOe0RS75DcHrJyZC+6+fdQoyyWKd8l1ECl08TN
         W0ln5/MS8i3HaGNPl2Q1yvEWvo2MNp1pxyGK69ipv+KViyWDRu3NoS01nHGdtXZc+q
         RRlF0LqN6arApUmmW/b3tkYsYexHIMETsc9GR0GU0SrK8eWw3N09ZWmV5BaEGmsXkj
         3JRdRZE8tVxeA==
Date:   Wed, 19 Jan 2022 17:32:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/12] user_events: Enable user processes to create
 and write to trace events
Message-Id: <20220119173203.7fb0cf37add3f7e6faeb7721@kernel.org>
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

Thanks for updating. This series looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Regards,

On Tue, 18 Jan 2022 12:43:14 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> User mode processes that wish to use trace events to get data into
> ftrace, perf, eBPF, etc are limited to uprobes today. The user events
> features enables an ABI for user mode processes to create and write to
> trace events that are isolated from kernel level trace events. This
> enables a faster path for tracing from user mode data as well as opens
> managed code to participate in trace events, where stub locations are
> dynamic.
> 
> User processes often want to trace only when it's useful. To enable this
> a set of pages are mapped into the user process space that indicate the
> current state of the user events that have been registered. User
> processes can check if their event is hooked to a trace/probe, and if it
> is, emit the event data out via the write() syscall.
> 
> Two new files are introduced into tracefs to accomplish this:
> user_events_status - This file is mmap'd into participating user mode
> processes to indicate event status.
> 
> user_events_data - This file is opened and register/delete ioctl's are
> issued to create/open/delete trace events that can be used for tracing.
> 
> The typical scenario is on process start to mmap user_events_status. Processes
> then register the events they plan to use via the REG ioctl. The ioctl reads
> and updates the passed in user_reg struct. The status_index of the struct is
> used to know the byte in the status page to check for that event. The
> write_index of the struct is used to describe that event when writing out to
> the fd that was used for the ioctl call. The data must always include this
> index first when writing out data for an event. Data can be written either by
> write() or by writev().
> 
> For example, in memory:
> int index;
> char data[];
> 
> Psuedo code example of typical usage:
> struct user_reg reg;
> 
> int page_fd = open("user_events_status", O_RDWR);
> char *page_data = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, page_fd, 0);
> close(page_fd);
> 
> int data_fd = open("user_events_data", O_RDWR);
> 
> reg.size = sizeof(reg);
> reg.name_args = (__u64)"test";
> 
> ioctl(data_fd, DIAG_IOCSREG, &reg);
> int status_id = reg.status_index;
> int write_id = reg.write_index;
> 
> struct iovec io[2];
> io[0].iov_base = &write_id;
> io[0].iov_len = sizeof(write_id);
> io[1].iov_base = payload;
> io[1].iov_len = sizeof(payload);
> 
> if (page_data[status_id])
> 	writev(data_fd, io, 2);
> 
> User events are also exposed via the dynamic_events tracefs file for
> both create and delete. Current status is exposed via the user_events_status
> tracefs file.
> 
> Simple example to register a user event via dynamic_events:
> 	echo u:test >> dynamic_events
> 	cat dynamic_events
> 	u:test
> 
> If an event is hooked to a probe, the probe hooked shows up:
> 	echo 1 > events/user_events/test/enable
> 	cat user_events_status
> 	1:test # Used by ftrace
> 
> 	Active: 1
> 	Busy: 1
> 	Max: 4096
> 
> If an event is not hooked to a probe, no probe status shows up:
> 	echo 0 > events/user_events/test/enable
> 	cat user_events_status
> 	1:test
> 
> 	Active: 1
> 	Busy: 0
> 	Max: 4096
> 
> Users can describe the trace event format via the following format:
> 	name[:FLAG1[,FLAG2...] [field1[;field2...]]
> 
> Each field has the following format:
> 	type name
> 
> Example for char array with a size of 20 named msg:
> 	echo 'u:detailed char[20] msg' >> dynamic_events
> 	cat dynamic_events
> 	u:detailed char[20] msg
> 
> Data offsets are based on the data written out via write() and will be
> updated to reflect the correct offset in the trace_event fields. For dynamic
> data it is recommended to use the new __rel_loc data type. This type will be
> the same as __data_loc, but the offset is relative to this entry. This allows
> user_events to not worry about what common fields are being inserted before
> the data.
> 
> The above format is valid for both the ioctl and the dynamic_events file.
> 
> V2:
> Fixed kmalloc vs kzalloc for register_page.
> Renamed user_event_mmap to user_event_status.
> Renamed user_event prefix from ue to u.
> Added seq_* operations to user_event_status to enable cat output.
> Aligned field parsing to synth_events format (+ size specifier for
> custom/user types).
> Added uapi header user_events.h to align kernel and user ABI definitions.
> 
> V3:
> Updated ABI to handle single FD into many events via an int header.
> Added iovec/writev support to enable int header without payload changes.
> Updated bpf context to describe if data is coming from user, kernel or
> raw iovec.
> Added flag support for registering event, allows forcing BPF to always
> recieve the direct iovecs for sensitive code paths that do not want
> copies.
> 
> V4:
> Moved to struct user_reg for registering events via ioctl.
> Added unit tests for ftrace, dyn_events and perf integration.
> Added print_fmt generation and proper dyn_events matching statements.
> Reduced time in preemption disabled paths.
> Added documentation file.
> Pre-fault in data when preemption is enabled and use no-fault copy in probes.
> Fixed MIPs missing PAGE_READONLY define.
> 
> V5:
> Rebase to linux-trace for-next branch.
> Added sample code into samples/user_events.
> Switched to str_has_prefix in various locations.
> Allow hex in array sizes and ensure reasonable sizes are used.
> Moved lifetime of name buffer when parsing to the caller for failure paths.
> Fixed documentation nits and index.
> Ensure event isn't busy before freeing through dyn_events.
> Properly handle failure case for ftrace and perf in fault cases for buffers.
> Ensure write data is over min size and null terminated for dynamic arrays.
> 
> V6:
> Fixed endian issue with dyn loc decoding (use u32).
> Fixed size_t conversion warning on hexagon arch (min vs min_t).
> Handle cases for __get_str vs __get_rel_str in print_fmt generation.
> Add additional comments around various event member lifetimes.
> Reduced max field array size to 1K.
> 
> V7:
> Acquire reg_mutex during release, ensure refs cannot change under any situation.
> Remove default n from Kconfig.
> Move from static 0644 mode to TRACE_MODE_WRITE.
> 
> V8:
> Squashed UABI header into ftrace minimal patch thread.
> Moved pagefault_disable/enable into copy_nofault.
> Moved to strscpy vs custom copy when getting array size from type.
> Made patch bisect friendly by ensuring tests are split from kernel code.
> 
> V9:
> Rebase to linux-trace ftrace/core branch.
> Added comments for user_reg and other structs in user_events.h.
> Moved from delayed seq_file to pre-created seq_file for status file.
> Added deleting events to documentation and expanded registering section.
> Reordered patches to make reviewing easier.
> Fixed nitpicks.
> 
> V10:
> Fix struct size case not writing size out to dynamic_events.
> Fix warning for NULL pointer arithmetic in user_seq_start.
> 
> Beau Belgrave (12):
>   user_events: Add minimal support for trace_event into ftrace
>   user_events: Add print_fmt generation support for basic types
>   user_events: Handle matching arguments from dyn_events
>   user_events: Add basic perf and eBPF support
>   user_events: Optimize writing events by only copying data once
>   user_events: Validate user payloads for size and null termination
>   user_events: Add self-test for ftrace integration
>   user_events: Add self-test for dynamic_events integration
>   user_events: Add self-test for perf_event integration
>   user_events: Add self-test for validator boundaries
>   user_events: Add sample code for typical usage
>   user_events: Add documentation file
> 
>  Documentation/trace/index.rst                 |    1 +
>  Documentation/trace/user_events.rst           |  216 +++
>  include/uapi/linux/user_events.h              |  116 ++
>  kernel/trace/Kconfig                          |   14 +
>  kernel/trace/Makefile                         |    1 +
>  kernel/trace/trace_events_user.c              | 1617 +++++++++++++++++
>  samples/user_events/Makefile                  |    5 +
>  samples/user_events/example.c                 |   91 +
>  tools/testing/selftests/user_events/Makefile  |    9 +
>  .../testing/selftests/user_events/dyn_test.c  |  130 ++
>  .../selftests/user_events/ftrace_test.c       |  452 +++++
>  .../testing/selftests/user_events/perf_test.c |  168 ++
>  tools/testing/selftests/user_events/settings  |    1 +
>  13 files changed, 2821 insertions(+)
>  create mode 100644 Documentation/trace/user_events.rst
>  create mode 100644 include/uapi/linux/user_events.h
>  create mode 100644 kernel/trace/trace_events_user.c
>  create mode 100644 samples/user_events/Makefile
>  create mode 100644 samples/user_events/example.c
>  create mode 100644 tools/testing/selftests/user_events/Makefile
>  create mode 100644 tools/testing/selftests/user_events/dyn_test.c
>  create mode 100644 tools/testing/selftests/user_events/ftrace_test.c
>  create mode 100644 tools/testing/selftests/user_events/perf_test.c
>  create mode 100644 tools/testing/selftests/user_events/settings
> 
> 
> base-commit: 85c62c8c3749eec02ba81217bdcac26867dc262e
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
