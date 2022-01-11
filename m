Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469CF48A701
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiAKFKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:10:48 -0500
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:63298
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229436AbiAKFKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:10:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIm2+c8dIARPJVCK9nuCvmr87Heh3bzFOGqUSGeEooehs/4SwkAHrsYXj1+Yylc6B9w0CG+c7hX34Z9dOjHxt77cuvxI7vcCD/e3aFCYpPi5WQEncBS0rsZ9FJm++DJYzaLK35urAzvcXGDxPoTjYRUXm6QeDzU/5APe3BHPccR/jJIXJAmcN4xfPtVRw/WGdgxWCeJaQhVoznLuSjJjpU1tO156zi9dvzMaATGTiYMa80BTs45mfFxOvpePcfJoF8sLiIOS1fBV2KIWKONwRIb7Wm1iLhGuewg6XWesQuKgc43daKZ6UcVHMjHGA3tHwFKWQAhyqKN3YO4Tccj5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuwA4KAk7rP+y7zSZeIwPPHUIGo8/nFzxYoQs/qbxy4=;
 b=NYc5JtScCg9BH6PaO6oECYFzD7i2yIrhSFDJbCBz4ST60q0nExhqY3ntNc72WBd+mU10ZUcYgnMPSHLs8rvPwaUv68AvXexQWD/JnsVDVqwzOE4nue+9Kybn74oV7HR+VWdPxLGgzlgULhCTfmWYs83A3NRj2Uck3On2RiITfmfWH336X3A3JTqm9KnikZJX9Imk7JbcJGraRm9rLNtLWRgAmg74sqwkYszuVoAPzd1Yqo/omh3RTwqMOcBqqdMLOTPHSWyYDbhYMzhMQI3JwJYV8wy19udUSxnL9q+e5AXKPeJR81/JEnNKAI28Aq6I59cJdBH7Pt5CYD6FZTXTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuwA4KAk7rP+y7zSZeIwPPHUIGo8/nFzxYoQs/qbxy4=;
 b=Yw+cL1d1k3cLcuyEjBfH7LfBJZX5m2ACGI2zGq8O12ZGeqZZRzjlOo4SWUzrLIGCJcBHTBP2Jy+82le6jeacBEwB/AwVSVOC87cZCSf5j4QRIQoF89R/3ZiyoPDvGjFoSOSQAnZJmjOxTewOB91cFDg+4gj+P3/KXr5p8HYe8GASx1LFllfXO4PrOgcng2KcBfgBxFqqLPLmiMKB89C1/EG6e+1Efp7gYbAzVhyz3BkHSMlaMAYt6KMUE7gKrrGo/vL7V1B08vsrik0UuUCVQWyKHV3fjjlpmsr3pdIk0CSjTW1IBAe0UYJC2JrfNUxHJqwb2AwvpneeHR9hNRr9aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3382.namprd12.prod.outlook.com (2603:10b6:a03:a9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 05:10:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:10:45 +0000
Message-ID: <54a8aab9-c7f5-dedc-140f-8d91de1f5cf7@nvidia.com>
Date:   Mon, 10 Jan 2022 21:10:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 11/28] mm: Make compound_pincount always available
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-12-willy@infradead.org>
 <279070af-4ac8-942f-5096-f7f61db9aeb6@nvidia.com>
 <Yd0J3QgwgRadAZyp@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yd0J3QgwgRadAZyp@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90a0693f-ea7f-4c4e-8e56-08d9d4c0b8f2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3382:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33823F107EF1A099C48CE2C2A8519@BYAPR12MB3382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDfhdG2xe9Bv0R/l33Knyj5LE5kycFIu1JOU5mpeFE6bhQ03tiJO0uZLyYv/I1K+wVEtu13lFK4gxof6e7Yc2CH8PFOAT1v0JKvFY4ojuSjTbMgrk6OPIHvRqqkluraftn2sfmbVZS8xvFA7ovCVP+N5diiqWwccVuL+O/hd+TKMEoS5Yh8n9ncWZRJYzRooSaAtU7EL6pTtWS5wKRBHps0P+5hnZaQ1ypdtAZbQelqXTvgAxNLKyc3p6mtjOEy2EV3Fb9iTtOp8H5lYx+tpRR8AQjO4R6y/EOgx3Dwe9P/u341Af0HvHGuO1Gh/ttQvKbnom6ZBQy9yvfk6EZPY946qRVHSkhPxwPYj8KX1dG2hWO4ZgPYYnqeMHRYXzx5zwaIRHY650TnMceqywShc9AwWEzKxmi1tSnOvRMAh8KEUn0O2I2fLmHmcJu5atsBXFZqrknjmANJbWTVkmlnLEsi4GOzdaJgHTn7Q/WawobEfTOF+zAMnyL1SHSaZ+xBdl6qGn2BrJznn9i6Fna/uLZvKdVTGmGijFxlp3DQmgRLgt/ySaHoU5dnTrGAMLfKsqsZtVc76/3DiFX04QmiowfnIAETnBu66KfXAeEZTBFBIsH7gCaZYdXNgk/wyAdt7Man0liaWXr6IE3s2Mh54O//G3VPutjKvl/W1YfqiklGgkU3ai8z3os2W9qe1EdWcUF3m/LjGRSSDea88YyiEFt6l/6udpB1ClJ5DV4yQFzjxx7SvsLATl+9/wjpzvOoe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(31696002)(36756003)(31686004)(2906002)(83380400001)(186003)(5660300002)(2616005)(66946007)(26005)(66476007)(38100700002)(8936002)(86362001)(508600001)(53546011)(316002)(66556008)(6512007)(6916009)(6506007)(4326008)(8676002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENjbnNraDZNNFY5aVlXNnAwOWpBa0ZVa3c4K0cvTUxFMTNwSERCVmUyTm5x?=
 =?utf-8?B?SEd1WUdMVUtha2pmWEE0ZlBrRGxBZTBLZ2JkMTBIK24xTUVTWEp2MzdrcTBi?=
 =?utf-8?B?WEVxRFM1OUI0NnNlRHl3SkZ2bjY0SFhydkI2akFTUGhsMlFFaVdCbVVjS00w?=
 =?utf-8?B?YTdXRUFzN2ZNeEthNkM4MHJ0ejhjcVRseFFQWUlxNjVrdjNMR0xCSUlzVkdl?=
 =?utf-8?B?WmRaL3J5OUpWNUNocU9JOEdhU3p2RUYrdHNxM0R6cjVoVERKTzNrQWFkVnNG?=
 =?utf-8?B?eEhNaGZvT09jUy9POVFReVlUWnNxWUFUU1FYamlIdy9OWk1IbjdPVTNrbHZ3?=
 =?utf-8?B?RVd3L2t4bGxFcFV3R0NNOURzVFBuQTZvclVpTFRUQTBhUUVSdTRPTDQ5ZGdt?=
 =?utf-8?B?ZUViZWlKUVdmQUhlNCtoZFNuaEdQN1lGTXdNUjVYWlR0a1VTSWwyWkdkRWh5?=
 =?utf-8?B?K24zcG40N0JmRVBSMmovazhLWWYxcVUwTExMdXVKbTgvVmtqcnZyOUM1NHFq?=
 =?utf-8?B?UGNEUTNkMjI0R2tkYk1iYktWd09VSmxJcysrUHpFUFM5cEZqaGdpQ1VaYlhF?=
 =?utf-8?B?blhuQ3NwUVF5WVJhR1FJR2pBa0RsY0hUcmdkZWpkNW5oeUY0b291cVBoekJO?=
 =?utf-8?B?YjNlYVBraC9YTWFLNXBwU2piSzVaQjZiTjAzWG5hVFhIVjVYd0RHZS9ITmQx?=
 =?utf-8?B?Ri8zVFVEU1JiUlZ3TXpBK1V5bzJLMEZDSVVMbmR5TVZZV2VpYk12Tm5wMEtR?=
 =?utf-8?B?WVBHaEhpSmlMbHRqK1h5NWEvaHEvcU92RXlobnlIWDhxR21KTm9YOWhqTVdU?=
 =?utf-8?B?YzVwbGlrUkcrS1lBMHZFZVZRRS82Q0pvMHFlNW54MGVDaG9uQk1ZRUNHUUFw?=
 =?utf-8?B?bjFFTTZqMVh2UHgvM2lqMWdta3BzQ2ZyaWpKNzJ0UzB2ekFKVEIzcVJzM0dT?=
 =?utf-8?B?SkhuZG9OMFhtYWtWSCtqbjVqMzg3c0M0bDNUV2h4QjFFZTZKNythVUZ0VkJ0?=
 =?utf-8?B?NjQ1TzZvMzdSMU1PeTc2bHVwSUxGS0gwV1BieDdNZTdDcEU5Q3JDS2lIaGJl?=
 =?utf-8?B?UVpQSmlGZ2NnaW5xVExIL2tpU2VRcHB0Nzgrdm45T2RXcHkzY3FWOEtEQWVx?=
 =?utf-8?B?OWtSSGFaa2tPRHZodm9NVDRVVkhLMndmKzcvNUtqNW1YYjZIU2d1UzcvbHV0?=
 =?utf-8?B?R20rQ0lieHkrcUJGdVptZUkxdnVja1ZmT3RYSHpDTDhCaC84WE1Jc21yeDlK?=
 =?utf-8?B?NXNMcnZ4UWNRbldvV3hIdnFBQVJsQ3E1aE5sTWpySjZYc0ozbmxlRENNa21Q?=
 =?utf-8?B?K0k5aThWcnhTQ3RacUFBaXBKQzVrWVFXSEZYVjczYU5OalpwVDVSV2FieVdU?=
 =?utf-8?B?SEVMUTkxNzcrZTlKUkJUM0NOYlZnM3dyZ0pER0ZEcC9HNDNFQ0p4S2s2YTZY?=
 =?utf-8?B?emdDaTM3c2tNL2lDekxqMTZScXVnSVpMb1BUY21iY2QxZ2tSQWxkM201S3FX?=
 =?utf-8?B?K016eWQzUDc0YXZvNDVJOTBFYUM3a1ZHSll6dWFuL2kxM2lLMG1UNXlsalNY?=
 =?utf-8?B?VEV3YnlrZ21kc0dydlZNYzN6SGs3blBnZXRhdkV2OFhWY1hKK1J0YTZveDZm?=
 =?utf-8?B?aEZPY0w2VDZVSkJTb2JGR1RITVlYTTJyY1BpcnpVTEFWQzBlMWFHZGdHck5F?=
 =?utf-8?B?bmYyRkpVQXZSV0xlVU9NQVVvR0xuaHkyVFFKMlloMFJxeTJJdFl1UWRWcUsx?=
 =?utf-8?B?eGVWUWZLT1Vma2FOZUFLMGhab1RnMTFDVmdxTDQzdVd6UzVuME9sNHhKZkRL?=
 =?utf-8?B?c1Btakowb2liUGVPNWJURVpNOU9YYjBkNHpHM3NFZ1EvSHpWbzhDWG1zWEVi?=
 =?utf-8?B?eTR0MlJJZG0ybmhPcXBySXA4QlZScnQ5NHkwNGViWHBVdXZ1UzdQT1pmalBS?=
 =?utf-8?B?R25yWVpYU1A4WlJsOWJ4cWNneVZMMWw5VXZzNFBTUU5EYllDNk5hWVdQZHJN?=
 =?utf-8?B?RUpoWmxZRTFxSzJMTUJzWFhJbjdxeG1JVm9wYlFWTDhOUFdQSEdURU9Mbmt5?=
 =?utf-8?B?RnJwT2VGbHd2RldLMHlmdXI5NjhNRW1QS1cvcVkzRDBXeVB5eDJlZC9seE9s?=
 =?utf-8?B?cEFQdlQ1aE9Ob1kzcVNxZUlVb2RhQ2tXMzk5MTlvV0lKR0JDV08vQ1YyYUg1?=
 =?utf-8?Q?yv8ZJ4NUZBpE13qsCyXO7X0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a0693f-ea7f-4c4e-8e56-08d9d4c0b8f2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:10:45.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A+RRpGVeonbQi7NnPA/+shIA/oiZtHwKDREWvFPCuuXJvJWlEmQuZJXJvvOR0WlA9H6cF45CWmrSgzRtXWODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 20:38, Matthew Wilcox wrote:
> On Mon, Jan 10, 2022 at 08:06:54PM -0800, John Hubbard wrote:
>>> +#ifdef CONFIG_64BIT
>>>    	return page[1].compound_nr;
>>> +#else
>>> +	return 1UL << compound_order(page);
>>> +#endif
>>
>> Now that you are highlighting this, I have this persistent feeling (not
>> yet confirmed by any testing) that compound_nr is a micro-optimization
>> that is actually invisible at runtime--but is now slicing up our code
>> with ifdefs, and using space in a fairly valuable location.
>>
>> Not for this patch or series, but maybe a separate patch or series
>> should just remove the compound_nr field entirely, yes? It is
>> surprising to carry around both compound_order and (1 <<
>> compound_order), right next to each other. It would be different if this
>> were an expensive calculation, but it's just a shift.
>>
>> Maybe testing would prove that that's a bad idea, and maybe someone has
>> already looked into it, but I wanted to point it out.
> 
> It' probably worth looking at the patch which added it ... 1378a5ee451a
> in August 2020.  I didn't provide any performance numbers, but code size
> definitely went down.

I looked at that, and the lore link for the conversation, but failed to learn
anything additional. Of course if you recall that there was in fact a measurable
performance improvement, then as of now, it's recorded somewhere. :)

It's far from clear whether we'll need or want this space in page[1] in the
future anyway, just wanted to poke at it though.

> 
>>> @@ -52,7 +51,7 @@ static int page_pincount_sub(struct page *page, int refs)
>>>    {
>>>    	VM_BUG_ON_PAGE(page != compound_head(page), page);
>>> -	if (hpage_pincount_available(page))
>>> +	if (PageHead(page))
>>
>> OK, so we just verified (via VM_BUG_ON_PAGE(), which is not always active)
>> that this is not a tail page. And so PageHead() effectively means PageCompound().
>>
>> I wonder if it would be better to just use PageCompound() here and in similar
>> cases. Because that's what is logically being checked, after all. It seems
>> slightly more accurate.
> 
> Well PageCompound() is defined as PageHead() || PageTail().  I don't
> think the intent was for people to always ask "Is this a compound page",
> more "This is a good shorthand to replace PageHead() || PageTail()".
> It's kind of moot anyway because this gets replaced with
> folio_test_large() further down the patch series.
> 

OK.

thanks,
-- 
John Hubbard
NVIDIA
