Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01CA4D5B73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiCKGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiCKGQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:16:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E4188877
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:15:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGMIz0twX67uaEBuu1YVJ+yWGiRZn3qHIk8KXELPXs4CTYnB5HlJUgpUp6LdrEDEamp5gSa4e599C0pg9b4kkdzr1syEr433RuK8QxrWH/2hw1VIfq2HEDztYglU9Tv1zaO8AwhOeHjnO9CK3JViIpWHA4RLYjwV3m970MH9sMdjTU4O6L4chrIFMZCqLg+pSwh/d7/ReT+XnNYhk+HycHfcVp580tESsqdYwWhhAuxB+aLmSW51R9wNAUJ1YSiZsj2EocmVeVzRATXxu8R8wx89ylB3X02bkxfPcHuYiMW22IVyvpfcQ48tngR/tjVapV6nfA7VY106Q/bXwuDOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy91tNzl7qK7wg3+wr+KGLiRhjtiyiYAQC53XG7YJzw=;
 b=ddKYrtY6TAWzOmJZM9+w4cB4AyYelVbsmQasLYF2y6nnwpQh0QXBjKJAw630fNi1Laygql5xmC+wPzRFmK69iYTFHZwha6jX2VTiC5YDYfDnsrU00vTknalCA27rk4d3mhL5xfkv9wFq2I3ZDuuoaPWTlbfv2TeZ2So1OCG7ap44N2/xa91NN1j/mtt9ZP/DLP4789OY4fM5k0EWrb64Ee2SGVfqYlHVwM8ak541VBX1iTyZ8I72IX2bLvFoTZ7KOoV8CDXVKYM3XZ5e65CbjWr6INrQtd9DtN9ZDV0W3TiN2vGJYgAL/75KIHvk+Z14M2ilSXX4+ENSrUsNoOQzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy91tNzl7qK7wg3+wr+KGLiRhjtiyiYAQC53XG7YJzw=;
 b=L8l9zLcx1cSOVgSQSA8bm3tQqdS1KzwtXhoKEtcUZ2uAN6DcNzkVHbvmc47ayAsC9r5Lvf9XmK+IeKQWPYZegjOuTplzydvvGeFrlsuggfRXLAKxoeZ2eRY2xAj3CuGUseHomk/ct0Nf4JWihd0OHCF+4Jggtc0Aa+BqNbiZJWS5y5MgJ49uAdvn58Dn9/p60wBo3CFIVzTZnRUg+c83pQkI7h23umWqaWPjubn0zn33Qj3oCodZDPmsiE9aHk7SyKesZQZUV1NZIO1ay4+0Gs2g8LUMSFTg1R7uULFjoJTyY9T+MkYm7cYphraJoo9ruMAmj7iUMSixp60P2ppaTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1256.namprd12.prod.outlook.com (2603:10b6:903:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 06:15:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb%9]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 06:15:07 +0000
Message-ID: <179e3540-b9bf-5fd2-cfa4-f7274b6c33d1@nvidia.com>
Date:   Thu, 10 Mar 2022 22:15:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
To:     mpenttil@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     apopple@nvidia.com, rcampbell@nvidia.com, jgg@ziepe.ca,
        vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220311033050.22724-1-mpenttil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37443d88-bdc0-48bc-2d58-08da03267d20
X-MS-TrafficTypeDiagnostic: CY4PR12MB1256:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB12569CBAB6966641DAAB99B1A80C9@CY4PR12MB1256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxvTFQVoYlqZ9LISOtitcWI/YPYBpaLLDdUiBrLgQ7j2i1OLx8UkPPArLZeYwVRZQUG7pdQMn/fIsy74qr5ZFpIMS699s2FZHUcRzjmcMmR5WD8rXvQAIT7b9CnSudCk6fZYSH/znUsbT0sq9H/iYwGIM40ENJThO/CqtDaE5M5kbhTz0H5G7eKul1lfeG45YDfGpSTRKIzhnqJZ4goHcaNDzVb8kKX8KtHKO4xVxyMcxZ0eh/WbklYcplwwxTpLjnS6sAV9dPoVxkVo/lljWIhuUddiszOBjYEt8TJOe0Bj0jNoTCm9xkscroYGyI3ebtSp2UDfuYSGyYT6VhYfxAyIRjyF8eC/q6ieTT3oIPKdEqrNqYIDu/SIJb2QDdZ4gbMzlLCv3hiegkgoM4JgpqYk57pwJ2nWjNtUOiAHyXbc45TqlZFHVLTRdY79TSZskTA8BcAItwUP7/rNxGCzr6itaa9cPt6y9lVWrzCflt70WgUiHasaqRnUSYm13rBf4wp7NAICelZ9jRK65ocw70HxmfrAkVgq3OdEhSXjoka4Z5V4wKqzYutP3yy2AOFftvJoW9afIrJe63tsv+TescizYyrq88gi1HrTAySz9+WqvjCl/kg4QV9kRilaT4nP8T3LMf8atXhYohqUkdmE6k5wZvsWjjeUayBEyR6skJalzwgb3IXH5xmuVluiHrNwy3VXTfMXoawKzRHugUCm9c86f4H9bWXNeV0XIJiRRkFbsxm2mGKq/a18Iw2uwNuR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(8936002)(86362001)(26005)(31696002)(186003)(83380400001)(31686004)(316002)(5660300002)(38100700002)(2616005)(6506007)(508600001)(6666004)(2906002)(53546011)(4326008)(6486002)(6512007)(66476007)(66556008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1lPY2lKMHNPTHpiYURLdGtScFZlQmxGR2J2SWpoaUVaQ1RUdjl1UlFkb0JP?=
 =?utf-8?B?ZlJnZFhEcE5MaEp0SzJOWVBXTXFsaEFSSWI4eHV0SzZhaFdqRG16NVFtNWJT?=
 =?utf-8?B?MnhDckx5UjFiVVBCcGdsb2MrTVJJQlVwc3hHemYyWjYwLytJS1h5bzVjbUlC?=
 =?utf-8?B?TW1IaDBodGdTTTBBdnlqaUZNT3BoREt5cVg3T0NGSkZkSElNaUQzYUtETjUx?=
 =?utf-8?B?ZUl6c0hRdUZJTUplSThQbWx3ZmtCb0lQSnp1OUFjYldmWEFFeUJ2OXhRbkZk?=
 =?utf-8?B?SGszVlNkVmE1WGxJbzZFU3BuakhXaHB6VHZVTTQydzR6TG9ReFN0NDBoWnBJ?=
 =?utf-8?B?bEtHbEh0Y1paMEJqYUF4QUdiMll1cjg1NFV3dGJQVE5QYzJpM3BJTUsyUzI0?=
 =?utf-8?B?cjJKSmlNWHFFMUNXanFhdjZFZ2ZmUXBQeDVtS2FWSXhzOGRLR0NRSlR6K3dR?=
 =?utf-8?B?cFlaSWJoZWJVakpBSjAwYkd4N0JWS3N3Wk9FTzFZVjl6b3dVVVBGV05LTit0?=
 =?utf-8?B?ZDFRS1d3cXdCbXlIUEw1emVJZ3hiaTVMWDUrOUplcS9kaG95U1o2MDJLWU4r?=
 =?utf-8?B?VUU4WHZpWGQ5b1ozaW9VYU1oNTltc2lZeUhVQXpNbThYdGI1L3c0aUFiVi9i?=
 =?utf-8?B?MHkxb2ZEQ0d5SVhvUFB3amtxWEkxZ1Y3Z1N2RUFRVGRXb2s3RVJQZkZ2cThs?=
 =?utf-8?B?ZGdsQWo1NUVKNlJRTjBXT0phV28yUjZhQXpNd21vR2Y4QWNObHJUa2RBaFQx?=
 =?utf-8?B?UFNSSmRkSHlIQlY2UERoaFJtc250T2Q4ZXdFZmRLamwwbmlIWWRncUlwQk5M?=
 =?utf-8?B?UE5FeG9QT0N2L0lmaG40SUQxeStiSHJvcy80d0NvTDlWRVlmeVRqZk9uNy9R?=
 =?utf-8?B?ZDhNaHVjK0paSTREN3lEMzl4UWVNcGk3Sjl6dXc0YlZUTVcwcUFsaHA0cWdT?=
 =?utf-8?B?cjBlcndnR2k3dEphR3Q3QkZIcnN4dk5OSCtlYUxUKzd0MWVKdWR1bmJWcGFN?=
 =?utf-8?B?WWZVK0NmVDN6SWZWdHkyUlhHQWoyMkVYd1JtWTlrYXJuQzNZYkxEWGZQNHc1?=
 =?utf-8?B?SG8xYU1jc3dXRFlzTzhucVpvbEMydTQ1L00vdC9qamMrdGlUVjE3aCtmK1RC?=
 =?utf-8?B?alNtNGdZMG42bXVlNTBTWlhMeFVXU3hNRUpaWGk2THpqS3lHaGZWM0hXdWJp?=
 =?utf-8?B?dFVWUXNtOGhncWpJdTRObW5BN1JZQy9OZDhuMk00SEtLV2N6YmU4RlFRNWxk?=
 =?utf-8?B?MHVJajd5ZlB6ekdHZ29xK3cweituUmdkMExTU3FvU1FNNTRZT1FCcHc5ZVdL?=
 =?utf-8?B?MFE3ODRTdzlDalIySXNzVlQ0ZkJkNWV4bEVZWUIyZXhmbGJsOWh3WEhsNm9m?=
 =?utf-8?B?YmlhSjVOYnVNY0tHUkErSjU2SmE4blBIVnphblVTeHc5TXFhZjM2RGU1L052?=
 =?utf-8?B?bEkrY1ZJV2Y5MDJlWHNJSjBISjR5c29iVjhIeHltUHVXQ09waE9UeWF1dmF2?=
 =?utf-8?B?UlBObzRtYmdiVkg4UkN6M04xUkhjZ3VhbHJkaE5rT1RFV25Kc1J0OFpCL1p0?=
 =?utf-8?B?eC9tTkFISW10YUFvbE1RTmhrS2JtOFhwOW9rRjBOeE0yUWIwbDRNNUN4SGRK?=
 =?utf-8?B?VE1INUc2Q2Q2UUZGSnZuK053L293MEF4TGM5TmRKMDdpUGdwNDZzeDR4Y1lr?=
 =?utf-8?B?WjFVZytYT0d3SU85bk5JY1VDZE8vM1gveWdjbUdwdE9JVERrdVU4M0JESDRD?=
 =?utf-8?B?MWdrZ2xpS29PaW1RZ01la1JqazNwTGJZem50MGxudU5tWmc0NUVuMitEanlU?=
 =?utf-8?B?OE04LzBZTHJRWXo5YUxuS1ljL0VEQkVqVlo0MmhybjQycGgrWVVlUXJBZ1Ex?=
 =?utf-8?B?TmlGOCtzaUY4a0RTS3poMXVNVE5kbGRXdnlXcncvZjRxRjJlazQ4elBWSnJT?=
 =?utf-8?B?RWdwa0tsSlFTVUhjem9SUFVjdEo3dnBvcTAzMWNIdDlxbzBWVG9MdzFsVE9Q?=
 =?utf-8?B?M01ZZXRrQThobUtkbGtnLzlMUnJGL3lzOHFlWDE4LzNyUk5KSDZwTkhGcDNs?=
 =?utf-8?B?MlE2NjRWdjlMUitCczQ2Vnl3dzJCY1BJNnRKQXlGbDVRYVo1b0lLdWtlWmZp?=
 =?utf-8?B?UzVVZU9sRllKU1RxdHdRQ050dTJ1d01KeFZRSk5YaWZodUhNbE1tdjhUSFpE?=
 =?utf-8?Q?RbDBbFwkbldsdZMZBYUIZzw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37443d88-bdc0-48bc-2d58-08da03267d20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 06:15:07.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9T0lVXlIKJ4akGC50yy7yY0KptTvo4BMRpu5YzbRyW57zVZABhm//mbJe6DqvFT70yOIOBnDnmxteSd0ElMsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1256
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 19:30, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use an in-kernel pseudo device to emulate device private
> memory. The pseudo device registers a major device range for two pseudo
> device instances. User space has a script that reads /proc/devices in
> order to find the assigned major number, and sends that to mknod(1),
> once for each node.
> 
> This duplicates a fair amount of boilerplate that misc device can do
> instead.
> 
> Change this to use misc device, which makes the device node names appear
> for us. This also enables udev-like processing if desired.
> 
> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.
> 
> v2:
>          - Cleanups per review comments from John Hubbard
>          - Added Tested-by and Ccs

The three lines above, starting with "v2:", belong after the "---". That
way, they are not included in the commit log. That's the convention.

I think Andrew can fix it up for you, no need to spin a new patch for
that.

Anyway, this looks good now, so please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Tested-by: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>   lib/test_hmm.c                         | 40 ++++++++++++--------------
>   tools/testing/selftests/vm/test_hmm.sh |  6 ----
>   2 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 767538089a62..0e1488e1bad8 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -10,7 +10,6 @@
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
> -#include <linux/cdev.h>
>   #include <linux/device.h>
>   #include <linux/mutex.h>
>   #include <linux/rwsem.h>
> @@ -25,18 +24,24 @@
>   #include <linux/swapops.h>
>   #include <linux/sched/mm.h>
>   #include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
>   #include <linux/rmap.h>
>   
>   #include "test_hmm_uapi.h"
>   
> -#define DMIRROR_NDEVICES		2
>   #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
>   #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
>   #define DEVMEM_CHUNKS_RESERVE		16
>   
> +static const char *dmirror_device_names[] = {
> +	"hmm_dmirror0",
> +	"hmm_dmirror1"
> +};
> +
> +#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
> +
>   static const struct dev_pagemap_ops dmirror_devmem_ops;
>   static const struct mmu_interval_notifier_ops dmirror_min_ops;
> -static dev_t dmirror_dev;
>   
>   struct dmirror_device;
>   
> @@ -82,7 +87,7 @@ struct dmirror_chunk {
>    * Per device data.
>    */
>   struct dmirror_device {
> -	struct cdev		cdevice;
> +	struct miscdevice	miscdevice;
>   	struct hmm_devmem	*devmem;
>   
>   	unsigned int		devmem_capacity;
> @@ -118,7 +123,6 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
>   
>   static int dmirror_fops_open(struct inode *inode, struct file *filp)
>   {
> -	struct cdev *cdev = inode->i_cdev;
>   	struct dmirror *dmirror;
>   	int ret;
>   
> @@ -127,12 +131,13 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
>   	if (dmirror == NULL)
>   		return -ENOMEM;
>   
> -	dmirror->mdevice = container_of(cdev, struct dmirror_device, cdevice);
> +	dmirror->mdevice = container_of(filp->private_data,
> +					struct dmirror_device, miscdevice);
>   	mutex_init(&dmirror->mutex);
>   	xa_init(&dmirror->pt);
>   
>   	ret = mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
> -				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
> +					0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
>   	if (ret) {
>   		kfree(dmirror);
>   		return ret;
> @@ -1216,16 +1221,16 @@ static const struct dev_pagemap_ops dmirror_devmem_ops = {
>   
>   static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>   {
> -	dev_t dev;
>   	int ret;
>   
> -	dev = MKDEV(MAJOR(dmirror_dev), id);
>   	mutex_init(&mdevice->devmem_lock);
>   	spin_lock_init(&mdevice->lock);
>   
> -	cdev_init(&mdevice->cdevice, &dmirror_fops);
> -	mdevice->cdevice.owner = THIS_MODULE;
> -	ret = cdev_add(&mdevice->cdevice, dev, 1);
> +	mdevice->miscdevice.minor = MISC_DYNAMIC_MINOR;
> +	mdevice->miscdevice.name = dmirror_device_names[id];
> +	mdevice->miscdevice.fops = &dmirror_fops;
> +
> +	ret = misc_register(&mdevice->miscdevice);
>   	if (ret)
>   		return ret;
>   
> @@ -1252,7 +1257,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
>   		kfree(mdevice->devmem_chunks);
>   	}
>   
> -	cdev_del(&mdevice->cdevice);
> +	misc_deregister(&mdevice->miscdevice);
>   }
>   
>   static int __init hmm_dmirror_init(void)
> @@ -1260,11 +1265,6 @@ static int __init hmm_dmirror_init(void)
>   	int ret;
>   	int id;
>   
> -	ret = alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
> -				  "HMM_DMIRROR");
> -	if (ret)
> -		goto err_unreg;
> -
>   	for (id = 0; id < DMIRROR_NDEVICES; id++) {
>   		ret = dmirror_device_init(dmirror_devices + id, id);
>   		if (ret)
> @@ -1277,8 +1277,7 @@ static int __init hmm_dmirror_init(void)
>   err_chrdev:
>   	while (--id >= 0)
>   		dmirror_device_remove(dmirror_devices + id);
> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
> -err_unreg:
> +
>   	return ret;
>   }
>   
> @@ -1288,7 +1287,6 @@ static void __exit hmm_dmirror_exit(void)
>   
>   	for (id = 0; id < DMIRROR_NDEVICES; id++)
>   		dmirror_device_remove(dmirror_devices + id);
> -	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
>   }
>   
>   module_init(hmm_dmirror_init);
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> index 0647b525a625..69f5889f8575 100755
> --- a/tools/testing/selftests/vm/test_hmm.sh
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -41,17 +41,11 @@ check_test_requirements()
>   load_driver()
>   {
>   	modprobe $DRIVER > /dev/null 2>&1
> -	if [ $? == 0 ]; then
> -		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
> -		mknod /dev/hmm_dmirror0 c $major 0
> -		mknod /dev/hmm_dmirror1 c $major 1
> -	fi
>   }
>   
>   unload_driver()
>   {
>   	modprobe -r $DRIVER > /dev/null 2>&1
> -	rm -f /dev/hmm_dmirror?
>   }
>   
>   run_smoke()
