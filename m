Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A73D527D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiEPG35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiEPG3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:29:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0F26AFE;
        Sun, 15 May 2022 23:29:54 -0700 (PDT)
Date:   Mon, 16 May 2022 08:29:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652682591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2Br0kGTz97gFRI4UoHpjTrAphLEpHX8G3A3EWdmkCo=;
        b=cil+zbCowMsn2/G+DxFU0NbmaeYTCghUfXe4n8ZAQNo4fW3GYLIaNYsUMp/eRH7tK6l9WH
        vEOt/i93dsLzwhNpl5F5TQXYXD8heNoAgrlQbJPDAAjM5DK/Uc+lKy3huZgajIMcJ3F5pv
        gXHqEt44ira47nMMMLsk1WVsUn8BLUo674UZBnsPZ19ZBWyixbexW14wZLpfe4wpUurCdh
        2fD4wF1uds3iOPY5yhql9e4RK6OjBFkrbeuXG9CIK/ygxTC52mExQnCIQUUKJj0SzqKW9+
        sJsq3QIhAXhOnuOY1hUBeTOel5rBnPBU1LlEC0TvW6P+FG448SFiTXwBt9CZag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652682591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2Br0kGTz97gFRI4UoHpjTrAphLEpHX8G3A3EWdmkCo=;
        b=h6Pg68+btj1eb0yWjhiNtumHNaV2y/bYZwna19lkebWnNIHB1My4fT5m4PtiVIBtfB/Byx
        b58Z8SaQXr+2pJCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] genirq: Deduplicate WARN_ON_ONCE() in
 generic_handle_domain_irq()
Message-ID: <YoHvXpo8PJUDbs08@linutronix.de>
References: <c3caf60bfa78e5fdbdf483096b7174da65d1813a.1652168866.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c3caf60bfa78e5fdbdf483096b7174da65d1813a.1652168866.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 09:56:05 [+0200], Lukas Wunner wrote:
> An example for irqchips where the warning is false positive are
> USB-attached GPIO controllers such as drivers/gpio/gpio-dln2.c:

They are not false positives because=E2=80=A6

> USB gadgets are incapable of directly signaling an interrupt because
> they cannot initiate a bus transaction by themselves.  All communication
> on the bus is initiated by the host controller, which polls a gadget's
> Interrupt Endpoint in regular intervals.  If an interrupt is pending,
> that information is passed up the stack in softirq context, from which
> a hardirq is synthesized via generic_handle_domain_irq().

they tell you that the context is wrong. From looking at gpio-dln2
this is called from USB URB's callback which is softirq. In the end
dln2_gpio_event() is invoked while dln2_dev::event_cb_lock is acquired.
That lock is acquired by disabling interrupts which is what gets the
locking right for generic_handle_domain_irq(). If that lock lifted to
spin_lock_bh() (because it is always in urb's calback context and all
HCDs complete in one context unlike now) then this breaks. And
PREEMPT_RT is broken already. Therefore, last week, I've been promoting
generic_handle_domain_irq_safe()
   https://lkml.kernel.org/r/YnkfWFzvusFFktSt@linutronix.de

and sadly I missed dln2. Please let me know if you have more users
similar to dln2. I will add those to my list once upstream buys that
interface.

Sebastian
