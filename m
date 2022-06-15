Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCE54C092
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiFOER7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiFOERz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:17:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75312459B;
        Tue, 14 Jun 2022 21:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI+MJz/Q2eieQ/oWZ405vO2OArsgGIYE9usNciL++BUloN9KV7BAjlka3JVljpTCWiPCwj4vaQz4RnAyP91npHkop3cvRpoRCgVkJF6CVXfBfaECd68BusRTpIxowRx+z+4uoaaMh6Dcnnu2r04Y56hplXNdLsNlE53sIylA11bcdrlHBlG1fibcmbo6m7ep9QdgJLxAFWDbGdKQkVvJBLJ5uYEBZfB+N7qS1fhQ1KfX++ZVKqxkHYoDWRtD0Ecsusq7kdNUUAx1RiRv+8bp6H1RjVcG1azD8u8P8fbsevMdgG/0GeshqZgYs5noWknofA3Z/XFAj2iW9mt8JqK+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anReXuPXegoUd7AxwXBgQvRq2aCvYj+xNqpFIFvylWA=;
 b=ZIIVCEJXIo6v6Bn1Ihnt5Tnk4T4MRV+TWL8sTjdEG/02gALheef0X1ZbaJq3ZjGc+/xXe+FI5zUK45pQEhkz5FEnjYSgDa+fZV2iQBwP/ySsbN+YRBSbhXs+haN8h+FhvYdiY/CuvIFbbDVurl4kYRkecjXUxxk2/ZTrvBCTettk21xUoGaHSzv1Vwf79lKL4oWEfr/Gu8VY0c3BPSOxAJdjnqQlP7+YLxt3r6gbnsmmPAP0VnyQYxz+Icdpuk9iybRzOLO7cOPR3jWhY+p5bNf/vk4+8UfblaQTgpYjXqHg5YMNV4iB7ZN/la9bEzPXL4pf3DadvOYLbA9rOKzgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anReXuPXegoUd7AxwXBgQvRq2aCvYj+xNqpFIFvylWA=;
 b=fFbM8CbXhCCEtYFBkQZAkFpcQVef/dlXcNxJrWhkmNC3StwKVf+iT6FgiJ0xdSjOwh4Lam1tYlsoUITy0QxfDUApGwIreCU7guXsrT5Mc8JSrID+IRNnyml7vr+q5Sk/bshejqkaQwLPiE57beZO2UZwC3y8wcHu/ZlNHpDde/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MWHPR1201MB0080.namprd12.prod.outlook.com (2603:10b6:301:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 04:17:47 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5005:bad7:e9a1:4275]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5005:bad7:e9a1:4275%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 04:17:47 +0000
Date:   Wed, 15 Jun 2022 12:17:22 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] x86/cpu/amd: fix the highest perf query for new AMD
 processors
Message-ID: <YqldUnctvKvNcAED@amd.com>
References: <20220614085255.256600-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614085255.256600-1-Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39d45e5-5f9d-4f9f-2349-08da4e8600d7
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0080:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0080283C32547F979E6F47D5ECAD9@MWHPR1201MB0080.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNNTzJfpJ+JvZ7bqyrQZxnIZ0cmqp6ec9MSCG6sZLy7b6oNbT0JkrtVCiRUVQGh33b8U1LzDTne+lABQDw4qeBQ1PUPnJnB+z3zJROzIkrvDajNK7m68aAcsINq0HTBYhzEIHaaeM7roGNRx7mKpcXzPeMrDDnXOJrvOwjNNNNGPF2s2E0+y4fHoQbLBGMArQV1pnkZKzlwxycauUfkVtLdMtHRY6X2bgJcBsX6cCPSK8ZDeGoPQT0QfHeS2vHFJxA84uY7DrrhIHpziZ1r7O3uC+DvFNLNfKBYzzpiGiJZODy86/PILwF2RGsg4Yvh04hycAPH1fojNXu3hBFw4pOLMkyqKq0LS1koaqpX7yQB0UkYPomCd8Pm/u88w5RZJeOE+dn/C8Z19nePjI4rH4aB7y72gy+eBcFDJYYmWn72q9P2ZFfd+DHUsAwjMu6KIX1i8Exc9wdJwrG8V9tDfTOk9YBXYHoHvPWFOapKKFn/fLaIYZLHA9Ad6wCpR/yq3hrZz1FPmN88C6QYjakfPtTI1l7tsT/3jJfCm99txF+/MkaIHfqjTNiWGBdlsvEwxDT58OOjdQBcGikeSGDJA9LVbuFzeONzhGY54+YBjX8tEDe0teCOYsaa9NGTA8rYahwZDnpfwv1scVfyMRWqmlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(26005)(8936002)(6506007)(36756003)(38100700002)(2906002)(6512007)(6486002)(66946007)(8676002)(4326008)(86362001)(186003)(5660300002)(316002)(508600001)(83380400001)(2616005)(54906003)(37006003)(66476007)(7416002)(6636002)(66556008)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGytyWwUlMPrDjTt5B4AYUJ4Ugxf77IuDmjuT6EXK++F1c3mArz5r2QsdAla?=
 =?us-ascii?Q?ltkJtCzMOp8BpJd2HKTWod1jXKbXdVsII7LcYvCGf1eEF0EgNB3m9Wvcz8b8?=
 =?us-ascii?Q?MWRGZjmhlZpSQEfc/UynUuy1H6R0hw4tNwVi98Wez1Ni2QHZTa2DbUKZZXiF?=
 =?us-ascii?Q?94FRWUQjAKsc/t1x3KFqgYIqq2eN+da4Tg2YIHvVuP3hpHoSFpkrIG3Zzcgu?=
 =?us-ascii?Q?xPdwr3DeCHmTFRb8eCthrpYOlcI5BKL4H9ncT4bTOgD/JsJuUxoUQc6gtwVN?=
 =?us-ascii?Q?ZMxT0XGIW7bK8lqgI6WZ5zpMy+NPuBa7GErugbOky7puE/DXWkHN+F5qOzlm?=
 =?us-ascii?Q?JL9kW+T+2hqR3PgWMgiKT8/RnH6Whd9s/lc1Wlb1drJm9tU60lKmdBIRnv9j?=
 =?us-ascii?Q?D0N45QXHemLV03mbKdmOiaQZBZxOTGCTSkvGXN6BGjYC0D27bhaw61lw9uD5?=
 =?us-ascii?Q?uisSspFmSS/JqtmPeWJA1n9LTuJ5xbbgS0LWV2YhBWVCs0dGSpLLeEvw9YqT?=
 =?us-ascii?Q?fEjL02oh61YhoI96ObEOE+PbbEopk6CA1L6Szx3iODwDkolpf8daYiyPzApl?=
 =?us-ascii?Q?wlH91OlriY7N4dQJ790ga9s0/mlWOBzmvgMYG59HHR9Ob8QqsGAuFR4W/GzI?=
 =?us-ascii?Q?LksHX58asIkAOcP3/5cVOLTR7XZxmIcmeu4ou/KcmnIA7R+yw6TBMXobHaWK?=
 =?us-ascii?Q?nCBEUUhlDEf6OdcYomxtBLX5j33YPjkAvAU13oT6EDpdKw3vi2gy+61cbmL5?=
 =?us-ascii?Q?MyY4sWcvJF9uGBMOstOKFDv2JNjR6BGzO7ZdZT6jIck4UNo/9z7Rlw/pslLZ?=
 =?us-ascii?Q?J2NaFCkQKPTjQS89KikP8LlbThos3HL5Wu87XtT+VzlZKxS5oFhP7BdfwED0?=
 =?us-ascii?Q?MWj29PLI+jJLMYCgrUquTFsOxrGt54EM5zyHpC4+SzFXnRbebOKFSxP5DTIe?=
 =?us-ascii?Q?lwgJGKWHK9Ta00QDC4DyOeUUXJ5wSJrPNToAj35iUyDVkIgRd2JqSPPwr7xR?=
 =?us-ascii?Q?heZ+E9paUUzPVv5jkxT+9nrBZOJT8t1TegIklkVMl8AHOIg8+3c1ZLLLE8Xf?=
 =?us-ascii?Q?H8oY6cYqAOAUDFx/PEigORcScvp9fXvhZsHKuowxnHnFQ9rZssA6FDcv23Xg?=
 =?us-ascii?Q?V3tfef32P2MiQGKZjI3Laaptv8AS/EVLswIWQmin8sddLfhnm0x6tryH61tR?=
 =?us-ascii?Q?FCdDmGXNOdPKE4MI4nAU5JUFu5VY1O6WHg2Yx9ELhOra4ERxQAvwltwxtMzA?=
 =?us-ascii?Q?SWDtazxpw6S453IQUzp7zguMgIhrkSqfxmVwDpgszHUzN2IEjJVQ1VDmrNTa?=
 =?us-ascii?Q?J7/eRvDREP6R0gOcUMkeOgOp9NDEIyS/QIb0TvdcBZHFkNXvBwFdlceAmSrg?=
 =?us-ascii?Q?UBMhgArStC1s4PBZxfpSmrfk5JZPf8FLHCEhUizVXIPv4SzEuaekdvniKy64?=
 =?us-ascii?Q?7hHDHe6tHoZ3z6ns8piYmyAP6mCC/jljx+N1yZBK6t0dnXq2A3MZAywqOvj3?=
 =?us-ascii?Q?wStcoevgj+icJfbl1WrgUatRb73AS6iVMDNJO1ySqc4xBzMzeBe7gbayt5tC?=
 =?us-ascii?Q?ASTXAOFZKlwXbhgWRwzEHxesrTFX13E4rJbn8g3p106QVPuavwsue/723zt5?=
 =?us-ascii?Q?f4eoUgy8uiS4SnoJ4AVj3uLKJLvek+TfdxzYGGURpwvS+VBcQ8xrBqxuZuPC?=
 =?us-ascii?Q?L29geTVWU/pdrJ/TzKP9DFRAggGVDnUjsRYYph4keDoYY5cFg+q1D/PpkY/P?=
 =?us-ascii?Q?KziuMXq3jQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d45e5-5f9d-4f9f-2349-08da4e8600d7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 04:17:47.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+xeQoALLT05wHotTC7QaO2mr+ojzoKwfABI9TEYmx5aQsSFGAyaC1TmeCYsrHeLnc1lwkrOxtSQZEOY5wmdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:52:54PM +0800, Yuan, Perry wrote:
> In order to get the corrent highest perf for some new AMD processors,
> the amd_get_highest_perf() call will check the CPU model and
> return correct highest perf value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  arch/x86/kernel/cpu/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 0c0b09796ced..ff2075f26ef4 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1152,7 +1152,8 @@ u32 amd_get_highest_perf(void)
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
>  	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> +			       (c->x86_model >= 0x70 && c->x86_model < 0x80) ||
> +			       (c->x86_model >= 0xa0 && c->x86_model < 0xb0)))
>  		return 166;
>  
>  	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> -- 
> 2.25.1
> 
