Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868CD4772FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhLPNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:17:55 -0500
Received: from foss.arm.com ([217.140.110.172]:43602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232126AbhLPNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:17:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607081435;
        Thu, 16 Dec 2021 05:17:53 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BEC13F73B;
        Thu, 16 Dec 2021 05:17:52 -0800 (PST)
Message-ID: <fe895d71-5f1f-daf0-bde8-c8ab5f4c0128@arm.com>
Date:   Thu, 16 Dec 2021 13:17:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] mfd: rk808: add reboot support to rk808 pmic
Content-Language: en-GB
To:     Frank Wunderlich <linux@fw-web.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
References: <20211215213300.4778-1-linux@fw-web.de>
 <20211215213300.4778-2-linux@fw-web.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211215213300.4778-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-15 21:32, Frank Wunderlich wrote:
> From: Peter Geis <pgwipeout@gmail.com>
> 
> This adds reboot support to the rk808 pmic. This only enables if the
> rockchip,system-power-controller flag is set.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>   drivers/mfd/rk808.c       | 48 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mfd/rk808.h |  2 ++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index b181fe401330..afbd7e01df50 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -19,6 +19,7 @@
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/regmap.h>
> +#include <linux/reboot.h>
>   
>   struct rk808_reg_data {
>   	int addr;
> @@ -533,6 +534,7 @@ static void rk808_pm_power_off(void)
>   	int ret;
>   	unsigned int reg, bit;
>   	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +	dev_err(&rk808_i2c_client->dev, "poweroff device!\n");

This is not an error.

>   
>   	switch (rk808->variant) {
>   	case RK805_ID:
> @@ -552,6 +554,7 @@ static void rk808_pm_power_off(void)
>   		bit = DEV_OFF;
>   		break;
>   	default:
> +		dev_err(&rk808_i2c_client->dev, "poweroff device not supported!\n");

If we really don't support power off for the present PMIC then we should 
avoid registering the power off handler in the first place. These 
default cases should mostly just serve to keep static checkers happy.

>   		return;
>   	}
>   	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
> @@ -559,6 +562,44 @@ static void rk808_pm_power_off(void)
>   		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
>   }
>   
> +static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
> +{
> +	int ret;
> +	unsigned int reg, bit;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	switch (rk808->variant) {
> +	case RK805_ID:
> +		reg = RK805_DEV_CTRL_REG;
> +		bit = DEV_OFF_RST;
> +		break;
> +	case RK808_ID:
> +		reg = RK808_DEVCTRL_REG,
> +		bit = DEV_OFF;

Is that right? The RK808 datasheet does say that this bit resets itself 
once the OFF state is reached, but there doesn't seem to be any obvious 
guarantee of a power-on condition being present to automatically 
transition back to ACTIVE.

> +		break;
> +	case RK817_ID:
> +		reg = RK817_SYS_CFG(3);
> +		bit = DEV_RST;
> +		break;
> +	case RK818_ID:
> +		reg = RK818_DEVCTRL_REG;
> +		bit = DEV_OFF_RST;
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
> +	if (ret)
> +		dev_err(&rk808_i2c_client->dev, "Failed to restart device!\n");
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rk808_restart_handler = {
> +	.notifier_call = rk808_restart_notify,
> +	.priority = 255,
> +};
> +
>   static void rk8xx_shutdown(struct i2c_client *client)
>   {
>   	struct rk808 *rk808 = i2c_get_clientdata(client);
> @@ -727,6 +768,13 @@ static int rk808_probe(struct i2c_client *client,
>   	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
>   		rk808_i2c_client = client;
>   		pm_power_off = rk808_pm_power_off;
> +		rk808->nb = &rk808_restart_handler;

The handler just relies on the global rk808_i2c_client anyway, so does 
this serve any purpose?

> +
> +		dev_warn(&client->dev, "register restart handler\n");

Don't scream a warning about normal and expected operation.

Thanks,
Robin.

> +
> +		ret = register_restart_handler(rk808->nb);
> +		if (ret)
> +			dev_err(&client->dev, "failed to register restart handler, %d\n", ret);
>   	}
>   
>   	return 0;
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index a96e6d43ca06..5dfe0c4ceab1 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -373,6 +373,7 @@ enum rk805_reg {
>   #define SWITCH2_EN	BIT(6)
>   #define SWITCH1_EN	BIT(5)
>   #define DEV_OFF_RST	BIT(3)
> +#define DEV_RST		BIT(2)
>   #define DEV_OFF		BIT(0)
>   #define RTC_STOP	BIT(0)
>   
> @@ -701,5 +702,6 @@ struct rk808 {
>   	long				variant;
>   	const struct regmap_config	*regmap_cfg;
>   	const struct regmap_irq_chip	*regmap_irq_chip;
> +	struct notifier_block		*nb;
>   };
>   #endif /* __LINUX_REGULATOR_RK808_H */
