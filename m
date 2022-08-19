Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56959A3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352927AbiHSR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350810AbiHSR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:26:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCE0CB5E8;
        Fri, 19 Aug 2022 09:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQePIey7pb09omJL7ZOCwiucte/yvTCh/FJ2i6s/9JEWlWp1nRMmqqEl++4Sc1e6REW92IYqmT2rr0yEx+Bng+4p+tgbvAEEiRZa3XrVTjUMoZNi+hn5tr13g63P/vKP76zUvfjTh9JffbrkyGLkynS7mabvSYwbIVw7R6Z2ltqmICR8IHQNUQcaI/pYethWSgOkDSiQ2fgSyzSDxjXxC8idAYikxPh4VEcnVqJCwhYaRKoXQFvzgehnwb5/PppoTV0nk15seeeE4iUQ8Zz8IFL1Nh0oTJrNlD/XGuIa9pFhlZWHpDNJPBhdX1HgG2xWLj97vF1zrKc7kwL68zb0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM5zDCSpOIdfoHBySDPMIu8XsMX5TEil5hGXeQrdBMM=;
 b=AFmYNvpV0GG8zgTLGtJ5rKFCQ+oJvj6V8ggYWwRIFcFUb9t7og4ESNx3W9pZWy2MHI6fvwXdnqIO9bbLj3IBkVPEe0hnI3SgmQ+vz4DYKGQCHlY263Q0At1q6eqSEhDmxhcdkDJJHNLOtqU3ZiUC+FylsMWw6DkYhMuV00EnAox0MDBrwnVzrqbnXKYAEL5VaF1vPFw0v8PKBxuzpZfIX36v9fBHHIRG4ohulX8CvQR2/nsgoFHSV2IQ/Gmdi04NvxuBYb9XdDvAEuqg/fuOOioILCE3QPffbKiN/V3Ya2AfWANLE4HNVJI8C0BkGSc3Xm+Z8CGxXZ84pJDgERGvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM5zDCSpOIdfoHBySDPMIu8XsMX5TEil5hGXeQrdBMM=;
 b=wy41KclRk2JhmeosvIWiP0H935Up+jJPj50jZAPe4rvq35kRYVxOLt+c7sunnEdpeCYYQwI+38rxray9iME2Ks8GxA67KCH1teLrNJDJk6Ka7BStwun+bIqw/3tely66CScr3+fnQt57/3rgRhAPCe6do1hmn+5GagAewl3MlXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN6PR1201MB0116.namprd12.prod.outlook.com (2603:10b6:405:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Fri, 19 Aug
 2022 16:43:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 16:43:48 +0000
Message-ID: <40d13998-f6e2-27a3-c83a-cd977e45f02a@amd.com>
Date:   Fri, 19 Aug 2022 11:43:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
Content-Language: en-US
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        Len Brown <lenb@kernel.org>, nouveau@lists.freedesktop.org,
        hdegoede@redhat.com, ddadap@nvidia.com,
        kai.heng.feng@canonical.com, Dell.Client.Kernel@dell.com
References: <20220819142519.5684-1-mario.limonciello@amd.com>
 <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
 <57cf9b61-82f4-f6d4-7f43-c3f94de7aaf3@amd.com>
 <CACO55tuRZOyoo79sgnewETF50Unzm_uksGtaB24Y93pej+2vgA@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CACO55tuRZOyoo79sgnewETF50Unzm_uksGtaB24Y93pej+2vgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24df5bc2-241d-4b2c-9d40-08da8201fd87
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCzmfWd348bDU78yYagXkJ0EqzYNRjywPaRIe02aKlreP7FTqu1z5nNyeX7jrXYk2gVzc305RKzICaf0yFAqJKsEwLiF/ks9JECMtOX3uVqCK5xn4hvO1c6TFp+jj3hlhrzaV0/OsBregsWO/LnbAZR2oB+2LC2HvRhuKC+zOrHV2udKApabAUeUnbbTv8Uc7gYY7djEAxNXLYrsyAzv2xZuSEMQ2IrgmxFLDxo9JH91TortxJXVmM/Biq8UFjQDJHi99ojx9iuRTSpmgFWLz1c0NyFPKBIhpnWQOcXt21FmgfSTa4JCO1vJ3bBNOaLojT594hcM3XjpruHd586BQ7khH8BWQ1QpIQANRUfhWEnng8MHbK4yKB2548fe/H/RHAExljiUsPhgQKVGlXn99OXlULBopGmCIutJ2fglVT4+OqN0PQbPKmOgObqNwYSZQmUq/zdXIDnqWwDchbeoDaLyNoWhoP0M272/tkhN/DcbT5xJAaAMaqizx+63xKjtsHSgLQXDz8afRtTyQBibPo9Zm7aLqFATdjzRJBMC1W498wEmXHogjf7IQzTj92gYlKjj6Jket7KxlYvxUhNrQemjxKtcAcjS/bqUirmM8ESNhHMT8rtZBQndDZUVemAmCmaHm+IWdWwCvIIwfoSODqHT4E2XfM0ICXI9XBnyMKvUPxrOeLbLSW129fUXbxR7WvdGjnwwMO3ZCCw+jJJA6M4OWWXmwtJF5yZnJHeRNwEimIdfWcF9lf++EFXBpJC4pnm7K5Ww54OFnCBG/cvcyiv6d+/+4U5+fPqhS+OfZ5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(38100700002)(83380400001)(2616005)(186003)(2906002)(54906003)(6916009)(31686004)(316002)(66476007)(8936002)(4326008)(66946007)(66556008)(8676002)(36756003)(6506007)(31696002)(86362001)(41300700001)(53546011)(6512007)(6486002)(26005)(7416002)(478600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGp0OTdrdDltc0hVdUdBTFk1azdldUxTVU5CTTFsUk1uYkhWS0w1dXRmZGN6?=
 =?utf-8?B?dWdjc0NCNm9nV2VCcTBMUkZIb3ZmVER0SnQvVFI0OWtKWXdRWVBUOHFKUllp?=
 =?utf-8?B?bWU4RXdtcUJocWtUUDRpZ3dRdk9KMHBuaXZjWFpRdHowRnliK1NTd1dkckFB?=
 =?utf-8?B?VFIzTTloTTNyL05hV2trbjdZWkFBbk9Ba0c1SW4zSWtvcS9BNVhnSTQwYWVr?=
 =?utf-8?B?eWNmd21ES0JaczRhM2NaZVRJRU13MkhCa3NKOU5aais2T1RKZno3Qi9sM0RW?=
 =?utf-8?B?Q1pOK1FpeXVCazlXTVQrQkorVFZsRnpXZ2tsdGJ5ZDdBcmk4L1d6U2Z1dDB5?=
 =?utf-8?B?ektVVVUxTGNuc1labktIR2g4bm1YM3Z5MWZpc0ZVdEU3T3FEemh4SGt6bUdQ?=
 =?utf-8?B?NDhDZ2JaN2lDb0xDSmlSdzdoeVVsYXU1Q3BDS3BLMXZDdkpkVTBVcWxhbzZo?=
 =?utf-8?B?eEhvTk5WQ3BEVzE4UWhVcTlCRDdNZ2Izb2lTcmt1cjhTRUUrMVd6Z0xTWnJE?=
 =?utf-8?B?Tk82elJLYy9LcWxnRFpJcHpxUmRLa3hPVmdBNDZVU2JBRXdrUUNYK3FaK0M0?=
 =?utf-8?B?MEpzQ2l0eVlab0lBVHNrSnhNZ0NJdG4xSi9LZm5VK0dObmFrME42VEtpOTA2?=
 =?utf-8?B?S1VWdTFjZkFTKzJuOHpHTVhDVDFuV1c5THY5VEhDYURTam9renRwSWN5Smcz?=
 =?utf-8?B?WGJGSjd4ZGFQTnVaQyswZEQxY3U0eng5dVJqU3g5T0twNzBwbzlEN2ttQlRr?=
 =?utf-8?B?QUIxOTRlak1IQlBTaTROZVRHUm1DNUo5WnhFSlhWVDFTL1FSdklGSXJGajJy?=
 =?utf-8?B?RTd5SlcxTzVLdDhncWpEcTI4Q1YxTVVWdWtHbER6NHNtdGxWOGJ3U0lCeS9I?=
 =?utf-8?B?akFOQTArTXVRMVA3a0p6bXlRRjNEcFQ0NFdqeGk4YnFhb2x2Mk84bjl5UEI5?=
 =?utf-8?B?cW5tSlFBWkVmbnk3SXc1bElVdXV2QWdQemYxMTRKUVpsWTNLbEp0dmpVRHVu?=
 =?utf-8?B?T0lEUHE1S0xvcHpRUWpTQWlJZmY1NnBrbCtEMTBqVEpsYkc1bEZISVhQM21h?=
 =?utf-8?B?bkw0TTR5TEplT1hpNlJyNkZOVHVFMWlkbTBjSk9ldzN1NS93T29BNHFucnVD?=
 =?utf-8?B?N0xhZ2dnMkRNdjhoa2lnSUwrTEhhdkhaaXBkRDVhRUpBWlR6YVg5c3h3OUps?=
 =?utf-8?B?VEJad2lCL3BGSDNmMy9rbjJ5ZEdJZG85ZFJGMDlCVTJFT3dTa09aWTNiRktt?=
 =?utf-8?B?T2VicThsT2NqUTlJNXRyUTYrTFloTm03aTdsM3R5RGxsbFpoUi9oNTRmcWh4?=
 =?utf-8?B?V3E3Nk4xKzhoYlN6WUNkVFVEc0NyQjhBYlFWZHFsNEhhb1hLVVEwWmVGYTJI?=
 =?utf-8?B?OXpCdU1wZUMzMVB0OWFSYUhvTjNpS3lwUkhkWjhJYnlpZUlBOFNNTU80eW02?=
 =?utf-8?B?dWh3RDBDbFhTdUU0NWc2K1R6SHNCSU9OaDJMWjFoSFFoNmdKYm83UTNkRTE1?=
 =?utf-8?B?WWI1c1RkVVZ0OHV5NUFmY3E3Wm1qRXFpa05mbHRGN1JqNExpOStBajNJamtE?=
 =?utf-8?B?cXNjNVljc0F0Y0Vzdm4wblNXWm9xMFk4ZzUrZTI4aGJIb0hSTTVwcm42STFY?=
 =?utf-8?B?UW03ejhUOGR1enJNY1dXcFN5S2JXdDFuR0dUZFFad0NKbjQyeXpabStGdUhU?=
 =?utf-8?B?YlFLOEp5RnM1ZWpaQUF3ZjR0VzdWWWRPaDVmTFBJOG5INzU2bkFpdlZEMHpQ?=
 =?utf-8?B?VFZWVm1MQnRoVDhtUUpxMDlOeFYrVXN2OWRNYkR2RFVXWXZ3R1VEMG93clA3?=
 =?utf-8?B?eHJkdS9LRzBGV0paaDNzQ1JPUEwxNCtPUzJuZjBmZXd4QlpScHFZQmxmTjJR?=
 =?utf-8?B?SU5wYlhiUllYKzZ2YjE4M0tBdXY5a2QxWlhLSXlzZ24rb1pib1kxN0pZK3hw?=
 =?utf-8?B?NFJQbzlOZFhNTXdQNFZuV1drQnNMVDIxWkNaYzR3aWN4MURjenNvclJVOGhU?=
 =?utf-8?B?WkNFLzJkQW5tUnNXR1E1TVp5RmNPU2NncFV4Ykkwc3NSdDV1WGNUL0lHY3VI?=
 =?utf-8?B?b1ZFUEIzUjM5d2tibGp4WU12d2xRVGp6ZmhySDNyMjR1UyswcWdyMkh3SzFu?=
 =?utf-8?Q?ioBMIYWUW/xaZmq1/MfdrMeg3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24df5bc2-241d-4b2c-9d40-08da8201fd87
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 16:43:48.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T70+9RyVUhlAnAcsKKLjZKlbWp4vzxWd1C9X0hbrhUtClNUyunbWQ/lmJ0X1yMv34H7TJo8jErDAVmqPyGfz8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2022 11:37, Karol Herbst wrote:
> On Fri, Aug 19, 2022 at 6:00 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 8/19/2022 10:44, Karol Herbst wrote:
>>> On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> 3 _OSI strings were introduced in recent years that were intended
>>>> to workaround very specific problems found on specific systems.
>>>>
>>>> The idea was supposed to be that these quirks were only used on
>>>> those systems, but this proved to be a bad assumption.  I've found
>>>> at least one system in the wild where the vendor using the _OSI
>>>> string doesn't match the _OSI string and the neither does the use.
>>>>
>>>> So this brings a good time to review keeping those strings in the kernel.
>>>> There are 3 strings that were introduced:
>>>>
>>>> Linux-Dell-Video
>>>> -> Intended for systems with NVIDIA cards that didn't support RTD3
>>>> Linux-Lenovo-NV-HDMI-Audio
>>>> -> Intended for powering on NVIDIA HDMI device
>>>> Linux-HPI-Hybrid-Graphics
>>>> -> Intended for changing dGPU output
>>>>
>>>> AFAIK the first string is no longer relevant as nouveau now supports
>>>> RTD3.  If that's wrong, this can be changed for the series.
>>>>
>>>
>>> Nouveau always supported RTD3, because that's mainly a kernel feature.
>>> When those were introduced we simply had a bug only hit on a few
>>> systems. And instead of helping us to debug this, this workaround was
>>> added :( We were not even asked about this.
>>
>> My apologies, I was certainly part of the impetus for this W/A in the
>> first place while I was at my previous employer.  Your comment
>> re-affirms to me that at least the first patch is correct.
>>
> 
> Yeah, no worries. I just hope that people in the future will
> communicate such things.
> 
> Anyway, there are a few issues with the runpm stuff left, and looking
> at what nvidia does in their open driver makes me wonder if we might
> need a bigger overhaul of runpm. They do apply bridge/host controller
> specific workarounds and I suspect some of them are related here as
> the workaround I came up with in nouveau can be seen in 434fdb51513bf.

But this overhaul shouldn't gate removing this _OSI string, or you think 
it should?

> 
> But also having access to documentation/specification from what Nvidia
> is doing would be quite helpful. We know that on some really new AMD
> systems we run into new issues and this needs some investigation. I
> simply don't access to any laptops where this problem can be seen.
> 

Do you mean there are specifically remaining issues on AMD APU + NVIDIA 
dGPU systems?  Any public bugs by chance?

Depending on what these are I'm happy to try to help with at least 
access.  If we have them maybe we can try to make the right connections 
to get some hardware to you, or at least remotely access it.

>>>
>>> I am a bit curious about the other two though as I am not even sure
>>> they are needed at all as we put other work arounds in place. @Lyude
>>> Paul might know more about these.
>>>
>>
>> If the other two really aren't needed anymore, then yeah we should just
>> tear all 3 out.  If that's the direction we go, I would appreciate some
>> commit IDs to reference in the commit message for tearing them out so
>> that if they end up backporting to stable we know how far they should go.
>>
> 

