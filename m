Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD951FDB6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiEINQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiEINQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:16:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1B1AF8C3;
        Mon,  9 May 2022 06:12:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652101973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBspkfCOiP10g+5drPmJg2fsEO9rzBTC2dvAOh7cjPw=;
        b=kbHC1p6RRwZ/BL4jPEXFzwHYmjXokSL+uS3cwwordw1EJV6wNjIGQPREMrngqZUm8qHdwV
        Yprr9120crP5C2G9QFQtp4xTRYus4VgivOnIfP0v1LdQe7hcYRwElLMb0JYFa2YjZcweGt
        Afw5OzTdqT2yxN9FHXGeK2vVPtz6hG0CzOZkw6XYnSNcHUVM/fPKFeANoOtDgILzwj/Gy/
        Fjx3ScPzRkCJquINskW2r2WqrYQO5Yg6ORmSwupnfjmr8ImdWUFR4Z6KUoYi7OVsoT/tUH
        U9irj/6W/4qicC44sXMkY/LG0wMR5iFgI5alXKj2aFseBiunMELtbF5bRFZK6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652101973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBspkfCOiP10g+5drPmJg2fsEO9rzBTC2dvAOh7cjPw=;
        b=Rq/x/sHbZy5rjclUvavUh0K3iWFJI4577Zfz96J+8/mfp7GtGy2EDV7p9Y8N0aZztlpsZR
        IEiFHShk1a3pk4CQ==
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
Date:   Mon, 09 May 2022 15:12:53 +0200
Message-ID: <87ilqergru.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09 2022 at 10:09, Marc Zyngier wrote:
> On Mon, 09 May 2022 09:54:21 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
>> 
>> On Fri, May 06, 2022 at 10:32:42PM +0200, Lukas Wunner wrote:
>> > On Tue, Oct 26, 2021 at 10:25:04AM +0100, Mark Rutland wrote:
>> > >  int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
>> > >  {
>> > > +	WARN_ON_ONCE(!in_irq());
>> > >  	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
>> > 
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
>
> I'd rather do something that allows these to be handled in the right
> context such as a self-IPI. This would certainly work for the GIC. No
> idea whether this is valid for x86, which is the other user.

We have to differentiate between interrupts which require hard interrupt
context due to constraints in the hardware, e.g. the horrors of affinity
changes on x86, and interrupts like the dln one which are synthetic. The
latter never go through the regular interrupt entry ASM muck.

Thanks,

        tglx
