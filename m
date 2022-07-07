Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3958456AE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiGGV6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiGGV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D89741D320;
        Thu,  7 Jul 2022 14:58:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 04A22201326C;
        Thu,  7 Jul 2022 14:58:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04A22201326C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657231112;
        bh=OA1r1wCh9LBEPcO9vdB7ZVEhQrFIKdlbqarqppMQbzk=;
        h=From:To:Cc:Subject:Date:From;
        b=BitkmtCAKi86lg357F7A2p12fa0gACdn/o0PXjuA2zqNE6g48Al+qvZysfR4N8jQE
         V8rUX60QVjZzFW/ZQgGTWr9SYsmPl+gkkU4EDA1NuFpJEpbtT0WO0ryJukWnS5w8Y1
         Dt1nKyTy6vHsqqVe1JT0PS1gt+qPUQl0GKfbplZw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] tracing: Add tracing namespace API for user
Date:   Thu,  7 Jul 2022 14:58:21 -0700
Message-Id: <20220707215828.2021-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on the ftrace/core branch.

You will need the following series to apply this series:
Link: https://lore.kernel.org/all/20220425184631.2068-1-beaub@linux.microsoft.com/

User facing tracing systems, such as user_events and LTTng, sometimes
require multiple events with the same name, but from different
containers. This can cause event name conflicts and leak out details
of events not owned by the container.

To create a tracing namespace, run mkdir under the new tracefs directory
named "namespaces" (/sys/kernel/tracing/namespaces typically). This
directory largely works the same as "instances" where the new directory
will have files populated within it via the tracing system
automatically. The tracing systems will put their files under the "root"
directory, which is meant to be the directory that you can bind mount
out to containers. The "options" file is meant to allow operators to
configure the namespaces via the registered systems.

The tracing namespace allows those user facing systems to register with
the tracing namespace. When an operator creates a namespace directory
under /sys/kernel/tracing/namespaces the registered systems will have
their create operation run for that namespace. The systems can then
create files in the new directory used for tracing via user programs. These
files will then isolate events between each namespace the operator
creates.

Typically the system name of the event will have the tracing namespace
name appended onto the system name. For example, if a namespace
directory was created named "mygroup", then the system name would be
"<system_name>.mygroup". Since the system names are different for each
namespace, per-namespace recording/playback can be done by specifying
the per-namespace system name and the event name. However, this decision is
up to the registered tracing system for each namespace.

The operator can then bind mount each namespace directory into
containers. This provides isolation between events and containers, if
required. It's also possible for several containers to share an
isolation via bind mounts instead of having an isolation per-container.
With these files being isolated, different permissions can be added for
these files than normal tracefs files. This helps scenarios where
non-admin processes would like to trace, but currently cannot.

To create a namespace called isolated and limited to 256 events run:
mkdir /sys/kernel/tracing/namespaces/isolated
cd /sys/kernel/tracing/namespaces/isolated
echo user_events_limit=256 > options

To bind mount the isolated root to /isolated for use by others run:
mkdir /isolated
mount --bind /sys/kernel/tracing/namespaces/isolated/root /isolated

Reading /isolated/user_events_status then outputs the following:

Active: 0
Busy: 0
Max: 32768
Limit: 256

The normal user_event ABI methods work just as before, however, the
events are now registered under a different system name and have
their own status file/bitmap.

There's been some previous discussion about this both in the tracefs
meetings as well as on the mailing lists:
Link: https://lore.kernel.org/all/20220312010140.1880-1-beaub@linux.microsoft.com/
Link: https://lore.kernel.org/all/20220425184631.2068-1-beaub@linux.microsoft.com/

Beau Belgrave (7):
  tracing/user_events: Remove BROKEN and restore user_events.h location
  tracing: Add namespace instance directory to tracefs
  tracing: Add tracing namespace API for systems to register with
  tracing/user_events: Move pages/locks into groups to prepare for
    namespaces
  tracing/user_events: Register with trace namespace API
  tracing/user_events: Enable setting event limit within namespace
  tracing/user_events: Add self-test for namespace integration

 fs/tracefs/inode.c                            | 121 +++-
 include/linux/tracefs.h                       |   5 +
 include/{ => uapi}/linux/user_events.h        |   0
 kernel/trace/Kconfig                          |  12 +-
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |  39 ++
 kernel/trace/trace_events_user.c              | 589 +++++++++++++++---
 kernel/trace/trace_namespace.c                | 567 +++++++++++++++++
 kernel/trace/trace_namespace.h                |  57 ++
 .../selftests/user_events/ftrace_test.c       | 150 +++++
 10 files changed, 1454 insertions(+), 87 deletions(-)
 rename include/{ => uapi}/linux/user_events.h (100%)
 create mode 100644 kernel/trace/trace_namespace.c
 create mode 100644 kernel/trace/trace_namespace.h


base-commit: b39181f7c6907dc66ff937b74758671fa6ba430c
prerequisite-patch-id: 1872158d6a015caa0cedefe85d10a9e48b1d33e9
prerequisite-patch-id: bb3e38a639be23a2df781547e4c87bc5bb1a05d0
prerequisite-patch-id: e7c8f170457cbb6d467ddec6f9282e2cdd81bb32
prerequisite-patch-id: ffbe40150b26469168a3f4abe97849d8708785d5
prerequisite-patch-id: a5c2a495793f9db8103c13a4f1e5380ea0f78902
prerequisite-patch-id: 3a0fbeaf8508f995f3cb271c9e603b666a69d5fa
prerequisite-patch-id: 5df583c86e6de3fc504b478e52e91068c85fa2b9
-- 
2.25.1

