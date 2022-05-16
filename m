Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403475281A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiEPKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiEPKSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:18:16 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E0DE97;
        Mon, 16 May 2022 03:18:16 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id EB3D4300002A8;
        Mon, 16 May 2022 12:18:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DF4F129FE74; Mon, 16 May 2022 12:18:14 +0200 (CEST)
Date:   Mon, 16 May 2022 12:18:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20220516101814.GA18490@wunner.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:04:08PM +0200, Sebastian Andrzej Siewior wrote:
> The problem with generic_handle_domain_irq() is that with `threadirqs'
> it will trigger "WARN_ON_ONCE(!in_hardirq())".

Now silenced by:
https://git.kernel.org/linus/792ea6a074ae


> +int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	local_irq_save(flags);
> +	ret = handle_irq_desc(irq_resolve_mapping(domain, hwirq));
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(generic_handle_domain_irq_safe);

AFAICS you don't need to disable hardirqs at least for the "threadirqs"
case because irq_forced_thread_fn() already does that.


>  drivers/bcma/driver_gpio.c                 |  2 +-
>  drivers/gpio/gpio-mlxbf2.c                 |  6 ++----
>  drivers/pinctrl/pinctrl-amd.c              |  2 +-
>  drivers/platform/x86/intel/int0002_vgpio.c |  3 +--
>  drivers/ssb/driver_gpio.c                  |  6 ++++--

From a quick look, the proper solution for all of those drivers is
probably to just add IRQF_NO_THREAD and be done with it.

Thanks,

Lukas
