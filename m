Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C12527DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbiEPHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiEPHCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:02:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE47DFB4;
        Mon, 16 May 2022 00:02:17 -0700 (PDT)
Date:   Mon, 16 May 2022 09:02:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652684536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BY9zh6DOrpPC4lvvoU6noyY6hJNaHrB0bXgQylzFWy4=;
        b=ZrbqpuwRnBT0ZUoj0KOZ9rUG5s/eSHc2X7vWVgdWAYz64FsT+7H39/Hs5LlYKtmTwNbUll
        KJu23dsoxM2n1tSjTjdrFssVcsltxvgq2IkFxCpRY35gdjHKtY9zQGZr7+YftlC+PYoOum
        ef5E6+TFyilHqZGHbiAJ7Aft0oNllM869RiVA3Eb9WGp1rVjFtzAo6hZxJ0nkU9RNNc5pY
        FmY+ycGzw7y4nBR+lL64otOm6cjXlZMQr6W5y3Q9RFC1/fdHmxGRqJNbkuJRRwqj0DWrwO
        jcfp1Ho52Mu+eTZbFLuJYYYIWp02kClFY546p6Hn0gqzWayVgI5E1ALNkjw0aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652684536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BY9zh6DOrpPC4lvvoU6noyY6hJNaHrB0bXgQylzFWy4=;
        b=saDiQLX5+7hZtOFNtF0yoT5muAi7lnc7HHnBOVrvm7pjL3t42BNr+IcmX0xVofgt0DSsNw
        LG7hXX7i1663uWAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lukas Wunner <lukas@wunner.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] genirq: Deduplicate WARN_ON_ONCE() in
 generic_handle_domain_irq()
Message-ID: <YoH29u6kNTXF/0Ew@linutronix.de>
References: <c3caf60bfa78e5fdbdf483096b7174da65d1813a.1652168866.git.lukas@wunner.de>
 <YoHvXpo8PJUDbs08@linutronix.de>
 <87ilq6q87q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ilq6q87q.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-16 08:53:29 [+0200], Thomas Gleixner wrote:
> > they tell you that the context is wrong.
> 
> Why? These handlers can be called from any context, really. Yes. They
> need to be called with interrupts disabled, but that's it. The warning
> is checking hard interrupt context unconditionally.

correct. If the context is wrong, the interrupts are usually not
disabled.

> > From looking at gpio-dln2 this is called from USB URB's callback which
> > is softirq. In the end dln2_gpio_event() is invoked while
> > dln2_dev::event_cb_lock is acquired.  That lock is acquired by
> > disabling interrupts which is what gets the locking right for
> > generic_handle_domain_irq(). If that lock lifted to spin_lock_bh()
> > (because it is always in urb's calback context and all HCDs complete
> > in one context unlike now) then this breaks.
> 
> Yes, but that's a different problem.
> 
> > And PREEMPT_RT is broken already. Therefore, last week, I've been
> > promoting generic_handle_domain_irq_safe()
> > https://lkml.kernel.org/r/YnkfWFzvusFFktSt@linutronix.de
> 
> Well, that's just a wrapper which adds the local_irq_save(), so it's not
> any different from having the local_irq_save() at the callsite, unless
> I'm missing something.

I haven't seen a local_irq_save() at the callsite. If it is, then it is
not any different.

> Thanks,
> 
>         tglx

Sebastian
