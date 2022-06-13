Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0F54A193
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiFMVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbiFMVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:36:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE09EF1;
        Mon, 13 Jun 2022 14:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0NTHd/3jHlKealZ+kU7FnhU4fKy3amtNeP/wiYYnDfHWXXvyPWQbqtOgK/G4nIls0rB1jdyrUTqCsMTPgImOzNj/xkUplcXJ6ycBTmEZj6i/YvYv9EO0XHV5GUEJY0aVVq7k0Jo2Th+g+ejNu3Mij8tJzmyREwl8k3zqM+zzuFmv2MQxit6qUNsBm9jwfEeFcIApAb92JdlXWC4fxHtKkJ7twmwujK7FYnF+D9WEdX1whKqIV6EQ+Wr/yKaRLJmsInJ7XdLUaqQTeD4CWNmUmbk1aJnxaR2asOvps89zlU9SXaYNPpUgGb3clyb1KzBcmXnfNxGd3FxgbwiQ/bncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szZ2Jq54xr8QLzI+rbJoUTgunRvlW5nsWf/6kMYElEo=;
 b=C+zp4ZVsj13Q5BL+Ip+EvXpjfuK4gsfAxPNh1fgWigw9dkiQpTBYZAhn5+L2M55qg5yuIKieawNOedqTDCeRKsRhUJzG0da0Ic5tWMTHdW06u8fC6iKMGk97UWmb1Tm2NX8dnbW55B1x1DUb9bZ5I6ZCYbSMrykW4AnXuj6lu1yZTAF7IwRfF6uF4AD5hyxw7RONNKCSNWYLG+DMc/HoHXFDEmfkXb+p28Ow5jTvAFaCGF47e+kivnGmkdB2ugZyEN4KZ1V8i8Ux5ktH24omPN0ut7zRgP0O0dzfC1FjBkYVtzhOgBw/FjDPF2IfoiUWNsjK6pYun2c+QQxTudXISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szZ2Jq54xr8QLzI+rbJoUTgunRvlW5nsWf/6kMYElEo=;
 b=LEG/xMVxgt0herjeT6c1hBD2lIddu+CRU+s+XFpZys/QseJvcnRuZfOCOcS5ZSilZqadsOna/lwHAZxT6+JrPnYDOiY+9KBVVPe7fYrCRAoQqvRexJdY53xQVcCmkJxaSQvABN13YLDhSJHvrfdZyMaDg+ieUJO6SCSGP69mvYM=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 21:36:14 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::7e) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Mon, 13 Jun 2022 21:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 21:36:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 14:36:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 14:36:12 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [10.23.122.97] (port=62985)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1o0rjI-0001dk-Lw; Mon, 13 Jun 2022 14:36:12 -0700
Message-ID: <30344b9c-fd6d-f797-7b89-e6ea75d4dc46@xilinx.com>
Date:   Mon, 13 Jun 2022 14:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v8 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <michal.simek@xilinx.com>,
        <ben.levinsky@xilinx.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-7-tanmay.shah@xilinx.com>
 <20220608173742.GA956547@p14s>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220608173742.GA956547@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317eda15-279a-477c-e973-08da4d84bda7
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB3879EC4092EF494F3E0C93B6CAAB9@DM5PR02MB3879.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1MF0fJEcRZmuuzdd3Z8vdwoa8ukk1xm+8mMYLiFg0O8dBWi+O9SgdMbUn5oWalrWebTK0tQHuyuUriNkBGo+8EZkn6cRlfo5i78saj3CALLz/1idaQQYSll43sYbYTH25kQj/UNI4bLWr7ZGHdnEsTGhcz965pOnWxRMnskVSZHSmDMvSqtBbZUDbBy7pIEuLr7jRkS2Pi697WtPwHtrtm/b+Z5YtvdEPmWag/WgxWJC0FonGhe/mADc0oDnc7Iz06l8QsVO3dNUcJUT5eCytohl+JwLVI7Kw+vM1IeJgfeA0+kbFnNY5wLDmucucPGt7Ot2W9n6MOpsdiVO/cGW2Em1hP0jZw2IDerMG/OkSIvp93XiNBsGvETl1OE5wXuA/fW0EAZlGe8KN5tVdQF6IiTlIzBFiTsLsEbYMmAHqMdT8KWjAB4VZlbCNseP9yfLknxeDGnC/5vujPFgHjvKQABExluu9obIdjnUfj2BVIqAM7ApJSSgS1a25P2Pq275eteSoiadgAsg4zZBu15K+EBeXZuvfw6jbMpoSHVZJ85OPL64+/oLxX+kUxMURgp99VGdGJZaQd6tUkUHDgqp2l4y46/2TdEGgGVvpO8Ho2K74HrUwmdxMBLV9ucjdQxc65mTQwWo7cUd1QFVpomM6klyqXs+eJYvfihCkuw1GAOj+DlI3xZYID5ZdUWgLp8oMG1eTjy8a7crXvCs6p4RgelaVkxtAyanUKleJ6s8mk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(47076005)(426003)(336012)(8676002)(4326008)(70206006)(70586007)(186003)(5660300002)(54906003)(2616005)(53546011)(83380400001)(6916009)(36756003)(31686004)(26005)(82310400005)(36860700001)(2906002)(30864003)(8936002)(356005)(7636003)(40460700003)(31696002)(508600001)(316002)(9786002)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 21:36:13.7704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317eda15-279a-477c-e973-08da4d84bda7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3879
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

I agree to all of the comments. I will address them in next revision.

Please find my response below for some comments:

Thanks,

Tanmay

On 6/8/22 10:37 AM, Mathieu Poirier wrote:
> On Thu, Jun 02, 2022 at 01:38:34PM -0700, Tanmay Shah wrote:
>> This driver enables r5f dual core Real time Processing Unit subsystem
>> available on Xilinx Zynq Ultrascale MPSoC Platform. RPU subsystem
>> (cluster) can be configured in different modes e.g. split mode in which
>> two r5f cores work independent of each other and lock-step mode in which
>> both r5f cores execute same code clock-for-clock and notify if the
>> result is different.
>>
>> The Xilinx r5 Remoteproc Driver boots the RPU cores via calls to the Xilinx
>> Platform Management Unit that handles the R5 configuration, memory access
>> and R5 lifecycle management. The interface to this manager is done in this
>> driver via zynqmp_pm_* function calls.
>>
>> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>> ---
>>
>> Changes in v8:
>>    - None
>>
>> Changes in v7:
>>    - None
>>
>> Changes in v6:
>>    - None
>>
>> Changes in v5:
>>    - None
>>
>> Changes in v4:
>>    - Remove redundant header files
>>    - use dev_err_probe() to report errors during probe
>>    - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
>>    - Fix memory leaks all over the driver when resource allocation fails for any core
>>    - make cluster mode check only at one place
>>    - remove redundant initialization of variable
>>    - remove redundant use of of_node_put()
>>    - Fix Comment format problem
>>    - Assign offset of zynqmp_tcm_banks instead of duplicating it
>>    - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
>>    - Remove rproc_mem_entry object from r5_core
>>    - Use put_device() and rproc_del() APIs to fix memory leaks
>>    - Replace pr_* with dev_*. This was missed in v3, fix now.
>>    - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was suggested by checkpatch script.
>>
>> Changes in v3:
>>    - Fix checkpatch script indentation warning
>>    - Remove unused variable from xilinx remoteproc driver
>>    - use C style comments, i.e /*...*/
>>    - Remove redundant debug information which can be derived using /proc/device-tree
>>    - Fix multilined comment format
>>    - s/"final fot TCM"/"final for TCM"
>>    - Function devm_kzalloc() does not return an code on error, just NULL.
>>      Remove redundant error check for this function throughout the driver.
>>    - Fix RPU mode configuration and add documentation accordingly
>>    - Get rid of the indentations to match function documentation style with rest of the driver
>>    - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
>>    - Use 'i' for the outer loop and 'j' for the inner one as per convention
>>    - Remove redundant error and NULL checks throughout the driver
>>    - Use devm_kcalloc() when more than one element is required
>>    - Add memory-regions carveouts during driver probe instead of parse_fw call
>>      This removes redundant copy of reserved_mem object in r5_core structure.
>>    - Fix memory leak by using of_node_put()
>>    - Fix indentation of tcm_mem_map function args
>>    - Remove redundant init of variables
>>    - Initialize tcm bank size variable for lockstep mode
>>    - Replace u32 with phys_addr_t for variable stroing memory bank address
>>    - Add documentation of TCM behavior in lockstep mode
>>    - Use dev_get_drvdata instead of platform driver API
>>    - Remove info level messages
>>    - Fix checkpatch.pl warnings
>>    - Add documentation for the Xilinx r5f platform to understand driver design
>>   drivers/remoteproc/Kconfig              |   12 +
>>   drivers/remoteproc/Makefile             |    1 +
>>   drivers/remoteproc/xlnx_r5_remoteproc.c | 1045 +++++++++++++++++++++++
>>   3 files changed, 1058 insertions(+)
>>   create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 166019786653..5637a71c0677 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -352,6 +352,18 @@ config TI_K3_R5_REMOTEPROC
>>   	  It's safe to say N here if you're not interested in utilizing
>>   	  a slave processor.
>>   
>> +config XLNX_R5_REMOTEPROC
>> +	tristate "Xilinx R5 remoteproc support"
>> +	depends on PM && ARCH_ZYNQMP
>> +	depends on ZYNQMP_FIRMWARE
>> +	select RPMSG_VIRTIO
>> +	select ZYNQMP_IPI_MBOX
>> +	help
>> +	  Say y or m here to support Xilinx R5 remote processors via the remote
>> +	  processor framework.
>> +
>> +	  It's safe to say N if not interested in using RPU r5f cores.
>> +
>>   endif # REMOTEPROC
>>   
>>   endmenu
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 5478c7cb9e07..91314a9b43ce 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -38,3 +38,4 @@ obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>>   obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>>   obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>>   obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>> +obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> new file mode 100644
>> index 000000000000..394b3469463c
>> --- /dev/null
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -0,0 +1,1045 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ZynqMP R5 Remote Processor driver
>> + *
>> + */
>> +
>> +#include <dt-bindings/power/xlnx-zynqmp-power.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/slab.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +/* settings for RPU cluster mode */
>> +enum zynqmp_r5_cluster_mode {
>> +	SPLIT_MODE = 0, /* When cores run as separate processor */
>> +	LOCKSTEP_MODE = 1, /* cores execute same code in lockstep,clk-for-clk */
>> +	SINGLE_CPU_MODE = 2, /* core0 is held in reset and only core1 runs */
>> +};
>> +
>> +/**
>> + * struct mem_bank_data - Memory Bank description
>> + *
>> + * @addr: Start address of memory bank
>> + * @size: Size of Memory bank
>> + * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
>> + * @bank_name: name of the bank for remoteproc framework
>> + */
>> +struct mem_bank_data {
>> +	phys_addr_t addr;
>> +	size_t size;
>> +	u32 pm_domain_id;
>> +	char *bank_name;
>> +};
>> +
>> +static const struct mem_bank_data zynqmp_tcm_banks[] = {
>> +	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
>> +	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
>> +	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
>> +	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>> +};
>> +
>> +/**
>> + * struct zynqmp_r5_core - ZynqMP R5 core structure
>> + *
>> + * @dev: device of RPU instance
>> + * @np: device node of RPU instance
>> + * @tcm_bank_count: number TCM banks accessible to this RPU
>> + * @tcm_banks: array of each TCM bank data
>> + * @rmem_count: Number of reserved mem regions
>> + * @rmem: reserved memory region nodes from device tree
>> + * @rproc: rproc handle
>> + * @pm_domain_id: RPU CPU power domain id
>> + */
>> +struct zynqmp_r5_core {
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	int tcm_bank_count;
>> +	struct mem_bank_data **tcm_banks;
>> +	int rmem_count;
>> +	struct reserved_mem **rmem;
>> +	struct rproc *rproc;
>> +	u32 pm_domain_id;
>> +};
>> +
>> +/**
>> + * struct zynqmp_r5_cluster - ZynqMP R5 cluster structure
>> + *
>> + * @dev: r5f subsystem cluster device node
>> + * @mode: cluster mode of type zynqmp_r5_cluster_mode
>> + * @core_count: number of r5 cores used for this cluster mode
>> + * @r5_cores: Array of pointers pointing to r5 core
>> + */
>> +struct zynqmp_r5_cluster {
>> +	struct device *dev;
>> +	enum  zynqmp_r5_cluster_mode mode;
>> +	int core_count;
>> +	struct zynqmp_r5_core **r5_cores;
>> +};
>> +
>> +/*
>> + * zynqmp_r5_set_mode - set RPU operation mode
>> + *
>> + * set RPU operation mode
>> + *
>> + * Return: 0 for success, negative value for failure
>> + */
>> +static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>> +			      enum rpu_oper_mode fw_reg_val,
>> +			      enum rpu_tcm_comb tcm_mode)
>> +{
>> +	int ret;
>> +
>> +	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> +	if (ret < 0) {
>> +		dev_err(r5_core->dev, "failed to set RPU mode\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> +	if (ret < 0)
>> +		dev_err(r5_core->dev, "failed to configure TCM\n");
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_start
>> + * @rproc: single R5 core's corresponding rproc instance
>> + *
>> + * Start R5 Core from designated boot address.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core = rproc->priv;
>> +	enum rpu_boot_mem bootmem;
>> +	int ret;
>> +
>> +	/*
>> +	 * The exception vector pointers (EVP) refer to the base-address of
>> +	 * exception vectors (for reset, IRQ, FIQ, etc). The reset-vector
>> +	 * starts at the base-address and subsequent vectors are on 4-byte
>> +	 * boundaries.
>> +	 *
>> +	 * Exception vectors can start either from 0x0000_0000 (LOVEC) or
>> +	 * from 0xFFFF_0000 (HIVEC) which is mapped in the OCM (On-Chip Memory)
>> +	 *
>> +	 * Usually firmware will put Exception vectors at LOVEC.
>> +	 *
>> +	 * It is not recommend that you change the exception vector.
>> +	 * Changing the EVP to HIVEC will result in increased interrupt latency
>> +	 * and jitter. Also, if the OCM is secured and the Cortex-R5F processor
>> +	 * is non-secured, then the Cortex-R5F processor cannot access the
>> +	 * HIVEC exception vectors in the OCM.
>> +	 */
>> +	bootmem = (rproc->bootaddr >= 0xFFFC0000) ?
>> +		   PM_RPU_BOOTMEM_HIVEC : PM_RPU_BOOTMEM_LOVEC;
>> +
>> +	dev_dbg(r5_core->dev, "RPU boot addr 0x%llx from %s.", rproc->bootaddr,
>> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
>> +
>> +	ret = zynqmp_pm_request_wake(r5_core->pm_domain_id, 1,
>> +				     bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
>> +	if (ret)
>> +		dev_err(r5_core->dev,
>> +			"failed to start RPU = 0x%x\n", r5_core->pm_domain_id);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_stop
>> + * @rproc: single R5 core's corresponding rproc instance
>> + *
>> + * Power down  R5 Core.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core = rproc->priv;
>> +	int ret;
>> +
>> +	ret = zynqmp_pm_force_pwrdwn(r5_core->pm_domain_id,
>> +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +	if (ret)
>> +		dev_err(r5_core->dev, "failed to stop remoteproc RPU %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_mem_region_map
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to map
>> + *
>> + * Callback to map va for memory-region's carveout.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_mem_region_map(struct rproc *rproc,
>> +				    struct rproc_mem_entry *mem)
>> +{
>> +	void __iomem *va;
>> +
>> +	va = ioremap_wc(mem->dma, mem->len);
>> +	if (IS_ERR_OR_NULL(va))
>> +		return -ENOMEM;
>> +
>> +	mem->va = (void *)va;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_mem_unmap
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to unmap
>> + *
>> + * Unmap memory-region carveout
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
>> +				      struct rproc_mem_entry *mem)
>> +{
>> +	iounmap((void __iomem *)mem->va);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * add_mem_regions
>> + * @r5_core: single R5 core's corresponding zynqmp_r5_core type instance
>> + * @rmem: reserved mem region parsed from dt node
>> + *
>> + * Construct rproc mem carveouts from carveout provided in
>> + * memory-region property
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int add_mem_regions_carveout(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct reserved_mem *rmem;
>> +	struct rproc_mem_entry **rproc_mem;
>> +	int i, num_mem_regions;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	num_mem_regions = r5_core->rmem_count;
>> +
>> +	/* memory regions not defined */
>> +	if (num_mem_regions < 1)
>> +		return 0;
> This can't happen as per zynqmp_r5_get_mem_region_node().


That's right. I will fix this in zynqmp_r5_get_mem_region_node().

As memory-region is not required property, we return successfully if 
memory regions are not defined.

So, zynqmp_r5_get_mem_region_node() should not fail if memory-region 
property is not found.


>
>> +
>> +	rproc_mem = kcalloc(num_mem_regions,
>> +			    sizeof(struct rproc_mem_entry *), GFP_KERNEL);
>> +	if (!rproc_mem)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_mem_regions; i++) {
>> +		rmem = r5_core->rmem[i];
>> +
>> +		/* Register associated reserved memory regions */
>> +		rproc_mem[i] = rproc_mem_entry_init(&rproc->dev, NULL,
>> +						    (dma_addr_t)rmem->base,
>> +						    rmem->size, rmem->base,
>> +						    zynqmp_r5_mem_region_map,
>> +						    zynqmp_r5_mem_region_unmap,
>> +						    rmem->name);
> Any reason you need to call rproc_mem_entry_init() on the vdev0buffers?

Thanks for this pointer.

Actually this is remoteproc driver only and I was only considering to 
add only fw-image memory-region.

But, as this is generic function for all the memory regions, I think I 
should handle other regions as well.

I believe there is no code change needed to add virngs.

However, for vdev*buffers I will use "rproc_of_resm_mem_entry_init()".


>> +		if (!rproc_mem[i])
>> +			goto release_mem_regions;
>> +
>> +		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
>> +			rmem->name, rmem->base, rmem->size);
>> +	}
>> +
>> +	/*
>> +	 * Add carveouts only if all rproc mem enties are
>> +	 * successfully initialized
>> +	 */
>> +	for (i = 0; i < num_mem_regions; i++)
>> +		rproc_add_carveout(rproc, rproc_mem[i]);
>> +
>> +	kfree(rproc_mem);
>> +	return 0;
>> +
>> +release_mem_regions:
>> +	for (i--; i > -1; i--)
>> +		kfree(rproc_mem[i]);
>> +	kfree(rproc_mem);
>> +	return -ENOMEM;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_mem_unmap
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to unmap
>> + *
>> + * Unmap TCM banks when powering down R5 core.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int tcm_mem_unmap(struct rproc *rproc, struct rproc_mem_entry *mem)
>> +{
>> +	iounmap((void __iomem *)mem->va);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * tcm_mem_map
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to initialize the va and da fields of
>> + *
>> + * Given TCM bank entry, this callback will set device address for R5
>> + * running on TCM and also setup virtual address for TCM bank
>> + * remoteproc carveout.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int tcm_mem_map(struct rproc *rproc,
>> +		       struct rproc_mem_entry *mem)
>> +{
>> +	void __iomem *va;
>> +
>> +	va = ioremap_wc(mem->dma, mem->len);
>> +	if (IS_ERR_OR_NULL(va))
>> +		return -ENOMEM;
>> +
>> +	/* Update memory entry va */
>> +	mem->va = (void *)va;
>> +
>> +	/* clear TCMs */
>> +	memset_io(va, 0, mem->len);
>> +
>> +	/*
>> +	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
>> +	 * while on the Linux side they are at 0xffexxxxx.
>> +	 *
>> +	 * Zero out the high 12 bits of the address. This will give
>> +	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
>> +	 */
>> +	mem->da &= 0x000fffff;
>> +
>> +	/*
>> +	 * TCM Banks 1A and 1B still have to be translated.
>> +	 *
>> +	 * Below handle these two banks' absolute addresses (0xffe90000 and
>> +	 * 0xffeb0000) and convert to the expected relative addresses
>> +	 * (0x0 and 0x20000).
>> +	 */
>> +	if (mem->da == 0x90000 || mem->da == 0xB0000)
>> +		mem->da -= 0x90000;
>> +
>> +	/* if translated TCM bank address is not valid report error */
>> +	if (mem->da != 0x0 && mem->da != 0x20000) {
>> +		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int add_tcm_carveout_split_mode(struct rproc *rproc)
>> +{
>> +	int i, num_banks, ret;
>> +	struct rproc_mem_entry **rproc_mem;
>> +	u32 pm_domain_id;
>> +	phys_addr_t bank_addr;
>> +	size_t bank_size;
>> +	char *bank_name;
>> +	struct device *dev;
>> +	struct zynqmp_r5_core *r5_core;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +
>> +	dev = r5_core->dev;
>> +
>> +	/* go through zynqmp banks for r5 node */
>> +	num_banks = r5_core->tcm_bank_count;
>> +	if (num_banks <= 0) {
>> +		dev_err(dev, "need to specify TCM banks\n");
>> +		return -EINVAL;
>> +	}
> This check should be done in zynqmp_r5_get_tcm_node(), please remove.  Same
> comment for add_tcm_carveout_lockstep_mode().
>
>> +
>> +	rproc_mem = kcalloc(num_banks,
>> +			    sizeof(struct rproc_mem_entry *), GFP_KERNEL);
>> +	if (!rproc_mem)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Power-on Each 64KB TCM,
>> +	 * register its address space, map and unmap functions
>> +	 * and add carveouts accordingly
>> +	 */
>> +	for (i = 0; i < num_banks; i++) {
>> +		bank_addr = r5_core->tcm_banks[i]->addr;
>> +		bank_name = r5_core->tcm_banks[i]->bank_name;
>> +		bank_size = r5_core->tcm_banks[i]->size;
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +
>> +		ret = zynqmp_pm_request_node(pm_domain_id,
>> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
>> +			goto release_tcm_split;
>> +		}
>> +
>> +		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, size=0x%lx",
>> +			bank_name, bank_addr, bank_size);
>> +
>> +		rproc_mem[i] = rproc_mem_entry_init(dev, NULL, bank_addr,
>> +						    bank_size, bank_addr,
>> +						    tcm_mem_map, tcm_mem_unmap,
>> +						    bank_name);
>> +		if (!rproc_mem[i]) {
>> +			ret = -ENOMEM;
>> +			goto release_tcm_split;
> If we end up here function zynqmp_pm_release_node() would not be called for the
> bank that was powered just above.
>
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Add carveouts only if all rproc mem enties are
>> +	 * successfully initialized
>> +	 */
>> +	for (i = 0; i < num_banks; i++)
>> +		rproc_add_carveout(rproc, rproc_mem[i]);
>> +
>> +	kfree(rproc_mem);
>> +	return 0;
>> +
>> +release_tcm_split:
>> +	/* If failed, Turn off all TCM banks turned on before */
>> +	for (i--; i > -1; i--) {
> I have already commented on this, please apply throughout.
>
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +		zynqmp_pm_release_node(pm_domain_id);
>> +		kfree(rproc_mem[i]);
>> +	}
>> +	kfree(rproc_mem);
>> +	return ret;
>> +}
>> +
>> +static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>> +{
>> +	int i, num_banks, ret;
>> +	struct rproc_mem_entry *rproc_mem;
>> +	u32 pm_domain_id;
>> +	phys_addr_t bank_addr;
>> +	size_t bank_size = 0;
>> +	char *bank_name;
>> +	struct device *dev;
>> +	struct zynqmp_r5_core *r5_core;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	dev = r5_core->dev;
>> +
>> +	/* Go through zynqmp banks for r5 node */
>> +	num_banks = r5_core->tcm_bank_count;
>> +	if (num_banks <= 0) {
>> +		dev_err(dev, "need to specify TCM banks\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * In lockstep mode, TCM is contiguous memory block
>> +	 * However, each TCM block still needs to be enabled individually.
>> +	 * So, Enable each TCM block individually, but add their size
>> +	 * to create contiguous memory region.
>> +	 */
>> +	bank_addr = r5_core->tcm_banks[0]->addr;
>> +	bank_name = r5_core->tcm_banks[0]->bank_name;
>> +
>> +	for (i = 0; i < num_banks; i++) {
>> +		bank_size += r5_core->tcm_banks[i]->size;
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +
>> +		/* Turn on each TCM bank individually */
>> +		ret = zynqmp_pm_request_node(pm_domain_id,
>> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
>> +			goto release_tcm_lockstep;
>> +		}
>> +	}
>> +
>> +	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
>> +		bank_name, bank_addr, bank_size);
>> +
>> +	/* Register TCM address range, TCM map and unmap functions */
>> +	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
>> +					 bank_size, bank_addr,
>> +					 tcm_mem_map, tcm_mem_unmap,
>> +					 bank_name);
>> +	if (!rproc_mem) {
>> +		ret = -ENOMEM;
>> +		goto release_tcm_lockstep;
>> +	}
>> +
>> +	/* If registration is success, add carveouts */
>> +	rproc_add_carveout(rproc, rproc_mem);
>> +
>> +	return 0;
>> +
>> +release_tcm_lockstep:
>> +	/* If failed, Turn off all TCM banks turned on before */
>> +	for (i--; i > -1; i--) {
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +		zynqmp_pm_release_node(pm_domain_id);
>> +	}
>> +	return ret;
>> +}
>> +
>> +/*
>> + * add_tcm_banks()
>> + * @rproc: single R5 core's corresponding rproc instance
>> + *
>> + * Given R5 node in remoteproc instance
>> + * allocate remoteproc carveout for TCM memory
>> + * needed for firmware to be loaded
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int add_tcm_banks(struct rproc *rproc)
>> +{
>> +	struct device *dev;
>> +	struct zynqmp_r5_cluster *cluster;
>> +	struct zynqmp_r5_core *r5_core;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +	if (!r5_core)
>> +		return -EINVAL;
>> +
>> +	dev = r5_core->dev;
>> +
>> +	cluster = dev_get_drvdata(dev->parent);
>> +	if (!cluster) {
>> +		dev_err(dev->parent, "Invalid driver data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
>> +	 * In split mode, each TCM bank is 64Kb and not contiguous.
>> +	 * We add memory carveouts accordingly.
>> +	 */
>> +	if (cluster->mode == SPLIT_MODE)
>> +		return add_tcm_carveout_split_mode(rproc);
>> +	else if (cluster->mode == LOCKSTEP_MODE)
>> +		return add_tcm_carveout_lockstep_mode(rproc);
>> +
>> +	dev_err(cluster->dev, "invalid cluster mode\n");
>> +	return -EINVAL;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_parse_fw()
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @fw: ptr to firmware to be loaded onto r5 core
>> + *
>> + * When loading firmware, ensure the necessary carveouts are in remoteproc
> There are no checks done to that effect in the function...
Thanks. This documentation is old. I will remove above line and fix 
description.
>
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	int ret;
>> +
>> +	ret = rproc_elf_load_rsc_table(rproc, fw);
>> +	if (ret == -EINVAL) {
>> +		/*
>> +		 * resource table only required for IPC.
>> +		 * if not present, this is not necessarily an error;
>> +		 * for example, loading r5 hello world application
>> +		 * so simply inform user and keep going.
>> +		 */
>> +		dev_info(&rproc->dev, "no resource table found.\n");
>> +		ret = 0;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = add_tcm_banks(rproc);
>> +	if (ret) {
>> +		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = add_mem_regions_carveout(rproc);
>> +	if (ret)
>> +		dev_warn(&rproc->dev, "failed to get reserve mem regions %d\n",
>> +			 ret);
>> +
>> +	return 0;
>> +}
>> +
>> +static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_core *r5_core;
>> +	int i;
>> +	u32 pm_domain_id;
>> +
>> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +
>> +	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>> +		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>> +		if (zynqmp_pm_release_node(pm_domain_id))
>> +			dev_warn(r5_core->dev,
>> +				 "can't turn off TCM bank 0x%x", pm_domain_id);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct rproc_ops zynqmp_r5_rproc_ops = {
>> +	.prepare	= zynqmp_r5_rproc_prepare,
>> +	.unprepare	= zynqmp_r5_rproc_unprepare,
>> +	.start		= zynqmp_r5_rproc_start,
>> +	.stop		= zynqmp_r5_rproc_stop,
>> +	.load		= rproc_elf_load_segments,
>> +	.parse_fw	= zynqmp_r5_parse_fw,
>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>> +	.sanity_check	= rproc_elf_sanity_check,
>> +	.get_boot_addr	= rproc_elf_get_boot_addr,
>> +};
>> +
>> +/**
>> + * zynqmp_r5_add_rproc_core()
>> + * Probes ZynqMP R5 processor device node
>> + * this is called for each individual R5 core
>> + *
>> + * @cdev: Device node of each r5 core
>> + *
>> + * Return: zynqmp_r5_core object for success, error pointer in case of error.
>> + */
>> +static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>> +{
>> +	int ret;
>> +	struct rproc *r5_rproc;
>> +	struct zynqmp_r5_core *r5_core;
>> +
>> +	/* Set up DMA mask */
>> +	ret = dma_set_coherent_mask(cdev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	/* Allocate remoteproc instance */
>> +	r5_rproc = devm_rproc_alloc(cdev, dev_name(cdev),
>> +				    &zynqmp_r5_rproc_ops,
>> +				    NULL, sizeof(struct zynqmp_r5_core));
>> +	if (!r5_rproc) {
>> +		dev_err(cdev, "failed to allocate memory for rproc instance\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	r5_rproc->auto_boot = false;
>> +	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
>> +	r5_core->dev = cdev;
>> +	r5_core->np = dev_of_node(cdev);
>> +	if (!r5_core->np) {
>> +		dev_err(cdev, "can't get device node for r5 core\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	/* Add R5 remoteproc core */
>> +	ret = rproc_add(r5_rproc);
>> +	if (ret) {
>> +		dev_err(cdev, "failed to add r5 remoteproc\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	r5_core->rproc = r5_rproc;
>> +	return r5_core;
>> +}
>> +
>> +/**
>> + * zynqmp_r5_get_tcm_node()
>> + * Ideally this function should parse tcm node and store information
>> + * in r5_core instance. We will use hardcoded TCM information from
>> + * driver for now in this function.
>> + *
>> + * @cluster: pointer to zynqmp_r5_cluster type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>> +{
>> +	int tcm_bank_count, tcm_node;
>> +	int i, j;
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct device *dev = cluster->dev;
>> +
>> +	/*
>> +	 * ToDo: Use predefined TCM address space values from driver until
>> +	 * system-dt spec is not final for TCM
>> +	 */
>> +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
>> +
>> +	/* count per core tcm banks */
>> +	tcm_bank_count = tcm_bank_count / cluster->core_count;
>> +
>> +	/*
>> +	 * r5 core 0 will use all of TCM banks in lockstep mode.
>> +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
>> +	 * 128k. Assign TCM banks to each core accordingly
>> +	 */
>> +	tcm_node = 0;
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>> +						  sizeof(struct mem_bank_data *),
>> +						  GFP_KERNEL);
>> +		if (!r5_core->tcm_banks)
>> +			return -ENOMEM;
>> +
>> +		for (j = 0; j < tcm_bank_count; j++) {
>> +			/*
>> +			 * Use pre-defined TCM reg values.
>> +			 * Eventually this should be replaced by values
>> +			 * parsed from dts.
>> +			 */
>> +			r5_core->tcm_banks[j] =
>> +				(struct mem_bank_data *)&zynqmp_tcm_banks[tcm_node];
>> +			tcm_node++;
>> +		}
>> +
>> +		r5_core->tcm_bank_count = tcm_bank_count;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * zynqmp_r5_get_mem_region_node()
>> + * parse memory-region property from dt node and add
>> + * memory region carveouts
>> + *
>> + * @r5_core: pointer to zynqmp_r5_core type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
>> +{
>> +	int res_mem_count, i;
>> +	struct device *dev;
>> +	struct device_node *np, *rmem_np;
>> +	struct reserved_mem **rmem;
>> +
>> +	dev = r5_core->dev;
>> +
>> +	np = r5_core->np;
>> +
>> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>> +							sizeof(phandle));
>> +	if (res_mem_count <= 0) {
>> +		dev_warn(dev, "failed to get memory-region property %d\n",
>> +			 res_mem_count);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rmem = devm_kcalloc(dev, res_mem_count,
>> +			    sizeof(struct reserved_mem *), GFP_KERNEL);
>> +	if (!rmem)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < res_mem_count; i++) {
>> +		rmem_np = of_parse_phandle(np, "memory-region", i);
>> +		if (!rmem_np)
>> +			goto release_rmem;
>> +
>> +		rmem[i] = of_reserved_mem_lookup(rmem_np);
>> +		if (!rmem[i]) {
>> +			of_node_put(rmem_np);
>> +			goto release_rmem;
>> +		}
>> +
>> +		of_node_put(rmem_np);
>> +	}
>> +
>> +	r5_core->rmem_count = res_mem_count;
>> +	r5_core->rmem = rmem;
>> +	return 0;
>> +
>> +release_rmem:
>> +	for (i--; i > -1; i--)
>> +		kfree(rmem[i]);
>> +	devm_kfree(dev, rmem);
>> +	return -ENOMEM;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_core_init()
>> + * Create and initialize zynqmp_r5_core type object
>> + *
>> + * @cluster: pointer to zynqmp_r5_cluster type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>> +			       enum rpu_oper_mode fw_reg_val, int tcm_mode)
>> +{
>> +	int ret, i;
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct device *dev = cluster->dev;
>> +
>> +	ret = zynqmp_r5_get_tcm_node(cluster);
>> +	if (ret < 0) {
>> +		dev_err(dev, "can't get tcm node, err %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +
>> +		ret = zynqmp_r5_get_mem_region_node(r5_core);
>> +		if (ret)
>> +			dev_warn(dev, "memory-region prop failed %d\n", ret);
>> +
>> +		/* Initialize r5 cores with power-domains parsed from dts */
>> +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>> +						 1, &r5_core->pm_domain_id);
>> +		if (ret) {
>> +			dev_err(dev, "failed to get power-domains property\n");
>> +			return ret;
>> +		}
>> +
>> +		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
>> +		if (ret) {
>> +			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
>> +				cluster->mode, ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_cluster_init()
>> + * Create and initialize zynqmp_r5_cluster type object
>> + *
>> + * @cluster: pointer to zynqmp_r5_cluster type object
>> + *
>> + * Return: 0 for success and error code for failure.
>> + */
>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>> +{
>> +	struct device *dev = cluster->dev;
>> +	struct device_node *dev_node = dev_of_node(dev);
>> +	struct device_node *child;
>> +	struct platform_device *child_pdev;
>> +	int core_count, ret, i;
>> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
>> +	struct zynqmp_r5_core **r5_cores;
>> +	enum rpu_tcm_comb tcm_mode;
>> +	enum rpu_oper_mode fw_reg_val;
>> +
>> +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
>> +
>> +	/*
>> +	 * on success returns 0, if not defined then returns -EINVAL,
>> +	 * In that case, default is LOCKSTEP mode
>> +	 */
>> +	if (ret != -EINVAL && ret != 0) {
>> +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * For now driver only supports split mode and lockstep mode.
>> +	 * fail driver probe if either of that is not set in dts.
>> +	 */
>> +	if (cluster_mode == LOCKSTEP_MODE) {
>> +		tcm_mode = PM_RPU_TCM_COMB;
>> +		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
>> +	} else if (cluster_mode == SPLIT_MODE) {
>> +		tcm_mode = PM_RPU_TCM_SPLIT;
>> +		fw_reg_val = PM_RPU_MODE_SPLIT;
>> +	} else {
>> +		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Number of cores is decided by number of child nodes of
>> +	 * r5f subsystem node in dts. If Split mode is used in dts
>> +	 * 2 child nodes are expected.
>> +	 * In lockstep mode if two child nodes are available,
>> +	 * only use first child node and consider it as core0
>> +	 * and ignore core1 dt node.
>> +	 */
>> +	core_count = of_get_available_child_count(dev_node);
>> +	if (core_count <= 0) {
>> +		dev_err(dev, "Invalid number of r5 cores %d", core_count);
>> +		return -EINVAL;
>> +	} else if (cluster_mode == SPLIT_MODE && core_count != 2) {
>> +		dev_err(dev, "Invalid number of r5 cores for split mode\n");
>> +		return -EINVAL;
>> +	} else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
>> +		dev_warn(dev, "Only r5 core0 will be used\n");
>> +		core_count = 1;
>> +	}
>> +
>> +	r5_cores = kcalloc(core_count,
>> +			   sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
>> +	if (!r5_cores)
>> +		return -ENOMEM;
>> +
>> +	i = 0;
>> +	for_each_available_child_of_node(dev_node, child) {
>> +		child_pdev = of_find_device_by_node(child);
>> +		if (!child_pdev) {
>> +			of_node_put(child);
>> +			ret = -ENODEV;
>> +			goto release_r5_cores;
>> +		}
>> +
>> +		/* create and add remoteproc instance of type struct rproc */
>> +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>> +		if (IS_ERR(r5_cores[i])) {
>> +			of_node_put(child);
>> +			ret = PTR_ERR(r5_cores[i]);
>> +			goto release_r5_cores;
>> +		}
>> +
>> +		i++;
>> +
>> +		/*
>> +		 * If two child nodes are available in dts in lockstep mode,
>> +		 * then ignore second child node.
>> +		 */
>> +		if (i == core_count) {
>> +			of_node_put(child);
>> +			break;
>> +		}
>> +	}
>> +
>> +	cluster->mode = cluster_mode;
>> +	cluster->core_count = core_count;
>> +	cluster->r5_cores = r5_cores;
>> +
>> +	ret = zynqmp_r5_core_init(cluster, fw_reg_val, tcm_mode);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to init r5 core err %d\n", ret);
>> +		cluster->core_count = 0;
>> +		cluster->r5_cores = NULL;
>> +		goto release_r5_cores;
>> +	}
>> +
>> +	return 0;
>> +
>> +release_r5_cores:
>> +	for (i--; i > -1; i--) {
>> +		put_device(r5_cores[i]->dev);
>> +		rproc_del(r5_cores[i]->rproc);
>> +	}
>> +	kfree(r5_cores);
>> +	return ret;
>> +}
>> +
>> +static void zynqmp_r5_core_exit(struct zynqmp_r5_core *r5_core)
>> +{
>> +	/* release r5_core device */
>> +	put_device(r5_core->dev);
>> +
>> +	rproc_del(r5_core->rproc);
>> +}
>> +
>> +static void zynqmp_r5_cluster_exit(void *data)
>> +{
>> +	struct platform_device *pdev = (struct platform_device *)data;
>> +	struct zynqmp_r5_cluster *cluster;
>> +	int i;
>> +
>> +	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
>> +	if (!cluster)
>> +		return;
>> +
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		zynqmp_r5_core_exit(cluster->r5_cores[i]);
>> +		cluster->r5_cores[i] = NULL;
>> +	}
>> +
>> +	kfree(cluster->r5_cores);
>> +	kfree(cluster);
>> +	platform_set_drvdata(pdev, NULL);
>> +}
>> +
>> +/*
>> + * zynqmp_r5_remoteproc_probe()
>> + *
>> + * @pdev: domain platform device for R5 cluster
>> + *
>> + * called when driver is probed, for each R5 core specified in DT,
>> + * setup as needed to do remoteproc-related operations
>> + *
>> + * Return: 0 for success, negative value for failure.
>> + */
>> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct zynqmp_r5_cluster *cluster;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	cluster = kzalloc(sizeof(*cluster), GFP_KERNEL);
>> +	if (!cluster)
>> +		return -ENOMEM;
>> +
>> +	cluster->dev = dev;
>> +
>> +	ret = devm_of_platform_populate(dev);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "failed to populate platform dev\n");
>> +		kfree(cluster);
>> +		return ret;
>> +	}
>> +
>> +	/* wire in so each core can be cleaned up at driver remove */
>> +	platform_set_drvdata(pdev, cluster);
>> +
>> +	ret = zynqmp_r5_cluster_init(cluster);
>> +	if (ret) {
>> +		zynqmp_r5_cluster_exit(pdev);
>> +		dev_err_probe(dev, ret, "Invalid r5f subsystem device tree\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> I am still not convinced you need to use the devm_add_action_or_reset() API as
> opposed to a simple platform_driver::remove function, but this is something we
> can tackle in another revision.
Ok for now, I will keep it as it is.
> I am done reviewing this driver.
>
> Thanks,
> Mathieu
>
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Match table for OF platform binding */
>> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>> +	{ .compatible = "xlnx,zynqmp-r5fss", },
>> +	{ /* end of list */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>> +
>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
>> +	.probe = zynqmp_r5_remoteproc_probe,
>> +	.driver = {
>> +		.name = "zynqmp_r5_remoteproc",
>> +		.of_match_table = zynqmp_r5_remoteproc_match,
>> +	},
>> +};
>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
>> +
>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
>> +MODULE_AUTHOR("Xilinx Inc.");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1
>>
