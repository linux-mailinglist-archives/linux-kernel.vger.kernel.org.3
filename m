Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0491E5A46FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiH2KSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiH2KS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:18:28 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF111A381
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1661768301; bh=AQf7Y+PACVxGUB/6c+6RJXN0ovHaKQP7Aja2+E93maQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rYBy0iX0j3WmFCEfOLyq9Gt2P5I4WTeaLvV8/RB1T39azBceVCdD6tb9XsR0yAGl/
         UsDRM1VB8YoTo9pJRkb8HVwkn5wjf7qQ6/P/nJWnhaeQW0lflDk0HQUu7j7mKnjW1j
         yRHUho4nYZtJR5K1xiyzMt1VSgX9ap+B2i31M3v8=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 30D8C600D9;
        Mon, 29 Aug 2022 18:18:21 +0800 (CST)
Message-ID: <9c13e812-7e43-52f7-dd6e-306946dc0d42@xen0n.name>
Date:   Mon, 29 Aug 2022 18:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:106.0)
 Gecko/20100101 Thunderbird/106.0a1
Subject: Re: [PATCH] LoongArch: Fix warning: #warning syscall fstat not
 implemented
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1661766931-7277-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <1661766931-7277-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 17:55, Tiezhu Yang wrote:
> Define __ARCH_WANT_NEW_STAT to fix the following build warning:
> 
>    CALL    scripts/checksyscalls.sh
> <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/include/uapi/asm/unistd.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> index fcb6689..b344b1f 100644
> --- a/arch/loongarch/include/uapi/asm/unistd.h
> +++ b/arch/loongarch/include/uapi/asm/unistd.h
> @@ -1,4 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#define __ARCH_WANT_NEW_STAT
>   #define __ARCH_WANT_SYS_CLONE
>   #define __ARCH_WANT_SYS_CLONE3
>   
No. We explicitly removed support for fstat/newfstatat in favor of 
statx, so the correct way forward is to amend the checksyscalls.sh, to 
make it aware of the fact that loongarch is the latest shiny addition so 
it doesn't carry any of the "legacy" around.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

