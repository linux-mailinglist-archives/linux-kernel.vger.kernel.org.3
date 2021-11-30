Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8665463EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhK3Tqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:46:31 -0500
Received: from mail-dm6nam08on2071.outbound.protection.outlook.com ([40.107.102.71]:33513
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239472AbhK3TpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:45:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVgRvGbwrLRucQ0EQJ82yT/s715TEVGieqRH13I9fDdFEKGVOBj8GmzlrZzvCiovJn78AbPe7/YDisdneipxnQHZVP611zQGK39EeR1BuLe4E8an5Xvu+UWFTwgZAMspPEd8OLzRlRVzQLmxubZY+niLHnQTKQhooSH4UHkYPXAI2DSdg0xab4SRyZSkzTKcttCMd678kW96GbpryDmWCcCCDSsuSoj08biTyNsko03OxJXD0XsXQPZOuwPQcnkNmXPbRtSNyb5DBzdfSeeyW+hH96QpRBNmsF65STtDGbal9XshrDUf/OSyT+qjjps6dhYuwtwZ4+vlfq3/IQlyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCB1w5q662PRcCvBUDjQVaQ7LaNBa5sVA3dnpGpHF8M=;
 b=SmVIvYqjMXQm/PHHBSiDq9TzdapRvPcnNPEYdNbti0DGWuGxA5pg5HZeRfT4szS5jugjhomAnbmq6QNlU82koRB4OGRC88m6jzz4DswxEIxk3uhh1pbSxQZwaGdifXVC62ngZujepNT2wYKvsw0awBrRoWE38h1KG2zLhNhA5yXiJgjCamuPVtmiJ2DGVUe6fZqXxP3YeKWfTTMOykkkJKhTL9VNYdgOnr6JX6OUuyOb0/0gdNWX/aTMRpfXroUSPmEUFcTt2mS7PpH73lIw2wf3IYWh2dwMnh9xqGK5bhh7dy06kVhS1bZdK0V6lYZfdBAndD4TIC9ekyLiJecZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCB1w5q662PRcCvBUDjQVaQ7LaNBa5sVA3dnpGpHF8M=;
 b=RomhShegv/02P8RFUfGIZqC03rbTcoyNZchVAkfB4mzi/ZZqQ8QzLo5E3gVcPKagw7P3GwtCZ0jzWb+QWdMHZhgyUU2vivnp73MM4RyzTEYvMsToplRl4R76NdhAiKTw3MAq1bkeL6IXXA31/2sH4cdvHVCsNZpXIdgiO54EYaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 19:41:34 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 19:41:34 +0000
Message-ID: <a7b9fbfc-c7e6-983e-1f79-189ce6dc983a@amd.com>
Date:   Tue, 30 Nov 2021 13:41:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 1/7] x86: clk: clk-fch: Add support for newer family of
 AMD's SOC
Content-Language: en-US
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, sboyd@kernel.org,
        rafael@kernel.org, linux-clk@vger.kernel.org
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
 <20211125110447.1188073-2-AjitKumar.Pandey@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20211125110447.1188073-2-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by BL1PR13CA0306.namprd13.prod.outlook.com (2603:10b6:208:2c1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend Transport; Tue, 30 Nov 2021 19:41:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63bcf51-6cdc-431e-d287-08d9b4396a7c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382AEE752C11DFABAD10894E2679@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IImY4zBU7E8j7/JNrHlJfHCjSyCD4JJ5RsmLjupheQhPwFYalFDyoRrkXOksC7//BFSc/nHOV7pxfEAQC7+lbE1+MraHo2otrBdcR4I/O/gtxusyEdGUU6WZoO5MDR4A5QP1HAVzBBXt69WZEHkFmxXum9wcMOKuhh60JYqyorb3fulNdk3WWkfoeY6C6lgQRBRDpUhJJ3cJ5IUDxq2XC7Pn19EF8wLbh+f3UWhDlA7i7Aeu3sxeZo/hbZ/244GX/SoDFp6KOHtl96EngMqtjNSaKBBVTPdcxrkf9ZlOl3sZMXrkg7TqIh/8a+XlSzCgcPCea8O7gYhZh9BJu/p8Ht4K3UM9pjutFgYCm+5SBpgTmn0Qmk6QcFMVscS22RAjTPbLSw18wd9Q2rg220qjNZtBxDZbrPpFp7ITMzBXXAj5S1Qk72YBr1XXMgLUg/0EU1K1zCQirzS30utxWklnnxVRNZykg4owYeQ+ZPyTY/F9S2zIHTX/G83ePZtSEIzfPygBEJ2zAJIkdQCjlTqqjtvM2konLh35V4k200MwsxeGftzPam8XYtIArbBtVSduNL3+taNi6SPZkqVXx0FaeGc9Ui2HA9RLaLYrBAjdq7humNH4Yw7/GGRKx8bfFyAGYbSFwCqcTbDf1wkKXWSNM3x6QxbPZqT2CUQcvwPDtNp9onBcEjxiyy201T+TPq6e7yvOuLit2CZqR4mFp+446J2nbkr07yGGx2vAdUfzQ50yOFtzikhe92MaLAkjz+dh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(956004)(31686004)(508600001)(86362001)(38100700002)(8676002)(83380400001)(54906003)(316002)(66556008)(66946007)(66476007)(31696002)(16576012)(5660300002)(186003)(26005)(36756003)(53546011)(2906002)(6486002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pHVVNjbmZ4QzFRQi92NDdlNG9IVzU2dmRHTUt0dzN1U2lOUFAzanpyM1ls?=
 =?utf-8?B?dWlHOXhJREZjQndkbVV5V0ZiK1N6bjNpME9Fd05sTnp5Snk0U01SRmVUcVRN?=
 =?utf-8?B?Ly9VcXRrT0VlRHFISE1xVlB5V3pRWHh4NDVMTHYvc2pCSHBBbVlyUmxQWCsz?=
 =?utf-8?B?Z05VeU1QdFYreVFLNnR0UEs3WXVIZFZEWFI5N056Y1Q2ZEJFMjQvTXQ2UjJW?=
 =?utf-8?B?MlcrUmF2cE5MVnl6dkxlblV4WGpLZm9uQ0Z0WjJQQzhhRjVaek1hc1dBTDBB?=
 =?utf-8?B?aFJlbGV1NjJvcWM3TkRyaHFMVHoybmdISU9CQ0k5MGFQaXBLTHBHRUtPUXVT?=
 =?utf-8?B?SiszN1doOXJ0QTdTb2ZsVnRZNGVvSGNnL2p1N09WM1pSMzV6eUFYYVBObTR3?=
 =?utf-8?B?L1FhMFpEVFZEaXNOSHVHdjVYQnVIWXRwUUxpelNwc2pwWTRidkFIZmRoMFcx?=
 =?utf-8?B?VkhZV1lNM2dHZy9YMU1xbmJ1bnJMWkIyQUVMTE5mUVFETnhPYWluZEFkejFm?=
 =?utf-8?B?SlhHZlRQL3JURlI0eTRTaU1EMWl0bXhCMHBXSitxL0swZ3dsOGxERXdIcHdl?=
 =?utf-8?B?QzBRMzVZRjBySmxsYlY1a3VtMFRVSFN3WHhGYXA1dkQ1Mi8wb2pYQzBwek9B?=
 =?utf-8?B?Y2t4K1AvK1JRR3pDNXRTdWtGTWIvWGNLclNSQ2JDLzdwbVVEbDkwVjVqSnNh?=
 =?utf-8?B?a2JFejJLbEVycW1Edzd1ZG44YTlIdU1TVXFBSXBzQWJmZ0hGNTBUMmhPQWxj?=
 =?utf-8?B?bzRvaEIyUWdPbUhHR2w0WFQvaEZBeVZnRWY4SFNZWnYzWXAwcjRKTHcyWTNS?=
 =?utf-8?B?b1dSZUFDSWxXcXU2MkVpa1lHZk1qQzFJbDY2NGNtanYwNEh5UmZEOElvSzUw?=
 =?utf-8?B?aGNxRkZxZUNTLzhIaENiSVpRcmRVQ25GQVNkaUpieStITHRjSHJiam9FY1FE?=
 =?utf-8?B?ZTlWeWIrelZaUzdLd0JrdDBYWEc4QUJjU0V6bGRScW1nUkZpbDl3NGZFWjRa?=
 =?utf-8?B?UnBNc2QxYUpodytmNEFTUXZlUlI3MzZjUW9uRWR2UTJTKzE2YitRaU1HbmRs?=
 =?utf-8?B?aGE4Q25FbzN4ek1ZM0VpYkNuYWpFK1NjZWJrNzVYZGhLcDhwZmNyNG5hOW83?=
 =?utf-8?B?NGRvMVY4bGdURjZENThWdlg3elNFa2FVRi90enQ5QlRndzJ3dlAxdVpsT2Uv?=
 =?utf-8?B?U3hFdWgvVVFoZ1RhWXJmTEJJSXNrZTNJblVPWWh3blpBRFVvUE1NQmhBZDZV?=
 =?utf-8?B?TXhkdU5IUnpTMFIwK2ROZFlueEpMR2hWWVBhKzh4Y2QvKzlNTW52WlZOTkRD?=
 =?utf-8?B?b2Zndks5SzB1TGdxOW9BZjVHSWhlMzNjT05Kbm15WWRFbVJmZVNNaFVHaGVZ?=
 =?utf-8?B?MXp1eEZ6emRlbkR3cUE2UVBPNFdHdWMwNFJRMlUxZjVtSUR0eEpiY08xYkJj?=
 =?utf-8?B?Wmw3bG9XK2txRFlXMWRHMDZFOWRqckpaOUgxR1BkOTB2QzFIVTVYcG5IbDNa?=
 =?utf-8?B?NlpjQnJHOENaa3NFdTJCeGFMOEVmYkd6VnZMQlhsOHRieFZ6dlFKeS9yR2xq?=
 =?utf-8?B?cmdvTFNGV2I0S2VzOWNlRUFvSGhRSGQ1UFFqYndQNVhjbWJIN2NaL1NqQTEw?=
 =?utf-8?B?OWp6MDFQZERINTNLWllJWFJvMUltK2kzTEc5QkJZUHNRMnNmQkVNZ050Y01M?=
 =?utf-8?B?eHdnbStvbTRpdC9rVEdFTGxTRExsZ1pjQ1JXeUw1N1pXV1V6WVcwVjJJdXpF?=
 =?utf-8?B?UDhFSG9OWlNSZUdQWnhQQVlTWFp0NElIVEszMnJSd1pNNUQrRUR5cVZ5Z1Fm?=
 =?utf-8?B?SXREa2Z4WWJHYy9wa2R4QUttYm80SXQ3U3NuTU53cUREM1NycXV3dEpXbXRm?=
 =?utf-8?B?aTM1QVJGUXpnLzg3bUJWcC96Wit0T0tVOHB1VWZUVmVWSXU5UWlScDlGSlJR?=
 =?utf-8?B?YVViSDhJRmZ4amh5TEZOUUxFTVpJUGF3b3lINjZwNmRCZG1wQlg4YUFML0t0?=
 =?utf-8?B?VFJoR1k3UDBIYzZsNnhoaGErMkVsbkswa3pyZGJ1a1VGVm1QUlg0RHZ0aFhX?=
 =?utf-8?B?ZEdZWG5nRmdYeGpTdDkvQ213cGZLRTVKSGp1cTNnMHl2Z1pOdlBpTTF1Vzgw?=
 =?utf-8?B?RHA4RXZVcDAvVEpoa05mOG50eEdjM21QRmlldnozMk5BN0tjNmg3VEI3R3ZV?=
 =?utf-8?Q?F0XXbcyPV6A6IAr0HLW0IkM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63bcf51-6cdc-431e-d287-08d9b4396a7c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 19:41:34.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Usy4d5ZP76ybmtXPp1mFa8PQbbuSrCUdMQ7AyLcB25eQQFVksGVAcrQB+y1k6Z9RTKTVCsEhRai7/8Zl97g5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2021 05:04, Ajit Kumar Pandey wrote:
> FCH controller clock configuration slightly differs across AMD's
> SOC architectures. Newer family of SOC only support a 48MHz fixed
> clock while older family has a clk_mux to choose 48MHz and 25MHz.
> At present fixed clk support is only enabled for RV architecture
> using "is-rv" device property initialized from boot loader. This
> limit 48MHz fixed clock gate support to RV platform unless we add
> similar device property in boot loader for other architecture.
> 
> Add pci_device_id table with Raven platform id and replace "is-rv"
> device property check with pci id match to support 48MHz fixed clk
> support. This enhanced flexibility to enable fixed 48MHz fch clock
> framework on other architectures by simply adding new entries into
> pci_device_id table. Also replace RV with FIXED as generic naming
> convention across all platforms.
> 
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> ---
>   drivers/clk/x86/clk-fch.c | 41 ++++++++++++++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
> index 8f7c5142b0f0..de556b03e184 100644
> --- a/drivers/clk/x86/clk-fch.c
> +++ b/drivers/clk/x86/clk-fch.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: MIT
>   /*
> - * clock framework for AMD Stoney based clocks
> + * clock framework for AMD FCH controller block
>    *
>    * Copyright 2018 Advanced Micro Devices, Inc.
>    */
> @@ -8,6 +8,7 @@
>   #include <linux/clk.h>
>   #include <linux/clkdev.h>
>   #include <linux/clk-provider.h>
> +#include <linux/pci.h>
>   #include <linux/platform_data/clk-fch.h>
>   #include <linux/platform_device.h>
>   
> @@ -26,22 +27,37 @@
>   #define ST_CLK_GATE	3
>   #define ST_MAX_CLKS	4
>   
> -#define RV_CLK_48M	0
> -#define RV_CLK_GATE	1
> -#define RV_MAX_CLKS	2
> +#define CLK_48M_FIXED	0
> +#define CLK_GATE_FIXED	1
> +#define CLK_MAX_FIXED	2
> +
> +/* List of supported CPU ids for fixed clk */
> +#define AMD_CPU_ID_RV			0x15D0
>   
>   static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
>   static struct clk_hw *hws[ST_MAX_CLKS];
>   
> +static const struct pci_device_id soc_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
> +	{ }
> +};
> +

Have you considered inverting it?  The number of ASICs using the "older" 
design with the mux and multiple clock sources is a fixed value, but 
we'll keep adding new ASICs in the "new" design of just 48Mhz.

Notably; I see that this series is missing the Yellow Carp ID for 
example.  We'll keep having more designs with the 48Mhz that need to be 
added to this list.


>   static int fch_clk_probe(struct platform_device *pdev)
>   {
>   	struct fch_clk_data *fch_data;
> +	struct pci_dev *rdev;
>   
>   	fch_data = dev_get_platdata(&pdev->dev);
>   	if (!fch_data || !fch_data->base)
>   		return -EINVAL;
>   
> -	if (!fch_data->is_rv) {
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev) {
> +		dev_err(&pdev->dev, "FCH device not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!pci_match_id(soc_pci_ids, rdev)) {
>   		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
>   			NULL, 0, 48000000);
>   		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
> @@ -61,17 +77,18 @@ static int fch_clk_probe(struct platform_device *pdev)
>   		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
>   			"oscout1", NULL);
>   	} else {
> -		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
> +		hws[CLK_48M_FIXED] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
>   			NULL, 0, 48000000);
>   
> -		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
> +		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
>   			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
>   			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
>   
> -		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
> +		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
>   			"oscout1", NULL);
>   	}
>   
> +	pci_dev_put(rdev);
>   	return 0;
>   }
>   
> @@ -79,14 +96,20 @@ static int fch_clk_remove(struct platform_device *pdev)
>   {
>   	int i, clks;
>   	struct fch_clk_data *fch_data;
> +	struct pci_dev *rdev;
>   
>   	fch_data = dev_get_platdata(&pdev->dev);
>   
> -	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return -ENODEV;
> +
> +	clks = pci_match_id(soc_pci_ids, rdev) ? CLK_MAX_FIXED : ST_MAX_CLKS;
>   
>   	for (i = 0; i < clks; i++)
>   		clk_hw_unregister(hws[i]);
>   
> +	pci_dev_put(rdev);
>   	return 0;
>   }
>   
> 

