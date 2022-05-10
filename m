Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178CB5227B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiEJXgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEJXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:36:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E526121;
        Tue, 10 May 2022 16:36:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652225775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/EYKbD+5m5rYtUrz9cU8ph/+xjuJsYLEKLmP4yizks=;
        b=Td0jh6UQTEdUYRd5xnaHNw8KSgjFmg4k8FSTVAaMadw81+zaBWQ1honj/GMlAoXcWJtq6o
        8WtVlmhVnMJUcJ+3ZFJZT/HuvbaGkgXgXpkOqYvWJn6bJEpAHPL8cFA/mXzRAqc15QkQ+V
        MpINp1sRCn8JHKegPRxjlhmce5H94xLcR1BsZ0TI3Z27hDK4Q9hAPyBAc3yST38VLP/m+W
        KmybeJK3EBvlbJe2V3CT+xFea/dh0T84L7k/J+sNwtAGwcNbg1UsdbVuh17vUmUvMSKZgP
        jwzPX5ryEapaebK7rRAXz8kD7xFpnnMSZP3hts7BT+yNwLRwagTkCi433Envrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652225775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/EYKbD+5m5rYtUrz9cU8ph/+xjuJsYLEKLmP4yizks=;
        b=/YfHHXkuqYRdWRMkvYVqBbEJaYYHN2qJOO5lbQ5LiAh5X/kNvBy4PxtPsKnSvZPQFqAflL
        qZ7ojYQ76UfcH0Aw==
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
In-Reply-To: <87h75z6pix.wl-maz@kernel.org>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de> <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <87h75z6pix.wl-maz@kernel.org>
Date:   Wed, 11 May 2022 01:36:15 +0200
Message-ID: <877d6tot8w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09 2022 at 10:09, Marc Zyngier wrote:
> On Mon, 09 May 2022 09:54:21 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
>> > Why isn't the WARN_ON_ONCE() conditional on handle_enforce_irqctx()?
>> > (See handle_irq_desc() and c16816acd086.)
>> 
>> I did this for consistency with the in_nmi() check in
>> generic_handle_domain_nmi(); I was unaware of commit c16816acd086 and
>> IRQD_HANDLE_ENFORCE_IRQCTX.
>> 
>> I'll have ot leave it to Marc and Thomas as to what we should do there.
>
> My preference would be to not introduce things that result in
> different behaviours for drivers, specially for things that are
> evidently cross-architecture such as USB drivers (which seems to be
> the case here).

No. USB drivers which synthesize their interrupts from a received packet
work perfectly fine on all architectures because the interrupt domain
and interrupt chip they are using are a software construct designed for
the purpose and have no hard interrupt context requirements.

The reason why this is done is to leverage the interrupt driven PHY
status changes instead of enforcing timer based polling. The charm is
that the phy code does not have to grow another wart and just uses the
offered synthetic interrupt. There are other places which do similar
things for the same reason. This also provides the beloved statistics in
/proc/interrupt, tracepoints etc. out of the box without having to add
extra muck into yet another subsystem.

> I'd rather do something that allows these to be handled in the right
> context such as a self-IPI. This would certainly work for the GIC. No
> idea whether this is valid for x86, which is the other user.

This interrupt is neither directly nor indirectly connected to GIC
or APIC. It's synthesized. So what would the self-IPI help?

And no, I don't want to create infrastructure to allocate a pseudo
device vector on x86 just to be able to self-IPI this USB synthesized
interrupt. That'd be yet another horrorshow and worse a horrorshow for
no reason and zero value.

IRQD_HANDLE_ENFORCE_IRQCTX was introduced to be able to differentiate
between interrupt chips which require a particular context and chips
which can handle it perfectly fine to have e.g. their software retrigger
handled by directly invoking the handler from an arbitrary context.

I wish this would be the case on x86. That would eliminate a boatload of
horrible code.

Thanks,

        tglx




