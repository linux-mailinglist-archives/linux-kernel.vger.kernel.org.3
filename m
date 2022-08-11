Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0559B59012A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiHKPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiHKPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:50:55 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD30A1D2F;
        Thu, 11 Aug 2022 08:42:39 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id h4so6971646qtj.11;
        Thu, 11 Aug 2022 08:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CmaQmycmiDs0ZhLNzBEap3uy9DegAtgeJY98yfTaoT0=;
        b=ULaRRhLxOhA1fMHO203DND7B0vFpogE8S0PgGp6UUUiOiTGwaHI7zh/X35/l6Yil8a
         7IyHQLQubjxQK2x3hU7NswjbyRkNDDMBcAK47je+7H0qq7yK6NKbi39sTI1KOViC1sUx
         nrtawqaHp0sFKxQCQz3PwLFMNOFn+0t2paUmc6VGY6mNr6cUPFbGxQRIQAAjmK9Twnf9
         hvjINFr7tUe45xFwWmzNjnQ3mUIjkYDRtj0Xg2QFBkpSQGhkISWWlmjoUN0MTHYkE+j5
         8GMZPUNtgC16ztb+AT9kG7NGPRKmAPVBTBpBNh8ehEdT/zUkdcchrQi0z0shIv54N/Se
         HV1w==
X-Gm-Message-State: ACgBeo1Rl/uUxrpsmLDGaELLGK23Wvn5b3v7GBC2GaKPixyUTr1E3Euk
        L7V80tL2cS4pdamYW1viKiIyAKTx44Mqdfep
X-Google-Smtp-Source: AA6agR6JZleD7P0zWD1Cs/v4IGCQsXeZzAUKD7qjw+oohmOVOnnsf8OVADIsvGQVhz+B84v5gDJQTw==
X-Received: by 2002:ac8:5a51:0:b0:342:e917:f25b with SMTP id o17-20020ac85a51000000b00342e917f25bmr24047628qta.284.1660232558391;
        Thu, 11 Aug 2022 08:42:38 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id w22-20020ac857d6000000b0031f287f58b4sm1890826qta.51.2022.08.11.08.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:42:36 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 204so28869438yba.1;
        Thu, 11 Aug 2022 08:42:35 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr29967472ybq.543.1660232555433; Thu, 11
 Aug 2022 08:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org> <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org> <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org> <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org> <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <80f08089-e3bb-983e-313b-45613364829e@linaro.org>
In-Reply-To: <80f08089-e3bb-983e-313b-45613364829e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 17:42:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOdQ5HNU8CuWYXHqYs-UfdggTuCf1AARdJC-3WMTy7Hg@mail.gmail.com>
Message-ID: <CAMuHMdWOdQ5HNU8CuWYXHqYs-UfdggTuCf1AARdJC-3WMTy7Hg@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 27, 2022 at 2:37 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 27/07/2022 14:21, Biju Das wrote:
> >> Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding
> >> documentation for Renesas RZ/Five SoC and SMARC EVK
> >> On 27/07/2022 13:37, Lad, Prabhakar wrote:
> >>>>> I did run the dtbs_check test as per your suggestion (below is the
> >>>>> log) and didn't see "no matching schema error"
> >>>>>
> >>>>
> >>>> So you do not see any errors at all. Then it does not work, does it?
> >>>>
> >>> Right I reverted my changes I can see it complaining, dtb_check seems
> >>> to have returned false positive in my case.
> >>>
> >>> What approach would you suggest to ignore the schema here?
> >>
> >> I don't think currently it would work with your approach. Instead, you
> >> should select here all SoCs which the schema should match.
> >>
> >> This leads to my previous concern - you use the same SoC compatible for
> >> two different architectures and different SoCs: ARMv8 and RISC-V.
> >
> > Or is it same SoC(R9A07G043) based on two different CPU architectures (ARMv8 and RISC-V)
>
> Then it is not the same SoC! Same means same, identical. CPU
> architecture is one of the major differences, which means it is not the
> same.
>
> > Using same SoM and Carrier board?
>
> It's like saying PC with x86 and ARMv8 board are the same because they
> both use same "PC chassis".

That's not a fair comparison: the "PC chassis" is passive, while the
carrier board is an active PCB.  So it is more akin to plugging
any Intel LGA 1151 processor into any motherboard with an LGA
1151 socket.  Do we have compatible values for all such possible
combinations? ;-)

The classic compatible scheme of an ordered list from most-specific
to least-specific is not well-suited for this case of mere
aggregation.  That's why we have been decoupling board and SoC
compatible values for a while, and identifying specific boards by a
combination of a board-specific and an SoC-specific compatible value.

New SoCs that are available with different core CPU families (and
that are pin-compatible) are just the next step in the evolution....

At the DT validation level, I think the proper solution is to
merge Documentation/devicetree/bindings/arm/renesas.yaml and
Documentation/devicetree/bindings/riscv/renesas.yaml into a single
file under Documentation/devicetree/bindings/soc/renesas/.

What do other people think?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
