Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A48587BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiHBMHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHBMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:07:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62CF33E0F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYYhvpkHwUNqYhn4aawhLOP3iGobYFjardCsBMgbCffICBxlOOPatrhCnS6s8VW1oeBjdpZAwWnC1k5GN1zdhfm2zkCxT89BpT8OFbVD6wT+CAZxR0svTVjhmqn1+Fa2TiurcUbIm5FR7yFdE7Dbiov7Lu/LssK/nCAZguOV7tkAehxOGKQZgyBNcZK/2zDyQHkCp5k+anzLZ47JKIaK+icxdy3NMWPpIyMal1KKZL+aT71+gLy49HdIqt4dQLB8Auw4YyMS33+fVOJKHPlA+mUzNQk2BBdbU5DhVXLHVmtk4Qen/3OExwF304gDma3tsuFlB9koLfXjfkQDasivaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut7lYH8Oa2TaRI0BkPyTwbFYSycLuuTeNSMUc5yLEdk=;
 b=ArhuZ3bzygmTTm4q0c5XWOaXj+0r/LG8zwgZnGKnsmbQ2u8gCblgHpk2hDI4EiAtlFi46C3PGkrZuV5hLHlHMTYRGVi2AE3eAItXaPqNdkA3KhjAPNfxfNWjCd8gD0DLAVTKb3QZ+FgLF206uJNWN7wi3xa4es9LBAhijMnEdE2eaNFoYfyy5o2r7sFVT2GIex2rzSDPtjtghcp0MY1nbrJUrPRVER1d6hit662MMruXxnaWeDbSdim2PlaIelR7EweXE/0S26+LMESmFOSZtVAfOIhNv+dE/WbtSr+HweOPDA30kzeH3wKLrxcGSWj47iRvNCkfDXuM0aXR3SQQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut7lYH8Oa2TaRI0BkPyTwbFYSycLuuTeNSMUc5yLEdk=;
 b=Cp1QBsF3QAbM6Bnoik82EBp7NmwAF18b+ZzN4trrt5Xxxuo9hT9GfaIl6jQsMuMjmuhV32HuBPb2GKHtxvEqaVtMoKABgY8XVhu4Tyv3sC+cjIrUhCgDjSyiPk2LYbgmrB3X0qwNTx7qIJi5m2xiZEoRNf6jmg6pDykUwt+9rIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB3698.namprd12.prod.outlook.com (2603:10b6:a03:194::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 12:07:37 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::899b:b076:6736:1b8f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::899b:b076:6736:1b8f%3]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 12:07:36 +0000
Date:   Tue, 2 Aug 2022 12:07:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH] RAS/CEC: Reduce offline page threshold for Intel systems
Message-ID: <YukTfuX3QmKV4msI@yaz-fattaah>
References: <a871b8bd35604921b842dcd65aed0f6c@intel.com>
 <20220701191239.619940-1-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701191239.619940-1-tony.luck@intel.com>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 673f6ee0-00ff-499b-b33d-08da747f9641
X-MS-TrafficTypeDiagnostic: BY5PR12MB3698:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIR25YuwT119mwUXS4KfLYHM5yrA3s9vQ+96gKU6DK085jF9zYI5OGqKWK0Bl160FmTJbhDYAUPsIlbabS8Q17r/zDgaML4Qw/6pvivvSNMWsqkeP9wK5jajXciQ+KSk+y08HrcoazlO3dfK/5eajXf8E3p4eVM6lb26zBGrcwnbyH6al/kcqWTBPWZjAmDafKqYCE1OoK/gEalxPV0Igmw3bF5lm0Ttj8+0t30oocE1CG8Qx+fmtJGQNlNxqB0z4gP/pdSROf4g2x2kllPw/emU0/bsxv3XXpQ/Ln1qXAEiDSkp6JPg6e1XX6bn6nTaxq28OYfPr15vAfTDiZLKqTO+RUBHH9PeF/ajvKMkOowWm9XqlE3HK9fuEmUHvnPUxMhBOjVqZyVcHF/TIFB5XTX1tnNrdr3aOISGmNiY0gvUmvcfe1ne7PVH2LVhfm9U5kNxct1FK6GoCEffKfU97Dw2hcmVOcBGWSFScay4RLsRXE97kaMskx/6gEXFC/srLU6fyHXNQwj9aHKcMIXbXtvgXCsoTXUnZnfMbK72exepjA3UAId3gfUgZGMJceoDx9g3hwlwZxFyOIcbEbHUwTudV80l7/8UAh2rbwMBXcUbHzVDE80LrveJnr3MT8lX4AlYpmtmeF7xIKVXREVDFSq2OhdeX1Ocv7VOvdHsIm4jBku5WgbYl32ownPYj13f28fm8PcJLe0ds/NPe74LP7HBlZmVmlIclJFrnL6pGWkdAOOGFh0Cav4yDpxL6EKf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(6666004)(38100700002)(9686003)(41300700001)(44832011)(6506007)(186003)(83380400001)(2906002)(6512007)(6486002)(26005)(478600001)(316002)(4326008)(66556008)(8676002)(66476007)(8936002)(6916009)(5660300002)(33716001)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tq5bljjrvqALRCxz+jcS9woNCCxhhFsTzyEFWu+nwrw57cCzi8WLkED8mGYv?=
 =?us-ascii?Q?rBqAHeOPDbiRSRusbJnrnnosVdxjAyg8U5lDJWzeQVvNlYtFKzlxZnxE4Wwq?=
 =?us-ascii?Q?+AcyXc6HWaxBTDsfIn+3HCbvHuwDNQnSmBuyewRhByQNAXY1f3EIrGU2+id1?=
 =?us-ascii?Q?ILzE8UoMxZg7QktTv3o6GvtuSs0qPOAu/BdiO9YAo8v9HQSoP1IGod8WA5MV?=
 =?us-ascii?Q?SP1dfGPBV0ARprVSq2yhYMwb0YHGH0DCp5gzZluHgwM7jWFq4fiD1Dk4p2yc?=
 =?us-ascii?Q?I4JejVqJBqsXH8hlpYiBpLAReKqDcZ3u7YIC4KiWGWCFVhwqTjUuli0sHKth?=
 =?us-ascii?Q?iO2rN7qubCUAZyZ64XMXwoDNdU/FvMUPxZ+Gef3Yi5ytjqZz/G+aSfzAExYH?=
 =?us-ascii?Q?iCBt0ILAHDruZG5Y9Ppqw5cSb/nD6LwvN5RZg/zCDAyWIfl1/epnfEz7JvkQ?=
 =?us-ascii?Q?6CLTRXskd479kHxYqg+wHusvMyuWV/Ftyf5Ds8H6iNxY6SunumUPkv3XmcXl?=
 =?us-ascii?Q?biD2nvsj2CBK2C/YSyUHtU6eR9dT5Ijy6gp+sx5vA5dWSogpSPraai7tT5So?=
 =?us-ascii?Q?huvBm6yddKGzBtRQksPPUAeDmhP8ZHE8CMdQiPSlDvqIjU2IBC6DoAY/QCrU?=
 =?us-ascii?Q?pU4GS/xMfq7IHsYOHGk4BfVxuD47pR+XzBNgw4prk1rnkPlVxrndZXrJLxFF?=
 =?us-ascii?Q?599pJdHuIKDLNvkz791XwElSTducOcuEnYqbAa2ahlCMBHqQGOHswpHo2gaJ?=
 =?us-ascii?Q?QEb5IYqVBD+vwHwNg+yAUU06TzuDXVoQJ/PfAcz9BubWHePNy1mh/6rGxZx5?=
 =?us-ascii?Q?hq6QPXhNehbdTFoZXu2XUuO7/suu64D/3EejYnVGpw6hfpuIqaKCXMqT3wdX?=
 =?us-ascii?Q?sdc+fcZR+To97USLR1KfPboOxGVzlrhvMc20Bqc1UxaktUk7z9wtNt1UmQcM?=
 =?us-ascii?Q?nVhreO+elidTJZyP/T1396/SmZJKvWijTsc4k2KhsYuX6mB+Sn9setSDvClY?=
 =?us-ascii?Q?GEuAmj5fZNhZTx06iF0oYQjhc1pTavXzz709ci8SOyrCs8MN54F9IcegDFQi?=
 =?us-ascii?Q?neX/81kICuBKt+LoUoUywb0KFu6fyRTR6xrQzOkiqMezaGQXaXLyCeRtfTP1?=
 =?us-ascii?Q?/tGz70VdhxE1pWEkosEw6pReZWomylfzesTe3hNeSEVoQPf6+1esWtlZjxR8?=
 =?us-ascii?Q?lCEW6FcLV3xSZA+XprfJk9Jt94WyJ+T5Ju7WJpo1aGcqWJXMm6wI6CkcmiSv?=
 =?us-ascii?Q?DAeECFJ1rh8SFnsi6+OZQbQWd2s7PFSMwLo54TSZURtl6bUOsL94IkjqjX+9?=
 =?us-ascii?Q?8Nz7M1haC9O6+KkCGsJy8pDapioaMDuencv3dvHqZnW55EHnc6gOA+xOElTF?=
 =?us-ascii?Q?apJbnVm65hYXMmHmFUqDSiZi/sekwWYqNHEuVl8vUCeqJc18M8N/+eZ/IOue?=
 =?us-ascii?Q?kXsKi8A/3538MRKZjl7m+2DpLIxSwvwBeGgIWD1z20aGslarz4XR70OhyPFv?=
 =?us-ascii?Q?qtWGD2ukOg8KAbQheEa0IPnt7LpnkIUgy5ZBikFbcUJQYdbc5xkzSpCQXPzv?=
 =?us-ascii?Q?/1+6FlEJU16Dr3+EjWczuuB4XGLVo3oF03v7nBGD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f6ee0-00ff-499b-b33d-08da747f9641
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 12:07:35.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W6Vj/pzEQkLf0FvK2rcSocg3oirG5V2mnWGnTtNIrCJSyys8mrAGU+QmheVl0iV/yq5+7jKxJQ0mzV13LDggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:12:39PM -0700, Tony Luck wrote:
> A large scale study of memory errors on Intel systems in data centers
> showed that aggressively taking pages with corrected errors offline is
> the best strategy of using corrected errors as a predictor of future
> uncorrected errors.
> 
> It is unknown whether this would help other vendors. There are some
> indicators that it would not.
> 
> Set the threshold to "2" on Intel systems.
> 
> Do-not-apply-without-agreement-from-AMD
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Hi Tony,
The guidance from our hardware folks is that this isn't necessary for our
systems. So I think restricting this to Intel systems is okay.

> ---
>  drivers/ras/cec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index 42f2fc0bc8a9..b1fc193b2036 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -556,6 +556,14 @@ static int __init cec_init(void)
>  	if (ce_arr.disabled)
>  		return -ENODEV;
>  
> +	/*
> +	 * Intel systems may avoid uncorreectable errors
> +	 * if pages with corrected errors are aggresively
> +	 * taken offline.
> +	 */

s/uncorreectable/uncorrectable/
s/aggresively/aggressively/

> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		action_threshold = 2;
> +
>  	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
>  	if (!ce_arr.array) {
>  		pr_err("Error allocating CE array page!\n");
> --

Looks good to me overall.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
