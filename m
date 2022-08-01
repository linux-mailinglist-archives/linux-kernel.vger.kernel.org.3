Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A29586E97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiHAQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiHAQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:34:43 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00113.outbound.protection.outlook.com [40.107.0.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3F3DF02
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGrOeLBOnMBZD6QiwPJSjJtna2LmxOJ668uPvCxILOT6rv3gxbyHvEvQfh2IoSiKs1wPf3iVClKpJ59++85TkhwJ/cJQMS3ozMFySrRl5XEOwa9jFx1jomSzWGvuVInm1Nrl9sZBpu8FrcbaquLT2DhQDsaQAC8rROScMeUBl/MXnxgII0JVvzshFJqglSZDtNnvllRNLVfokKG4pw9Y7TEAcPLUdgXlv2kfK66UDPImknKvRw6qgTZoVHxVa+ixB0TE4Xfj8E/iTKL/mO8/28gJ/GVrpmvO/xe1ilTo3ZywrMH/mTVVfDDUFOOKhbM/GraJ6UunTlvQahZxLbDKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyB3vd1N/O1CquFTY6hOkRNyMSTGQJTh6MET7EwJtGo=;
 b=dZrOASn4jDcqp30zlk4H4PlZVarSG6Dgk1cnytYwz3EE+pcc3KcWEkAFjEIHhSSlWarUBp2gODfpjOIwJNORt2mCGCyaZMBJlbEacey5Q1bfGKrFbZsgw2Ct7NYajcqK2xUEDFtcAo4xDM8ijjCUhDF48/m/9i4EAThowy94c+12jiyH4uUF90+yg0A9zb4OmT6kuvlxKhKhMASog100kc/epWiMwMNSlXGpQqCOIuHOw8SDwy147Gz57aIljzKrJ3wHdLnHGWMszDwSwQaXTYLb5RXPMFotohtW242e8A9DotUJmZcUWgOhO5wi6ymdc6Jyya1FJre1/CIrB+hePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyB3vd1N/O1CquFTY6hOkRNyMSTGQJTh6MET7EwJtGo=;
 b=uCqfIGTIzSIb1hcwwo1peB/J8r1gLeB63PI1NBuJvCVttoVpzHr7sMxqCMra931rSHkFUb0etGAuy7iEHYXDrifQTowzn84jyL9jonvZvI8h8xq2XfrGfwPb3DpjtA/VX2k/jrhgz7TcT/6gW78ufkCMtMUjOYi2CtEwP72G+RymKFl53wQ3AJi/YRwsTO3ba5VpAFePT/9f2VeOotdSnc1nSf/RVR5ROhKobKNIbd80/23gYaMbvn9WTB8awgs8zij92SE2vptAmJP/t6OJsCDJFTM3DYoQqCo9oOWM2STxj3BaOiU4S3gbp8dHunY36UnqML+YBgfUVTXca4toQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AM6PR08MB5128.eurprd08.prod.outlook.com (2603:10a6:20b:e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 16:34:38 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 16:34:38 +0000
Message-ID: <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
Date:   Mon, 1 Aug 2022 19:34:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::19) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eba273d-f899-49f9-2ec2-08da73dbba19
X-MS-TrafficTypeDiagnostic: AM6PR08MB5128:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mmpeNWh6y1zsR6CC6nynJx6rnwE2QAb3d/KUoWgjsKbP6OqAQF7q7QHJlGz8QXcz1f4QYlChSY2bZa74Y84PQ2tjjDgaJOY3ru0cI/2Dsx9g9CSuBvLMiZ9RZRJjEF179T1q6R48n1CnO7LiE0x8Vo82xUB2ohQ+g73ipFjkO7A4zp6YwUOh7H4RT9SZo4bEbR6UqTNKXtiBMajBtNMGUbzIfx3Lo+1Lt5kYLwzG5McymkTuYnRtAtIXC3D6O2HBrcfj4TVEUZbVrliexZe2JywEMC5sw2ukMXIZ0Fae+dKyNfYvaRWbk27tKGdJPms+SgsqblpWKJPDytGC3Hf/PDongKLePKhd9svXHor42yqzYyAi5EOssKINuWEFchkNHq5MSPmU3ufPnY26ZgxLvjGuUcACBgfN0u5DZTCIGRLOSlBBpEnjr7pLz0PVPH+LRYWth26O9qm2Dq0l/+1Ka5GNz+k0/5E7fpgCN3OEn4GrJLK1xt5uvaL6NpaH0hv/ThekMaIoojUIAuQk7FaRu8tTwr/AYaVGZHLBVrIa6V+uELHvKZNVjqApzJwC7qZH0A/Gh7A4azVpLG7nb1FJ/q/9MNUiMNqI7DKfEex5WJm2Jwh/boysUDoH3Lroh4jFp62DHpW307qpRn2twP9PI9A4Ygp9SVy+svCODhpoxwJZ42rJpTyCyfx1c0lqIi0Rg3vcSAAtXalgELRLTlPMtQDIrRJUkA2mefLiYHl2rk4GO11QWdlx4/5QuabdCcNTsbcoJA7nrKgOD6V1JiWKWfahnSJgPtS2VURiSikaBXkZLGLAOUuNSI93PHYXrOQ1oFKz65l926aKE/cLmSYN4SjlN+jmk458LcAZP5jeyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(376002)(396003)(39850400004)(66476007)(31686004)(4326008)(66946007)(44832011)(66556008)(5660300002)(36756003)(41300700001)(316002)(110136005)(8676002)(478600001)(8936002)(6486002)(2906002)(6512007)(2616005)(26005)(186003)(6506007)(53546011)(52116002)(83380400001)(31696002)(38100700002)(38350700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU93bjlKcjFveTJvNWc0aXJldHdKTjJqYjFDV0ZPNEpSamlabk44S00zNFV0?=
 =?utf-8?B?SHBLcVRpalVscDJmeXIzNTBFbmxGZ0lLZWRwQ3NZUnZkRHlHSzhHYWY2bkZo?=
 =?utf-8?B?UzR0QUwyY2dCTStIdVRQYUYzQW9ZVEludVFvY1BtZkdpZXAzUE05dTZNR3VF?=
 =?utf-8?B?UTdjTEFsS3hPeTJkNnFaK2w2dWRSUjlKVDJUK0pUZHFJV0MvRG1xV0EyVTNr?=
 =?utf-8?B?KzhGL2tpZWxhSUZFcUI1QkRVZjhycFdkYmpJNk5CckthZ2M2RllRQWpxRmp2?=
 =?utf-8?B?eVZqQXYxSVhoS3UxV1BoTnRTZ3M2VVZQb0g2b04vdEVFekpaMDcxaFEyRlVt?=
 =?utf-8?B?RlhCSDNuQVAvays1VDdRaXBsRndIOUhvOGVMR3QrbEpqVm8yVTBYeUQ5dWZI?=
 =?utf-8?B?MlpYZEZ3OENxWHB2ZU0xK01JZGhobU5oMi9CNEFKd1dmWUd1dSttUWd2d0Zt?=
 =?utf-8?B?UmdNcXUwZmJhNGlQYVFOc1dPaHR2U0hTbThrUlRJUk1yYnVQV3Z5NVJkSnJZ?=
 =?utf-8?B?cHZXK0RsSjAxeDVHRGZTaEhnTkcrMmV5OVgzU2d1NCt6alpvYkhhN1F5bDFP?=
 =?utf-8?B?aGZzTG0yQUZGOGtuNjRPNHI1N2xTaHgyWWpES0VwWEVFSHdZeDRIK3lGVGpk?=
 =?utf-8?B?WDN1QnV2QURkbkFVOU9KdVNoVW40Z1l3M0hsV3FYQy94a0NPcVNaeGw5S3Na?=
 =?utf-8?B?ZFRUeWVwSHhlSUxnbWRJR3BVNFpIQnZNUTkxM05hUDFoU2RmTklqNHdGdTl0?=
 =?utf-8?B?NXowMVJBUEliQU5Gc3Y0cWdOTm1aWTAvT3pNRzZUa3BKaXJacXNpeWsrbHd1?=
 =?utf-8?B?V2xtK3lMS284YjJrVDVRME1SRWlvQ1BpK2xPVWNRTmtoQmdZSkpEUzZnWjNj?=
 =?utf-8?B?MmRiZlJpdHpiTGpmK2JIY3hhRmxGQUd4OWVZNUZIbTd4VkxmUW1lblh4TXAr?=
 =?utf-8?B?OVc2QU9TVGRSOGQ1MzNPQko5ZDkzM2VIYkZoMU9uMW5mODZxMTBJeFFTb3JZ?=
 =?utf-8?B?U1VEbS9mcEV5ODRKZmZHUWRLMEJFYWtTNlNXMXBLYkc2RnZ1bzFyQnBQNVAy?=
 =?utf-8?B?aTlwbnI3djQ5NmJLcmVGekNla0Q2cW1MQ1Y3RGpOTUpDcitpQzV0d01lRVZM?=
 =?utf-8?B?L29RSkVZUFFxdUo5TjFWNTZFRkVXOFRhdW9ZOXI4MEN5RDllSzhBSnVDK1Zi?=
 =?utf-8?B?OWJ4TWN1QkloUFhWMXJuUVRnSjZkbDVoUG03RkMxbnpQbytlWXhUQkRkUWQ5?=
 =?utf-8?B?Y2RCZURLdUw3M1BVUFpRUWFQTzR2ek5aR1BPSzcxOHgyU2oxSWFiMlpCVCtC?=
 =?utf-8?B?NWtGbFBPTFg5VDlabklvZTQ3ZTUwTzlDOFRqZFhUZnUxR3daVWNLZmZwOE9l?=
 =?utf-8?B?ZHVCY3FPRnVKOHZlcTZSOXVjajhGWi9qV3BLVHA4WHcvL1BGQVpVa09DTk9U?=
 =?utf-8?B?bTlpbGY2YkNzbjA1QndXQThUcmJtZUJadHJyMzVhYTNKdWc3eG5GVjY2T1Mw?=
 =?utf-8?B?bDdwVHV6R2tmNWJnOXl6b1FQU2xBU1NOVFBiVWg1Q3pudjZ3RmswNEI2cFQv?=
 =?utf-8?B?MlhxMDhHbjRkL0xxcm85c0FoL05uTENoYjhyT1dOQS93M3ZIUTFvYzdyVnNj?=
 =?utf-8?B?YVd0YThGL3JEbFVhR1F5SHFmbGFVdTg1Y09XNFNvbm9jR2dVMCtVUlRIWmZX?=
 =?utf-8?B?WTN1b2dZbmZFNUUxSU10SWRXUDhlZVNXY1BuTTJjdzFnTmVCQWthZTdINHk0?=
 =?utf-8?B?TlIrYS9maUIvWXN5dlpuWncya2MySnZyZDhiVXN3VFp1OHVVMTc0d3VOWGZF?=
 =?utf-8?B?SEJ0bEM1VFRQeDJid0xuaW8rLzVGL21pMkVNdEk3TnM3K3l1ejBMMk52U0hD?=
 =?utf-8?B?M0JBc3ZucW1aV3pON1JES3JCZ1BRWVM0K3Z0NGYvMklBVmtrdFZrbk84d2s0?=
 =?utf-8?B?RFFociswbHdJL1JCbUpLOUY4QUdiWXEyUWpFdW51K1hmOE9KeGVYSW9mQnF0?=
 =?utf-8?B?MzJLYUJUai84bnVDYTRoa3JpYWVMUWtrakN6NkY0NjhIT3NTUkhERmJHcWpX?=
 =?utf-8?B?UnR1OUFmZ01Uc00rM3Z4VFBwd2dvanIzRTlUNkdyVE40WnRUVXphRkt6Uk90?=
 =?utf-8?B?bmx6OGVEaDlQcXIyWVp2VlFvWFdSMHlBQzB3amdwVno4cVdhY0swVk1oakxu?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eba273d-f899-49f9-2ec2-08da73dbba19
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 16:34:38.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gjaW8fFHJayiE7iVghQpmeU+7oCtk5GxEtTuqaivMRgOgxmjvQAFXk+22+BFn+/rmsZkM41W9kWSc6HlUwq3yqbEaIoRmRxZtxRuai0YDShOyo9KtD+igziMJH4DmoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/08/2022 18:18, David Hildenbrand wrote:
> On 26.07.22 16:08, Alexander Atanasov wrote:
>> Allow the guest to know how much it is ballooned by the host
>> and how that memory is accounted.
>>
>> It is useful when debugging out of memory conditions,
>> as well for userspace processes that monitor the memory pressure
>> and for nested virtualization.
>>
>> Depending on the deflate on oom flag memory is accounted in two ways.
>> If the flag is set the inflated pages are accounted as used memory.
>> If the flag is not set the inflated pages are substracted from totalram.
>> To make clear how are inflated pages accounted sign prefix the value.
>> Where negative means substracted from totalram and positive means
>> they are accounted as used.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> V2:
>>    - fixed coding style
>>    - removed pretty print
>> V3:
>>    - removed dublicate of features
>>    - comment about balooned_pages more clear
>>    - convert host pages to balloon pages
>> V4:
>>    - added a define for BALLOON_PAGE_SIZE to make things clear
>> V5:
>>    - Made the calculatons work properly for both ways of memory accounting
>>      with or without deflate_on_oom
>>    - dropped comment
>> V6:
>>    - reduced the file to minimum
>>    - unify accounting
>>
>> I didn't understand if you agree to change the accounting to be the same
>> so following part 2 is about it.
>>
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index f4c34a2a6b8e..97d3b29cb9f1 100644
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
>> @@ -731,6 +732,59 @@ static void report_free_page_func(struct work_struct *work)
>>   	}
>>   }
>>   
>> +/*
>> + * DEBUGFS Interface
>> + */
>> +#ifdef CONFIG_DEBUG_FS
>> +
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
> Superfluous empty line. Personally, I'd just get rid of this
> (comparatively obvious) documentation completely.
Ok.
>
>> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>> +{
>> +	struct virtio_balloon *vb = f->private;
>> +	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
> Rather call this "inflated_kb" then, it's no longer "pages".
Ok.
>
>> +
>> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>> +		num_pages = -num_pages;
> With VIRTIO_BALLOON_F_DEFLATE_ON_OOM this will now always report "0".
>
> which would be the same as "num_pages = 0;" and would deserve a comment
> explaining why we don't indicate that as "inflated: ".
>
> Thanks.

Except if "now"  refers to some commit that i am missing it does not report 0.


with qemu-system-x86_64  -enable-kvm -device virtio-balloon,id=balloon0,deflate-on-oom=on,notify_on_empty=on,page-per-vq=on -m 3G ....

/ # cat /sys/kernel/debug/virtio-balloon
inflated: 0 kB
/ # QEMU 4.2.1 monitor - type 'help' for more information
(qemu) balloon 1024
(qemu)

/ # cat /sys/kernel/debug/virtio-balloon
inflated: 2097152 kB
/ #

with qemu-system-x86_64  -enable-kvm -device 
virtio-balloon,id=balloon0,deflate-on-oom=off,notify_on_empty=on,page-per-vq=on 
-m 3G ...

/ # cat /sys/kernel/debug/virtio-balloon
inflated: 0 kB
/ # QEMU 4.2.1 monitor - type 'help' for more information
(qemu) balloon 1024
(qemu)
/ # cat /sys/kernel/debug/virtio-balloon
inflated: -2097152 kB

To join the threads:

>> Always account inflated memory as used for both cases - with and
>> without deflate on oom. Do not change total ram which can confuse
>> userspace and users.

> Sorry, but NAK.

Ok.

> This would affect existing users / user space / balloon stats. For example
> HV just recently switch to properly using adjust_managed_page_count()


I am wondering what's the rationale behind this i have never seen such users
that expect it to work like this. Do you have any pointers to such users, so
i can understood why they do so ?

-- 

Regards,
Alexander Atanasov

