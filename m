Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045F5B0B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIGRVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:21:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F53A5C61
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:21:37 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MN8Dw2BCLz9skr;
        Wed,  7 Sep 2022 19:21:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DuwBRwQWXqUM; Wed,  7 Sep 2022 19:21:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MN8Dw1DWKz9skq;
        Wed,  7 Sep 2022 19:21:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C93C8B78B;
        Wed,  7 Sep 2022 19:21:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MLVDGr0fKSvO; Wed,  7 Sep 2022 19:21:35 +0200 (CEST)
Received: from [192.168.232.239] (unknown [192.168.232.239])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AAC08B763;
        Wed,  7 Sep 2022 19:21:35 +0200 (CEST)
Message-ID: <7cb1285a-42e6-2b67-664f-7d206bc9fd80@csgroup.eu>
Date:   Wed, 7 Sep 2022 19:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] powerpc/lib/xor_vmx: Relax frame size for clang
Content-Language: fr-FR
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20190621085822.1527-1-malat@debian.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20190621085822.1527-1-malat@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/06/2019 à 10:58, Mathieu Malaterre a écrit :
> When building with clang-8 the frame size limit is hit:
> 
>    ../arch/powerpc/lib/xor_vmx.c:119:6: error: stack frame size of 1200 bytes in function '__xor_altivec_5' [-Werror,-Wframe-larger-than=]
> 
> Follow the same approach as commit 9c87156cce5a ("powerpc/xmon: Relax
> frame size for clang") until a proper fix is implemented upstream in
> clang and relax requirement for clang.

With Clang 14 I get the following errors, but only with KASAN selected.

   CC      arch/powerpc/lib/xor_vmx.o
arch/powerpc/lib/xor_vmx.c:95:6: error: stack frame size (1040) exceeds 
limit (1024) in '__xor_altivec_4' [-Werror,-Wframe-larger-than]
void __xor_altivec_4(unsigned long bytes,
      ^
arch/powerpc/lib/xor_vmx.c:124:6: error: stack frame size (1312) exceeds 
limit (1024) in '__xor_altivec_5' [-Werror,-Wframe-larger-than]
void __xor_altivec_5(unsigned long bytes,
      ^


Is this patch still relevant ?

Or should frame size be relaxed when KASAN is selected ? After all the 
stack size is multiplied by 2 when we have KASAN, so maybe the warning 
limit should be increased as well ?

Thanks
Christophe

> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/563
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/lib/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index c55f9c27bf79..b3f7d64caaf0 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -58,5 +58,9 @@ obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
>   
>   obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
>   CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
> +ifdef CONFIG_CC_IS_CLANG
> +# See https://github.com/ClangBuiltLinux/linux/issues/563
> +CFLAGS_xor_vmx.o += -Wframe-larger-than=4096
> +endif
>   
>   obj-$(CONFIG_PPC64) += $(obj64-y)
