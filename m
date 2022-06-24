Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773155998D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiFXMQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiFXMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:15:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7B6802F;
        Fri, 24 Jun 2022 05:14:14 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D836E0011;
        Fri, 24 Jun 2022 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656072853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8YHbVeqUO9nBhg4jGFDepGndFo7k3NShS8ZLBtA3Ps=;
        b=RbjP6/YetP5HPhGNompMgF/70JE2/dj7etwQ6IkjkkDRXaK6GFBbNiKtG6lhkth3uyfVq9
        6v8XGzs+S0FR7iouuzqsroXcwndPhXesox3rQtF7Kuoqjb5j98oKi3uN58w8y20W7FWeYq
        WOTpPXICYYDwGaUfmuypRHvwOGkUEHByGLoZcdXN93HIjpxcWcZciuooPmhT3TSikNT6PJ
        JDllECBzDE7Azp3i7k4VUAGv1tSke/iUbrGS6djjotq5xlgKwByvKr7BrPk0QR/8AlFAAL
        OFwXRcyqqiv0RXHBJIXLvQDCOCr0pwODIlArlVP7aDD7RzW4ZH8ecXLPmm6ceQ==
Date:   Fri, 24 Jun 2022 14:13:20 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2]  of: create of_root if no dtb provided
Message-ID: <20220624141320.3c473605@fixe.home>
In-Reply-To: <20220624034327.2542112-2-frowand.list@gmail.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
        <20220624034327.2542112-2-frowand.list@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 23 Jun 2022 22:43:26 -0500,
frowand.list@gmail.com a =C3=A9crit :

> =20
> +/*
> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
> + * scripts/Makefile.lib
> + */
> +extern void *__dtb_empty_root_begin;
> +
>  /*
>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>   * @limit: maximum entries
> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
>   */
>  void __init unflatten_device_tree(void)
>  {

Hi Frank,

This function is only defined when CONFIG_OF_EARLY_FLATTREE is enabled.
Which means that on platforms that do not select this, the default
empty device-tree creation will not be done.

This configuration option is selected by the platform and not by the
user. On x86, only one config enables this (X86_INTEL_CE) which means
this won't work on all the other platforms even if CONFIG_OF is
selected. I would need this to work by only selected CONFIG_OF.
That's why I decided to add the of_root creation in of_core_init()
using a function (of_fdt_unflatten()) that is provided if CONFIG_OF is
defined.

> -	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
> +	if (!initial_boot_params) {
> +		initial_boot_params =3D (void *) __dtb_empty_root_begin;
> +		unflatten_and_copy_device_tree();
> +	} else {
> +		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>  				early_init_dt_alloc_memory_arch, false);
> +	}
> =20
>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
>  	of_alias_scan(early_init_dt_alloc_memory_arch);
> @@ -1373,6 +1384,12 @@ void __init unflatten_and_copy_device_tree(void)
>  	unflatten_device_tree();
>  }
> =20
> +void __init setup_of(void)
> +{
> +	if (!of_root)
> +		unflatten_device_tree();
> +}
> +
>  #ifdef CONFIG_SYSFS
>  static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *bin_attr,
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index d69ad5bb1eb1..4566876db351 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const void =
*default_match,
>  /* Other Prototypes */
>  extern void unflatten_device_tree(void);
>  extern void unflatten_and_copy_device_tree(void);
> +extern void setup_of(void);
>  extern void early_init_devtree(void *);
>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>  #else /* CONFIG_OF_EARLY_FLATTREE */
> @@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void) {}
>  static inline const char *of_flat_dt_get_machine_name(void) { return NUL=
L; }
>  static inline void unflatten_device_tree(void) {}
>  static inline void unflatten_and_copy_device_tree(void) {}
> +static inline void of_setup(void) {}

Shouldn't this be setup_of(void) ?

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
