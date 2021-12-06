Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B7468FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 05:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhLFE7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 23:59:43 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:43480 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233900AbhLFE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 23:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638766571; x=1670302571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kBQwGNVkUVyBBbQCQnjEKzPjrNcwYkbrkDfb80vyn+Q=;
  b=RjGJy0QiZIp1zope4sptKkkMmxW0am6/cWP9B5YeeYPpG5qB4w1CutwB
   +8e1UNXkSHun30UUlrJmjA6pNB9uQLPTXWwxlCCT/TF75Zuq9bL1jIiYi
   mivlZlF1VBO7Wuz810p4JhRzuAnF6rbxvpL7pd8yRW/iyPXibdErU1zp9
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Dec 2021 20:56:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 20:56:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 5 Dec 2021 20:56:09 -0800
Received: from [10.50.37.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 5 Dec 2021
 20:56:04 -0800
Message-ID: <192d147f-d170-ac57-f376-c4b7a3b919aa@quicinc.com>
Date:   Mon, 6 Dec 2021 10:24:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 5/8] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Content-Language: en-CA
To:     Greg KH <greg@kroah.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
 <e13421cebfcddda5e7df99a8cf767854d121976e.1638430506.git.quic_schowdhu@quicinc.com>
 <Yan52hNKKZMgzleI@kroah.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <Yan52hNKKZMgzleI@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/2021 4:34 PM, Greg KH wrote:
> On Thu, Dec 02, 2021 at 03:21:24PM +0530, Souradeep Chowdhury wrote:
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
>>   drivers/soc/qcom/qcom_eud.c                | 268 +++++++++++++++++++++++++++++
>>   4 files changed, 288 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
>>   create mode 100644 drivers/soc/qcom/qcom_eud.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
>> new file mode 100644
>> index 0000000..eaf2e82
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-eud
>> @@ -0,0 +1,9 @@
>> +What:		/sys/bus/platform/drivers/eud/.../enable
>> +Date:           October 2021
> You sent this patch in December 2021 :(
>
Ack
>
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
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
>> index 0000000..613ac41
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom_eud.c
>> @@ -0,0 +1,268 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
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
>> +	void __iomem			*eud_mode_mgr2_phys_base;
>> +	unsigned int			int_status;
>> +	int				eud_irq;
>> +	bool				enable;
>> +	bool				usb_attach;
>> +
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
>> +
>> +static struct attribute_group attr_group = {
>> +	.attrs = eud_attrs,
>> +};
>> +
>> +static const struct attribute_group *attr_groups[] = {
>> +	&attr_group,
>> +	NULL
>> +};
> ATTRIBUTE_GROUPS()?
Ack
>
> thanks,
>
> greg k-h
