Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F594E3625
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiCVBrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiCVBrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:47:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE41EC40
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsmsw83G8TjDZ86MIBnN8a/lx3Pfeah8gYLTDmpK2i5zSq60bDGxp+LrJO42o3bsBvIOLjqJEhuJG+sc6dSQ8YMikGdZrg2nCW46rlKB44Qo43utGjT6/oHLysuxAW4vf6DDI96EAp5iczg2touHsI3v3uvwFurUxcKf0J1k5do+acLa8fhf3g34v9xKugpXjA5rnjuI2bv0HVpWcKHvJKJ/PpXBchwr/4CaxbjRwvIfAbr2bJNcUw60ztDsTiPHZPJiJiAq2tg3kA8zFPQv4hZy36ge0xBnko0l9R861hQBFPS7O//YQoGxC6iCe5eETmfNpT17vibWVOVTBNJjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzorXdj+pu4g1OvOsgNxTkO26tIt2Lc6N1OIyiOkr8Q=;
 b=gcuYNQ7NTzZuflGNGVFHJuLGVulIuUzVBlkOdUe8tRntz5qtbilNqrPaD1ljEQRuzd9x+T5/Eenac+eCaF/muMb8QjP7NqgX/7LqTreECeG/aA15D3qOja1LPkhCUwHABA/N4NQwvxRvlbmyN5ubVBw+Pbu/lApHMah9SQreB49A7uTX5RZCMw99ZLXU+Z0mJythaOOTmsOaQ27zJ/eOTgUntKH2lGPRqjw1h6ScVjxdZXppIzTcKnwbXPRD4lX/fhg9jcYFjr21ds6HPc/XluxkxDVNfTexC+wDhuJa9p07WlWyXtjhvO4b8a/TckD4Vmb1BV2sUfqpLb5ibj2+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzorXdj+pu4g1OvOsgNxTkO26tIt2Lc6N1OIyiOkr8Q=;
 b=e1djfYtplLz5cck6qDdMm5Q6ePPWxIPbsCRPFX32+N4nlTrRYDt/kpNL6cRxKoFi7OqkBaK6pGJR/9jlZTSOI99YZMfloNjQRYi4PEUNfc7c7U8OFB0YoaNIBk13LgmiiJ+m2zFBacDC9/LozB+/q/5xUE4dFOjWRSXMx9DqdAavUDU+vQi7iHvdn8KjPj6Vjh4GE/mo2SK/I+16mVHHlP0Fyrzw7iqwxyOiL7tDv5g4XsA7Ayz2pEwZOqT/bOHk8CQPUHape0urEbDOomaW2e/WzPOsEw2IzrsMV5A2Fq967uXhdscGGK9QSw2ucFpriyM0CFVWBrYAIOJpf6pwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3125.namprd12.prod.outlook.com (2603:10b6:a03:dc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 01:45:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 01:45:51 +0000
Message-ID: <ceb1f1f1-ba8c-58c1-b33e-31324424f608@nvidia.com>
Date:   Mon, 21 Mar 2022 18:45:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] mm/hmm/test: use char dev with struct device to get
 device node
Content-Language: en-US
To:     mpenttil@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     apopple@nvidia.com, rcampbell@nvidia.com, jgg@ziepe.ca,
        vbabka@suse.cz
References: <20220321025410.21286-1-mpenttil@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220321025410.21286-1-mpenttil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998aee28-23fa-43d7-1f2b-08da0ba5b248
X-MS-TrafficTypeDiagnostic: BYAPR12MB3125:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3125CE980842E813E71439E8A8179@BYAPR12MB3125.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pwD4HV7Hnq/CYaGdmU5zOj3jHF4FEBepzCZe5KAcGCGpYPaurP8UJlEMe+ofdtHVMHRv/Xw7Bats8vBFRKN8uKL0/ehfuJ5eTHXj5gW2Q4nSa+RdgoFsmRfgmF6r9m2LOmh+mnqGfCK3C9XnTA6wrLLCk+K9kxiSNq/3CnTaPv2LYPKaAymqvpfRpBiFSP5++aEA6aBsUgCVXZin4vraBLLpyEMM4FixlnprtZYeOg8/92MzA3q1liMwcXDQ6hhT1D6Gkcg+LbLGhgOY9UhcFXfNb9P4DaWL8U5X/gp7oV5rpwu7nq1wSCp9oL01xuxRtAZSt8auyFlB9rpkJ06nJP/uYeWoG+wNTBRBTUIR+HppTDZoYjwEEgxh76e0ICpgREWtfqgpgPLcEYp8+46YmXFJ248YaahLLxOeA87g0Akqbcq5J2VUbBdMUlgENvFIyLRzX6khKrgeLD148SWeHGhLqW55eisqlAIdKIg5qF83LDw4BDoCCOwJzzOJOLmNy3+GeEoKS2yqyEXSM1ERRww+g68SVwaK+LXU8GraizvobQ8WziAruY9+ymCJg8QaELjAiU8nU7S6GP68CcUL3fq9g4pok6md2IdSWqc3M2SjXD1CDSVqC1tWfVLK4ELvIpFdhwcqAatajCgGzQf2yT7Q+fXYtmeb5+5er7HqfZ18u9/69m3BgbUwh3LxuMb+lX7wHnfwE07t7KHe+VgpEQw8dl1dPfVC39ftM05oxWhZp0C/mCIvb6mBuTnFyNK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(53546011)(31686004)(38100700002)(86362001)(6512007)(31696002)(186003)(5660300002)(6506007)(36756003)(26005)(4326008)(66556008)(8936002)(8676002)(508600001)(66476007)(66946007)(83380400001)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2ozOGpkVU9Pckh6SDJvTFdoZmZDMFlLdGtTRGNKWjZjS3czNUp6Z2F6Z3Yw?=
 =?utf-8?B?SHErNjdvdlhxUXBOQUo3ZVpuTk45UjRFY3ZHMVZINjRJQWdEN2R2MjhWRy95?=
 =?utf-8?B?ajluY2dLaStHL0lpVXJkak9jUTNVeFo3OXdLeTdwVlVOR2JQMU9MUEw2MFhE?=
 =?utf-8?B?REhqdGpXT2QwREJwaTdsbytkempNSGxLRTlWK0NCUlgza295dnNjRWdibnFS?=
 =?utf-8?B?bjhpYzc3QUQ3N2VBd0ZWWHh3VGNWS2hOOWREYUhVSUQwa1ErVEdXWTJ1Zkpk?=
 =?utf-8?B?ZjdHVjNieFh2QTZjK1RNWFhyOVRBekQyL0hjNnRJOExVNWdYKzk5MzFyWng2?=
 =?utf-8?B?VDdqY29mWThZZ3JLVHRHZ0liQ295WWpsMWpaUjJQZWxwTWdjRlFhTHFCdkJD?=
 =?utf-8?B?VkpHcVBTdkhSVDdLS1huZkJwUU5ZSk5zWWVBck84WnhtZHMzdnpOZ010SU43?=
 =?utf-8?B?d082Vmw4eTR2OTNScktHa0hBNllXVXNoWWhLZlovUVp2MU1UcVczSm1YM1Bq?=
 =?utf-8?B?NjBxYlVXamJjenlmWDh4dFdBNU1Zd0lTYnlPbzd3ZEllN0xEU3EvMGtkV085?=
 =?utf-8?B?Q2hrQ2ZnZFFleERQaUx0Vk9XaVpKdE5ySVljUUZGYnMyU21XeU9GODNaZ005?=
 =?utf-8?B?bG1LcnZyd0ZUbmh0ZlpBS2FCMGRmQ1Buam1ZaExlNFkwY2Noa3RyK1IwUlJv?=
 =?utf-8?B?bTRGVDlZcUFrSDZKNFV6ZDcvcUc0NERBYytGYnZWa1FXYjZUeDhvazY0b2FQ?=
 =?utf-8?B?dFdOTTYvMWw0dUs0cHpFN0hPTTd1NEs4bFlkVWJPNkN2OXN3SkVVYjZ6cWhS?=
 =?utf-8?B?RzhGVXdBMXU1bTJNWlNHMWF5aExpQ2k1N01VRjF2NWJsWEh1ZmtmY3ZpM1VD?=
 =?utf-8?B?SGdnRHV3alJ4RHNlMHg2TC8ybThpdFdyQmtVMVRoSGNXS0JSYXVad0x0ejhD?=
 =?utf-8?B?OU1aRzBhSE9iVFF6NzMzRStKSDJibVkvRnhFcnY0MFp5RFNGM3oxZDNTRXg4?=
 =?utf-8?B?cmp2T3F0ckpHdTd1dGRxRC83ZDJIQ0JhZHpuNkFQRnlNUENwRjRlM0o2SVdJ?=
 =?utf-8?B?VU1odW9EU09UNzJ0RzZkdm1yZWhMaDZhcEZNdEI2MnZsRG04L3Nmemx3VG0r?=
 =?utf-8?B?UElxRFdhQWVaZ042N1FWTVdBQ1ZnRytqbXFHUmxXYXdKdjNObzNSdXZOaFZJ?=
 =?utf-8?B?Rm1sUEQxenp4a0RZMEI5eUcvTnFzbnQ3TCtldTllMUJOTHE4UHV4NDJ1ZnJ3?=
 =?utf-8?B?UFlPSDh5WDJmNXNWSzl4M2Jua2tZL2dnTVVGbUt3Q2Nab2Y0eWNWRW80S1dM?=
 =?utf-8?B?a2Rtc2UvNDQ5U0hWeG43c0huUnRJLy9XSW40TXQ5cUtPZFNqNlNMYUNUVmhn?=
 =?utf-8?B?NWxoc1NnQUVwT3BkUDZmSFBnOGNkQnRrMTlwSnlzYUhxanBOMHRzdndZUHl3?=
 =?utf-8?B?SXAwVmtUd0h6Y2xMTndkczBIdjFBai9mOE1rSGt2OXp1TjhUcmNBT2QvcGZm?=
 =?utf-8?B?UnlGRUVLcUtBOWtZNGIrNEdpWENTRjh6bkp2dnlqalJmSDh0T1ZYK25oZWVD?=
 =?utf-8?B?Mzd1SkYwTkc1ZitWenpkNTBnd1pJWDA3cTF3WXVvRllQVjRDNjF5TzBzTmI4?=
 =?utf-8?B?RDkvdDBUU01KNG5tV0hpcEhNM083elRQczhteWVWdkx1SE5DeVFvdTJwU3ds?=
 =?utf-8?B?MHBiTjBVMkozajcrQk9RNTJMQXVaSFlEd25NanBlaHZkWVkrTVpnQ0tzTk96?=
 =?utf-8?B?anRqblpRNG9nL25TY0EwSHVuR3UvSGhyRW9MTXJZVW8zT2NiR3hhWGF6NThW?=
 =?utf-8?B?UTIwYjVyalJGSzFEaXN6Ty91UGFBN2VFZEVLT0pJQldwdW1RSXBLYm1aby9h?=
 =?utf-8?B?a1JVZ2JGc2dId2ZWbGRBbDh2S05mZE44emlsaVhnV3dUMEwrUFdiZmcrMWs5?=
 =?utf-8?B?OUpLUUtzcmkwWXh6bVY3aXVCcEZQeTJzRFpKSlJhRWpqNkNUR1hWVmIwODRk?=
 =?utf-8?B?MXpEZGZxZnZ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998aee28-23fa-43d7-1f2b-08da0ba5b248
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 01:45:51.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPBQsmYHJ5x8dt0JNnUthqczIio3EQK7SrXE4YwV0tQweqbhz4TDmQFtpaxZxnvERMuHSLITqxpSCbO68BkhGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/22 7:54 PM, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use an in-kernel pseudo device to emulate device private
> memory. The pseudo device registers a major device range for two pseudo
> device instances. User space has a script that reads /proc/devices in
> order to find the assigned major number, and sends that to mknod(1),
> once for each node.
> 
> Change this to use proper use of cdev APIs and struct device.

Maybe, "Change this to properly use cdev and struct device APIs".

> 
> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.
> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> v4:
> 	- fix commit log
> v3:
>         - use cdev_device_add() instead of miscdevice
> v2:
>         - Cleanups per review comments from John Hubbard
>         - Added Tested-by and Ccs
> 
>  lib/test_hmm.c                         | 25 ++++++++++++++++++-------
>  tools/testing/selftests/vm/test_hmm.sh |  6 ------
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 767538089a62..d247e9c0fe94 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -29,11 +29,17 @@
>  
>  #include "test_hmm_uapi.h"
>  
> -#define DMIRROR_NDEVICES		2
>  #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>  #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>  #define DEVMEM_CHUNKS_RESERVE		16
>  
> +static const char *dmirror_device_names[] = {
> +	"hmm_dmirror0",
> +	"hmm_dmirror1"
> +};
> +
> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
> +
>  static const struct dev_pagemap_ops dmirror_devmem_ops;
>  static const struct mmu_interval_notifier_ops dmirror_min_ops;
>  static dev_t dmirror_dev;
> @@ -74,7 +80,7 @@ struct dmirror {
>   * ZONE_DEVICE pages for migration and simulating device memory.
>   */
>  struct dmirror_chunk {
> -	struct dev_pagemap	pagemap;
> +	struct dev_pagemap      pagemap;

Unnecessary (likely unintended?) whitespace change. I notice that this 
file uses tabs to line up the names of fields and local variables, let's 
not disturb that unless there is some reason to do so, as it merely adds 
diffs that we don't really need, cluttering up the real point of the 
patch.


>  	struct dmirror_device	*mdevice;
>  };
>  
> @@ -82,8 +88,9 @@ struct dmirror_chunk {
>   * Per device data.
>   */
>  struct dmirror_device {
> -	struct cdev		cdevice;
> -	struct hmm_devmem	*devmem;
> +	struct cdev             cdevice;
> +	struct device           device;
> +	struct hmm_devmem       *devmem;

Same thing here: in this case, you only added one line, and the other 
changes are due to whitespace that should really just be left 
undisturbed.

However...I just noticed that "struct hmm_devmem	*devmem;" is 
entirely unused! Yikes. Probably best to delete it and add a short note 
in the commit description to mention that. Something like, "Also, 
deleted an unused field in struct dmirror_device: devmem."

>  
>  	unsigned int		devmem_capacity;
>  	unsigned int		devmem_count;
> @@ -132,7 +139,7 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
>  	xa_init(&dmirror->pt);
>  
>  	ret = mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
> -				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
> +					0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);

Another inadvertent whitespace change.

>  	if (ret) {
>  		kfree(dmirror);
>  		return ret;
> @@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>  
>  	cdev_init(&mdevice->cdevice, &dmirror_fops);
>  	mdevice->cdevice.owner = THIS_MODULE;
> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
> +	device_initialize(&mdevice->device);
> +	dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
> +	mdevice->device.devt = dev;
> +
> +	ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);

looks good...

>  	if (ret)
>  		return ret;
>  
> @@ -1252,7 +1263,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
>  		kfree(mdevice->devmem_chunks);
>  	}
>  
> -	cdev_del(&mdevice->cdevice);
> +	cdev_device_del(&mdevice->cdevice, &mdevice->device);
>  }
>  
>  static int __init hmm_dmirror_init(void)
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> index 0647b525a625..69f5889f8575 100755
> --- a/tools/testing/selftests/vm/test_hmm.sh
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -41,17 +41,11 @@ check_test_requirements()
>  load_driver()
>  {
>  	modprobe $DRIVER > /dev/null 2>&1
> -	if [ $? == 0 ]; then
> -		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
> -		mknod /dev/hmm_dmirror0 c $major 0
> -		mknod /dev/hmm_dmirror1 c $major 1
> -	fi
>  }
>  
>  unload_driver()
>  {
>  	modprobe -r $DRIVER > /dev/null 2>&1
> -	rm -f /dev/hmm_dmirror?
>  }
>  
>  run_smoke()

The diffs look functionally correct (although I have not actually tested 
them), so with the above minor cleanup applied (with, or without also 
deleting that .devmem field--up to you), please feel free to add: 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
