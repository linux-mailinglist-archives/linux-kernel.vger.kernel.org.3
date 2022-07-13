Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14642573B22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiGMQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiGMQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:25:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB1222
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcOLDNDqy/X85ckegSNMA2pW3l3Xk7DY7goFiYBfM0zZexPlZlWm+/jVvq/OmgnNPXtQ1aZBuCbJaTnQ/CeWDU4cYZNObP0bN3m8mJQRFlJFBlR955DclD/MG56XjtzHiV9dR7RNHGQ6TfHdDJkLvd745VqlQd0Ada5tt5kUyUWSofCldP8toL8F/dQeiYWdYdNb+s2qhFHxm8SyK0UmeoVuISRemEchFi9P//qr0sEkonA/ev4IQcba1QQRAD+wnEri5UP6FpioYbGEVnwd+vFLLdiPYfRsDrdWEGOdENeyCybZzeydVnq611poEBBLZk3Mdsb5BUayRo++HCjWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57wxrm73NyTmqXnfcD7V71EVrmmpgatK+Lx8SAD2qf8=;
 b=cK/EDfQ/+GzxGjgSk7NGk6G/01q8mp2gQmBOchJ24oU3CKoHJJVM1eVnkXAnQKGL5tTuGA1SDRBhFCS5Jioh/uUB5mkvvgQ8ufuHJBTRlfQfwPp7f5yzxzUXQgw91E7QUXx9yNpxeaK7g/hEi9jZUaEiu/vGYppxJZMibkoRUr0Z/OjwIL6AG0PLETZu2SzOX1IBJUhWat8vH6kgZrbMbHaYCr6xgO5ri7hbRmWyTQ+m4bcftLXa4Z00tgqGo31Ex3WktDXIiHr65MeMlnht300XmRVc210MZyHDoBjefy4M6nKodBByjj59yLC6/MXZfPgMcTR7dBfIyhPQwZ/wVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57wxrm73NyTmqXnfcD7V71EVrmmpgatK+Lx8SAD2qf8=;
 b=LG9Mxpt7WZXf55q6jyjboSQexmAqhdOL2ZNSxK0NXKPyiOCcds5iJe6RY6c5aC7bMRktvfmpCQwxREW7Kw8XJhrWQfD3DT5D5mg3ZQBp6wdjAimsBkyC6n6Wy2Dj4HF3UeQNw66wWWiDHYhrA7ZFqXAQ5oipAs0vFaDJiV5kTkSeX1Q13wJJX6+2cp5oG1/W96ggFI2isXJWadk1094T/EZII5BlOTeDnmzyMaYWck6azo1ZkaFFSkYxA2JIkRqpFpxF4xNxfWYIvrEtK5RybLC9kN0erc5h12a0H1fQxYD9fNJ15kzFAAurhIl7dbpTmyDngPoNrlYGbsxXhxpUyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AM5PR0801MB2068.eurprd08.prod.outlook.com (2603:10a6:203:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 16:25:12 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 16:25:11 +0000
Message-ID: <a2d00f23-bf02-7048-119f-c89f7825a2b5@virtuozzo.com>
Date:   Wed, 13 Jul 2022 19:25:09 +0300
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
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d55e37-6d7c-4357-7f0c-08da64ec424e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2068:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAZ/fI8WVtu8gAOO3ZxDeNSwGKqnMi3gCwIEBe+KxChibLNNRY8mswFmNMHLMJ+cwFELtZyz4Y6zAxRAUkvRAbi/qDlnVp+yHLzlhUJsmzOkI7n0m6FnkZGI9Pv1SEZde+JOYFiDUA+6Dt4N8z1WG1hdRG2Tw9Zd5UGonf59GkHWhPFV+Kw4RxbQExzdS5aGTDfphpqDbSE7xP/YHmm01VgC6h6mSBsC4cmwYjIBb8vUlrd0UbvzOtpXAVnXzAMqYi5/fXKHp69CmQWDcchjMbxH0AM85uT5Xamk2fJenuz14NOXAZWEhS3nXuefhayZl1gk+SKDLx7Om8X4h+6pKDL+H/fpNtQgxFW6kDs/wZNw3nTt5OS2ieLxn+c/zEQlbZPvC4PGv4wiCobm2x3Rth7ocgBuPDvsI8l0OFcH9Gd7XCN/Y2JVeb12qFn2uFd0sIce0SasqagGanmlJU+82ZEXl/+O5jgTbiIiaDvvzKXSlPjJSEMUiubxAr9UNv9+7ucpEhrNd8W256VDpfXv7rnL4QdBnsMgofem4+JzYmW8jeTKiA35s4p6DGsTDJamDbMNzGZHDgoL77BeBChA7j2+U16o6fF9XC+UrAeUgBlGpk+DULTAQ0g9vQyjpXuH6+Q46ZheIx45igzMWdp3EKmOck5rqKw9fXhWvtw2eZlbYeP7ct78Q+ZpG26WebTG31yNvdrGTJgbnj+UNiduClcyng2iYH/WKdefHcNlNaxPj2mUg8bOYf23qo1gxtsrRg0TbM8v9STRmWqgYZJUz12qcFBwgQiipYV3RzxHoQLg1E55sJOakKDn8XPty0Wlo8NsDeOdS/N93EudvNtK7zpBV5YzHbq0uVGsUA2ZnWc5dIC48wglQHWyPqVKSWE9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(53546011)(52116002)(6506007)(6512007)(316002)(41300700001)(26005)(2616005)(8936002)(44832011)(2906002)(5660300002)(6486002)(54906003)(86362001)(31686004)(36756003)(6916009)(31696002)(186003)(83380400001)(478600001)(66476007)(38350700002)(4326008)(8676002)(66556008)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGV6NkU3Rk1qalBpUXdUZmdCS1Y0T1N3TFdDU2x0VDBkTGI3Z3JlZUUycU1O?=
 =?utf-8?B?Y2dwK0czc1VtQUVqRnNlM2t4ck44L0VEVDF2RHBObGZSdlZZKzJuNTBaK24z?=
 =?utf-8?B?eXMyYTJxRUhjQjZPU3Q0ZWZXV0F1Nk9oTXVxMEpNckl3MWQ0V0h2ODJPS1Rn?=
 =?utf-8?B?bGNNcENiU05ZRkVRSnphcXhVUEZnZDdWRDBSNGx2NW1rUThwRFFnVkdkY2ZM?=
 =?utf-8?B?NjlvTG1SL0w1VTA3QlRsRnIwMkd6MFpUNndxUjhSTnVwZ1JucVZlK3ppYzJw?=
 =?utf-8?B?TU10dUIwbUltSDhybDNzZThrSmVIY3ArTGhCWkVsMHVCak5kTWFWelRiQm9y?=
 =?utf-8?B?a2RudVFSVmFONDgyeHpFc1ducXdocStEUlFObng5Q1dvYmh3VkJOZ0UyeE55?=
 =?utf-8?B?VURFanlsWkQ2UXdwYlNJYjgrbUtpZWkzTDIrTXZWOVlyeldMdU9IWU1tRXVR?=
 =?utf-8?B?OGViVUlxdzRDdjlqUllWczBTVW5LU3ZHVi93Unl2eUhrUFFPcWpEYzZTN1Q1?=
 =?utf-8?B?a1ZiRUFNckxsNktPUmtpY2ZSc0hXT1pGTEtFaXdBM0FWYU12MEpMVDF6dzlu?=
 =?utf-8?B?Y1JWdEY1cWQ4ckFFS0xTTTladWFxcW1RWWxoZ2x1M2ZaWHZNTjRSa2V4T2Nm?=
 =?utf-8?B?c0grVGUydGRDa1lVSjFpVkp6RzIxcGsyak9VbzhzYzhwV3BhTG1lSzA5K2F3?=
 =?utf-8?B?cGFuV3FQVWovTkNBNnJNdFVGLzVONmw1M3k2ODN6dXJ0MDRPM1hvRDZvODRM?=
 =?utf-8?B?cDRnM3VISXpESFE4Y3NGZlVGVVlSSVkzb3dDNGJQdTUzZ3hzeW1rcW1MbDVM?=
 =?utf-8?B?NkJGN2pXWU0zZ0FZVXAvVGJSbUMvRU5jRFI4NTBTL3VKNGd1N0E0dmxUUzE5?=
 =?utf-8?B?ek1DdFRwUFVYYTN3c3BJdTZxY1pFVlVjbUptdTkwSUtES1MzVnRmM0UrckZa?=
 =?utf-8?B?UVIrcTlHeHg3MDZOYyt6M2hvR1V5MzFZMlZCNUFpV2E4RSt1eS9zWXZIdTZW?=
 =?utf-8?B?d09FU1ZidjQ1MkJrWCtMdjdqYnc5SmZRdlVUS2lYbFNIV0NZMDJiZ3IxMnI1?=
 =?utf-8?B?YVBzTTdoZUdaUW5JaTU4eDVsZ1NFNUJFUm52V0xjdmlBL1dQeTNTbDZEQ2s5?=
 =?utf-8?B?aDJWbmZjbTdnczJESEt1NjRDejJMNml4WkhYZmNLNWpLbkVDNm00YmVqQ2Fi?=
 =?utf-8?B?N2JkeURWa3RaNU56Y01ONU42dnZ6QzMzUk9lSzZucFF3TExyUUJwRHRSYTRO?=
 =?utf-8?B?NkhMK3FXVDhONWhuMnllRFZvaCsvNXRiaENYYm9JbkFUakR1THh5aHo2SXhn?=
 =?utf-8?B?am1ENzJMRURyMnp6My9TYnFWNko4OGs3TlZlVXc3OFJwQTdtbmRGc0ZPVDZX?=
 =?utf-8?B?WU5nN3BTNTNlcVhhdTNpNlMvUGhhRWRmUkxYcTN5MHI2cFA1S2tRZmhvV05l?=
 =?utf-8?B?VVNIOUl1SmFIY20yelN5RUMrOEtpR3BzNHdNK0RSVy9jKzl5TTRCVGVBYjl2?=
 =?utf-8?B?bHVQbXJYMGEzaGZaVXJPb0NLbmlFZXJTUnRLWmpQc01BUUNrY1NUdzBUYTFU?=
 =?utf-8?B?a0hXblUvRXNWR01ldmF0US9zYU5GbkFvcTdvODByeWRPZlZWZ0JIR0lGMnNj?=
 =?utf-8?B?K09XWjBLZ3NCd2RTTWZySXFzRVdxWWxLYjFNalBLcDlnYlRicERDZ0J0dW0r?=
 =?utf-8?B?TXptVTArOG1XUzdmVHlXV2h3ejRPMlhZOHRKVGNwUkhkeWFJQnhocUFNcnUy?=
 =?utf-8?B?TmJqNkJnQkxHVW9JaVVteDM0SmNrR3lvK0ZiQWlqaWlmY1NJUFZMUElQUW1Y?=
 =?utf-8?B?djhqU2hRNFhqaHhJS1ZhcEh1N2RuMDgyK1lYdVNpS3NOZklOQnBacDFvNHlk?=
 =?utf-8?B?bC8yM3B4dXYzZDV4aDEzcE1NUld1c3ZkMERRWTNJQWJtR0IyNVVGSmxWdGxF?=
 =?utf-8?B?QlNZNnRQdjl5K0lvT1FEaytnR2J4SUxyRWJXNExKelJOaE1uRDcyTDdHYWZp?=
 =?utf-8?B?S2F1Z3NyZzV1UGdYRUhEZFg4N2lxOG5xNW1OTGJrVkdOWFZ4R2JLY2Y5eE5n?=
 =?utf-8?B?emhvcURwR0I1YzFjZFphSDR2ckV4V09wd0Z3bmNCNmFmUGFqSEpTclhlcURV?=
 =?utf-8?B?VThzT2NQdGxXQXllaDAzT0ZnLzBoRnp1Nkdsa0dtazNUSm5hSEtPbVNkTVBm?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d55e37-6d7c-4357-7f0c-08da64ec424e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 16:25:11.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEATIwHRoDH7LSMdEZdkmoY7dxmQPLqS05wwxpGVBbgtC0Gft5ZwR48IeClqMAC0XdeO33u/aXy0oRYF/0HptiA6/M3dscsUx/g7DPGSQNSpTSnEk8VNpr2QBb8I/qC9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
....
>>   /* Size of a PFN in the balloon interface. */
>>   #define VIRTIO_BALLOON_PFN_SHIFT 12
>> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
>>   #define VIRTIO_BALLOON_CMD_ID_STOP	0
>>   #define VIRTIO_BALLOON_CMD_ID_DONE	1
> Did you run checkpatch on this?


Yes, i did.

More than a week passed and i haven't got any feedback. Have i missed 
something ?

Same goes for the patch that restores semantics of vq->broken which 
Jason Wang ack-ed.

-- 

Regards,
Alexander Atanasov

