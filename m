Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C4590E74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiHLJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiHLJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:50:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761AF2722;
        Fri, 12 Aug 2022 02:50:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 21so695889ybf.4;
        Fri, 12 Aug 2022 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Q5LlMwsyUspPj+LtUVoQu26MZFGsOb33CHbaqq1+4jY=;
        b=HLc75iYp79U1+RfhEBEOhwMlcov52UCcyU+25l5nIgSE4ZPcnkp3oEkZQa1i+IqCy3
         reG28bNyQGn7hxdj7H/0fK8bSv1k6AnOmynkI2yzau3lzhdKQW3qTM58UQD00qyUNUCh
         eRApV/QCT8+C50xMZ/WnA9QUkmqnk0PNev9mrqEbnB8/s0Ky59r6NQC9+3bzs72p0rtl
         wauKGWXFx/3Xfw2XRThy4QMjAJA4mdquushkxg3kt/mvmsRbul11EzI9GuUL9Jbm79Di
         310jC6boc8ZKwICI780E0W9rybi02aINiEOR5O8CxYz8fC1YopKdcHy7cLthXX4W2G1R
         QL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Q5LlMwsyUspPj+LtUVoQu26MZFGsOb33CHbaqq1+4jY=;
        b=h/U0LYPR2GbXF9JSEGpF3ssnowOvVL+VrLLufBCLrwOgdELKaNMXJB/MtJ6ohZsIkM
         Li0ccEE62ESYjielNJ7vQB1YZ5j/+5hDAdYWs1wVeCGG1Keu4vyXcdgCuIjfJiACNjdt
         0KO0OdSeTSCMAUaEWtE7m4Xk4aQeUi0f9aXZoYW4G53SoyLT1cwgWipe9eQwqWstCiP8
         jKg2MTk/oGe277fIyJfyNXSiuqmRXdiFt3Ap6nYscRxXWaqdAXcVNb/q6HSTMl5WPDRo
         2nwf/ltCdGCrWjeSMVsSmk5EyBToHsH5f8aAXaFZSWKrafXfN1Rj24JLEIzo0pMICGlg
         5VVg==
X-Gm-Message-State: ACgBeo2FH3sH3WCrDPKswdztqL/5l3ZmPAuvoNqVYYQ0XSAqbEoDEjJo
        FY938wnZ4mEg48Z0uvtP3pYzzBKZ4TKMYw8UYmY=
X-Google-Smtp-Source: AA6agR5Qds9HYZib7WpLaLPtA8FNj+szouC4DQXZ2jOMC4iomnaw1mEjO7ET2cQ/CJgVkEcs1O6l22bXprmAG+HAMCA=
X-Received: by 2002:a25:2245:0:b0:67b:7758:808b with SMTP id
 i66-20020a252245000000b0067b7758808bmr2793684ybi.279.1660297816681; Fri, 12
 Aug 2022 02:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org> <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org> <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org> <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org> <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <80f08089-e3bb-983e-313b-45613364829e@linaro.org> <CAMuHMdWOdQ5HNU8CuWYXHqYs-UfdggTuCf1AARdJC-3WMTy7Hg@mail.gmail.com>
 <1aa477b2-1d91-066e-5fcd-849ece62388d@linaro.org>
In-Reply-To: <1aa477b2-1d91-066e-5fcd-849ece62388d@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 12 Aug 2022 10:49:49 +0100
Message-ID: <CA+V-a8uK3=Ca_1O_gQOm-5hUB1L95Wh_uXm5fpbAS0cbuVJE2w@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Geert,

On Fri, Aug 12, 2022 at 7:23 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/08/2022 18:42, Geert Uytterhoeven wrote:
> > At the DT validation level, I think the proper solution is to
> > merge Documentation/devicetree/bindings/arm/renesas.yaml and
> > Documentation/devicetree/bindings/riscv/renesas.yaml into a single
> > file under Documentation/devicetree/bindings/soc/renesas/.
> >
> > What do other people think?
>
> I am ok with it.
>
Thanks, I'll move this to the soc folder in v2.

Cheers,
Prabhakar
