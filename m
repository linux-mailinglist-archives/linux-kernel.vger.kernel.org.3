Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C1473503
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbhLMTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:31:14 -0500
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:59553
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242359AbhLMTbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:31:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl3EOzmi4rrvSKSze4Z46Ohr5MqP/CVPDFc3oqUKp9br/jzLGj47OmCH/j8ucBjiL+dx/CbgMbZcz21n0eZWiq14WGAWgnnZfAi0sPaopXV2Sy34CMn3DhnmQR8jtauDr91+i4UD2IzvOqFJwAvpSyRkagrzE2cLJOPcIiwPwNTbaZP8ig2imOCVSmvsO6rODMyFi5feaQusPulholbUCW/S7Z8VkoT79L3u0ZexV3gGyAPPqKxTjUwzbz5dEXog/QDz+pCeWY9L2BGdNVwSKOpzF0Jk/X9ObBRfgx6grofNaXBHp8P/Xuod9IJVemOGZ8xNwHg9kCBNH2Pn3Gm+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIR7BV9X7+Az5mfHkPwS4mcwsmxAkGu1z5swQjwFBx0=;
 b=K6l4cHr+cIR2iROMB8dNvu/hv76se7wCd2dX2NUF3baE47XUGjUgOguV9zx4LCn2ZZhfKl3Y6swveePlsNSL1NtJwp7ny5dPeX0FbLAPTi91BE+x+9ABVXvIWQWgKjHb/n7fBnO/DtsdSrEfkc4TjV3W/rK0GNoH53eEEx2QckrLnKf9jOJhNRrzUkQEM9DqzTIhBWU40fW8PeXnA4c+C1g/Xh2YIqdYdhps+mEp0BN7w6bIWCdZYTeV6v1IfmnAgiJlwy7ExXOEixznXMV2cqLrbPuKi1agVm5TPxS6JDyNoqIw4w3oRcTcMllxpM4WRYRnrVA89hMyOYIRlXQuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=metafoo.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIR7BV9X7+Az5mfHkPwS4mcwsmxAkGu1z5swQjwFBx0=;
 b=jgXtUCyGYVXkBkmgl3FVHZrGZRULUTDSeSVL9FJ3sjjsOBy57HhbqHYmJITw1DVwUN99snohmRp5+H6CnSIERNe25CBu994qNuaCrbwbezIafy8Umt4p8WaZeK5AOeLiXTT5VZSCloENzgRZqa/v6lSDwHjSwrN8gZ66IeaCzBg=
Received: from DM6PR11CA0059.namprd11.prod.outlook.com (2603:10b6:5:14c::36)
 by SN6PR02MB5152.namprd02.prod.outlook.com (2603:10b6:805:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 19:31:10 +0000
Received: from DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::25) by DM6PR11CA0059.outlook.office365.com
 (2603:10b6:5:14c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 19:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT046.mail.protection.outlook.com (10.13.4.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 19:31:09 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Dec 2021 19:31:08 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Dec 2021 19:31:08 +0000
Envelope-to: michal.simek@xilinx.com,
 ben.levinsky@xilinx.com,
 sergei.korneichuk@xilinx.com,
 lars@metafoo.de,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.71.116.145] (port=61714)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1mwr2R-0002b9-5l; Mon, 13 Dec 2021 19:31:07 +0000
Message-ID: <acbd7749-7bb2-0de2-5658-2b62ace9520a@xilinx.com>
Date:   Tue, 14 Dec 2021 01:01:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        "Sergei Korneichuk" <sergei.korneichuk@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
 <ab9e009a-5e35-ae49-2c8e-65be6ba36d7f@metafoo.de>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <ab9e009a-5e35-ae49-2c8e-65be6ba36d7f@metafoo.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb4c10c2-ece6-4914-862d-08d9be6f1da3
X-MS-TrafficTypeDiagnostic: SN6PR02MB5152:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB51520BC5E6E4A791D9DD9046CA749@SN6PR02MB5152.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /G0dDEaYeKFoHho2k5r8rFEuCUZg7tdsAtTc0YLeIjDqZE3U8ECSWnXg7IZ5ey62r8NN6FhZo+VRtss3L05Y7TmA6q6jgOnmP8RQ41t9xnwlFoUYfaH16Y2p0l7GICYjDAXKPIW0zwpQ4bNY1aNtNoMzsnP6ew7qx0J/o95g32ezs/pXSGfIQ8KZ4OteMcMY8tTnPEh65mVbvFTxE5ii1hst/NM8UfsTVv5XsUqleA5k9euSAuy0UdBBB77YHd9lQLvR/D7rd4CY/Yx5Qwa595d4Oigb2MY0P8BLtBtsH6X54xHmZ93ruYs6I45t6/PWlewdc9/c4D7V2fiVcj+0fI2T+UZu3etECnqe98rvJj/lW0TVPyBkcidkc4fsTViZ0ICx+rAah1bPD7jQzjsveffFAECr3YCtcyF2V1uPps8o8koQHGj1KNwja+ouSAez298sAEw4yZXGObKjgxMrlbvYldYcBy52FuMu+hm4nP6alebGxPU25FKIgsgD7JYT3l6/aZY9uF3kQ8F2P2eVg/Qifs/drYiPdFaWnL6064OOsIpcsEBRfgF2c7iXi55M/PX3RlrlIKHvHj7VT2GUClTsHaR/Tu5+5aDLkB0c1rcF+/eUvzOfN7KO+rNEmcc5R8ia3RPKor4Nchw8rG//47cl9qVk0lgy6zxdFG66A3rkhv4E1/+FI/NSzbIpgVfcYm7cf77h/KFz+qfHKqVt1N00qNHVSSai12Ct6XKSU+RD+FXXrUqMWcXB/hc7KolznMLYFwRUuoUWePv4kOxLezieCG7s9NU1QyIw7ip9tx+G0DjvjoxjqbuUh3WMzl08YoqxUyAdwp32Njv9IudNQQ==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70206006)(7416002)(186003)(53546011)(44832011)(36860700001)(70586007)(26005)(6666004)(4326008)(966005)(336012)(508600001)(2616005)(8676002)(426003)(356005)(31696002)(36756003)(31686004)(47076005)(83380400001)(316002)(5660300002)(54906003)(7636003)(110136005)(2906002)(6636002)(8936002)(82310400004)(9786002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:31:09.5195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4c10c2-ece6-4914-862d-08d9be6f1da3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/21 4:38 PM, Lars-Peter Clausen wrote:
> On 11/23/21 7:20 AM, Tanmay Shah wrote:
>> [...]
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
>> +                   struct rproc_mem_entry *mem)
>> +{
>> +    void __iomem *va;
>> +
>> +    va = ioremap_wc(mem->dma, mem->len);
>
> Since you want normal memory and not IO memory a better choice might 
> be memremap() with MEMREMAP_WC. Internally memremap() will call 
> ioremap_wc(), but this will make the intention clear and you do not 
> have to deal with the __iomem type cast.
>

Thanks Lars-Peter. Yes you are right. I found this article 
https://lwn.net/Articles/653585/ about use of memremap after I posted 
this patchset and I have planned to replace ioremap_wc function with 
memremap with MEMREMAP_WC flag.

>> +    if (IS_ERR_OR_NULL(va))
>> +        return -ENOMEM;
>> +
>> +    mem->va = (void *)va;
>> +
>> +    return 0;
>> +}
>> [...]
>>
>> +static int add_tcm_banks(struct rproc *rproc)
>> +{
>> +    struct device *dev;
>> +    struct platform_device *parent_pdev;
>> +    struct zynqmp_r5_cluster *cluster;
>> +    struct zynqmp_r5_core *r5_core;
>> +
>> +    r5_core = (struct zynqmp_r5_core *)rproc->priv;
>> +    if (!r5_core)
>> +        return -EINVAL;
>> +
>> +    dev = r5_core->dev;
>> +    if (!dev) {
>> +        pr_err("r5 core device unavailable\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    parent_pdev = to_platform_device(dev->parent);
>> +    if (!parent_pdev) {
>> +        dev_err(dev, "parent platform dev unavailable\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    cluster = platform_get_drvdata(parent_pdev);
>
> You could just use dev_get_drvdata() without having to cast back to 
> the platform_device first.
>
>
>> +    if (!cluster) {
>> +        dev_err(&parent_pdev->dev, "Invalid driver data\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (cluster->mode == SPLIT_MODE)
>> +        return add_tcm_carveout_split_mode(rproc);
>> +    else if (cluster->mode == LOCKSTEP_MODE)
>> +        return add_tcm_carveout_lockstep_mode(rproc);
>> +
>> +    dev_err(cluster->dev, "invalid cluster mode\n");
>> +    return -EINVAL;
>> +}
>> +
>> [...]
>> +
>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
> const
>> +    .start        = zynqmp_r5_rproc_start,
>> +    .stop        = zynqmp_r5_rproc_stop,
>> +    .load        = rproc_elf_load_segments,
>> +    .parse_fw    = zynqmp_r5_parse_fw,
>> +    .find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>> +    .sanity_check    = rproc_elf_sanity_check,
>> +    .get_boot_addr    = rproc_elf_get_boot_addr,
>> +};
>> [....]
>> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core 
>> *r5_core)
>> +{
>> [...]
>> +
>> +    for (i = 0; i < res_mem_count; i++) {
>> +        rmem_np = of_parse_phandle(np, "memory-region", i);
>> +        if (!rmem_np)
>> +            return -EINVAL;
>> +
>> +        rmem = of_reserved_mem_lookup(rmem_np);
>> +        if (!rmem) {
>> +            of_node_put(rmem_np);
>> +            return -EINVAL;
>> +        }
>> +
>> +        memcpy(&r5_core->res_mem[i], rmem,
>> +               sizeof(struct reserved_mem));
>
> r5_core->res_mem[i] = *mem;
>
> This will give you proper type checking and is also a bit shorter.
>
>> +        of_node_put(rmem_np);
>> +    }
>> +
>> +    r5_core->res_mem_count = res_mem_count;
>> +
>> +    return 0;
>> +}
>> [...]
>> +
>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>> +{
>> [...]
>> +
>>
>> +    i = 0;
>> +    for_each_available_child_of_node(dev_node, child) {
>> +        child_pdev = of_find_device_by_node(child);
>> +        if (!child_pdev)
> A return or a break in a for_each_available_child_of_node() will leak 
> the reference to the child node.

Do you mean I have to use of_put_node for each child?

>> [...]
>> +    }
>> +
>> [...]
>> +
>> +    return 0;
>> +}
>> +
>> +static void zynqmp_r5_cluster_exit(void *data)
>> +{
>> +    struct platform_device *pdev = (struct platform_device *)data;
>> +
>> +    platform_set_drvdata(pdev, NULL);
> This is not needed. The device driver core will set drvdata to NULL 
> when the device is removed.
>> +
>> +    pr_info("Exit r5f subsystem driver\n");
> This is probably also not needed.
>> +}
>
>
