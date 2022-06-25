Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49655A8AD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiFYKFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFYKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:05:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A7393F0;
        Sat, 25 Jun 2022 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656151509; x=1687687509;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=64n5WIu3m8ECq0hcL/3ZwPIajMr/prijxDfl5xl4iOM=;
  b=Jgy6u09kHvfXmoQqjJ7VMZLPqCn6YY21qIxcXNX5HO6Bw2dNVAeRO/hC
   B/i341aLux3JMujpC4x9oYVTvkWz+EKUpLDwo2RTHcfeWiOZN5X2N4cDp
   wnXQJHYkmrYJBgTsVVDT8ztwRn+9p1rXLJ8epK30ixKXogLhOlorjW6gu
   IY/Aek4BQhXxcHQP3xOordIIF863WL0UHBwLWzg9mACF4ZiFj+NsgTOlk
   5OEleYskauskTjkIW6tL9bxVBHh5Vh2MFb05k2PtZXICFxmuqORQNLvGb
   1pPXcdmlZLi1RNW8B3fP41wF+XV7ZHg5iASHXpkIDz6tfWHvnIs5toHbm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="367486979"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="367486979"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:05:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645645813"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:05:05 -0700
Date:   Sat, 25 Jun 2022 13:05:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 4/8] serial: core: sanitize RS485 delays read from device
 tree
In-Reply-To: <20220622154659.8710-5-LinoSanfilippo@gmx.de>
Message-ID: <5d406271-3290-f321-5984-bbc1f9a3bd96@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> When setting the RS485 configuration from userspace via TIOCSRS485 the
> delays are clamped to 100ms. Make this consistent with the values passed
> in by means of device tree parameters.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index fa6acadd7d0c..2e9f90e73e62 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3382,6 +3382,8 @@ int uart_get_rs485_mode(struct uart_port *port)
>  		rs485conf->delay_rts_after_send = 0;
>  	}
>  
> +	uart_sanitize_serial_rs485_delays(port, rs485conf);
> +
>  	/*
>  	 * Clear full-duplex and enabled flags, set RTS polarity to active high
>  	 * to get to a defined state with the following properties:
> -- 
> 2.36.1

While above works, if we go to this change user-visible behavior route, 
uart_get_rs485_mode() could just call full uart_sanitize_serial_rs485()?

The sanitization is currently being done during probe in 
uart_rs485_config() which has another challenge to tackle. The RS485 
supporting UART drivers are not consistently calling it during their 
probe(), only a few of them do but it would make more sense if all of them 
would enter into RS485 mode w/  linux,rs485-enabled-at-boot-time being 
set. However, making such change might run afoul with the expectations of 
users.


-- 
 i.

