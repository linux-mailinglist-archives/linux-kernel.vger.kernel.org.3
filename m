Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544A452284D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiEKAM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiEKAL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:11:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60339DA8;
        Tue, 10 May 2022 17:11:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652227913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LNuHk31MU8NfbUkWhTQWEmIsDRSnnMCHcYTmT8fO/lY=;
        b=EuVQqWjL/KUqB/CW2WZnKUENdoV3TuMemWSLrLHG/zjCnV2kJitekfdllmCrXeRBHAgkJl
        N9VGxaJCPGSLpEX+u6uP4cm9q+FXGP6kAIXyis97mVl9efUDKvqZudiBjyKHmvGVyVc331
        43Fg5Q+fRfE0e3IaLyJPZ0p5wt2T9HRbzYztEW/EhAMaYQDSHLlFfjW7EOykBDmmYsJ8DQ
        dJXQBxEOYamLScb9r7J3jtrV3iKhhBZGCJlbcWi+8Nknu81VMZ4fSewlMvNj0p0Nuo45ky
        gF9fFsq4IivHfX7IPAFsf8L3pw769T3RIzGmQ1C3rUDE9HHCwuhzA0bbqbp6rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652227913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LNuHk31MU8NfbUkWhTQWEmIsDRSnnMCHcYTmT8fO/lY=;
        b=5etwy+oQ4vqvPZjT8W/1Hehtrb4Q311ZjDMAfdogHZdAvif7QwpoU5ASIW8mLslfRgL21+
        aAAQpQODQg29I9DA==
To:     Mark Rutland <mark.rutland@arm.com>, Lukas Wunner <lukas@wunner.de>
Cc:     maz@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@kernel.org, vladimir.murzin@arm.com, will@kernel.org
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
In-Reply-To: <Ynpzb5L53iGex14D@FVFF77S0Q05N>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de> <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <20220510121320.GA3020@wunner.de> <Ynpzb5L53iGex14D@FVFF77S0Q05N>
Date:   Wed, 11 May 2022 02:11:52 +0200
Message-ID: <874k1xorlj.ffs@tglx>
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

On Tue, May 10 2022 at 15:15, Mark Rutland wrote:
> On Tue, May 10, 2022 at 02:13:20PM +0200, Lukas Wunner wrote:
>> Actually, since you're mentioning the in_nmi() check, I suspect
>> there's another problem here:
>> 
>> generic_handle_domain_nmi() warns if !in_nmi(), then calls down 
>> to handle_irq_desc() which warns if !in_hardirq().  Doesn't this
>> cause a false-positive !in_hardirq() warning for a NMI on GIC/GICv3?
>
> I agree that doesn't look right.
>
>> The only driver calling request_nmi() or request_percpu_nmi() is
>> drivers/perf/arm_pmu.c.  So that's the only one affected.
>> You may want to test if that driver indeed exhibits such a
>> false-positive warning since c16816acd086.
>
> In testing with v5.18-rc5, I can't see that going wrong.
>
> I also hacked the following in:
>
> -------->8--------
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 939d21cd55c38..3c85608a8779f 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -718,6 +718,7 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
>  int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
>  {
>         WARN_ON_ONCE(!in_nmi());
> +       WARN_ON_ONCE(!in_hardirq());
>         return handle_irq_desc(irq_resolve_mapping(domain, hwirq));

which is pointless because NMI entry code has to invoke [__]nmi_enter()
before invoking this function. [__]nmi_enter() does:

    __preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);

So it's more than bloody obvious why there is no warning triggered for a
regular hardware induced NMI invocation.

For a software invocation from the wrong context it does not matter how
many redundant WARN_ONs you add. The existing ones are covering it
nicely already.

Thanks,

        tglx
