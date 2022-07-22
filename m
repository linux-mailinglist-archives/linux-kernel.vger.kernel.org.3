Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9857E81D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiGVUMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiGVUMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:12:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E4AF958
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dURrXAu63aZIoVPk5wSx9pEuWewOri01K61TAeTOfcVgMX4jsZfKAKWcf6TnKdgG6S1RO645+8O6brf3Jc7bnrtAJW6mXo48sZZAdC9bhcfLSQcXR5rqg17NdiRNfD+RlsEiZHc9nTmRTGlRnyf+iVm3Wu8j4mgvXspS6yRaZxCG3B2KBOCjlzjouMnX39mLWjzbrLk+TODT85XhMSyKzwAA27m59gY6lKI2iv3ZMrNRIs5s7cAVlXwt56zkAE+L96gKW//t7FkW6pQmxZngNkOg1bCe7mC8ac01ZgZc7ckg52kGsC0l0kzIXA3u0shh/4lji0CvrpWQODdjWMlT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPFauaO1x0KVz9U/wICVF/xCTJMqMHbEOVZ01tOrx+I=;
 b=k54lg4Qf4Ar0qYdxnQLD0mRoLrpwi6gGwZh+XJw0k2tw2IysClEIuSeTKNFPJjBfwODnStykzr09GAQu9vzjpkPElGJtlXp3VRYzC8HTxEJPSZeOhWnCGAJSctsH/KJrH3MTMjTAVZlXcsFds6tJH1OSJRSnMimFv2X2SP0wthfQ/I2ffbboABJ9eXksPRkEfCbLklxn/6NKZ8gtotKRJDGDmBD0/u8agzKnHXh+P1u4Nnz1nC/zv3jW4X9QVHbzdGOqjAwnE7IZtaMrEZWjFdJrWcwDusAq/Dxc4Dz4g8y0JC1Esulq0FkhFPQP4iUe456DMRJuzVY9TAVjDXXOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPFauaO1x0KVz9U/wICVF/xCTJMqMHbEOVZ01tOrx+I=;
 b=kaJCPZ1oYf3WSch12fSGPe9HUX0u4DBCknJVf6Mlm20gHEKl20DDnE6olGi2V0IsPdg4nNe0VTZuWWyG9O8mSc6dDdRAtu9bG9mn3Oiy3JgHHEZAIcZ+ZKxBgM0X7YMn4Ojmda/2+EufrRQ0RT6wwZ1asCQqhPDM50tYwg6THK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MN2PR12MB3919.namprd12.prod.outlook.com (2603:10b6:208:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 20:11:50 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 20:11:50 +0000
Message-ID: <88080eb0-e1c2-7b87-6175-72f2842562ba@amd.com>
Date:   Fri, 22 Jul 2022 16:11:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/4] drm/amd/display: Remove parameters from
 rq_dlg_get_dlg_reg
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20220721183633.1004611-1-mairacanal@riseup.net>
 <20220721183633.1004611-3-mairacanal@riseup.net>
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, Isabella Basso <isabbasso@riseup.net>,
        andrealmeid@riseup.net, "Li, Roman" <roman.li@amd.com>
In-Reply-To: <20220721183633.1004611-3-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:b0::12) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f09aed68-3e86-41c8-3595-08da6c1e69b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3919:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bpavp0nWlm5jEzzz04xRiSwkq44AoaNnYQOUARoh44tsIEzD0lsSJZEkPTUk6pyEfDrw0p0FzgeW0JoQPQrTUmqxfOKyxapbQe2iex8myB4x95N4bN5ho4BTp/aRyV4Jeq8/Ru0Uor3LXXzTL5abWpIUceT3quqOnDIxyg0fmsJU5uaJrkWLDq8xiHXIK4Aa5vVaVMT3GIfL6z+Vlh01QgzKoEBHF+k6z+M/vSyVNm2MRCxqr0ciP0AfEveA1+fNeT4KIrvmuLkEcl+5t4q4gXHSv4ExIbaUbJFGIKpWa/KCX9tlOK3B/50sizE0a15VDj81nRdw8CjeDbsu5E5dpct/Cu+agVla1vmnLxqpsPN1eZqkFtrPaqe1KzynNP7dd1aRP21EoCsV4xvkGNsoZ9ZNYeEBSmD+5d7dM6bk77XJCalX9F75y1fzYLKfzcuwfZHektlfHPFqRM1JsX9XP7+NP4IRmWWnUsYKM9gZDTQ+bH5pu8sNdt3i4ef98uPd0yEMo+7jUjJntlPes0gNZdcQ16iFIBQuoJ9FN0UrMtn0sND79W5l6xOlQl2gCs4BYVmYE+zjd5bO1ifbtPbwfSk71JKb+QgM3Wd4hqn9dt16rgx9CtXvCntJ05TCloeUD5QExvOTHEHpx/fUwQqf0ZVRc+L58aUKtE37jRzedJpH5qyiuHUlQ9xTJrg8h6G5uxZecfBYQETPKyjUcF+D6gOxJND27sPvXKkG2q6kXc6wy+OkxncsI/X+2d5Y228P646g2SiVqHIepKM03P1MeWq4C2OcpkkPdxTlAuFSKTUrLPViWjoTdEL8kKQZMHoIhmpt4GzEt4NH1qWpRMmMS9IEcfbAobQfLcuzy5ywOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(8936002)(41300700001)(6506007)(2906002)(53546011)(30864003)(6512007)(66556008)(66946007)(36756003)(31696002)(31686004)(5660300002)(26005)(86362001)(66476007)(6636002)(316002)(8676002)(4326008)(110136005)(54906003)(478600001)(83380400001)(38100700002)(921005)(2616005)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXpadUlHYlgybFQ5SFo0K1VqeVRVTngzN3doZFhleXlySW9YVkRuRU8zVUh2?=
 =?utf-8?B?Vi82UnM4RlFvV3R2b1dSWjM1UUJaaDA4V3Nmb29SaEJuUmZCTzRPWjRMSmxS?=
 =?utf-8?B?d28yK2FuWVVmYVpCalNzakJPTEc2eCtzN3BsQ044cjZHdG81R083RzNweGwz?=
 =?utf-8?B?T2tiSmVPWkc3VEttSVpUNWF1dzNPQ1NaM1NFYk9vbUJUQllSVVBFMlBPeDJp?=
 =?utf-8?B?MjhwbmROYnVtUzQzdnNZMUlMS2paMkVNQzlTTmFYS1hRdWhQRlZMWVJxRms0?=
 =?utf-8?B?amI1VkZZeUU2MDdRMUlKbHRpSEZBNEhRZkFwZDczbnZ2Vk1mb0gyd1NZcmZi?=
 =?utf-8?B?MmN4ZjRvdHhjZFV0YmIyMGZmaG0zWVFYSk1pMjZoYVd4TmtvT1plL0lCSlVn?=
 =?utf-8?B?UUJ1eDRLV1JDMjNXeWowOHEySmpaY0M3Q0RtaDI3ZWhZYkMxK21HQ0dwNlUv?=
 =?utf-8?B?YWR0MlZQZFlVaFNocU9rbytsL1ZSNzFmN3ltcWRQOFpDelA3d252cCtEVVQw?=
 =?utf-8?B?NDRMdk5lY21PcHVWTWFvSkpreG9VWGhCb2tMQ3RaVFp4MTl2K1VBaDRtWENu?=
 =?utf-8?B?MXBtRkFyU04rbTA5dlJQZndWUjVTS3dEMVA1TnFZZVdqQXRxU2JMRlZGR05Z?=
 =?utf-8?B?RTZUYzF0TGx0aFk5NFFZSFlaYitKWXR0aVQvWCttbDd2NTY4b0FNUjIwS2Jv?=
 =?utf-8?B?VDZHdkpseVVibmYvcEt0bVE2a2dPaktyUjBMQ3lNYW9oT1pQV2QwMXM4eVFC?=
 =?utf-8?B?cUhoUnJTZ3hoT0tJV1RzZkNLOVpnQWxKNWw4ZzZIMDFmUDhrS0pnOWhMNEVj?=
 =?utf-8?B?WXluWGtkLyt5UnlvdzcycnNVTURiOGJOMVd1SjVEL2xPRG5xdVhBSGpxYUQv?=
 =?utf-8?B?TzNnWFFzVUJSdkpkRGd4RVJnZ3RzY3l2S1FaeS9kZVNaTDZrZzZ0dStrZDcw?=
 =?utf-8?B?UzFZY1U0Sm5BZWsyYTJYNFNpMkQ5cFptK25mQTJqQjRlNG1SSnNDRlVNRGpt?=
 =?utf-8?B?ZUFSd3lZVGdxQU9lR0ZzN2ZhSkZvTjQ4cXZ0NkNsOTF2N0pmWkd5QTFEWVUv?=
 =?utf-8?B?U0dCL1g1cmFBeHJiWGxpbldySGhjNTNOaStKUHBtOHhrQkYzd1BCejJab0RT?=
 =?utf-8?B?cno2U016WTJtVnUycUNQRGxUa3FzODVJcElWWjZ5UGcyWXJIMjhHcmhjczh2?=
 =?utf-8?B?SUZxMnl2Y0VuckFRWUI1Y2JnQWtyL3pOak9PeTk0UlVjR2Z4ZUNETzZPcGZO?=
 =?utf-8?B?Rk5CWmI1VTJZMU1LRFpmNW1wQmZxL1JRK2U1Smd1ek9oeE1aSHlEd2N3OGJQ?=
 =?utf-8?B?dmlIYlF6eXJudEZwbTZvZk5iWU1hOEZXcTd3cGo2Wk8rY05EYTY2allzbFdh?=
 =?utf-8?B?L3pGc2JLT0k0cFFKamU4U1NxalhQNmxkbVdaRDRTdzRDZVNLaVcwVy9MaU9n?=
 =?utf-8?B?a05EaFNpdGh5eFVUZTZ4L21Pb3NJVkNLQkQwOTFORmhEWk96WjBIWWVVRzFZ?=
 =?utf-8?B?RkUrV2hCWFp3WEJ2clFkT0tYWnJieWlNZEhUOWQyUHlDQXQ0Q3RoMmFGWElB?=
 =?utf-8?B?ZStHQkNPYy9iL1FpYXc2YzRIYlRTN3ErQStpSU5iM3BRVDkzZS8wL1IwQmMy?=
 =?utf-8?B?bkFickdYazIzMkVlaEdEdHh6WEVDZW8rWTVUaWdxRW8yVzBDUzFIMnJNK01s?=
 =?utf-8?B?WnJwNFphWjNPeVJ5OWZOZVk3VEdqV2ZTQmxZMWJxaDFVQytzZitCSklTc1Fi?=
 =?utf-8?B?V2toQ0Y3cDJKR0IzMWE4R1Y2YS9EKzgvM0RwL0pMeVV4empLcXBZL2NiWFhv?=
 =?utf-8?B?OFRwZjlXek5IYXBuMDJhWjlEN0Z2Njkwd0J2eC9RUWprU0thV3h4bG9ySHBk?=
 =?utf-8?B?aURqejNQV2NVelZYOHE3b3ovdDR1WDZad3B2dVdwbmU1ZnVNOGNoTFdGVS9n?=
 =?utf-8?B?UTh6NGs1WEVmWDBzU0JaVjNsQWEyUlZaNmVWeUI5S0ZTZklWeUZZNDhLWW0w?=
 =?utf-8?B?VGp3SndTYUptRkIrWWRpZC9BWnRTVnY3OExSTDBmQWszd2ZBM2FzRzVWQlB3?=
 =?utf-8?B?d2d1R2ZXRVdzK0RrZzZlZ2pFaVdmYXl2QUtiU3EwN3pZYUJUUW9VMHdJcWoy?=
 =?utf-8?Q?iqjNkUdC2yPzUXpsned3eu/fh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09aed68-3e86-41c8-3595-08da6c1e69b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:11:50.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9fgjnugUJ4FlDJy0NJ8UKsCChaOJdEYwkQDZ17PnNGaHigltd1gRmBDLZk4C8xU/u0ChcTWK63UT8iT2dCZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3919
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maira,

First of all, thanks a lot for this patch. This change is really helpful 
for reducing the stack size. I just have few comments inline.

On 2022-07-21 14:36, Maíra Canal wrote:
> Across all DCN's (except DCN32, that has a separate
> rq_dlg_get_dlg_reg), the parameters const bool vm_en, const bool
> ignore_viewport_pos, and const bool immediate_flip_support are not used
> on the function. Therefore, change the rq_dlg_get_dlg_reg signature
> by deleting those parameters.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
> v1 -> v2:
> - Replace "enum" to "enum entries" (André Almeida).
> ---
>   .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  3 +--
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  5 +----
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |  5 +----
>   .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  5 +----
>   .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |  5 +----
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  5 +----
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |  5 +----
>   .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 18 +++---------------
>   .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |  5 +----
>   .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 19 +++----------------
>   .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |  5 +----
>   .../dc/dml/dcn314/display_rq_dlg_calc_314.c   | 15 ++-------------
>   .../dc/dml/dcn314/display_rq_dlg_calc_314.h   |  5 +----
>   .../drm/amd/display/dc/dml/display_mode_lib.h |  5 +----
>   .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  |  3 +--
>   15 files changed, 20 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index dc60b835e938..d9cfb29a2651 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -857,8 +857,7 @@ void dcn20_calculate_dlg_params(
>   				pipe_cnt,
>   				pipe_idx,
>   				cstate_en,
> -				context->bw_ctx.bw.dcn.clk.p_state_change_support,
> -				false, false, true);
> +				context->bw_ctx.bw.dcn.clk.p_state_change_support);
>   
>   		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
>   				&context->res_ctx.pipe_ctx[i].rq_regs,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> index 548cdef8a8ad..d0a4c69b47c8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> @@ -1553,10 +1553,7 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support)
> +		const bool pstate_en)
>   {
>   	display_rq_params_st rq_param = {0};
>   	display_dlg_sys_params_st dlg_sys_param = {0};
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
> index 8b23867e97c1..36c3692e53b8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
> @@ -65,9 +65,6 @@ void dml20_rq_dlg_get_dlg_reg(
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support);
> +		const bool pstate_en);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> index 0fc9f3e3ffae..17df9d31c11f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> @@ -1554,10 +1554,7 @@ void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support)
> +		const bool pstate_en)
>   {
>   	display_rq_params_st rq_param = {0};
>   	display_dlg_sys_params_st dlg_sys_param = {0};
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
> index 2b4e46ea1c3d..f524f1ccfe41 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
> @@ -65,9 +65,6 @@ void dml20v2_rq_dlg_get_dlg_reg(
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support);
> +		const bool pstate_en);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> index 618f4b682ab1..502dafc6dd79 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> @@ -1662,10 +1662,7 @@ void dml21_rq_dlg_get_dlg_reg(
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support)
> +		const bool pstate_en)
>   {
>   	display_rq_params_st rq_param = {0};
>   	display_dlg_sys_params_st dlg_sys_param = {0};
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
> index af6ad0ca9cf8..822c68089ca8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
> @@ -65,9 +65,6 @@ void dml21_rq_dlg_get_dlg_reg(
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support);
> +		const bool pstate_en);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> index 8179be1f34bb..b3bdb7283a7e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> @@ -898,10 +898,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
>   	const display_rq_dlg_params_st rq_dlg_param,
>   	const display_dlg_sys_params_st dlg_sys_param,
>   	const bool cstate_en,
> -	const bool pstate_en,
> -	const bool vm_en,
> -	const bool ignore_viewport_pos,
> -	const bool immediate_flip_support)
> +	const bool pstate_en)
>   {
>   	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
>   	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
> @@ -1031,9 +1028,6 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
>   
>   	dml_print("DML_DLG: %s:  cstate_en = %d\n", __func__, cstate_en);
>   	dml_print("DML_DLG: %s:  pstate_en = %d\n", __func__, pstate_en);
> -	dml_print("DML_DLG: %s:  vm_en     = %d\n", __func__, vm_en);
> -	dml_print("DML_DLG: %s:  ignore_viewport_pos  = %d\n", __func__, ignore_viewport_pos);
> -	dml_print("DML_DLG: %s:  immediate_flip_support  = %d\n", __func__, immediate_flip_support);
>   
>   	dml_print("DML_DLG: %s: dppclk_freq_in_mhz     = %3.2f\n", __func__, dppclk_freq_in_mhz);
>   	dml_print("DML_DLG: %s: dispclk_freq_in_mhz    = %3.2f\n", __func__, dispclk_freq_in_mhz);
> @@ -1746,10 +1740,7 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>   	const unsigned int num_pipes,
>   	const unsigned int pipe_idx,
>   	const bool cstate_en,
> -	const bool pstate_en,
> -	const bool vm_en,
> -	const bool ignore_viewport_pos,
> -	const bool immediate_flip_support)
> +	const bool pstate_en)
>   {
>   	display_rq_params_st rq_param = { 0 };
>   	display_dlg_sys_params_st dlg_sys_param = { 0 };
> @@ -1785,10 +1776,7 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>   		rq_param.dlg,
>   		dlg_sys_param,
>   		cstate_en,
> -		pstate_en,
> -		vm_en,
> -		ignore_viewport_pos,
> -		immediate_flip_support);
> +		pstate_en);
>   	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
> index 625e41f8d575..d28ed3ae3f94 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
> @@ -61,9 +61,6 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
>   		const unsigned int            num_pipes,
>   		const unsigned int            pipe_idx,
>   		const bool                    cstate_en,
> -		const bool                    pstate_en,
> -		const bool                    vm_en,
> -		const bool                    ignore_viewport_pos,
> -		const bool                    immediate_flip_support);
> +		const bool                    pstate_en);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> index 66b82e4f05c6..c36dd3a79871 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> @@ -859,10 +859,7 @@ static void dml_rq_dlg_get_dlg_params(
>   		const display_rq_dlg_params_st *rq_dlg_param,
>   		const display_dlg_sys_params_st *dlg_sys_param,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support)
> +		const bool pstate_en)
>   {
>   	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
>   	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
> @@ -970,9 +967,6 @@ static void dml_rq_dlg_get_dlg_params(
>   
>   	dml_print("DML_DLG: %s: cstate_en = %d\n", __func__, cstate_en);
>   	dml_print("DML_DLG: %s: pstate_en = %d\n", __func__, pstate_en);
> -	dml_print("DML_DLG: %s: vm_en     = %d\n", __func__, vm_en);
> -	dml_print("DML_DLG: %s: ignore_viewport_pos  = %d\n", __func__, ignore_viewport_pos);
> -	dml_print("DML_DLG: %s: immediate_flip_support  = %d\n", __func__, immediate_flip_support);
>   
>   	dml_print("DML_DLG: %s: dppclk_freq_in_mhz     = %3.2f\n", __func__, dppclk_freq_in_mhz);
>   	dml_print("DML_DLG: %s: refclk_freq_in_mhz     = %3.2f\n", __func__, refclk_freq_in_mhz);
> @@ -983,7 +977,6 @@ static void dml_rq_dlg_get_dlg_params(
>   	disp_dlg_regs->refcyc_per_htotal = (unsigned int) (ref_freq_to_pix_freq * (double) htotal * dml_pow(2, 8));
>   	disp_dlg_regs->dlg_vblank_end = interlaced ? (vblank_end / 2) : vblank_end;	// 15 bits
>   
> -	//set_prefetch_mode(mode_lib, cstate_en, pstate_en, ignore_viewport_pos, immediate_flip_support);
>   	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
>   
>   	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
> @@ -1576,10 +1569,7 @@ void dml31_rq_dlg_get_dlg_reg(
>   		const unsigned int num_pipes,
>   		const unsigned int pipe_idx,
>   		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support)
> +		const bool pstate_en)
>   {
>   	display_rq_params_st rq_param = {0};
>   	display_dlg_sys_params_st dlg_sys_param = {0};
> @@ -1610,10 +1600,7 @@ void dml31_rq_dlg_get_dlg_reg(
>   			&rq_param.dlg,
>   			&dlg_sys_param,
>   			cstate_en,
> -			pstate_en,
> -			vm_en,
> -			ignore_viewport_pos,
> -			immediate_flip_support);
> +			pstate_en);
>   	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
> index 8ee991351699..5b0b438a9804 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
> @@ -61,9 +61,6 @@ void dml31_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
>   		const unsigned int            num_pipes,
>   		const unsigned int            pipe_idx,
>   		const bool                    cstate_en,
> -		const bool                    pstate_en,
> -		const bool                    vm_en,
> -		const bool                    ignore_viewport_pos,
> -		const bool                    immediate_flip_support);
> +		const bool                    pstate_en);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> index 61ee9ba063a7..37ecc4a6ae11 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> @@ -943,11 +943,7 @@ static void dml_rq_dlg_get_dlg_params(
>   		display_ttu_regs_st *disp_ttu_regs,
>   		const display_rq_dlg_params_st *rq_dlg_param,
>   		const display_dlg_sys_params_st *dlg_sys_param,
> -		const bool cstate_en,
> -		const bool pstate_en,
> -		const bool vm_en,
> -		const bool ignore_viewport_pos,
> -		const bool immediate_flip_support)
> +		const bool cstate_en)
>   {
>   	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
>   	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
> @@ -1060,9 +1056,6 @@ static void dml_rq_dlg_get_dlg_params(
>   
>   	dml_print("DML_DLG: %s: cstate_en = %d\n", __func__, cstate_en);
>   	dml_print("DML_DLG: %s: pstate_en = %d\n", __func__, pstate_en);

hmmm... I'm not sure if I missed something, but you dropped the variable 
pstate_en from the parameter list, but you still have it here. Is this 
correct?

> -	dml_print("DML_DLG: %s: vm_en     = %d\n", __func__, vm_en);
> -	dml_print("DML_DLG: %s: ignore_viewport_pos  = %d\n", __func__, ignore_viewport_pos);
> -	dml_print("DML_DLG: %s: immediate_flip_support  = %d\n", __func__, immediate_flip_support);

Why are we dropping these logs? It is already hard to debug DML code, 
and reducing the amount of information that we can get does not sound 
good to me.

Thanks
Siqueira

>   
>   	dml_print("DML_DLG: %s: dppclk_freq_in_mhz     = %3.2f\n", __func__, dppclk_freq_in_mhz);
>   	dml_print("DML_DLG: %s: refclk_freq_in_mhz     = %3.2f\n", __func__, refclk_freq_in_mhz);
> @@ -1073,7 +1066,6 @@ static void dml_rq_dlg_get_dlg_params(
>   	disp_dlg_regs->refcyc_per_htotal = (unsigned int) (ref_freq_to_pix_freq * (double) htotal * dml_pow(2, 8));
>   	disp_dlg_regs->dlg_vblank_end = interlaced ? (vblank_end / 2) : vblank_end;	// 15 bits
>   
> -	//set_prefetch_mode(mode_lib, cstate_en, pstate_en, ignore_viewport_pos, immediate_flip_support);
>   	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
>   
>   	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
> @@ -1725,9 +1717,6 @@ void dml314_rq_dlg_get_dlg_reg(
>   			&rq_param.dlg,
>   			&dlg_sys_param,
>   			cstate_en,
> -			pstate_en,
> -			vm_en,
> -			ignore_viewport_pos,
> -			immediate_flip_support);
> +			pstate_en);
>   	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
>   }
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.h b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.h
> index 49cb85d1056c..d2c1ba8b7ebf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.h
> @@ -62,9 +62,6 @@ void dml314_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
>   		const unsigned int            num_pipes,
>   		const unsigned int            pipe_idx,
>   		const bool                    cstate_en,
> -		const bool                    pstate_en,
> -		const bool                    vm_en,
> -		const bool                    ignore_viewport_pos,
> -		const bool                    immediate_flip_support);
> +		const bool                    pstate_en);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
> index 2bdd6ed22611..8a4b60a278b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
> @@ -55,10 +55,7 @@ struct dml_funcs {
>   			const unsigned int num_pipes,
>   			const unsigned int pipe_idx,
>   			const bool cstate_en,
> -			const bool pstate_en,
> -			const bool vm_en,
> -			const bool ignore_viewport_pos,
> -			const bool immediate_flip_support);
> +			const bool pstate_en);
>   	void (*rq_dlg_get_rq_reg)(
>   		struct display_mode_lib *mode_lib,
>   		display_rq_regs_st *rq_regs,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
> index b4b51e51fc25..e39e2363ea0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
> @@ -1647,8 +1647,7 @@ static void dml_calculate_dlg_params(
>   				pipe_cnt,
>   				pipe_idx,
>   				cstate_en,
> -				context->bw_ctx.bw.dcn.clk.p_state_change_support,
> -				false, false, true);
> +				context->bw_ctx.bw.dcn.clk.p_state_change_support);
>   
>   		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
>   				&context->res_ctx.pipe_ctx[i].rq_regs,

