Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF435A2A35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbiHZO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHZO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:59:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79585DF1D;
        Fri, 26 Aug 2022 07:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui37bF/zYm3K9p3Ix9mUDAM/oETeV3DFy7TWkchjD2ho7jgBA9xa0CsQOZktwpNgiC7/hp8GhaObpwJTMEWPsDmgvaSBnWolYbviUkgKHpnQz80Qmwy1af+x3LdsDgB7hDO9JO5bIIbByfBJC2WK2KQV/CjvLYqIQGwPtToyf4cBoMTEuD1OT3Ejypcwss9f8C5oPogvNuj06lCvmwSPJAklXv8xJkoI4Rgnfnp2GoHDr7x9bI5pHh78p2G3GtKrVYpgBFQs3LhB8XavVo716n9TUU/PkyyvWjdekBYGANFiVVKl/eR0LquQyDjU6YgnSUctFiYJ3/tI/uSUGHN0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP8TH79Jr52YATL77twyDlT+CSiqCr3sUnuaaETuUs8=;
 b=hpyWKPTktNW6fk1S7tcG2JYE/P2YMBKWRcjAQPe70WInmg6RHJ5wN6jO6xOODs7vjU9OEZvHi9kDwWLFQz2GcM/gojUDbQSfrUCbqskdxq5GWPX4EweUs1kXzCGnDRKuNk3AVeBQXvOZvdw+8S8lkK9T3yRxRA1aYg159VGVVd0/VsiQfPSqrK3E4oX2rdYkuWNrEF7y9FpYO9kr8bDcKoLwuSyxL1Z7JsBTs0wdjKFL8K2hY0Kx+Jce2jmfN4BKLirkQwUciZy7ferVAFq8Oi+q69CYoy0A1PjvAk0IgI8MB0iYUUfROZJ7O0iaFRzPxcYdTzUeSPsLWsDCi5v1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP8TH79Jr52YATL77twyDlT+CSiqCr3sUnuaaETuUs8=;
 b=AMMY84ykhOzl3YntZ8eFp+bWqaRidIeeEMfRA/drkDz5+yAp2/sG7YIhGvqyeZJxSvxQwfvAC65aLSwE7S0D5HKKpTYD6M1ewknajp0nOhhUmtDDRCKOqMfSs4JBqfxzWEl6gxnHVFP7Fb74MKrEJhKG5l7ZKMXPfQMw4mtWb7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BYAPR12MB3397.namprd12.prod.outlook.com (2603:10b6:a03:db::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 14:59:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:59:38 +0000
Message-ID: <7c3aa894-7778-68af-8c4b-49e5e6233567@amd.com>
Date:   Fri, 26 Aug 2022 09:59:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/10] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117578296.6695.6947071073613460712.stgit@bmoger-ubuntu>
In-Reply-To: <166117578296.6695.6947071073613460712.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9d8c2f5-b6dc-4ed2-2898-08da877398d9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3397:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfGJyUovajlqbgi3xAPs3D5xzII9PMKwpgxxx2gexR38ERw+MW7kxXbyJpQqkguAtxxl61IL2Kagh3JbiUgIMawzUE/CkrxEdWuAk7wVz5pfqq/stnjF/eaezh5ofNpIGIUXdhfqXIvXGLd6DNJOh7dGtK8OGBxmBZn/oq33WzcYyEZPbrWLyRacH/oElciJBn3dn+GBvbe4iX/N1nLAcPCtGb4cc7PogLQBZuEtLdE0/v1y1HXyDLBls4m5gVxA5te5DGJHrxQnegKkmdDG97NWQN2WtppwRTZydf6NuXudNqvsG1SjO3Orb44I/TwFbHucRqLb2HQrhAYDnRF5Im7c1iJOv6w0xqJ6IP8fvBfqe6XwzgtV78M41j7QYyg5VHUaAfj5EEo+tZn2MQD7Otb0Lu7z4Qryy9iQ+u+FUrNS0AGwLqcbqoVOtM4Rr+eAKt/TkRsigRcU7WOwJ7MVFyEnZYKhXkdKc3F5e/KsAYDNhHXVnflsXcvvCP/PL/vnTyP611sEN1uG79Q/lRk5NzF47Phyxi2Jc6Pjj/u54GxTWKYl13RqE4D01dkSexNt1vy21Z+MVvtecTnic6PUIwz5OtiIQrHQxZ1AdLnD3/gPP9buoyOsAUcJ+3HFJj6rwqion3HytnWyZdU5ajVP/VxR0gJCkoMcg9P8aGZI7taqzkaSJ4j82XndIiW9WUV4d7/169fskIQZe9EETZmZIwcgmtkF4SFgkGl5M0nRrl3lPtMkCrjUk2cg8ITomKya3+yJ7LcgRdc2aNahP/kKSATPpUoMUvfZ5V+hW7tZc08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6506007)(26005)(6512007)(53546011)(2616005)(2906002)(186003)(8936002)(7416002)(5660300002)(31696002)(36756003)(86362001)(31686004)(6666004)(41300700001)(478600001)(6486002)(83380400001)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVMbkhSTFJyZE9xajdsS3VtQWRmVEUrMU10S1UzRDRhZzNWeGVGYit3Si9T?=
 =?utf-8?B?bzduYktRMjBtQWludHVNREZYanRRUmJnaXNCczBjQUhXVEx6L0FpTUNkZUJN?=
 =?utf-8?B?U09tOEIxdWRWVm9oaGt2cVRGdktKWmxKRTFQTkxJSDJNaVJJdWxJNC9DenFq?=
 =?utf-8?B?QUNIcVJLNmFMUVBMMUFUUEwwTlFjbVF4SEk4eXRTdmtlNnQ0b1FYQmRubUk2?=
 =?utf-8?B?L0V2cEZ0NHppaFhDOWdRUGkzTDBLd0RXOE5xQjFRZ3RjNjFxaGsyeHdJa1do?=
 =?utf-8?B?WE0wUkpqL0JFUnN0dStqSENieTAzQ0Q0SmtYd3BMNG8zTjhFR2JlWGJBYXhp?=
 =?utf-8?B?dE5qTmozcmRnZElmSkI5RGpqek1DM0ZpMVYwcU9LVFhOYmMzdjE1N3JnTU0z?=
 =?utf-8?B?cWdoNGRFaVVtRnM1QUJJWTQ1WTFkTVdUcHFLU3J2WnNxZXZ6QjY0OTdNY1hF?=
 =?utf-8?B?NnlwOG5KWHRRMjd2S01QMzVqNzlha3hsV3NyNlhJNWp2ajdmaUorS3hGZWNP?=
 =?utf-8?B?TDhzZW9OZWtZN2dOZkNvWUY0cFVVL1hQSzZzM0tJSEp1aXlKeWx1TjEwd3o4?=
 =?utf-8?B?QzZGcHRZUm5VbFN6eEdsWWczNGxWdnQwMkhocEFxcHhLYjhTVE9pYzRhcjFF?=
 =?utf-8?B?SnI3NXFPQ3RXN3Y0eDhmV29MaHZudzl3M0NraXkvTjM4VU1IM2FNQ0dwVGE4?=
 =?utf-8?B?anNlMnlDTDRYRFZkemhzWDZpWDNIdHlmajc1YmcweTYwY2JiSW5IWHdaWUI4?=
 =?utf-8?B?RmhCdkFMK1daWWFIeFZyeUdDU3l5ZVRHNzJhQi81SDlScnZKVFZSWVFNYVhC?=
 =?utf-8?B?M2JBY1d1UWpuOUQyWkxsNCt4U2Q3TGM3eWFVMlgzYkF4QzFVYlgyZWFXQzBX?=
 =?utf-8?B?cEFKZlZRSFdMangrRzhIL0pVTkQ5VjRLdDZFVFV4d2QrTmJKekx0emNld3VR?=
 =?utf-8?B?NTJXMUdSL1FXV1JLZnFwRjRwekRabDFUYTlnTk9MdUlwZktrakM4SWlPWEFL?=
 =?utf-8?B?QkZ4Qjlqc1JNSzR1K1BNWXY3Mm01V3ZBYnBtUVl1dmwvS2YrNlNMam1ENVdy?=
 =?utf-8?B?RXRKdE1WcHBRVXZrS04vazF6Z2NmYlBBSklUN3pCMUpGYzh6UXk2SC8weTJm?=
 =?utf-8?B?VFYrYjJnNjJmeEZ4YVZTb0lCRTVTbENpUGE4aEpjczliN1JIbm9hL29HT0Qr?=
 =?utf-8?B?M0ZySlpjdDBkTjErRXBEdmI4Rjg3dEJpRlBjREZDaXU0NUIwVHI0Z3BqT1lT?=
 =?utf-8?B?RlRIY1c3bys5ZWN3eUtZSUVtSS9meVUzd2ZGYlVUUmJvWFNOd0Nza2UxSXpz?=
 =?utf-8?B?MTJ3TVVFSDNGMlFROFA3YnplVGY2WTJ4STIxVXg0aXlWVG9aTnJLK2V0VmVV?=
 =?utf-8?B?R1JQdUMxK05Jalo3SEtFQU4xT2h1S3hHcHNqSm1UNVB2YnI5a1c1NVJGUHNV?=
 =?utf-8?B?NXFORExYSkhEUjVVa1NJM1Y2QUFkdUxYREZuRVBiSld0dXh2Zmk0bCtyQ3dy?=
 =?utf-8?B?T3VwTzlxUm1yU05XWGFuWXE5MFpGN2IrS0xUelNxbWFoa2pPV2ZWdFNFY2Zi?=
 =?utf-8?B?TFpPWldKa0hEWEpFVUE1MzN0d1VxTDJKR3NOUFdPYnM5QWJjU3N2aE1BVE9r?=
 =?utf-8?B?d29OeUFyTmMvcit3NU02d0J5M3hrRGlRTHdHSlN5M2s1SUh0RmE4SFlBZElB?=
 =?utf-8?B?ZW5ETmVKWjRNSHpjSDkvcCtYVTl4MU1Dc0tSZy9uakRYM3ZNVnNpY1pLR3Zu?=
 =?utf-8?B?dk9sNmlBbFY3YnVCRXZ1ZldNMlkrNlRSa2dqUGZVQmx3TnpRSTlZSFRmRXZG?=
 =?utf-8?B?ZUZpRlRGcGd6ZGtSRysxUTRyTlZ0d1MwVVgxSUxDR3BIZFNLR3BWa2x2eWIx?=
 =?utf-8?B?cCswMG1nbzBFR2hab1RuYjRrK2NQNC9iSWRzMUxxZVJLMktSa2VyU0c3WWpx?=
 =?utf-8?B?YS9BdjZHTEVuY0Frd1M3RlFCaHVkTFg3bGxwQ3BTNlR5RHExSFhpV1Z1TTU1?=
 =?utf-8?B?d0MxUElGaTlsbXB5SldNei9oMFBmVkJQQ0VYMmhwSjJGZmFwWmt2Q1h1NmFR?=
 =?utf-8?B?eWJzcHp4U3A0YnhhSXFBYnFpV0ZobE02VW5abWJZWWVEQ2lFZEVHaHhnbnA4?=
 =?utf-8?Q?AZV8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d8c2f5-b6dc-4ed2-2898-08da877398d9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:59:38.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdS+o3SHl37eV6GrqS8HH3wUBIUSZ8UAFmQSK0je+n8tzPq40SpsoQchcJ+tZ+1G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/22/22 08:43, Babu Moger wrote:
> Adds a new resource type RDT_RESOURCE_SMBA to handle the QoS
> enforcement policies on the external slow memory.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index a5c51a14fbce..6c38427b71a2 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.fflags			= RFTYPE_RES_MB,
>  		},
>  	},
> +	[RDT_RESOURCE_SMBA] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_SMBA,
> +			.name			= "SB",


For some reason some of the messages are not landing in the mailbox.

Yes.  I will change it to "SMBA" instead of just "SB".

Thanks

Babu


> +			.cache_level		= 3,
> +			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.parse_ctrlval		= parse_bw,
> +			.format_str		= "%d=%*u",
> +			.fflags			= RFTYPE_RES_MB,
> +		},
> +	},
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 1d647188a43b..24a1dfeb6cb2 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -418,6 +418,7 @@ enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
>  	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_SMBA,
>  
>  	/* Must be the last */
>  	RDT_NUM_RESOURCES,
>
>
-- 
Thanks
Babu Moger

