Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3329D4F4DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582708AbiDEXtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391133AbiDENrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:47:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB19F3B9;
        Tue,  5 Apr 2022 05:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isFscoz7YDPmJeWihwxAWzgqHNtZtXLUcCwz0G/F5RCIRPOJluPgCB9QMR9tA2k4C5MG4b54dZd1CyZJFEucWJ9LMtCQZuhiXwmT/VMaBYA3vzkhVnnbQ2mbr/PQ6/VgUQo3LkHLmN6uq8kk8dRI0yHAkGR/Ea3QJOwcUBrPwrsMbaqgA+Nrsgj4VQkwTvS1pkOJzwQbKTdUwtFWfntnr582cHIidNrMYcc6lOOb2oqmAtTDpVd4J9olwKORsrYiyLUgiJeANefxZRUX03p5gfZg52S4mQljHZzLmviFiTLKJILnnyEHzRgF8EJ+ReChWs+zsiyrLKHAaKarrhITTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTf/+FTG+3n9OUxcNBvDMXAzBTLyqGP4sOosI1NRoc4=;
 b=B64LksyjdrTnVjCvCnBPp43kE7cZl013MtaYd3nX8C4lBzkxgT80K1ZAjHtUZtERBCAUjPWqPzNovCI7hK2Xx09Ddi6Nm5+5JjtdadhqSDs/8tTov7gJ+4SvZkb1mrdTic8/NKav+PZVcbsYr5n8+hYRYNJnXDh0/ZAaKGb/EiiMkTcERL1He98BUDswBlg8G6u+NnvT0U4tvjRBb/l9WqMvEU83REUNFNfpVeJ2bifG+PX+P8gFi5QyaVLCWGrIcQGHBrD1KpWh66g/PMOkqhP5ZVFE0yDS4I4/G+7F56j1awq3InI6AvcKesI27o+WjiDwVw8HGBUjM+BxFUSnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTf/+FTG+3n9OUxcNBvDMXAzBTLyqGP4sOosI1NRoc4=;
 b=dNNzmnt3TH1cs4b03RNDydW9NBzRp63MNqItc/08CDe6BFxk7vOeMRY+cRYvCllEKK8aS3DuFfuZdYEOghrDi/Z5M1dCO826+VBcDza24T08aIp9v+eOH+SNyjISIid/tpqikHlv5UqTiaDYDY1DJou+AUl/VabP/tp/Ry3ymfsua3r2CToQfwjWGIqvDUL6AE2HYRvc/riDx+WfAeS1DhsX1lvf3oZAuDT/pKBSf2f3ojcY1BLFz5VUD7YUJTHmzyFfVZq3ZmhzGiEnIOUVDn/A0rNpm/SpcrxJb3KdqF7kKRvLYlgNpBIctARtDUzYQcvMjCtre0TeuoVvgkUTRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Tue, 5 Apr 2022 12:44:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6%4]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 12:44:13 +0000
Message-ID: <a31d9fe6-3052-d09d-c012-3e141a4ffde3@nvidia.com>
Date:   Tue, 5 Apr 2022 13:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] soc/tegra: fuse: Add nvmem cell lookup entries for
 tegra194
Content-Language: en-US
To:     Sagar Kamble <skamble@nvidia.com>, thierry.reding@gmail.com,
        digetx@gmail.com, yangyingliang@huawei.com,
        ndesaulniers@google.com, pshete@nvidia.com, nathan@kernel.org,
        kkartik@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1648123728-16737-1-git-send-email-skamble@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1648123728-16737-1-git-send-email-skamble@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::44) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe367682-3bed-43cd-0808-08da1701fd2b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5464:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5464F56E3B9DEAC781A61F2BD9E49@DM8PR12MB5464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Kra9c0v8PhBJENxk8Q7DfIsCEup9pMfjugp36FUt2d3/e0otRNDCmH8ihANOkV9NcWGc9TfZ28KlruZLiPZaAINJxusaisNlB7HkMbw4ka0Xsq2DeDZ0RSXSuuC2LW2xLFN5oU/pSTFQVZT9TgWbuxPNpLhwFdCuYx/9XDJiAA87CM2Z2nLwsnfDo+kCHBHxBoBZp31p2vlWuuULb7N3wabBcJ/JcDUfhdBNnO0NoyHfOdKYIoyyazI607VooGfuMID2ZT13C5lqUmv2fFsCbYwrYcqrihqeT1K76E66uS/9lUNPS+mNvdIN0RRyhjDNrPS8RgW5Q/InzvhM6HCnrdhkU32NG4F5K5pASpNl5zQoP5zoQXFUCzcJV2gzZth8VOrVGwRMI8a2TvI6I7DwTGyUitN0GUWaO1z9q+fvvw8HWHPs1BiEAX60Q5biwjyUJDS2IGOxottZNWal5tCZU/FOJ58q7m1ITpKmV23Z5pCjkXqwzptPaE55r9If+VlqWKRL4oF63UAWMWsh2BTuuK+P+4R4czKYYzHShDuzZFSKKaUsy8sk8Nx0xxtMPdERV0rjVZw5PaFINSRI3v67QpP5pwcRSswfNbpMIujaXievnrzTP8SQWqFqGPN/3OzSmtz8qUcAKA2AYuuNBK2+/IJYOS6K7V+IoHzSTJ/vr2PWdnXx+24B2TGTV8y78V4LarqEpIchuiMkP1DOAQ9apHvVTtD3zx1R5E7MfRXvGSJQ3JIifE/OjrfGgQl5yVU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(26005)(186003)(53546011)(66946007)(83380400001)(36756003)(55236004)(31696002)(8936002)(2906002)(38100700002)(86362001)(2616005)(5660300002)(8676002)(921005)(66476007)(508600001)(316002)(6512007)(6666004)(6506007)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZZVlBxb3RSVDRsbUdrbEdwTG9Ud3V1Wk9uNlFZRWcyV284Rm5pOU56Y0lR?=
 =?utf-8?B?TE1TYUIzVHdZb0ErQW5JL3hoL3h0SElKTEloeVdkT2M5clByQS9BclVuaWNv?=
 =?utf-8?B?c1lGZWs2MEE1cGVCUitjbkpGNExYaFhHa29yb1loM3dacTBXTXFuWWhmLzdH?=
 =?utf-8?B?WFE5OFFCT2Z1aXZ1Y1loY1JxOXBhMFZzTTNKUDQ5WktwVyt2bG5PbWJEUWF5?=
 =?utf-8?B?R0h3SjBUZGhUUEdXSTNONHc3cDltN2lFT3lpa1RPdXRXY3lKZnJZSlM5eXgw?=
 =?utf-8?B?OU1XdjM3ZXk0TWRRM09RV214UFBSek5SbkhyZ2FsVTh3MDl1eVFuWkZyZWI3?=
 =?utf-8?B?V1R5K1VtYTRBekprK2U0c2JGVkNyZkxtZ01hWnloN2dOd2MyZUQxMkFpRHdi?=
 =?utf-8?B?NTIyRzJ1UVlWS0Y2dlJ1UExsd04veUNxSTkxaWxVNnBsYUlFdFYyMnE2bW52?=
 =?utf-8?B?WDE1dkM4SmJvdmRBSnlUMVZSZWZ6TkdDY2lPU1lUOFBHM0lzWHVJbGRYbHJP?=
 =?utf-8?B?VC9jVkJXM0ZIUlliVU15THJZdTZ1QUdNQVE3WFRSWVpnSFBDM1duVTB0bUNp?=
 =?utf-8?B?cDNENjJnbEpMUE1acUxYaXNsS0dYRlZjTkR0dEdjdVVkWGdkRUpXS2o5anc4?=
 =?utf-8?B?RGNHc1RnWFRRVkxzR0hySWM1S0d1NE1PYXZjZzBiWFEvS2UzZitta2hIM2RE?=
 =?utf-8?B?aHJ4TWZHTWozVDNQby9CWkQ3aDM4aWRxeWNpWmpUTGZ2UmFObVhZYXJrWlhu?=
 =?utf-8?B?ajJkT3dtaG1JNW9ka1JKNTdlbE9YRS9qZ0NtQ25Dc05MeW5kdUJsTjVYaFlz?=
 =?utf-8?B?Q1ptQ2ZRRDBHSzVhOGgyVE1NMzN3UGhQcklOZFcyUWYxMlgrSit0cU4vQS9r?=
 =?utf-8?B?N2F3c3A0TlQ1NTkzUmhyV0ZGUitZbmRQb25QNzhLK3dtemRXYVFSbTRPTDJI?=
 =?utf-8?B?anY3TEVtbVF4TnZMZ3h6aGlOVnh4SmJsVnB3S0kzMlo0dkJ6WEdFQ0p1aVJp?=
 =?utf-8?B?UXBHVUdyTmQ0aWdMbjd0VXFuWHhvNUJlVm52K3dKNFhCRDY5U2ZJVHJTYXho?=
 =?utf-8?B?NmFZUzBUOWxYZzFhZGlVQmVCK3BqZmpwbGhLTWV3dzJoYzlLbDNYUmg1ajV6?=
 =?utf-8?B?YWRiYmR6eVhuV1c1NGM1Q0lqb3FWUVlpNTlCQ3ZjUHVGS3pQeEFNUThsTVdG?=
 =?utf-8?B?ZXRlVjdWRUg3ZFdRR1dMU2dTNWliL09kSCtZd1dDZm5HT3NBUEpMTHE1dmVP?=
 =?utf-8?B?Mzl5WWc2eXlrbVRmcEU5VEpGdW5Kb3JrZWN1N1hmdW9vVjVQdXNCVTVlUmoz?=
 =?utf-8?B?QjdsbEJvdm9aajU4bHFPTXVkOXZ6dmozeG5zRzNXOVJnRnJJVTV6UE1TNHFY?=
 =?utf-8?B?Y3p5Y0s4VTBVRG5FV00rODZDbmlmd1hGOW5xc21jNGN2RWxxUWo1OThHY09u?=
 =?utf-8?B?cnp1bEN4RUhhRmIwbHdyME9BSGlza0pJbVNJMThreVZJUGdzRGNXaktaTHR1?=
 =?utf-8?B?OHN3ZGhEU2kyR3poaDg2TnZBc3drN3VabEVXNW8xeFZUL3FKcXozSVFkNU1j?=
 =?utf-8?B?R2N6R2Uxb0VacGoxWEFMMjJHSENQcy9rYW8yWnNRUWUxclNad0M1UXFYZWdB?=
 =?utf-8?B?OFVMTEdONytFYjY1Yy9wMW83REdXWlBCNnY2ZUtOaXdnb21pcUcxWGNKUFJM?=
 =?utf-8?B?aEJ6MjhvYlRxbGlrZzRhUTY4ZDVhemdUVnZIbENxSmc1bytNK0daT3I1aWdY?=
 =?utf-8?B?OU5aRjU1Z0hBR29OZ1hSMENaWWhuRmtGUWpqamdISVVqWkwwTHJabnlFYkdn?=
 =?utf-8?B?bUtZWkI2eGlCTzVPLzR6OEVlbHkzYnFGdkNpQzZsU2JZOW5wYm1BR1pQRmZy?=
 =?utf-8?B?TEtCQnNqQUF4NUNPZ2RMbHRnQWlQK0IvbTduQXIwZzZkU2p4eFJLeUc3SlB0?=
 =?utf-8?B?U0pFcVZkdGZJbWVZV0xVN1J4eTJMZjc5a09kdVorMVpQZElOZUQvWnF3T3lj?=
 =?utf-8?B?M2d6K2lmaG12VElwOGhBaVNUZXEram5sVTdPN1BpcDdkbkg0bTN1Z2pOZ1o3?=
 =?utf-8?B?QjFwak5EUzAwZUNWbGFld3NZWlpkME1XZTFKY2pVMWZCeUxCR2xpYXlIVCtq?=
 =?utf-8?B?eU5RY0FURjN1UzhDOFNCUmFPSEozdkRyRzFCOTdyc3dJek5IRC9QdTFpTy91?=
 =?utf-8?B?Ukx4NGF2UnhIWmZUOWtyemphNFErekgrYWg3NWdCNFB1TUJjS2pMRU8vbXpt?=
 =?utf-8?B?d0pBelRoMDNrSTErTTZlSWZnWWE5a0ZBWWY5N3hIaE9hSlg2ODZmcXJNTW9r?=
 =?utf-8?B?cHBqZWM5OHpTK1cxS05vUENFSlhVbTFLVXR1WmZqcUxGL0JhaGVtVTZ0ck5F?=
 =?utf-8?Q?3883p9IVLfnMk/FQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe367682-3bed-43cd-0808-08da1701fd2b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 12:44:13.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4gSP6/xIMNxu8Bh9zYeyo20z15DQgI7+2MH6HCpcOZHeH6K9aib0kzPqmgYxZyHJvNX1vJFbdk3mqowsY4tXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/03/2022 12:08, Sagar Kamble wrote:
> Add nvmem cell lookup entries for below fuse cells:
>   - gcplex-config-fuse
>   - pdi0
>   - pdi1
> 
> Also include the device name prefix "gpu-" in the names of the gpu fuse
> cells in nvmem_cell_info.
> 
> Signed-off-by: Sagar Kamble <skamble@nvidia.com>
> ---
>   drivers/soc/tegra/fuse/fuse-tegra.c   |  8 ++++----
>   drivers/soc/tegra/fuse/fuse-tegra30.c | 17 ++++++++++++++++-
>   2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index aa94fda282f4..b0a8405dbdb1 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (c) 2013-2021, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2013-2022, NVIDIA CORPORATION.  All rights reserved.
>    */
>   
>   #include <linux/clk.h>
> @@ -162,7 +162,7 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
>   		.bit_offset = 0,
>   		.nbits = 32,
>   	}, {
> -		.name = "gcplex-config-fuse",
> +		.name = "gpu-gcplex-config-fuse",
>   		.offset = 0x1c8,
>   		.bytes = 4,
>   		.bit_offset = 0,
> @@ -186,13 +186,13 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
>   		.bit_offset = 0,
>   		.nbits = 32,
>   	}, {
> -		.name = "pdi0",
> +		.name = "gpu-pdi0",
>   		.offset = 0x300,
>   		.bytes = 4,
>   		.bit_offset = 0,
>   		.nbits = 32,
>   	}, {
> -		.name = "pdi1",
> +		.name = "gpu-pdi1",
>   		.offset = 0x304,
>   		.bytes = 4,
>   		.bit_offset = 0,
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
> index b071d433d74f..f01d8a2547b6 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra30.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2013-2022, NVIDIA CORPORATION.  All rights reserved.
>    */
>   
>   #include <linux/device.h>
> @@ -344,6 +344,21 @@ static const struct nvmem_cell_lookup tegra194_fuse_lookups[] = {
>   		.cell_name = "xusb-pad-calibration-ext",
>   		.dev_id = "3520000.padctl",
>   		.con_id = "calibration-ext",
> +	}, {
> +		.nvmem_name = "fuse",
> +		.cell_name = "gpu-gcplex-config-fuse",
> +		.dev_id = "17000000.gpu",
> +		.con_id = "gcplex-config-fuse",
> +	}, {
> +		.nvmem_name = "fuse",
> +		.cell_name = "gpu-pdi0",
> +		.dev_id = "17000000.gpu",
> +		.con_id = "pdi0",
> +	}, {
> +		.nvmem_name = "fuse",
> +		.cell_name = "gpu-pdi1",
> +		.dev_id = "17000000.gpu",
> +		.con_id = "pdi1",
>   	},
>   };
>   

Thanks! Looks good to me.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
