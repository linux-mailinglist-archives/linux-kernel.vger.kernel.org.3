Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1E506B77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351924AbiDSLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348881AbiDSLyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:54:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE135A8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=by/avHz0lmt+0CrvyNMfd3ZJgBpesJrRIzEYCC0+J9I=; b=EH26emG8dozfwgbLDRHaT6hR0a
        T5GBynsNsO4tqZPmoBNSfhF8bWZSGePL4fCQcue5FCIl0KRud3yH/NQGLU6WNJMU9Eztb/6kyxqLw
        VNQhjmseNibEiCY0wtukgVtCAwkdqrsJMFBIs+hl6pTqcbj1CLdEACIOYHRs/CVsAfs9Z6sk1ufvN
        DRcgp25XHwok8rSIZNJH14q7yaNsII4KTODZMvSAEt1w645mE+XNsrXNDUASaYPx6hbAckSeox4/O
        P2U1+3sYqmLXx9kjuBzFvXgOiTueEMDxpCDHPEN7H3STTMtoeGc+iqE6SvM2JS8FOFhvsfVyQqkII
        NnpgE7mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngmOI-0033rG-T3; Tue, 19 Apr 2022 11:51:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32919986195; Tue, 19 Apr 2022 13:51:30 +0200 (CEST)
Date:   Tue, 19 Apr 2022 13:51:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 00/25] objtool: Interface overhaul
Message-ID: <20220419115130.GT2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:50:19AM -0700, Josh Poimboeuf wrote:

> Josh Poimboeuf (25):
>   objtool: Enable unreachable warnings for CLANG LTO
>   libsubcmd: Fix OPTION_GROUP sorting
>   x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
>   x86/retpoline: Add ANNOTATE_ENDBR for retpolines
>   x86/uaccess: Add ENDBR to __put_user_nocheck*()
>   x86/xen: Add ANNOTATE_ENDBR to startup_xen()
>   objtool: Reorganize cmdline options
>   objtool: Ditch subcommands
>   objtool: Don't print parentheses in function addresses
>   objtool: Print data address for "!ENDBR" data warnings
>   objtool: Use offstr() to print address of missing ENDBR
>   objtool: Add option to print section addresses
>   scripts: Create objdump-func helper script
>   objtool: Make stack validation optional
>   objtool: Rework ibt and extricate from stack validation
>   objtool: Extricate sls from stack validation
>   objtool: Add CONFIG_OBJTOOL
>   objtool: Make stack validation frame-pointer-specific
>   objtool: Make static call annotation optional
>   objtool: Make jump label hack optional
>   objtool: Make noinstr hacks optional
>   objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
>   objtool: Add HAVE_NOINSTR_VALIDATION
>   objtool: Remove --lto and --vmlinux in favor of --link
>   objtool: Update documentation

I've taken the liberty of reordering it slightly:

   objtool: Enable unreachable warnings for CLANG LTO
   x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
   x86/retpoline: Add ANNOTATE_ENDBR for retpolines
   x86/uaccess: Add ENDBR to __put_user_nocheck*()
   x86/xen: Add ANNOTATE_ENDBR to startup_xen()
   objtool: Print data address for "!ENDBR" data warnings
   objtool: Use offstr() to print address of missing ENDBR

Go into x86/urgent, and I've added Fixes: tags with various patches from
the IBT series, and then the rest goes into objtool/core.

As already indicated, there's going to be a few merge conflicts against
x86/core, but alas. Resolved as per the below.

---
diff --cc arch/x86/Kconfig
index 20c1dacd2baa,c8f560802bf2..000000000000
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
diff --cc scripts/Makefile.build
index 7e7aa1d030a6,ac8167227bc0..000000000000
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@@ -227,15 -227,19 +227,19 @@@ ifdef CONFIG_OBJTOO
  objtool := $(objtree)/tools/objtool/objtool
  
  objtool_args =								\
- 	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
- 	$(if $(part-of-module), --module)				\
- 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
- 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
- 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
+ 	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
+ 	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
+ 	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
+ 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+ 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
+ 	$(if $(CONFIG_SLS), --sls)					\
+ 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
+ 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
 -	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 +	--uaccess							\
- 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
- 	$(if $(CONFIG_SLS), --sls)
+ 	$(if $(linked-object), --link)					\
+ 	$(if $(part-of-module), --module)				\
+ 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
  
  cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
  cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
diff --cc scripts/link-vmlinux.sh
index 3a2fffdf49d4,eb9324f07f3d..000000000000
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@@ -126,34 -132,46 +132,44 @@@ objtool_link(
  		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
  			objtoolopt="${objtoolopt} --mcount"
  		fi
- 	fi
  
- 	if is_enabled CONFIG_VMLINUX_VALIDATION; then
- 		objtoolopt="${objtoolopt} --noinstr"
- 	fi
+ 		if is_enabled CONFIG_UNWINDER_ORC; then
+ 			objtoolopt="${objtoolopt} --orc"
+ 		fi
  
- 	if [ -n "${objtoolopt}" ]; then
- 		if [ -z "${objtoolcmd}" ]; then
- 			objtoolcmd="check"
+ 		if is_enabled CONFIG_RETPOLINE; then
+ 			objtoolopt="${objtoolopt} --retpoline"
  		fi
- 		objtoolopt="${objtoolopt} --vmlinux"
- 		if ! is_enabled CONFIG_FRAME_POINTER; then
- 			objtoolopt="${objtoolopt} --no-fp"
+ 
+ 		if is_enabled CONFIG_SLS; then
+ 			objtoolopt="${objtoolopt} --sls"
  		fi
- 		if is_enabled CONFIG_GCOV_KERNEL || is_enabled CONFIG_LTO_CLANG; then
- 			objtoolopt="${objtoolopt} --no-unreachable"
+ 
+ 		if is_enabled CONFIG_STACK_VALIDATION; then
+ 			objtoolopt="${objtoolopt} --stackval"
  		fi
- 		if is_enabled CONFIG_RETPOLINE; then
- 			objtoolopt="${objtoolopt} --retpoline"
+ 
+ 		if is_enabled CONFIG_HAVE_STATIC_CALL_INLINE; then
+ 			objtoolopt="${objtoolopt} --static-call"
  		fi
  
 -		if is_enabled CONFIG_X86_SMAP; then
 -			objtoolopt="${objtoolopt} --uaccess"
 -		fi
 +		objtoolopt="${objtoolopt} --uaccess"
+ 	fi
  
- 		if is_enabled CONFIG_SLS; then
- 			objtoolopt="${objtoolopt} --sls"
+ 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
+ 		objtoolopt="${objtoolopt} --noinstr"
+ 	fi
+ 
+ 	if [ -n "${objtoolopt}" ]; then
+ 
+ 		if is_enabled CONFIG_GCOV_KERNEL; then
+ 			objtoolopt="${objtoolopt} --no-unreachable"
  		fi
+ 
+ 		objtoolopt="${objtoolopt} --link"
+ 
  		info OBJTOOL ${1}
- 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
+ 		tools/objtool/objtool ${objtoolopt} ${1}
  	fi
  }
  
