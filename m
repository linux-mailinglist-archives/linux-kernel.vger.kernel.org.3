Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794859093C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiHKXiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiHKXiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:38:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF4D9AFC4;
        Thu, 11 Aug 2022 16:38:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-32a09b909f6so83809797b3.0;
        Thu, 11 Aug 2022 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IVeJqcWhysLWzgWUShSqLwDczoSExRUDYbSpzRpTiXQ=;
        b=k9jTdTI8sjO6UKOTeC4As0uQK2prWT7dSWXk4grIFRnvMm8jpC71fdZnFr5SVlFie3
         J5u9uJmgcQOpJlmDc+TH8w1teZWNMP2cwYNXmIFamQ+6Oez/W8vAph4I54W5OMxOaWi3
         nzH8r7JhnuooVcrrlRzGUgyXwBWg/NRqQooBGrXsRw4UH8M3qym/5q98FZ1LWi/Q8gIy
         /zQtmgyn6JIhmp/XPWJ4Df1VyBMTp6GMv1xc22OfjJDwRgldahF+FV3/Co5okfwaU45w
         TNz2pQ/MqF4vgbz7VCz+TSEj0hjfhtVk2wGEkuFhFUsNc94jgGEMz6GSwyK20nFeGtll
         uO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IVeJqcWhysLWzgWUShSqLwDczoSExRUDYbSpzRpTiXQ=;
        b=gas/YV0oWSwcjhLxplnZRCNameIjEGZRHbh57AuBnCY8I0ijJKbv/RpXom7HfSDIyo
         920ZEE6PtzIfmiuaqRsHTiXxKZPQ5XALsC77U7gHdvTomdOcEK+P6YfodmYfzxfnmXT4
         1xbmcBYtsHIfDoC0kOPD8/YuZWp5PN3ql4clLSy+i5tHUROecBweacjG5nZU63D2yIUH
         H8jLuH8OSJia6t65GjnEg3yX1WoAXhZOAAoA1oTdxRjzZ58g36mC6kksjRyAagQv33gR
         25DPXqNYMcehQNwSFYgPgI9iDFrcE3OhVjfhgGGo47j4qfH9gLGlN0CISpoLVkcqcUp0
         dqTQ==
X-Gm-Message-State: ACgBeo3b4BtVxtqg84hcf2GT9i/46ElBPBUkrIfSe4qmKvA3Knlakda6
        PgYkuN1/5damsl3APcB1M8ha4R35N2Zcf9iGjoaoizT3kro=
X-Google-Smtp-Source: AA6agR53mPvsRpuEkAtKI6C+nhnmHsWN+IupElYcWWe4XANRE7IWo58pKjOW1TMETFZly0nVg2UElycZ1NeUGtGGebc=
X-Received: by 2002:a0d:f282:0:b0:329:7da1:90e8 with SMTP id
 b124-20020a0df282000000b003297da190e8mr1535254ywf.519.1660261089750; Thu, 11
 Aug 2022 16:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org> <CA+V-a8vb+za1Zckk5aTxz0hKkd5fHQk7gtfV+HR_2YMZ5JuJEQ@mail.gmail.com>
 <3e3c0c80-48eb-098d-977d-a1801036fc0c@linaro.org> <CA+V-a8tJVGz57FcJVnbksMot=pg5dXALo4QEyqO+57HnOTJLfQ@mail.gmail.com>
 <CAMuHMdWih6XiVfLT0g=k8QrMmVzb2sqv9hxqtGE1t1F1Jvj_QA@mail.gmail.com>
In-Reply-To: <CAMuHMdWih6XiVfLT0g=k8QrMmVzb2sqv9hxqtGE1t1F1Jvj_QA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 12 Aug 2022 00:37:42 +0100
Message-ID: <CA+V-a8tkRJrugewfAunO7CP9H7A8H5OM2=uRQtDfk7=15Zkw4A@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Aug 11, 2022 at 4:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Jul 27, 2022 at 11:48 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Jul 27, 2022 at 10:31 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 27/07/2022 11:00, Lad, Prabhakar wrote:
> > > > On Wed, Jul 27, 2022 at 9:53 AM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >> On 26/07/2022 20:06, Lad Prabhakar wrote:
> > > >>> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> > > >>> (RISC-V arch).
> > > >>>
> > > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >>> ---
> > > >>>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
> > > >>>  1 file changed, 9 insertions(+)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> > > >>> index ff80152f092f..f646df1a23af 100644
> > > >>> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > > >>> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > > >>> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> > > >>>  maintainers:
> > > >>>    - Geert Uytterhoeven <geert+renesas@glider.be>
> > > >>>
> > > >>> +# We want to ignore this schema if the board is of RISC-V arch
> > > >>> +select:
> > > >>> +  not:
> > > >>> +    properties:
> > > >>> +      compatible:
> > > >>> +        contains:
> > > >>> +          items:
> > > >>> +            - const: renesas,r9a07g043f01
> > > >>
> > > >> Second issue - why not renesas,r9a07g043?
> > > >>
> > > > We have two R9A07G043 SOC'S one is based on ARM64 and other on RISC-V.
> > > >
> > > > RZ/G2UL ARM64:
> > > > Type-1 Part Number: R9A07G043U11GBG#BC0
> > > > Type-2 Part Number: R9A07G043U12GBG#BC0
> > > >
> > > > RZ/Five RISCV:
> > > > 13 x 13 mm Package Part Number: R9A07G043F01GBG#BC0
> > > >
> > > > So to differentiate in ARM schema I am using  renesas,r9a07g043f01.
> > >
> > > What is the point to keep then r9a07g043 fallback? The two SoCs are not
> > > compatible at all, so they must not use the same fallback.
> > >
> > Agreed, I wanted to keep it consistent with what was done with ARM64
> > (since both the SoCs shared R9A07G043 part number).
> >
> > Geert - What are your thoughts on the above?
>
> "renesas,r9a07g043" is the CPU-less SoC base containing I/O devices.
> "renesas,r9a07g043f01", "renesas,r9a07g043u11", and
> "renesas,r9a07g043u12" are SoCs built by integrating one or more
> RV64 or ARM64 CPU cores and the related interrupt controllers with
> the CPU-less SoC base.
>
That's bang on! which I missed to convenience the DT maintainers.

Cheers,
Prabhakar
