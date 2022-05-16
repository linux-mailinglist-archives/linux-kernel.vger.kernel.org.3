Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C6527DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbiEPGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiEPGxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:53:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA73F3668F;
        Sun, 15 May 2022 23:53:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652684010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyYJ2WHlWTrl9zB33+sqWxQ7FgI0MyBHjDAy808aYx8=;
        b=VTJBnR9iJS2UcJSlk6vOxJB5Z+F1wXmL2BSt3bi+/m/fTunsd0N2musDc+wyIw7iEtIc6S
        Kkt605axNOMj6SoBBCi73glx0dktXc4wrr/ZpdBuPmrkjDdKgbSRn9c39Lzs3YOlGTIr4m
        0YkEprbzBLIqZP1Isca4jQ2Vbj4CNovb+K/lxA5upQ59svtO4PhHZL19qMU8g4YN3stAJ4
        TDz25KDHPNEw0bTEenbtblaVhtlXXf7rfZGlz6bAsZZ49LE2/sM/jJ/JKtFAYGGrsmV6me
        7Ygj/bc8Ov+uMHfr8Gj0M12IA441dXgMfciE8Aeb8+oqsxCsaj5dSEZ6Q7YOdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652684010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyYJ2WHlWTrl9zB33+sqWxQ7FgI0MyBHjDAy808aYx8=;
        b=QGKny6r7vUJkTs0dbB1OhnBXWVoMca0t7FKqSIteEyXJZQqpjd4Ibew8D6KO8YK231kcJW
        oF+f95CUYPwVDeDA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] genirq: Deduplicate WARN_ON_ONCE() in
 generic_handle_domain_irq()
In-Reply-To: <YoHvXpo8PJUDbs08@linutronix.de>
References: <c3caf60bfa78e5fdbdf483096b7174da65d1813a.1652168866.git.lukas@wunner.de>
 <YoHvXpo8PJUDbs08@linutronix.de>
Date:   Mon, 16 May 2022 08:53:29 +0200
Message-ID: <87ilq6q87q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16 2022 at 08:29, Sebastian Andrzej Siewior wrote:

> On 2022-05-10 09:56:05 [+0200], Lukas Wunner wrote:
>> An example for irqchips where the warning is false positive are
>> USB-attached GPIO controllers such as drivers/gpio/gpio-dln2.c:
>
> They are not false positives because=E2=80=A6
>
>> USB gadgets are incapable of directly signaling an interrupt because
>> they cannot initiate a bus transaction by themselves.  All communication
>> on the bus is initiated by the host controller, which polls a gadget's
>> Interrupt Endpoint in regular intervals.  If an interrupt is pending,
>> that information is passed up the stack in softirq context, from which
>> a hardirq is synthesized via generic_handle_domain_irq().
>
> they tell you that the context is wrong.

Why? These handlers can be called from any context, really. Yes. They
need to be called with interrupts disabled, but that's it. The warning
is checking hard interrupt context unconditionally.

> From looking at gpio-dln2 this is called from USB URB's callback which
> is softirq. In the end dln2_gpio_event() is invoked while
> dln2_dev::event_cb_lock is acquired.  That lock is acquired by
> disabling interrupts which is what gets the locking right for
> generic_handle_domain_irq(). If that lock lifted to spin_lock_bh()
> (because it is always in urb's calback context and all HCDs complete
> in one context unlike now) then this breaks.

Yes, but that's a different problem.

> And PREEMPT_RT is broken already. Therefore, last week, I've been
> promoting generic_handle_domain_irq_safe()
> https://lkml.kernel.org/r/YnkfWFzvusFFktSt@linutronix.de

Well, that's just a wrapper which adds the local_irq_save(), so it's not
any different from having the local_irq_save() at the callsite, unless
I'm missing something.

Thanks,

        tglx
