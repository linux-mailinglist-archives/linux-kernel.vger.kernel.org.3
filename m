Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA42579D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbiGSMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbiGSMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:49:47 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2638EEFF;
        Tue, 19 Jul 2022 05:19:47 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id l14so8448711qtv.4;
        Tue, 19 Jul 2022 05:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJG6Ulg/9mINtjLuIPQP9FH//JZjqoP/N9ZujWJIh7A=;
        b=Va0IZy9p9o3ufGbs+cGHCWvLYz0zDm9ldajoC/Yu3Z+NcFClp42RGxa3Haoq9xRbpq
         tY3WzfYddDG+MB5/om38ld8gb5FedhN2lxZ4bvD5DGKKJvdGUUvcQfbBy3IDwDOrIPeq
         7VtKX6dxN9cPBTt6IOynwbJotbIZZyds+C2Dy+LeN6k1zBjT2yBSkZ7NTLN1fgpChLXF
         gPsoVIvzMAiadRdQvMizxUad7B4X8A869RTB+MK2np4vMQcWf/CDii6bcQ5miJZqQpnh
         NTqqO8cUhWMz84gDW1RtoHvHfKdK6v7JxD0DAyZ9kLco+VlmZ8lM8xJwIyr3Kd/qJYKC
         mlAA==
X-Gm-Message-State: AJIora9ybYFsvZjef0hPgIRqbITKDIHOUiTDfgnuHkgd6dhoyAIL7erM
        piu/P63pW7eI6io4TxgFraIBpHfTZcM5sg==
X-Google-Smtp-Source: AGRyM1smW9qqAktG/Yz2BOl7I6w5o1ma7XbpwfutE0Fwr+AAbEEZRzjqMGP1AwYRIG0QC/jDClzuMg==
X-Received: by 2002:ac8:5882:0:b0:31e:e175:8351 with SMTP id t2-20020ac85882000000b0031ee1758351mr13602622qta.71.1658233165042;
        Tue, 19 Jul 2022 05:19:25 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id do1-20020a05620a2b0100b006b5c80e2b6asm13754924qkb.12.2022.07.19.05.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 05:19:24 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 75so26131988ybf.4;
        Tue, 19 Jul 2022 05:19:24 -0700 (PDT)
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr29388524ybu.365.1658233164004; Tue, 19
 Jul 2022 05:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
 <20220713100603.3391-2-wsa+renesas@sang-engineering.com> <CAMuHMdUYwTLehX8Q-Qk8rar7K2Ag4oN369+9X7pzvreGdRoZag@mail.gmail.com>
In-Reply-To: <CAMuHMdUYwTLehX8Q-Qk8rar7K2Ag4oN369+9X7pzvreGdRoZag@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 14:19:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUO_nR_b_+76LVEeTU87APW9GiMPhoMOV6KDQrtwCaaSw@mail.gmail.com>
Message-ID: <CAMuHMdUO_nR_b_+76LVEeTU87APW9GiMPhoMOV6KDQrtwCaaSw@mail.gmail.com>
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

On Tue, Jul 19, 2022 at 9:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jul 13, 2022 at 12:06 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> > +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> > @@ -83,6 +83,11 @@ properties:
> >                - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
> >            - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ/G2
> >
> > +      - items:
> > +          - enum:
> > +              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
> > +          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
> > +
> >        - items:
> >            - enum:
> >                - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
> > @@ -100,6 +105,11 @@ properties:
> >                - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
> >            - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
> >
> > +      - items:
> > +          - enum:
> > +              - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
> > +          - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
> > +
> >    reg:
> >      maxItems: 1
>
> The above is correct, but you forgot to update the conditional sections
> specifying the number of interrupts.

However, it would have been nice to adhere to the existing sort order
in the file... I will prepare a patch for both issues...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
