Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83951ED2A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiEHLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiEHLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 07:06:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81ADF1B
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 04:02:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652007754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7G+zUj54eBfyktDcZa4ZbAJ+odaEfrQMWJTCSbKdy3k=;
        b=iGAXFGuLvVo6RpqFLMh0I7GAsJs9x6RUuD0iLq6O3k1p1jaLIT1/Dnjl1o8u3Mk8My2mvO
        P3I5idFwbQ2uMmyBEghYRQAOJ52/jbcCUG9kpi7BDGQqqxgS1M4Knh2rfp1xSkGv2OqYup
        GSybEJMYYY+ieyrk1J32AG14PfLXRTU7sMUyHloRCtBoKES1lZXKjc32wqh6Md/fjKI1J0
        QuU6Fox4owf6UrYQzJCl0HXVDRAenF6AMq3e5Zl3mQ30S/jhXFddru6bjClYUnvmFI6WSI
        coRXikGGhJzUQfhprSwM/G20Usso5Oq7HnlArGepFuPbe4/8v7oJkBd1yISKTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652007754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7G+zUj54eBfyktDcZa4ZbAJ+odaEfrQMWJTCSbKdy3k=;
        b=fMm0K8kzoOwNve1dseEdxD4RAMHY82afC7BOqFI9E8ghspP/h/+mXruaz2MaO63rE24efU
        +7qpfIyUWZ8o00Aw==
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <ca6b70a2-9bcc-fb86-200c-e1714c9d53be@baylibre.com>
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
 <87pmktm2a9.fsf@jogness.linutronix.de>
 <87a6bwapij.fsf@jogness.linutronix.de>
 <87zgjvd2zb.fsf@jogness.linutronix.de>
 <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
 <ca6b70a2-9bcc-fb86-200c-e1714c9d53be@baylibre.com>
Date:   Sun, 08 May 2022 13:08:33 +0206
Message-ID: <871qx4qoc6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2022-05-06, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Thanks all for figuring out the issue, perhaps other uart drivers
> could fall in the same issue if startup code isn't protected with
> lock?

When preparing for the official patch submission [0], I needed quite a
bit of time to understand why another function (meson_uart_reset) should
not and cannot acquire the port->lock.

I then started investigating some other drivers and indeed I see lots of
potential problems. Any console initializing port->lock from the
driver's probe() is probably wrong (and there are lots of them). But as
I've learned with the meson driver, the details are subtle. Each driver
will need to be carefully evaluated to see if it is actually safe.

uart_ops->startup() is called without holding port->lock. If the device
is a console, it is already registered and printing.

driver->probe() is called without holding port->lock. If the device is a
console, it is already registered and printing.

For both functions, port->lock might not be initialized yet, so blindly
acquiring it is wrong.

Note that this is not related to the introduction of kthread printing.

I've put it on my TODO list to go through the ~76 console drivers to
investigate their startup() and probe() implementations. But I will not
be able to do this quickly. My time might be better spent writing to all
the maintainers asking them to please verify the usage.

John Ogness

[0] https://lore.kernel.org/lkml/20220508103547.626355-1-john.ogness@linutronix.de
