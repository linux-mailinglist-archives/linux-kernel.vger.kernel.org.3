Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3B4900F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiAQE7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:59:24 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:55019 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAQE7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642395563; x=1673931563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ecZRymGbai2/9D1ipMDLn9AKSIpYMSNiD0oBP3JjOcw=;
  b=FclZvwPLtbv5bKCCK+/krGfcl96ewgzQygIciSW6FkXGrhkVQC7oJoju
   179wq8LwlwRCXtiTMFMZztKMecB3+myolyC+wT4w7wIIKtT3avncBnPTW
   FsIXUr15F59pl1Ij5euOrP+GlidHcdkTAxZKr46ZwZ5JRjDKyvddM2Hqs
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 20:59:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 20:59:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 20:59:21 -0800
Received: from [10.50.10.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 16 Jan
 2022 20:59:16 -0800
Message-ID: <8006132e-bd09-ae21-8150-a2351ca64e88@quicinc.com>
Date:   Mon, 17 Jan 2022 10:28:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 4/7] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
        <tsoni@codeaurora.org>, <psodagud@codeaurora.org>,
        <satyap@codeaurora.org>, <pheragu@codeaurora.org>,
        <rnayak@codeaurora.org>, <sibis@codeaurora.org>,
        <saiprakash.ranjan@codeaurora.org>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <654a9529015d2d5cf9ee1c263cdc0a970bbe4f91.1641288286.git.quic_schowdhu@quicinc.com>
 <YdeVC3d3OzbCSDTQ@ripper>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YdeVC3d3OzbCSDTQ@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2022 6:49 AM, Bjorn Andersson wrote:
> On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:
>
>> Add support for control peripheral of EUD (Embedded USB Debugger) to
>> listen to events such as USB attach/detach, pet EUD to indicate software
>> is functional.Reusing the platform device kobj, sysfs entry 'enable' is
>> created to enable or disable EUD.
>>
>> To enable the eud the following needs to be done
>> echo 1 > /sys/bus/platform/.../enable
>>
>> To disable eud, following is the command
>> echo 0 > /sys/bus/platform/.../enable
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-eud |   9 +
>>   drivers/soc/qcom/Kconfig                   |  10 ++
>>   drivers/soc/qcom/Makefile                  |   1 +
>>   drivers/soc/qcom/qcom_eud.c                | 260 +++++++++++++++++++++++++++++
>>   4 files changed, 280 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
>>   create mode 100644 drivers/soc/qcom/qcom_eud.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
>> new file mode 100644
>> index 0000000..2381552
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-eud
>> @@ -0,0 +1,9 @@
>> +What:		/sys/bus/platform/drivers/eud/.../enable
>> +Date:           January 2022
>> +Contact:        Souradeep Chowdhury <schowdhu@codeaurora.org>
>> +Description:
>> +		The Enable/Disable sysfs interface for Embedded
>> +		USB Debugger(EUD). This enables and disables the
>> +		EUD based on a 1 or a 0 value. By enabling EUD,
>> +		the user is able to activate the mini-usb hub of
>> +		EUD for debug and trace capabilities.
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 79b568f..a4db41b 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -42,6 +42,16 @@ config QCOM_CPR
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called qcom-cpr
>>   
>> +config QCOM_EUD
>> +	tristate "QCOM Embedded USB Debugger(EUD) Driver"
>> +	select USB_ROLE_SWITCH
>> +	help
>> +	  This module enables support for Qualcomm Technologies, Inc.
>> +	  Embedded USB Debugger (EUD). The EUD is a control peripheral
>> +	  which reports VBUS attach/detach events and has USB-based
>> +	  debug and trace capabilities. On selecting m, the module name
>> +	  that is built is qcom_eud.ko
>> +
>>   config QCOM_GENI_SE
>>   	tristate "QCOM GENI Serial Engine Driver"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index ad675a6..3331a40 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>> +obj-$(CONFIG_QCOM_EUD)          += qcom_eud.o
>>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>>   obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>> diff --git a/drivers/soc/qcom/qcom_eud.c b/drivers/soc/qcom/qcom_eud.c
>> new file mode 100644
>> index 0000000..7c4cc7d
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom_eud.c
>> @@ -0,0 +1,260 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
> Is this needed?
Ack.
>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/usb/role.h>
>> +
>> +#define EUD_REG_INT1_EN_MASK	0x0024
>> +#define EUD_REG_INT_STATUS_1	0x0044
>> +#define EUD_REG_CTL_OUT_1	0x0074
>> +#define EUD_REG_VBUS_INT_CLR	0x0080
>> +#define EUD_REG_CSR_EUD_EN	0x1014
>> +#define EUD_REG_SW_ATTACH_DET	0x1018
>> +#define EUD_REG_EUD_EN2         0x0000
>> +
>> +#define EUD_ENABLE		BIT(0)
>> +#define EUD_INT_PET_EUD		BIT(0)
>> +#define EUD_INT_VBUS		BIT(2)
>> +#define EUD_INT_SAFE_MODE	BIT(4)
>> +#define EUD_INT_ALL		(EUD_INT_VBUS|EUD_INT_SAFE_MODE)
>> +
>> +struct eud_chip {
>> +	struct device			*dev;
>> +	struct usb_role_switch		*role_sw;
>> +	void __iomem			*eud_reg_base;
> This is unnecessarily long, "base" or "eud" seems sufficient.
Ack
>
>> +	void __iomem			*eud_mode_mgr2_phys_base;
> "mode_mgr"
Ack
>
>> +	unsigned int			int_status;
>> +	int				eud_irq;
> "irq"
Ack
>
>> +	bool				enable;
> "enable" is an action, but you use it to track if the state of the EUD,
> i.e if it's "enabled".
Ack
>
>> +	bool				usb_attach;
> "attach" vs "attached"
Ack
>
>> +
> Empty line.
Ack
>
>> +};
>> +
>> +static int enable_eud(struct eud_chip *priv)
>> +{
>> +	writel(EUD_ENABLE, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
>> +	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
>> +			priv->eud_reg_base + EUD_REG_INT1_EN_MASK);
>> +	writel(1, priv->eud_mode_mgr2_phys_base + EUD_REG_EUD_EN2);
>> +
>> +	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> When this fails, don't you want to disable the EUD again?
Ack
>
>> +}
>> +
>> +static void disable_eud(struct eud_chip *priv)
>> +{
>> +	writel(0, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
>> +	writel(0, priv->eud_mode_mgr2_phys_base + EUD_REG_EUD_EN2);
>> +}
>> +
>> +static ssize_t enable_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct eud_chip *chip = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%d\n", chip->enable);
>> +}
>> +
>> +static ssize_t enable_store(struct device *dev,
>> +		struct device_attribute *attr,
>> +		const char *buf, size_t count)
>> +{
>> +	struct eud_chip *chip = dev_get_drvdata(dev);
>> +	bool enable;
>> +	int ret;
>> +
>> +	if (kstrtobool(buf, &enable))
>> +		return -EINVAL;
>> +
>> +	if (enable) {
>> +		ret = enable_eud(chip);
>> +		if (!ret)
>> +			chip->enable = enable;
>> +	} else {
>> +		disable_eud(chip);
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(enable);
>> +
>> +static struct attribute *eud_attrs[] = {
>> +	&dev_attr_enable.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(eud);
>> +
>> +static void usb_attach_detach(struct eud_chip *chip)
>> +{
>> +	u32 reg;
>> +
>> +	/* read ctl_out_1[4] to find USB attach or detach event */
>> +	reg = readl(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
>> +	if (reg & EUD_INT_SAFE_MODE)
>> +		chip->usb_attach = true;
>> +	else
>> +		chip->usb_attach = false;
> chip->usb_attach = reg & EUD_INT_SAFE_MODE;
Ack
>> +
>> +	/* set and clear vbus_int_clr[0] to clear interrupt */
>> +	writel(BIT(0), chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
>> +	writel(0, chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
> How come you do this before waking up the threaded handler?
Ack
>
>> +}
>> +
>> +static void pet_eud(struct eud_chip *chip)
>> +{
>> +	u32 reg;
>> +	int ret;
>> +
>> +	/* read sw_attach_det[0] to find attach/detach event */
> Please instead describe what this means, like:
>
> /*
>   * When the EUD_INT_PET_EUD in SW_ATTACH_DET is set, the cable has been
>   * disconnected and we need to detach the something because something.
>   */
Ack
>
>> +	reg = readl(chip->eud_reg_base +  EUD_REG_SW_ATTACH_DET);
> Please drop the double space.
Ack
>
>> +	if (reg & EUD_INT_PET_EUD) {
>> +		/* Detach & Attach pet for EUD */
>> +		writel(0, chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
>> +		/* Delay to make sure detach pet is done before attach pet */
>> +		ret = readl_poll_timeout(chip->eud_reg_base + EUD_REG_SW_ATTACH_DET,
>> +					reg, (reg == 0), 1, 100);
>> +		if (ret) {
>> +			dev_err(chip->dev, "Detach pet failed\n");
>> +			return;
>> +		}
>> +
>> +		writel(EUD_INT_PET_EUD, chip->eud_reg_base +
>> +				EUD_REG_SW_ATTACH_DET);
> Can you please help me see what differs between this and the write in
> the else statement?

Ack. Will move this out of the if else statement.

>
>> +	} else {
>> +		/* Attach pet for EUD */
>> +		writel(EUD_INT_PET_EUD, chip->eud_reg_base +
>> +				EUD_REG_SW_ATTACH_DET);
>> +	}
>> +}
>> +
>> +static irqreturn_t handle_eud_irq(int irq, void *data)
>> +{
>> +	struct eud_chip *chip = data;
>> +	u32 reg;
>> +
>> +	/* read status register and find out which interrupt triggered */
> That's what the next line says as well, please drop this comment.
Ack
>
>> +	reg = readl(chip->eud_reg_base +  EUD_REG_INT_STATUS_1);
> Please drop the double space.
Ack
>
>> +	switch (reg & EUD_INT_ALL) {
> What if both of these bits are set? Won't you just end up with an
> interrupt storm until someone disables the EUD again?
So EUD can either be in safe mode or vbus mode ,  both bits will not be 
set together.
>
>> +	case EUD_INT_VBUS:
>> +		chip->int_status = EUD_INT_VBUS;
>> +		usb_attach_detach(chip);
>> +		return IRQ_WAKE_THREAD;
>> +	case EUD_INT_SAFE_MODE:
>> +		pet_eud(chip);
>> +		break;
> This is the only case where you break to return IRQ_HANDLED. Please be
> consistent.
Ack
>
>> +	default:
>> +		return IRQ_NONE;
>> +	}
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t handle_eud_irq_thread(int irq, void *data)
>> +{
>> +	struct eud_chip *chip = data;
>> +	int ret;
>> +
>> +	if (chip->int_status == EUD_INT_VBUS) {
> I presume you have this here to signal that EUD_INT_VBUS was set in
> EUD_REG_INT_STATUS_1 in handle_eud_irq().
>
> But 1) unless this was true you wouldn't have woken up the threaded
> handler and 2) you never clear int_status, so once you've received the
> EUD_INT_VBUS it seems to forever be true.
Ack. Will be clearing the int bits once this is done.
>
>> +		if (chip->usb_attach)
>> +			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_DEVICE);
>> +		else
>> +			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_HOST);
>> +		if (ret)
>> +			dev_err(chip->dev, "failed to set role switch\n");
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int eud_probe(struct platform_device *pdev)
>> +{
>> +	struct eud_chip *chip;
>> +	struct fwnode_handle *fwnode = pdev->dev.fwnode, *ep, *connector;
>> +	int ret;
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->dev = &pdev->dev;
>> +
>> +	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
>> +	if (!ep)
>> +		return -ENODEV;
>> +
>> +	connector = fwnode_graph_get_remote_port_parent(ep);
>> +	fwnode_handle_put(ep);
>> +	if (!connector)
>> +		return -ENODEV;
>> +
>> +	chip->role_sw = fwnode_usb_role_switch_get(connector);
> Can't you just call usb_role_switch_get(&pdev->dev) to find the
> "usb-role-switch", without having to traverse the fwnode_graph manually?

"usb_role_switch_get" finds the role_switch from the current or the 
parent node, however

in this case the usb-role-switch property is present at the parent of 
the connector node

which is attached to the eud node via port end point.

>
>> +	if (IS_ERR(chip->role_sw)) {
>> +		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
>> +					"failed to get role switch\n");
>> +	}
> Note that from now on you must usb_role_switch_put(chip->role_sw);
Ack
>
>> +
>> +	chip->eud_reg_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(chip->eud_reg_base))
>> +		return PTR_ERR(chip->eud_reg_base);
>> +
>> +	chip->eud_mode_mgr2_phys_base = devm_platform_ioremap_resource(pdev, 1);
>> +	if (IS_ERR(chip->eud_mode_mgr2_phys_base))
>> +		return PTR_ERR(chip->eud_mode_mgr2_phys_base);
>> +
>> +	chip->eud_irq = platform_get_irq(pdev, 0);
>> +	ret = devm_request_threaded_irq(&pdev->dev, chip->eud_irq, handle_eud_irq,
>> +			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
>> +
>> +	enable_irq_wake(chip->eud_irq);
>> +
>> +	platform_set_drvdata(pdev, chip);
>> +
>> +	return 0;
>> +}
>> +
>> +static int eud_remove(struct platform_device *pdev)
>> +{
>> +	struct eud_chip *chip = platform_get_drvdata(pdev);
>> +
>> +	if (chip->enable)
>> +		disable_eud(chip);
>> +
>> +	device_init_wakeup(&pdev->dev, false);
>> +	disable_irq_wake(chip->eud_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id eud_dt_match[] = {
>> +	{ .compatible = "qcom,sc7280-eud" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, eud_dt_match);
>> +
>> +static struct platform_driver eud_driver = {
>> +	.probe		= eud_probe,
> I would prefer if you didn't indent the assignments.
Ack
>
>> +	.remove		= eud_remove,
>> +	.driver		= {
>> +		.name		= "eud",
> "qcom_eud" please.
Ack
>
> Regards,
> Bjorn
>
>> +		.dev_groups	= eud_groups,
>> +		.of_match_table = eud_dt_match,
>> +	},
>> +};
>> +module_platform_driver(eud_driver);
>> +
>> +MODULE_DESCRIPTION("QTI EUD driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.7.4
>>
