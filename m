Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412615A746B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiHaDY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiHaDYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:24:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A48DA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:24:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f24so10218833plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc;
        bh=kqwl44xXslk8mD4DJbfbDJIMb0fXoT8+FG8NxGiGLek=;
        b=VttqN4Dv/XpbYwDeiIEuhkKb4giGyoop4TZPUQ8jl5PN4HGb81TudvpjvLR1w8Oxjr
         Tq/Kz/CNf1Y0Y10p6QHUbY+kUV3+CwNQ2aF7BHlBThkO5n778gecnO4skc3smi+Ivref
         0vn1TAwn1SIJ2H07vT8qBXNRUZXribloDh7xnrv9BPaUwyHk5K6ysvgM97E7AVHISdBj
         /A17q2ayEPxz2eD+epuGkUlSwdoVqEk013suJ152e/+nx/nqZKLa1ydlJIphwI0rn9Zu
         zUrZDtkrZzjA8a+ES0ZsmjwakUUgNsgJ3k9ze3/69KWFZLSYVdqfea+UKlNW61ReXUyy
         2MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc;
        bh=kqwl44xXslk8mD4DJbfbDJIMb0fXoT8+FG8NxGiGLek=;
        b=3y8WOGU0UfJSB/U8B4usAeAfZb4w9fEiyeFKw9UvBQjwFkr/r5E3HebBBtcDBnKa4y
         AfiCGvNK+wASSf3jdxioHp6qC/1iXo1y9VbBXIXBRxqYVp9Eu75N7vR1OZigaI84JbDh
         L3gdv349Rp+vDkK+5PQZ4A8unYPPUwmKmOfyGMatdQQWo4BW8hE8fWYv16TuRM63y/XU
         +myZk8C60d+25be+Cg52trF3QL9PL2wbkfKiFRBhtBjwmQQB2jN8a21OSNIjzSYdak87
         blQFIOFqXg6m+TZPKTZbGeABZX4ObkAAaHzqHWdjIZAeqqhbDUx45Dnp56ItPDh7ssng
         1uIg==
X-Gm-Message-State: ACgBeo1BbglfB94YHUB6xo5gNCx2fDLPdAgwUWmzdhKRtFaxNrPrCiN1
        VOmF+VZGTlyD1OTdPgrcKhg=
X-Google-Smtp-Source: AA6agR79FpJV09h+m0gsjjb1ok5GYy+zXsOSQDBQEuZJfswpToHFyHlCTjaLH8hHUo8Le+T2H764bg==
X-Received: by 2002:a17:903:244d:b0:175:3ead:4586 with SMTP id l13-20020a170903244d00b001753ead4586mr2289352pls.28.1661916253232;
        Tue, 30 Aug 2022 20:24:13 -0700 (PDT)
Received: from localhost (110-175-65-113.tpgi.com.au. [110.175.65.113])
        by smtp.gmail.com with ESMTPSA id k88-20020a17090a3ee100b001fd86f8dc03sm316052pjc.8.2022.08.30.20.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 20:24:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 31 Aug 2022 13:24:05 +1000
Message-Id: <CMJW5375AS4G.3VZ0XK6D3OZ9O@bobo>
Cc:     <jpoimboe@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <aik@ozlabs.ru>,
        <mpe@ellerman.id.au>, <mingo@redhat.com>,
        <christophe.leroy@csgroup.eu>, <rostedt@goodmis.org>,
        <mbenes@suse.cz>, <chenzhongjin@huawei.com>,
        <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 02/16] powerpc: override __ALIGN() and __ALIGN_STR()
 macros
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Sathvika Vasireddy" <sv@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.11.0
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-3-sv@linux.ibm.com>
In-Reply-To: <20220829055223.24767-3-sv@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 29, 2022 at 3:52 PM AEST, Sathvika Vasireddy wrote:
> Powerpc instructions must be word-aligned. Currently,
> there is an alignment of 16 bytes (by default), and it is
> much more than what is required for powerpc (4 bytes).
>
> The default expansion of __ALIGN() macro is:
> #define __ALIGN       .align 4,0x90
>
> Since Powerpc Linux does not require a 16 byte alignment,
> override __ALIGN() and __ALIGN_STR() macros to use required
> 4 byte alignment.

Alignment can be desirable beyond the minimum requirement, for
example 16 byte alignment for functions could be helpful for
instruction fetch. So it should be explained why possible
benefits of the larger alignment are not worth it.

And if you have the patch in a series, it should be explained
why the patch is required for the series if it is not obvious.

Thanks,
Nick

>
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/linkage.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/as=
m/linkage.h
> index b71b9582e754..8df88fe61438 100644
> --- a/arch/powerpc/include/asm/linkage.h
> +++ b/arch/powerpc/include/asm/linkage.h
> @@ -2,8 +2,12 @@
>  #ifndef _ASM_POWERPC_LINKAGE_H
>  #define _ASM_POWERPC_LINKAGE_H
> =20
> +#include <linux/stringify.h>
>  #include <asm/types.h>
> =20
> +#define __ALIGN			.align 2
> +#define __ALIGN_STR		__stringify(__ALIGN)
> +
>  #ifdef CONFIG_PPC64_ELF_ABI_V1
>  #define cond_syscall(x) \
>  	asm ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
> --=20
> 2.31.1

