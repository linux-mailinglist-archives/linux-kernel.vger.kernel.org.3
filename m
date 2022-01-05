Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB946484E78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiAEGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:50:05 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:40711 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbiAEGuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:50:02 -0500
Date:   Wed, 5 Jan 2022 07:49:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1641365400;
        bh=afrKCOqNubeiPYf4TQvcYsO4O7woEkun/NZnSzhJmB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSKMNX6/W1IBeitY5sfihEqq17clNJCbw7+sQUR87j5l6I4jTXj6cDC0bH0c6VYDD
         y2ce/0NzjWIsudlb+MMKJHRBrD4A/rJoOaIcafIKjuVDrvgukBt4IAnQG3JZiy05UR
         tEKDJ+sdPx5y6LT3BVX3VbJ2P/HMKLzWEmr214hw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: validate size of power_supply_attrs
 at compiletime
Message-ID: <5bbd9f31-f6b5-4554-958c-71ec9ebd0363@t-8ch.de>
References: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
 <20220105064239.2689-2-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105064239.2689-2-linux@weissschuh.net>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, Hans,

On 2022-01-05 07:42+0100, Thomas Weißschuh wrote:
> For each member of enum power_supply_property a matching entry in
> power_supply_attrs is needed.
> Add a basic test at compiletime to validate this in addition to the
> existing runtime testing.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 2 ++
>  include/linux/power_supply.h              | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 491ffec7bf47..2565052a7a8c 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -403,6 +403,8 @@ void power_supply_init_attrs(struct device_type *dev_type)
>  {
>  	int i;
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(power_supply_attrs) != __POWER_SUPPLY_PROP_CNT);
> +
>  	dev_type->groups = power_supply_attr_groups;
>  
>  	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 71f0379c2af8..60853f26e25f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -172,6 +172,8 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +
> +	__POWER_SUPPLY_PROP_CNT
>  };
>  
>  enum power_supply_type {
> -- 
> 2.34.1
> 

Please ignore this patch. It does not do what is tries to do. Sorry for the
noise.

Thomas
