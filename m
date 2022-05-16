Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62252831B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiEPLX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243099AbiEPLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:23:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DBF387A2;
        Mon, 16 May 2022 04:23:49 -0700 (PDT)
Date:   Mon, 16 May 2022 13:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652700228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5NxAJPVWcMi6gSub2SnJmtVeydspv2dOKKX4Sgbo2E=;
        b=lJ/ua/xT36CFkqAG2YmuUJzsMegjfmmNTNqFT+fjWUS0gy0CFATLEgN6pymWdJzZRXx+c2
        +2tnuSQnhzScgw8CD400ykPzDIZ34DTelPol+ky2h5ZdINhBstvnNH2N6Xwral/bK94Srw
        GcE97KmJQRokY9lLjkxkE0MajKpJCpKkpsFmmNGZLC0M4eGr2JrDlIkWq+IUovdVExg15j
        ngczzWRkxsTGvHYwzULb4NfvLr1Zvc1S1egZzwo3HBfWnvIZhMwtnLjGw44Udvu5b7unJQ
        2rRFDnGD6COThS/URwcxwBvcZchfuCohtpzk9klqe6WeAdWfuiCwwSPp0C+O9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652700228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5NxAJPVWcMi6gSub2SnJmtVeydspv2dOKKX4Sgbo2E=;
        b=54/Hu5OcF7w+aG2PdqmJIRu09tvXTti1VbEvmiab9M9zPRjw3PZQbf8xF5NEXBPzJfk2jw
        5Mtg5wpN0Ua/JmBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Gross <markgross@kernel.org>, Michael Buesch <m@bues.ch>,
        Rafa?? Mi??ecki <zajec5@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [RFC PATCH] genirq: Provide generic_handle_domain_irq_safe().
Message-ID: <YoI0QiM4ntJP/9fQ@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
 <20220516101814.GA18490@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220516101814.GA18490@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-16 12:18:14 [+0200], Lukas Wunner wrote:
> On Mon, May 09, 2022 at 04:04:08PM +0200, Sebastian Andrzej Siewior wrote:
> > The problem with generic_handle_domain_irq() is that with `threadirqs'
> > it will trigger "WARN_ON_ONCE(!in_hardirq())".
> 
> Now silenced by:
> https://git.kernel.org/linus/792ea6a074ae
> 
> 
> > +int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq)
> > +{
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	local_irq_save(flags);
> > +	ret = handle_irq_desc(irq_resolve_mapping(domain, hwirq));
> > +	local_irq_restore(flags);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(generic_handle_domain_irq_safe);
> 
> AFAICS you don't need to disable hardirqs at least for the "threadirqs"
> case because irq_forced_thread_fn() already does that.

PREEMPT_RT does not disable interrupts. Also completions in softirq
won't disable interrupts.

> 
> >  drivers/bcma/driver_gpio.c                 |  2 +-
> >  drivers/gpio/gpio-mlxbf2.c                 |  6 ++----
> >  drivers/pinctrl/pinctrl-amd.c              |  2 +-
> >  drivers/platform/x86/intel/int0002_vgpio.c |  3 +--
> >  drivers/ssb/driver_gpio.c                  |  6 ++++--
> 
> From a quick look, the proper solution for all of those drivers is
> probably to just add IRQF_NO_THREAD and be done with it.

I think I mentioned that part in the commit description: IRQF_NO_THREAD
must be specified by all handlers of a shared interrupt. It is an option
for the handler that owns an interrupt exclusive.

> Thanks,
> 
> Lukas

Sebastian
