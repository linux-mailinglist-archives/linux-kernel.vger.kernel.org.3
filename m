Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1E55F9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiF2H7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiF2H73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:59:29 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF338DAB;
        Wed, 29 Jun 2022 00:59:26 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 0643FE000A;
        Wed, 29 Jun 2022 07:59:23 +0000 (UTC)
Date:   Wed, 29 Jun 2022 09:59:22 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] media: ov5693: count num_supplies using array_size
Message-ID: <20220629075922.qihwbmxzolra2fkd@uno.localdomain>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-2-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627150453.220292-2-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso

On Mon, Jun 27, 2022 at 05:04:47PM +0200, Tommaso Merciai wrote:
> Instead of hardcode OV5693_NUM_SUPPLIES in a define is better use
> ARRAY_SIZE function to count the number of supplies from
> ov5693_supply_names array
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

thanks
  j

> ---
>  drivers/media/i2c/ov5693.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index 117ff5403312..f410333c4c67 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -127,11 +127,15 @@
>  #define OV5693_LINK_FREQ_419_2MHZ		419200000
>  #define OV5693_PIXEL_RATE			167680000
>
> -/* Miscellaneous */
> -#define OV5693_NUM_SUPPLIES			2
> -
>  #define to_ov5693_sensor(x) container_of(x, struct ov5693_device, sd)
>
> +static const char * const ov5693_supply_names[] = {
> +	"avdd",		/* Analog power */
> +	"dovdd",	/* Digital I/O power */
> +};
> +
> +#define OV5693_NUM_SUPPLIES	ARRAY_SIZE(ov5693_supply_names)
> +
>  struct ov5693_reg {
>  	u32 reg;
>  	u8 val;
> @@ -352,11 +356,6 @@ static const s64 link_freq_menu_items[] = {
>  	OV5693_LINK_FREQ_419_2MHZ
>  };
>
> -static const char * const ov5693_supply_names[] = {
> -	"avdd",
> -	"dovdd",
> -};
> -
>  static const char * const ov5693_test_pattern_menu[] = {
>  	"Disabled",
>  	"Random Data",
> --
> 2.25.1
>
