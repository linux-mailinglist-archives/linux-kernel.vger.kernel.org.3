Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B2532F18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiEXQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:38:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADAE023;
        Tue, 24 May 2022 09:38:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q4so16302460plr.11;
        Tue, 24 May 2022 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HDX84FFeFcjSflCNx/dYP2mOlMAVfBYz8NXog7/4cdA=;
        b=kCGVsnokeKe36OuduWxziv0q3V3zFewTgyZ8ZcYnQUMh2yWCS/RhP0lulH2745OHxm
         TrBc6V/3T6oYEPYvu5h636CXl8ymu9t7NmarcjASamefGZ4C2xBhz1sSRShLQIscFrol
         SdtK9pnKzB15c5ABS9qP2+hTL02S/SN0vH6P3XmGP31V9lmgMiI2ERYE/I8qxBDERClb
         Hhs5dxeS6k/FQYmSM39bCFrWO9ZZnkGqhrhloxdQazHOMAuyrDJy6UO5YV69TM5zVQoU
         BFEfJxAetRO6IJW85qZLE7PEi6cq6J0yoHLfInuG+l3jAld2BtEEjg7ifGyWhUiq0H9q
         9HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HDX84FFeFcjSflCNx/dYP2mOlMAVfBYz8NXog7/4cdA=;
        b=1/R0DOUWgjsz3lwPGr/2Z6ubpl+svHfHtycrOYxoxeZgE6gSCY9lB7OoYRzKLWLeQN
         AF8v85ilnQ1aaQqw2gnf/qPbJhGAwQAnPcWQYwSavzsG+KauDaXLIZDI7HLQZIF3Hl08
         8h/8rrzM48u2KFlO3vMNde3DmNktiTI7KH77WNquLzdk9sTcROBrrEM+CfkgeRgxs76o
         dQmUMRBsASz/XKB4JiONCMJWY5htfz245f+Z/nkDlOHsLtRsKbE/H2xcLovxwvqMTfxI
         468/9ko6Q9wpW7K0LjCAWFFZCcwU1mK+w33SAAC9EQ/4XwboQp1QSb5MimcdlS4GAiTP
         BO3g==
X-Gm-Message-State: AOAM533X+jzOqvk25zFj0H+3RdpPNAKaILJPK4iZmRHdDwnSTQo36Wxo
        s2nxxBB83STRCzFWLpmP7Gk=
X-Google-Smtp-Source: ABdhPJyHJTZK9prcTPjbOowTYJbwGiMQofwKhcs/AB/aQXuadf8eb7QK39M1QUve5l38G3Hve1FeXg==
X-Received: by 2002:a17:903:288:b0:15f:a13:dfd5 with SMTP id j8-20020a170903028800b0015f0a13dfd5mr28525273plr.55.1653410309327;
        Tue, 24 May 2022 09:38:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v6-20020a63b946000000b003c14af5063fsm6808077pgo.87.2022.05.24.09.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 09:38:28 -0700 (PDT)
Message-ID: <7682977b-5929-890a-3a18-662fbfcede5c@gmail.com>
Date:   Tue, 24 May 2022 09:38:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] MIPS: Rewrite `csum_tcpudp_nofold' in plain C
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 13:48, Maciej W. Rozycki wrote:
> Recent commit 198688edbf77 ("MIPS: Fix inline asm input/output type
> mismatch in checksum.h used with Clang") introduced a code size and
> performance regression with 64-bit code emitted for `csum_tcpudp_nofold'
> by GCC, caused by a redundant truncation operation produced due to a
> data type change made to the variable associated with the inline
> assembly's output operand.
> 
> The intent previously expressed here with operands and constraints for
> optimal code was to have the output operand share a register with one
> inputs, both of a different integer type each.  This is perfectly valid
> with the MIPS psABI where a register can hold integer data of different
> types and the assembly code used here makes data stored in the output
> register match the data type used with the output operand, however it
> has turned out impossible to express this arrangement in source code
> such as to satisfy LLVM, apparently due to the compiler's internal
> limitations.
> 
> There is nothing peculiar about the inline assembly `csum_tcpudp_nofold'
> includes however, though it does choose assembly instructions carefully.
> 
> Rewrite this piece of assembly in plain C then, using corresponding C
> language operations, making GCC produce the same assembly instructions,
> possibly shuffled, in the general case and sometimes actually fewer of
> them where an input is constant, because the compiler does not have to
> reload it to a register (operand constraints could be adjusted for that,
> but the plain C approach is cleaner anyway).
> 
> Example code size changes are as follows, for a 32-bit configuration:
> 
>        text       data        bss      total filename
>     5920480    1347236     126592    7394308 vmlinux-old
>     5920480    1347236     126592    7394308 vmlinux-now
>     5919728    1347236     126592    7393556 vmlinux-c
> 
> and for a 64-bit configuration:
> 
>        text       data        bss      total filename
>     6024112    1790828     225728    8040668 vmlinux-old
>     6024128    1790828     225728    8040684 vmlinux-now
>     6023760    1790828     225728    8040316 vmlinux-c
> 
> respectively, where "old" is with the commit referred reverted, "now" is
> with no change, and "c" is with this change applied.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Hi,
> 
>   I have visually inspected code produced and verified this change to boot
> with TCP networking performing just fine, both with a 32-bit and a 64-bit
> configuration.  Sadly with the little endianness only, because in the
> course of this verification I have discovered the core card of my Malta
> board bit the dust a few days ago, apparently in a permanent manner, and I
> have no other big-endian MIPS system available here to try.

How about QEMU is not that a viable option for testing big/little endian 
configurations?
-- 
Florian
