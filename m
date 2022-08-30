Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A895A5EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiH3IxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiH3Iwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:52:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6AF9A967;
        Tue, 30 Aug 2022 01:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C35ABB81888;
        Tue, 30 Aug 2022 08:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE725C433D7;
        Tue, 30 Aug 2022 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661849542;
        bh=GfTk307VAPbulMgNaAUsMDt2ahKUcbPofgSTa8PhAiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyAjFc9HC2ltJIBwtejCLHGP0+sh4+HuJH4YfCl6P8VLxiBLSdh4bYf4KeN7al3lV
         5PLJQlBjMnWL25yCyRqMVhzRZ3gM02EAmzOaeMviC4al0M8ZWWAUGB8MNMawubTwtT
         eF2q9bnUCiff/VsE6cHX2ADN9bnv18PGyeNm8ssg=
Date:   Tue, 30 Aug 2022 10:52:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v2 4/4] serial: Add kserial_rs485 to avoid wasted space
 due to .padding
Message-ID: <Yw3Pw9kwDDKXuqC+@kroah.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
 <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:29:56AM +0300, Ilpo Järvinen wrote:
> -static int serial_rs485_from_user(struct serial_rs485 *rs485,
> +static int serial_rs485_from_user(struct kserial_rs485 *rs485,
>  				  const struct serial_rs485 __user *rs485_user)
>  {
> -	if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
> +	struct serial_rs485 rs485_uapi;
> +
> +	if (copy_from_user(&rs485_uapi, rs485_user, sizeof(*rs485)))
>  		return -EFAULT;
>  
> +	*rs485 = *((struct kserial_rs485 *)&rs485_uapi);

Ah, you are mapping this on top of the existing structure, so there was
no padding in the original one, why say that?

> +/*
> + * Compile-time asserts for struct kserial_rs485 and struct serial_rs485 equality
> + * (except padding).

This does not take into account any padding, in fact it's the opposite
as all of this:

> + */
> +static_assert(offsetof(struct kserial_rs485, flags) ==
> +	      offsetof(struct serial_rs485, flags));
> +static_assert(offsetof(struct kserial_rs485, delay_rts_before_send) ==
> +	      offsetof(struct serial_rs485, delay_rts_before_send));
> +static_assert(offsetof(struct kserial_rs485, delay_rts_after_send) ==
> +	      offsetof(struct serial_rs485, delay_rts_after_send));
> +static_assert(offsetof(struct kserial_rs485, addr_recv) ==
> +	      offsetof(struct serial_rs485, addr_recv));
> +static_assert(offsetof(struct kserial_rs485, addr_dest) ==
> +	      offsetof(struct serial_rs485, addr_dest));
> +static_assert(sizeof(struct kserial_rs485) <= sizeof(struct serial_rs485));

Is there to ensure that the offsets are exactly the same, no padding
involved anywhere.

So I don't understand the problem you are trying to solve here,

greg k-h
