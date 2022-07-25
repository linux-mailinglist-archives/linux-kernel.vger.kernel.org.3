Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4B57FE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiGYL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiGYL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:27:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70107.outbound.protection.outlook.com [40.107.7.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20395BD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/kgGzDK4Kef0ryTDGaRQX6XOCzX/QhBuT/phVUx65YvAiMjXJP3ILhB9dhbE5TlRq/uyj6tcjYxP2o1lNh8pXnb2Wz4cT1Ot6bxkG8XbAdckUpT0r3wMRNGgKSS+8/JFNBA+RvBFhqLdsEW04YYmO+eBOBOCVenM0ZN3FfXQYGc1ZScJzX1e2U5uZMnb5oVf1Xn+ZTs5Ekb5jAd2guqE0NNXBtmdWCTRGKkbs72PYAyjuGUAjxnTxXjzzasuz7TJQPpj2nOv6HckgB/TmO0B5FxHbbeBfE5MsJdKgXZAQkmCjNKTwV3nQmi98poPX9NHwQFAoovlK9e+R+ZcOBr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sywkwqzvuUU7k/kmM8o/TdlsQ+R1XkSLj8eude6asX4=;
 b=gNjEBRxqGRnXOB/1Qj+kipJstMyNXVNbaW03/7PxH+iWok07vuNzS3D3FwJCyQ5nrVjraJpD8MBpHOAgvfJmOz450gFxIc6fyPuEE8Sdzb+sg+edZidK+lmuSJf6fkweEoozrXcGKgzSiuVOVqz7GCZvNOlGp72htZRw5CarHl8XGUrxxZeacFePGm7AKKq3mr8ddyaAoTs3ZMASpic2306B3Ch/AW4g+ySbZU6Qknenw5CmJo/XQdAWnWZwjcVgf7qh5Uu7hJayYmfhghEsqP9JycnizWwuoB92MzR8Bt4NM3s+wICw35ki3SMZf4Ds4gvn6D0c5S+YobVN/HeEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sywkwqzvuUU7k/kmM8o/TdlsQ+R1XkSLj8eude6asX4=;
 b=TPM+u3IllyVvm2cpfLAWbSwrBeAUEuzi1q7BAW4JeY780C5ahz3SiuIPmYYjA9ePN5OczGOTv956lDcpP05zuGmyyN1KWJcYEme5Qkmv1JEL3Y83GQfup7/QUMKULo4Rh+FuXzHNcTla9hNTM1z+OoFDHaY2T9noqtMHgRPYqCqacHyyQ/ACqL2+pZl2thvhVjJmIIrLmyXO/3+riNSFE2LUMIHN2ic9SuqB8T0UUL2mnaGHVM8Q06LqKNwxsXsNowI9uMvQoPEkULC8Rj984i6h8Ab3u6fGBG/rcjF+o6hrKc4q+wkUSI+NAgTF/aBrEQMicAJjUK4qoBuJqN4rsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by VI1PR08MB4175.eurprd08.prod.outlook.com (2603:10a6:803:ea::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 25 Jul
 2022 11:27:50 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 11:27:50 +0000
Message-ID: <865e4da3-94fe-95dc-cbe3-161fa8c2146d@virtuozzo.com>
Date:   Mon, 25 Jul 2022 14:27:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
 <0b660226-28dc-1f1d-e22e-34805dc5b25d@redhat.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <0b660226-28dc-1f1d-e22e-34805dc5b25d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::14) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f9edd9-3c07-46eb-a397-08da6e30b4ed
X-MS-TrafficTypeDiagnostic: VI1PR08MB4175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjbjc5fUvhNioCJvV67XbevngSN/elVBMA/ZP3TEVM4rDCfQx4D7xQfSZkX5KlU+DCto2ScrMcMSSLrpfjSI0sWb9GK/8CpJBRMchXYEyp0SglmptbZeJnZtoLFRVHPmkwIWB7PR9ycpZdZoKvZLKX0/6mznOvidkWaNahuwr0H+sYpio1UHHwhg7iLd1U1kUTJ6xpOqtloXKmxCQ0QY565GKDgglnwMUrXQ0n3tK6qMkq0uEvmDirQ51zE6AB0K0qEsukOO7KT5NV+4ToJlQR7EJ4Wph9BFP69lxdS6p3zOgOTA+16AoKl7+eOSJzE4ky6FNA9AJLvcGiUGuuJFrj9lyQU1FGBZrQlpNcwqr1VT3yLhvngJOaGewXA7ArqkxBOGeEH/3LkVA/BfyoT/MwsIdpZRzyJlJFEk/4UYgAW5eyU3ubHaCdZCwaJpCBBaUGhmW/xpPxjDPG9OJf0Jdr1EnEDyuCOo0yBxOnDBIvkAuXwkPh2G89tjMqmWx7iI3cZ9Wkix4S0I315AezcDtxMs+WgFbQmlzFJyFWptIAsFx+8SLG1bvLtmA4yUEeuuT9AKbtO6XjhlmhzTYi58qz8j8+9HUQbzcrWD/wOIxRXdRNLC6GzkIML26nc8ZbrdbkB8VLWCGXHmVdf1GLmaDZqHBAe6+hzkNGrcC8od0bL5mvtax53KEFQ1UjxP6+Qxl980U27r+mUs6Mb6G84OIrTRdsuQpgd8OVlVSgQMrqKNp6NEVYMkWvDoYDuKcpGMGe2h0qwv3EQF8z5B6wi/KwiazCQKVKPysAuPxnN8BAgOj2LWZocZOtTbIp+NaR5SXyx30+X+m68ps8ZyxX/2ffWsy8wrLylSUNS5cvuMxKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(2616005)(66476007)(6486002)(4326008)(478600001)(6666004)(26005)(41300700001)(38350700002)(110136005)(186003)(2906002)(83380400001)(66556008)(66946007)(316002)(5660300002)(31686004)(8676002)(86362001)(8936002)(6512007)(31696002)(6506007)(38100700002)(52116002)(44832011)(36756003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3M5eWxIaG5CeGVIeUYrNTdVSGZqWkFkK1kvRnpNdTZZMFFNOHNNSEtTMjlr?=
 =?utf-8?B?SHpKY0E4V3U1SmtjMlVvOE5nNmgwdVJLRjFURG1vYWllcXhObjZkY0tLWjYy?=
 =?utf-8?B?UHk2TVhwZ3JZVURPUjFlWWxac3ZCRS82T2tEbzJUWVlEbVZFNVFYYjh4WWt6?=
 =?utf-8?B?eDdQYzAyakJOY2ZycTN4cFY4eTFWNVRmMUlBeWNEWm80Z2tzTjg1cytzQW5I?=
 =?utf-8?B?K084SW5FSG9KMVhERUpucEtDKzcyQW1iY0tlSUk2TWd2Mkk0V1NvMHZQQlZn?=
 =?utf-8?B?ekZ1dzlhd2grazFOWmRCVkI4R0Q1S2dwdXJYaW9pVjF5d0hqMUpJcDFaNmcr?=
 =?utf-8?B?d1dsN3JSRW1JaUlYZ3NiOGw5VmYzY29wNUFkSzYyVGdSOXFQMnpMNnNvZk13?=
 =?utf-8?B?Ri9TblRMekZDQkxtTGZjQVh2TENrdjdRZkNuWnNGTFBpTXVwREJYby9vYUVj?=
 =?utf-8?B?cDA4UzBFYW02cXU1MncxRjdtcFoyaTBVelA5NUhIK2xray9ET1BiRjNmbmdv?=
 =?utf-8?B?OXdmbTR0Vm41Y3dDcFZlNEdyV2krcC9IUms4QUoxNnB2NDVVSjFBcjBpa1h5?=
 =?utf-8?B?dTRLb0pueEZQeFdOellNMnFKNEhxTCtabFE2WGhjUGJvbmZLUmZIMytVQWVX?=
 =?utf-8?B?a2lBUjJid0gwelNiSE1JM1JKcDdpOGxwbmU4SnlZbWlhN3YzOTczUWFRZWxJ?=
 =?utf-8?B?ZHFHeDhYR0VrZEpVOERTVjhQUFNtRjdIMUR3RXJ4Vkxqc1d2bEhuWG96Ukpm?=
 =?utf-8?B?dVZJMnhSdlRvV2tyQlg5SzAwQmMzcDJOVVoxRU5VYlB4eitSMnRNTGJlYnA5?=
 =?utf-8?B?NzlENVdOdXZzcGpGUzBtYnJxU3Jwa3M5azVmM0sxS3JVbXBnNElIZmxORkJz?=
 =?utf-8?B?YmdhUWhmNmRFelowalFZclN0V2FnVnR4SHhOOTJwQ1JZOEthT21EZ2VhQzRM?=
 =?utf-8?B?ejFRcWs3dmRUZGE1a0RMcE9YYjF5QkF3MU1RN1BXT044b0k3YktzOUFnTGFE?=
 =?utf-8?B?UE1FQVh5a1pHODlyd0NqUW1oeUdFNkwxNFp5bkwvR1VLcnpIQ3hIa2dYQUJS?=
 =?utf-8?B?SXI3bFBmbHBXVnptYUszdUw1Vy9NUmZwbXZIQzQ2V1I0ZzVsZTVRTVJUYXJM?=
 =?utf-8?B?ZGNpZlp6TDlhOWFnU1ZpWUpQTUpSQ2Ntckl5bytCaGVQdHhvT2xCbElqRTgw?=
 =?utf-8?B?NGttaHZoeWNGQ25lL25iMnNqUnEweTRFbmxhRFBqbVRrY1gra3RWS011UStK?=
 =?utf-8?B?VE1nSHJPdWlCZ29BTk1FK3NwMEV5amlmVmpVNW1oeWkzSzZrNm05am13c2pI?=
 =?utf-8?B?aXNvaVhVa09EbXJwZGhqSUdQVDJFVGZvR3p5UWhsUXVkUWRwNnlGbDdBSXEr?=
 =?utf-8?B?MWw2MmxrSnVXeDQyK2Z5NHJZUmdTbVNxQ1AvMXhiWWpYV0k4WmdiTEJMVjhU?=
 =?utf-8?B?NzdGSHRYODdiL2tiSmNSd1lFR0lWVjByZzVpS0tCMkVKbnQ3WlNVSmE3RUlo?=
 =?utf-8?B?R2hPZDVGK09TbkVNSDE3NmlMd0h2Nmd6S3JoeG1qM3k3N0d3MGw3eXRLUEtk?=
 =?utf-8?B?K1JYTG1vT0ErZDl5aFV6enZIc3huay8yOFZQaUt1bzJtckZlU0craEdteDg1?=
 =?utf-8?B?WjdyQzZBSGNpS0g1eTkwSzlEYUVZOXVVT1dmUFhYcmZ6anRYVGFzbWdFN3NC?=
 =?utf-8?B?QzlCa2dhOTI1aWtpcnB4Z0c0NHMwQnF6citFbnFmTThCL1hvcE1oN0FYWnl1?=
 =?utf-8?B?Qk1QYWJNVDRmQTEwdGJ5TDdrbzA0Mm9UcmcyZG91Qkc5SjIrTDF0a0grQ3Bw?=
 =?utf-8?B?c0kvTmdITFdSQUlsOGVtdVpQOEhTVlBQQ1UzemNrTFdsN1VEL2ZxQzlINW5p?=
 =?utf-8?B?NTFTYjM1cjU0M3hIMThvS25YRzNmY3B6R0gyUkNpQ2FpKzBhbzd2MnFvVG15?=
 =?utf-8?B?UkJ6MWU1MnBuRjRuTVczazd0cTFlbndUSmoxUTNpT2VHYWlzbENrendOQXV3?=
 =?utf-8?B?R0oxZi8ySEUxRGJ4cngwWURZVmkzTkZjUTQ4NzIyZjJWSm1NdlNHdWY3c1h5?=
 =?utf-8?B?WDJyOTdqL1BPRy9lOEV3dVg5S1J5b04zSERCc29pSktsTWNTcXNPc3IzbGhM?=
 =?utf-8?B?SVhQeERVSHE4cWo2Y0ZNT0pLZnhhSS8rM3MvVDFoWkVFMnJTdktENHc3dndZ?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f9edd9-3c07-46eb-a397-08da6e30b4ed
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 11:27:50.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jAqu47hUZhVXoa5IgSSIOM3iCLld6tUIpJMB+9Pa1OfVkLL1vy8WgNQCBzL6UxMcDIqpan6K8n7V23hpxkNMbHTyJiXFejp3HEbVf2Lo6R+l34t2kMPYH+v8ZtQw8fC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/07/2022 14:35, David Hildenbrand wrote:
> On 14.07.22 15:20, Alexander Atanasov wrote:
>> Allow the guest to know how much it is ballooned by the host.
>> It is useful when debugging out of memory conditions.
>>
>> When host gets back memory from the guest it is accounted
>> as used memory in the guest but the guest have no way to know
>> how much it is actually ballooned.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>>   drivers/virtio/virtio_balloon.c     | 79 +++++++++++++++++++++++++++++
>>   include/uapi/linux/virtio_balloon.h |  1 +
>>   2 files changed, 80 insertions(+)
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
>> V5:
>>   - Made the calculatons work properly for both ways of memory accounting
>>     with or without deflate_on_oom
>>   - dropped comment
>>
[....]
>> +	u32 num_pages, total_pages, current_pages;
>> +	struct sysinfo i;
>> +
>> +	si_meminfo(&i);
>> +
>> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
> Why? Either export all in ordinary page size or in kB. No need to
> over-complicate the interface with a different page size that users
> don't actually care about.
>
> I'd just stick to /proc/meminfo and use kB.

The point is to expose some internal balloon data. Balloon works with 
pages not with kB  and users can easily calculate kB.

>> +
>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>> +
>> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
>> +		total_pages = guest_to_balloon_pages(i.totalram);
>> +		current_pages = guest_to_balloon_pages(i.totalram) - num_pages;
>> +	} else {
>> +		total_pages = guest_to_balloon_pages(i.totalram) +  num_pages;
>> +		current_pages = guest_to_balloon_pages(i.totalram);
>> +	}
>> +
>> +	/* Total Memory for the guest from host */
>> +	seq_printf(f, "%-22s: %u\n", "total_pages", total_pages);
>> +
>> +	/* Current memory for the guest */
>> +	seq_printf(f, "%-22s: %u\n", "current_pages", current_pages);
> The think I detest about that interface (total/current) is that it's
> simply not correct -- because i.totalram for example doesn't include
> things like (similar to MemTotal in /proc/meminfo)
>
> a) crashkernel
> b) early boot allocations (e.g., memmap)
> c) any kind of possible memory (un)hotplug in the future
>
> I'd really suggest to just KIS and not mess with i.totalram.
>
> Exposing how much memory is inflated and some way to identify how that
> memory is accounted in /proc/meminfo should be good enough.
>
> E.g., the output here could simply be
>
> "Inflated: 1024 kB"
> "MemTotalReduced: 1024 kB"
>
> That would even allow in the future for flexibility when it comes to how
> much/what was actually subtracted from MemTotal.


The point of the debug interface is to expose some of the balloon driver 
internals to the guest.

The users of this are user space processes that try to work according to 
the memory pressure and nested virtualization.

I haven't seen one userspace software that expects total ram to change, 
it should be constant with one exception hotplug. But if you do  hotplug 
RAM you know that and you can restart what you need to restart.

So instead of messing with totalram with adding or removing pages /it 
would even be optimization since now it is done page by page/ i suggest 
to just account the inflated memory as used as in the deflate_on_oom 
case now. It is confusing and inconsistent as it is now. How to  explain 
to a vps user why his RAM is constantly changing?

And the file can go just to

inflated: <pages>

ballon_page_size:  4096

or

inflated: kB

I prefer pages because on theory guest and host can different size and 
if at some point guest starts to make requests to the host for pages it 
must somehow know what the host/balloon page is. Since you have all the 
information at one place it is easy to calculate kB. But you can not 
calculate pages from only kB.

Later on when hotplug comes it can add it's own data to the file so it 
can be used to see the amount that is added to the total ram.

It can add

hotplugged: <pages>


What do you think?


>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
>> index ddaa45e723c4..f3ff7c4e5884 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -40,6 +40,7 @@
>>   
>>   /* Size of a PFN in the balloon interface. */
>>   #define VIRTIO_BALLOON_PFN_SHIFT 12
>> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
> We prefer extra spacing
>
>   (1 << VIRTIO_BALLOON_PFN_SHIFT)


Ok, i am working on my  bad habits - thanks! I'll address the style 
issues and variable naming in the next version along with the future 
feedback.

-- 
Regards,
Alexander Atanasov

