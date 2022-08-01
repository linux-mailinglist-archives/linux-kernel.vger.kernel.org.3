Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB91586552
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiHAGrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiHAGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:47:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDD18B21;
        Sun, 31 Jul 2022 23:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmDdMLzZXBMSQK0sq7jEfQ3Hq+m4o4eqmx5szS8kUjSCC3Sez+zO9hWqIXujfAJktybJ6SrhkYJTTYtgutSHIUvx36f0dehEdDLaP+nPn26zTHYImCrmdUWZyTPLO4k7HD8ar1yJZoCPQFNnUQrV73S5dOqlFpSQFe5VnZiPA72aeaqHMH/HhiaeAO5Pna1TXETb3naSz2qwEo4LsD/9ubGGghaidrWHbVziBNY/habQPDSCjVk9gO2XaNm9a6Cx348Z1KuS31AOFIyF7joQSFN5tNat2UDHHe30pySWd3OWEcn51ciROiKOxTEciooHiH6tpEy/a4jDjqA2QqONew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZfkvdBpoXl1iNwECxLPeEfsT4eiXtD85FIHry6cmgc=;
 b=CymbbdLWFelxPO/G209AiuLbac3B1M9gixLj5UxpeFnwfBtaFqlMNHltebUc06qGv66PJ+/W2dzWDdrCIps+xfRxjkKCrJiei1fGDW/uqgr+mIijX2WMePid9qE69I13V6iq+AJHr3AcqkNTPRC3ZtiOxcLVxMuv1rfDtb/lEx09eWtCklExjlrU2Qmk9l53Wkr/nuM1gwlFYYzX05fUpUZNzsOid1eiQgfBJbgmFLpIPAZtjJ5SksQi3nafZNAEQcWaA96rV2DAADRLh9AfpDINjizOmwFYm39eJibNi7bS/AWxNbasqJm1oaHguvpIzzQTp5IUHBizMrF/7Lm8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZfkvdBpoXl1iNwECxLPeEfsT4eiXtD85FIHry6cmgc=;
 b=ldvnCkg/7Ipbj2GCJOwQqhZqIjjUxluglXmAQGDdu3On7NU5Kx2nTl//fXGkRADcdp7azb2q33siM84h19eJHDrqTi8k/ZP3wfu2S/GNmxoBb7apbk0OLeCnVusxaxj9UWqwP8IEcKf2pNwnHgdd0xVOBhbz6jMh66a9G3Gp7C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH2PR03MB5270.namprd03.prod.outlook.com (2603:10b6:610:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 06:44:34 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::c832:eea0:1883:a19c]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::c832:eea0:1883:a19c%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 06:44:34 +0000
Message-ID: <ec08ac1d-dc03-097e-dcb4-0ea0e86c612c@synaptics.com>
Date:   Mon, 1 Aug 2022 14:44:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] [Draft]: media: videobuf2-dma-heap: add a vendor defined
 memory runtine
Content-Language: en-US
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, ayaka@soulik.info
References: <20220731202116.820516-1-ayaka@soulik.info>
 <CAAFQd5C95W-2=oLTmbgQCBoYq1Ef3hKgpmk=ij4+nFPY3XVWPg@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5C95W-2=oLTmbgQCBoYq1Ef3hKgpmk=ij4+nFPY3XVWPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da9ae0ac-9a71-47b1-5576-08da73894b6a
X-MS-TrafficTypeDiagnostic: CH2PR03MB5270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6FTDbBFUxbf+rviJozhVQNEf0BA8Rjnz1EDxECktR9+gmS/AMY3dOrfLPYu22yG1UhGxM6ysZRnP7NgPeebOvqG8F+fSFu9DGuGnE4zeHr1HJRZHz2Ka+7MMHJO6nHGi80ViUuExf9CuNUJKDx6klIDKlEG4ffZehmmI/GWk7gCtoKdI4G4qeaJ7Iq3GI3Y2LdVlmlqk6BK7C+y/5Pvnnd1sO7nP0wCyNMt5Vd7G4xkIsWDLqp3984ywHsJUib1zupRJlMCCPDnNnM5++eowyX6ELzn/UwtNNGm0/pA+iFtov6WfclWuRxHGvBpWAxTIz2aoSMnMLs/+6yq+UYgPTw2dekKT2BxwShJfgSE32cJ0+51tMQZjCI9si6T8HBcT9lbkXfLwT4qU81DbM/Mk3RwLw9GhzxSOEiGuACK+wZQm4YoLZI5Fy+u90qta/uljrH4Kg6k3hAyMUWHeNfDQRJU9MybnWG60KmdwLORWqHjf8hwLm5t2jcoR09p6uTHyVIGXKjUVQYcgJYVkrYdtAJahBFTfBVBkPbqmH4Hyngm/QFG3jCpk+wj03WGLQuTBAUmW5nNKrXXKIE3wr9Gb4WMSK/GltfyoXokJvJHuRjPK8mw8HxS5cVxZ7pgNC7U11SyF6r2BQjC80ZONfL3lDEKl6sQiWoNlvXymImCAQHLE4CP0ZLcb5zJvsV7R+5xnP00O5ukrXRfPwwb/YU6NAWV7TIaal33tOaomhroytXt6STpuH/YRmuJCAbYwYwY8m5uk+Fb1oIwqFc/jLGZbC0Pf/zRyeaB/h7d2t5LTq31t2T4krA7F82u65s+0xhTwJAfMXJzyyi/AnZxIfOuM6/FzUxJaR+69Dp3vslHleY7n4yQ4c3+KGQPjINYNnFo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(396003)(346002)(136003)(376002)(366004)(6666004)(6506007)(38350700002)(83380400001)(26005)(2616005)(6512007)(52116002)(186003)(53546011)(41300700001)(38100700002)(31696002)(30864003)(5660300002)(2906002)(8936002)(36756003)(8676002)(478600001)(86362001)(6486002)(66946007)(4326008)(31686004)(66556008)(66476007)(316002)(6916009)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytuZEI0MDFhS1lOZGVTMUE2cHBBYVRLSzRBSlNhMkgzQmMrSnhIK3E5WUxw?=
 =?utf-8?B?MUFqSXp6djdVZk1ZQXRrQi9hWFBFM09UY2JpemllZk5MWmsxa1VORW8yMktx?=
 =?utf-8?B?T1VmcEV2K3pNVTlqbjh2MEFLbU1HVlRzblJJajd3ZjNOTkpjWE5Pb040MjRO?=
 =?utf-8?B?WnlrRWhjS1pBQXJJdjZDWGU0d0JQQlpJNytKSzRZVjJ4akw4b3FCbGs4M1o4?=
 =?utf-8?B?RmZNMnZzSlR5VHZId2ppcERkbk15WUx0akEycWxrVFVrdXZlK0x3UGhjMEFL?=
 =?utf-8?B?WjFUZU56bDl2U2Q1MWRhQ1FTZHRFcWJnSURwYkxqVmluYTBSbFg4WHdxZGxh?=
 =?utf-8?B?b3FrZCtyYk04OUJydjBpZjZ3U3p2bU9PS1gwWmpWRnlwNVl0dnZBbW1EdXhV?=
 =?utf-8?B?VmttR1NVSmo4czFjZFAyNVd5SlFoQThvekpBTzVybGhMcldKa042cm9KcG80?=
 =?utf-8?B?czZuMVEvS1RYWDZtaitzSXBGb2hEbjVZOEUyTFdSQlZDQlBDQk9IQzdLY0xn?=
 =?utf-8?B?K0ZJMWJUYUdodUxIcDVzcjc4eklkNFFhNEFnR1VkZUpXSlZvM2ozZlFoc3d1?=
 =?utf-8?B?WDhlRlpjMGdndDVsaUlMRFpxb1RSdEc4amoxRlJQRCs3U3laMzZtNVB3cVNK?=
 =?utf-8?B?L2dzMitZVzFZWjJoOWZoaWN1TUpHb2N5L0RDZHhmTmFmeU9EZXRpTTNTUXdn?=
 =?utf-8?B?MlFKbHdMenQzTGtRbnA5SE1MWmpEbDNXSDNsaUV3NUZhSHNURk5IbkI2UGV0?=
 =?utf-8?B?ZHdJNG1kNlk5NG91UTgrcWdvUmFZRTl4NEZ0alppeXFJRXV4TlZjclRiemtS?=
 =?utf-8?B?RFVJZFNkWnZHekw2dUlxTnMraUNaUUJoY2JOOXJPZk04UGV4WUZMVWlxNTZV?=
 =?utf-8?B?eDd0eUIxVGNkdVlzMjlDcGtlWXlUUm1YSWJNOVNtQ1A1YnZGMlF6LzA1TWph?=
 =?utf-8?B?dGJhb05VanNRRGwxdnppRFJsZXVBcHB3VVJpR3hLTWFURU1aWUZsRUYzMnNX?=
 =?utf-8?B?aEtGODRhZ1cybStKakptMGFFd0VjT2Z6bjJYWWQweHU2VVJ0UGRzK1BFc0Z2?=
 =?utf-8?B?aTRMcFdEY1lVUUNMbkxCMGdlQ2QrVmZuOVFzMlUwZWdtSDhmSHVOTHdsVE5L?=
 =?utf-8?B?ZTBhRDNranEzU2NGK3FHd01FSWFzUS9MNy9Pc3pXM2VKRXdBVkJhaFJWOU5V?=
 =?utf-8?B?dkljRDRkR2RHbmVXQnlYanFLZ1lGcldiR1NmdkswNmNxNGVmR3hnQXU5YWpP?=
 =?utf-8?B?WXdTMDh5S21icnJsakhtZWFlZHNpUXAyalpweFY2T0FYekQrV1RQUkdyWk5F?=
 =?utf-8?B?bzY4YXUxR2QxRElqQ2h4WkE5Smc1dXIwOWFwdjBkb0dJNTUvYzk4RVB3QU9z?=
 =?utf-8?B?eHBxY3hiN3Blb2ZyaWZNMnE2MXZJMW5KcGhyYXFTc2xlOEw0ekJISUg4Ty9j?=
 =?utf-8?B?cnFleUtTdHhLdmIzeDVGVUV1VGJhQllQVmlFTnZSQ1o3dDZzaTlTWk5yRkc1?=
 =?utf-8?B?Tjh0c0pMTE5RMmZPOXowWXZKL2JOMUczR1Y1NjBKNURucGVDblE4Qis5RE9F?=
 =?utf-8?B?c1FxU1dDR2ZSODNmTzlTUVpWb2NLSW9Ldm9tVURNMUU4MzBkV0htS1hRTit3?=
 =?utf-8?B?bC8xa0Y0eEtYQVdCMlNlWmtEK2JsR2pGY09XSGFmaXd3ZlZRUVJoL3FvU3h2?=
 =?utf-8?B?ZzIrWGZYNDYwYTVFNU9hemlKYVZFOVlqV2lLejlFL0RSa2ZVK2xnZHdEZlVJ?=
 =?utf-8?B?S1dXT0RPanBienBDMWhTb2p1bTl6eVRpY3lYQysvNUg2Z3luaEUxZTB0TVZD?=
 =?utf-8?B?Zm9lbjZrOUIxSmpQLzNheWU0ZHIwOVBHeHBrdXVKWGV6MGR6Y0l0SFZqaGls?=
 =?utf-8?B?RWl5Y0V3S3BnWGRRYWwrbGkxVUlGeC9rU1oxK1daVWQ5SUhZckxpc3dyTTZC?=
 =?utf-8?B?bVFqQjhoOEhTaVpBMTlPdDZoRU94bS9SaFVZNE1GYkIxOUpHNU1lYTVpSjc1?=
 =?utf-8?B?RFlhblNDd3p1OVpoNlFNR042MFRvdkE3TWRVdmlBME9nTEg1Q0k0d3RKZXU5?=
 =?utf-8?B?ei8rWDhMc1p1c3g5YWdwandlemtqUkdSQStjMWhmK3dZV2pIOC92cm9EMmZM?=
 =?utf-8?Q?4MbU2AvOqrP2FUR5x2xBAxOmu?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9ae0ac-9a71-47b1-5576-08da73894b6a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 06:44:34.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAol67kiXBHslNhZUAKl/T20Z0YXTKrMOuZ2OXEXbSU9qQeygf8l4p7szP/0rZS6LKgU6NGlWQJHpSTJUDAdng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5270
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/22 14:19, Tomasz Figa wrote:
> 
Hello Tomasz
> 
> ?Hi Randy,
> 
> On Mon, Aug 1, 2022 at 5:21 AM <ayaka@soulik.info> wrote:
>>
>> From: Randy Li <ayaka@soulik.info>
>>
>> This module is still at a early stage, I wrote this for showing what
>> APIs we need here.
>>
>> Let me explain why we need such a module here.
>> If you won't allocate buffers from a V4L2 M2M device, this module
>> may not be very useful. I am sure the most of users won't know a
>> device would require them allocate buffers from a DMA-Heap then
>> import those buffers into a V4L2's queue.
>>
>> Then the question goes back to why DMA-Heap. From the Android's
>> description, we know it is about the copyright's DRM.
>> When we allocate a buffer in a DMA-Heap, it may register that buffer
>> in the trusted execution environment so the firmware which is running
>> or could only be acccesed from there could use that buffer later.
>>
>> The answer above leads to another thing which is not done in this
>> version, the DMA mapping. Although in some platforms, a DMA-Heap
>> responses a IOMMU device as well. For the genernal purpose, we would
>> be better assuming the device mapping should be done for each device
>> itself. The problem here we only know alloc_devs in those DMAbuf
>> methods, which are DMA-heaps in my design, the device from the queue
>> is not enough, a plane may requests another IOMMU device or table
>> for mapping.
>>
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>>   drivers/media/common/videobuf2/Kconfig        |   6 +
>>   drivers/media/common/videobuf2/Makefile       |   1 +
>>   .../common/videobuf2/videobuf2-dma-heap.c     | 350 ++++++++++++++++++
>>   include/media/videobuf2-dma-heap.h            |  30 ++
>>   4 files changed, 387 insertions(+)
>>   create mode 100644 drivers/media/common/videobuf2/videobuf2-dma-heap.c
>>   create mode 100644 include/media/videobuf2-dma-heap.h
>>
> 
> First of all, thanks for the series.
> 
> Possibly a stupid question, but why not just allocate the DMA-bufs
> directly from the DMA-buf heap device in the userspace and just import
> the buffers to the V4L2 device using V4L2_MEMORY_DMABUF?
Sometimes the allocation policy could be very complex, let's suppose a 
multiple planes pixel format enabling with frame buffer compression.
Its luma, chroma data could be allocated from a pool which is delegated 
for large buffers while its metadata would come from a pool which many 
users could take some few slices from it(likes system pool).

Then when we have a new users knowing nothing about this platform, if we 
just configure the alloc_devs in each queues well. The user won't need 
to know those complex rules.

The real situation could be more complex, Samsung MFC's left and right 
banks could be regarded as two pools, many devices would benefit from 
this either from the allocation times or the security buffers policy.

In our design, when we need to do some security decoding(DRM video), 
codecs2 would allocate buffers from the pool delegated for that. While 
the non-DRM video, users could not care about this.
> 
> Best regards,
> Tomasz
> 
>> diff --git a/drivers/media/common/videobuf2/Kconfig b/drivers/media/common/videobuf2/Kconfig
>> index d2223a12c95f..02235077f07e 100644
>> --- a/drivers/media/common/videobuf2/Kconfig
>> +++ b/drivers/media/common/videobuf2/Kconfig
>> @@ -30,3 +30,9 @@ config VIDEOBUF2_DMA_SG
>>   config VIDEOBUF2_DVB
>>          tristate
>>          select VIDEOBUF2_CORE
>> +
>> +config VIDEOBUF2_DMA_HEAP
>> +       tristate
>> +       select VIDEOBUF2_CORE
>> +       select VIDEOBUF2_MEMOPS
>> +       select DMABUF_HEAPS
>> diff --git a/drivers/media/common/videobuf2/Makefile b/drivers/media/common/videobuf2/Makefile
>> index a6fe3f304685..7fe65f93117f 100644
>> --- a/drivers/media/common/videobuf2/Makefile
>> +++ b/drivers/media/common/videobuf2/Makefile
>> @@ -10,6 +10,7 @@ endif
>>   # (e. g. LC_ALL=C sort Makefile)
>>   obj-$(CONFIG_VIDEOBUF2_CORE) += videobuf2-common.o
>>   obj-$(CONFIG_VIDEOBUF2_DMA_CONTIG) += videobuf2-dma-contig.o
>> +obj-$(CONFIG_VIDEOBUF2_DMA_HEAP) += videobuf2-dma-heap.o
>>   obj-$(CONFIG_VIDEOBUF2_DMA_SG) += videobuf2-dma-sg.o
>>   obj-$(CONFIG_VIDEOBUF2_DVB) += videobuf2-dvb.o
>>   obj-$(CONFIG_VIDEOBUF2_MEMOPS) += videobuf2-memops.o
>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-heap.c b/drivers/media/common/videobuf2/videobuf2-dma-heap.c
>> new file mode 100644
>> index 000000000000..377b82ab8f5a
>> --- /dev/null
>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-heap.c
>> @@ -0,0 +1,350 @@
>> +/*
>> + * Copyright (C) 2022 Randy Li <ayaka@soulik.info>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/dma-buf.h>
>> +#include <linux/dma-heap.h>
>> +#include <linux/refcount.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <media/videobuf2-v4l2.h>
>> +#include <media/videobuf2-memops.h>
>> +#include <media/videobuf2-dma-heap.h>
>> +
>> +struct vb2_dmaheap_buf {
>> +       struct device *dev;
>> +       void *vaddr;
>> +       unsigned long size;
>> +       struct dma_buf *dmabuf;
>> +       dma_addr_t dma_addr;
>> +       unsigned long attrs;
>> +       enum dma_data_direction dma_dir;
>> +       struct sg_table *dma_sgt;
>> +
>> +       /* MMAP related */
>> +       struct vb2_vmarea_handler handler;
>> +       refcount_t refcount;
>> +
>> +       /* DMABUF related */
>> +       struct dma_buf_attachment *db_attach;
>> +};
>> +
>> +/*********************************************/
>> +/*         callbacks for all buffers         */
>> +/*********************************************/
>> +
>> +void *vb2_dmaheap_cookie(struct vb2_buffer *vb, void *buf_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +
>> +       return &buf->dma_addr;
>> +}
>> +
>> +static void *vb2_dmaheap_vaddr(struct vb2_buffer *vb, void *buf_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +       struct iosys_map map;
>> +
>> +       if (buf->vaddr)
>> +           return buf->vaddr;
>> +
>> +       if (buf->db_attach) {
>> +               if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
>> +                       buf->vaddr = map.vaddr;
>> +       }
>> +
>> +       return buf->vaddr;
>> +}
>> +
>> +static unsigned int vb2_dmaheap_num_users(void *buf_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +
>> +       return refcount_read(&buf->refcount);
>> +}
>> +
>> +static void vb2_dmaheap_prepare(void *buf_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +
>> +       /* TODO: DMABUF exporter will flush the cache for us */
>> +       if (buf->db_attach)
>> +               return;
>> +
>> +       dma_buf_end_cpu_access(buf->dmabuf, buf->dma_dir);
>> +}
>> +
>> +static void vb2_dmaheap_finish(void *buf_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +
>> +       /* TODO: DMABUF exporter will flush the cache for us */
>> +       if (buf->db_attach)
>> +               return;
>> +
>> +       dma_buf_begin_cpu_access(buf->dmabuf, buf->dma_dir);
>> +}
>> +
>> +/*********************************************/
>> +/*        callbacks for MMAP buffers         */
>> +/*********************************************/
>> +
>> +void vb2_dmaheap_put(void *buf_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +
>> +       if (!refcount_dec_and_test(&buf->refcount))
>> +               return;
>> +
>> +       dma_buf_put(buf->dmabuf);
>> +
>> +       put_device(buf->dev);
>> +       kfree(buf);
>> +}
>> +
>> +static void *vb2_dmaheap_alloc(struct vb2_buffer *vb,
>> +                              struct device *dev,
>> +                              unsigned long size)
>> +{
>> +       struct vb2_queue *q = vb->vb2_queue;
>> +       struct dma_heap *heap;
>> +       struct vb2_dmaheap_buf *buf;
>> +       const char *heap_name;
>> +       int ret;
>> +
>> +       if (WARN_ON(!dev))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       heap_name = dev_name(dev);
>> +       if (!heap_name)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       heap = dma_heap_find(heap_name);
>> +       if (!heap) {
>> +               dev_err(dev, "is not a DMA-heap device\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       buf = kzalloc(sizeof *buf, GFP_KERNEL);
>> +       if (!buf)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       /* Prevent the device from being released while the buffer is used */
>> +       buf->dev = get_device(dev);
>> +       buf->attrs = vb->vb2_queue->dma_attrs;
>> +       buf->dma_dir = vb->vb2_queue->dma_dir;
>> +
>> +       /* TODO: heap flags */
>> +       ret = dma_heap_buffer_alloc(heap, size, 0, 0);
>> +       if (ret < 0) {
>> +               dev_err(dev, "is not a DMA-heap device\n");
>> +               put_device(buf->dev);
>> +               kfree(buf);
>> +               return ERR_PTR(ret);
>> +       }
>> +       buf->dmabuf = dma_buf_get(ret);
>> +
>> +       /* FIXME */
>> +       buf->dma_addr = 0;
>> +
>> +       if ((q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
>> +               buf->vaddr = buf->dmabuf;
>> +
>> +       buf->handler.refcount = &buf->refcount;
>> +       buf->handler.put = vb2_dmaheap_put;
>> +       buf->handler.arg = buf;
>> +
>> +       refcount_set(&buf->refcount, 1);
>> +
>> +       return buf;
>> +}
>> +
>> +static int vb2_dmaheap_mmap(void *buf_priv, struct vm_area_struct *vma)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +       int ret;
>> +
>> +       if (!buf) {
>> +               printk(KERN_ERR "No buffer to map\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       vma->vm_flags &= ~VM_PFNMAP;
>> +
>> +       ret = dma_buf_mmap(buf->dmabuf, vma, 0);
>> +       if (ret) {
>> +               pr_err("Remapping memory failed, error: %d\n", ret);
>> +               return ret;
>> +       }
>> +       vma->vm_flags           |= VM_DONTEXPAND | VM_DONTDUMP;
>> +       vma->vm_private_data    = &buf->handler;
>> +       vma->vm_ops             = &vb2_common_vm_ops;
>> +
>> +       vma->vm_ops->open(vma);
>> +
>> +       pr_debug("%s: mapped memid 0x%08lx at 0x%08lx, size %ld\n",
>> +                __func__, (unsigned long)buf->dma_addr, vma->vm_start,
>> +                buf->size);
>> +
>> +       return 0;
>> +}
>> +
>> +/*********************************************/
>> +/*         DMABUF ops for exporters          */
>> +/*********************************************/
>> +
>> +static struct dma_buf *vb2_dmaheap_get_dmabuf(struct vb2_buffer *vb,
>> +                                             void *buf_priv,
>> +                                             unsigned long flags)
>> +{
>> +       struct vb2_dmaheap_buf *buf = buf_priv;
>> +       struct dma_buf *dbuf;
>> +
>> +       dbuf = buf->dmabuf;
>> +
>> +       return dbuf;
>> +}
>> +
>> +/*********************************************/
>> +/*       callbacks for DMABUF buffers        */
>> +/*********************************************/
>> +
>> +static int vb2_dmaheap_map_dmabuf(void *mem_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = mem_priv;
>> +       struct sg_table *sgt;
>> +
>> +       if (WARN_ON(!buf->db_attach)) {
>> +               pr_err("trying to pin a non attached buffer\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (WARN_ON(buf->dma_sgt)) {
>> +               pr_err("dmabuf buffer is already pinned\n");
>> +               return 0;
>> +       }
>> +
>> +       /* get the associated scatterlist for this buffer */
>> +       sgt = dma_buf_map_attachment(buf->db_attach, buf->dma_dir);
>> +       if (IS_ERR(sgt)) {
>> +               pr_err("Error getting dmabuf scatterlist\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       buf->dma_addr = sg_dma_address(sgt->sgl);
>> +       buf->dma_sgt = sgt;
>> +       buf->vaddr = NULL;
>> +
>> +       return 0;
>> +}
>> +
>> +static void vb2_dmaheap_unmap_dmabuf(void *mem_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = mem_priv;
>> +       struct sg_table *sgt = buf->dma_sgt;
>> +       struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
>> +
>> +       if (WARN_ON(!buf->db_attach)) {
>> +               pr_err("trying to unpin a not attached buffer\n");
>> +               return;
>> +       }
>> +
>> +       if (WARN_ON(!sgt)) {
>> +               pr_err("dmabuf buffer is already unpinned\n");
>> +               return;
>> +       }
>> +
>> +       if (buf->vaddr) {
>> +               dma_buf_vunmap(buf->db_attach->dmabuf, &map);
>> +               buf->vaddr = NULL;
>> +       }
>> +       dma_buf_unmap_attachment(buf->db_attach, sgt, buf->dma_dir);
>> +
>> +       buf->dma_addr = 0;
>> +       buf->dma_sgt = NULL;
>> +}
>> +
>> +static void vb2_dmaheap_detach_dmabuf(void *mem_priv)
>> +{
>> +       struct vb2_dmaheap_buf *buf = mem_priv;
>> +
>> +       /* if vb2 works correctly you should never detach mapped buffer */
>> +       if (WARN_ON(buf->dma_addr))
>> +               vb2_dmaheap_unmap_dmabuf(buf);
>> +
>> +       /* detach this attachment */
>> +       dma_buf_detach(buf->db_attach->dmabuf, buf->db_attach);
>> +       kfree(buf);
>> +}
>> +
>> +static void *vb2_dmaheap_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
>> +                                      struct dma_buf *dbuf, unsigned long size)
>> +{
>> +       struct vb2_dmaheap_buf *buf;
>> +       struct dma_buf_attachment *dba;
>> +
>> +       if (dbuf->size < size)
>> +               return ERR_PTR(-EFAULT);
>> +
>> +       if (WARN_ON(!dev))
>> +               return ERR_PTR(-EINVAL);
>> +       /*
>> +        * TODO: A better way to check whether the buffer is coming
>> +        * from this heap or this heap could accept this buffer
>> +        */
>> +       if (strcmp(dbuf->exp_name, dev_name(dev)))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> +       if (!buf)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       buf->dev = dev;
>> +       /* create attachment for the dmabuf with the user device */
>> +       dba = dma_buf_attach(dbuf, buf->dev);
>> +       if (IS_ERR(dba)) {
>> +               pr_err("failed to attach dmabuf\n");
>> +               kfree(buf);
>> +               return dba;
>> +       }
>> +
>> +       buf->dma_dir = vb->vb2_queue->dma_dir;
>> +       buf->size = size;
>> +       buf->db_attach = dba;
>> +
>> +       return buf;
>> +}
>> +
>> +const struct vb2_mem_ops vb2_dmaheap_memops = {
>> +       .alloc = vb2_dmaheap_alloc,
>> +       .put = vb2_dmaheap_put,
>> +       .get_dmabuf = vb2_dmaheap_get_dmabuf,
>> +       .cookie = vb2_dmaheap_cookie,
>> +       .vaddr = vb2_dmaheap_vaddr,
>> +       .prepare = vb2_dmaheap_prepare,
>> +       .finish = vb2_dmaheap_finish,
>> +       .map_dmabuf = vb2_dmaheap_map_dmabuf,
>> +       .unmap_dmabuf = vb2_dmaheap_unmap_dmabuf,
>> +       .attach_dmabuf = vb2_dmaheap_attach_dmabuf,
>> +       .detach_dmabuf = vb2_dmaheap_detach_dmabuf,
>> +       .num_users = vb2_dmaheap_num_users,
>> +       .mmap = vb2_dmaheap_mmap,
>> +};
>> +
>> +MODULE_DESCRIPTION("DMA-Heap memory handling routines for videobuf2");
>> +MODULE_AUTHOR("Randy Li <ayaka@soulik.info>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS(DMA_BUF);
>> diff --git a/include/media/videobuf2-dma-heap.h b/include/media/videobuf2-dma-heap.h
>> new file mode 100644
>> index 000000000000..fa057f67d6e9
>> --- /dev/null
>> +++ b/include/media/videobuf2-dma-heap.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Copyright (C) 2022 Randy Li <ayaka@soulik.info>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef _MEDIA_VIDEOBUF2_DMA_HEAP_H
>> +#define _MEDIA_VIDEOBUF2_DMA_HEAP_H
>> +
>> +#include <media/videobuf2-v4l2.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +static inline dma_addr_t
>> +vb2_dmaheap_plane_dma_addr(struct vb2_buffer *vb, unsigned int plane_no)
>> +{
>> +       dma_addr_t *addr = vb2_plane_cookie(vb, plane_no);
>> +
>> +       return *addr;
>> +}
>> +
>> +extern const struct vb2_mem_ops vb2_dmaheap_memops;
>> +#endif
>> --
>> 2.17.1
>>

-- 
Hsia-Jun(Randy) Li
