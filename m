Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7055658FF47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiHKP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiHKP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:26:46 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46D6B166;
        Thu, 11 Aug 2022 08:26:45 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id u8so13585916qvv.1;
        Thu, 11 Aug 2022 08:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DTtQnNq6ywRHsZZL/uujOqWlFtBnXuiLlCZYEJfCk7M=;
        b=YRRJwoNP/uegJz2mkcBcT7O54hXRzqirgIvKluwiDTt51aB+9UTmVu1k26Ws3a9xYt
         mqkvAz3guhYyqsgsxuVK5oXi7RkfGSynL/QubWggPR+fstZ3EL0pXu4aMNayPsCJhuPO
         yimsLbKRRKKUWnVAIHBcZftXwdntEWZp6zmOo8FfuYBxvGFN87Qy3jJXo2iYk5Ci5qNc
         0hTGBXdAt+EeO/xBPBSM7jhhWdkT/nniTPe/Hqj3h0uRJodT99tQE0t0aiKohVGS3YZp
         wMTxjAoW7YgWbNyqgB4P8xb1rgaJaNDBao4Q8SXb+r/hTLdRar1OK1M1St8W7eV538hn
         svgw==
X-Gm-Message-State: ACgBeo3AHJd2X/nWpXBIuqA4OJEwXOru0x1k22S+79TT6IwfCDAODefb
        UGa6Z0p/1/KiuQF01WB7CvrySdYETj+1RrD2
X-Google-Smtp-Source: AA6agR4bYlU0/EITs/MY4AcXHnUfMbG/kUQgczbthvLfPtSBLiBOUmHFfIeYi5a2Uv+GTaeWJxH+vA==
X-Received: by 2002:a05:6214:e4e:b0:476:c48f:ad7 with SMTP id o14-20020a0562140e4e00b00476c48f0ad7mr28306940qvc.33.1660231604396;
        Thu, 11 Aug 2022 08:26:44 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006b93ef659c3sm2310349qkn.39.2022.08.11.08.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:26:44 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-32194238c77so176451937b3.4;
        Thu, 11 Aug 2022 08:26:43 -0700 (PDT)
X-Received: by 2002:a81:af42:0:b0:31f:4e9a:74ad with SMTP id
 x2-20020a81af42000000b0031f4e9a74admr33633524ywj.358.1660231603773; Thu, 11
 Aug 2022 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org> <CA+V-a8vb+za1Zckk5aTxz0hKkd5fHQk7gtfV+HR_2YMZ5JuJEQ@mail.gmail.com>
 <3e3c0c80-48eb-098d-977d-a1801036fc0c@linaro.org> <CA+V-a8tJVGz57FcJVnbksMot=pg5dXALo4QEyqO+57HnOTJLfQ@mail.gmail.com>
In-Reply-To: <CA+V-a8tJVGz57FcJVnbksMot=pg5dXALo4QEyqO+57HnOTJLfQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 17:26:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWih6XiVfLT0g=k8QrMmVzb2sqv9hxqtGE1t1F1Jvj_QA@mail.gmail.com>
Message-ID: <CAMuHMdWih6XiVfLT0g=k8QrMmVzb2sqv9hxqtGE1t1F1Jvj_QA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Jul 27, 2022 at 11:48 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Jul 27, 2022 at 10:31 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 27/07/2022 11:00, Lad, Prabhakar wrote:
> > > On Wed, Jul 27, 2022 at 9:53 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >> On 26/07/2022 20:06, Lad Prabhakar wrote:
> > >>> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> > >>> (RISC-V arch).
> > >>>
> > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
> > >>>  1 file changed, 9 insertions(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> > >>> index ff80152f092f..f646df1a23af 100644
> > >>> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > >>> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > >>> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> > >>>  maintainers:
> > >>>    - Geert Uytterhoeven <geert+renesas@glider.be>
> > >>>
> > >>> +# We want to ignore this schema if the board is of RISC-V arch
> > >>> +select:
> > >>> +  not:
> > >>> +    properties:
> > >>> +      compatible:
> > >>> +        contains:
> > >>> +          items:
> > >>> +            - const: renesas,r9a07g043f01
> > >>
> > >> Second issue - why not renesas,r9a07g043?
> > >>
> > > We have two R9A07G043 SOC'S one is based on ARM64 and other on RISC-V.
> > >
> > > RZ/G2UL ARM64:
> > > Type-1 Part Number: R9A07G043U11GBG#BC0
> > > Type-2 Part Number: R9A07G043U12GBG#BC0
> > >
> > > RZ/Five RISCV:
> > > 13 x 13 mm Package Part Number: R9A07G043F01GBG#BC0
> > >
> > > So to differentiate in ARM schema I am using  renesas,r9a07g043f01.
> >
> > What is the point to keep then r9a07g043 fallback? The two SoCs are not
> > compatible at all, so they must not use the same fallback.
> >
> Agreed, I wanted to keep it consistent with what was done with ARM64
> (since both the SoCs shared R9A07G043 part number).
>
> Geert - What are your thoughts on the above?

"renesas,r9a07g043" is the CPU-less SoC base containing I/O devices.
"renesas,r9a07g043f01", "renesas,r9a07g043u11", and
"renesas,r9a07g043u12" are SoCs built by integrating one or more
RV64 or ARM64 CPU cores and the related interrupt controllers with
the CPU-less SoC base.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
