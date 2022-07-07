Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C00756A135
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiGGLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiGGLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:43:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E834F65D;
        Thu,  7 Jul 2022 04:43:56 -0700 (PDT)
Date:   Thu, 07 Jul 2022 11:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657194234;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzccpZTqKPrOwaQ4wOzwzjUA7yHS+ujzGxsstE08CyM=;
        b=wilJws5SpHCX1PjfyGd3a9suEVFLqUfBoZ5P27wqXNirlLqTTo37KSGPnZMjB9jrC8zzDy
        c2sD+7Z0GSC90exkAzilzm+H7oBnyPg3f7bC2by5Gx2ornFNhXXr6LXfmi4PmPFPqGBxc2
        HsLLMiSoHPqGqlGp56Ca3nNuZqHfn2hyfAfKHe28aqCOEnOvbFwpD4JrTKSrkjxRgFGfzo
        4KskEHuPE/ZYGnRzi877AP5Y5iOjgU9auajnYcRW0iq6PmXHAII5b9xt7P0yPSJpw3S2/J
        eo1awLLTVDhkMQJKOpnXdN0nWpbRcNPwseUkCtwEsm2DjmI9NCor7MriJe3PaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657194234;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzccpZTqKPrOwaQ4wOzwzjUA7yHS+ujzGxsstE08CyM=;
        b=MKyrpWArM5Y5jLoiomBPHdrsR6maRMpTWIN8iHKrIAFtv6RLg5qmaxNRrx7H8GPOExPG/8
        3HAw5+NpXK4u2cCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ibt, objtool: Don't discard text references
 from tracepoint section
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yrrepdaow4F5kqG0@hirez.programming.kicks-ass.net>
References: <Yrrepdaow4F5kqG0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165719423266.15455.16444447983189826756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     38e0e4d04d4187c63d6b511396faae7db6a3cd9e
Gitweb:        https://git.kernel.org/tip/38e0e4d04d4187c63d6b511396faae7db6a3cd9e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 28 Jun 2022 12:57:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Jul 2022 13:26:54 +02:00

x86/ibt, objtool: Don't discard text references from tracepoint section

On Tue, Jun 28, 2022 at 04:28:58PM +0800, Pengfei Xu wrote:

> # ./ftracetest
> === Ftrace unit tests ===
> [1] Basic trace file check      [PASS]
> [2] Basic test for tracers      [PASS]
> [3] Basic trace clock test      [PASS]
> [4] Basic event tracing check   [PASS]
> [5] Change the ringbuffer size  [PASS]
> [6] Snapshot and tracing setting        [PASS]
> [7] trace_pipe and trace_marker [PASS]
> [8] Test ftrace direct functions against tracers        [UNRESOLVED]
> [9] Test ftrace direct functions against kprobes        [UNRESOLVED]
> [10] Generic dynamic event - add/remove eprobe events   [FAIL]
> [11] Generic dynamic event - add/remove kprobe events
>
> It 100% reproduced in step 11 and then missing ENDBR BUG generated:
> "
> [ 9332.752836] mmiotrace: enabled CPU7.
> [ 9332.788612] mmiotrace: disabled.
> [ 9337.103426] traps: Missing ENDBR: syscall_regfunc+0x0/0xb0

It turns out that while syscall_regfunc() does have an ENDBR when
generated, it gets sealed by objtool's .ibt_endbr_seal list.

Since the only text references to this function:

  $ git grep syscall_regfunc
  include/linux/tracepoint.h:extern int syscall_regfunc(void);
  include/trace/events/syscalls.h:        syscall_regfunc, syscall_unregfunc
  include/trace/events/syscalls.h:        syscall_regfunc, syscall_unregfunc
  kernel/tracepoint.c:int syscall_regfunc(void)

appear in the __tracepoint section which is excluded by objtool.

Fixes: 3c6f9f77e618 ("objtool: Rework ibt and extricate from stack validation")
Reported-by: Pengfei Xu <pengfei.xu@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yrrepdaow4F5kqG0@hirez.programming.kicks-ass.net
---
 tools/objtool/check.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 864bb9d..57153e0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3826,8 +3826,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc")			||
-		    !strcmp(sec->name, "__tracepoints"))
+		    !strcmp(sec->name, "__mcount_loc"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
