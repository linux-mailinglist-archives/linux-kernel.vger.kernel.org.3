Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103374BEF59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiBVCNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:13:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiBVCNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:13:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B812ACB;
        Mon, 21 Feb 2022 18:13:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR79sKdBg5Z7uvAfCSW6mqh1d/3JmWwSnmN91RLsHQCdw7n0a7/c1iLAM3ozgGWJ8NWfLyiJChqVlj0mYD4LJKzb0tgFYs93GZyCkli52pbzii4rvi13RLUXZwaffBiwysIfs5NGNcFSztjedujCP3XPT89R5lDvqMA3EVAL1ACkpKXIbv9+owg61cIPvtVzDhcL/UbRuqexZJieK2W9a/GFdJSOB+b2V+sMSPRzbHvRz6m/am3uJoUNA8yCSwqzLxbG18+Aq7S1a4FyE9reu3Q/2SVP5+u6JtcpeWCfCg4uQnky61y+BIveV3Gy/4W1LYhC/Hsgf485Gofo2Ol5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbaN5l3E1+HVBg/+SXgBl3gkC6lDaqAo54f+5Eq01xQ=;
 b=RVfo15D7XU5i6S/WWm6D+ASgHpjFVCg6jwQrQbgrbxWqifOclWwnrI/dwiQe/ZY77CfJzKXAgWqBEw5iYP9NdfmfXlMQxFr0K2/uQJshlj/zmSeHLlhE+WpA9mV/nT5+vJivB+4tOHxWGGAUpdm6VOPlH220ZeizYq8MfB79ZzbR8GHQX0YVQqmluYQR6st2iCveUI7cjDSxeN/CES7rj/DA6TcpwlPSbFfcW25DW2Da9oD6k2LTJe67QG8JwGhCrmz3YKULl5b11yXIbZV7FiaJsNwyIrmvQVl/OrTH5+ewYQv4DqHXYmKzgrdUx4wOIGexFKqBgfs+Btgsl8TuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbaN5l3E1+HVBg/+SXgBl3gkC6lDaqAo54f+5Eq01xQ=;
 b=eiQSG0GJevpUlWi7pBoAe0OA7bPanK5CMJrojNKTenU9w6HNyGXx7OzkAE3q79RzfpNKFjOqwY0spf/VtMO+iQZcT241vUjjMxHsARXCvpoTkdGuCp97JKSXACwWzWVXrOEG1C94bxJ+7aqMA+NT7TOhZK4btEeOcBUMuzgzHSM=
Received: from SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::11)
 by BY5PR02MB6369.namprd02.prod.outlook.com (2603:10b6:a03:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 02:13:20 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::d9) by SA9P221CA0006.outlook.office365.com
 (2603:10b6:806:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Tue, 22 Feb 2022 02:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 22 Feb 2022 02:13:19 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 02:13:18 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 02:13:18 +0000
Envelope-to: michal.simek@xilinx.com,
 ben.levinsky@xilinx.com,
 sergei.korneichuk@xilinx.com,
 arun.balaji.kannan@xilinx.com,
 mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.71.118.67] (port=49775)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nMKg0-000163-VE; Tue, 22 Feb 2022 02:13:17 +0000
Message-ID: <6a9dcca9-3c86-f603-d13a-acc74161f1a1@xilinx.com>
Date:   Mon, 21 Feb 2022 18:13:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
From:   Tanmay Shah <tanmay.shah@xilinx.com>
Subject: Re: [PATCH v3 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <laurent.pinchart@ideasonboard.com>,
        <ben.levinsky@xilinx.com>, <bill.mills@linaro.org>,
        <sergei.korneichuk@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-7-tanmay.shah@xilinx.com>
 <20220218191150.GB574087@p14s>
Content-Language: en-US
In-Reply-To: <20220218191150.GB574087@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eade9e57-76b5-402f-163b-08d9f5a8e56a
X-MS-TrafficTypeDiagnostic: BY5PR02MB6369:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB63699088B41A0A64ACCA5DBCCA3B9@BY5PR02MB6369.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaNcGDiiRfxXA8dG6iQNzPmg7QsOEDXA+WCoL+G/2938DuKnDjPmMBDUlcAUkVLaR1KWp6GykGMa7U6AQLniqdGkWSvbBfWZB7b7wSCetuamk41XMoSQ2d7KEmIOL2Nn0lw9xqn1erNl5rYEsW06JKITWt1BKWHGUR8HYzpDTbyVGLagJFrSyH1l8+ChSVxuWykKta2CqX/PGg94pU3wx8dO0SFndeK5SksYKWm6l4cZKLfRf4ROrHstv3pNzJxDRvrVx+/rcElFVEwPq9UJbGvYy0/O0r7GKb1VkqmRhzVkRAR+in+IwV821uydy9BEn2b7b2JNO9eTUL2pwzwNHS7/uSbaXN5TN1wDy2W/pLfT00DqhQlfGSkHQ7KRPuKRHs+2U/lwLZ9/C7wLSxDgDBXbHjhslyQthNcbF8nR/nBi7BXhJsdCtaX2G64acC59BGWXqYEAyA4UxCuT6j3Dfrp8W5UR13zYzhN7I78/9z1X3mN1OE5g2wM5s6HFcSPkTKPxeLelCRrsTwAPDEBagzazzdDL5/kqhQ3jFzkJz/yN3SxesCFwBeAb/URiMxBM8nsCVyeUs41sslAd/Q2jV2e0ukeL2OKxNH8domTYzMG6yZ9Lgj+3MrrKciorJ1o6LwYXJnZjMproL9JCz0fcx2K5wb98A0Dp6v+fV3MUjfqXl3SyoRVhliI93kpVDlKr94EkuzI7Xu7U2Db9YCaqFA==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(316002)(6916009)(44832011)(30864003)(31686004)(36860700001)(8676002)(83380400001)(356005)(9786002)(4326008)(36756003)(6666004)(54906003)(2906002)(31696002)(70206006)(47076005)(82310400004)(70586007)(426003)(336012)(7636003)(5660300002)(8936002)(186003)(26005)(2616005)(508600001)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 02:13:19.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eade9e57-76b5-402f-163b-08d9f5a8e56a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6369
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/22 11:11 AM, Mathieu Poirier wrote:
> On Thu, Feb 10, 2022 at 03:28:24AM -0800, Tanmay Shah wrote:
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
>> Signed-off-by: Ben Levinsky<ben.levinsky@xilinx.com>
>> Signed-off-by: Tanmay Shah<tanmay.shah@xilinx.com>
>> ---
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
>>
>>   drivers/remoteproc/Kconfig              |  12 +
>>   drivers/remoteproc/Makefile             |   1 +
>>   drivers/remoteproc/xlnx_r5_remoteproc.c | 973 ++++++++++++++++++++++++
>>   3 files changed, 986 insertions(+)
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
>> index 000000000000..ce2ac364b995
>> --- /dev/null
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -0,0 +1,973 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ZynqMP R5 Remote Processor driver
>> + *
>> + */
>> +
>> +#include <dt-bindings/power/xlnx-zynqmp-power.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mailbox/zynqmp-ipi-message.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/sysfs.h>
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
>> + * @rproc: rproc handle
>> + * @pm_domain_id: RPU CPU power domain id
>> + */
>> +struct zynqmp_r5_core {
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	int tcm_bank_count;
>> +	struct mem_bank_data *tcm_banks;
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
>> +			      enum zynqmp_r5_cluster_mode rpu_mode)
>> +{
>> +	enum rpu_tcm_comb tcm_mode;
>> +	int ret, reg_val;
>> +
>> +	/*
>> +	 * SINGLE CPU mode is not supported in driver yet.
>> +	 * For now we only set lockstep mode or split mode.
>> +	 */
>> +	if (rpu_mode == LOCKSTEP_MODE) {
>> +		reg_val = 0;
>> +	} else if (rpu_mode == SPLIT_MODE) {
>> +		reg_val = 1;
>> +	} else if (rpu_mode == SINGLE_CPU_MODE) {
>> +		pr_err("RPU single cpu mode is not supported\n");
>> +		return -EINVAL;
>> +	}
> I thought we had done all those checks in zynqmp_r5_cluster_init
> ()?  Please
> choose a single place to do the checks and leave it at that.

Sure. I will add two more variables in zynqmp_r5_cluster i.e. r5_reg_val 
and tcm_mode

and set them in zynqmp_r5_cluster_init

>> +
>> +	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, reg_val);
>> +	if (ret < 0) {
>> +		pr_err("failed to set RPU mode\n");
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * At this point RPU is assumed to be configured only in
>> +	 * lockstep mode or split mode. Configure TCM accordingly.
>> +	 */
>> +	tcm_mode = (rpu_mode == LOCKSTEP_MODE) ?
>> +		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
>> +	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> +	if (ret < 0)
>> +		pr_err("failed to configure TCM\n");
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
>> +		pr_err("failed to start RPU = 0x%x\n", r5_core->pm_domain_id);
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
>> +		pr_err("failed to stop remoteproc RPU %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * zynqmp_r5_rproc_mem_map
>> + * @rproc: single R5 core's corresponding rproc instance
>> + * @mem: mem entry to map
>> + *
>> + * Callback to map va for memory-region's carveout.
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_rproc_mem_map(struct rproc *rproc,
>> +				   struct rproc_mem_entry *mem)
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
>> +static int zynqmp_r5_rproc_mem_unmap(struct rproc *rproc,
>> +				     struct rproc_mem_entry *mem)
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
>> +static int add_mem_regions_carveout(struct zynqmp_r5_core *r5_core,
>> +				    struct reserved_mem *rmem)
>> +{
>> +	struct device *dev;
>> +	struct rproc_mem_entry *mem;
>> +	struct rproc *rproc;
>> +
>> +	rproc = r5_core->rproc;
>> +	dev = r5_core->dev;
>> +
>> +	/* Register associated reserved memory regions */
>> +	mem = rproc_mem_entry_init(dev, NULL,
>> +				   (dma_addr_t)rmem->base,
>> +				   rmem->size, rmem->base,
>> +				   zynqmp_r5_rproc_mem_map,
>> +				   zynqmp_r5_rproc_mem_unmap,
>> +				   rmem->name);
>> +	if (!mem)
>> +		return -ENOMEM;
>> +
>> +	rproc_add_carveout(rproc, mem);
>> +
>> +	return 0;
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
>> +	struct zynqmp_r5_core *r5_core;
>> +	int i;
>> +	u32 pm_domain_id;
>> +
>> +	r5_core = rproc->priv;
>> +	if (!r5_core) {
>> +		pr_err("r5 core is not available\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	iounmap((void __iomem *)mem->va);
>> +
>> +	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
>> +		if (zynqmp_pm_release_node(pm_domain_id))
>> +			pr_warn("can't turn off TCM bank 0x%x", pm_domain_id);
>> +	}
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
>> +	struct rproc_mem_entry *mem;
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
>> +
>> +	/*
>> +	 * Power-on Each 64KB TCM,
>> +	 * register its address space, map and unmap functions
>> +	 * and add carveouts accordingly
>> +	 */
>> +	for (i = 0; i < num_banks; i++) {
>> +		bank_addr = r5_core->tcm_banks[i].addr;
>> +		bank_name = r5_core->tcm_banks[i].bank_name;
>> +		bank_size = r5_core->tcm_banks[i].size;
>> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
>> +
>> +		ret = zynqmp_pm_request_node(pm_domain_id,
>> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
>> +			return ret;
>> +		}
>> +
>> +		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, size=0x%lx",
>> +			bank_name, bank_addr, bank_size);
>> +
>> +		mem = rproc_mem_entry_init(dev, NULL, bank_addr,
>> +					   bank_size, bank_addr,
>> +					   tcm_mem_map, tcm_mem_unmap,
>> +					   bank_name);
>> +		if (!mem) {
>> +			/* If failed, Turn off all TCM banks turned on before */
>> +			do {
>> +				pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
>> +				ret = zynqmp_pm_release_node(pm_domain_id);
>> +				if (ret)
>> +					dev_warn(dev,
>> +						 "fail to release node: 0x%x, %x\n",
>> +						 pm_domain_id, ret);
>> +			} while (i--);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		rproc_add_carveout(rproc, mem);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>> +{
>> +	int i, num_banks, ret;
>> +	struct rproc_mem_entry *mem;
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
>> +	bank_addr = r5_core->tcm_banks[0].addr;
>> +	bank_name = r5_core->tcm_banks[0].bank_name;
>> +
>> +	for (i = 0; i < num_banks; i++) {
>> +		bank_size += r5_core->tcm_banks[i].size;
>> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
>> +
>> +		/* Turn on each TCM bank individually */
>> +		ret = zynqmp_pm_request_node(pm_domain_id,
>> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
>> +		bank_name, bank_addr, bank_size);
>> +
>> +	/* Register TCM address range, TCM map and unmap functions */
>> +	mem = rproc_mem_entry_init(dev, NULL, bank_addr,
>> +				   bank_size, bank_addr,
>> +				   tcm_mem_map, tcm_mem_unmap,
>> +				   bank_name);
>> +	if (!mem) {
>> +		/* In case of error, turn off TCM banks */
>> +		for (i = 0; i < num_banks; i++) {
>> +			pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
>> +			ret = zynqmp_pm_release_node(pm_domain_id);
>> +			if (ret)
>> +				dev_warn(dev,
>> +					 "fail to release node: 0x%x ret: %x\n",
>> +					 pm_domain_id, ret);
>> +		}
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* If registration is success, add carveouts */
>> +	rproc_add_carveout(rproc, mem);
>> +
>> +	return 0;
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
>> +	struct platform_device *parent_pdev;
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
>> +		dev_err(&parent_pdev->dev, "Invalid driver data\n");
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
>> + *
>> + * return 0 on success, otherwise non-zero value on failure
>> + */
>> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	int ret;
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct device *dev;
>> +
>> +	r5_core = rproc->priv;
>> +
>> +	dev = r5_core->dev;
>> +
>> +	ret = add_tcm_banks(rproc);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get TCM banks, err %d\n", ret);
>> +		return ret;
>> +	}
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
>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
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
>> +
>> +	/* Add R5 remoteproc core */
>> +	ret = devm_rproc_add(cdev, r5_rproc);
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
>> +	int i = 0, j;
> Variable @i doesn't need to be initialised.
Agree.
>> +	struct zynqmp_r5_core *r5_core;
>> +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
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
>> +	/* r5 core 0 will use all of TCM banks in lockstep mode.
>> +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
>> +	 * 128k. Assign TCM banks to each core accordingly
>> +	 */
> Comment format problem.
My bad. I will fix it.
>> +	tcm_node = 0;
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>> +						  sizeof(struct mem_bank_data),
>> +						  GFP_KERNEL);
>> +		if (!r5_core->tcm_banks)
>> +			return -ENOMEM;
>> +
>> +		for (j = 0; j < tcm_bank_count; j++) {
>> +			/* Use pre-defined TCM reg values.
>> +			 * Eventually this should be replaced by values
>> +			 * parsed from dts.
>> +			 */
> Same.  I commented on that in my previous review of this set.
Yes. I will fix it.
>> +			r5_core->tcm_banks[j].addr = tcm[tcm_node].addr;
>> +			r5_core->tcm_banks[j].size = tcm[tcm_node].size;
>> +			r5_core->tcm_banks[j].pm_domain_id = tcm[tcm_node].pm_domain_id;
>> +			r5_core->tcm_banks[j].bank_name = tcm[tcm_node].bank_name;
>> +			tcm_node++;
>> +		}
>> +
>> +		r5_core->tcm_bank_count = tcm_bank_count;
> Why do we need to copy the exact same information from zynqmp_tcm_banks to ->tcm_banks?  Why can't ->tcm_banks point to an offset in zynqmp_tcm_banks and ->tcm_bank_count set accordingly?

zynqmp_tcm_banks is global variable. If I use ->tcm_banks point to 
offset of zynqmp_tcm_banks and use it in driver, that section of code 
won't be thread safe anymore.

I might have to use mutex to protect it. So Instead of pointing it to 
global variable, I decided to copy information from global variable to 
->tcm_banks.

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
>> +	int res_mem_count, i, ret;
>> +	struct device *dev;
>> +	struct device_node *np, *rmem_np;
>> +	struct reserved_mem *rmem;
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
>> +	for (i = 0; i < res_mem_count; i++) {
>> +		rmem_np = of_parse_phandle(np, "memory-region", i);
>> +		if (!rmem_np)
>> +			return -EINVAL;
>> +
>> +		rmem = of_reserved_mem_lookup(rmem_np);
>> +		if (!rmem) {
>> +			of_node_put(rmem_np);
>> +			return -EINVAL;
> What happens to previously allocated regions when there is a failure?

Right, I need to unmap memory and use kfree(rmem) to de-allocate memory.

>> +		}
>> +
>> +		ret = add_mem_regions_carveout(r5_core, rmem);
>> +		if (ret)
>> +			dev_warn(dev, "failed to get reserve mem regions %d\n",
>> +				 ret);
> Same here.

Here as well. I will release reserved mem dev with 
of_reserved_mem_device_release API.

One more thing. I moved add_mem_regions_carveout from parse_fw to 
zynqmp_r5_get_mem_region_node.

However, I believe I should move it back to parse_fw.

Following test case is failing in when add_mem_regions_carveout is not 
available in parse_fw:

load_rpu_fw -> start rpu -> stop rpu -> start rpu again

In above case, during mem regions are not added again.

Is it fine, if I move this add_mem_regions_carveout back to 
zynqmp_r5_parse_fw ?

> I am out of time for this set.  Please address comments provided up to here and
> we will see about the rest in a future revision.
>
> Thanks,
> Mathieu
>
>> +
>> +		of_node_put(rmem_np);
>> +	}
>> +
>> +	return 0;
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
>> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster)
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
>> +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
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
>> +	int core_count = 0, ret, i;
>> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
>> +	struct zynqmp_r5_core **r5_cores;
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
>> +	 * fail driver probe if either of that is not set in dts
>> +	 */
>> +	if (cluster_mode == SINGLE_CPU_MODE) {
>> +		dev_err(dev, "driver does not support single cpu mode\n");
>> +		return -EINVAL;
>> +	} else if ((cluster_mode != SPLIT_MODE &&
>> +		   cluster_mode != LOCKSTEP_MODE)) {
>> +		dev_err(dev, "Invalid cluster mode\n");
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
>> +	r5_cores = devm_kcalloc(dev, core_count,
>> +				sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
>> +	if (!r5_cores)
>> +		return -ENOMEM;
>> +
>> +	i = 0;
>> +	for_each_available_child_of_node(dev_node, child) {
>> +		child_pdev = of_find_device_by_node(child);
>> +		if (!child_pdev) {
>> +			of_node_put(child);
>> +			return -ENODEV;
>> +		}
>> +
>> +		/* create and add remoteproc instance of type struct rproc */
>> +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>> +		r5_cores[i]->dev = &child_pdev->dev;
>> +		if (!r5_cores[i]->dev) {
>> +			dev_err(dev, "can't get device for r5 core %d\n", i);
>> +			of_node_put(child);
>> +			return -ENODEV;
>> +		}
>> +
>> +		r5_cores[i]->np = dev_of_node(r5_cores[i]->dev);
>> +		if (!r5_cores[i]->np) {
>> +			dev_err(dev, "can't get device node for r5 core %d\n", i);
>> +			of_node_put(child);
>> +			return -ENODEV;
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
>> +		of_node_put(child);
>> +	}
>> +
>> +	cluster->mode = cluster_mode;
>> +	cluster->core_count = core_count;
>> +	cluster->r5_cores = r5_cores;
>> +
>> +	ret = zynqmp_r5_core_init(cluster);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to init r5 core err %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void zynqmp_r5_cluster_exit(void *data)
>> +{
>> +	struct platform_device *pdev = (struct platform_device *)data;
>> +
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	pr_info("Exit r5f subsystem driver\n");
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
>> +	cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
>> +	if (!cluster)
>> +		return -ENOMEM;
>> +
>> +	cluster->dev = dev;
>> +
>> +	ret = devm_of_platform_populate(dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to populate platform dev %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* wire in so each core can be cleaned up at driver remove */
>> +	platform_set_drvdata(pdev, cluster);
>> +
>> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = zynqmp_r5_cluster_init(cluster);
>> +	if (ret) {
>> +		dev_err(dev, "Invalid r5f subsystem device tree\n");
>> +		return ret;
>> +	}
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
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.25.1
>>
