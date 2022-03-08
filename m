Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51A64D115F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbiCHH5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbiCHH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:56:55 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257FB3E5DC;
        Mon,  7 Mar 2022 23:55:58 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4FA7B2013FA;
        Tue,  8 Mar 2022 07:55:55 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DF9BF801EA; Tue,  8 Mar 2022 08:55:50 +0100 (CET)
Date:   Tue, 8 Mar 2022 08:55:50 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     conor.dooley@microchip.com
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        lewis.hanly@microchip.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] hwrng: mpfs - add polarfire soc hwrng support
Message-ID: <YicMBhn81HmtJMiF@owl.dominikbrodowski.net>
References: <20220307154023.813158-1-conor.dooley@microchip.com>
 <20220307154023.813158-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307154023.813158-2-conor.dooley@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Mar 07, 2022 at 03:40:23PM +0000 schrieb conor.dooley@microchip.com:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a driver to access the hardware random number generator on the
> Polarfire SoC. The hwrng can only be accessed via the system controller,
> so use the mailbox interface the system controller exposes to access the
> hwrng.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/char/hw_random/Kconfig    |  13 ++++
>  drivers/char/hw_random/Makefile   |   1 +
>  drivers/char/hw_random/mpfs-rng.c | 103 ++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/char/hw_random/mpfs-rng.c
> 
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 9704963f9d50..69f1fd538589 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -385,6 +385,19 @@ config HW_RANDOM_PIC32
>  
>  	  If unsure, say Y.
>  
> +config HW_RANDOM_POLARFIRE_SOC
> +	tristate "Microchip PolarFire SoC Random Number Generator support"
> +	depends on HW_RANDOM && POLARFIRE_SOC_SYS_CTRL
> +	help
> +	  This driver provides kernel-side support for the Random Number
> +	  Generator hardware found on PolarFire SoC (MPFS).
> +
> +	  To compile this driver as a module, choose M here. The
> +	  module will be called mfps_rng.
> +
> +	  If unsure, say N.
> +
> +
>  config HW_RANDOM_MESON
>  	tristate "Amlogic Meson Random Number Generator support"
>  	depends on HW_RANDOM
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 584d47ba32f7..3e948cf04476 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -46,3 +46,4 @@ obj-$(CONFIG_HW_RANDOM_CCTRNG) += cctrng.o
>  obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
>  obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
>  obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
> +obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
> diff --git a/drivers/char/hw_random/mpfs-rng.c b/drivers/char/hw_random/mpfs-rng.c
> new file mode 100644
> index 000000000000..a103c765d021
> --- /dev/null
> +++ b/drivers/char/hw_random/mpfs-rng.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip PolarFire SoC (MPFS) hardware random driver
> + *
> + * Copyright (c) 2020-2022 Microchip Corporation. All rights reserved.
> + *
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/hw_random.h>
> +#include <linux/platform_device.h>
> +#include <soc/microchip/mpfs.h>
> +
> +#define CMD_OPCODE	0x21
> +#define CMD_DATA_SIZE	0U
> +#define CMD_DATA	NULL
> +#define MBOX_OFFSET	0U
> +#define RESP_OFFSET	0U
> +#define RNG_RESP_BYTES	32U
> +
> +struct mpfs_rng {
> +	struct mpfs_sys_controller *sys_controller;
> +	struct hwrng rng;
> +};
> +
> +static int mpfs_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +	struct mpfs_rng *rng_priv = container_of(rng, struct mpfs_rng, rng);
> +	u32 response_msg[RNG_RESP_BYTES / sizeof(u32)];
> +	unsigned int count = 0, copy_size_bytes;
> +	int ret;
> +
> +	struct mpfs_mss_response response = {
> +		.resp_status = 0U,
> +		.resp_msg = (u32 *)response_msg,
> +		.resp_size = RNG_RESP_BYTES
> +	};
> +	struct mpfs_mss_msg msg = {
> +		.cmd_opcode = CMD_OPCODE,
> +		.cmd_data_size = CMD_DATA_SIZE,
> +		.response = &response,
> +		.cmd_data = CMD_DATA,
> +		.mbox_offset = MBOX_OFFSET,
> +		.resp_offset = RESP_OFFSET
> +	};
> +
> +	while (count < max) {
> +		ret = mpfs_blocking_transaction(rng_priv->sys_controller, &msg);
> +		if (ret)
> +			return ret;
> +
> +		copy_size_bytes = max - count > RNG_RESP_BYTES ? RNG_RESP_BYTES : max - count;
> +		memcpy(buf + count, response_msg, copy_size_bytes);
> +
> +		count += copy_size_bytes;
> +		if (!wait)
> +			break;
> +	}
> +
> +	return count;
> +}
> +
> +static int mpfs_rng_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mpfs_rng *rng_priv;
> +	int ret;
> +
> +	rng_priv = devm_kzalloc(dev, sizeof(*rng_priv), GFP_KERNEL);
> +	if (!rng_priv)
> +		return -ENOMEM;
> +
> +	rng_priv->sys_controller =  mpfs_sys_controller_get(&pdev->dev);
> +	if (IS_ERR(rng_priv->sys_controller))
> +		return dev_err_probe(dev, PTR_ERR(rng_priv->sys_controller),
> +				     "Failed to register system controller hwrng sub device\n");
> +
> +	rng_priv->rng.read = mpfs_rng_read;
> +	rng_priv->rng.name = pdev->name;

Is there also some quality estimation, or should this hwrng only be trusted
if it passes validation by userspace?

Thanks,
	Dominik
