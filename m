Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F99557C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiFWNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiFWNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:11:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503FE30554
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:11:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e5so11020223wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JF3KFGuU5d1nPOiqYMvyN5E84aUzwajF94ekFp44h3w=;
        b=LBM2kqEtnMXJotGt8/OvyPuEtGx1Lesxgls/2wFhLs9qSftGQ766tmIXd3WtwmiAmJ
         bQrPEbNbQZlDk8k5THkJ5JiD9r+CUc/co1hveaXpvT3hW/fP8g+dZfjW8FdtvzE0cCvW
         05IVbMQGu7Y5AvjL3f5J6255yMHT5RNJ6uym2VtetnFXj+Uk1k5QidCWSDIDaU6bgHip
         c4wN1OLm7R9uBf4TL+T3pOkDJA/e1GKHRnUdG25r/1DuGPdE9PR1VmlVsiS8e+dJDPsH
         VFw1wZYF+EAvKWjfhE9/8H7Q8GyRWbUxpCPp0YLXcgGrs/epk+o7o95YiFYR7b9H2czt
         P3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JF3KFGuU5d1nPOiqYMvyN5E84aUzwajF94ekFp44h3w=;
        b=gwGDEhVVTcMM+9OWqAff457WN2DKl+ejZny1FdSCXHrI4MxORyQd7yNFJ6SQdZ1WTJ
         rys7VY9sJH2HAlygIelbh94jF9WVWui4ioA6EZineuaVTOfTI4HsGYPqCa7HDzlQx/jM
         EgByVeo2GImZmQ+W5QozSEovT6z8jVAUEDucYXmVziK2jsDQHyPiOfPHG68mzKubNj3a
         YvIljSZ3cDTWKDmngzA6YMrkww/sYzNLAsbKkDq2QQKrISkh5zyxuScfxEnVBPPX4M52
         d4NxewUtHDau8edFSJrDmrBrA2IXzoabJGo1UXNKO0RuhAwXFXoqUFj1UgFMK/ESrG7q
         dr3g==
X-Gm-Message-State: AJIora9dEKkq4YI8Su1kR5gYUSgAIWAsygzGatwgsAJ4SXdz+WiW7CRQ
        X+mJcasO2k2mwcQUV6MGznGTJBXOeRugj6COJ3dxjg==
X-Google-Smtp-Source: AGRyM1s8jERg0p36PqyphiAkwtRLgjreNmeqmAHlkeVHNpYZOMl7w1X/p6JVFgAnddSW/XKcAhKGiNVel50D01z461A=
X-Received: by 2002:a05:600c:4fd4:b0:3a0:334e:241e with SMTP id
 o20-20020a05600c4fd400b003a0334e241emr2072446wmq.73.1655989887621; Thu, 23
 Jun 2022 06:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220623112905.253157-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623112905.253157-1-krzysztof.kozlowski@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Jun 2022 18:41:15 +0530
Message-ID: <CAAhSdy35972j=qpqQWak1Ot1nZb0iiURzYqhrbZ1bfuuAdpw_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: traps_misaligned: do not duplicate stringify
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 4:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use existing stringify macro from the kernel headers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/traps_misaligned.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 46c4dafe3ba0..378f5b151443 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -7,6 +7,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/irq.h>
> +#include <linux/stringify.h>
>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
> @@ -150,9 +151,6 @@
>  #define PRECISION_S 0
>  #define PRECISION_D 1
>
> -#define STR(x) XSTR(x)
> -#define XSTR(x) #x
> -
>  #define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)                 \
>  static inline type load_##type(const type *addr)                       \
>  {                                                                      \
> @@ -207,9 +205,9 @@ static inline ulong get_insn(ulong mepc)
>         asm ("and %[tmp], %[addr], 2\n"
>                 "bnez %[tmp], 1f\n"
>  #if defined(CONFIG_64BIT)
> -               STR(LWU) " %[insn], (%[addr])\n"
> +               __stringify(LWU) " %[insn], (%[addr])\n"
>  #else
> -               STR(LW) " %[insn], (%[addr])\n"
> +               __stringify(LW) " %[insn], (%[addr])\n"
>  #endif
>                 "and %[tmp], %[insn], %[rvc_mask]\n"
>                 "beq %[tmp], %[rvc_mask], 2f\n"
> --
> 2.34.1
>
