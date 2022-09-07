Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D15B0040
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIGJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIGJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:21:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DBA86FE2;
        Wed,  7 Sep 2022 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662542482; x=1694078482;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0aD11024owXiWys0CYVqLXLWsO/hlSbQMpdnFQamO0s=;
  b=ijUB9cxMUP47lrbQe7vzijd2jl4I2q08vHG4+VIm7VLMqxt5rgmEAeYz
   +dCQz/yz8bfVr+WDm3ixZP3wn6o+aDTqIFJQ/CDKC/qWMh3ucpceKZ973
   Of7Dwy9jOdxj17CurQAQJ+di9zmPYQ8tHWhhcIUfkAEjx55pFoh4fqmLQ
   8X4mzI6L2s1tyqCxugwYShJ2nXxJ7cjVXRyl+6WehcJdVMC2FAknSaFBA
   N4O9QPE/ttUUp50aBI8KN5DHMjhEsN1MuYannBMhHrI9/tZ87N0QFh3gw
   jItJ4XR85Js4l8RJc+VepuUjEDngDRBTQuWRZKDoY2uoXzXy6uTrRoG1T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276564373"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="276564373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:21:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676096363"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:21:13 -0700
Date:   Wed, 7 Sep 2022 12:21:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 08/13] tty: serial: atmel: Define GCLK as USART baudrate
 source clock
In-Reply-To: <20220906135511.144725-9-sergiu.moga@microchip.com>
Message-ID: <5d3e3a73-8b13-fb23-a32c-565046ec3c27@linux.intel.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com> <20220906135511.144725-9-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022, Sergiu Moga wrote:

> Define the bit that represents the choice of having GCLK as a baudrate
> source clock inside the USCLKS bitmask of the Mode Register of
> USART IP's.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before
> 
> 
> 
>  drivers/tty/serial/atmel_serial.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
> index 0d8a0f9cc5c3..70d0611e56fd 100644
> --- a/drivers/tty/serial/atmel_serial.h
> +++ b/drivers/tty/serial/atmel_serial.h
> @@ -49,6 +49,7 @@
>  #define	ATMEL_US_USCLKS		GENMASK(5, 4)	/* Clock Selection */
>  #define		ATMEL_US_USCLKS_MCK		(0 <<  4)
>  #define		ATMEL_US_USCLKS_MCK_DIV8	(1 <<  4)
> +#define		ATMEL_US_USCLKS_GCLK		(2 <<  4)

This would be FIELD_PREP(ATMEL_US_USCLKS, 2) from linux/bitfield.h.

They should all be converted to use FIELD_PREP(), IMHO (in a separate 
patch).

>  #define		ATMEL_US_USCLKS_SCK		(3 <<  4)
>  #define	ATMEL_US_CHRL		GENMASK(7, 6)	/* Character Length */
>  #define		ATMEL_US_CHRL_5			(0 <<  6)
> 

-- 
 i.

