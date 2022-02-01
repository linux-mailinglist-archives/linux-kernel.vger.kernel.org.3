Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175EF4A58A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiBAImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiBAImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:42:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF25C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77DBA614E5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C882BC340EB;
        Tue,  1 Feb 2022 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643704890;
        bh=izwcm3CMYXMkkVXXOgnEHRhRx65+7KdZS5cc2E9mFiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK5mfW7setlJqHn2Ep2vNGz7IJkFUFZGr7LH0IfP/EqqL9VkHkK4nR1utWtzLQ1dk
         QFvFW5GR3U29trNqhNqYM/GT5B79QrZPbP9PSKwrsiO3P5KsRa7MOZAmn1FeqcYZSY
         zuBkH4LdCp3WYrSO85zJ5Zjaif2nFPjFiJxu5/s4=
Date:   Tue, 1 Feb 2022 09:41:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 2/2] ARM: aspeed: Add secure boot controller support
Message-ID: <YfjyNo5wBPs16vkz@kroah.com>
References: <20220201050501.182961-1-joel@jms.id.au>
 <20220201050501.182961-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201050501.182961-3-joel@jms.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 03:35:01PM +1030, Joel Stanley wrote:
> This reads out the status of the secure boot controller and exposes it
> in sysfs using the bootinfo sysfs api.
> 
> An example on a AST2600A3 QEMU model:
> 
>  # grep -r . /sys/firmware/bootinfo/*
>  /sys/firmware/bootinfo/abr_image:0
>  /sys/firmware/bootinfo/low_security_key:0
>  /sys/firmware/bootinfo/otp_protected:0
>  /sys/firmware/bootinfo/secure_boot:1
>  /sys/firmware/bootinfo/uart_boot:0
> 
> On boot the state of the system according to the secure boot controller
> will be printed:
> 
>  [    0.037634] AST2600 secure boot enabled
> 
> or
> 
>  [    0.037935] AST2600 secure boot disabled
> 
> The initialisation is changed from early_initcall to subsys_initcall
> because we need the firmware_kobj to be initialised, and because there's
> no requirement to print this information early.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/soc/aspeed/aspeed-socinfo.c | 84 ++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
> index 1ca140356a08..fe77b31e4d1d 100644
> --- a/drivers/soc/aspeed/aspeed-socinfo.c
> +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> @@ -8,6 +8,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
> +#include <linux/firmware_bootinfo.h>
> +
> +static u32 security_status;
>  
>  static struct {
>  	const char *name;
> @@ -74,6 +77,83 @@ static const char *siliconid_to_rev(u32 siliconid)
>  	return "??";
>  }
>  
> +#define SEC_STATUS		0x14
> +#define ABR_IMAGE_SOURCE	BIT(13)
> +#define OTP_PROTECTED		BIT(8)
> +#define LOW_SEC_KEY		BIT(7)
> +#define SECURE_BOOT		BIT(6)
> +#define UART_BOOT		BIT(5)

Where do these bits come from?

> +
> +static ssize_t abr_image_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", !!(security_status & ABR_IMAGE_SOURCE));

sysfs_emit() here and everywhere else you use sprintf() please.

> +}
> +static DEVICE_ATTR_RO(abr_image);
> +
> +static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", !!(security_status & LOW_SEC_KEY));
> +}
> +static DEVICE_ATTR_RO(low_security_key);
> +
> +static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", !!(security_status & OTP_PROTECTED));
> +}
> +static DEVICE_ATTR_RO(otp_protected);
> +
> +static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", !!(security_status & SECURE_BOOT));
> +}
> +static DEVICE_ATTR_RO(secure_boot);
> +
> +static ssize_t uart_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	/* Invert the bit, as 1 is boot from SPI/eMMC */
> +	return sprintf(buf, "%d\n", !(security_status & UART_BOOT));
> +}
> +static DEVICE_ATTR_RO(uart_boot);
> +
> +static struct attribute *aspeed_attrs[] = {
> +	&dev_attr_abr_image.attr,
> +	&dev_attr_low_security_key.attr,
> +	&dev_attr_otp_protected.attr,
> +	&dev_attr_secure_boot.attr,
> +	&dev_attr_uart_boot.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(aspeed);
> +
> +static int __init aspeed_bootinfo_init(void)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +
> +	/* AST2600 only */
> +	np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
> +	if (!of_device_is_available(np))
> +		return -ENODEV;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	security_status = readl(base + SEC_STATUS);
> +
> +	iounmap(base);
> +	of_node_put(np);
> +
> +	firmware_bootinfo_init(aspeed_groups[0]);
> +
> +	pr_info("AST2600 secure boot %s\n",
> +		(security_status & SECURE_BOOT) ? "enabled" : "disabled");

When all is good, no need to print anything out.

> +
> +	return 0;
> +}
> +
>  static int __init aspeed_socinfo_init(void)
>  {
>  	struct soc_device_attribute *attrs;
> @@ -148,6 +228,8 @@ static int __init aspeed_socinfo_init(void)
>  			attrs->revision,
>  			attrs->soc_id);
>  
> +	aspeed_bootinfo_init();

Why does this function return a value and yet you ignore it?


thanks,

greg k-h
