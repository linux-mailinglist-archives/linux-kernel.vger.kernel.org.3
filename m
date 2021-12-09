Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01F146EB53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhLIPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbhLIPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:36:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB04C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:32:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 283F5CE2689
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF181C004DD;
        Thu,  9 Dec 2021 15:32:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mvLPD-000SvT-2F;
        Thu, 09 Dec 2021 10:32:23 -0500
Message-ID: <20211209152908.459494269@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Dec 2021 10:29:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [for-linus][PATCH 0/5] tracing: Updates for 5.16-rc5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace and tracefs fixes:

 - Have tracefs honor the gid mount option

 - Have new files in tracefs inherit the parent ownership

 - Have direct_ops unregister when it has no more functions

 - Properly clean up the ops when unregistering multi direct ops

 - Add a sample module to test the multiple direct ops

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/urgent

Head SHA1: 72a86f97053fc70c8cfa6bdef3154bda8a811041


Jiri Olsa (3):
      ftrace: Use direct_ops hash in unregister_ftrace_direct
      ftrace: Add cleanup to unregister_ftrace_direct_multi
      ftrace/samples: Add module to test multi direct modify interface

Steven Rostedt (VMware) (2):
      tracefs: Have new files inherit the ownership of their parent
      tracefs: Set all files to the same group ownership as the mount option

----
 fs/tracefs/inode.c                          |  76 ++++++++++++++
 kernel/trace/ftrace.c                       |   8 +-
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 152 ++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c
