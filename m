Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951414AEFF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiBILbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiBILbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:31:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51920E034902;
        Wed,  9 Feb 2022 02:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC810w6oF7exW3EtHRI+TeMR7Ex3BrXVW2Dh5TvzmzC2yZapzRYa1RglNU5Rfvf9NK1PDC5F6Qp1H+LX+Ec3I+Q9TvKa4ltgPeMUxELngLgzTpsn0hiwOFHPW/XaiU+VqnXcwMzF78LMMUbu3r3iz8608/fJR5fMWx6Dqllx8VkbUHIh9dqcO6tADYUHpDiMratWrtYt673+GXoFh8gLXqh+eEiAq35+i5imlr+jSvB4NuzmIQ0MNjht66/3VRA7f3VPRTHHFHBVtKilOsvfL82rlEhYqgPZP1IqJbRAW3IsK8WPnUEizjylyw8XJrEWwNE6K8W4EkpXoD1EhlEc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dJFRTSZuXDPAmrAZPZivzRvdnwcSyCTP+gNQTsgvLc=;
 b=etzemGCpkmUL4kHI92cwmchgbCaAfJ+J2SHdzNaN1Miz4J1YXrkNvlz+lvdHmN6TLenGoiT2Dw88XMhmM+lL6iqJNktL5tbXOuvd56k/3GsGtensVAPO4ibpTm+TrFW73XIpoSDN79fzNa/0sBQv4XpJ+FFmZSDPCvrOaz5wRyaT8KwpuG9Ik5YQKBa0ljgztRlbllU8G57VP0cR+zyuAczp1QbctRFonP7+YCsJEp1z8GLWeD+4/6y0w77gsvKglpx49lXgwOh6CzPcCODgLIy8UXpKA4QJ8Vne2dSva9MQoKMVTeJxBDPfmBbBI9seQEixTcofaqKTNvrSud8qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dJFRTSZuXDPAmrAZPZivzRvdnwcSyCTP+gNQTsgvLc=;
 b=Q51zkrmP9zcqUAciCiRuE/vpIaS4i+bqD2KIL31DPGwBOz3B4piTTc8AvOAQh5sFKKG7uyxttHcjf7SrHl0vTPfYhwp6EJ478z6qmVVZVkwQlTU2MmVSe8E+AJ7A1kLCpodEt0YiVKnxyGMAvjg8EThd4/iLt3pnXOZ3P/zTyi8=
Received: from SA9PR03CA0017.namprd03.prod.outlook.com (2603:10b6:806:20::22)
 by PH0PR02MB7525.namprd02.prod.outlook.com (2603:10b6:510:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 10:24:03 +0000
Received: from SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::38) by SA9PR03CA0017.outlook.office365.com
 (2603:10b6:806:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 10:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0028.mail.protection.outlook.com (10.97.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 10:24:03 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 02:24:02 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 02:24:02 -0800
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.143.123.116] (port=53763)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nHk8m-0004sG-Nh; Wed, 09 Feb 2022 02:24:01 -0800
Message-ID: <c9c98d61-f404-14bd-b274-758326827f90@xilinx.com>
Date:   Wed, 9 Feb 2022 15:53:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        Sergei Korneichuk <sergei.korneichuk@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
 <20211207183118.GA1099463@p14s>
 <2138161e-bf6b-c22d-1c73-a93bc334da4f@xilinx.com>
 <20220208165452.GB3495196@p14s>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220208165452.GB3495196@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 081e05e3-44ea-4093-bcb2-08d9ebb64b74
X-MS-TrafficTypeDiagnostic: PH0PR02MB7525:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB752517271CCF64D359257177CA2E9@PH0PR02MB7525.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q66jY0jlwZjD3nig7nly3Fb5yzL39120Jv247eF0rfnlHghdi4NN18qutCuTw8fWHHO+iXmxCDprNC9qDXsfNjC0iTZnkDgD+CndH8TSUqGoFSxYruKPfoxJL4TwpXqnOFQ9FDh8ZuFz9jA+1SLPMBs/pyCQFk+8qFJy32NGNYGtoui1Pxwbyn2rBkaDSAnfhwHHP7GiaiN3yCpOaARJxuAJwbbYmwjV17mAO+i/MxlHQs3j3EkRMmTLkZBCWuBfFJ/ljE6CIewp9lHZn7uE4kxYpGHsmB2rnPhbAozsUooAwFVWccBHPPJMUp8gFOCuy3fmihCIAsDbX65P+cU7eA71ymtr8/C0k9nzbsMp3x/l0TGnGCqz4PLnwE7F0dUEtQ63UH2+hbUlvzxDeVXp1kCjruWfRE24oSOd+Cdbq42nGOyyGRxKUIEmBg3RXYxAU66qW1jLqw9eX0z7lVoJiVOgUpwQNDJGDFWTJe9Nm5HcGD6j4PoKHWDbxM+/MzOOouK/ZnqaStW5A/0sff/eFi66AVpm8o/dD7hP+h7PSLsfzCnKeSpLI5QN9kinWgM/AKogDviVx4GShi5D6VWH+63fmbhQAMY4kbl2gEKCmK+4CZliJZlIqo6YDE6//Lqifr7iUVymhbpOfdTgWKmRhduxNft8GHx25FxuIIfHNngjMfaH3GTrmHsbS2pPAiwts3CFbxR/UwhTGnJBUWD27uWGJAoCL9d6D4G1b43aypvFkmFPkPHsjM9vuS6Nu4+yoXWkIaxT2eMezZc4fNrXD3IdnU2Ah4iSxEAj1nl8Is7de6vFuz+66/rGxmO0qq0rf16rjqpGMMGoveX12Mjj6eDte6AEHEXsaoEf3fxtFe8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(83380400001)(36756003)(2616005)(26005)(31686004)(316002)(6916009)(70206006)(336012)(54906003)(356005)(47076005)(70586007)(7636003)(53546011)(508600001)(9786002)(966005)(40460700003)(4326008)(36860700001)(8676002)(8936002)(82310400004)(5660300002)(44832011)(426003)(31696002)(6666004)(2906002)(30864003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:24:03.1371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081e05e3-44ea-4093-bcb2-08d9ebb64b74
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7525
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/8/22 10:24 PM, Mathieu Poirier wrote:
> Hi Tanmay,
>
> [...]
>
>>> I am done reviewing this set - the overall structure is sound but there is a
>>> fair amount of work to be done.  There is no need to rush another revision as I
>>> won't have time to review it before the holidays.  On that front, change
>>> _only_ the things I have commented on.  We can address other issues as we move
>>> forward.  Last but not least, please run the sparse checker on your work.
>>>
>>> Thanks,
>>> Mathieu
>> Hi Mathieu,
>>
>> I am ready to post v3 in this patch series.
>>
>> I have developed v3 based on rproc-next. However, when I rebased my work on
>> tip of linux-next branch,
> Are the merge conflicts related to drivers/remoteproc or drivers/rpmsg?  That
> would be surprising since the code that is in rproc-next and rpmsg-next is also
> in linux-next.

Merge conflict is in Xilinx firmware driver related code. i.e. file 
"include/linux/firmware/xlnx-zynqmp.h"

>
> In any case I would suggest to base your v3 on _today's_ for-next branch [1] and
> explicitly mention any dependency in the cover letter.  From there I might be
> able to see where the problems are and advise further.
>
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next

Sure I will do the same.

I found that following two patches are available in linux-next and not 
in rproc-next/for-next:

https://lore.kernel.org/all/20211025082350.10881-2-abhyuday.godhasara@xilinx.com/

https://lore.kernel.org/all/20211026042525.26612-4-abhyuday.godhasara@xilinx.com/

>> I faced merge-conflicts.
>>
>> What is preferred way to proceed in such case? Should I post my patch based
>> on rproc-next or linux-next?
>>
>> Or any other way to proceed further?
>>
>>
>>>> +
>>>> +	dev = r5_core->dev;
>>>> +
>>>> +	ret = add_tcm_banks(rproc);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to get TCM banks, err %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = add_mem_regions(rproc);
>>>> +	if (ret)
>>>> +		dev_warn(dev, "failed to get reserve mem regions %d\n", ret);
>>>> +
>>>> +	ret = rproc_elf_load_rsc_table(rproc, fw);
>>>> +	if (ret == -EINVAL) {
>>>> +		/*
>>>> +		 * resource table only required for IPC.
>>>> +		 * if not present, this is not necessarily an error;
>>>> +		 * for example, loading r5 hello world application
>>>> +		 * so simply inform user and keep going.
>>>> +		 */
>>>> +		dev_info(&rproc->dev, "no resource table found.\n");
>>>> +		ret = 0;
>>>> +	}
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
>>>> +	.start		= zynqmp_r5_rproc_start,
>>>> +	.stop		= zynqmp_r5_rproc_stop,
>>>> +	.load		= rproc_elf_load_segments,
>>>> +	.parse_fw	= zynqmp_r5_parse_fw,
>>>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>>> +	.sanity_check	= rproc_elf_sanity_check,
>>>> +	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>> +};
>>>> +
>>>> +static void zynqmp_r5_print_dt_node_info(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	int i, j, k;
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +
>>>> +	dev_dbg(cluster->dev, "Printing dt node info\n");
>>>> +
>>>> +	pr_debug("cluster mode = %d\n", cluster->mode);
>>>> +	pr_debug("r5f cluster in %s mode\n", (cluster->mode == 0) ? "SPLIT" :
>>>> +		 cluster->mode == 1 ? "LOCKSTEP" : "SINGLE_CPU");
>>>> +	pr_debug("r5f num cores = %d\n", cluster->core_count);
>>>> +
>>>> +	for (i = 0; i < cluster->core_count; i++) {
>>>> +		r5_core = &cluster->r5_cores[i];
>>>> +		if (!r5_core) {
>>>> +			pr_err("can't get r5_core\n");
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		pr_debug("r5 core %d nodes\n", i);
>>>> +		pr_debug("TCM banks = %d\n", r5_core->tcm_bank_count);
>>>> +		for (k = 0; k < r5_core->tcm_bank_count; k++) {
>>>> +			pr_debug("tcm %d addr=0x%llx size=0x%lx, pm_id=%d, %s\n",
>>>> +				 k, r5_core->tcm_banks[k].addr,
>>>> +				 r5_core->tcm_banks[k].size,
>>>> +				 r5_core->tcm_banks[k].pm_domain_id,
>>>> +				 r5_core->tcm_banks[k].bank_name);
>>>> +		}
>>>> +
>>>> +		pr_debug("reserve mem regions = %d\n", r5_core->res_mem_count);
>>>> +
>>>> +		for (j = 0; j < r5_core->res_mem_count; j++) {
>>>> +			pr_debug("mem %d addr=0x%llx, size=0x%llx, name=%s\n",
>>>> +				 j, r5_core->res_mem[j].base,
>>>> +				 r5_core->res_mem[j].size,
>>>> +				 r5_core->res_mem[j].name);
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>> +/**
>>>> + * zynqmp_r5_add_rproc_core() - Probes ZynqMP R5 processor device node
>>>> + *		       this is called for each individual R5 core to
>>>> + *		       set up mailbox, Xilinx platform manager unique ID,
>>>> + *		       add to rproc core
>>>> + *
>>>> + * @r5_core: zynqmp_r5_core r5 core object to initialize
>>>> + *
>>>> + * Return: 0 for success, negative value for failure.
>>>> + */
>>>> +static int zynqmp_r5_add_rproc_core(struct zynqmp_r5_core *r5_core)
>>>> +{
>>>> +	int ret;
>>>> +	struct rproc *r5_rproc;
>>>> +	struct device *dev;
>>>> +
>>>> +	dev = r5_core->dev;
>>>> +
>>>> +	/* Set up DMA mask */
>>>> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/* Allocate remoteproc instance */
>>>> +	r5_rproc = devm_rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops,
>>>> +				    NULL, sizeof(struct zynqmp_r5_core));
>>>> +	if (IS_ERR_OR_NULL(r5_rproc))
>>>> +		return -ENOMEM;
>>>> +
>>>> +	r5_rproc->auto_boot = false;
>>>> +	r5_rproc->priv = r5_core;
>>>> +
>>>> +	/* Add R5 remoteproc */
>>>> +	ret = devm_rproc_add(dev, r5_rproc);
>>>> +	if (ret) {
>>>> +		pr_err("failed to add r5 remoteproc\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	int tcm_bank_count, tcm_node;
>>>> +	int i = 0, j;
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
>>>> +	struct device *dev = cluster->dev;
>>>> +
>>>> +	/* ToDo: Use predefined TCM address space values from driver until
>>>> +	 * system-dt spec is not final fot TCM
>>>> +	 */
>>>> +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
>>>> +
>>>> +	/* count per core tcm banks */
>>>> +	tcm_bank_count = tcm_bank_count / cluster->core_count;
>>>> +
>>>> +	/* r5 core 0 will use all of TCM banks in lockstep mode.
>>>> +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
>>>> +	 * 128k. Assign TCM banks to each core accordingly
>>>> +	 */
>>>> +	tcm_node = 0;
>>>> +	for (j = 0; j < cluster->core_count; j++) {
>>>> +		r5_core = &cluster->r5_cores[j];
>>>> +		r5_core->tcm_banks = devm_kzalloc(dev, sizeof(struct mem_bank_data) *
>>>> +						  tcm_bank_count, GFP_KERNEL);
>>>> +		if (IS_ERR_OR_NULL(r5_core->tcm_banks))
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (i = 0; i < tcm_bank_count; i++) {
>>>> +			/* Use pre-defined TCM reg values.
>>>> +			 * Eventually this should be replaced by values
>>>> +			 * parsed from dts.
>>>> +			 */
>>>> +			r5_core->tcm_banks[i].addr = tcm[tcm_node].addr;
>>>> +			r5_core->tcm_banks[i].size = tcm[tcm_node].size;
>>>> +			r5_core->tcm_banks[i].pm_domain_id = tcm[tcm_node].pm_domain_id;
>>>> +			r5_core->tcm_banks[i].bank_name = tcm[tcm_node].bank_name;
>>>> +			tcm_node++;
>>>> +		}
>>>> +
>>>> +		r5_core->tcm_bank_count = tcm_bank_count;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
>>>> +{
>>>> +	int res_mem_count, i;
>>>> +	struct device *dev;
>>>> +	struct device_node *np, *rmem_np;
>>>> +	struct reserved_mem *rmem;
>>>> +
>>>> +	dev = r5_core->dev;
>>>> +
>>>> +	np = r5_core->np;
>>>> +	if (IS_ERR_OR_NULL(np)) {
>>>> +		pr_err("invalid device node of r5 core\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>>>> +							sizeof(phandle));
>>>> +	if (res_mem_count <= 0) {
>>>> +		dev_warn(dev, "failed to get memory-region property %d\n",
>>>> +			 res_mem_count);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	r5_core->res_mem = devm_kzalloc(dev,
>>>> +					res_mem_count * sizeof(struct reserved_mem),
>>>> +					GFP_KERNEL);
>>>> +	if (!r5_core->res_mem) {
>>>> +		dev_err(dev, "failed to allocate mem region memory\n");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < res_mem_count; i++) {
>>>> +		rmem_np = of_parse_phandle(np, "memory-region", i);
>>>> +		if (!rmem_np)
>>>> +			return -EINVAL;
>>>> +
>>>> +		rmem = of_reserved_mem_lookup(rmem_np);
>>>> +		if (!rmem) {
>>>> +			of_node_put(rmem_np);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		memcpy(&r5_core->res_mem[i], rmem,
>>>> +		       sizeof(struct reserved_mem));
>>>> +		of_node_put(rmem_np);
>>>> +	}
>>>> +
>>>> +	r5_core->res_mem_count = res_mem_count;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	int ret, i;
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	struct device *dev = cluster->dev;
>>>> +
>>>> +	ret = zynqmp_r5_get_tcm_node(cluster);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "can't get tcm node, err %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < cluster->core_count; i++) {
>>>> +		r5_core = &cluster->r5_cores[i];
>>>> +		if (!r5_core) {
>>>> +			pr_err("invalid r5 core\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		ret = zynqmp_r5_get_mem_region_node(r5_core);
>>>> +		if (ret)
>>>> +			dev_warn(dev, "memory-region prop failed %d\n", ret);
>>>> +
>>>> +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>>>> +						 1, &r5_core->pm_domain_id);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "failed to get power-domains property\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		ret = zynqmp_r5_add_rproc_core(r5_core);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "failed to init r5 core %d\n", i);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	struct device *dev = cluster->dev;
>>>> +	struct device_node *dev_node = dev_of_node(dev);
>>>> +	struct device_node *child;
>>>> +	struct platform_device *child_pdev;
>>>> +	int core_count = 0, ret, i;
>>>> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
>>>> +	struct zynqmp_r5_core *r5_cores;
>>>> +
>>>> +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
>>>> +
>>>> +	/* on success returns 0, if not defined then returns -EINVAL,
>>>> +	 * In that case, default is LOCKSTEP mode
>>>> +	 */
>>>> +	if (ret != -EINVAL && ret != 0) {
>>>> +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (cluster_mode == SINGLE_CPU_MODE) {
>>>> +		dev_err(dev, "driver does not support single cpu mode\n");
>>>> +		return -EINVAL;
>>>> +	} else if ((cluster_mode != SPLIT_MODE &&
>>>> +		   cluster_mode != LOCKSTEP_MODE)) {
>>>> +		dev_err(dev, "Invalid cluster mode\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	core_count = of_get_available_child_count(dev_node);
>>>> +	if (core_count <= 0) {
>>>> +		dev_err(dev, "Invalid number of r5 cores %d", core_count);
>>>> +		return -EINVAL;
>>>> +	} else if (cluster_mode == SPLIT_MODE && core_count != 2) {
>>>> +		dev_err(dev, "Invalid number of r5 cores for split mode\n");
>>>> +		return -EINVAL;
>>>> +	} else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
>>>> +		dev_warn(dev, "Only r5 core0 will be used\n");
>>>> +		core_count = 1;
>>>> +	}
>>>> +
>>>> +	r5_cores = devm_kzalloc(dev, sizeof(struct zynqmp_r5_core) *
>>>> +						 core_count, GFP_KERNEL);
>>>> +	if (IS_ERR_OR_NULL(r5_cores)) {
>>>> +		dev_err(dev, "can't allocate memory for cores\n");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	i = 0;
>>>> +	for_each_available_child_of_node(dev_node, child) {
>>>> +		child_pdev = of_find_device_by_node(child);
>>>> +		if (!child_pdev)
>>>> +			return -ENODEV;
>>>> +
>>>> +		r5_cores[i].dev = &child_pdev->dev;
>>>> +		if (!r5_cores[i].dev) {
>>>> +			pr_err("can't get device for r5 core %d\n", i);
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		r5_cores[i].np = dev_of_node(r5_cores[i].dev);
>>>> +		if (!r5_cores[i].np) {
>>>> +			pr_err("can't get device node for r5 core %d\n", i);
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		i++;
>>>> +		if (i == core_count)
>>>> +			break;
>>>> +	}
>>>> +
>>>> +	cluster->mode = cluster_mode;
>>>> +	cluster->core_count = core_count;
>>>> +	cluster->r5_cores = r5_cores;
>>>> +
>>>> +	ret = zynqmp_r5_core_init(cluster);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "failed to init r5 core err %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	zynqmp_r5_print_dt_node_info(cluster);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void zynqmp_r5_cluster_exit(void *data)
>>>> +{
>>>> +	struct platform_device *pdev = (struct platform_device *)data;
>>>> +
>>>> +	platform_set_drvdata(pdev, NULL);
>>>> +
>>>> +	pr_info("Exit r5f subsystem driver\n");
>>>> +}
>>>> +
>>>> +/*
>>>> + * zynqmp_r5_remoteproc_probe()
>>>> + *
>>>> + * @pdev: domain platform device for R5 cluster
>>>> + *
>>>> + * called when driver is probed, for each R5 core specified in DT,
>>>> + * setup as needed to do remoteproc-related operations
>>>> + *
>>>> + * Return: 0 for success, negative value for failure.
>>>> + */
>>>> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>>>> +{
>>>> +	int ret;
>>>> +	struct zynqmp_r5_cluster *cluster;
>>>> +	struct device *dev = &pdev->dev;
>>>> +
>>>> +	cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
>>>> +	if (IS_ERR_OR_NULL(cluster))
>>>> +		return -ENOMEM;
>>>> +
>>>> +	cluster->dev = dev;
>>>> +
>>>> +	ret = devm_of_platform_populate(dev);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to populate platform dev %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* wire in so each core can be cleaned up at driver remove */
>>>> +	platform_set_drvdata(pdev, cluster);
>>>> +
>>>> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = zynqmp_r5_cluster_init(cluster);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Invalid r5f subsystem device tree\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	dev_info(dev, "Xilinx r5f remoteproc driver probe success\n");
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/* Match table for OF platform binding */
>>>> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>>>> +	{ .compatible = "xlnx,zynqmp-r5fss", },
>>>> +	{ /* end of list */ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>>>> +
>>>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
>>>> +	.probe = zynqmp_r5_remoteproc_probe,
>>>> +	.driver = {
>>>> +		.name = "zynqmp_r5_remoteproc",
>>>> +		.of_match_table = zynqmp_r5_remoteproc_match,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
>>>> +MODULE_AUTHOR("Xilinx Inc.");
>>>> +MODULE_LICENSE("GPL v2");
>>>> -- 
>>>> 2.25.1
>>>>
