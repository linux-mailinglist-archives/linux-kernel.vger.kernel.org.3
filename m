Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A295A5E88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiH3Itr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiH3Itl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:49:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF98B99D2;
        Tue, 30 Aug 2022 01:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A77CFB81887;
        Tue, 30 Aug 2022 08:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9BBC433D7;
        Tue, 30 Aug 2022 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661849377;
        bh=y+1MMFa8GkCF5J8xOBa4wpAmNDUFKU7en8TBxW//a4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bf1YtPs307mo8lMrBvPJ8JYzsN4hPwgTGnjeruF2ZT+1HYnd27ANo4lCmBvYw6VuQ
         2XxLEk1UupnJaBo6WfhMPaUkQ7okqnaaO9IlK6tMeOhVGHNOJT8Nvn6H+iLkIHrqoI
         YzbnTxjGWzGZRSZHOSZBz4hrQkidgYl3DUpQ/ghA=
Date:   Tue, 30 Aug 2022 10:49:34 +0200
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
Message-ID: <Yw3PHg0imhJyb9sf@kroah.com>
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
> The struct serial_rs485 has a .padding field to make uapi updates
> easier. It wastes space, however. Create struct kserial_rs485 which is
> a kerner counterpart w/o padding.

"kernel"?

And what is the size difference now?

> +/**
> + * struct kserial_rs485 - kernel-side struct for controlling RS485 settings.
> + * @flags:			RS485 feature flags
> + * @delay_rts_before_send:	Delay before send (milliseconds)
> + * @delay_rts_after_send:	Delay after send (milliseconds)
> + * @addr_recv:			Receive filter for RS485 addressing mode
> + *				(used only when %SER_RS485_ADDR_RECV is set).
> + * @addr_dest:			Destination address for RS485 addressing mode
> + *				(used only when %SER_RS485_ADDR_DEST is set).
> + *
> + * Must match with struct serial_rs485 in include/uapi/linux/serial.h excluding
> + * the padding.

Why must this match?  And how is that going to be enforced?

> + */
> +struct kserial_rs485 {
> +	__u32	flags;
> +	__u32	delay_rts_before_send;
> +	__u32	delay_rts_after_send;
> +	struct {
> +		__u8    addr_recv;
> +		__u8    addr_dest;
> +	};

As this is an in-kernel structure, this should be "u32" and "u8" now.

thanks,

greg k-h
