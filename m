Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011AE586D57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiHAO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:58:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE9313A0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXw+hvGP+5HetJO43DUohgV3LHlTVU2aCw2n0b2ZiefLZuW7xxkIziez5+aFBvnc6QJmgsh57gXaHl6Mp8SVN6MdGcorjrxgIQHUJ0lLeHAKFcl7r1Sm6jOiJjR/65JzOgjQe/AAfabsfu+GeOVtSHan9NKZxkrhQkzvhT9HGv2mGKowLG2WFUn8xqeucRdOmv6s0L050TM9Qr7ZDF7FcGTjJUXEH4+nDQojlHTNCL//TZCOBfyqD1iBm5zWn0G4dNDgzp39h/9shNPqrnzurvXsQOhUBaZ7n9cbCvV5goIYk19sS7WUPIm3x3JTDltDjOTCPUmdlS8jZBu8D38gXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AouL3Juc99C08+0VOSAhvU6nBl7Ce/mQQBVhj9cJz54=;
 b=BoEY6iRxVr49Xnrrc27BpdDNEh8/cHgbIhgLjgWjRVr5+gIjCcz0NgJUp25hmAF/jUilGwQWdotpqg0cIkFEk4gtfTwsmz5ox69SlC2VsGjCDNX2IioJXDBCWP/Jnm1xb2aJxjWO5VdEfy2Fj3rzPigFR5V4Ooza8W+RKyG6sNFznFH7RgaaKLgVOnbmyDAuEq6gdC5WEQHDi3heKMZ6bA3BKfG84L9mkGRl24m4wlyCYpzR5KnwZGnECNxhAglu2dNYD312Gsz3i6402fHi3G/eRuFWXRhG6y6a5416kOOHgF8xDiumjeBxTNLmWE9CAjm0MkS53Oh/IuP3tJq6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AouL3Juc99C08+0VOSAhvU6nBl7Ce/mQQBVhj9cJz54=;
 b=E5Vfi6+6yu4dDa/Q1jtECmz5Tg6TPUr0vEP0BcH3cW1uHevrb166H3+u5jNqWP/JBsOWTvOrhF6aoVSZkHSSrcu5/BYQLiivRlJOU6sd4OGnK6W4tKJb1qzmdO357xgp1MeCYdE+xCGve/j+h9/qRUZYce2bRFprcVqqnfwUl30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 14:58:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::945b:e042:bc6b:e183]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::945b:e042:bc6b:e183%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:58:52 +0000
Message-ID: <5a7abe15-5d0d-6ff0-3248-e6fcd6b92d7d@amd.com>
Date:   Mon, 1 Aug 2022 09:58:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Content-Language: en-US
To:     eranian@google.com
Cc:     fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, x86@kernel.org
References: <CABPqkBTU_StuH_zyZ=22wtV5_V8YDnxRpTSjy4Bg0s=mk8PahQ@mail.gmail.com>
 <20220725194743.173159-1-babu.moger@amd.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20220725194743.173159-1-babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87045982-a1df-452b-c15d-08da73ce5956
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H4nWYCKVryOg8Qqs1AjSjfkozZ9mdVmpG5VlD0XSa+LSV4YMQ/tMMHq8OYbE2/FmyqgLl6Mq73GFHwgcwHO/DacvaSHlVzWMT2IbnLJhZ8wWWkopryCakfDIwHER73X4scaGWJkJIF5+sMWXk/KrMJBA77lxspU5AUVHP0zDjDHv1a+EZmXd5rqYTUZcDh/13tIs+KBYl7dCu/hnxtRtj+WWcv7N0lhZug/jrpVTKZhc20VJIKxYoldbUJlsy+N5Le9eSLAi3X8Is5weBaY+XxhUcfQgwBxYXGPptnKQ4wRFIgUo6LqmFetpjFONje8XFGQTmpGM3sdqWrfdjUq4ubw7x2AUyCzuMK8JCNks/mCNIJixIcTS9QLKND7uee3ZXzRHqlBaRKhgl/nz3XBmdQrveKfqDM493sb0+jTUxlTpl3aI+B1NnDCvT56jW7Qx2E32JADY+VxNvnEpv9SChjuRXusv81su6gfBUk0PlEbphkFN182/PDtiJNOFqH4UetrcV3vG57Sz77uqmUbzEmCdq2Ouubiygk7f8msHZvyf2ss81uIfVAvoxulBLnJ4Lq5PFVp76SvhCCtYS0+WI8WF01mc1CvfCIdZNIPvlh5eyqvQV/COuu/tESFaBkzoJq7TWSpGsAU0vPgpQm3+gqZNeX5SJ6+P5CjbPqNM8IgSpcrn1jOvSCSdbGDjZB32hucDnTGypw3+IZtywTy/DbSMzlHlmkpGldwyXs4mj0hAffm/oN/nmRDq38NtdXh0A8qaPG+OxTKKmWVMVHEjAW3JChYk8w2QsNRf0ww6MjGrcyKQKmdwEUTZV09VFJqIjCRMPz/PQm3riIhP00Vvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(36756003)(2906002)(66946007)(5660300002)(8936002)(3450700001)(66476007)(6666004)(66556008)(8676002)(4326008)(41300700001)(316002)(6916009)(478600001)(6486002)(53546011)(6506007)(31686004)(38100700002)(2616005)(26005)(186003)(86362001)(83380400001)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFqZDZtMndJZjRxbk44Yi83ZHcwSjlJVDFiUlFFMHBVRUN1TFN4M1Z4RExr?=
 =?utf-8?B?UFZIOENjc3ZMZVBodVhjd1FzcDFaOS9aWTRWdWZkek5KczhuR0NJUHhhNlVm?=
 =?utf-8?B?a3E1dEpxdkUzYXNBTGFaRkFYZ2hkclR4QUxVWStjWGRyb3hHU3hWWElGTzRI?=
 =?utf-8?B?NHRUeUNoWWtVSVNCRDFidXpNNXNSTDkzVFVSRWhDaGgxSTgrbFVuMlF2WVh1?=
 =?utf-8?B?bUFBc0tGMHlyV0pURzdhY2srZHNKd2YySlJhUi9hclBzWCtZaTI0Y25Xb1hT?=
 =?utf-8?B?V2ZLV0JjNDZnNnRDSjN3TU4zWjZsYWUyY2VDL05WNnZWdWJYbEYrVCtTNnVo?=
 =?utf-8?B?RllMNG1RS1BCc1hCYzlwaSt0QWhvMC92YnNhdW10L1ZZQi94Z3FEeU5WTENM?=
 =?utf-8?B?WTB6bThXMUVvZk90Q1Z5ZXhKUldOa1JKOUYvWUVMVXY1MWlTTjhNYVRHeWZm?=
 =?utf-8?B?Szl2TjI1a1ZaZmhFNGpyekJwVGFlSE9IUHF1NDFBYWt3MlFzRFRlSGdlVTNW?=
 =?utf-8?B?VG8wTkZNLzBoUFNBdHg0ZEhabkpDMks4ZTlwNytON3dmT0krSFRNNHBsN0F1?=
 =?utf-8?B?Rkl3a1QrOW5DUEZjNXhmMGhHTTlNMFpkU0M2enNvbjI2VEVpSkwrOTE5MU1R?=
 =?utf-8?B?ZDk3djNHVldNOU9sS2tveEFjNFgydHZSZjZpVE8vZ0pFTVBOb0tKdUxRTmFO?=
 =?utf-8?B?OVFYQkhNckZobmtYcThuRlc4M3hXOWtTbU1PbDRQay8xOUFJOUwxRUVId2c0?=
 =?utf-8?B?OFExSU1LUE9mbm14dzVMakIwZkJyOHczalNjMnRlSkZzZTlwRlRHTVBVbFVZ?=
 =?utf-8?B?YXVZQkpQQWJnaXpqckhtb2FzWk54UHFqTFQwdmI2aTVEM2E5cUE1dHg4QkZy?=
 =?utf-8?B?UUxZTkVxKzdhbUE0aGxVODlQeDVGRVZHTTVzQzlQUU5jSUtVL21ucXpVcURH?=
 =?utf-8?B?cDJKNTR4UmJza3JoYzBGWW5CRkQxcGlyWnlUL2pralhINTczUmFYaVNMK3NZ?=
 =?utf-8?B?M2lkWWUzaVNmazkrRnN1MXNxZVRnemdaM0hHamp2c1NaSGk4NFBXSXJCZXdl?=
 =?utf-8?B?SmY1cStvL1QzWTNWTTEvd1pzekw2OWZaQ2JFUGNlUVJBSmZaaXcyeGVnUUFv?=
 =?utf-8?B?cXJmVHpFU3NyamhPUXY5ckRMbHhnS3pOYW9sMFhqUFZ5MlBaR0FQdUtmcHpV?=
 =?utf-8?B?MnBLWlFQMklNK3pNZWYxT1J3OEx3cnRVaStJQ0lHR3JLSGFHYWVmQ1FuVng3?=
 =?utf-8?B?bVR0TVdzSkpMY2E2OGxLNFZpdkMwZ0Zlclo2MzRsd25wbmFwd0RZL2RSSUxZ?=
 =?utf-8?B?QXJrUitYL3hEaUtjZGlMV3kzWHJIczNmZzRWT0I4em40VjJnaWp4bW5rMEVI?=
 =?utf-8?B?OUQ4WFIvVUlIZVlpOS9NZUVmSlpCZzRuMk5CVzViYUJ4S0JiVm5XbDl4ZDhF?=
 =?utf-8?B?Z0x2MzNaVkR6NFdFR1k5bjFuM0c2L3NoQ2J0MjNQZmc3a1FWQ1k0M2Y2MVhp?=
 =?utf-8?B?ZEpnblprZzJ5K1FGRUNxVlhtVXZxYUd5OCtKYWRmSEtnVjd4VVo5T1RqaytY?=
 =?utf-8?B?ZTBrTWVPQmkzZy9UYjErNVZwRDdiRTdsRElqVURHUXpTZU5wMk1NOWt1N1Ez?=
 =?utf-8?B?dk44akZmQkExcWV6c3NSWC9WYWNjaWtkNUFSMXI2Wi9oSG00V1NDWjk3SDVR?=
 =?utf-8?B?RHlSenRQTWQvekRFWStVampKelI2UGd2Z25jcUdxUFd3WlRiUGE3TTVRQmJS?=
 =?utf-8?B?ZkF0QW9RQzczVmxFSG04emZhMklUN1k5RDZiWWltallHd21pZUovN2x1L0lZ?=
 =?utf-8?B?THhiMWxWQmk5Q0dSK0NxRzBESytRK2V4QjlwdERaZDNvWXRxaGJjam1zTDBi?=
 =?utf-8?B?V2UraWN1WHk1TFJhWSsxR2Y5R24yKzU4aTVKMW84L3E1MmlxeklnRnk1SjFh?=
 =?utf-8?B?dHJqeTRRSzEvbTlMZDB0SFNISHlYZGI1d2F0Q3VJcUwwSHUraFFVblhNQWRi?=
 =?utf-8?B?Y2cxYmZ1V2N5cFVjcGxiYXRUcUlpaHRjaHRpL1NoWkhDbUZkYkQ1WCtRSWRx?=
 =?utf-8?B?cVJndnA5WmMrY0NVNEQ4TE9QblloejBSYjd1Sm1EdUdxdGp4ZTNOYWVYU3JG?=
 =?utf-8?Q?Vjwk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87045982-a1df-452b-c15d-08da73ce5956
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 14:58:52.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l93FuZz/e5+PL+xevwzgB3vsIfAPshNGNBR3rPX3x5DhrXNXKWepAAx9bQPJAIeq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/22 14:47, Babu Moger wrote:
> Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
>
> Sorry, I didn't see this thread. Just noticed going thru the archives.
> Replying using "git send-email" to the thread.
>  
> Thanks Stephane for the patch. Thanks Fenghua and Reinette for your comments.
>  
> Stephane, Are you planning to re-submit the patch with Fenghua's proposal?
> If not I will resubmit with my current patch-set.

Didn't see Stephan's response yet. I will add this patch in my QoS series.

Stephan, Let me know if you want me to add your "Signed-off-by".

Thanks

Babu

>  
> I agree with Fenghua's proposal. Here is my proposal with slight modification.
>  
> Thanks 
>
> ==================================================================================
>
> Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
>
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index bb1c3f5f60c8..a5c51a14fbce 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
>  			.cache_level		= 3,
> -			.cache = {
> -				.min_cbm_bits	= 1,
> -			},
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
>  			.cache_level		= 2,
> -			.cache = {
> -				.min_cbm_bits	= 1,
> -			},
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
>  			r->cache.arch_has_sparse_bitmaps = false;
>  			r->cache.arch_has_empty_bitmaps = false;
>  			r->cache.arch_has_per_cpu_cfg = false;
> +			r->cache.min_cbm_bits = 1;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			hw_res->msr_update = mba_wrmsr_intel;
> @@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>  			r->cache.arch_has_sparse_bitmaps = true;
>  			r->cache.arch_has_empty_bitmaps = true;
>  			r->cache.arch_has_per_cpu_cfg = true;
> +			r->cache.min_cbm_bits = 0;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;

-- 
Thanks
Babu Moger

