Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD2584D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiG2IOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiG2IOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:14:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB881B17;
        Fri, 29 Jul 2022 01:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYuW3TBvL+OvTC1MFGNlL3a9PzutV4tfGSv+AGyRCArxvy1F9TORg6NjEWNKn7TAeQj/igHpSeyO3T2wdiP9BUiSW0ThEmIljmVwSnGqSCvSdVbh914umxgsUC0zEb6ESji2X4k1cWlws1ciD28lfy6h9PTBEs3uChtQ6T4YHlS3EtKfUcUEZ5zyhHBduP0aCOUkuX5JxuJ8hlBm0qQN7SEs2l1YhDpjBiHd25/iHugEfNHfYjJ/VfD7msOmj7GgONVcg6EOyv/G8s+B7tB9csTOPxvrUumMROi+ZtAVuH+9rjRMfBMzU5geitw6NGy8QRKT4bDyHLlgg7AKHb/zXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoeKXKK43mSO/YBoIpcnLNP4HwTmgUTMVrr3+TzGodA=;
 b=Jt89hJiHBAlEuwSTE13wYTG+0kkd1+G7NalzPViGI/1plAPLuezpnjFD/ZGEiXFIDgzpgVLVXgpx5TxoIkFeTIqp5W34peaDZeSKAZ7easlzreMQaVJBf02wBaXLg//mrlNAuqYp/ZCSM6jMxKw2L55gjy10o2QxdklTOXcbmlhGxI+UA+qFKtM1wn9CMiCEHCjIMz0qDyE70Z1xcSwFeRrMoh8PrMli0M5Sew21m77j1A4G9Onq9ykv3SpMOfApixbK49bRWQu1/CKXpYpymkz6HW9x9LSwUU/NJzJ8uLIxmX36cMUUbx4jRQd54OmelMneJ+h90udfBSe9GEtQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoeKXKK43mSO/YBoIpcnLNP4HwTmgUTMVrr3+TzGodA=;
 b=SF7vPYg4KHNGzgEWgo3DxBs/Rwpk9Pv526aluFuBv5PSxRM+ELbVq1uUlhFZz/PfciJ2QnCJAEPXz58sL6MuREUQIC1A5/kVedTpSKOO4FG1VJS9ev5kdIR91AxE425HZzH+R+9W1AcxDLfD6afqm6M0cZ+iVWfeDkhVkunGB9o=
Received: from BN9PR03CA0230.namprd03.prod.outlook.com (2603:10b6:408:f8::25)
 by DM5PR12MB2341.namprd12.prod.outlook.com (2603:10b6:4:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Fri, 29 Jul
 2022 08:13:55 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::11) by BN9PR03CA0230.outlook.office365.com
 (2603:10b6:408:f8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Fri, 29 Jul 2022 08:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 08:13:55 +0000
Received: from [10.143.121.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 03:13:50 -0500
Message-ID: <f0ea25fe-782b-ed35-d977-3fe16724193c@amd.com>
Date:   Fri, 29 Jul 2022 13:43:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
Subject: Re: [PATCH v2 4/4] drivers: misc: Add Support for TMR Inject IP
To:     Greg KH <gregkh@linuxfoundation.org>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-5-appana.durga.kedareswara.rao@amd.com>
 <YuKcBO5JatwRYQJ3@kroah.com>
Content-Language: en-US
In-Reply-To: <YuKcBO5JatwRYQJ3@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca205c40-ecdb-4e35-d58d-08da713a47f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2341:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoTIC4RkmVmVzuSggtOSsVf1eM3knB602lKquDxxEjk7WT5LLjJ5PAUvldB8P/k1AJpmxGAwggppvZP5iQ31k4nodPGNY6HE19yrZMzqNhlC8wdbncZ1OoZ3jEao5KmqHCKdTlhlCnZgqT73nCpIZoIk/TUgCOZZi2rcq5cqJ6L8mMJJILj7BR3NDkLAFjvesCih81pIXIUPNLZK2n0tUCVog4JYbWGMm2Ska1KT1epPIBZnKrmZ32oB5gzGkGzZ9/jKC+8a0henDXb9C69wribIrajulXOvsTtenvC33slHX7hIZz7bSOcpjizIQOb8dnFNtlWwpCzejwe/38hYNh8kRY/me9iENMkEJF3KwGz3nNbIY/2YmTcyZIfGXyw97wfNsbFuNqedl5EymyLyxyBQRahJkPCcCec0mWWDDRCzndcn4w8npLghEWB4DTuZgR4zscYf7N4TnKzm6aafhU0pgYN3TRCZRdmRtPyRNk2uL5sieA3rXTtUuJBphjrog6l8OdkFbsMqyukffNm4xCX/EMGtgibd70MsrwHs8We00oWp5bO+bZAGQmrCT6ZJ9Kg9xuPa/KzzN/1FeZYVPQOJzWV2i+7BrNcSCAWme2RD9upArSrrwarnIOPhxcWKdy6FWkcWii8LUcFWljbc/c+LwyQszuXO1EdgT1uwhI3rCmjUpKCDFbYzPazPlyBsUe9Fyf7ACxurAw/74nmtEXT6IzQ5OPddcH8US0tDbn/vB4TAcb7ZQxKNkrefPpwXx5+bjmwtWqRIUOrjK4Yui7BNwvFqjZjeOtjBJSw2hdOIrwcIaXvqewTYx6rTMvXK5v+XdPZe2zTnjite7y1kW1ETS6+weY0TWTbu5PPr3ldRJpvIKGPcLqzIm720RBrp+pBEgjPMTioAuggLdb3tPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(26005)(53546011)(81166007)(966005)(31696002)(6636002)(478600001)(110136005)(6666004)(16526019)(107886003)(2616005)(336012)(186003)(356005)(41300700001)(426003)(47076005)(83380400001)(82740400003)(36860700001)(8936002)(5660300002)(31686004)(82310400005)(40480700001)(2906002)(36756003)(16576012)(316002)(40460700003)(4326008)(54906003)(70586007)(70206006)(8676002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:13:55.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca205c40-ecdb-4e35-d58d-08da713a47f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2341
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the review.

On 28/07/22 7:54 pm, Greg KH wrote:
> On Wed, Jul 20, 2022 at 11:30:16AM +0530, Appana Durga Kedareswara rao wrote:
>> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>
>> The Triple Modular Redundancy(TMR) provides functional fault injection by
>> changing selected MicroBlaze instructions, which provides the possibility
>> to verify that the TMR subsystem error detection and fault recovery logic
>> is working properly, provided sysfs entries which allow the user to inject
>> a fault.
> 
> We already have a fault-injection api, why are you not using that?
> 

Inorder to inject the error using TMR inject IP, The API
which injects the error should be executed from Processor LMB,
below sysfs entry calls microblaze core API xmb_inject_err()
which switches the processor to real mode and injects the error,
Please find the code corresponds to xmb_inject_err() API here: 
https://www.spinics.net/lists/arm-kernel/msg991888.html


>>
>> Usage:
>> echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> Odd, just one is needed.

Sure will fix in next version.
> 
>> ---
>> Changes for v2:
>> --> Added Examples for sysfs entries
>> --> Removed uneeded struct dev from the driver private structure
>> --> Updated driver to use sysfs_emit() API instead of sprintf() API
>> --> Added error checks wherever applicable.
>> --> Fixed sysfs registration.
>>   .../testing/sysfs-driver-xilinx-tmr-inject    |  16 ++
>>   MAINTAINERS                                   |   7 +
>>   drivers/misc/Kconfig                          |  10 +
>>   drivers/misc/Makefile                         |   1 +
>>   drivers/misc/xilinx_tmr_inject.c              | 186 ++++++++++++++++++
>>   5 files changed, 220 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
>>   create mode 100644 drivers/misc/xilinx_tmr_inject.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
>> new file mode 100644
>> index 000000000000..d274b30ee24c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
>> @@ -0,0 +1,16 @@
>> +What:		/sys/devices/platform/amba_pl/<dev>/inject_err
>> +Date:		June 2022
> 
> It's not June anymore, even when you sent this patch :(

Will fix in next version
> 
>> +Contact:	appana.durga.rao@xilinx.com
>> +Description:	This control file allows to inject fault using tmr inject.
>> +		This file is write only.
>> +		Example:
>> +		# echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err
>> +
>> +What:		/sys/devices/platform/amba_pl/<dev>/inject_cpuid
>> +Date:		June 2022
>> +Contact:	appana.durga.rao@xilinx.com
>> +Description:	This control file allows to configure the CPU identifier
>> +		to enable fault injection.
>> +		This file is write only.
>> +		Example:
>> +		# echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_cpuid
> 
> What errors and faults happen?  Where is that documented?  What happens
> when you write to these sysfs files?  Does the system crash?  Why would
> you want to use them ever?
> 
> 

TMR subsystem has 3 Microblaze processor cores, by default driver is 
configured to inject the error at processor core-0,  This sysfs entry 
provides a mechanism to inject the fault at the user-specified core.

> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 732fd9ae7d9f..c903b45c204a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13087,6 +13087,13 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>>   F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>>   F:	drivers/misc/xilinx_tmr_manager.c
>>   
>> +MICROBLAZE TMR INJECT
>> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> +S:	Supported
>> +F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
>> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
>> +F:	drivers/misc/xilinx_tmr_inject.c
>> +
>>   MICROCHIP AT91 DMA DRIVERS
>>   M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>>   M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 555ae2e33b91..0989c36f3051 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -493,6 +493,16 @@ config TMR_MANAGER
>>   
>>   	  Say N here unless you know what you are doing.
>>   
>> +config TMR_INJECT
>> +	bool "Select TMR Inject"
>> +	depends on TMR_MANAGER
>> +	help
>> +	  This option enables the driver developed for TMR Inject.
>> +	  The Triple Modular Redundancy(TMR) Inject provides
>> +	  fault injection.
>> +
>> +	  Say N here unless you know what you are doing.
> 
> Why can't this be a module?
> 
> 

We can use this driver as a module will fix in next version.

> 
>> +
>>   source "drivers/misc/c2port/Kconfig"
>>   source "drivers/misc/eeprom/Kconfig"
>>   source "drivers/misc/cb710/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 28b9803f909b..e9d0a709e207 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -61,3 +61,4 @@ obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>>   obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>>   obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
>>   obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
>> +obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>> diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
>> new file mode 100644
>> index 000000000000..930d89e90b61
>> --- /dev/null
>> +++ b/drivers/misc/xilinx_tmr_inject.c
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Xilinx TMR Inject IP.
>> + *
>> + * Copyright (C) 2022 Xilinx, Inc.
>> + *
>> + * Description:
>> + * This driver is developed for TMR Inject IP,The Triple Modular Redundancy(TMR)
>> + * Inject provides fault injection.
>> + * Fault injection and detection features are provided through sysfs entries
>> + * which allow the user to generate a fault.
>> + */
>> +
>> +#include <asm/xilinx_mb_manager.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +
>> +/* TMR Inject Register offsets */
>> +#define XTMR_INJECT_CR_OFFSET		0x0
>> +#define XTMR_INJECT_AIR_OFFSET		0x4
>> +#define XTMR_INJECT_IIR_OFFSET		0xC
>> +#define XTMR_INJECT_EAIR_OFFSET		0x10
>> +#define XTMR_INJECT_ERR_OFFSET		0x204
>> +
>> +/* Register Bitmasks/shifts */
>> +#define XTMR_INJECT_CR_CPUID_SHIFT	8
>> +#define XTMR_INJECT_CR_IE_SHIFT		10
>> +#define XTMR_INJECT_IIR_ADDR_MASK	GENMASK(31, 16)
>> +
>> +#define XTMR_INJECT_MAGIC_MAX_VAL	255
>> +
>> +/**
>> + * struct xtmr_inject_dev - Driver data for TMR Inject
>> + * @regs: device physical base address
>> + * @cr_val: control register value
>> + * @magic: Magic hardware configuration value
>> + * @err_cnt: error statistics count
>> + */
>> +struct xtmr_inject_dev {
>> +	void __iomem *regs;
>> +	u32 cr_val;
>> +	u32 magic;
>> +	u32 err_cnt;
>> +};
>> +
>> +/* IO accessors */
>> +static inline void xtmr_inject_write(struct xtmr_inject_dev *xtmr_inject,
>> +				     u32 addr, u32 value)
>> +{
>> +	iowrite32(value, xtmr_inject->regs + addr);
>> +}
>> +
>> +static inline u32 xtmr_inject_read(struct xtmr_inject_dev *xtmr_inject,
>> +				   u32 addr)
>> +{
>> +	return ioread32(xtmr_inject->regs + addr);
>> +}
>> +
>> +static ssize_t inject_err_store(struct device *dev,
>> +				struct device_attribute *attr, const char *buf,
>> +				size_t size)
>> +{
>> +	int ret;
>> +	long value;
>> +
>> +	ret = kstrtoul(buf, 16, &value);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (value > 1)
>> +		return -EINVAL;
> 
> That does not match your documentation :(
> 

Will fix the documentation in next version

> 
>> +
>> +	xmb_inject_err();
>> +
>> +	return size;
>> +}
>> +static DEVICE_ATTR_WO(inject_err);
>> +
>> +static ssize_t inject_cpuid_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t size)
>> +{
>> +	struct xtmr_inject_dev *xtmr_inject = dev_get_drvdata(dev);
>> +	int ret;
>> +	long value;
>> +
>> +	ret = kstrtoul(buf, 0, &value);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (value > 3)
>> +		return -EINVAL;
> 
> Again, does not match the documentation at all.
> 

Will fix the documentation in next version


> confused,

sorry for the improper sysfs documentation will fix in next version.

Regards,
Kedar.
> 
> greg k-h
