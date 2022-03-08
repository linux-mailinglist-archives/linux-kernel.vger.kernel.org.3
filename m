Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05154D1C64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbiCHP4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348026AbiCHP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730464F9C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VGIbQ0XMMqyoIBLBPEc8/JzXGxiEWQOMoo30NjTyUvw=; b=D2+a4Q4cH10TSGttguNdeMJkmq
        dpsR5Cb1BDyPZZx2ETcTn4l0Ay36ub1iucvp6H3Ke4tsJHiTLjMhg9UaCu9IbU+TZlFm2OAIt2Kxl
        38zu3Khsd4dQf1l8LeS7bX45/eLGgrYwRzf3T64DnXvndOmUOWSqe5ULh6m5RTeHPhw+vEoqdP3jX
        MKLJ/3pZJX1QlJYSMklYB7CeJNzLetM/YxZaEFQRrCD/VpoWalH9OIjRppbslQ1WOvno7r9TFk5Tr
        jxXt7FPtTM94RzCRioB+CQVrl2bkJgcVCjxzqD8Q+4mrGsmiEkyoCR7Pdbuq7q5vSUVyAjUxNfLv8
        VAI1JwJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAd-00GIvM-A3; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F7C9302DD6;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CBEB52B5649D2; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.351270711@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 37/45] exit: Mark do_group_exit() __noreturn
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: get_signal()+0x108: unreachable instruction

0000 000000000007f930 <get_signal>:
...
0103    7fa33:  e8 00 00 00 00          call   7fa38 <get_signal+0x108> 7fa34: R_X86_64_PLT32   do_group_exit-0x4
0108    7fa38:  41 8b 45 74             mov    0x74(%r13),%eax

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/task.h |    2 +-
 kernel/exit.c              |    2 +-
 tools/objtool/check.c      |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -79,7 +79,7 @@ static inline void exit_thread(struct ta
 {
 }
 #endif
-extern void do_group_exit(int);
+extern __noreturn void do_group_exit(int);
 
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -907,7 +907,7 @@ SYSCALL_DEFINE1(exit, int, error_code)
  * Take down every thread in the group.  This is called by fatal signals
  * as well as by sys_exit_group (below).
  */
-void
+void __noreturn
 do_group_exit(int exit_code)
 {
 	struct signal_struct *sig = current->signal;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -181,6 +181,7 @@ static bool __dead_end_function(struct o
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
 		"cpu_bringup_and_idle",
+		"do_group_exit",
 		"stop_this_cpu",
 	};
 


