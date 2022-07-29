Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0753B584D35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiG2INY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiG2INW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:13:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935D7FE7F;
        Fri, 29 Jul 2022 01:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik2vaoOg/umQi6+Lt1ha7SzWbwX7dWof5fqzzxmAm+Uq8DGOQT5ymTInHbJb2RCg3h0nGkvd3gcCRoTJJLN2PZ9Of3bCPp9LFL7f1E8PRoWjenHEino9tQ3QgnKmbx2kt08PsouuR+t0N1fBT2bzvhR/tJRLH8Ze3e8QXJu1xqU/VMiw1ihXtqgLpHTZCVi/G6PJT4QZXpXk5QyYAXlB1P55EpXi3028ohWtOZRv+ZS5ZRKWdSRVRWnVRrEtZKBUeHOhtP5hFTTvC6gXPR78sCFRrLMlzJxu31P0u0bxLLgOE8Urn2Z2y3F4/Q2XZailLequCaZHTII4qgJlnJPCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uaWkXJjhHwOEVhlfPD/XDHJ/tuSVxfZYlSJpp5/7Ls=;
 b=SZU0UzuicHUI2xORiIg0rwpimKbQPCmOyHDJ80PZKthg4TuyUyuYLqEq/ka/CVdIBvWKXk3XuFa6/vsZQqeg5qQ6Xpegz6+YfrqZrPerkAJdbqfP83dUbGx1QOKYvL3VOZpRyJ2U05nskkfY+UtAdh6sORdFU18eiW872NpIgWGsPYOzHgKggR+ituoq5rcPaizJGD7h1ubY1mMs+K6ROpA+MMrbtVW8of5DdRI9b3MS7oPKZC5r7gQ+few/I7k+e4g0+s/xhlrepPXpYc4J8+ntwhJvB82LqYZZmKLMIWy59EFw2wG5OE+H93ArQBAZna1WAd6trr5t6cDlpJ6+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uaWkXJjhHwOEVhlfPD/XDHJ/tuSVxfZYlSJpp5/7Ls=;
 b=T5ER4FLdtxXfreOoW3N5GX89XsiaC22sXMgX6Gyqe2xejwoU5xvgAcYsVzOoelNgaumxm5tVodOvXTuwSxZDJT97Xlh7QolemmWM1yDWInC8mLg1W/PKnJXIwCu/hinxE9IoXwnBnyQUZkWvAOSxAw1cEpfjLKhlsZimPwovSV4=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by DM5PR12MB1802.namprd12.prod.outlook.com (2603:10b6:3:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 08:13:16 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::11) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 29 Jul 2022 08:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 08:13:16 +0000
Received: from [10.143.121.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 03:13:10 -0500
Message-ID: <b5d19b25-ebcc-fc4a-b95e-504430a63eb5@amd.com>
Date:   Fri, 29 Jul 2022 13:43:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
Subject: Re: [PATCH v2 2/4] drivers: misc: Add Support for TMR Manager
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
 <20220720060016.1646317-3-appana.durga.kedareswara.rao@amd.com>
 <YuKctxTbVnb3lUF3@kroah.com>
Content-Language: en-US
In-Reply-To: <YuKctxTbVnb3lUF3@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71acaa6-fe84-48a0-e91b-08da713a307e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1802:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nq5W1fzOiO/VB/2ogaoeH57E5oJsE7P5phG/Ln8yScuLb9Umk/DUczb7b6nXtxPXaGqtBZsbpcND+rUP8z7N8lX+UAeU4DLq5ArnERRB4/BnsZWuuMyDl8ZSKi3hbh+RoW9ej2dkArS77YP8XtJ8AtyMD43RMwuNkBwxLh0cseftZaTZCZGxCLxQ0zPzxVcmWg6/yiJcp8JW5IkEj7uAKsdKTZ5d3Bs4qHqHiMiZ0PpvacUXijeGie0jMTXPz/mkPUYhwYu0HJaSXqFcKPCltnh3T95XavZdJEGjwcM9UooDB2WwjzS1LNGVLIH7GFb1jnGgOfdtFJlxoHYjWhgHlSrcdZGQrGlztehd+04eEn6CPCbxRk+L7pCgy1M4JOulLORQkkTtwYUZMSzDNb5vroT5ckFsTvp9G52VMwulZhaRhYOY9Nj6iocWduRXTvKT7dIqcRDrZsyhSvH/gkX4lc5A3geTMTcpnOKEfNHqOul0nSVfkpPdMNAysaOjOZZJvP9PiOlZ/2qKfifgHFPttHQgQpq1Q+Dlxlx94g7jR3i2SyIe5TcepLXq1NF63qmc6ClM8wH4VXSUsADO5zYPYCgJ1hFayPaPui1j3SU1YdlDPoWa+N5pyc/Ess3v7oP88iWNZejLjBxvRbPHrrcUEfIm1G6wxItlQtSyiB5UigQSc20le/HUPboBxIWER4AcD0ifG93uhvPhPrhOK29pjbCT5mPtLU5suSQJJV41R6ZySFCdihEaVwFmcGwkIAEJHzzFf0EcCayrSxNdUgPvLRzyUCMYBTqJwmmUQfhPayw3LfjJ4zO1OsSubJtJCgTicJUo4/iogbadqFhPhB4nKhCozDZ8a6QAjDeJuG7p+Nd4dqKjvLf5ocwFYw7k39eN9tZ36VnPTfkOzSVN4CZU/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(31686004)(2906002)(53546011)(81166007)(82740400003)(478600001)(26005)(36756003)(40480700001)(82310400005)(8676002)(4326008)(70586007)(31696002)(70206006)(5660300002)(30864003)(8936002)(110136005)(16576012)(316002)(40460700003)(54906003)(36860700001)(6636002)(16526019)(186003)(426003)(47076005)(356005)(966005)(6666004)(41300700001)(107886003)(2616005)(83380400001)(336012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:13:16.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71acaa6-fe84-48a0-e91b-08da713a307e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1802
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

On 28/07/22 7:57 pm, Greg KH wrote:
> On Wed, Jul 20, 2022 at 11:30:14AM +0530, Appana Durga Kedareswara rao wrote:
>> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>
>> Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
>> subsystem is fault-tolerant and continues to operate nominally after
>> encountering an error. Together with the capability to detect and recover
>> from errors, the implementation ensures the reliability of the entire
>> subsystem.  TMR Manager is responsible for performing recovery of the
>> subsystem detects the fault via a break signal it invokes microblaze
>> software break handler which calls the tmr manager driver api to
>> update the error count and status, added support for fault detection
>> feature via sysfs interface.
>>
>> Usage:
>> To know the hardware status:
>> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
>> To know the break handler count(Error count):
>> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>> ---
>> Changes for v2:
>> --> Added Examples for sysfs entries
>> --> Removed uneeded struct dev from the driver private structure
>> --> Fixed style issues (Used resource_size_t instead of uintptr_t)
>> --> Updated driver to use sysfs_emit() API instead of sprintf() API
>> --> Added error checks wherever applicable.
>> --> Fixed sysfs registration.
>>   .../testing/sysfs-driver-xilinx-tmr-manager   |  27 ++
>>   MAINTAINERS                                   |   7 +
>>   drivers/misc/Kconfig                          |  10 +
>>   drivers/misc/Makefile                         |   1 +
>>   drivers/misc/xilinx_tmr_manager.c             | 253 ++++++++++++++++++
>>   5 files changed, 298 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>>   create mode 100644 drivers/misc/xilinx_tmr_manager.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>> new file mode 100644
>> index 000000000000..fc5fe7e22b09
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>> @@ -0,0 +1,27 @@
>> +What:		/sys/devices/platform/amba_pl/<dev>/status
>> +Date:		June 2022
>> +Contact:	appana.durga.rao@xilinx.com
>> +Description:	This control file provides the status of the tmr manager
>> +		useful for getting the status of fault.
>> +		This file cannot be written.
>> +		Example:
>> +		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
>> +		  Lockstep mismatch between processor 1 and 2
>> +		  Lockstep mismatch between processor 2 and 3
> 
> Why a whole long string?
To let user know about exact status of the TMR Subsystem(Manager) status

> 
> And this should only be 1 line, not multiple lines.  If it's multiple
> lines, this is NOT ok for a sysfs file.

Sure will fix in next version.
> 
>> +
>> +What:		/sys/devices/platform/amba_pl/<dev>/errcnt
>> +Date:		June 2022
>> +Contact:	appana.durga.rao@xilinx.com
>> +Description:	This control file provides the fault detection count.
>> +		This file cannot be written.
>> +		Example:
>> +		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
>> +		  1
>> +
>> +What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
>> +Date:		June 2022
>> +Contact:	appana.durga.rao@xilinx.com
>> +Description:	This control file enables the break signal.
>> +		This file is write only.
>> +		Example:
>> +		# echo 1 > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 651616ed8ae2..732fd9ae7d9f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13080,6 +13080,13 @@ W:	http://www.monstr.eu/fdt/
>>   T:	git git://git.monstr.eu/linux-2.6-microblaze.git
>>   F:	arch/microblaze/
>>   
>> +MICROBLAZE TMR MANAGER
>> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> +S:	Supported
>> +F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>> +F:	drivers/misc/xilinx_tmr_manager.c
>> +
>>   MICROCHIP AT91 DMA DRIVERS
>>   M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>>   M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 41d2bb0ae23a..555ae2e33b91 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -483,6 +483,16 @@ config OPEN_DICE
>>   
>>   	  If unsure, say N.
>>   
>> +config TMR_MANAGER
>> +	bool "Select TMR Manager"
>> +	depends on MICROBLAZE && MB_MANAGER
>> +	help
>> +	  This option enables the driver developed for TMR Manager. The Triple
>> +	  Modular Redundancy(TMR) manager provides support for fault detection
>> +	  via sysfs interface.
>> +
>> +	  Say N here unless you know what you are doing.
> 
> Not a module?
> 

Will fix in next version.
>> +
>>   source "drivers/misc/c2port/Kconfig"
>>   source "drivers/misc/eeprom/Kconfig"
>>   source "drivers/misc/cb710/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 70e800e9127f..28b9803f909b 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>>   obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>>   obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>>   obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
>> +obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
>> diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
>> new file mode 100644
>> index 000000000000..dbeca18c409f
>> --- /dev/null
>> +++ b/drivers/misc/xilinx_tmr_manager.c
>> @@ -0,0 +1,253 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx TMR Subsystem.
>> + *
>> + * Copyright (C) 2022 Xilinx, Inc.
>> + *
>> + * Description:
>> + * This driver is developed for TMR Manager,The Triple Modular Redundancy(TMR)
>> + * Manager is responsible for handling the TMR subsystem state, including
>> + * fault detection and error recovery. The core is triplicated in each of
>> + * the sub-blocks in the TMR subsystem, and provides majority voting of
>> + * its internal state provides soft error detection, correction and
>> + * recovery. Error detection feature is provided through sysfs
>> + * entries which allow the user to observer the TMR microblaze
>> + * status.
>> + */
>> +
>> +#include <asm/xilinx_mb_manager.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +
>> +/* TMR Manager Register offsets */
>> +#define XTMR_MANAGER_CR_OFFSET		0x0
>> +#define XTMR_MANAGER_FFR_OFFSET		0x4
>> +#define XTMR_MANAGER_CMR0_OFFSET	0x8
>> +#define XTMR_MANAGER_CMR1_OFFSET	0xC
>> +#define XTMR_MANAGER_BDIR_OFFSET	0x10
>> +#define XTMR_MANAGER_SEMIMR_OFFSET	0x1C
>> +
>> +/* Register Bitmasks/shifts */
>> +#define XTMR_MANAGER_CR_MAGIC1_MASK	GENMASK(7, 0)
>> +#define XTMR_MANAGER_CR_MAGIC2_MASK	GENMASK(15, 8)
>> +#define XTMR_MANAGER_CR_RIR_MASK	BIT(16)
>> +#define XTMR_MANAGER_FFR_LM12_MASK	BIT(0)
>> +#define XTMR_MANAGER_FFR_LM13_MASK	BIT(1)
>> +#define XTMR_MANAGER_FFR_LM23_MASK	BIT(2)
>> +
>> +#define XTMR_MANAGER_CR_MAGIC2_SHIFT	4
>> +#define XTMR_MANAGER_CR_RIR_SHIFT	16
>> +#define XTMR_MANAGER_CR_BB_SHIFT	18
>> +
>> +#define XTMR_MANAGER_MAGIC1_MAX_VAL	255
>> +
>> +/**
>> + * struct xtmr_manager_dev - Driver data for TMR Manager
>> + * @regs: device physical base address
>> + * @cr_val: control register value
>> + * @magic1: Magic 1 hardware configuration value
>> + * @err_cnt: error statistics count
>> + * @phys_baseaddr: Physical base address
>> + */
>> +struct xtmr_manager_dev {
>> +	void __iomem *regs;
>> +	u32 cr_val;
>> +	u32 magic1;
>> +	u32 err_cnt;
>> +	resource_size_t phys_baseaddr;
>> +};
>> +
>> +/* IO accessors */
>> +static inline void xtmr_manager_write(struct xtmr_manager_dev *xtmr_manager,
>> +				      u32 addr, u32 value)
>> +{
>> +	iowrite32(value, xtmr_manager->regs + addr);
>> +}
>> +
>> +static inline u32 xtmr_manager_read(struct xtmr_manager_dev *xtmr_manager,
>> +				    u32 addr)
>> +{
>> +	return ioread32(xtmr_manager->regs + addr);
>> +}
>> +
>> +static void xmb_manager_reset_handler(struct xtmr_manager_dev *xtmr_manager)
>> +{
>> +	/* Clear the FFR Register contents as a part of recovery process. */
>> +	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_FFR_OFFSET, 0);
>> +}
>> +
>> +static void xmb_manager_update_errcnt(struct xtmr_manager_dev *xtmr_manager)
>> +{
>> +	xtmr_manager->err_cnt++;
>> +}
>> +
>> +static ssize_t errcnt_show(struct device *dev, struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%x\n", xtmr_manager->err_cnt);
>> +}
>> +static DEVICE_ATTR_RO(errcnt);
>> +
>> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
>> +	size_t ffr;
>> +	int len = 0;
>> +
>> +	ffr = xtmr_manager_read(xtmr_manager, XTMR_MANAGER_FFR_OFFSET);
>> +	if ((ffr & XTMR_MANAGER_FFR_LM12_MASK) == XTMR_MANAGER_FFR_LM12_MASK) {
>> +		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
>> +		len += sysfs_emit_at(buf, len, "processor 1 and 2\n");
> 
> You can write a full string all at once, no need to call this twice.
> 

Sure will fix in next version.
>> +	}
>> +
>> +	if ((ffr & XTMR_MANAGER_FFR_LM13_MASK) == XTMR_MANAGER_FFR_LM13_MASK) {
>> +		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
>> +		len += sysfs_emit_at(buf, len, "processor 1 and 3\n");
>> +	}
>> +
>> +	if ((ffr & XTMR_MANAGER_FFR_LM23_MASK) == XTMR_MANAGER_FFR_LM23_MASK) {
>> +		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
>> +		len += sysfs_emit_at(buf, len, "processor 2 and 3\n");
>> +	}
> 
> As said above, multiple lines is not ok, you need to fix up this api.
> 
> Perhaps 3 files, one for eacy type of mismatch and a simple 0/1 value
> returned in them?
> 

Okay will fix in next version.

> 
>> +
>> +	return len;
>> +}
>> +static DEVICE_ATTR_RO(status);
>> +
>> +static ssize_t dis_block_break_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t size)
>> +{
>> +	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
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
> Why is 1 magic?
> 
> And we have a sysfs function to read a 0/1/Y/N/y/n value, please use
> that.

Sure will fix in next version.

Regards,
Kedar.
> 
> thanks,
> 
> greg k-h
