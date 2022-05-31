Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12553975C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbiEaTtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiEaTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B93B2B8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F1DB61265
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0EC385A9;
        Tue, 31 May 2022 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654026536;
        bh=XuBOBa58dsKmshY9gO3+HghfNDzjaNi7Dw7jP7fbIYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2fUCmbDvMPx/fopsPyhGHj4LvZOpbcHrUuVvFUGF79SwaEJ7hr8FiW2h/Vbp3c8t
         yT9R0glPYQOBsaphQiz8ZNGl+HdzzuZuiVZugSkls2SsmdHtfSjoGQ1tQal45GPMh8
         QbSBBkA+s7DRZJ+hy8pmx9U6GcgQN4bAkP9UpRybb8PvwCINFXOt2BfmJtuTWSv1IE
         uzZgbW29Hpl2+MAPDvYIugDNHeAGoITIA91p5zEPdkpWLTa/p6uqk93MgSON8stbkv
         tbHR4bIKx4n0BgJRzDoTqeuG/4fXE6sfJHAEJjYtfV0LyN/3XnoBY6N1XRdS9GrdTN
         CVqU57JwKG2Fw==
Date:   Tue, 31 May 2022 12:48:49 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: vmlinux.o: warning: objtool: __fentry__+0x16: return with
 modified stack frame
Message-ID: <20220531194849.klpqt4fzpgql737d@treble>
References: <202205310609.Rw55oP08-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202205310609.Rw55oP08-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 06:30:07AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e11a93567d3f1e843300ed98ff049a4335db8015
> commit: 72064474964724c59ddff58a581a31b1ede75cf9 objtool: Make stack validation frame-pointer-specific
> date:   6 weeks ago
> config: x86_64-buildonly-randconfig-r006-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310609.Rw55oP08-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72064474964724c59ddff58a581a31b1ede75cf9
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 72064474964724c59ddff58a581a31b1ede75cf9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame
> >> vmlinux.o: warning: objtool: __fentry__+0x16: return with modified stack frame

Here's a fix for this warning.  Will post a proper patch tomorrow-ish.

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 03364dc40d8d..4c8b6ae802ac 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -36,10 +36,6 @@ KCSAN_SANITIZE := n
 
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 
-ifdef CONFIG_FRAME_POINTER
-OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
-endif
-
 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,
 # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 4ec13608d3c6..db7c396064ef 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -175,6 +175,7 @@ SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
+STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
 SYM_FUNC_START(ftrace_epilogue)
 /*
@@ -282,6 +283,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	jmp	ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)
+STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
@@ -311,6 +313,8 @@ trace:
 	jmp ftrace_stub
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
+STACK_FRAME_NON_STANDARD_FP(__fentry__)
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 6491fa8fba6d..15b940ec1eac 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -143,6 +143,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD_FP func:req
+#ifdef CONFIG_FRAME_POINTER
+	STACK_FRAME_NON_STANDARD \func
+#endif
+.endm
+
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 6491fa8fba6d..15b940ec1eac 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -143,6 +143,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD_FP func:req
+#ifdef CONFIG_FRAME_POINTER
+	STACK_FRAME_NON_STANDARD \func
+#endif
+.endm
+
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr

