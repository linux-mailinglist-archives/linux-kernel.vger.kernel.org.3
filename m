Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502EF4F8648
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbiDGRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiDGRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:35:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF6136C0B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O66Kv8wL/RRQkrKEveaSpo+ovmqXrk/pslYuYUzSjcxtrUCllC957faytgyY1TmnyCxitubyFCGnG+6Emz5B8vHohVKp+FmS8gbfn9TbUzZpzzqfwulXko5qZx85+utYqkqD7camxhsEbc66YTaVlZOUCIqyvsDm0CmYGXTbMyAyVrnG9Arouoe6W7JROugqZ7fni4E6J/DkTSmavRAE2E4LWz6cSXmYCAObQ0HzqUl1nwmH1k4LKfyAPgUDzynu+V742Sc2PQjpbI4ffWDJOdJKBthNoQB5cX3Ei1oa4k43YXpC9gFw9tdJOWAKeH+TE6zPvS51L9zPq2I+seK3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psTV8UDmIIQ/dhmqIx275DEGLgzfEScYAbFFbfFUcEQ=;
 b=ltq/6gjWPtoGOpeH6E6eL0zf2BVOkmqHY4svQ9UEMYbPC/Fe0q5Vuwsy0brZjhOZ+hcximhWXqokoDTVkfDYkOpDsOeTAcgXE2SZww7QiCyN/0yNkLI89RoOeew/YR5DJLaTH+CJxZ7KTnBohqMttPppIwI2ktgwFOHkcS6XTSMLxp9xHFlySAFzIku5p4mznifxAhCG9pg04MUYmtQSbKOL1ICJ74AaLyb3HUB5lFrMwvU92aSOe6UPfdz9YVkFDMYIB5oFn9Fgzs5s2+K4i5uinZXJTJw8igL4i1VkOwXGUuF33HZnF8tPMR8MLsL7RqcHZHaGPM9TGQLNca+qwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psTV8UDmIIQ/dhmqIx275DEGLgzfEScYAbFFbfFUcEQ=;
 b=tbp2MEWyYaq4ZCpFGQN4gUkNy3STdXeROLLzOviMaZsplSP7vGuuMZHBB3I4qphdi9yauxNyWaQYnzmnfeQnlOErDvkoP4Znjt/14yl+B4oVgHwm7Z/ZeCl+Q2qO5oUIMFVjaNkHOka5ajtT2oHQGBZDqYEJRxxLrodpEWAEqFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Thu, 7 Apr
 2022 17:32:43 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::61e4:a6bf:9444:31f9]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::61e4:a6bf:9444:31f9%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 17:32:43 +0000
Message-ID: <aac9a178-e58c-60c7-a9b5-56ce219d051c@amd.com>
Date:   Thu, 7 Apr 2022 13:32:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/display: Fix indenting mistakes in
 dcn10_hw_sequencer.c
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1649311250-17077-1-git-send-email-baihaowen@meizu.com>
 <bb7635cf-461e-7abd-6092-4be67099c846@amd.com>
 <CADnq5_Ogke7XuVsQaB8pskreXam1ASTE2jna=U6iuKuuyR4r-Q@mail.gmail.com>
 <CADnq5_Phw7SvfdtX_RN7N4xEzceYpZLvRv971y3YyOdrg5Lz_w@mail.gmail.com>
From:   Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_Phw7SvfdtX_RN7N4xEzceYpZLvRv971y3YyOdrg5Lz_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b2aa82-64b7-4ba6-a25f-08da18bc9f50
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190AA6BDC3ADE148DF928A98CE69@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBznqBjHdBjPU/vHoFG0DfWWCMgkXkhBxgkMLMc6kUF/qjiHEIdlOIxdqxxcXCzDYzSPa1Krzrf8tiabH+/XMVmzVuU7FqErCQt9WWU6hONH7LK9x+vkYq9FpYloEzG0evcgV9RpJ//lyqUc4bjS6zQXnZFL3p9ooXL9sk4/f7akRbJMcelLJ72fehLCzUsdQYMqOJ3n9GDsEduYoUuqLPRTlttxflHtGgQHiviAQRjBOaw206p8l580M+kKt94xYL4zUdHN9QbTdxjrwVpGIrze1cAI0bpjBXSHPDOFOc5dJeE28CXq3zA5GuXr41osKAHatBDJMZM1Cvk/Cuc42OE46ChD/pBaKT8fz2o+Mlhma37u4nTVLaPY8f5q5qdWNzAlBqeOb7fnKqEDIMwf2He00hTc1VymdGnMqTCjmL6ywOWr1rmWpyJR8zgN80w3IKcZGcokPHNyOa3VLTa1pMUVbTXEuA+XKG6ubmY+/pUtawD5Po/WFMAQ5RpC0BxZzgGwfhX4F6oBCilwrp6gse0aE83xxlE/+3GK+HZBgH5kTynI3E3uActo8zEgFZvqItsx2IfqD8T9RO50A5cGXgum69B+uf2rO1E+btrlaUX7/X2iahqjnTlR3kEGBDQd2sWhZmqlfn//5jv55HNAFZ4Ee8jRGMhkmsyO/CURh868Yf6A3VjWqS1IexVPQYwSOW0r5bRm688g/PFMtib2nPUxwMiEytSX7/Wb974U1hDte68yZYGxeorJmi4ylJea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(31696002)(2616005)(54906003)(186003)(31686004)(36756003)(6506007)(38100700002)(6916009)(44832011)(6512007)(53546011)(316002)(66476007)(66946007)(2906002)(66556008)(5660300002)(8936002)(6666004)(8676002)(83380400001)(86362001)(4326008)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHE4MTU2S3MxSzJ2UVZVVUwrblVUQTNDUitYNGpqQUJQZFBOWmdhS0x1ZllB?=
 =?utf-8?B?c1ZPaHNORVBQdFprR3J0aHFFNW5WTE5pakt2aVN2S21WMHpJSVBXTDQxM2s1?=
 =?utf-8?B?cnpUV0VGK2dnbnhKQXZmeFJNMkNVMHBkUnNOWU81QWpuc1o0VExNZkV0eC85?=
 =?utf-8?B?K2dXL000U2Jnd3NRaXBMbm1LbHpGSk9DS2twQTZtdFBESlR2YWYyeCtMQXpy?=
 =?utf-8?B?c09ZYkJSREpqbWcvOFhwYUJlcmlkL3QvYmkxK3BDVEw1WDhrdHVEMHM0Ykd2?=
 =?utf-8?B?cG1zdGpsc0V6ODhaUm1meTZrNERMaEl3enc1SmRMM3orWFNsUzhpYS9FaUlI?=
 =?utf-8?B?cXA2eVdUVENpTUJtR3VQTERxRTc4MUhaR3RTLzVXRE5OY096aXBEdVU3Ujda?=
 =?utf-8?B?Q1pONXY0RjdXL3hoYzAyVUtWQ0JucHZTV3M0MEVBcUpBbWdUdWhaN0U3bkow?=
 =?utf-8?B?L2dReU5QM3Q5QkFnY1M4YUwwaFZ4bmdPUFdLeGk2TkkrQlNRQ0kxbW4vN2k5?=
 =?utf-8?B?M2RhMUdCbzBPSm9EL0JYU0FZS2I0MDFTVkxtbERwWi9Kd0kwMWtQMU01Q1RD?=
 =?utf-8?B?NWxGb2xRNmpWSTA1dHZwM2RQUnkrWStuaUgyOXd5QWZlaEJnRCs5WXpsYVdq?=
 =?utf-8?B?UitRK0JSNVk3ckc5TWNRNkpMaUFqajcwYkcrL0Uwdk0zY0pSMnpQUytUZFE2?=
 =?utf-8?B?aHFTcjVydkNDYUlkL2tWejNMSFNDTjd5VnJOc3V2a0FqcFIwU1MvQkU2MS8z?=
 =?utf-8?B?dVJKWkpreGovTVI1bnJIbGlWWjRVQysySkdmTS9qdktNTTI3aEVzMmVKVW83?=
 =?utf-8?B?N0VEdHpRQm44bFNKc2QzWXFWZmhyYjVGTDBCZUkxWE9qWXF3QTZXWlBwajRY?=
 =?utf-8?B?ZjBqZXF4RkFxMkJXcVppSHFSSTBTcHZhMXNDYmh1ZGZLM0RqUXBORHAyclBz?=
 =?utf-8?B?M1EwazhwL0NxWlFjZ3JCNGVFak9JNG1yM3JNL2FCUE8zZFh3MURXL0wrb1BT?=
 =?utf-8?B?bWQxUDBRa3RVZ0xjbzJqZUNzSFRxOEJjS3JhTFpDc0krSnZEZm1iZzh3UTVy?=
 =?utf-8?B?a281Vm9NMExLdmVVMXpsZGtNUEplQTBXZytKZExvOFRFUmowNFdWVktwQVF3?=
 =?utf-8?B?Tm9JT1BqdG1DdnhhekF1d2VXU2duei9MVDFJSGlsU3NWTndDcldlZXNwYjBp?=
 =?utf-8?B?VTdQY0U1VlJncGxkNVlNY25salZ6VWViTWpac20zMEZEV2I5b3dqd1hRZ1M0?=
 =?utf-8?B?clE4OFZKYml3VmxUOHhPN2NTYTFVT25GUVRGQ3I4dGo4eHEyNjh2YU1rNyt4?=
 =?utf-8?B?eXBPOG1hQm95clhIVGJjQ1BQalgrV2FMOEpzN1VqVGpOUlVCQ2dsOTVLL2Np?=
 =?utf-8?B?REdjSlN5N2Q4cmNZOGFJOTZUSDFZNkY0R202b2gySGZWcCt1amJWN3JtRkxD?=
 =?utf-8?B?cGtrTWpsb1dGd3BEQUtxbjhVdHBoR2k4Vm5RL28wUDRwTjBJMU5LT1pRUlU0?=
 =?utf-8?B?dVFaZjVVNzdQalRZc1hWR0FrZ0hKdEJkTHRMYU02VFZuQWh3RCtxVnJJd3VU?=
 =?utf-8?B?OHIwRVlSb1pDV1d3OXpqcjlUZExML2xvYTV6QjdaeXEyN29VeGhOK0Ftekhp?=
 =?utf-8?B?dVB0U2x6ZTZZYWtUSENQZEl6cWRPTG9PVUJUQ2JoRWpzT2tvU0UvdEdBOWlw?=
 =?utf-8?B?RW1vc2xmM1VsRGFNcUNnbjR0a1NnOG44Y3JyOUQxYWtxb29yNVZ4azBuU2NT?=
 =?utf-8?B?UmlTKzRSNzdYTmdkcUVWSVJBNmhzbUpYUGpISXVSaElSME1RdG1EcyszcVBZ?=
 =?utf-8?B?ckx1SDAwOEFsRnozQ1RrQjZsRk13MjB1MDFoNFlVeW13WlNGZjkwUlJ5Z2RX?=
 =?utf-8?B?bHdwUDc5ckY2TzZxUXpTb3ErcitBMTlISlZmYU5NSVN3dDI5USt1K2ZFWTJs?=
 =?utf-8?B?cjF0blR5SGRHYmUreFNhMWhkSXNMY0pMOUVUMnRwOUJTL0xEL0h2M2hVNmJr?=
 =?utf-8?B?QitXenBoRE83SHVvTEhLS0J1a3d3SzFVSTEvSjlYM20wQ3JtNWpmSGdrbzJn?=
 =?utf-8?B?eER1UUh3cGRnWVgrMDhFaSs1V0NXQ08xMjhaZSs2Z0VhRG5sQnZOVUwxdnVk?=
 =?utf-8?B?RnM2d2V0V3lFVnJLTEptM1o1OUVTYUd3YWQyQmJzejk0UGRvUFNMMVNBSHRH?=
 =?utf-8?B?SEk2WkxMVmhSekdsN004M1BvL1Y5Q3IrOVcrSGhxemh0c1JxNytJMTJBYzN2?=
 =?utf-8?B?RU5YMEltaTJnRXNWdjJuVHJNb1FLcCtXZnprRWZpVzVkUjE2Vm9tNGttM1FI?=
 =?utf-8?B?QUVKSmN1bDVnYkhvRnhEemxBbE5FMXZZQ2VDcFRxVThGTGFEMTEwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b2aa82-64b7-4ba6-a25f-08da18bc9f50
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 17:32:43.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lt2NjT3wU4Pj7xAPuec0wpk9gdjLPUg5KKsPx1bd42GO5NdW1j8m8jerFQAltyNc3ek55cf8JtHO5mnBmqeKHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-07 12:07, Alex Deucher wrote:
> Actually this just causes another warning.  Dropped for now.  More below.
> 
> On Thu, Apr 7, 2022 at 11:52 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Applied.  Thanks!
>>
>> Alex
>>
>> On Thu, Apr 7, 2022 at 10:18 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>>
>>>
>>>
>>> On 2022-04-07 02:00, Haowen Bai wrote:
>>>> Smatch reports the following:
>>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2174
>>>> dcn10_enable_vblanks_synchronization() warn: if statement not indented
>>>>
>>>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>>>
>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>>
>>> Harry
>>>
>>>> ---
>>>>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 +++++++-------
>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>>>> index ee22f4422d26..3c338b85040c 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>>>> @@ -2172,13 +2172,13 @@ void dcn10_enable_vblanks_synchronization(
>>>>       if (master >= 0) {
>>>>               for (i = 0; i < group_size; i++) {
>>>>                       if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
>>>> -                     grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
>>>> -                             grouped_pipes[master]->stream_res.tg,
>>>> -                             grouped_pipes[i]->stream_res.tg,
>>>> -                             grouped_pipes[master]->stream->timing.pix_clk_100hz,
>>>> -                             grouped_pipes[i]->stream->timing.pix_clk_100hz,
>>>> -                             get_clock_divider(grouped_pipes[master], false),
>>>> -                             get_clock_divider(grouped_pipes[i], false));
>>>> +                             grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
>>>> +                                     grouped_pipes[master]->stream_res.tg,
>>>> +                                     grouped_pipes[i]->stream_res.tg,
>>>> +                                     grouped_pipes[master]->stream->timing.pix_clk_100hz,
>>>> +                                     grouped_pipes[i]->stream->timing.pix_clk_100hz,
>>>> +                                     get_clock_divider(grouped_pipes[master], false),
>>>> +                                     get_clock_divider(grouped_pipes[i], false));
>>>>                               grouped_pipes[i]->stream->vblank_synchronized = true;
> 
> @Harry Wentland should this last statement be part of the if clause or
> the for loop?
> 

It should be part of the if clause.

Harry

> Alex
> 
>>>>               }
>>>>               grouped_pipes[master]->stream->vblank_synchronized = true;
>>>

