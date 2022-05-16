Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0991528171
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiEPKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbiEPKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:05:37 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C1C5F8F;
        Mon, 16 May 2022 03:04:45 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E5918300002A8;
        Mon, 16 May 2022 12:04:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D9D7925050A; Mon, 16 May 2022 12:04:43 +0200 (CEST)
Date:   Mon, 16 May 2022 12:04:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20220516100443.GA13963@wunner.de>
References: <c3caf60bfa78e5fdbdf483096b7174da65d1813a.1652168866.git.lukas@wunner.de>
 <YoHvXpo8PJUDbs08@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoHvXpo8PJUDbs08@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:29:50AM +0200, Sebastian Andrzej Siewior wrote:
> From looking at gpio-dln2
> this is called from USB URB's callback which is softirq. In the end
> dln2_gpio_event() is invoked while dln2_dev::event_cb_lock is acquired.
> That lock is acquired by disabling interrupts which is what gets the
> locking right for generic_handle_domain_irq(). If that lock lifted to
> spin_lock_bh() (because it is always in urb's calback context and all
> HCDs complete in one context unlike now) then this breaks.

I think you want WARN_ON(!irqs_disabled) to catch that,
not WARN_ON_ONCE(!in_hardirq()).


> and sadly I missed dln2. Please let me know if you have more users
> similar to dln2. I will add those to my list once upstream buys that
> interface.

There's another USB GPIO irqchip queued up for 5.19 now:
https://git.kernel.org/netdev/net-next/c/1ce8b37241ed

And there's one more in drivers/hid/hid-cp2112.c, but that calls
handle_nested_irq(), which disables hardirqs.

Thanks,

Lukas
