Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43055827EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiG0Npq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiG0Npm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:45:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3400BDFCD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:45:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so2372513wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gGrlyDdirvdUA7riaI7TlemrpJ1LUBifzMGQQE/jDU=;
        b=aKoczN7k/b/+LolbU8csJT7jtDZsDTeSvx3Zk5EwoZBtEzljz8+BJasZmELiDP475B
         mEFBsLIGvifwWkMkXIYH2RcsiBiXb3wBrA1Q3rVg03uLkD8ToYWlnTudgtmSeEyJK6o5
         LRsIzG21yeKngXSQQPo3ZgGRuoRD7UP1vuerJ5Wf/v4+3Ui9Qz/F+Xt3h4+Itbn5i3PH
         To03EGaMHO0UuYhZHMs/ZioA2XpkC5ElpQYihO33E7SVqRU+62Wj5CZuctyUZllDX+g0
         L4py3NLskYAR4kEvkX3nR4WUg4EpXOmxb53sGNDBFjnjo2+QgUWi0/G3EpqNWyheC9lY
         Glrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gGrlyDdirvdUA7riaI7TlemrpJ1LUBifzMGQQE/jDU=;
        b=1YHXd74Ei0Hal6vSUj6FNGFd/LZfp3dXs8hnu6WaOI2s5d4kTzEBAMxx2GjVUj1kNt
         gddXqSX4/oVEM9DQ/lRs+krmntHKFevbyEbR7CRanKTac1kyB4edcURNiYdEiXt4+XXc
         KOa8YcKV6RMtV+DJG4HFiPQIJnxLOu9Yif+ql8hTQ3PTkFwvhSu9g4HY9PEI5h7uXL85
         ah7odkuZr6gK9c4A/JYLMfrtGvj9d12lylF3X3YboRuJVMxq4xY0N1LdrJ52YKbN9hKh
         USe1Bqgk1Qfsp19EhAwRBW2nJfcelUOJgFrDd2/UyXuvNWgg3Y0b81gsFLP876nWtDkx
         WlQg==
X-Gm-Message-State: AJIora8o4qGj0WYkGstlA+lmezbElmOQ2/0FVofZAiWxL4sueH8tTfzY
        sw22k2yfJz5bIGf8o/UPzHJd8BAXQZ6BpXGurDHnTg==
X-Google-Smtp-Source: AGRyM1vX7ezpYljF/hOQ0ZqLM8P3MfOOLiOVDi5erUYoEUOh9xltKy4QxFtI8mHqlZRaN5MibKtQN46hvKBVNtxOYxM=
X-Received: by 2002:a05:600c:5114:b0:3a3:3f7f:27ec with SMTP id
 o20-20020a05600c511400b003a33f7f27ecmr3109497wms.93.1658929539557; Wed, 27
 Jul 2022 06:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com> <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <20220727124556.owk3zlyzsg5uaa4t@bogus>
In-Reply-To: <20220727124556.owk3zlyzsg5uaa4t@bogus>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Jul 2022 19:15:28 +0530
Message-ID: <CAAhSdy0TSKhR8_2eU7pmgizybuxPbwAycn4YudvkfGWGbnXNtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Wed, Jul 27, 2022 at 6:16 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 02:07:50PM +0200, Krzysztof Kozlowski wrote:
> > On 27/07/2022 13:43, Anup Patel wrote:
> > > We add an optional DT property riscv,timer-can-wake-cpu which if present
> > > in CPU DT node then CPU timer is always powered-on and never loses context.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > index d632ac76532e..b60b64b4113a 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -78,6 +78,12 @@ properties:
> > >        - rv64imac
> > >        - rv64imafdc
> > >
> > > +  riscv,timer-can-wake-cpu:
> > > +    type: boolean
> > > +    description:
> > > +      If present, the timer interrupt can wake up the CPU from
> > > +      suspend/idle state.
> >
> > Isn't this a property of a timer, not CPU? IOW, your timer node should
> > have "wakeup-source" property.
> >
>
> I agree on the concept that this is property of the timer and not CPU.
> However we generally don't need to use wakeup-source property for timer
> as we ideally use this for waking up from system sleep state and we don't
> want to be running timer when we enter the state.

It seems ARM is using two separate timer DT properties: one for
system suspend (i.e. arm,no-tick-in-suspend) and another for CPU
system (i.e. always-on). Is this understanding correct ?

>
> > Now that's actual problem: why the RISC-V timer is bound to "riscv"
> > compatible, not to dedicated timer node? How is it related to actual CPU
> > (not SoC)?
>
> We have "always-on" property for this on arm arch timer, and I also see
> "regulator-always-on" or something similar defined. So in absence of timer
> node probably "local-timer-always-on" make sense ? Thoughts ?
>
> --
> Regards,
> Sudeep

Regards,
Anup
