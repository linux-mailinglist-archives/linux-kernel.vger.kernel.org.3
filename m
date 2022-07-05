Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0925665C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGEJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiGEJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:02:46 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130134.outbound.protection.outlook.com [40.107.13.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E1392
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBRayz78frcfc6q9b082rw4+nu3jGjfM3mBZRStB3ZyRFPVnCkLcPoGjjY4BWeUsxAebxYMk2pnd8tqmwRzYkeCo7KTX8HKa8bZJ//3l9BsFWZJqmaeMuK9+/0H7433DbVO58we/1zaQcK9PzLs6ub4SEm4TJs5bN4gjp0AyqpC6kV/pnWWPZd8TGIUAf6AH/3p6oPws0kyy3skRlQxbPDRGVRMGF3+NZ6ZrcsGm13uGGxWV2RK0FarHzOXwzxANmhKoH+pX9H70j78PGp5eq391c1E3G608NJM+LjeDDJ56wGnkT2eHEJZsiRGKt7nMReHZBVwm4G6G05bJ3i//Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxACyF5oi8TbIic8mkM/J/U1qFcTYr9lpIEtBzy/zzQ=;
 b=RSiQSITIUpEZxmVvTU+YkACwHI3MqQeAdsev/nLs14Cy0KhSpOj/0aMNgDREGc4/SZvBZQHKiNMohH5XmuyyaEhaN1oyRJDUoiXxRZtMe9nWUVTjEKCfMVkmw4XbVy0gzWt6VBxrsjxCiNlRhM2pVDJZcTs9V0bqF0QTJB3bfMzk2+7UkHWp4kruW8tpJzgi8KfTuoiD6B6pZEHhcfrJjcSTLDIwKtoGhPSpg9OAcnqbpjC4k59FiWlACnrOZbBXbP7e2GGjdwYB8nXj5d2xpEmnZG+dRbt3e7G1KOircWA5tLCf8z/DQbVn3nHZB5P7h9npiAwRcVsdDt5Rp4gK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxACyF5oi8TbIic8mkM/J/U1qFcTYr9lpIEtBzy/zzQ=;
 b=XSffP4BEuH1GdvOxVeiiRjIofuERxoY009kZXD6es/r63WxO9CltqHK6U3HLEost6T/0I/SNZL5CLQ8ZiFnazgkbaDbfdfEiO3Ck0QXHYji6igMq2eqOGyeN/iTSeg7odZAi/kcvF/JBUrABNBDACAY/Gxo8a7WCl1YlSEZqVuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 09:02:00 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 09:02:00 +0000
Message-ID: <f6b46a29-0f65-9081-5228-a1028fea2bef@virtuozzo.com>
Date:   Tue, 5 Jul 2022 12:01:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <20220705045912-mutt-send-email-mst@kernel.org>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220705045912-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:803:118::22) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6006916-26f2-4770-b33a-08da5e650554
X-MS-TrafficTypeDiagnostic: PA4PR08MB6141:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YjDBK7kTXM2eq93+gbfKyLx2IdDl+xi7BNgx2+3UwT8jlW1HwwtBHK/fFQ9vQgQ2y3/J/baqtdPOhEVgQ2DHt/GOxsZ1P7FoLdlBw83lAe6IldWBqsj10M+dcDos9hO91xVLoq3XfbxzYqOmIbMrVtVk1Jvq5kCR/0Ew3QvFOqnohTObi4BXYa+48EbdSouxh3bZ0VgA1dmey7vr2FkGTE18pveQXjnrZrMiplb3Z9IAKPhlT2Q4C0Hmpy4hLoUYd5EC4XRqa2JqdtgJTs/thyhMJLMylz0cIOGYA3J78zv6T22Hy6bDN4pRydxOTpbSeUim28NPhn/ABOv46hIyUU8APg3axu1Mr6PvFPkdXku2rBB2Zzb7oyXqMpu+DXXsFodnhMYye+7ieHR3Azp9JYZhIIVnn1FYs92qmvIIgSY0KLhDbiMQ5qGvtNHjoskZGpJN1iqO7MG0KtlqhivphUVTiI7OaLyr7h8oE24f8KO1llcIUzIUBVaSBEosERTLQ7+LRYWQjZufUJWxOJPGTL/gAaqeOahNpdU+NM7N874cDLDgJQmNT833wCeKKNff05QuSPhNh2Bm46PdAAIQ6fW6zjW4/Avnz32TMdUIB1ZzQLhNthM7XKJq4wZH8QP2jplwOD8m3Ml9OQ+9Wd7SLASOJi17LX0jZRk1S6in0BLr8AnpB1XT7IyZUHy6odz+2C+UIAwaotkJ2AanKtaqATaGoRgBq7n38WxWXDj4yqqwRgEOiRpBqpFRLim6nv8Mm8iDx2uzQx0XMIEcjfAaUYXH0VbbSh0mzOTdZTX6DYaacGE2lNBQKpwBOCA6BuhIaK/7apTPdBg3BfislIapHehK6qVmyZxzRLpAsPJu+588fdBEfpa8bOwKq5caxLG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(366004)(396003)(376002)(346002)(44832011)(6486002)(478600001)(8936002)(5660300002)(52116002)(53546011)(6506007)(31696002)(6512007)(41300700001)(2906002)(26005)(86362001)(38350700002)(38100700002)(2616005)(186003)(83380400001)(66946007)(8676002)(66476007)(4326008)(66556008)(36756003)(31686004)(316002)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElyTDRsWTVmRTlxVTNLSnhTcnZlMVlmYjJiazZKR0gzbXNaMG5WVnAzL1BL?=
 =?utf-8?B?cTZoeldDWDg0UlZEYTlzbGF5VVZra0J2c1BtNWNBd3pHRWlNWCtwcWpxSGVK?=
 =?utf-8?B?UFMwa2tsYnU5SXNzcE1iT3dMOXB4MzBXSTZnVmZ5ckx5eGoxR1RkODl3U0c5?=
 =?utf-8?B?VFdkdFN3S0lJaG94K2RHbWY2MnRRTlExLzhrM1QrbEVPbm5qSVVIdjBGc1pv?=
 =?utf-8?B?YTdpeHVMRWRNQWJKMWhUanpVZk9oWjV2b3VwQk5ZM1RvbkVEbTRZM2RSRHlh?=
 =?utf-8?B?STlQWVRDem5ZR2hKSjlFTWRlZm1qRjFja1RhbWpzdWxyQVo4SlA2eWQ5RGZE?=
 =?utf-8?B?TGRQajJMeExCa1ZsN0tna25uZDc1S0g0N1hGTmdrMkF0UnhJbEZlbFVYemhv?=
 =?utf-8?B?d0ZhcUc1dCszQ3RsRW01Q2RCTms3dzEwWTJzNDZpdUxvblFIMkFya0x6c2JF?=
 =?utf-8?B?Q0UzS0Ivc3c0cnM5ODc0aldRd2JTVkx4a2lqK1dIWEdnRU1sQUQzY3lQQm1W?=
 =?utf-8?B?NGlPZWZXZ1l6UzdGZWJTdC9MOENhUFMxQURSaTBsNlpCaTh3K1BwUXRVZDN3?=
 =?utf-8?B?NkEydmhFMTVoL1ZpZmtZMEU5V0ZwZHU1TFlOQ0ZieHVMNk96Uk52aGd3Q2xp?=
 =?utf-8?B?cnhqVFdUWGZ2Um56ZGxHT250REFJSVF1aDVOalhPNVFuZ1B1QlZmdm9SU3Ir?=
 =?utf-8?B?WS81RmxwdURxREZZTnN0dmtBeHZRRnlwUUFIUk0xNkZLenhSUDNDZERhQzlx?=
 =?utf-8?B?U2YrVmorWXpRem9qWDRpWUJKSEQ4ZWxDRjNaZmh5aHRZeWRLSmxIN1dlaGNs?=
 =?utf-8?B?U09hcG5lYWpmSm10M3cvMlliNzJLUFRaakpadlRyKzlnT1BRQVpPa1NVblc5?=
 =?utf-8?B?aDQra0xOMm1LK2VkMFB1UXNtb0lVclVzU3U5cWZUT2w5b29URVcvVEJxdFBu?=
 =?utf-8?B?TmhmNnJ0dEpIUkp0cEQwUWFGZjlIaWZTdHdSWHVTdi9YYjdVR1ZuYmhiSGoz?=
 =?utf-8?B?Z1dwT3FhOWlWOHFSNlNUL3JGZW9US05WY2dUdWlzaFpWRFlETVN0cVRXdHNz?=
 =?utf-8?B?elljNXkvWEVxdEZjVUFTV0JrcGZTOWJFTFkrZ2JtcSs1RXNKRC9IUjlCUmtF?=
 =?utf-8?B?d0txWFpCSFIzY2VEM0FLSG9VV0Q1YjVTdzVhVzk1Sjl4UEdRZDRRWTNMYVZY?=
 =?utf-8?B?Q1cxcHdrMHIxMmJlc2diVGM5NDZmMlo4VUIrd3BWVUxQMm43UVdlMzloblJs?=
 =?utf-8?B?ZUVzLzNyWjhsYXVsZEN0b2IzK3BmeVBXMUlINXZrTWxvL1lGNUoyUi9UMlRF?=
 =?utf-8?B?dVdnblNydEhWc2RsMWRxTXBqU2pHSmUzZE84MTN0bjFEaFBEb1R5Q2JsZ01X?=
 =?utf-8?B?TWVLYTRQZEJUVkQwT2NYcE9WdFk5dFhkbEpKSHVwWEV4SCszRTdUanhSMSt2?=
 =?utf-8?B?NmRkZjU4VmJEYnUxWmJPdHo0TWdoSFlyWXNDTGVjQWhQU3hScFh4WGhneUJL?=
 =?utf-8?B?V0JNYnlRUFZNakRsUjdLbXhybTR0clZ6UmJtZGoyWXBRa0Z4SFUvRW1ra2pX?=
 =?utf-8?B?ZXNZNGcrS05rMWVxcGZUanc2MTByK2pjRkp2amszV0tBaVRhOTFDcTZJK2Nv?=
 =?utf-8?B?MWFvY0k2Y3JmMENBSTFneFh0RHZvS0Y5Mk1ya3VIalJuS0lGQ1BvZnpDeGpz?=
 =?utf-8?B?MDJLWW9qb0pXVWt5a3RQR3VoRUJUMUJhc0QvTFV6YU9wYWJMM29kbUo4YTRT?=
 =?utf-8?B?OFl6ek5aSEhxakdreUVCLzhFL0ZUZGk5ZGxYZmM4M2JVUmM3S2Y5VStOMzg2?=
 =?utf-8?B?SGROcUhTS09TcEJWS2Z0cnNRTUZkend1dmhlbnVZbzdZNm5UZGtEWE4vUTdn?=
 =?utf-8?B?Z1pPY20xdS96d0tuWVM1UW9xRThpbDlzbU1ueGxMaDhrQmZ3N3dZSnlrbGhI?=
 =?utf-8?B?WWtha0RqRUNzWUZVR0Z6VUo5Mk1uSTh6SkVBMEUvTkJjQWdNNHVpbmh4SHdu?=
 =?utf-8?B?U3hTeks5dzhnbXlVYmFLWTV1ZU5uRDdwblQ3eFhYb3NUOTlHc0U4SFliWUsv?=
 =?utf-8?B?bFhtUmJ3T2c5NW82MjRNeDd2ZDNaK2xlZUdKM1Y4Nk9KN0pVWWtuNng1WDI3?=
 =?utf-8?B?S1licjc0VmxaYlVGSUtYNjRYZUV1VVd6MUpaNHlXQmJKMll0ZzVOUklNM2JN?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6006916-26f2-4770-b33a-08da5e650554
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 09:02:00.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkB87yS4IkSen4Rlny1waaxp79homTa6shnGAxdnMtIQ1PwU1mSdhSRP8lwdOvGdYVTyTYifwnYH4rBVkbhlw85I4mawFazbF572e4/z20bURYmoIwhb1a7NoKa8cWQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141
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

On 05/07/2022 11:59, Michael S. Tsirkin wrote:
> On Tue, Jul 05, 2022 at 08:36:37AM +0000, Alexander Atanasov wrote:
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
>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>> +
>> +	/* Total Memory for the guest from host */
>> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
>> +			guest_to_balloon_pages(i.totalram));
>> +
>> +	/* Current memory for the guest */
>> +	seq_printf(f, "%-22s: %lu\n", "current_pages",
>> +			guest_to_balloon_pages(i.totalram) - num_pages);
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_SHOW_ATTRIBUTE(virtio_balloon_debug);
>> +
>> +static void  virtio_balloon_debugfs_init(struct virtio_balloon *b)
>> +{
>> +	debugfs_create_file("virtio-balloon", 0444, NULL, b,
>> +			    &virtio_balloon_debug_fops);
>> +}
>> +
>> +static void  virtio_balloon_debugfs_exit(struct virtio_balloon *b)
>> +{
>> +	debugfs_remove(debugfs_lookup("virtio-balloon", NULL));
>> +}
>> +
>> +#else
>> +
>> +static inline void virtio_balloon_debugfs_init(struct virtio_balloon *b)
>> +{
>> +}
>> +
>> +static inline void virtio_balloon_debugfs_exit(struct virtio_balloon *b)
>> +{
>> +}
>> +
>> +#endif	/* CONFIG_DEBUG_FS */
>> +
>>   #ifdef CONFIG_BALLOON_COMPACTION
>>   /*
>>    * virtballoon_migratepage - perform the balloon page migration on behalf of
>> @@ -1019,6 +1091,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>   
>>   	if (towards_target(vb))
>>   		virtballoon_changed(vdev);
>> +
>> +	virtio_balloon_debugfs_init(vb);
>> +
>>   	return 0;
>>   
>>   out_unregister_oom:
>> @@ -1065,6 +1140,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>>   {
>>   	struct virtio_balloon *vb = vdev->priv;
>>   
>> +	virtio_balloon_debugfs_exit(vb);
>> +
>>   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>>   		page_reporting_unregister(&vb->pr_dev_info);
>>   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
>> index ddaa45e723c4..f3ff7c4e5884 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -40,6 +40,7 @@
>>   
>>   /* Size of a PFN in the balloon interface. */
>>   #define VIRTIO_BALLOON_PFN_SHIFT 12
>> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
>>   #define VIRTIO_BALLOON_CMD_ID_STOP	0
>>   #define VIRTIO_BALLOON_CMD_ID_DONE	1
> Did you run checkpatch on this?


Sure, i did:

scripts/checkpatch.pl 
../outgoing/v4-0001-Create-debugfs-file-with-virtio-balloon-usage-inf.patch
total: 0 errors, 0 warnings, 108 lines checked

../outgoing/v4-0001-Create-debugfs-file-with-virtio-balloon-usage-inf.patch 
has no obvious style problems and is ready for submission.

-- 
Regards,
Alexander Atanasov

