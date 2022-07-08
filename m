Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E87156BFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiGHSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiGHSY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:24:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC1823B6;
        Fri,  8 Jul 2022 11:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpzH8oe9iyWhX0ua73nLmATNE/kQxLUOEVqzMiGzqnPQOKhCNGQMYV0DTi0D8MR8T9CiyHEp1RCVKBjH0J9N/m1xLq1CtHmYv+UiaxiHBAcJO4wHWHG6zoWFtV81HTFpSqy3DDWtr03KGlI+xv143KtRmi3p1jNMHKKIOwod3RzQZHsDNpORcBr7a0/SLRA5qSMV+s8XTG6KNhmmfDwy5Y+Cv20xCJgcaD/FWm3KAk49XAgtVthFKnYSgH1W6pV3toAXyMPpwgIUXsi87QhU3lTBNvRrk9cbj25IuRRdHuBAciAIGIIrt5xZgUhMOT9OrjhnGihFvEscRiTzq0pyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHec/yxXRRO8ADfra18bTFs97a+DSlLIhXotM1fcBzM=;
 b=ktY4qJh+JNelJhLZTXb7wlXSlpvsN49nAqCCILIFlP4YylRXPG4DZgstFVdQsTNBk03feSnZAsfW3IlhNzkGMR25LWoURougIv717DeNpE6xlm6evVCX5ZOw148ZHpN5WP+4OfozXAagp5jKyvM5cD0gKC28ZAB2rMMjdn3EgnzpYnKT9TruEzZrktdwk+6Oe49D10evUFvR2CMqQwAGCGaeqHq0ua3FXpGfEvpaWJJYSoEOR6DDmxzlYqRqgIKxHKKIti41CYSBRZdfFU3rDmkZaZjfJvKG12uM3U4LEEuNK6iZ9RHon18xz5ceuy2ZvGbAb9vtJccT6olfNCXyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHec/yxXRRO8ADfra18bTFs97a+DSlLIhXotM1fcBzM=;
 b=NqzksPNi9N1e4/R73JGtjQQWPwlRNh3BN7VjFFUOoOfQoYUctuUNBR6XgpRDDXKLOpVkkW7uNO2ZsbALdr04pdhs707F+WAMoG43HNvEIRJ+6SfvkyQDWzwEuzXRBnNiHurNsxXjJZ7VeSJnIlguGIjDgWll5slVNAJtYgQNyAG2e3F+FgT0BQ5j83F/XRhiLsEVR61MpCrKTXoq1HLUVlWdFltjJAJdiBP2s/EwQd+7YrhMQPqBQf6FU8TrY9iqAs8Tbova5xd1B7cpuEZl2D0xlJvPjKNvnxsAzim4VMSTJiXWocftI0nHKf1tzJp7UpUe9ED4epKaZoBWWecfhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 18:24:54 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 18:24:54 +0000
Message-ID: <424af43a-bcaf-4f59-086d-b1afea425054@nvidia.com>
Date:   Fri, 8 Jul 2022 11:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] gpiolib: cdev: fix null pointer dereference in
 linereq_free()
Content-Language: en-US
To:     Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220706084507.2259415-1-warthog618@gmail.com>
 <20220706085025.GA2259579@sol> <20220707090006.GB57165@sol>
 <CAMRc=Mcqvp4oN_tHXS1cb0AnEOU=Znd4bmSwO4ZZ1GszRfXhSA@mail.gmail.com>
 <20220707102918.GA60169@sol>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220707102918.GA60169@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 475b0c16-ce01-4fd0-07cb-08da610f27ac
X-MS-TrafficTypeDiagnostic: DS0PR12MB6437:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOHQ5MIzwWtQsjGYYWhRSw86DM6H/DR31U8PSkXYF8B+hFKSu0p7fQLZbtEvb8YvT71b66nc3syu5Xa/FiTyZMTZyM/bWnghSuOVKqzL6maBGqLF6/tgXthYjQd0xfXs/GdVwjgtvfRNV/ylMfUTaJ3cwV1b1A3BgW5zmduYq7/b20grWr3b6yVx/09kTCho1xgSQ9jV5E+EFeKTLP71gsmjb1EYpzYJIxPDBAUIx1UFt1hcWJ5LgxCNQO8ASIaIOQM3wc84CRSmm5RwnqL0g5Ta6R0Syz5DDbrdodTygjp8KHEGOmrrqOVkC8a4ZH+5mirEHU6mT07k+t4aFCTNr28Wo8/KyaZATUNzEv3vS8HD4ZuEp6ibC+rqeXW8WenE3Mt5qXikBoG6abVHdjKytARbuQb2TOFEvUv0X59uxDYkijKxWbpT82LajGcWT8S4I2+fTTvm2kt0WwfvJFypyaGIS8cEkLH954HsdE42cXTg26/JpJ7kkDEOH19GmaWT5K1qitJokETlZDhS0x32hEqnaSwTQuXL1p1a5z6WxEp8QhSnAuIMIpKeaAYjLe9oPbh0jZxig/MQ2Kbj9mn1DhkASzkADCi5oZEwH1il4CNKYGdaZtNsbJ20RQNwDwr9r47hc2uTJWDzX0S5rbv65AETCf/0JPjOcRoKzXYI9c53SoCaInl0APl5epJZcTq4byAm8X3sv7W7lnomay/9DoOP+dIOw0uR9juFDmCgScKDS/5iXDc6rvnEaLM+jgiqzczMjT2wmUu3RCrDkrRQblk4ChXFtE7EvFQLTW8RzeOCZDdKn6FBzmyeIcj9AwsVUGHsQPtGfXH85AQbYF6IbM3OLQynr8Nb01LbpYYhonM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(186003)(6666004)(38100700002)(2906002)(110136005)(53546011)(2616005)(54906003)(8936002)(6506007)(86362001)(31696002)(31686004)(316002)(5660300002)(36756003)(4326008)(83380400001)(26005)(6486002)(8676002)(6512007)(478600001)(66946007)(66476007)(41300700001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpuak1WTUwxSjBHeUlyQno0UWsyQ1BQeDRVbWRvZ3ZhRlMyRUx4SFF5MEFn?=
 =?utf-8?B?UncwVVBBNDlDTytFWXVrVW1RcGkzRkZKbnNoeGN6UTJGUXFvQW5yUk1WR05n?=
 =?utf-8?B?S2I5eEdkY0hoZTFQbEtWcm42SDVtandpVlN6b053aVN6T1FESUFBM2hGS1JZ?=
 =?utf-8?B?N3lmaU10NnU0blNYQndQSlJtMnczWEFHRWNxVktnbUVVd2NHa1Bib3ZLZEx6?=
 =?utf-8?B?bWpZdzcvV0UwUlJRalBBSWE4OEdIN2ZRTDhyeEwrOEwyc0psbUhYb3ZVSkt4?=
 =?utf-8?B?bXRMa3N0dlc3ZFZTMzlnbW94NjE5aFRVdEs0ZE9KWUdVaXlBRlc0NHlxSlZF?=
 =?utf-8?B?ay9EQnlGak5FVzlMeHk3QXkxWVBCS0pMVmRUelViT2V2b0dDQzdCSkp0TG1n?=
 =?utf-8?B?M094czRnbXJpTzNFdEp2UlZNbGFQSDZhQnZ3ZEU5TTFKK3NTVHJLbEdBUHJy?=
 =?utf-8?B?WWU1clVPUTBhRmxGVVFtSCtWL3ZmNTVCWEZDOGNxclFxT0k5ZW50MG1HdHBk?=
 =?utf-8?B?dWxETmNmQ09nQ0U1WDgweDNUT3A3RUF1aFFvUlFLWTlTWHRKNUo3VXIrbmky?=
 =?utf-8?B?WWRmdldnZEczRkZWckRielpONWhOWkhRYUZNQ0xDWWRxZ3V4K1pOdmc5Q1ZL?=
 =?utf-8?B?SUtoN0ZFZTQwaXVScjVJdittRjN6cENNeUY4WXNpbDNtek1OZnJMQ3lacEpB?=
 =?utf-8?B?QXhxK0tRbDFPdlpTMzBmaTBxMEFYRHh2RUtld3Z5d0ZPVGVDN3hDSUMxOCs3?=
 =?utf-8?B?aDhyUWp1RDJKam8yQ1FRblpFa0t1RFpZUDF2T0FUMlhxS1huZS8wcDFzeWNy?=
 =?utf-8?B?RmFZbW13SWxGbnh1R1VVYnlENVAzUStmNktmL1prTHJwdXdFMHFWbk5aK2x1?=
 =?utf-8?B?Yk9tekhvcUlRQ2VSY2dmcXdGVXc2R2EvNnNOWGtNWURHNEZoQUtCcFJHOFFX?=
 =?utf-8?B?a3VRSWNYdkdpOVBhblBCSXRBdnZHZm9NNFVRYVc5ZktmUnQ2amMwNUtqY2VK?=
 =?utf-8?B?NDBBUmd5cGpYYWg0UTF6U1BkcDd2emdXOEs2amNpQlROWEp3S1BVbUlsVUp2?=
 =?utf-8?B?MjAxM0RHSmhnV1ZOMm9uY2pKdlh6QUpvaGdnMzN0b2hnRVMzQUwxODl4aFRR?=
 =?utf-8?B?c1BYTi9KZUtjT2U3Zi9CVHNJdEw1UTVHSktvUmM3RElvUG9GTmZvZURSaGdS?=
 =?utf-8?B?VlZkVDd6U1NLU21zMnlNbGRlT25YK2pKMUNiUEdHalRnR1BqSXZIZXBGS2N6?=
 =?utf-8?B?TXhZZ3RleEU4ZjduTEJ2Ly9RdzFGZXdlS2hPc1BFTit1eGxLbFpjYWUxSzN6?=
 =?utf-8?B?a3g1K05IeDg0QzJpYStPV3BlMThMRWdycnNtZWljaDRQM3FFYTFlUVV0RzR1?=
 =?utf-8?B?Z1gxR2tRemhZUlF0azViNGpSRlhWUGlBVXZFd2F5NDdhSjlXSWxaQTlrb0FC?=
 =?utf-8?B?dGFKd2t2Wk9PR1pqb2xCRFlHZk9ZdkhlbW5acit2NFh0YVNFWmMvY0FtYmE2?=
 =?utf-8?B?Wm9pQzA5ZTZ2YWFFdEpqZlRwNUg4aTBsYTRtTkE3NlVoUXlualdwTTZNdFNI?=
 =?utf-8?B?TmFWNmZWRFYvKytCcGJpK3h2UXNkUmFpQnA0TTBETHM0NlVwR3U5YTNKYWNn?=
 =?utf-8?B?UHRXMnYyY05nRXFSUHlORmJTOXArSDJQbFYvd01JQVJWTXRqQUdZOFl5dzI0?=
 =?utf-8?B?c1RBc2FqRmh2RjlQbHNpcDJxMGdrVEMzT2R1RTlzM3doeXZzblhrU0tuUWZn?=
 =?utf-8?B?TlBRNVpGb1NFY1BUd0o3QjNQSzY2UXVzYm9TSWd4OFBiSGRvMFpaUG9xOStK?=
 =?utf-8?B?cC81VVBhcFFHNUxnWTh6emxZeTNCUDhZRnBsRitjUWdEMWRxV3dXaDZoUVpt?=
 =?utf-8?B?clZ3WXBLV1VRbU16eVNXTG5yLzdYUjRZNVIrUmFhRXNGSGNRSFlNUFQzNXlm?=
 =?utf-8?B?ZXBEQldXcU9ORkVCYmt1U2JVa0xnUkJhT3VhejdEM21xVm01VDA0bDRIK3R1?=
 =?utf-8?B?eHpLU3ZXZzFYM2tMM0g5WUlYYi9OVWVSTksvOURScmxrbWhBQngzNzd5eGZh?=
 =?utf-8?B?R0ZxY3JFMW1kMVMrY1g5RWlSeEhlbmR6bWtUU0pkc0ZDNm90WDBvaVM1aENI?=
 =?utf-8?Q?w4enqWQukngo1pC9ECDSzs0Ct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b0c16-ce01-4fd0-07cb-08da610f27ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 18:24:54.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou7wx1m4kamC1/5+hx+cN34MxnQDkXAzOx+nzC1GTsnSzqTrHsia2/0UAjM0n1gBFhYRKK50nx/2Zqjq3znG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 3:29 AM, Kent Gibson wrote:
> On Thu, Jul 07, 2022 at 12:19:15PM +0200, Bartosz Golaszewski wrote:
>> On Thu, Jul 7, 2022 at 11:00 AM Kent Gibson <warthog618@gmail.com> wrote:
>>> On Wed, Jul 06, 2022 at 04:50:25PM +0800, Kent Gibson wrote:
>>>> On Wed, Jul 06, 2022 at 04:45:07PM +0800, Kent Gibson wrote:
>>>>> This patch fixes a kernel NULL pointer dereference that is reported by
>>>>> gpio kselftests.
>>>>>
>>>> Should be:
>>>>
>>>> Fix a kernel NULL pointer dereference reported by gpio kselftests.
>>>>
>>>> Sorry - I rushed this one a bit.
>>>>
>>> And I might not've been totally clear, but this bug is present in
>>> v5.19-rc1 onwards (when HTE was added), up to and including rc5.
>>>
>>> Would be good to get it fixed before v5.19 goes out the door.
>>>
>>> Cheers,
>>> Kent.
>> Yep, figured that out. Applied and fixed the commit message, thanks!
>>
> Good to hear.  I never got around to reviewing that final HTE patch
> and, while it did end up pretty close to what I expected, there are a
> few things that I would've done slightly differently that I'd like to
> tidy up.
I can create another thread to address this. Let me know.
> And also have the HTE specific code compiled out unless CONFIG_HTE is
> selected, as that is very likely to be the case for most builds.
> But that can wait for v5.20.

I am assuming #ifdef CONFIG_HTE blocks around HTE blocks. I think Linus W. also

indicated that.

>
> Cheers,
> Kent.
>

