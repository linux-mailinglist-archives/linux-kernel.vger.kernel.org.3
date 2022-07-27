Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8866582990
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiG0P0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiG0P0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:26:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 785DC3336E;
        Wed, 27 Jul 2022 08:26:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABAA5113E;
        Wed, 27 Jul 2022 08:26:19 -0700 (PDT)
Received: from bogus (unknown [10.57.11.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04EB3F73B;
        Wed, 27 Jul 2022 08:26:16 -0700 (PDT)
Date:   Wed, 27 Jul 2022 16:26:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
Message-ID: <20220727152613.kbhfnvekpkd7na72@bogus>
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
 <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <20220727124556.owk3zlyzsg5uaa4t@bogus>
 <CAAhSdy0TSKhR8_2eU7pmgizybuxPbwAycn4YudvkfGWGbnXNtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy0TSKhR8_2eU7pmgizybuxPbwAycn4YudvkfGWGbnXNtQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 07:15:28PM +0530, Anup Patel wrote:
> Hi Sudeep,
> 
> On Wed, Jul 27, 2022 at 6:16 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Jul 27, 2022 at 02:07:50PM +0200, Krzysztof Kozlowski wrote:
> > > On 27/07/2022 13:43, Anup Patel wrote:
> > > > We add an optional DT property riscv,timer-can-wake-cpu which if present
> > > > in CPU DT node then CPU timer is always powered-on and never loses context.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > index d632ac76532e..b60b64b4113a 100644
> > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > @@ -78,6 +78,12 @@ properties:
> > > >        - rv64imac
> > > >        - rv64imafdc
> > > >
> > > > +  riscv,timer-can-wake-cpu:
> > > > +    type: boolean
> > > > +    description:
> > > > +      If present, the timer interrupt can wake up the CPU from
> > > > +      suspend/idle state.
> > >
> > > Isn't this a property of a timer, not CPU? IOW, your timer node should
> > > have "wakeup-source" property.
> > >
> >
> > I agree on the concept that this is property of the timer and not CPU.
> > However we generally don't need to use wakeup-source property for timer
> > as we ideally use this for waking up from system sleep state and we don't
> > want to be running timer when we enter the state.
> 
> It seems ARM is using two separate timer DT properties: one for
> system suspend (i.e. arm,no-tick-in-suspend) and another for CPU
> system (i.e. always-on). Is this understanding correct ?
>

TBH, I hadn't looked at "arm,no-tick-in-suspend" before though it seem to
be there for few years now. Based on the log, I see this as quirk for some
platform and not used on many platforms. Ideally to account how much time
was spent in suspend, we could use the counter as it continues to tick
during the suspend as well i.e. just the timers are not available if
not always. This was added to handle systems that are not conformant to
the expectation of always available counter.

-- 
Regards,
Sudeep
