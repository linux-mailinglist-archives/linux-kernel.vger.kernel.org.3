Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F120539D37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbiFAGaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbiFAGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:30:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7545F8F8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtakC3/PLTmCpTnmGpSbsJHnpDEzT3BjmcpIfe4diFN2Py2FO32xEbucP4EpIOZZnh1zrKd9pJ9Tp7XVHkliDo2CuYIs5AcVPfE+GALeuleIWku6KWWbQTGfxd5NUllgQOaY+fNjcd6xZSPzN6krMbn044JXP0KwdLSop0qZprWzAHPG8sadlb4lKtFTdG79AxyMXyT7ig1+awdd53xEBie4XDob5YSR9b0mwgLyJe2bOpFmFaf/z652JJsBZA115z+GEuQTcjHqKJCccxwOhVSqmc+yOFgSl1tBQBtzq65212Susu1RPQlmMRKFVn2Skjq0yAMW8SrfWK30gv0R4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML8jmW9d37g8/b70sCqGqz2BtW+/ii1GO7pFtspW7Vs=;
 b=Q2Yl3GbBp50wV3+pwxwua6Z899Rvm2Mx6UVYxra1AX3RcD/qPzQ343WCCLSezTUiFyitPzP3X+qIsxX4CjPnxr5EsK11++59caLiM7HPzePC4is81sw2IRDLgQyayF16EpiP0KoKahdAAlrRE2B93ICvJeZFFWYzvpuplSLww2ZVIHvn7OeIIRR+sWKECAm+3sFuebLOHu4P7m44utOB2wstMyZi6qMiC4Ymv1sqsNDm1UdWMFYngpoRM7RVRYtdfxsvwW9CKkcqPNE3IuSub/mlTijkud7V07mgr08ynWewAVTTg1HS2Q0q9tmWbLjEb3LIjbrA03KgcTvMJGkPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML8jmW9d37g8/b70sCqGqz2BtW+/ii1GO7pFtspW7Vs=;
 b=4CZSO9nu6I2ADoB7wpzH+uhWIO6yviGn2oMe8Qymail8784h6n2cerICgPFw6Q5OiqxOWuc/oXzGQodwnkN1UI0+uMW0gp7IpfZZVuSiNQkBMCpup3lX5obcxYSlzNm7Je8nPaQ2c90gzSJhyay8kbGupjdTb7WWx+Qu+/uyKzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:30:03 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd%5]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 06:30:03 +0000
Message-ID: <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
Date:   Wed, 1 Jun 2022 11:59:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2ff1d18-c109-45ed-815d-08da4398291d
X-MS-TrafficTypeDiagnostic: PH7PR12MB5654:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5654F4B3666C2C3E57D8AB8BB0DF9@PH7PR12MB5654.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/MmQ+30g3EJqsiMleHPhEm80mJ6jnh4nFRg0xArTeEb4XQ7MulAPe6Wb5OLeqRecMoFvG/HdrMJr+TaAvAyOowLQuTEpZmT8p1DqU23/wkqL94HQno2u9rk9M7K0ngfjY52VLfbz9vjtYxuLnBF5vH4OE2KN+jkjBAkEnWh712+ZYKzcwMmtFBysLVvt8Cd+0p3/jMVTSewEknutzRidIdC9YKzFWN6tkLrvMYwM3R6ZrLHwEqvzfnB6qSKmc6Q2242Vyiuikc9jr4r3BTY4cy8EGATT+opi1QDb4q55FyIvh784i050He5H1m1mI03cqNqKLTpO878dAddGqtZEZca1qRE3kFlIfDAczcDOpgM0raZgSHl59esHPyeIv3fEpk4ktfDVm9c7ltdZjC2UGbF92qOsGzU9EVGfF/NC64Jegw2Km0SXbadrV1KIyF9WTROscxZbNCDkr8jVXeXhmvTNdeiJD+kOfCT8MNooHIyWexq6Y9PXUIGv6MciE26ZMUS+lKWCFcHSXm9MN469EyrFXkJHpI+mmd6HQEWm6kI2nHwRUXsSukYmUs0nDcPYo7ZltQytuu3t+aBKEbDM39tJiRnjpTpXWWdRp48B0lfLdrkVT6sJ5ImzlN4C1y6Wle6Ev5hEYgtEDShUH6FYqaJ5SN9d8XzPDlJ+d/gqqC5ldbcHEYQWQRL1qNO8CmqFH4L3q2yQhhTuzjQmx7M1gVQnHH+n7343egrpDx10cE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6666004)(6512007)(7416002)(26005)(53546011)(6506007)(316002)(54906003)(66556008)(66476007)(66946007)(86362001)(6486002)(4326008)(8676002)(8936002)(38100700002)(508600001)(31696002)(31686004)(36756003)(2616005)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9RNUV3ZUVUSjZRK3BhMnNFbUYzNkVLMTVQOWlkQUhPR2M4ODBpZ2xzUEFJ?=
 =?utf-8?B?Ym96YUNSU1VvRXNrRGRsK3VpdVgrcEt3czhQL3ZwOEw2L2V6TEZFb3pnV29a?=
 =?utf-8?B?SEN4UzJQOHNhRlByVnVBQ1hJNTJIZnJ2VG9nd0pLM3ZJQUIrZ1ViaVFpcnAr?=
 =?utf-8?B?ekV1L01Ia3l6QW5jTGZ5VThaOTVTUWhsVWtlU0dUK3IrTnJVd3g3WWJEQVda?=
 =?utf-8?B?S09ROVZrb1FCVmVUWk9YOER4M29SWkQ3TDFGdkpjSnNFQmpGTzBRaS80TnN3?=
 =?utf-8?B?Z0h5eVphQ2paN2E4cEtyblpMd3ZpMG1oSGFwcW42NFZQaHQ2SFkxMnVURllm?=
 =?utf-8?B?aVRjeCtpREoxL3FBWDJBNVZmWnNrZXphaEI4UDZXSlE2bWNVQUZrN3dFWVR5?=
 =?utf-8?B?aU16RW1Ta0tKdFY4SXhMQUZ1QXYzaXN4NWF3U3lLRHdlK21uYTBkbW5YcERV?=
 =?utf-8?B?aFBWNzFMcVhURkxOVUtnbUhBT05HaUg2dGpvQUdhM2c0VjBGa3RVRWxnV3Rp?=
 =?utf-8?B?VFFQdzZMbVVxYlJaNXpKeFg1OW9VS09SY1Y0ZHUwdDFaSTJHdHJYY0xHVEph?=
 =?utf-8?B?dWNwQUlXT0djODRYVVM2QkhKS0ErNklOdndKSE1ESzJZQ3pqS1hwTTNFanNk?=
 =?utf-8?B?cnNNbkVNZm9CeFpmanBMb0FRVWV5VG5BYlZ6UHYvTzJJaisxV0JzSGhGcVda?=
 =?utf-8?B?OWh4SUtiT2VLdWZYR1VISHZaako1M1dkMm5OY1B3ZXYyOElZalZtQ1dVNGJz?=
 =?utf-8?B?emFCZGd0TGFCazQ1MGl0ZGdVOEZDMmlOT1FDVFV2RERRaXVhdGhrNzZIOGx6?=
 =?utf-8?B?ZWFmM2M5WlhLdENYY2Q4OWRrM3pMdVNZbkRyNUxPa1E5blR4cUcwdXRwZlN6?=
 =?utf-8?B?clJwdkdUbzNVN2J0SXhkRFdxYXVSL201TEZSeU1yd3FHb3pGSDkwWUNMd080?=
 =?utf-8?B?ZkIwV0tNZC9ERGRqOVJoUjdHMU5FUTJpTHZVcHlDR3E1aDRUWnJNdXJqaWdQ?=
 =?utf-8?B?QnZ1Mmh5ckxUYldFK0hKTHpJUkhheVJROVBxR1VEek5pUTUrbGJoTnJpQzBv?=
 =?utf-8?B?aWNjeVE0clp2WHhQWFdvdXVOdENxcHlheUpZL3MwZElYUlc0d2h6eHVSbWtD?=
 =?utf-8?B?V2hjbXZBdHVLMVVOTnM0TGJhc2RzVmdNenE1WW1ZR1JxdlUvNHA2eEhoVVRp?=
 =?utf-8?B?bnRCbklLQS8xK3prNTAwMytPNzRCN0dVYzgwUEd1ZTFFOXFTaW05YnMzeUtk?=
 =?utf-8?B?SGlkWDA5SThRYnM2WjM3ejhaWTMwVi9WR004U3pVK1h3dXpIbjROcnVzTnJq?=
 =?utf-8?B?TEpWczZSRExINUp2WHE2QWtmTGlaR3NmNHpOZjh2UTR3U3NrL2tBQmlwYmlF?=
 =?utf-8?B?Wit3Uzh4U1Jzd0ZZa1pzZVFFMEVJYlcxOTZtRUUxbFZKYjRFT1lCUVB0UXFL?=
 =?utf-8?B?Q3VwTG5lY0JYenF2OGl1NGUwOWhmSS9hV3JZdzBFSlF2bW1QREc0SzhOaHhm?=
 =?utf-8?B?N0R3TDM2cHVxTTM3SlJDcWRBSUFVZkRpY2dRSlZZWWVSbXFqbW5GUmVOUTF3?=
 =?utf-8?B?R29NTnhubllkQm42VkdNS21TVHg4NXMvc2hQY3htWUpVTkxWWXMyNmJqd1pC?=
 =?utf-8?B?ZU5LZUZxdlcya0kyRkl6R0d4NFJ3U29zemxsaGY0ZW1LOXVWWndtVGJRTHBH?=
 =?utf-8?B?OFF5alJPQ1h4Q0JNcDFLeENmaGtxOUxPZGJwUUthNjJzZGFaWFlpUElmYm5O?=
 =?utf-8?B?THB1emI3WGtCOEFHSWNFemY0V1RYMXg4MWJVQ0F1a2hYcTVmZldBZ1VaRzdG?=
 =?utf-8?B?ZmFoTXpWK3ZtaXVXRVRLLzk2dUg1Y3dsdWt0NUMydWNGcnpVall6aE1oN0dX?=
 =?utf-8?B?NFBvR0xoTzRzdFZaM0g2SGhVMGhIVkFITmtlcnlnT2Q1Y0VISU9yRXFXN1Z0?=
 =?utf-8?B?Q2ZOS1BrQVVKRFdBNXZVdmtjRTR2bDhZVXJYVDRHbXgwc1BLdTBybytJeHFN?=
 =?utf-8?B?YzRuSVcyU3U3aStTMWYyUjBpeThZL0MyMEsxT2w4RnRiclB0alBJZVhuQWxX?=
 =?utf-8?B?QytUektzeXFlSTI5aGJGNGgzN2JibUt3SHZwVEEwNUxVQStEV0NNanhTUWJq?=
 =?utf-8?B?SGZ0WkxmcXo0L2l3QTJzMnVjN0d1T0NkSjFGM0ZUWkMxeDZXdHRybTFpVm4w?=
 =?utf-8?B?bmxQeFZjeWRBajFjUG5oMFpBSUc5SUFKc2kxMURNTEJwQlBNWlBOUlRXU1Jk?=
 =?utf-8?B?TDF6aW8wek5MbWdWcU1qa2ZhTlVONzFxUy9uTFJRRm11SjIxbkNmQnhNYTc2?=
 =?utf-8?B?d1p1TDVjcUdrektoZWhOclJOWVM3T2lITVhvSzRRcGt2Mkd0cUxXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ff1d18-c109-45ed-815d-08da4398291d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:30:03.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jkpFpjCUXon/dUrlg3OPmA0OrGz0TIxzPzwU5rCqlhxWkmdQIfjZ8dtH6Y6c6NeDAr1LxkGZxLqZgIuu9vR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/2022 5:55 PM, Aneesh Kumar K.V wrote:
> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> 
> By default, all nodes are assigned to DEFAULT_MEMORY_TIER which
> is memory tier 1 which is designated for nodes with DRAM, so it
> is not the right tier for dax devices.
> 
> Set dax kmem device node's tier to MEMORY_TIER_PMEM, In future,
> support should be added to distinguish the dax-devices which should
> not be MEMORY_TIER_PMEM and right memory tier should be set for them.
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/dax/kmem.c | 4 ++++
>  mm/migrate.c       | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..991782aa2448 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> +#include <linux/migrate.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> @@ -147,6 +148,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  
>  	dev_set_drvdata(dev, data);
>  
> +#ifdef CONFIG_TIERED_MEMORY
> +	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
> +#endif

I was experimenting with this patchset and found this behaviour.
Here's what I did:

Boot a KVM guest with vNVDIMM device which ends up with device_dax
driver by default.

Use it as RAM by binding it to dax kmem driver. It now appears as
RAM with a new NUMA node that is put to memtier1 (the existing tier
where DRAM already exists)

I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
that expected to happen automatically when a node with dax kmem
device comes up?

Regards,
Bharata.
