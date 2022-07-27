Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5B582647
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiG0MVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiG0MVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:21:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B23C8C0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:21:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w15so18812619lft.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bEtmnK2tPU54AB6HVbM7vDC+tZHIQcAyrzRsaXxDZM=;
        b=GgSGDIdHNixhUGu7yYAoz9ouzF0cT0bTt4S1/YmYLkt5GDfgvZBWzegMGJlXpsf2YQ
         bhL1bod+/rV+CnEVcM6rDKWhaLbvHKIQ8E6J6S08LicgAf/JPdmCYipJ2m9HwxfRNJQn
         +SJlIkRUaHJvkYW7OrfaFlZPoBwMtbqiuQjFHcVcjBOS2Uz948tiFPy0oxOCr1h/1ZIk
         lrb2JsONok9uuXduhfl0kVAA2aKwn5ykcRJoutP4u4kgpyCfsrGXfCfbfO8MTU0X1Ec9
         RDOhQHKAej2rbGm41huZNordTZ2u7bukYCURGu/iEz/KnrUwCJ14QyeGAGkRhCuPgyk6
         JAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bEtmnK2tPU54AB6HVbM7vDC+tZHIQcAyrzRsaXxDZM=;
        b=PYK5mPYoBHdOLFlaopVTW/1vOOTLypCl3hXHqvPL45ER5rSs9n9t1WFIx13jYA2hdC
         x4XFwVJvQ+NA0H5VhFi2xLkf907sut5F5ldVbLOf11UUQYSpEGnwxLioXbyQRtiAd2Fh
         joF9eQYTtkNsNqjK3rA868rXRSpkyzgiLpqu1ZqHQB+1kXIqodcroYfWl8f6+2mqy4lj
         kTh19v0agNy0rZup4u582oqSmYKtcLXCxKCVyuwFBiEOuNgWigtXoztJX32wZITn1fAT
         bw8QJRjYaG0MxWCLAn2LIhFTE49wdT4D3sdz7OJJ6aXQYmxkJOOpLsoSXgIZiqL3Z87L
         QFXQ==
X-Gm-Message-State: AJIora/FBF5gaPYfuQbREiI7Pb7r/B3tDl3NdKjp1QmLNGxpqq7CU8wU
        v2ZP+4sKK2hCQyrcpsT7AlLhvwj5C+udqZOH9eAJ5g==
X-Google-Smtp-Source: AGRyM1tBR5GHnn8Sw/Vkd8jNxCDYQqmi2BGppjOeFfvYrEZtHdmW/4v1/hpsHv17Di796mRJwvbprkRM0Q7KijluqJc=
X-Received: by 2002:a05:6512:3e03:b0:48a:9d32:5652 with SMTP id
 i3-20020a0565123e0300b0048a9d325652mr3537132lfv.41.1658924476217; Wed, 27 Jul
 2022 05:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com> <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
In-Reply-To: <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 27 Jul 2022 17:51:05 +0530
Message-ID: <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 5:37 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/07/2022 13:43, Anup Patel wrote:
> > We add an optional DT property riscv,timer-can-wake-cpu which if present
> > in CPU DT node then CPU timer is always powered-on and never loses context.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index d632ac76532e..b60b64b4113a 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -78,6 +78,12 @@ properties:
> >        - rv64imac
> >        - rv64imafdc
> >
> > +  riscv,timer-can-wake-cpu:
> > +    type: boolean
> > +    description:
> > +      If present, the timer interrupt can wake up the CPU from
> > +      suspend/idle state.
>
> Isn't this a property of a timer, not CPU? IOW, your timer node should
> have "wakeup-source" property.

Historically (since the early days), we never had a timer node in the
RISC-V world.

>
> Now that's actual problem: why the RISC-V timer is bound to "riscv"
> compatible, not to dedicated timer node? How is it related to actual CPU
> (not SoC)?

The RISC-V timer is always present on all RISC-V platforms because
the "time" CSR is defined by RISC-V privileged specification. The method
to program per-CPU timer events in either using SBI call or Sstc CSRs.

Since, there is no dedicated timer node, we use CPU compatible string
for probing the per-CPU timer.

Regards,
Anup
