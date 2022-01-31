Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01C4A4FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377845AbiAaUB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:01:56 -0500
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:37187
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235449AbiAaUBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:01:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYfsp3AbarO1iaKfj4e77beB49XUXiesmSgPW9ekNFFF4DxfzNCB7EkH8de2i6ksPsYm8fk/uPe8I2IT2+YSZY8qowgVkl/2uwh8CbQjTQ9VjvYA5F/7Ws5riL1JK/UfGj8j06owowhekFsO6G/QXfytVgFQ+56Qc8UaZm5xAo6YexYp3Dq+O3tBlGiHt1uo9b+Ospxa/e85AzNqVvxYu2AVFNzDryq40eF9ddTonb5noBREWBNwR2lv4vqa5SoyblnCqhm+h+XkuSTUHoQtqUmrwfjUOkoqmvybiyyIoYIS52MFzVSWnw5i7uh85/5bmGIbrwe5UunycohgzEmbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih3NzIHi+AP4E0Ho1O8OIWkTVXdfA0WrscFpDCc71I4=;
 b=eMAGOImjK+rcdxKOy8JsFtmUc+iW6y/KNvo/+LsN1C6h0uvfDISa27UhbQ8ytoM06/QMxkORCE7WwQrD+Irzea35xqzMcurHTZhA5h/WL+VttlWqDmH6m6NWh7VNq3UifIZOzq2r91AVNX1ZmgHqAAMexV1sxVL2zmnO4FDoNsVqeX9E8d6WX4YoptBemjQBC08YhBGpwIzDEgIF18/OccTMO9E2FO5BjrEjSfw23zWzu0/bQC1GvPUTN0nk+6P7Dvu+nQWS+qpaFK8Fuiq+yLCwhOF3BXTfRHh1smrY3skFT+tDjNFgWkcjwJINTZJha1LZBE4imM/2ZFz1t+PMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih3NzIHi+AP4E0Ho1O8OIWkTVXdfA0WrscFpDCc71I4=;
 b=mfg3n2r2WX2tFFRNJ5ZDjWmIWgewzME6XR3xI9k5mgiLNeBb0WVc3FMzqwiRD+VgV/3k0qjaRb75V0cdaWHPzihQvRpV3YHxP83dauRt9lCiaxX09yjrbiv6MQrPAiMmzE32gRDsiStQZWCtIXzRtr5bbzq0NvJH8WPWPzbGJSkXzMwmDXdctnBLDdlFFNqcwU5w5iqzfp40nuTHeQRIrf9sWmXm0VzULtFG+GeJX5y4iaRMzDUkjPZiEPT8e+N2PjLj/ebeF0RDFaL/MZqtNp/M1ufPWjkKlaUe6eOGcswgiQEIflqI9TbI+7SSawZfj2rsz55hXjG36gaK+BTQnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 20:01:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 20:01:51 +0000
Message-ID: <37484a02-9e64-ea20-314a-a65759b138d2@nvidia.com>
Date:   Mon, 31 Jan 2022 12:01:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 4/4] mm/gup: remove get_user_pages_locked()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-5-jhubbard@nvidia.com>
 <20220131120557.rwde6sphc245pzu7@quack3.lan>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220131120557.rwde6sphc245pzu7@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3ceefae-4086-4e86-e262-08d9e4f48524
X-MS-TrafficTypeDiagnostic: BYAPR12MB2760:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27603630B406850D470475FDA8259@BYAPR12MB2760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U339mdIEBArjcjY3d0zUEGX3RzUjY9KnlNZF7r8gi3zgg+UPWKgxaxbXgbN1F/xZILedHPWz9j8whEbcg0JA6ufzje3ucB8rK7qJyt8JtIXm/FK8JIZYvlYxMfWHnKYK7YAv/D2B44rW/+pl6XC9iPwUDp3q8YnZNFloRMg2od6pp5X1gU/zVkk5+FtxqVeR706Y/NTHfKTLIlFxLK0aJ6r10txNEDBgOx9YJlMchnYeoBWUFNFgy56euCkilKSFf48lTH4xOicoFALiDHQ1wUWskUqIluJBbcQ/uuE97iQzazT6JuiekUcL7QcX73KWBGcWp8enmd4ZuTdpzIUOZLnxlSXnkx72FWbj4elqdSifsxgm6W/0uZt3tH2VLATQaL2E38uhXMx2EuMP5rC+4EU+urkJRdCJSsWsq9/5o9nNFNnysZ0tHZUSK6uUJj9FSSZCbEi5i98PLDg6mvXNY4aZP2FDwksyhm0Qr1de+wNRTPlY1OXgBpmhUUTEqrgmhoh11HyXLbVLVsb31IiBcQr+OBNaZ+4voDpd9GfQjeeLj6YEZgF7Jtck0OOb2yTkf3lsyGa68F85p0ry+YR27blXJuTD/590YRgC0WPdcNTmnweZGITTBs4Pl2NsGxjeP/amgRGzO2n0kkYbVbJ6GTX4a8+Fy2JT51LPt3V2p/GF7wd7b+qSgdA2NXiOUBg4gUBBKzEYKXcdZLHGL0wAJ7pa7CU3TCi5DIyrGPrlHqjzq4Kx0vSLAHuLJL8Iq/V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66946007)(66556008)(6486002)(508600001)(66476007)(38100700002)(54906003)(83380400001)(316002)(31696002)(36756003)(6916009)(53546011)(6506007)(6512007)(6666004)(86362001)(186003)(7416002)(26005)(2616005)(5660300002)(8676002)(8936002)(4326008)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1wVEtYN2QzbHo3bzQyU2pXYUJuazBkUlM0V2Q2UEI3N2FmRzNpMm9oQ01H?=
 =?utf-8?B?SWF2dWNHeklMcWNNajUzcGw2aWxYRlBIV05taTNONWZweDd1RzZXcUpvdTlO?=
 =?utf-8?B?dVpmSFlGSjR6dGtpdVRBd1ViOWFjY2Vrb3RkNHU3RmFjUElXT1NITy91VGUz?=
 =?utf-8?B?Vkk5dW0zR2pTTUVuT1ROZlJ4OVhoS04rVjhRMmNDeXYrdFc2SC9lRkdvMmc2?=
 =?utf-8?B?MDVmcE9UdDNNek1vVVJTSGRSLzl2NjlGUGlyQnVFNTltMTZveGR4TDFIa3Fj?=
 =?utf-8?B?ZC9nMkxwY3RtbDJ6dSs1ZlRkRjlmWGFOYm1kUXU0MUg3cFB6c3A4VHNJcW5q?=
 =?utf-8?B?UnZGYkduMmNUb0JUYXduaW5Vb3RVNTM1RmFiZVhibGNOK1hVMDJOVXlOTi83?=
 =?utf-8?B?eXkrQ0lMYzZCMG9kL0s1S0lwcEhJRjVObStwa3lLaWJQaGJWellCWHZYZ2tv?=
 =?utf-8?B?a0krQ2liMFR6ejV3Uzhua3JvODNpZEdod2FhSmdrOVN0TUordHppZzVha3h2?=
 =?utf-8?B?SjlDUzROallodHBmVVJ6SWpiWWdzbjhwT1RMRXZpRGZDSmdIcmZtQmhNRWgy?=
 =?utf-8?B?RGVsc1lObDRvdEV0WWVRVTNxVDc0ay84UTJrbnJSdjF4a0VJMzhBdFNzdDAr?=
 =?utf-8?B?NENaV2g0T2RrUXFvTnRSdjRrSWtCYmpyT0pha29nUXhEZUlVUnNaR3JuZTdD?=
 =?utf-8?B?QVRBWDRKMnl1VmpOVmhCZzdlM0hYand3WGVKWGJGWTdjbjNLUjlRT3lnSHRh?=
 =?utf-8?B?R2dCckNQUHg3YUtYcWQrRzBJKzhzUTNKL0Z6eFZ0ejA2LzFVUm5lK2NDZmxj?=
 =?utf-8?B?QkwxZFJCaHI3bDN0N1V2WkhIeHg3SEJLTVdXY0tJOThIN3ZWcElyL1JNTmFp?=
 =?utf-8?B?czl5Ujd0VXZCa1pUSmlqT1A0QW9VenZCaFlRQmwzTWhuQndNL2Nvc1kzM3VI?=
 =?utf-8?B?bVo2VlUvbGViVHRtS25lVTJZdjNEKzFXYy9OTEJqdmprVFRnSnJPaWhPdG9z?=
 =?utf-8?B?b0lVSGpmSk1nSUdWRXJNV2RTY3IxZHhZL2oxRUdsRm9HS0ZlNDl4NWd5SURq?=
 =?utf-8?B?dkNtV1lobFRJQ2Z1R1NnYlZTSzlEb2NEM2FwWExOWFVJZVdzM0xqN0JqRllx?=
 =?utf-8?B?K0RWZWgyL3BRaVJSTFdNeTlpYURUZkZBcW5BblE2eHFSM1RJRWM3VlhVZGNP?=
 =?utf-8?B?YVpJd1FXRVpncHVBenEyOTR5N1VJYk9wSFFWUW9QSHdHYzcyd0RBRU5BdEg2?=
 =?utf-8?B?ZHZPcUtSbkxmbGpveVhmWFc1UzFDL0pBbjBqVlhwTitSeFJYeWNZbG9qNFND?=
 =?utf-8?B?b2pqK1hjRlFDOEROM3Z0UkFsYmcxcVVJSFlEcS8wcDduWVB2SmU0ZEYySFJo?=
 =?utf-8?B?S05OUWhpSks3UlZ0MGV1ZmF3RFRtR3lPN0VMdkRVUWFJeUpDU1hZN1BiMHl6?=
 =?utf-8?B?QXhjM00vZUhRRGJMVUV0aExJS1FGY2NzOWFTK2d3b3BQdXlISWhTdjdTd1pT?=
 =?utf-8?B?SE54REFtYWR2Vzl1N3VsYkhsSENZekdCQUFoM0hGUGlibW1hNDZsazB4K3U5?=
 =?utf-8?B?M2ZSVzNrQXliOTZ6V0N4UFNSWDFRV3lLbG5MZUtDOTlmWExIVmZneXFFcndx?=
 =?utf-8?B?d3AwT1lGd3BTZWh2bXcyRGlsMTNwYjM1TG94NDlxVjJuNHNTc1luRUFhWHNR?=
 =?utf-8?B?emdJaCtGVlFXZjYzYkduVE9aUGJJS1hKKytqSThLOFJQNEtBZjJTRWR2RmFi?=
 =?utf-8?B?amw2MnFoU2U4Yzl2L3FrZWNNUjRrRThVUVlsU3l5dVhVTFpQUmdRbHNyTjVJ?=
 =?utf-8?B?VjNuN0x3ZTFGQ0R6U25IV2ZuZGZHWXh4MTNsc0xZdUR4T2dsQTFRdUtsY21u?=
 =?utf-8?B?bERoZ0prdTBCcXg4anN3clNaZkF0RmtlUW1FdG1zT3N2ZTY2MXdHYUpVZ0lQ?=
 =?utf-8?B?RVNCcW9GeGE1d0JXSldyUzljYzlGUi85bnJiVlkwdXd5cXRJVGpWN1Q2eGUv?=
 =?utf-8?B?RmZOakVsdjVUcEdZZkVKVFN4MXljOW13YVlNSzU0RmNlZVFKVXkwMkV5czNB?=
 =?utf-8?B?bWwyOTlTTWsvTlRoYnQxdGVuU0Y4YkJpbWZoU3FDQWFmRjEzc2FYNER1dDAw?=
 =?utf-8?B?d0V6Qlc5dHZZaTByOHZIVFBrZnVPS2VSZmUzQVg1dis3UjJLU0hnTUZYTXpR?=
 =?utf-8?Q?XnDlVOg5gbP+YPVHJBAZ+tM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ceefae-4086-4e86-e262-08d9e4f48524
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 20:01:50.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrgsQcYK7Xqx+jxn/u2LzUJSxhWK8jlq06ZD+Sh0BZ5LB8w4ArOtOzcdElJNm2sRlYHM1Ek6k6ddLlKKcZz6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 04:05, Jan Kara wrote:
> On Sun 30-01-22 21:17:52, John Hubbard wrote:
>> Unraveling the rat's nest set of APIs in mm/gup.c a bit more.
>> get_user_pages_locked() was not helping at all, so remove it.
>>
>> Also, lookup_node() has only a single caller, but it is still worth
>> having a clearer locking policy there. Changing it so that the caller
>> both takes and releases the mmap_lock, thus leaving lookup_node() with
>> the sole job of translating a virtual address into a numa node ID.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Well, the point of _locked() GUP variants is that we can unlock mmap_sem
> when reading a page from the disk during a page fault (hidden behind
> VM_FAULT_RETRY). So as such _locked() variants are about reducing mmap_sem
> latency rather than code readability.  In this particular case, I don't
> think using _locked() variant in lookup_node() is very beneficial
> (generally I would not expect to take a fault there) but at least a
> justification in the commit message should be different :).
> 
> 								Honza

I'll rewrite this commit description to cover this point properly.
Jason also suggested using gup-fast, which I like.
  thanks,
-- 
John Hubbard
NVIDIA
