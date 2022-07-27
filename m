Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2AD5829AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiG0PdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiG0Pc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:32:57 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE11F61F;
        Wed, 27 Jul 2022 08:32:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31f445bd486so60777147b3.13;
        Wed, 27 Jul 2022 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQl6ehKgsHyBcO+W1cY0L1NdZu5y/xwam/X+NYPQiLI=;
        b=DeXHGhLgtfyynj98wV8YO+BCLU/Yzf46/Fa08tj2uwlIiGSuXkHKxFj+or8DphUJMl
         ptVfTRP7Lr69Rb5HZQpGnjpDx73NVijiQrvaLm75o5dLo1Y+30Q2zI9e3DK++wyFqOCj
         Sbr8b0SCC/8fsjHe63vYZdtuFi2Vc0FEWvcCJOHKhtxh2UCi1/xKXnDGpXK/zHdYa2f3
         4elZnFzDTlcM9TOmqq2QfrvGxy3WDv3uQyTBBrgO+qDkIY9aeWr+pMQ6anyoDsO3/Wdw
         aZk6C590YR1L4+kKOCpuZnu5uSAonYVLSbQBHbfLdJ2YnWmEQ814i2s5l+MlJqjmSd3G
         IJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQl6ehKgsHyBcO+W1cY0L1NdZu5y/xwam/X+NYPQiLI=;
        b=D84PecWQxNg5rSp6980y4db+GUZ/tI9Q4ilBAhc3ris8PSfWLduZ75Z5XDCxGT7oo1
         0nFeX2AtCqw1+h6nauWZ/a81XRUMzixIpQHSewXDCkRK/jkTaRYrGWLmQTxFmmeEWUDZ
         y9GvZzeJouWJ/Bi8t8M6Yl7fxy+3lFm1bvedDLt1/v3cRlZ+lJ/JecnL6XSORs2Vj0ng
         OE4riCXArTHEigiYQJpoTy+uAIZjuVwSYkI7g0Ok87yWVo8quWNMJWXLEXcN3JMA9eG4
         jGCyn0CU4Ir5tUkRObiFIyP+0RQAnG2wY/tmyTiieYlPHWAWUZRRNATWAwQ76uAy6Tcu
         60+Q==
X-Gm-Message-State: AJIora9o7+z705Qyi5LDbCLAbP1X9Knwi6KAu/yuCMO1UvsX0twzJQgc
        /B1Ncm7GmjT43n++9r97uzDZIBy5oMx9iefd1uc=
X-Google-Smtp-Source: AGRyM1sO8vBRq9aT9sglSssa+iwKjicoels0vxgWeCj/K+xF2arUKXy1DBNmqhRSbnGdnNWfin4mhsUYSijorGIdNcw=
X-Received: by 2002:a81:5d55:0:b0:31c:dce7:96c9 with SMTP id
 r82-20020a815d55000000b0031cdce796c9mr19528137ywb.519.1658935975618; Wed, 27
 Jul 2022 08:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org> <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org> <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org> <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org> <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <80f08089-e3bb-983e-313b-45613364829e@linaro.org> <OS0PR01MB5922FDF8CFFE44A611D3783886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <75e5ace3-3255-2302-65f5-9fbef9cb1147@linaro.org> <5292fbdd-9eae-2398-1260-cbef652f6af2@microchip.com>
In-Reply-To: <5292fbdd-9eae-2398-1260-cbef652f6af2@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 16:32:28 +0100
Message-ID: <CA+V-a8vVOXeqUZL7fTVHrc1qnC==uLR+nHooz=1mg-K3BwW3mQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
To:     Conor.Dooley@microchip.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 2:29 PM <Conor.Dooley@microchip.com> wrote:
>
> On 27/07/2022 14:00, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On 27/07/2022 14:56, Biju Das wrote:
> >>>
> >>> Then it is not the same SoC! Same means same, identical. CPU
> >>> architecture is one of the major differences, which means it is not the
> >>> same.
> >>
> >> Family SoC(R9A07G043) is at top level. Then it has different SoCId for taking care of
> >> differences for SoC based on ARMV8 and RISC-V which has separate compatible like
> >> r9a07g043u11 and r9a07g043f01?
> >
> > This does not answer the concern - it's not the same SoC. The most
> > generic compatible denotes the most common part. I would argue that
> > instruction set and architecture are the most important differences.
> > None of ARMv8 SoCs (SoCs, not CPU cores) have "arm,armv8" compatible and
> > you went even more - you combined two architectures in the most generic
> > compatibles.
>
> I would have to agree with this. The most "core" part of the SoC is
> its architecture and while the peripheral IPs might be the same etc
> & the Renesas marketing team might have put them in the same "family",
> for the purposes of a device tree I don't see how having a common
> fallback makes sense.
>
Agreed, I was following the same which we have done on the ARM64 schema.

I am waiting on Geert's feedback on whether we should follow as
Krzysztof suggested ie to have

renesas,smarc-evk-r9a07g043f01 - for the board
renesas,9a07g043f01 - for the SoC

Cheers,
Prabhakar
