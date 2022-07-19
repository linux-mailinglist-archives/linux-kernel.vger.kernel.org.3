Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DDC5794B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiGSH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiGSH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:58:09 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D4D3AE51;
        Tue, 19 Jul 2022 00:58:02 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id r12so10558226qvm.3;
        Tue, 19 Jul 2022 00:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3taTuKeIgki22WvuFHicrfEHw/ak0WDquxxXe2fRN4=;
        b=FJ8VkHWDPAwq/MOLk+zP2NXp5Xza9O82T1hsE8Bdy8Zx50RxLdaCfksfy813oHBAn0
         /YNBCio+EdyB5IuQ9mL5e7NNj5WcV+3X7UZ3OK/phw+cfBkTS55QN0SeTTGevfO5IErN
         AzVZ+Pu043u3k0UpOH7D/w4WLN4J264eCgyDWV2uHrn3PgsQ87Iuh+8mM0858xpzdIto
         s0nBOUYKv9zDd8lRZZm8k/YA4W8EURLg1PsnZQMkXmW69Hu0TKv20XIu32Jpp13P2WJL
         Vgjigr33D2EL4quddTZJhyHlcRsVs4mOUtlpNdJRCtCo86iTk4ljnzx/wcFuVe6taW9R
         VHUg==
X-Gm-Message-State: AJIora/xVNeHuRMd408Rr+bPdS59tnndm4x9bz0PPUcxzBGubVsJMqu0
        yYhCh4A6aZDcOPF5FlhTpj0jm15Gs+Vxdg==
X-Google-Smtp-Source: AGRyM1tmtObvppyc/eAiJUCimmR9liReQzyR5ecdQdT+CQC6xD95cE5iTxiXxVj2kwt1HhAJyxDteg==
X-Received: by 2002:a05:6214:1ccd:b0:46e:7427:2626 with SMTP id g13-20020a0562141ccd00b0046e74272626mr24405509qvd.101.1658217480953;
        Tue, 19 Jul 2022 00:58:00 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006b5df4d2c81sm8583259qko.94.2022.07.19.00.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:58:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31e560aa854so20316467b3.6;
        Tue, 19 Jul 2022 00:58:00 -0700 (PDT)
X-Received: by 2002:a81:168f:0:b0:31e:6128:247d with SMTP id
 137-20020a81168f000000b0031e6128247dmr264411yww.383.1658217480387; Tue, 19
 Jul 2022 00:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com> <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 09:57:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUYwTLehX8Q-Qk8rar7K2Ag4oN369+9X7pzvreGdRoZag@mail.gmail.com>
Message-ID: <CAMuHMdUYwTLehX8Q-Qk8rar7K2Ag4oN369+9X7pzvreGdRoZag@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: timer: renesas,cmt: Add r8a779f0 and
 generic Gen4 CMT support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Jul 13, 2022 at 12:06 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> @@ -83,6 +83,11 @@ properties:
>                - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
>            - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ/G2
>
> +      - items:
> +          - enum:
> +              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
> +          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
> +
>        - items:
>            - enum:
>                - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
> @@ -100,6 +105,11 @@ properties:
>                - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
>            - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
>
> +      - items:
> +          - enum:
> +              - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
> +          - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
> +
>    reg:
>      maxItems: 1

The above is correct, but you forgot to update the conditional sections
specifying the number of interrupts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
