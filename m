Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49B574EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbiGNNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiGNNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:20:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AAF5D5B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGRj3LPAyUreq2jOC97xFg7/fBdjqB2xkmxPUXElRmNotxsi39nMXdsu4qeYEYFH7bgiRfU4cjestjdBchqPNhpOi4E9elYCyWUj0+m805DvZ7Yf7enCQXhkJT/FwGvVcgg4tpi5iaMBZDbl4zGDqvoAhaTfgqP5gV5gXlBSn3UjiL/vpYcH5YeAqtere6+db+9Uq282DUg3q0bvHmTnTxtKoT5VB93K/ELbMEcIuPSE2rbvE4NCB39myPIznWUNQHBssG4gmfE88CJDPk+dHHw16f1UNj/jkx0Iyhu01LkwBcoyPbor0Q/b/1vUCamgu/gXSKjf1VAQw8RNGJ7bUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyHUHUYZf/U4A62wbXhtpYi5BrfzMlUQJoQ6NuT9EHE=;
 b=QU41W3qohoMIe+F9BxTKtDgklwauUIFZvoCcdgWy7FUbyrPSjp5o11tY5GtX7UxE8YWQzA6xS/Qjf4X9Gv+Ko0zPf6v74H+VqglOAZM67tCJRaYWiv0Vi4QiC1BBAp2Zphx+MFoHa/zqW/XSyQK+wUjKlhvu7ZWQudyYZ+0zPoSYJTMaVKdt8nuwfh/QjVcXqkUK9wZ0EdylhucahC/atdVsLYbEt8Sgt2fhAaiVJ03SVlSzVSfS2uOmJzKIlBnAspA3ovucFbV3lnuiUasWrcf6sQx9TIjJLTQMw9Ez5taQFNU9W+KNqVlOmzdAj6CgZWG9FryCTMZFNVMx9+x59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyHUHUYZf/U4A62wbXhtpYi5BrfzMlUQJoQ6NuT9EHE=;
 b=Rabjxq0nOeWw7bgkC9PEhFDxN4SO3v9AGJg7+7VIFRVKtUFslw4QPE5wpELV2tQodYtsudALOQ27Lf+oUiCnImE/99mOUfYbEclZwtbH5jZ3eQ9N0LrLoNlrlN2x62wwz3YrmloskTWgVZkS66GD7D2NtSr0pwLJ6jmZiqH5FMDfkAWpsV8gPbpmN5VvzL3oz/OLXDpYNxrfmoE2/lbF26a/jUvj1RO7g0DoF3FePrmETbzQ77Yfto2o0hLdtuhy6Yz9dsqbgM5Yi3AvZzKl+IU1a5Yg5HCUnEPa8l8xbz4y8iPnOxJBc/5vrmMZzrEsnCOINatGc4IMeR/eG6O+WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by HE1PR0802MB2473.eurprd08.prod.outlook.com (2603:10a6:3:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 13:20:19 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 13:20:19 +0000
Message-ID: <123b7518-b0c9-171c-9596-73654691ee58@virtuozzo.com>
Date:   Thu, 14 Jul 2022 16:20:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::11) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d150916-a591-41f0-a17a-08da659b9983
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2473:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcZzE13VGE9mCbj7o3pWcggmhUerhRCA+P3SwlTxD4YotCxyaD4lXS6gQ1tmVK19qCnHZwNakqwOMmTiQff6tlptwXicAsG6k98HO7E/vMri820fIT101B40bgm6YXTeVFzLCy3gr/bORNUD/yi0BiFw/ZVtffggHpl/7bp28sZo2nIEcIUft86bvj96bIz/KnWIsj22atUpertxan1GEmsd776ofHj+1HJVxYsxr+kwO+IhbIf/XvdOxJ3IgW0nMvaMq7KUT7phjyxUzgkrljUbgHBVq6sZU7wMtmjaz2j6d5bpelVyltGJw9W4fRrNwxzmqKCAnYGpoJ6GM/4V+WOLX9rmYB8YRrO6fEWU4oQY50KQXLTSy3EcCLTQATqzuk+VefcZLV3ICxVRI2T9yXMr9fZnx8/VYMuhob6GA/VQdGxIW8WVRpwms8NApuVVeaevGrJwNik0IGP9kKmkh2Z2rZ7gk06SBgfxi4EWLf6ax+IoUGHrECEyo/uYXkTBOLqAZslROGHIjB30vBUQ98T4MuXdTVDmlhiCTE87/aUqTIlg9mo8eee8REDffT+rRWtcbiSncARLdanbaQ7U3pbSagiC3gmPKqI+QdjAz1FyrTFUKEuGbcPdCwueTH6X/z/sg+R48Su+Y/ZcsD0mOwhxRJtt1adNHscfwxP2DqrBwDmeOnxR6uulTjrBRADc0lkqdPHHKJfQHAcJCJ+uzIdftjzVqf2T0P5c/0u1ZrCH+FPCLiMJ9PHUf+8U1NCJ5qkeBrzicB7NEnuUqmjYtfSe6If74bm6aMj8vN78eqB401VCeq6EUDRjxmMfXSMOm7beTc2YBOBJMdVvTg1JMLKgFFJhggbffAhFqdA/oosjd4EBTkqc9R+NptBxkX5k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39850400004)(376002)(366004)(136003)(6506007)(6512007)(52116002)(8936002)(2616005)(53546011)(31686004)(478600001)(6486002)(86362001)(26005)(44832011)(2906002)(5660300002)(41300700001)(31696002)(38100700002)(38350700002)(186003)(83380400001)(36756003)(316002)(66556008)(4326008)(66946007)(8676002)(66476007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjRlYTRMbGRIYnB3bU9nZWRYZXJkODNxVXZyWkRhVTlGQ2lXTXRMWW5zd0Qv?=
 =?utf-8?B?KzJwNWFydlhEK1MyTCt6aFpzTGdiazNEemtIOVNnd2dhWnVQT2Y5RGduOG5T?=
 =?utf-8?B?akVRcUtaQTJXTHcrQTNBY3pCV2pCNkhkVjd1UGdaVGxGNURXKytIQUNpRGR0?=
 =?utf-8?B?dEpUTlNPQnFDSFhXQURrWkhWcnIvOWt1MlRUblF6MW9ZT2NVUklSTVFNd1BP?=
 =?utf-8?B?cGdYN1FicDF6OWV1a296SnZOd0xGQTZscWJVZFE3eGMvaDNxSm5FcmJQNldL?=
 =?utf-8?B?Q0VBVmUyZStCR2Ryb2J4UVBHWUg4UW5GdFZ4UGZqQmpmemRHR1BkNU1RL3NJ?=
 =?utf-8?B?NGIzQ09qaGJ5MTBROXdYTXBuay8zcHUrUGxNamZzbk1XRFEyMy9IaG1mSGJk?=
 =?utf-8?B?bjVsa0ZIY054ajh4T2IrdzNUQldiQ2V4L1FhRUFMSlBjVmF6RDYzVVlBdWtv?=
 =?utf-8?B?cHFka3B1eUdDWEE4YjkyZThxVllZMlN6ZTh0aUtWY2RWQ3B4clZwVXp3ZnY3?=
 =?utf-8?B?eXFVa2dZTmFsSjVJVnVVanNjM2xnbU13d2hHd3dLbjRYQ29YeGFpdXhnai9w?=
 =?utf-8?B?NWF1QjgrclpnOVRlWDZwck93K1VYOVM2akpoWEtPSWoyME80dXRJUGxLaFYv?=
 =?utf-8?B?cHU3T0xBRURlajg5ZTRYMzI1Zzlic0V6MXU1Znl1bllja3NvK25hVkFWY1Ey?=
 =?utf-8?B?NTg3S2hkcEFpOGFqRVk5NGhpd1NjZzVpYy9jT1UxajBSRlFYQ0NEOVA5TDdF?=
 =?utf-8?B?RU1FZ0dtbWF4NTQ1NzZyWDh4aEdZSEQxd3FxazVFRW9qOE9tcHBUakdvaysr?=
 =?utf-8?B?VzRHKzR3cXViU1VQSWVVWlk2VFVzWWxyUFIxTzhtYmhaZUFCcmNGSEFTYUVN?=
 =?utf-8?B?aEExMmtWcmFJM3B1MGlmcGtLc1NPSlR4UkdyVWZwQjdFbWpHVUsweXd2RHlm?=
 =?utf-8?B?MnVaNEJHRCsva1VOejdZVkVvbFJhcjVmRDloVEE3YjNwdnZZRXQ4VG5FNnZl?=
 =?utf-8?B?SW5EYTd1TXhna3RTVVl3MFVRUENHeHZkMVNzMWFMY3A5dy9hY2s2cEFoNmM1?=
 =?utf-8?B?Ums1Nnk4MnlURGJWNm90OHBobmViZDAydk05cCtjcEVZTWlJR0wxdFk0K3c1?=
 =?utf-8?B?ODFLMVFBV2VJaWZmYnBSUXRzRkhZVit2TmN4RWpaTEpndzFsUDNOVjZZMVIx?=
 =?utf-8?B?K3l5aUJzSFhRSXRPYzl2aUROMys2RUpTYXFzckQ5R3IyRitnelFlMmxHNEZU?=
 =?utf-8?B?VHRQWTU5S1JSdjZMdWNxYmZzQXJGUCtjbzNCQnR2QktYSVdUaWtGMmtybWVa?=
 =?utf-8?B?MGYxQ2dVaHpvMXZNNWJCOHprOE9uMFgxVWMxUkh1TG11d05EeGRFU0NEVEJF?=
 =?utf-8?B?OVFZVm9CMmJuSk9icU9ZcmVpYWo5SmFqc2x6aG4vZmNWbTZFMytnOVdkWnJS?=
 =?utf-8?B?V2F5dFU4SVpidlF3aFlSTjdCa0VzR2U1VG9ROFc5b0krQ2JaaEE5MFF5bndq?=
 =?utf-8?B?V0Frd1pibC9rQTZoNDc5Vys2M25kMWdWd3cyREpMakU3anNJUFh6V1d5dEVM?=
 =?utf-8?B?ZTZpVUZsRERURUI2Wlh6Z01TQ1JvaGxpUTJvVlRERVhHYWR0UDdmcFZCQ1JH?=
 =?utf-8?B?M0xpcGd5S3pEdFptaHRVNU9haWk3QTJaSzFoenZGSUVTY0dTdGlGUEplV3hE?=
 =?utf-8?B?R1BoWjBUTk5Jc3dZUjRrNGZvcmRkRGhkNVBIbGNqeHNJMmovd0pZZFdnc1VI?=
 =?utf-8?B?VXpoVTNsdzlTKzJHNnVaRjJmVTJKVWtWY2xxTmphcHNzVURmQXFMUk9MTVN5?=
 =?utf-8?B?NDJnUXdkeXVPNXNITzJuaDIvRjh4YjNyYy8waVM0dTdmWjI2ZlpNYW9DS2to?=
 =?utf-8?B?dzZlTnRaakIyc1FDd3A1YnRydkdIeU5VQWRwWEZKTkM2MDFZMHBXdFhwM3Nm?=
 =?utf-8?B?eUFxZ1Fhd01iNzJMYk50eU15RWpsSWIxNlpYKzJrQ1AwSGJ3OGRGYVkvenh3?=
 =?utf-8?B?aEprYWxIT2lxZHVHSXlWSlZVUVZjdENpSnQ0bG4vOXBMUFU4VS9Udzd3dmdk?=
 =?utf-8?B?eEwwOTVCMno1emVVaEM0ZFVyNGJLVWg2aG41U3F1ckIwQUxpY2tDaitEV1JN?=
 =?utf-8?B?R0xBempDSzNERE9qbm1jemI0eW4vUXBZbWI5R2JXOCtiQnYyOWFaakZWMWFw?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d150916-a591-41f0-a17a-08da659b9983
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 13:20:19.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19A6SipV4JJAT6L3AJT9pVuW53/Lz5xJTWJDDQkIE8oyUi/h1pOag8soGVY24Eik4+60fwYDqQJMJ13q0bZ9RMXtrlkZsVUIgbBS1GN2PK4/nJvrkuJ1BxUsWksgHjJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 14/07/2022 14:35, David Hildenbrand wrote:
> On 05.07.22 10:36, Alexander Atanasov wrote:
>> Allow the guest to know how much it is ballooned by the host.
>> It is useful when debugging out of memory conditions.
>>
>> When host gets back memory from the guest it is accounted
>> as used memory in the guest but the guest have no way to know
>> how much it is actually ballooned.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>>   drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>>   include/uapi/linux/virtio_balloon.h |  1 +
>>   2 files changed, 78 insertions(+)
>>
>> V2:
>>   - fixed coding style
>>   - removed pretty print
>> V3:
>>   - removed dublicate of features
>>   - comment about balooned_pages more clear
>>   - convert host pages to balloon pages
>> V4:
>>   - added a define for BALLOON_PAGE_SIZE to make things clear
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index b9737da6c4dd..dc4ad584b947 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/virtio_balloon.h>
>>   #include <linux/swap.h>
>>   #include <linux/workqueue.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>> @@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
>>   	}
>>   }
>>   
>> +/*
>> + * DEBUGFS Interface
>> + */
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
>> +/**
>> + * virtio_balloon_debug_show - shows statistics of balloon operations.
>> + * @f: pointer to the &struct seq_file.
>> + * @offset: ignored.
>> + *
>> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
>> + *
>> + * Return: zero on success or an error code.
>> + */
>> +
>> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>> +{
>> +	struct virtio_balloon *b = f->private;
>> +	u32 num_pages;
>> +	struct sysinfo i;
>> +
>> +	si_meminfo(&i);
>> +
>> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
>> +
>> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
>> +			&num_pages);
>> +	/*
>> +	 * Pages allocated by host from the guest memory.
>> +	 * Host inflates the balloon to get more memory.
>> +	 * Guest needs to deflate the balloon to get more memory.
>> +	 */
> Please drop that comment. This is basic virtio-balloon operation that
> must not be explained at this point.

Ok

>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>> +
>> +	/* Total Memory for the guest from host */
>> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
>> +			guest_to_balloon_pages(i.totalram));
> totalram is calculated from totalram_pages().
>
> When we inflate/deflate, we adjust totalram as well via
> adjust_managed_page_count().

That is true only when not using DEFLATE_ON_OOM.

Otherwise inflated memory is accounted as used and total ram stays the same.
> Consequently, this doesn't calculate what you actually want?
> Total memory would be totalram+inflated, current would be totalram.

My calculations are correct for the case deflate_on_oom is enabled.

> But, TBH, only export num_pages. User space can just lookup the other
> information (totalram) via /proc/meminfo.

I have missed that the memory accounting is made differently depending 
on a flag.

Since the calculations are different i'd prefer to have the values 
calculate and printed there.

Where no matter what the flags is:

  - ballooned_pages     -> how much is balloon inflated
  - total_pages             -> total ram the guest can get
  - current_pages         -> current ram the guest have

Patch to unify both cases with or without deflate on oom coming next.

-- 

Regards,
Alexander Atanasov

