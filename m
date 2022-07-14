Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE19D574F45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiGNNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiGNNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:35:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3754F66B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKHBr19DFbmpAaWXcjwYYPLTD+g5O0TnklVzwfysZ+wqQc9TVklDpagHeu81UCHFJofZKBjq9kSNIGzivbrsK3KVO86KGrUZ/SXflUI/bC1AYbxIH/yEQCmJCs92/wEOfqVkLs8DZE/Xf+usXl30itM4hvxyRS2WGzi4dxvGuqBH1GxA+k97l/a0IcrRCcQninaj7LgvbGFTFNVdlngHpAHkumPv49oLRF3+wgkgjN7IzcwyluSvVia3KMhFVJfdO8zB8OdcK9qKZvcvWX2x9CLg0hxC27JTp07CtVrQa4BZZgG/oLisvhh4aTGkz3jWh1KUu2503/irKoEpRHD/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjYZJ1yRk1Mwo8FNdIAVBURBynjuhwzAPqzN4i6y01U=;
 b=RgOcEMNtvck814pJcVmFQkx9VPr8aHCM+paSV+CP8HZbl2pvSYBV+WvidXYDzgZJOBqavTO3of7DPTHkaVvxVD9czEewYN2E+519MbqG6AYkN1JLCyg6fp9k8IP50SOLC1FUSuw9vxeSBhq5bdwMar+LFnkrZ2Ravz1VXi2zbqNlJS6rad8LoRcaIkSCFdTyqTxlHphxrJwJnn69GpKJ/t21roY0qfOgiWjDjKOhfu+MnC1DiCcyd23D+sBy5vuRDaOiiGvb2lx+3rsZa4uT9ogCYclittLHl0V8sj4iQ+kq0MWW/JNw82lCKBfMnmxXsBYpb10dMjl20qayS/nWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjYZJ1yRk1Mwo8FNdIAVBURBynjuhwzAPqzN4i6y01U=;
 b=GTaPlYfFoe2L8hwTCjM+VJcOe+dzxxkqrN0lrmAUk2YmwSdq2aPaDok4T4rw1IoZHU/hWvmSgvFFdy3izzUgqjxLFCNZkwQJDQzWUS0qbmzmcKvkaxWy4YH7aGA09xw7rrmws8hY2p76yoLB/SsQzIq40WCHGpAEyrDFj+SI5Etm++L8tP1AfLm/dWh+9xZ8LKQxa4at1tFCUERDOCJ8C4azgyLsbRFnM+a0R3wUJTLjj9Jmiqv1uuiN5AIO0ERGTEXDyN7ygUhhRHHrU60IBkAvRWjA72SvR8QIhaIMR3vu412fXhlycXTo8A2hNRvwBR5QcqaOf38nl+ozDGSmrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB8PR08MB4985.eurprd08.prod.outlook.com (2603:10a6:10:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Thu, 14 Jul
 2022 13:35:48 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 13:35:47 +0000
Message-ID: <92d0aae3-58b8-4603-3bab-c4bb5ba6a5fd@virtuozzo.com>
Date:   Thu, 14 Jul 2022 16:35:46 +0300
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
 <123b7518-b0c9-171c-9596-73654691ee58@virtuozzo.com>
 <bfb7ab7f-6c17-e1fe-d87e-b19312f06e0c@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <bfb7ab7f-6c17-e1fe-d87e-b19312f06e0c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0186.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::7) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3601dd-cc7b-4dc0-1e35-08da659dc2c3
X-MS-TrafficTypeDiagnostic: DB8PR08MB4985:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/Pd7XIqyvrlPcy21f7LXnBOKVuBqOMj9rvsmRnXrzI2j4JqJKxpaoJxkv5W6Z/j5dWOvG5qvJjrauexDpvSCuxEVk3DRWh3iDTYdxujmougTYh5rdijQvdsDT47K5tDlY4Q97KAduMWSsDxdZtUP8kAtA+Tggk0YVhCS3qTZI6VPL6XzEq0VHuRd6cuJXBXDs0QAlA77bb/mRW4SsK1lQcI0B/nHBaOrjBR5sDjEVjIVfqG9aQT2Py2aNCG5tJ5Akf4zlNVBAx8TuPNOmHd0vWIQf7eSOtEUmyJLc4vX9XuWJBB5SgRTViOwejWDf/asQUHYeKsirFNU50aLEgFmKkcfuJz6xkVt3kwBTyoW7xy9P76OvhYKbQ7IH6LohKU8tDJuZihhlHfDUZdHo8eFanqjVgifvI5nYQMFJ/o3hs/9GXbIjhnH/Jx59+vtvKnnsYQ1xev5CXqVyHLMZXtcOcPHOv/70NWH/zc7JyDS0FHyJBW12Ne5+zkqrzAD1xg2aDJN/1U7b4uSKjGbxx1VvBer4+8yueoeZQclyYV4ThBsW+WrlJD/eRtcOmp1x34mfUPuX14P71ARM9cxu3b9I/exzChlQyRA1Xt7zcl7Pu2QoeuHsY0oNhDKLosEsYzVvDI0UOR4t1sn5Jkxjlt3K6pxgiZXC5GWIwDhbUYXiYhlyAdB/V1PPNGjwpQhTN0Uwbs+HFpgQsspV0vhFtLm2/SRMYaCMwii3EOlJ3HSTmgnVTKIrAxWuZQGDkh2CqBezASkR1/0Io3iaxYj/5OXhteybntW+q+aITmpIJPi4dQFyoSzxTfabu/IrsSp11SAnlQnl4dlQNiMUQFhGLcAicls70LNjhmKMIjPYmQYZipZFjLehxkel+HTR8gYt1F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(346002)(396003)(136003)(376002)(52116002)(66946007)(31696002)(4326008)(53546011)(8676002)(44832011)(6512007)(66476007)(41300700001)(478600001)(83380400001)(26005)(2906002)(186003)(6486002)(5660300002)(66556008)(86362001)(31686004)(316002)(36756003)(8936002)(38100700002)(2616005)(38350700002)(110136005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0YzYWJXcWtFZ3lQWXl3Qy9CRVlvUGlpbDRTZnBSVnZVakdyaEw2T0Q4dFpO?=
 =?utf-8?B?VmxQSXVja2lHSnBDNjlUMktZbjhqbmI3OWhVaFJXTXJvOFltemZNaGJWOUNh?=
 =?utf-8?B?aHg0NnhQMEN3cnB6eEhFb0FsWjdFZTBUTGlURG5GZEhWa2Q1TnJFVjdJdjF2?=
 =?utf-8?B?OXJZZ0JBOW9qZlJHcTN5VExWdkUwaXpnMVNmUHVNK1c1UmNNR0hpbkVSQnh1?=
 =?utf-8?B?RnQxQURLOWxDV0VpNk85ZTNiSm5mUlZUN0Q1WXRIV3N2UVVKSjJReW1pVnZk?=
 =?utf-8?B?bGMwN2RuNUpjUzZpbThxeENNbzltdDhYOEpNQm12KytqM2Q0azE3TlFmamxZ?=
 =?utf-8?B?YXdKQ2VRc0wwc2MvbW9CUDVYRklPTWVZbTZJZThlckNNemR0ay91ZWl3d25K?=
 =?utf-8?B?Z20yNEg1RCt0TGQzRkZmZzdEUUtHeDZ6ME9UbXNQeWVoMmhVeDR6QzV2ajJN?=
 =?utf-8?B?RVRnWXNmWU05TWdiZ0tmVCt6U0l6QjJyMy9ldkZSMHJicjVXVUpTWFRTbUtP?=
 =?utf-8?B?MUVKeFlLMnYzYXlEOHNUUm9DeERsNTVTcTZ5TkJiOUJHMUhCQUQxWVVqZGZa?=
 =?utf-8?B?dHJOeGx6cndmYUxNaWNjdklYR1lWSmk0QjQvSkZZMlBMY2ljNnBFTUFUU0cx?=
 =?utf-8?B?NFdMN2tMRU9QMkJQcDNkV1dYazRGbWQ5Vk5BVlFPVlNlMzVncVRUUktsMlpJ?=
 =?utf-8?B?T002Y05nYnhuRmxrb3NrWlBpZFdKQXY2NWZVKzJwVGdMNHllMGpGQ3ZweEM3?=
 =?utf-8?B?TEMyeDZoM2p4Y3Iyc0FMVCtqOFJwaDdPQk41N0FUb1Z3MFgxRE9PNzdtWjJL?=
 =?utf-8?B?VnJlYjc0eis4Qys1UnpyUm1BT0g5aHN6aUVIQkJ5Rzk3cDVKQVhnRzNpMytt?=
 =?utf-8?B?R3V3VXAzSmtRTVNISXBJRURXT2M0WXU3MTY0dExIM2g3RzdKY2xKeFQ0QXNs?=
 =?utf-8?B?dC80ZTYvSFFnaWthSUhlS1NVcGRCZDBrRUhndWd1YThGejFYMEtlRnJkamtO?=
 =?utf-8?B?Znl3N2ZnaGYrYkpnZ1JrT1NlSnAzWDQzTnluS0NNM2hpaVpOT0tvditabm92?=
 =?utf-8?B?NGZuN3dseTAydVFReVNIcVhteWZLb1oza2hnUjl6Yll5S1NYUE1DdlArc3Q0?=
 =?utf-8?B?bkkwR0ordUR1bjJpcDVjM09TRkFWM2JPWS9QcGN1RW5PZkU4a0NHc25ickty?=
 =?utf-8?B?TGtoZmF0TEhQcmFaSkE4aVplYVFVZlpwMDFHMnpzdERLMkNnTTV0VUt4Zk5p?=
 =?utf-8?B?T1A1ZEg3cVAvRUNYNGx3R3NCdVFyajV0b0dRVVF5VlViSWUzNCsxblhQSHRB?=
 =?utf-8?B?WElqellETlF4dHBZWDBpVzhVUHpKS0hqc2tPS0dMcUdURDFUZGdsd0pSN1dn?=
 =?utf-8?B?Nm4xbHpuRFRwQ3ZpQ0VOaHNaMWtDeVRJWEFlQTM0R0lxbUZsaWNOSkh6ZkV5?=
 =?utf-8?B?Rk5pRDNEbklWRzB5bmQ0SlhuaVlKd25RclNuQm9EM1krb0t1ZWZYNkVsQlRH?=
 =?utf-8?B?a0RlQis3RTZaOGNNN0NzNzlYcXd6UG5uQ3JoaFVsSkZ1YldxeXJBRmJweTVF?=
 =?utf-8?B?MU9PWFkxUlNKZTFVdDFEMXYvdTNMK0JpQ0FLaUk4V0x4SVpKaFlNKzF3QUVI?=
 =?utf-8?B?Z1RFT3E5elhEaGJOWGFUekhPbUJDV1FEMkRYVjlkbW42UG1SNVVWR2hSOWIv?=
 =?utf-8?B?dkhOMTFlNk1tWVg3ZFd4Rmw1K1VxL3JRK0VvQy9vQzhGRHVseVRqUnlQS1BM?=
 =?utf-8?B?RG13M3pTQ2loRzhTTHdVQklyd0VOQm80RUg0OXRWejQ0dnZDN21FNU5vTUZk?=
 =?utf-8?B?NFpCNDBIRU9JbVV2MURNWjNwUkhNOHpCbE9XSGpSUHJsL2lxUVV5dHdCMkZI?=
 =?utf-8?B?WTdOejdKWGpYbk1od1lDaVh5bzZ1WUpDMWxrT2RYQUN3V1BKcUFxbndNSjBI?=
 =?utf-8?B?cDdKUHNWMmhoWHI5WWhKQmVuZjVWdjcxSUo4aDRUZE84YWZtSVhtbE1RRjJX?=
 =?utf-8?B?YWFIeFhmRnBmY25zYkJpMThHaWJoek5XS2pESDg4djloYWV0S0RRK3VNbDFu?=
 =?utf-8?B?OW03VDVrR3M5WStqZ3pSSGJvUFFuVWNkcjlOZVpLSWVHMTRscmc0NzZFaFR0?=
 =?utf-8?B?d29JcHM5NkFmODZXcjFHU0hqUksxZlRQUEZ3cmRYVTMvVXdjMG40QXVCYzlm?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3601dd-cc7b-4dc0-1e35-08da659dc2c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 13:35:47.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAYkMCKPiTSGTHXVY4SXCYTVXqYfhSwnHv2glEj95uyVOFq4i1clJvDAfc8Njrqb/WP0NFlnKbSKWFn6iVFEQZGQfRKDOGIDUtrBIvEDfif7KTKLqCzMUifhHaRxzLlG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4985
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

On 14/07/2022 16:24, David Hildenbrand wrote:
> On 14.07.22 15:20, Alexander Atanasov wrote:
>> Hello,
>>
>> On 14/07/2022 14:35, David Hildenbrand wrote:
>>> On 05.07.22 10:36, Alexander Atanasov wrote:
>>>> Allow the guest to know how much it is ballooned by the host.
>>>> It is useful when debugging out of memory conditions.
>>>>
>>>> When host gets back memory from the guest it is accounted
>>>> as used memory in the guest but the guest have no way to know
>>>> how much it is actually ballooned.
>>>>
>>>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>>>> ---
>>>>    drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>>>>    include/uapi/linux/virtio_balloon.h |  1 +
>>>>    2 files changed, 78 insertions(+)
>>>>
>>>> V2:
>>>>    - fixed coding style
>>>>    - removed pretty print
>>>> V3:
>>>>    - removed dublicate of features
>>>>    - comment about balooned_pages more clear
>>>>    - convert host pages to balloon pages
>>>> V4:
>>>>    - added a define for BALLOON_PAGE_SIZE to make things clear
>>>>
>>>>
>>>>
>>>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>>>> +
>>>> +	/* Total Memory for the guest from host */
>>>> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
>>>> +			guest_to_balloon_pages(i.totalram));
>>> totalram is calculated from totalram_pages().
>>>
>>> When we inflate/deflate, we adjust totalram as well via
>>> adjust_managed_page_count().
>> That is true only when not using DEFLATE_ON_OOM.
>>
>> Otherwise inflated memory is accounted as used and total ram stays the same.
>>> Consequently, this doesn't calculate what you actually want?
>>> Total memory would be totalram+inflated, current would be totalram.
>> My calculations are correct for the case deflate_on_oom is enabled.
>>
> Which is the corner cases. You'd have to special case on DEFLATE_ON_OOM
> availability.

Besides checking the features?

>
>>> But, TBH, only export num_pages. User space can just lookup the other
>>> information (totalram) via /proc/meminfo.
>> I have missed that the memory accounting is made differently depending
>> on a flag.
>>
>> Since the calculations are different i'd prefer to have the values
>> calculate and printed there.
> What about an indication instead, whether or not inflated pages are
> accounted into total or not? That would be slightly cleaner IMHO.

If you care if they are included or not you can check the features and
see if the flag is enabled or not. Going vice versa is not so easy to calculate
the final values. Please, see the v5.

-- 
Regards,
Alexander Atanasov

