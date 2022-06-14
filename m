Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9E54A9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352563AbiFNGtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352539AbiFNGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:49:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD539B87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:49:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1o10MR-00064H-N2; Tue, 14 Jun 2022 08:49:11 +0200
Message-ID: <22ce9497-563f-0855-bec2-c56d4ddcfffa@pengutronix.de>
Date:   Tue, 14 Jun 2022 08:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V3 1/2] mtd: allow getting MTD device associated with a
 specific DT node
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220611204651.19947-1-zajec5@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220611204651.19947-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafał,

On 11.06.22 22:46, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MTD subsystem API allows interacting with MTD devices (e.g. reading,
> writing, handling bad blocks). So far a random driver could get MTD
> device only by its name (get_mtd_device_nm()). This change allows
> getting them also by a DT node.
> 
> This API is required for drivers handling DT defined MTD partitions in a
> specific way (e.g. U-Boot (sub)partition with environment variables).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V3: First introduction of of_get_mtd_device_by_node()
> 
> mtd maintainers: please let know how would you like this patch
> processed. Would that be OK for you to Review/Ack it and let it go
> through NVMEM tree?
> ---
>  drivers/mtd/mtdcore.c   | 28 ++++++++++++++++++++++++++++
>  include/linux/mtd/mtd.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 9eb0680db312..7dc214271c85 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1154,6 +1154,34 @@ int __get_mtd_device(struct mtd_info *mtd)
>  }
>  EXPORT_SYMBOL_GPL(__get_mtd_device);
>  
> +/**
> + * of_get_mtd_device_by_node - obtain an MTD device associated with a given node
> + *
> + * @np: device tree node
> + */
> +struct mtd_info *of_get_mtd_device_by_node(struct device_node *np)
> +{
> +	struct mtd_info *mtd = NULL;
> +	struct mtd_info *tmp;
> +	int err;
> +
> +	mutex_lock(&mtd_table_mutex);
> +
> +	err = -ENODEV;

Shouldn't this be -EPROBE_DEFER? That way drivers making
use of this function can defer probe until the device
is probed.

> +	mtd_for_each_device(tmp) {
> +		if (mtd_get_of_node(tmp) == np) {
> +			mtd = tmp;
> +			err = __get_mtd_device(mtd);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&mtd_table_mutex);
> +
> +	return err ? ERR_PTR(err) : mtd;
> +}
> +EXPORT_SYMBOL_GPL(of_get_mtd_device_by_node);
> +
>  /**
>   *	get_mtd_device_nm - obtain a validated handle for an MTD device by
>   *	device name
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 955aee14b0f7..6fc841ceef31 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -677,6 +677,7 @@ extern int mtd_device_unregister(struct mtd_info *master);
>  extern struct mtd_info *get_mtd_device(struct mtd_info *mtd, int num);
>  extern int __get_mtd_device(struct mtd_info *mtd);
>  extern void __put_mtd_device(struct mtd_info *mtd);
> +extern struct mtd_info *of_get_mtd_device_by_node(struct device_node *np);
>  extern struct mtd_info *get_mtd_device_nm(const char *name);
>  extern void put_mtd_device(struct mtd_info *mtd);
>  


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
