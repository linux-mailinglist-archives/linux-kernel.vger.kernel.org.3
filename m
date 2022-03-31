Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9A4EE383
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiCaV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiCaV5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:57:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5D30F7A;
        Thu, 31 Mar 2022 14:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O29LOt1hZrdJTB5PGy+9s6aL1zibzwO6kvOaI4DLUA9pVixEpnW6+nvgh7X08Y+OhtXn8BnZVWtLEnWb6LWCkbWQDjK8ID1F9yKQGRhZ/LWHnHW4dZhXVnAB4b6ffc2jQtDWwid9+JRos4wk9vbtyqVmVgggOI0VtK9VG5b/+rvBY/ly44alo4KWsPvrqAI/Yb2GPRI2HHf5y6NUlI7jZC9aN6Mfi7EOfhNSen5/Pepaxc2DA+a4kor6Ij+2LwaA15oyNSuz40To8/rGOQ7I/xN1So9cvqPndxw0KVhpu1mohlLejzTnK0QPh/0+PHX6fic+yJsEUgLWDjRVFcjh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD0y73UmNufwX8bluGhaN2iC2zmitkrP7PW3jksfQFw=;
 b=Y8QL/Q+rRL4UgUEs/YZKrEgzYMhkqVQfCQpfxbz+9L6Ju//gFBRH0piybq2gdtr3NoImOhFupxajXOd5/c62bT569bcJmpf1Or2vNq/QdRkw05T4Us9RsrgxeuIVxNvIM7E1lT1DfQMc/v48w6DT0GFeIRmWSA2lrFW7fhjOgYs+Xo296NlAJZnVYaVMQTH292X7DU63EHlEvQ5iR8NecuDxGGod5zfAx0o/QEdSHC+bs5wW31iejbkTuWN+VVxvrIHLwPoS/1Iv4rRfDWXn1TtsRdn1rIF5lLvC1eeeFmE1PdXDJo/73ohhDg9cxxlsl3RRWhfUgtgmyfj3Tmk7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD0y73UmNufwX8bluGhaN2iC2zmitkrP7PW3jksfQFw=;
 b=O60MoF1y1MLmZwGLk3Ot5rjHJhqaeDYEOkCYvE3v0z19KMo7myMoBP+zVKWAkgMVgHYLkeHUKekN97csGelpa3bSXquws68QOKGDhEmIV1PVZbVv5I8HMDI3x+J0Wa6eoAj8vB0iZgnfp9iJWi13h0VRCdbIhttk6SrXg3YxkRNzVpZL4l77mDVXdLXPFdeU3f9BzeBQ0PUriLjDQEVTM0ITrgpCFuuV/rAhKMLN50NWHyTAzVHB/tW01wmGlxI9r4fDwGJJXXU+GLyIxnJorNw8m4oT1yDpMVdmEPI1TOhn38ZxHKFEY88T3FHcVO4b8IRkZmKThHFZjSsfsGvkBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM5PR12MB1913.namprd12.prod.outlook.com (2603:10b6:3:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 21:55:14 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 21:55:14 +0000
Message-ID: <1d9e2055-ac22-334a-f003-911034ef75f4@nvidia.com>
Date:   Fri, 1 Apr 2022 03:25:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
 <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
 <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
 <44235c65-160c-04c7-294d-16b13d25605c@nvidia.com>
 <bf851834-7812-13f1-a382-1f64078ff2a5@collabora.com>
 <06174428-edb1-6478-1b2c-ede83c4bfa87@nvidia.com>
 <bf8bee92-0d0e-453b-5ff1-1829a4406fd1@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <bf8bee92-0d0e-453b-5ff1-1829a4406fd1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::33) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3141544f-df40-48d4-e697-08da136122c2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1913:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1913A345A3F4B507D79FE786CAE19@DM5PR12MB1913.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5Ua2G/OFq8/0NEU8KMxP3GpQnIV512yMDDr/ihbfx/B3nTCXSPJIYLrWoiVZFYhAfqnGjzHKFOX2dUiBRjEIgwyve/ntr2KBat2wh+G9grceqJdxAwjn21sZp7hM+0MK0eV8Gexg60k/3eObcs2pKB/R9QU36DrGytwb0FHNUp/BqqVVfivJWsl2M+PsndJQ4OVPmnCxIQg1EYFyK9aztpirdZCEpDksa6BUYjwJXl10MtGuj0F4Om4+hn2knS1vM5kH7FL7TuEXL1XgTdIl6LZj+KBFox4F4P1dLwjzQ0vObAQlPW8pxcPCoHIU+UYhcgXPMwLEDYsxK7IE+DKLA1u2qYMn3X5kPw/7Mc/4fzHS5H7LL0NysWG1lZovZz43vr7OauYWFMwjbt3PSZLWR0TchpFfu7gLAVsNp0QqxjCY3EFxhnvpRgKpMlfPrIRvKNGmfPy2uURAw08xO+qUZlI1FaFukiTvdkK5eGUL9a+KW0z6EcjPnHaaLXTquVjDxqS1VVX8OAdE+ZIRv+zKidZAow+LG9b4tjrZaNNsoQ4OVvnCRz3WgJO1Wd3hHuU1RrTtdCuJXhy6eqfaYbIt0vkg+/qIbkB0Pg+aL5oJuggPYI1ibMCnlYrWzSx+8cS5lkm1NTuL0s5JBfYze8DUCy6x/jNz6jn0Ak/z5WippB293NvtoF89doknAtK+hO5RP3IB7y0sLLbmGeVx8nNaMjEAbs0xiZXGWBuotKak+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(110136005)(186003)(26005)(8676002)(6512007)(66556008)(31686004)(6486002)(107886003)(2616005)(36756003)(2906002)(66476007)(66946007)(31696002)(38100700002)(86362001)(5660300002)(6506007)(6666004)(4326008)(8936002)(55236004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdUTW5HZ2VCam1UQWdEYldXSVk3MEhUVFYxVGFEVXB0VWowOXRxTUgvSEtq?=
 =?utf-8?B?OVNGVGNBOUIzd21aN0haU1JxTFhCaFlwL012V3VSVUVVaXdtamhEQ3F3K3hU?=
 =?utf-8?B?T25uQ1FsVmJkNkMvY25jVEc1YThXWUZHTXlaVGNDUE1lVjJjdlAxdGJKcmt0?=
 =?utf-8?B?eWREcE5aWUNXTFBuRmFaOXdTQXpkNWdsZkdIRTZaK0wyYWM2cnVPWGxWamdr?=
 =?utf-8?B?RGFtejZhaXluSXhyTktTSld1K3dzWXBuaE43YkZCVEphRkh6N2FjV0hkWmV6?=
 =?utf-8?B?eDhiVjlBSFE2THExQm5SSnlHUzZGMEN2MHF6c2JOTVMwZ2ZsaGNQeE03SlhV?=
 =?utf-8?B?R2dKOGk4QmwxT2FyUXF1NzVlUkdNRmNaZjNZOXRqakRKM2RUKzF4TGFtZldh?=
 =?utf-8?B?VzUrSU13MENJODBGQVZsT2V2ZldheHJaYkZzUWp5emJSM3VjYWp1Qi9UMFpZ?=
 =?utf-8?B?VFBPdkxBMVlGOVlNYlVNTVRYNXlIdFVnbFQzNG1GOW9TMVUrSVk1VGZmeXJZ?=
 =?utf-8?B?ODBFTzg2VGxrRlgwaXBkY1JuRzlsRjBrMUVzbDFGSjFxVkk3WU83U3JJeDdh?=
 =?utf-8?B?b0FHQ1JLb3h6MVl2bkdSU2svUjk5UzFHQ0d4N3RPM3dVUTdoQloxdHVYZnF0?=
 =?utf-8?B?N093ZVUxaisyODgxbnpIdTYxWXE4bm9BQThBOUtZS3VrMkNmUVdYdTBYM21q?=
 =?utf-8?B?S3JFRXc1TWRFb2s3T0lZTWdUS05zL1VYc0E1dktSeE92TXoyRTVNUXNzMlJy?=
 =?utf-8?B?QkFScTNhUGtJeHVWM0FYRWcwc1lnelJzOXZVcyswVkZ3Q1JLaTlBaENreExl?=
 =?utf-8?B?NjIyQVlkMVM5R1owQ3I0WFVkc3Rrc0dlVVp4ME9WOEwvdlAyTnc4VUx3YzI5?=
 =?utf-8?B?SE85ckZlWVNtdzQ4V3ZSVzVGcENVOHF0TE1PMlNWUFF0RkRWajdUMndQNmFS?=
 =?utf-8?B?bmhZczZwcFBxRDZzdnowZWNqNlVuOHBaZUJXSkI4Z3VzdGpqQ3hNRjZ1M2g3?=
 =?utf-8?B?QVBvTk9tOEUwd2phTll6UUJEMHVFYmhIOWt3UUhrbkJZRFJUbS95cVlGRVhu?=
 =?utf-8?B?NC9Vcnd2SS9NTlVxSXJrSlEybnplTDlCdlZ5QzZJMkxWZXp2ZFpvUHR6NlpN?=
 =?utf-8?B?K3lYczVza1h5QTR2MTNtWTBtWGdEWkNrVERPSnkzWWtoM3RhWXVxeXVLbE5Q?=
 =?utf-8?B?RzRwL1RyQVVZcHBCNG9rZGdsRzJ6UVZsamFMaHRNaVgrd0pxSG1jL1pBMjdj?=
 =?utf-8?B?Mnc1RjFtMXNqNW01dU8wTEU4Ull3T3hmWDlWcVVJY0pwUldKc1RTQmFXZVVw?=
 =?utf-8?B?S2NKVnV1N3dHVG9vaUpGV2JIekdtc3NmQjkvTGh1VzVvZ2MxckFoVE83bTdy?=
 =?utf-8?B?a3hmVlg2RFFxQjFINWt4VjBxQ0RPOTFsQXZOZllhU1ZMMVBBVjhxM2xXZEVz?=
 =?utf-8?B?MFk3bEtaRXlZc3krbGF3ODA5aDE1c1VVK0RxUjFDaGhUTHB0M0FYV1h1RzVj?=
 =?utf-8?B?RS91TVBLTi9CY1BCaU9IdnhpaUIrZm9lUnc0dThBL0RxUUp3YjZpS0RuNFVE?=
 =?utf-8?B?a2FZdWxLaVdUUzlUNVBITUNHRWdFQm1BWGFiMHZxWmFGNzU0cEFkeFRtbXhv?=
 =?utf-8?B?MDR2cEJmVi80Nk8yS3RyMlV2WXo0djhWc0RCYXNtNVpKWk9NcVByZ3Q4Y3FU?=
 =?utf-8?B?UTJvWXN3YzBnOEdBb25BQ3RYT1lDTWZFS3pYYXJKdGhDVWs5aUN2ei9jVG1y?=
 =?utf-8?B?UHhsRXUxZVJkN1JnZ1RWZXp2ZFVkMlRheWROYVlmaFd2M3RoR1FZQkEwOFBw?=
 =?utf-8?B?SVhqRFNIanQ1OUNPVnNGR0g1dzJOSExjK1dLajA0VlFyWWJ1by9JK1Ruck5L?=
 =?utf-8?B?ZzhtUUEydlllVXVGRUpPY2NzMzdOekZrMC9DUDBadlV0YmtPdk1VZFhTT0Q3?=
 =?utf-8?B?ZnhnL0NuZC9vZk8vS2FPZTBJMFBZNjZ0R0tUZ0pCZytLd0wvQ0FxbG9oTHBT?=
 =?utf-8?B?Ly9rZ213WmVpQXdpeFBkVllrSmtLRU85QUwwSVBKZUE4OXlKc09TQkI1S2Qw?=
 =?utf-8?B?akErUk9KMUM2ZzZ0Qi9YelhFOURXNExiSnJOdVJ1cXdXQVBUSHM1VEVCWVcr?=
 =?utf-8?B?L3B0dU1ZQ0pmOFhvSUZXak81eFVKY0M5VkhNaDYycDUwVlJVM2NkOGJvc1B5?=
 =?utf-8?B?ZWFCOXNVbytqaG1tNWZTbklCUVZwckdDaWxJdVQvV1lkdGYxNmduZTBHb3hK?=
 =?utf-8?B?YzIwTWZwR3BkQWIwRTJSdXduWGllcHlPQ0JjenNiVis5WTlQdFR6TFl6c2NF?=
 =?utf-8?B?RnhzOEIxUXo0ejZ5RU9oS0VCayttd2NiQzZBK2EwRVZFajM4OEFmdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3141544f-df40-48d4-e697-08da136122c2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:55:14.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLvxvoN+TIBzBzTzfB6VFAWng04jlch4M7umFnShTKKu8dLGlwVsAqrFnCSjHPRgVI9mHDYoa/mlot5yDw53Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/2022 1:19 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/30/22 14:22, Ashish Mhetre wrote:
> ...
>>>> If we are to remove this callback then how to handle unknown interrupt
>>>> channel error?
>>>
>>> Create a common helper function that returns ID of the raised channel or
>>> errorno if not bits are set.
>>>
>> So something like this:
>>
>> int status_to_channel(const struct tegra_mc *mc, u32 status,
>>                unsigned int *mc_channel)
>> {
>>      if ((status & mc->soc->ch_intmask) == 0)
>>          return -EINVAL;
>>
>>      *mc_channel = __ffs((status & mc->soc->ch_intmask) >>
>>                   mc->soc->status_reg_chan_shift);
>>
>>      return 0;
>> }
>>
>> Correct?
> 
> Yes
> 
>>>> Also we want to handle interrupts on one channel at a time and then
>>>> clear it from status register. There can be interrupts on multiple
>>>> channel. So multiple bits from status will be set. Hence it will be
>>>> hard to parameterize shift such that it gives appropriate channel.
>>>> So I think current approach is fine. Please correct me if I am wrong
>>>> somewhere.
>>>
>>> You may do the following:
>>>
>>> 1. find the first channel bit set in the status reg
>>> 2. handle that channel
>>> 3. clear only the handled status bit, don't clear the other bits
>>> 4. return from interrupt
>>>
>>> If there are other bits set, then interrupt handler will fire again and
>>> next channel will be handled.
>>
>> For clearing status bit after handling, we can retrieve channel bit by
>> something like this:
>>
>> ch_bit = BIT(*mc_channel) << mc->soc->status_reg_chan_shift;
>>
>> Correct?
> 
> Yes
> 
> Perhaps using FIELD_PREP() and alike helpers could make it look nice in
> the code.

I tried using FIELD_PREP() and FIELD_GET() for our use-case but
compilation is failing because these macros require the mask to be 
compile time constant and our mask "mc->soc->ch_intmask" cannot qualify
to be compile time constant.
