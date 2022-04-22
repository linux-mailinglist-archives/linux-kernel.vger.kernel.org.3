Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8350BAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449042AbiDVO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449080AbiDVO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182CC5C87D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:56:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650639387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yeO7DB/oOdZiE5YWbOfjg8Pxdhh85gWuIsOq1Wgec1w=;
        b=yAkNhORuwRA0vCkGQ5lKnhlYDhJjnaqjPGowwq3uqTmK8KvetIzZWoXWNo5H4914SRrOXI
        6Y67ttATBwOnFttY/DaIyaJw4VQghgL/kEQjfjEPfxePgSljVurZrWBM8zov5T4QALRDjd
        9CtP7gmEzYXv7oU9El41VxogjuI/D52/QRv0T9zHIaMrt5nJK93pmAXkUufe8I6f7pA5+t
        wGcfQ3HW+XmlACHBjESFr3qPyCvmFFibk/xbD5D55Gkwil37SzQQJzwbN+G71L2WCxsALV
        dAZMR+OsWLc82wjDlNeB1cyx76ooxJb4zH26hOQqjTVkhfw1l9izIKqzDPxElA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650639387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yeO7DB/oOdZiE5YWbOfjg8Pxdhh85gWuIsOq1Wgec1w=;
        b=pbX00wnHWFBeWEQwToFkdzn2dZAsMpSlsXcZZWK42rB4fM0DI8EfoHH6HgWMhZHvTPgL2E
        RsgBuCxAU7Fdw1Bw==
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        joel@jms.id.au, arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
In-Reply-To: <20220421192132.109954-5-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-5-nick.hawkins@hpe.com>
Date:   Fri, 22 Apr 2022 16:56:26 +0200
Message-ID: <87o80t5fqd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21 2022 at 14:21, nick hawkins wrote:
> +
> +static struct gxp_timer *local_gxp_timer;

What is local about that time?

> +static void __iomem *system_clock __read_mostly;

__ro_after_init perhaps?

> +static inline struct gxp_timer *to_gxp_timer(struct clock_event_device *evt_dev)
> +{
> +	return container_of(evt_dev, struct gxp_timer, evt);
> +}
> +
> +static u64 notrace gxp_sched_read(void)
> +{
> +	return readl_relaxed(system_clock);
> +}
> +
> +static int gxp_time_set_next_event(unsigned long event,	struct clock_event_device *evt_dev)

Stray TAB in arguments

> +static int __init gxp_timer_init(struct device_node *node)
> +{
> +	void __iomem *base;
> +	struct clk *clk;
> +	u32 freq;
> +	int ret, irq;
> +	struct gxp_timer *gxp_timer;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("Can't remap timer base register");
> +		ret = -ENXIO;
> +		return ret;
> +	}
> +
> +	/*Set the offset to the clock register*/
> +	system_clock = base + GXP_TIMESTAMP_OFS;
> +
> +	clk = of_clk_get(node, 0);
> +	if (IS_ERR(clk)) {
> +		pr_err("%pOFn clock not found: %d\n", node, (int)PTR_ERR(clk));
> +		ret = -EIO;
> +		goto err_iounmap;
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +
> +	freq = clk_get_rate(clk);
> +
> +	sched_clock_register(gxp_sched_read, 32, freq);
> +	clocksource_mmio_init(system_clock, node->name, freq,
> +			      300, 32, clocksource_mmio_readl_up);

So this registers sched clock and clocksource and if one of the
following fails....

> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0) {
> +		ret = -EINVAL;
> +		pr_err("GXP Timer Can't parse IRQ %d", irq);
> +		goto err_iounmap;

... the error path unmaps 'system_clock'

> +	}
> +
> +	gxp_timer = kzalloc(sizeof(*gxp_timer), GFP_KERNEL);
> +	if (!gxp_timer) {
> +		ret = -ENOMEM;
> +		goto err_iounmap;
> +	}
> +
> +	gxp_timer->counter = base + GXP_TIMER_CNT_OFS;
> +	gxp_timer->control = base + GXP_TIMER_CTRL_OFS;
> +	gxp_timer->evt.name = node->name;
> +	gxp_timer->evt.rating = 300;
> +	gxp_timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	gxp_timer->evt.set_next_event = gxp_time_set_next_event;
> +	gxp_timer->evt.cpumask = cpumask_of(0);
> +
> +	local_gxp_timer = gxp_timer;
> +
> +	ret = request_irq(irq, gxp_timer_interrupt, IRQF_TIMER | IRQF_SHARED,
> +			  node->name, gxp_timer);
> +	if (ret) {
> +		pr_err("%s: request_irq() failed %pe\n", "GXP Timer Tick", ERR_PTR(ret));
> +		goto err_iounmap;

... and here as a bonus leaks gxp_timer.

> +	}
> +
> +	clockevents_config_and_register(&gxp_timer->evt, TIMER0_FREQ,
> +					0xf, 0xffffffff);
> +
> +	pr_debug("gxp: system timer (irq = %d)\n", irq);
> +	return 0;
> +
> +err_iounmap:
> +	iounmap(system_clock);
> +	iounmap(base);
> +	return ret;
> +}

Thanks,

        tglx
