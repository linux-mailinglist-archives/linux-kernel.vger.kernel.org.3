Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320374C00F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiBVSIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiBVSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:08:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1201F170D50;
        Tue, 22 Feb 2022 10:08:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVm4pAvuIzPGaT9ZZTKbzUR4BZTtzHuVxjJKfYh7WGflsvgMvv7gfw51fm3DTA0G0CZX3cEq3Wn8gAM1DnfWK5iNQBV9oOzyPYvIPWbahacg+sqgAmzAxKGzCrqntovjSfMNYG+Ly9LoqkHO/Urd8JivZapsn6qsqkhufC0rEbKeKxw2evuByY7o9/B8cHay6vf/6cHgGAXaw/rl22DoaNMnjYfH8gW20ZwIHJZKX88ykZL9syvNz7alG6Hof3tldHW2fjX8M6gpXuvXbcV8u+Fw7lP3To9inTf4i9ZcN3CTqE4TBBBohiiwSlxcbgCcC42GhRWNCVhzb+ecx9YdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf3PXzcuLIum5zELXJWEk+JDoBI97ShKNobZ9ZpaX6M=;
 b=Dhc9KWKFxZSUAX/XRujt0l9AfovIcc1AOixF1FexjNaa/F50I6ESwZO1HntqzV+0c5iOkLr982IJYsEw0DOJ0zCnDgbFzLX9KF5grY92Wt5t4DbLi5LeNVlDwXSGZ05m1W09pjXueoex3eIlQR8nbYt/3KMtKba4SwF4KLrsRXPeFdy2YbDkJfQSA3YDERhs/Q/aAtlY4ZPhSr6s2MP4BX0WK9Xzr6+Z0H+OVUMryVlafZL+owE0wP4mxFlLVBKhbzOWvDTuzZaGJrIHHxaoEja1rJYZlHrfNa9l1pBzkeIpKhrPQMw5jR9GysDrcehZsxRQ6LNv0XJRLgYC5ycTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf3PXzcuLIum5zELXJWEk+JDoBI97ShKNobZ9ZpaX6M=;
 b=ng7qVBsoBJAKLIuyP1xczAX1si/K6c1tzOlG5gYlEfrgr4Ldr5vuP1QMHIjUvEhbLYHCoGfIaiUuZoEwdaZ4TuTtEPswrq65zwjXuiYlXYTH4E5vhCLr7tWvwcQUzGEM3IU+E+Hmtsr1Tl/z5RipPDIBXnDZo6YpObsR9MkmyBk=
Received: from SN4PR0501CA0127.namprd05.prod.outlook.com
 (2603:10b6:803:42::44) by BY5PR02MB6817.namprd02.prod.outlook.com
 (2603:10b6:a03:20e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 18:08:17 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::c6) by SN4PR0501CA0127.outlook.office365.com
 (2603:10b6:803:42::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7 via Frontend
 Transport; Tue, 22 Feb 2022 18:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.27 via Frontend Transport; Tue, 22 Feb 2022 18:08:16 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 18:08:15 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 18:08:15 +0000
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
Received: from [10.71.117.28] (port=52265)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nMZaA-0001XF-GF; Tue, 22 Feb 2022 18:08:15 +0000
Message-ID: <c959c092-208c-a95a-6128-71648eea401c@xilinx.com>
Date:   Tue, 22 Feb 2022 10:08:11 -0800
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
 <6a9dcca9-3c86-f603-d13a-acc74161f1a1@xilinx.com>
 <20220222165734.GC923552@p14s>
Content-Language: en-US
In-Reply-To: <20220222165734.GC923552@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58458f48-1533-4f94-a497-08d9f62e4d01
X-MS-TrafficTypeDiagnostic: BY5PR02MB6817:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB681718D6193F1B857A0A2BC7CA3B9@BY5PR02MB6817.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/Mx6amJADSUXFMuNyaz4nH0YRM2kjhrfsB9wIP3fEwfTD1q6s/g5NgTHLxME26eELIKsHBIFaovCZNejXBtIyeYPC8daSLodl/Fg5iKoEeEb6Mara/yAeRe6RU1wDAPySmkVbAK7CBCEzobvcm4rtOqEZvxDauD+wEDyUE8BljI44e/e6hTljmMZi/0jNGE/jZ116rDXhrRIfBux5IEyjWdfsWqu0ifDs+4/YPrthpAqWBdL7HB7+wHVtE5iqRmfgFcAky+keqNLOuvngNr3XQ3uPqPtqkZALwTmuLYLS8gRnDHp2wh8p1jbhmIL4aeSHy2KZBQtpPI+brl5evkWpIM3C/0nxB0eqW4nELkUTAs/fUQzCQ8BM/Fe965C6Y6x/bOlM1FwZHI33uChFj8bNQ8UcmbvY+Z2H/FSjRtHIHBdQHejFc9kfdePNJ2GTLX/H48z7NG4P4ZI2TVTguAVBDpURbe0Yc3d9/7D6Xnx4kCXkHkQ0gGOMk1OO3BCtBVrJQ5sSzw34JM3kCQUjLa/ml+KlFkIEzvKi7wx46SQzuB0XnwCMj8elcqo9AP2fh2nmiXNWv2TTof8G9SyZiWo4PmiDSwGRGcFrJeaocCLG9tHmCt00RCHyxcRgIv2UqEPC7pVuxt4LspHpB6vFQqpXEEDiNwYkXLkT5oDoxj52xqHaqlcVJ4QGh+8RDhyCixJtGJNizdtv05BjIB5ywL9bLj5jjh0EZCr6ktDi+e4rw=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(26005)(316002)(9786002)(2906002)(40460700003)(70206006)(70586007)(30864003)(82310400004)(83380400001)(2616005)(54906003)(6666004)(36860700001)(186003)(8676002)(44832011)(6916009)(5660300002)(4326008)(336012)(426003)(47076005)(53546011)(508600001)(31686004)(356005)(31696002)(7636003)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 18:08:16.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58458f48-1533-4f94-a497-08d9f62e4d01
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6817
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/22 8:57 AM, Mathieu Poirier wrote:
> [...]
>
>>>> +/**
>>>> + * zynqmp_r5_get_tcm_node()
>>>> + * Ideally this function should parse tcm node and store information
>>>> + * in r5_core instance. We will use hardcoded TCM information from
>>>> + * driver for now in this function.
>>>> + *
>>>> + * @cluster: pointer to zynqmp_r5_cluster type object
>>>> + *
>>>> + * Return: 0 for success and error code for failure.
>>>> + */
>>>> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	int tcm_bank_count, tcm_node;
>>>> +	int i = 0, j;
>>> Variable @i doesn't need to be initialised.
>> Agree.
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
>>>> +	struct device *dev = cluster->dev;
>>>> +
>>>> +	/*
>>>> +	 * ToDo: Use predefined TCM address space values from driver until
>>>> +	 * system-dt spec is not final for TCM
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
>>> Comment format problem.
>> My bad. I will fix it.
>>>> +	tcm_node = 0;
>>>> +	for (i = 0; i < cluster->core_count; i++) {
>>>> +		r5_core = cluster->r5_cores[i];
>>>> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>>>> +						  sizeof(struct mem_bank_data),
>>>> +						  GFP_KERNEL);
>>>> +		if (!r5_core->tcm_banks)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (j = 0; j < tcm_bank_count; j++) {
>>>> +			/* Use pre-defined TCM reg values.
>>>> +			 * Eventually this should be replaced by values
>>>> +			 * parsed from dts.
>>>> +			 */
>>> Same.  I commented on that in my previous review of this set.
>> Yes. I will fix it.
>>>> +			r5_core->tcm_banks[j].addr = tcm[tcm_node].addr;
>>>> +			r5_core->tcm_banks[j].size = tcm[tcm_node].size;
>>>> +			r5_core->tcm_banks[j].pm_domain_id = tcm[tcm_node].pm_domain_id;
>>>> +			r5_core->tcm_banks[j].bank_name = tcm[tcm_node].bank_name;
>>>> +			tcm_node++;
>>>> +		}
>>>> +
>>>> +		r5_core->tcm_bank_count = tcm_bank_count;
>>> Why do we need to copy the exact same information from zynqmp_tcm_banks to ->tcm_banks?  Why can't ->tcm_banks point to an offset in zynqmp_tcm_banks and ->tcm_bank_count set accordingly?
>> zynqmp_tcm_banks is global variable. If I use ->tcm_banks point to offset of
>> zynqmp_tcm_banks and use it in driver, that section of code won't be thread
>> safe anymore.
>>
>> I might have to use mutex to protect it. So Instead of pointing it to global
>> variable, I decided to copy information from global variable to ->tcm_banks.
> As far as I can tell ->tcm_banks is a read-only field and as such shouldn't
> need mutext protection.
>
> Thanks,
> Mathieu

Ok, in that case I will point to offset in zynqmp_tcm_banks as suggested.

Rest of the comments looks good, and I will address them in next revision.

Thanks,

Tanmay

>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * zynqmp_r5_get_mem_region_node()
>>>> + * parse memory-region property from dt node and add
>>>> + * memory region carveouts
>>>> + *
>>>> + * @r5_core: pointer to zynqmp_r5_core type object
>>>> + *
>>>> + * Return: 0 for success and error code for failure.
>>>> + */
>>>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
>>>> +{
>>>> +	int res_mem_count, i, ret;
>>>> +	struct device *dev;
>>>> +	struct device_node *np, *rmem_np;
>>>> +	struct reserved_mem *rmem;
>>>> +
>>>> +	dev = r5_core->dev;
>>>> +
>>>> +	np = r5_core->np;
>>>> +
>>>> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>>>> +							sizeof(phandle));
>>>> +	if (res_mem_count <= 0) {
>>>> +		dev_warn(dev, "failed to get memory-region property %d\n",
>>>> +			 res_mem_count);
>>>> +		return -EINVAL;
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
>>> What happens to previously allocated regions when there is a failure?
>> Right, I need to unmap memory and use kfree(rmem) to de-allocate memory.
>>
>>>> +		}
>>>> +
>>>> +		ret = add_mem_regions_carveout(r5_core, rmem);
>>>> +		if (ret)
>>>> +			dev_warn(dev, "failed to get reserve mem regions %d\n",
>>>> +				 ret);
>>> Same here.
>> Here as well. I will release reserved mem dev with
>> of_reserved_mem_device_release API.
>>
>> One more thing. I moved add_mem_regions_carveout from parse_fw to
>> zynqmp_r5_get_mem_region_node.
>>
>> However, I believe I should move it back to parse_fw.
>>
>> Following test case is failing in when add_mem_regions_carveout is not
>> available in parse_fw:
>>
>> load_rpu_fw -> start rpu -> stop rpu -> start rpu again
>>
>> In above case, during mem regions are not added again.
>>
>> Is it fine, if I move this add_mem_regions_carveout back to
>> zynqmp_r5_parse_fw ?
>>
>>> I am out of time for this set.  Please address comments provided up to here and
>>> we will see about the rest in a future revision.
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>> +
>>>> +		of_node_put(rmem_np);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * zynqmp_r5_core_init()
>>>> + * Create and initialize zynqmp_r5_core type object
>>>> + *
>>>> + * @cluster: pointer to zynqmp_r5_cluster type object
>>>> + *
>>>> + * Return: 0 for success and error code for failure.
>>>> + */
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
>>>> +		r5_core = cluster->r5_cores[i];
>>>> +
>>>> +		ret = zynqmp_r5_get_mem_region_node(r5_core);
>>>> +		if (ret)
>>>> +			dev_warn(dev, "memory-region prop failed %d\n", ret);
>>>> +
>>>> +		/* Initialize r5 cores with power-domains parsed from dts */
>>>> +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>>>> +						 1, &r5_core->pm_domain_id);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "failed to get power-domains property\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
>>>> +				cluster->mode, ret);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * zynqmp_r5_cluster_init()
>>>> + * Create and initialize zynqmp_r5_cluster type object
>>>> + *
>>>> + * @cluster: pointer to zynqmp_r5_cluster type object
>>>> + *
>>>> + * Return: 0 for success and error code for failure.
>>>> + */
>>>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	struct device *dev = cluster->dev;
>>>> +	struct device_node *dev_node = dev_of_node(dev);
>>>> +	struct device_node *child;
>>>> +	struct platform_device *child_pdev;
>>>> +	int core_count = 0, ret, i;
>>>> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
>>>> +	struct zynqmp_r5_core **r5_cores;
>>>> +
>>>> +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
>>>> +
>>>> +	/*
>>>> +	 * on success returns 0, if not defined then returns -EINVAL,
>>>> +	 * In that case, default is LOCKSTEP mode
>>>> +	 */
>>>> +	if (ret != -EINVAL && ret != 0) {
>>>> +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * For now driver only supports split mode and lockstep mode.
>>>> +	 * fail driver probe if either of that is not set in dts
>>>> +	 */
>>>> +	if (cluster_mode == SINGLE_CPU_MODE) {
>>>> +		dev_err(dev, "driver does not support single cpu mode\n");
>>>> +		return -EINVAL;
>>>> +	} else if ((cluster_mode != SPLIT_MODE &&
>>>> +		   cluster_mode != LOCKSTEP_MODE)) {
>>>> +		dev_err(dev, "Invalid cluster mode\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Number of cores is decided by number of child nodes of
>>>> +	 * r5f subsystem node in dts. If Split mode is used in dts
>>>> +	 * 2 child nodes are expected.
>>>> +	 * In lockstep mode if two child nodes are available,
>>>> +	 * only use first child node and consider it as core0
>>>> +	 * and ignore core1 dt node.
>>>> +	 */
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
>>>> +	r5_cores = devm_kcalloc(dev, core_count,
>>>> +				sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
>>>> +	if (!r5_cores)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	i = 0;
>>>> +	for_each_available_child_of_node(dev_node, child) {
>>>> +		child_pdev = of_find_device_by_node(child);
>>>> +		if (!child_pdev) {
>>>> +			of_node_put(child);
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		/* create and add remoteproc instance of type struct rproc */
>>>> +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>>>> +		r5_cores[i]->dev = &child_pdev->dev;
>>>> +		if (!r5_cores[i]->dev) {
>>>> +			dev_err(dev, "can't get device for r5 core %d\n", i);
>>>> +			of_node_put(child);
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		r5_cores[i]->np = dev_of_node(r5_cores[i]->dev);
>>>> +		if (!r5_cores[i]->np) {
>>>> +			dev_err(dev, "can't get device node for r5 core %d\n", i);
>>>> +			of_node_put(child);
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		i++;
>>>> +
>>>> +		/*
>>>> +		 * If two child nodes are available in dts in lockstep mode,
>>>> +		 * then ignore second child node.
>>>> +		 */
>>>> +		if (i == core_count) {
>>>> +			of_node_put(child);
>>>> +			break;
>>>> +		}
>>>> +		of_node_put(child);
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
>>>> +	if (!cluster)
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
