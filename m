Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D55B2701
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIHTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiIHTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:42:17 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414FD740B;
        Thu,  8 Sep 2022 12:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf+nXRwbS6Pg3XS5pbFHZ4uG8IXRGSPUEvvduxbXCpeGDTj9JRvcBQsvbm307pnExXghlwsO9D090WcUciDKDJ9rBfQQQkOKCIn/O+OycGHFv0BKHawzwNcRpNMX3xVNz1sBViKTL3BHtDEHOsvWihQZr6koLwIxrhSuf0nXmuCU1XnMfHl5szlTulDqIEpqklEd6B0/+gQ17q0IajX2IWW8Zhk3dl1evDP9LJrAkA+Vx16C/OKtsBhN//ApHPfGT43G/kJ1BGuO+zIswfJ9fCYQKpBH+h/3kry3yOPeLAWAgH6ZVT/GjMTWSfqje38NUi+yXPr3BhbEk/yZ327WyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzFg9xXylmNpl+0TF0FwWejQnzxrpk00GPv+e0WLhTw=;
 b=bXVYB68q3mOJXimffbYxjJOzza2w5ULcnL1VTj2Dt4jw+6EhTvcYIxFO94g1e0i2XhH9bQ/3FMmFnwSY3X0FlmRWxbivU9OkdfkB8cuiv2D8KWBbjbYeTVgTFPKOtiY+0CkPKZn9ZsPnzbN9EDbCLJ+cbH4ZqeyIC+ZrWQ5oGGcLUXJAMyOUew5qTHJqXcC/81AgqWITkjZGjDjoU+DVf7vojwjk9leuc15/bsYNJCYmo7tOPVzR8HA8VoN147cF9pTu3t3rLKnY/FY4EWDu8wvA9FYWHaUiIDUqMl46wlyDIWClWUQjdnnslEF+prLD6QGA0dyhU5LPnt7WQ/p5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzFg9xXylmNpl+0TF0FwWejQnzxrpk00GPv+e0WLhTw=;
 b=pNn8yRhrzPBqxlD2ffckaGwz3mrogjV7Oe++iZAA+5U3gCu4myAJwyGtnjhORooC+PrfqDaC76BRw7N4CcOHu2E+RfWmVfb4PR3SPEcKmKCrxYKbLebGJN9G0fi3egTEhm0mm0TzioavJFJcZcmBw3qpOdI3xz0Dr2frxaa0iC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 19:42:06 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 19:42:05 +0000
Message-ID: <757e655b-4786-d59b-deea-1e1ea8bd9d0c@amd.com>
Date:   Thu, 8 Sep 2022 12:42:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tanmay Shah <tanmay.shah@amd.com>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, ben.levinsky@xilinx.com,
        tanmay.shah@xilinx.com, michal.simek@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-7-tanmay.shah@amd.com> <20220901202517.GB626605@p14s>
 <bd7a8e2c-0d9f-fed5-4a5c-920817adbad2@amd.com>
 <20220902195903.GB1787913@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220902195903.GB1787913@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e69cbeb0-7443-4e67-83c3-08da91d2357f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55PA5Mo7mlwn4mN9iBS5m/C7jr6/owTLwVk2o2iQGuGiedJO1p3W1uNuwumxQMzQbduoH4n9MHYxf0RRPJ+0CmcXndmzdYaQeTC8c9eRhlEgPE6HSpk+Cr/6AusmV76LeiyGXVTOEGtvOiomkNVc7y2eKO3EUScb89NOTWaRoIzE8gJAN34O6Szp2K2wggIX4ObM1p18rQeT8nmDTjPySVEs2qM7yM8FfDToKYMGmv6XsXv2kTuQWvyfn6ttjHFYvbTg40G3USfmbeXJIZ2/PCqKPT6iik1fz9hTl8b6CtsyGEs3LUVoNSwApftQdJTt6U3aX5tgykQIH5R/i2zKccwA5AbBPcPdB0V6GZk2JRwrrsUUSNDOlvPkI9kNnbmYiQL97MxR5dVWvwmDUC4DHoMHpxS7OOD9sGwdNzBjuZZaD6Zyak9G7YTFfGChoIiejSyp5CUqGvBqyzXYPEK0QicYTnZEBIxvCBDBr+edShgYmtBhfBFTSsbMF9hitxbnAVnZ8heg+jvdNsWuemQWULaPp0QlMnX0sigPnhpnqpbMQCq45GUNSzutLTWsnHlzxDe/DZsCskk2ZCcJVCfiZ2hU/pHMGCBwkbYIRthLGsZm12fKhdLppNHHPGWcrR/7an1ae+WdslJAWdF1WeauyuH/fnM2HWEIanluZnpt07dfzPp2ADwyCWEddowlx0hRxAGBh80l1lXn9dl3RHEvro22Zx6srbkHXIvHJT0VpUHUbghsVvC+gYg1ZQK7bnCTpM9s6D91PqkXW4k5U8rQApRK0GL/y7fxroOu180zP1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(186003)(6666004)(31696002)(478600001)(6486002)(6512007)(41300700001)(2616005)(26005)(6506007)(38100700002)(53546011)(8936002)(5660300002)(316002)(83380400001)(2906002)(4326008)(8676002)(66476007)(66556008)(6916009)(31686004)(66946007)(30864003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdiSHJjRkdWMkM1Q1RRK0JqblpFZHN4YUFEODdocUJTZEUyZHNzdzNsdklj?=
 =?utf-8?B?ZU02NFpKTFZ1bGg5K0hLd01HQ29ubFM1REluTCtkSDFWSVRuRHpLMnllOStJ?=
 =?utf-8?B?QnpKMnBIdlNvWGk2cFRqemU0Y2U0WXNReU9iRi9EcnZYZ1hSQm1STzRFWElU?=
 =?utf-8?B?akkzWGJKY1FJMklkMUZYL082Z1I0TTZrVy9GTzRnZmxsTUpKWjJReFdhLzgr?=
 =?utf-8?B?djFUYUo3V3N1ODJvZzNidkQwTnZ0eUh6RThLUDVjaHZlSTY3TFFkem03VmFr?=
 =?utf-8?B?ZlVsZG5GcStUMXdzRHRwV2hRL0RjVUNTSEJLMGZscXdINUJhZXptandoYi9N?=
 =?utf-8?B?NGdGaTRpMStnZXhCSk1kVVgzVlpYMnJnZnF0Tmc2YU41aFR3bjBOeU9JMXQ1?=
 =?utf-8?B?b1ZLZjNtR05oTzJuakRYMXZKY2srY1A3L0ZpR1podUdLbE95bnBISXJVUHE5?=
 =?utf-8?B?VUZ2Zy8yRlorNEZsdTdGVkZKOHhLOG1rempjTVFrR1A3TVBsK2N4V0NjQWMz?=
 =?utf-8?B?RzNMSUpyU3d5c3N6R2ExUjVjemhnclhjT3J2T3NZRG1WRUtJQ0dJWmx3Mmd6?=
 =?utf-8?B?a2lWNzNpb2RBdzFnYitFY3VCajNEYzFsUUpQcHRtODQ1MzY1eW9UZHRTZnJr?=
 =?utf-8?B?aTFrTnY1UGV0V3QzV3NxeDUrUXA2UGxNODk4N3Nudkc0eVdLeXoxQTRYWTZm?=
 =?utf-8?B?TktDdnhaVTcrMkZQMVpWb0JIUGpRTmx3K3c3WVVhY1FqR2Eya0Uzc1BUR3hu?=
 =?utf-8?B?SFJVUGhTZzYyUGErRlZ1M1Jsc044Qm85dFlQODlNdlRCY2hUcUtwOWpBQnJW?=
 =?utf-8?B?d1hVa2NwUDlMQ1lZcEJJem4wbkl5YjRTejR0VmI0M1R1Z3U2aEJ1RXhlMnlC?=
 =?utf-8?B?NlNQdUNNU1plamNGQ0pWaUVFSDAvanpqbEtJUjFZYWoxdlFZOWFha2oxR2Fp?=
 =?utf-8?B?NnVsNyt6SmU1Mkl2YkJBM3pzY01NZzAvaCtZVXp6eDdNR0hjbUFaTUsvSFlG?=
 =?utf-8?B?N3h1dXg1R2crV3ZOR1U3UXFuSHV2MXY2S0ZBdXIyUHhiQ3N0cldsVmFEelV3?=
 =?utf-8?B?VTJZWndyZlRNbGEwSnRZOTYva1U0Ymp1cFhHMVdwQkZjTHhVL2twRlkyRXRS?=
 =?utf-8?B?RmRMMVlhaEhmdGdJRlYvZjlvSW1hakgxMzEzZVJPdE1LTzlCbkIxRUJpblcw?=
 =?utf-8?B?ZFdUYVN2ZnkyNVNlaFhGcWEwczc1TldOTFJ3VTl4QmpUTFBWL01tR3Fsbi9x?=
 =?utf-8?B?MG1sbGxmQ1NTT2VQZS8yMXk1RllQVTVXUjFVeXVhYVhTYlJwVjNRcUxYSkVy?=
 =?utf-8?B?U1ZVL0dVM3h3M3FRVmZsaEhvT2p1SWdwRHpUSWc1TStrSnhFK0JCZ3lDdjdZ?=
 =?utf-8?B?VU9kNFFiZmFDTHVxbjE1dTlLbzFqNW90Nko0TVYrUFJrKy9GTjFtRituSm9O?=
 =?utf-8?B?SXVsUnY0VnFiRzNsZlhIMWUwWlU1d2Rjcjd0M3c1TStqcERiWEl1UkVFV0dw?=
 =?utf-8?B?UlMxRmo4U1ZjbkRiS25lQzg1K3hXUUh0bUZVMS9HS3dZZjRERldNWHNKY0dG?=
 =?utf-8?B?QnpaUm40djlXbVJrMFpXOEswZGIyNHVIdExZcFBScGE2UFlJRXJNb3pYNWV6?=
 =?utf-8?B?MzhSRWFpajV6cnpVTjVHSmFSNW42L2J0OVlnYjlLb3Fpb3FPMnFjV1V6dHdq?=
 =?utf-8?B?cmlKdnorTm5hYU5HZktKU2xJUi9zcnYvek9iVFBnUkpaRDVqcUU4V0ZhSk5F?=
 =?utf-8?B?VG9LaUN0dDkxL2Mzd0JPU3lhNlNvRklFQzUzc2hIMzloTjViYm0wdVcvS0FY?=
 =?utf-8?B?cVFFWENsRDJmNnE3Q3M5bXVMcVk1ekJoalJocFNJY3FpdGdUSmhLajJKOG8r?=
 =?utf-8?B?dmxtR1hFMlM4SU9kcUpTQ1ZEUEtGcmF5UU1OM1BVblNjZTUraWhEYWRoLytx?=
 =?utf-8?B?ZDgwZkl5Z1VSTzAyeXcvMHpLMWpMNWMrcS9qKzRDM2pQWGNVWGg3R1k0ZnJZ?=
 =?utf-8?B?cjVBTmVRY1NWN2pBUlRTM0N5YXRDSXU1dzJ4WUNNdTNjb21wM1Fwb2JVazUy?=
 =?utf-8?B?RWNxS29WT1F1aVV1ZkpBdEtsNTllaE5LY215dzlRZjJBcXl5WGhsSDlBVDNv?=
 =?utf-8?Q?e4qYHq7bCkblLInYpvYvcTutw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69cbeb0-7443-4e67-83c3-08da91d2357f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:42:05.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFR4c0P+qdIsJ5RdqyP9MG7f24yxnMi+AonmQBeDyWS0V3tFraoy5ejvJABT7Kdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for reviewing this patch-set. Ack to comments and will fix in new 
revision.

On 9/2/22 12:59 PM, Mathieu Poirier wrote:
> [...]
>
>>>> +
>>>> +static const struct rproc_ops zynqmp_r5_rproc_ops = {
>>>> +	.prepare	= zynqmp_r5_rproc_prepare,
>>>> +	.unprepare	= zynqmp_r5_rproc_unprepare,
>>>> +	.start		= zynqmp_r5_rproc_start,
>>>> +	.stop		= zynqmp_r5_rproc_stop,
>>>> +	.load		= rproc_elf_load_segments,
>>>> +	.parse_fw	= zynqmp_r5_parse_fw,
>>>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>>> +	.sanity_check	= rproc_elf_sanity_check,
>>>> +	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>> +};
>>>> +
>>>> +/**
>>>> + * zynqmp_r5_add_rproc_core()
>>>> + * Probes ZynqMP R5 processor device node
>>>> + * this is called for each individual R5 core
>>>> + *
>>>> + * @cdev: Device node of each r5 core
>>>> + *
>>>> + * Return: zynqmp_r5_core object for success, error pointer in case of error.
>>>> + */
>>>> +static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>>> +{
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	struct rproc *r5_rproc;
>>>> +	int ret;
>>>> +
>>>> +	/* Set up DMA mask */
>>>> +	ret = dma_set_coherent_mask(cdev, DMA_BIT_MASK(32));
>>>> +	if (ret)
>>>> +		return ERR_PTR(ret);
>>>> +
>>>> +	/* Allocate remoteproc instance */
>>>> +	r5_rproc = rproc_alloc(cdev, dev_name(cdev),
>>>> +			       &zynqmp_r5_rproc_ops,
>>>> +			       NULL, sizeof(struct zynqmp_r5_core));
>>>> +	if (!r5_rproc) {
>>>> +		dev_err(cdev, "failed to allocate memory for rproc instance\n");
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +	}
>>>> +
>>>> +	r5_rproc->auto_boot = false;
>>>> +	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
>>>> +	r5_core->dev = cdev;
>>>> +	r5_core->np = dev_of_node(cdev);
>>>> +	if (!r5_core->np) {
>>>> +		dev_err(cdev, "can't get device node for r5 core\n");
>>>> +		return ERR_PTR(-EINVAL);
>>> Here @r5_rproc is leaked and r5_rproc->rproc never free'ed.
>> This function is only used in cluster_init.
>>
>> r5_rproc->rproc is free'ed in release_r5_core label in
>> zynqmp_r5_cluster_init function if this function fails.
> It would be the case if @r5_core was returned, but it is not.  A such
> @r5_core[i] zynqmp_r5_cluster_init() is still null and the memory leaked.

Ack. Yes you are right. Thanks!!

>
>> This avoids multiple free of same resource.
>>
>>>> +	}
>>>> +
>>>> +	/* Add R5 remoteproc core */
>>>> +	ret = rproc_add(r5_rproc);
>>>> +	if (ret) {
>>>> +		dev_err(cdev, "failed to add r5 remoteproc\n");
>>>> +		return ERR_PTR(ret);
>>> Same.
>> Same as above.
Ack. I will fix this.
>>>> +	}
>>>> +
>>>> +	r5_core->rproc = r5_rproc;
>>>> +	return r5_core;
>>>> +}
>>>> +
>>>> +/**
>>>> + * zynqmp_r5_get_tcm_node()
>>>> + * Ideally this function should parse tcm node and store information
>>>> + * in r5_core instance. We will use hardcoded TCM information from
>>>> + * driver for now in this function.
>>>> + *
>>> It would be a good idea to explain _why_ hardcoded values are used.
>> It is explained in function, but will add in description too.
>>>
>>>> + * @cluster: pointer to zynqmp_r5_cluster type object
>>>> + *
>>>> + * Return: 0 for success and error code for failure.
>>>> + */
>>>> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>>>> +{
>>>> +	struct device *dev = cluster->dev;
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	int tcm_bank_count, tcm_node;
>>>> +	int i, j;
>>>> +
>>>> +	/*
>>>> +	 * ToDo: Use predefined TCM address space values from driver while
>>> I'm not sure why there is a "ToDo" here since this is exactly what you are
>>> doing.
>> Ack. ToDo needs to go.
>>>> +	 * system-dt spec is not final for TCM
>>>> +	 */
>>>> +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
>>>> +
>>>> +	/* count per core tcm banks */
>>>> +	tcm_bank_count = tcm_bank_count / cluster->core_count;
>>>> +
>>>> +	if (tcm_bank_count <= 0)
>>>> +		return -EINVAL;
>>> As far as I can tell this can't happen and as such should be removed.
>> I kept this check for future, when we add TCM dt nodes. I will remove it.
>>
>>>> +
>>>> +	/*
>>>> +	 * r5 core 0 will use all of TCM banks in lockstep mode.
>>>> +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
>>>> +	 * 128k. Assign TCM banks to each core accordingly
>>>> +	 */
>>>> +	tcm_node = 0;
>>>> +	for (i = 0; i < cluster->core_count; i++) {
>>>> +		r5_core = cluster->r5_cores[i];
>>>> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>>>> +						  sizeof(struct mem_bank_data *),
>>>> +						  GFP_KERNEL);
>>>> +		if (!r5_core->tcm_banks)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (j = 0; j < tcm_bank_count; j++) {
>>>> +			/*
>>>> +			 * Use pre-defined TCM reg values.
>>>> +			 * Eventually this should be replaced by values
>>>> +			 * parsed from dts.
>>>> +			 */
>>>> +			r5_core->tcm_banks[j] =
>>>> +				(struct mem_bank_data *)&zynqmp_tcm_banks[tcm_node];
>>>> +			tcm_node++;
>>>> +		}
>>>> +
>>>> +		r5_core->tcm_bank_count = tcm_bank_count;
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
>>>> +	struct device_node *np, *rmem_np;
>>>> +	struct reserved_mem **rmem;
>>>> +	int res_mem_count, i;
>>>> +	struct device *dev;
>>>> +
>>>> +	dev = r5_core->dev;
>>>> +	np = r5_core->np;
>>>> +
>>>> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
>>>> +							sizeof(phandle));
>>>> +	if (res_mem_count <= 0) {
>>>> +		dev_warn(dev, "failed to get memory-region property %d\n",
>>>> +			 res_mem_count);
>>>> +		r5_core->rmem_count = 0;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	rmem = devm_kcalloc(dev, res_mem_count,
>>>> +			    sizeof(struct reserved_mem *), GFP_KERNEL);
>>>> +	if (!rmem)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	for (i = 0; i < res_mem_count; i++) {
>>>> +		rmem_np = of_parse_phandle(np, "memory-region", i);
>>>> +		if (!rmem_np)
>>>> +			goto release_rmem;
>>>> +
>>>> +		rmem[i] = of_reserved_mem_lookup(rmem_np);
>>>> +		if (!rmem[i]) {
>>>> +			of_node_put(rmem_np);
>>>> +			goto release_rmem;
>>>> +		}
>>>> +
>>>> +		of_node_put(rmem_np);
>>>> +	}
>>>> +
>>>> +	r5_core->rmem_count = res_mem_count;
>>>> +	r5_core->rmem = rmem;
>>>> +	return 0;
>>>> +
>>>> +release_rmem:
>>>> +	for (i--; i >= 0; i--)
>>>> +		kfree(rmem[i]);
>>> Function of_reserved_mem_lookup() doesn't allocate a new reserved_mem structure,
>>> you get a reference to an existing one.  As such there is no need to explicitly
>>> free individual elements of the rmem array.
>> Ack.
>>>> +	devm_kfree(dev, rmem);
>>>> +	return -ENOMEM;
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
>>>> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>>> +			       enum rpu_oper_mode fw_reg_val,
>>>> +			       enum rpu_tcm_comb tcm_mode)
>>>> +{
>>>> +	struct device *dev = cluster->dev;
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	int ret, i;
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
>>>> +		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
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
>>>> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
>>>> +	struct device *dev = cluster->dev;
>>>> +	struct device_node *dev_node = dev_of_node(dev);
>>>> +	struct platform_device *child_pdev;
>>>> +	struct zynqmp_r5_core **r5_cores;
>>>> +	enum rpu_oper_mode fw_reg_val;
>>>> +	struct device **child_devs;
>>>> +	struct device_node *child;
>>>> +	enum rpu_tcm_comb tcm_mode;
>>>> +	int core_count, ret, i;
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
>>>> +	 * fail driver probe if either of that is not set in dts.
>>>> +	 */
>>>> +	if (cluster_mode == LOCKSTEP_MODE) {
>>> Why is are LOCKSTEP_MODE and LOCKSTEP_MODE defined when the same values were
>>> already added in xlnx-zynqmp.h in patch 3/6?
>> Actually LOCKSTEP_MODE defined in this driver is taken from dt-bindings of
>> this driver. However, PM_RPU_MODE_LOCKSTEP defined in firmware represents
>> value expected by firmware. They are not the same defines. LOCKSTEP_MODE = 1
>> which is defined as per xlnx,cluster-mode bindings and similar to ti
>> cluster-mode bindings. PM_RPU_MODE_LOCKSTEP = 0 which is expected from
>> firmware.
> Ah yes, you are correct.
>
>>
>>>     And why not add SINGLE_CPU_MODE
>>> there as well instead of duplicating things in enum zynqmp_r5_cluster_mode?
>>
>> SINGLE_CPU_MODE just represents xlnx,cluster-mode value from dt-bindings. It
>> is not supported in firmware.
>>
>> There are multiple ways to configure r5 cluster in single-cpu mode.
>>
>> 1) Add new EEMI call which asks firmware to configure cluster in single-cpu
>> mode.
>>
>> or 2) use existing EEMI calls and configure cores from driver. As
>> single-cpu-mode is not supported yet, I am not sure, how it will
>>
>> be implemented or what its design will look like. So, I haven't modified
>> anything in firmware driver related to single-cpu mode.
>>
>>
> That is fine.
>
>>>> +		tcm_mode = PM_RPU_TCM_COMB;
>>>> +		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
>>>> +	} else if (cluster_mode == SPLIT_MODE) {
>>>> +		tcm_mode = PM_RPU_TCM_SPLIT;
>>>> +		fw_reg_val = PM_RPU_MODE_SPLIT;
>>>> +	} else {
>>>> +		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
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
>>>> +	child_devs = kcalloc(core_count, sizeof(struct device *), GFP_KERNEL);
>>>> +	if (!child_devs)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	r5_cores = kcalloc(core_count,
>>>> +			   sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
>>>> +	if (!r5_cores) {
>>>> +		kfree(child_devs);
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	i = 0;
>>>> +	for_each_available_child_of_node(dev_node, child) {
>>>> +		child_pdev = of_find_device_by_node(child);
>>>> +		if (!child_pdev) {
>>>> +			of_node_put(child);
>>>> +			ret = -ENODEV;
>>>> +			goto release_r5_cores;
>>>> +		}
>>>> +
>>>> +		child_devs[i] = &child_pdev->dev;
>>>> +
>>>> +		/* create and add remoteproc instance of type struct rproc */
>>>> +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>>>> +		if (IS_ERR(r5_cores[i])) {
>>>> +			of_node_put(child);
>>>> +			ret = PTR_ERR(r5_cores[i]);
>>>> +			goto release_r5_cores;
>>> If we are here and i == 0, we are leaking a reference to child_pdev since the
>>> loop in release_r5_cores won't execute.
>> Ack. I will check if i == 0 and put_device() before jumping to
>> release_r5_cores.
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
>>> Instead of using the i to check the cores, simply break if cluster_mode ==
>>> LOCKSTEP_MODE.  That will avoid the fragile dance around the manipulation of
>>> variable i and simplify the release of resources in release_r5_cores.
>>>
>> Actually variable name "i" needs to be changed. I need that variable to
>> track how many cores  are added successfully.
>>
>> So, if first core is added and second core fails, then I can release
>> resources allocated for first core successfully.
>>
>> So, instead of "i" I can use meaningful variable name like "cores_added" or
>> "cores_allocated".
>
> You can still use variable @i, just don't use it to break out of the loop.  As I
> pointed out, it would be much easier to simply do that if in lockstep mode.

Ah! makes sense. I will check for lockstep mode instead of @i counts.

Thanks.

>>>> +	}
>>>> +
>>>> +	cluster->mode = cluster_mode;
>>>> +	cluster->core_count = core_count;
>>>> +	cluster->r5_cores = r5_cores;
>>>> +
>>>> +	ret = zynqmp_r5_core_init(cluster, fw_reg_val, tcm_mode);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "failed to init r5 core err %d\n", ret);
>>>> +		cluster->core_count = 0;
>>>> +		cluster->r5_cores = NULL;
>>>> +		goto release_r5_cores;
>>>> +	}
>>>> +
>>>> +	kfree(child_devs);
>>>> +	return 0;
>>>> +
>>>> +release_r5_cores:
>>>> +	for (i--; i >= 0; i--) {
>>>> +		put_device(child_devs[i]);
>>>> +		rproc_del(r5_cores[i]->rproc);
>>>> +		rproc_free(r5_cores[i]->rproc);
>>>> +	}
>>>> +	kfree(r5_cores);
>>>> +	kfree(child_devs);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void zynqmp_r5_cluster_exit(void *data)
>>>> +{
>>>> +	struct platform_device *pdev = (struct platform_device *)data;
>>>> +	struct zynqmp_r5_cluster *cluster;
>>>> +	struct zynqmp_r5_core *r5_core;
>>>> +	int i;
>>>> +
>>>> +	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
>>>> +	if (!cluster)
>>>> +		return;
>>>> +
>>>> +	for (i = 0; i < cluster->core_count; i++) {
>>>> +		r5_core = cluster->r5_cores[i];
>>>> +		put_device(r5_core->dev);
>>>> +		rproc_del(r5_core->rproc);
>>>> +		rproc_free(r5_core->rproc);
>>>> +	}
>>>> +
>>>> +	kfree(cluster->r5_cores);
>>>> +	kfree(cluster);
>>>> +	platform_set_drvdata(pdev, NULL);
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
>>>> +	struct zynqmp_r5_cluster *cluster;
>>>> +	struct device *dev = &pdev->dev;
>>>> +	int ret;
>>>> +
>>>> +	cluster = kzalloc(sizeof(*cluster), GFP_KERNEL);
>>>> +	if (!cluster)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	cluster->dev = dev;
>>>> +
>>>> +	ret = devm_of_platform_populate(dev);
>>>> +	if (ret) {
>>>> +		dev_err_probe(dev, ret, "failed to populate platform dev\n");
>>>> +		kfree(cluster);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* wire in so each core can be cleaned up at driver remove */
>>>> +	platform_set_drvdata(pdev, cluster);
>>>> +
>>>> +	ret = zynqmp_r5_cluster_init(cluster);
>>>> +	if (ret) {
>>>> +		zynqmp_r5_cluster_exit(pdev);
>>>> +		dev_err_probe(dev, ret, "Invalid r5f subsystem device tree\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
>>>> +	if (ret)
>>>> +		return ret;
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
>>>> +MODULE_LICENSE("GPL");
>>> There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.
>>>
>>> More comments tomorrow or Tuesday.
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>> -- 
>>>> 2.25.1
>>>>
