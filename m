Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F24BB331
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiBRH2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:28:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiBRH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:28:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E5130830
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 23:28:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id F3BC81F464F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645169280;
        bh=KYLq7eNzr+XRZuirnWBJLVeUqZ6BEc4ttbFcZk8iUGk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U6IzTeuS1C+9np66UfM0lKpZF0ZKxDj3xYfdA5C4d9HrIROIyV/RyA2jMUd2BNOz3
         sGl2U7h0GuVIpNXqneRPSmoSK+E0lHgdD+mi3foUCPxf73o9EVHvFIn1QiUxe8MgPT
         L8SU7BZy9V5lD9EmjJd9qtP1dTFOskQgGX07ipGgvN3DW9W5F/NOGO8CPlMk+ibsaR
         NlXwtCJQRxpBtzNatU97rvLq8HfGcKA36bCUc/jxLWpPZJqUPNKXgmrzcR05o3JuJR
         ujv7dXmfGgx/ly3f+Oh7FZwWA9dZoBv5tAkxQcctMyqjtBwPB/+MZuJsNvk7eliUNV
         33O8pUAIYIqaA==
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.com>
Subject: Re: [PATCH] tools: fix unavoidable GCC call in Clang builds
In-Reply-To: <Yg6PousYSZXimFCS@dev-arch.archlinux-ax161>
References: <20220217033648.1453303-1-adrian.ratiu@collabora.com>
 <Yg6PousYSZXimFCS@dev-arch.archlinux-ax161>
Date:   Fri, 18 Feb 2022 09:27:57 +0200
Message-ID: <87czjk4osi.fsf@ryzen9.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022, Nathan Chancellor <nathan@kernel.org> wrote:
> Hi Adrian 
> 
> On Thu, Feb 17, 2022 at 05:36:48AM +0200, Adrian Ratiu wrote: 
>> In ChromeOS and Gentoo we catch any unwanted mixed Clang/LLVM 
>> and GCC/binutils usage via toolchain wrappers which fail 
>> builds. 
> 
> Neat for hermetic builds. 
> 

Thanks! We're doing this for the entire build and found quite some 
bugs in upstream userspace projects as well, like configure/m4 
hardcoding things like binutils ar instead of our toolchain 
configured llvm-ar.

>> This has revealed that GCC is called unconditionally in Clang 
>> configured builds to populate GCC_TOOLCHAIN_DIR.   Allow 
>> overriding the variable to avoid the GCC call - in our case we 
>> can set GCC_TOOLCHAIN_DIR directly in the ebuild recipe. 
> 
> Would you just set GCC_TOOLCHAIN_DIR to nothing to avoid 
> triggering the 'gcc -print-sysroot' call?

Yes, the intention was to set GCC_TOOLCHAIN_DIR="" in the ebuild, 
but now we have a better approach suggested by you below :)

What we do right now is add an exception for the entire kernel, to 
allow it to make mixed toolchain calls (wrappers don't fail the 
build). AFAICT this is the last bug before we can start enforcing 
"pure" LLVM builds, at least on more recent kernels.

Older kernels have been known to work as well (eg 5.4) after 
fixing some bugs which were not strictly in the kernel codebase, 
like: 

https://archives.gentoo.org/gentoo-dev/message/a4aefebf8969b2ddbbf7298c67659996
 
> 
> An alternative might be allowing CLANG_CROSS_FLAGS to be 
> supplied by the user, so that you can stil benefit from cross 
> compiling tools, but with the flags and sysroot that you expect. 
>

That seems like a better approach, thanks. It makes sense to allow 
distributions to specify locations of their userspace libraries 
since the kernel has no control over how various distros are 
configured.

According to the original commit message adding this change, in 
some cases Clang might be able to autodetect these paths, but 
autodetection does not work for all possible configurations.

If a reliable generic Clang autodetection mechanism is possible, 
then setting these vars/flags becomes a no-op and can be dropped, 
until then CLANG_CROSS_FLAGS solves our problem.
 
>> Suggested-by: Manoj Gupta <manojgupta@chromium.com> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> 
> 
> Regardless, as long as it works for your use case: 
> 
> Acked-by: Nathan Chancellor <nathan@kernel.org> 
> 
> The change that this patch fixes [1] went via bpf-next [2] last 
> cycle, you could either target that tree to have it fixed for 
> 5.18 or make a case for having it merged in the 5.17 cycle via 
> bpf [3]. I would resend this change to the kernel/bpf 
> maintainers, as Nick and I do not currently pick up patches.

If Nick is also ok with the CLANG_CROSS_FLAGS approach, I'll send 
that to bpf-next. Thanks again!

>
> [1]: https://lore.kernel.org/r/20211216163842.829836-2-jean-philippe@linaro.org/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/
>
>> ---
>>  tools/scripts/Makefile.include | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>> index 79d102304470..98c098c064dd 100644
>> --- a/tools/scripts/Makefile.include
>> +++ b/tools/scripts/Makefile.include
>> @@ -90,7 +90,7 @@ EXTRA_WARNINGS += -Wstrict-aliasing=3
>>  
>>  else ifneq ($(CROSS_COMPILE),)
>>  CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
>> -GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
>> +GCC_TOOLCHAIN_DIR ?= $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
>>  ifneq ($(GCC_TOOLCHAIN_DIR),)
>>  CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
>>  CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
>> -- 
>> 2.35.0
>> 
