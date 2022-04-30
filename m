Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608C15160A5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbiD3VeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiD3Vdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 17:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80FBE1C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 14:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F15AC6111E
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 21:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8716C385A7;
        Sat, 30 Apr 2022 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651354230;
        bh=vAVhhXypRqDZcqGhaCYEaH4e+Ngkzft0fv8RfvcJdcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeokDMgihaUGrwVXZ1/Yej5wrXuZBv9ggnZeIXmyQu1aWrgUvaL7YPgeSsdO2LAjV
         NWY/WCi8sXyvcY8FRtY6dZzUqMgwX/J/orA9FjsS9gDwl/peAmt1XmCGmm3REIYI9l
         ghTuNmTsu6k7GErshPTZxkSMiYMbwZE7JaPcdeTtq1cMA8HtSMz8JsvjbNV08uNlTr
         knUeGsAPUxRzY5nFQDCnonASHWDAnwyDQ9KX15uNHo9cUe7C8W+egFR4ztvgkpkZeY
         nzXBICbJggtQK5+zwaWizA2qMWX4l9YfwR4XoPakssKivYdA3TKzIpfGoPgZ0ZWBBK
         BAIPAD8xu212A==
Date:   Sat, 30 Apr 2022 14:30:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mauro Rossi <issor.oruam@gmail.com>
Cc:     luto@kernel.org, Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
Message-ID: <Ym2qdHAB6BMMlegB@thelio-3990X>
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

[+ llvm@lists.linux.dev and Nick]

On Fri, Apr 29, 2022 at 07:40:07PM +0200, Mauro Rossi wrote:
> Hi Andy,
> 
> I am an hobbyist contributing to android-x86 FOSS project lead by
> Chih-Huwei Huang (in Cc: for information/alignement)
> 
> I am performing periodic tests to build kernel for Android 11 based iso image
> which relies on aosp shipped prebuild clang toolchain (clang version 11.0.2)
> 
> When building linux 5.18rc4 and also with linux 5.17 x86_64 64bit kernel targets
> there is a building error in arch/x86/entry
> 
>   AS      arch/x86/entry/entry_64.o
> <instantiation>:2:2: error: unknown use of instruction mnemonic
> without a size suffix
>  lsl %rax, %rax
>  ^
> <instantiation>:1:1: note: while in macro instantiation
> LOAD_CPU_AND_NODE_SEG_LIMIT %rax
> ^
> <instantiation>:2:2: note: while in macro instantiation
>  GET_PERCPU_BASE %rax
>  ^
> /home/utente/r-x86_kernel/kernel/arch/x86/entry/entry_64.S:890:2:
> note: while in macro instantiation
>  SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
>  ^
> make[3]: *** [/home/utente/r-x86_kernel/kernel/scripts/Makefile.build:389:
> arch/x86/entry/entry_64.o] Error 1
> make[2]: *** [/home/utente/r-x86_kernel/kernel/scripts/Makefile.build:550:
> arch/x86/entry] Error 2
> make[1]: *** [/home/utente/r-x86_kernel/kernel/Makefile:1887: arch/x86] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> As other interesting info, the building error does not happen when
> building x86 32bit kernel target and i can build 86_64 64bit kernel
> target only by setting the LLVM_IAS=0 parameter to disable the
> internal llvm assembler

This error was fixed in LLVM 11.0.0 final, which was released after
Android's LLVM 11.0.2:

https://github.com/ClangBuiltLinux/linux/issues/1079

> I wanted to ask you if you could help us, if there could be a way to
> improve arch/x86/entry/entry_64.S code to be able to complete the
> build without disabling the llvm internal assembler.
> 
> I don't know if this building error may be caused by the clang version
> 11.0.2, but at some point the aosp and android version may hit this
> same issue,
> so I wanted to highlight this issue to you to have a competent person feedback,
> as I am more a "trial and error" guy than a kernel expert

I am open to other opinions but I am not inclined to suggest working
around this in the kernel for two reasons:

1. This issue was resolved in the toolchain almost two years ago, so it
   is not a recent failure.

2. Android's LLVM 11.0.2 is technically older than the minimum version
   that the kernel supports (11.0.0), which I would argue means it is
   unsupported. 11.0.0 final was released on October 12th, 2020 and
   Android's LLVM 11.0.2 was committed on June 11th, 2020, so you are
   potentially missing four months worth of fixes:

   https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/431c74471920f3f9b0517692fb69515c023bde41

   Unfortunately, due to the way that LLVM versions work, it is not so
   easy to check for this but perhaps we should consider trying to
   handle this, so that others don't continue to trip over old bugs.

Moving to LLVM_IAS=0 is the solution that we went with for clang-10 when
it was supported after the switch to the integrated assembler by
default, which I do not think is an unreasonable solution for this
issue.

Alternatively, you could apply the hack that Nick inserted into Android
for this issue if upgrading your toolchain or turning off the integrated
assembler is not possible:

https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae

I really do not mean to sound dismissive or rude, I apologize if it
comes off that way, but we have worked quite hard to avoid inserting
unnecessary workarounds, as they are ultimately technical debt that can
be hard to manage over the long term.

Cheers,
Nathan
