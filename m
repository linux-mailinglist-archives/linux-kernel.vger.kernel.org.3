Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA954C272C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiBXJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiBXI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:59:50 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C015C9E7;
        Thu, 24 Feb 2022 00:59:20 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id g15so552481ual.11;
        Thu, 24 Feb 2022 00:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glczv0l5uaIHGX0k1sHQaF0Req6u5NGSTbrWdrmUApU=;
        b=Lu/QJFhL23DemLIEQ/v/O1fo8XJXSAmnLmY95UtSCKNxhuB44dxmLJhfK4xZ9haL68
         1cm1cdXYv4cldUw9TPtoTnxi9OTXDUxhmpfNT6F7r5eXNouvez18n00j5YW0xn0718md
         c59h0GBV7KY4s82gwCp/BiH921CbiOdtUkxAzfZd12j/zGx6EoMMYEeTXRW/JaDsOEEX
         08UI2857XMbuJU4eeRAi1J+JQ3lzlGuz5Cq9tzqYmtis8XyochijwAQEs9gdDeJwsR0U
         U8vp/UAV5Fo+AG0/4saZOouYWl2rO9cQH45swjSMWp27RpbS963E5ulxvcn5KLcPt72Q
         0RHQ==
X-Gm-Message-State: AOAM530WMdS+j7g0sFhzLKvPSkXroUWr2iLV6Xw+UoyITTqWIIkM4/Y1
        5Fnqly6SCige/8C/w50pjFbkr09fw32HAA==
X-Google-Smtp-Source: ABdhPJxVMubJNxj6kJFiHtVKwD7Jmy8N7cYjfmfOTg5bG+PlljwGRb4jmORG4KTcT9a8PRSvrfZJ1w==
X-Received: by 2002:ab0:6897:0:b0:341:f244:f174 with SMTP id t23-20020ab06897000000b00341f244f174mr688142uar.130.1645693159594;
        Thu, 24 Feb 2022 00:59:19 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id y5sm289436vsj.11.2022.02.24.00.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:59:19 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id j3so1382996vsi.7;
        Thu, 24 Feb 2022 00:59:19 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr696559vsb.5.1645693159137; Thu, 24 Feb
 2022 00:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20220224060448.1856091-1-keescook@chromium.org>
In-Reply-To: <20220224060448.1856091-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 09:59:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
Message-ID: <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Implement "current_stack_pointer"
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Thu, Feb 24, 2022 at 7:04 AM Kees Cook <keescook@chromium.org> wrote:
> To follow the existing per-arch conventions, add asm "sp" as
> "current_stack_pointer". This will let it be used in non-arch places
> (like HARDENED_USERCOPY).
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/arch/m68k/include/asm/current.h
> +++ b/arch/m68k/include/asm/current.h
> @@ -24,6 +24,8 @@ static inline struct task_struct *get_current(void)
>
>  #define        current get_current()
>
> +register unsigned long current_stack_pointer __asm__("sp");

I don't know what HARDENED_USERCOPY does, so I don't know if you need
"usp" (see rdusp()) or "sp"?

> +
>  #endif /* CONFNIG_MMU */
>
>  #endif /* !(_M68K_CURRENT_H) */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
