Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F24FBF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiDKOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244525AbiDKOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:52:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AEE25C59;
        Mon, 11 Apr 2022 07:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKHH5e0/dEIDgV6lK2iN5fm4a/EpV3MccBa928YliiaRudHkYsEUngnc4+pXurIjQiYb/2v5H+QO6/cE0b0z72bfb3/6fJuL6KsalqNd4rfIJRNmz/vxAR8WDw52BRUVnq0JyuoiwW51qeo7RQ/Ai93NeiHpugVQY0ebN7HXyLkoq1PjoQPz2QGTLawMOOsRkZDaEIEhzjkJBNLJ9lO9bWma0tybRyG9p/5f6m5n7/haG9ucu8d8wak6NDPxdp+KNxJelE8nT7cZxH4de/7f5z+LbgysfznKHuoolS1l7H1+C0Eu1l1QwCaob8im1S+EjoNa/AkXOYPIMQ7bt296Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF3i5uMQeWqHFaOYDEEEX+0gsVxAXKPE/i6ILpN3o7g=;
 b=Wirdzzqb/FPR5gm/qxM3t6p1qmYtF7MZz8KWI/uatAF91mCIoEk5mma0gFWCMMOGNHDch2YS7d+PgyE/pN5zbUfXfI8kwHuFAG9YqgBU0ZKvW5YKLLSjtwz27EqUjcVuxjkQDw0LC6eymN0xzh7HIq+zQr1Qiam1o6K+f9nt4tQBPGwrPThTuJuYmAd7PE7PtbvXO8ykizwoRDX6bzgSp7OHHGwvXVER2ixGhhHFj595tr5bgok9iDec06aGQGPr7W01KoHkpdLIMzJ+QvOt1e1uimAp1Jhfa/YvQyS/svgSG2XldS10VhBLq2nX22BxyGBLHY2fWyKSzp1eTwJxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF3i5uMQeWqHFaOYDEEEX+0gsVxAXKPE/i6ILpN3o7g=;
 b=JDrNZTBcIWRJRPW/XCsRdi8FnyoNq2d8+JjSKOYu9cUHFddJUJe2Hb8LrtkpWT1hd8coJEtrOgX6sUnzrIZUVmCB/KJc2IeXVFGjdI5X93bMZOsekoOBXIdjFuqG1oKl6f/8v6Y0pJ08Ob1isLM9fP3b6WxSFfIcw6/5wb9qNGEpb7vGoaUyRgUrNH3tnUfTPhWqxye7o0hFLDofJcve7zX97lwq8BmWNwNoEMY0/iQSGliPprUXM+AC1u86VuTjWCtPVSHoDjiwP5wLDTBoQWBM8p9QxZG+GzOHZKkmIKkT4bTcBjRUdNEO0ds3BnGvnrXSrbssMMClRnfrue1V4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by HE1PR03MB2937.eurprd03.prod.outlook.com (2603:10a6:7:60::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 14:50:05 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::fd2d:a04b:de07:33f8]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::fd2d:a04b:de07:33f8%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 14:50:05 +0000
Subject: Re: [PATCH] usb: dwc3: fix backwards compat with rockchip devices
To:     Peter Geis <pgwipeout@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Hancock <robert.hancock@calian.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220409152116.3834354-1-pgwipeout@gmail.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <7e3080fe-a8bf-9ad9-af0c-f000203a5b13@seco.com>
Date:   Mon, 11 Apr 2022 10:50:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220409152116.3834354-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed8f4e2e-0052-4be8-7165-08da1bca90ce
X-MS-TrafficTypeDiagnostic: HE1PR03MB2937:EE_
X-Microsoft-Antispam-PRVS: <HE1PR03MB2937D10F76DE8BA76EA7439B96EA9@HE1PR03MB2937.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE0za7frrkluoyL6NAXUBdmyS7jxaD7S2PSf+0hIwHBawhek9c/bO7m2WkDgtM5oSy5zhEvrBDFvnZWG/6D5mGlcRdz24RR8YPx1uhYT3EUPn+tz0JyZjIXe4cTXaLSah0msTk8hVqblLkRUMoILBPKfCkmQmHAHc/+8borhFCXgKmU1RNh8W7E6dFU6pVfFaBT0ebhSrN5C0bXGdNmpo8gSgpucCGTWtpx2z+Gkvg0DFffSZSvvrzYYJ75WC7ihWg02S/q88yx/riEb7jO0puMrcu/Avdcq8LeOSedWsKNqcJfyySGlmhnxUQFOws5mHHYcJcyo19Y/gjn2eAbMLGRyTS/+5A6Cy9rURaIzvkLwr9oS0pNL3ceEKIq73N9rH6c6+0AapSywoJliO1VwCjqXFxWkdsuD47Lt24E4g/5X+I7YcWMp8yg8rHZLboQgJTX0lU9G6PVylt8GXt1oEjYZEp22qFYccexSbBVQF4L3yUpoaAztGPqcFhNh78u/MUSzh55DTeMM4K4sKUhkAzONF941+T47HLCSgAuCc0WTyLvSYIAc4W9P5sY/MxBXfOdpC2t95qrz6D72gqJsu+TdZ+XkVDXfQnt9N1JcXPQI+TxoYUdSx/r7O4JZGsik+90yQH9vtFFCjUqEhor9yxvjLn1mPKdlT90wnimag1EJxSnrgLETy5w743gyADoEamWbLkj8iRYuOYzWuU4l2ZiL9hQpcvlVuzNqITzAgMbnpxP3NYLoWnllfulgRucH3VuewtiNSRjawjK1xOvAeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(8936002)(66476007)(66556008)(4326008)(31696002)(5660300002)(44832011)(86362001)(2906002)(53546011)(52116002)(6506007)(6512007)(83380400001)(6666004)(38100700002)(66946007)(2616005)(38350700002)(316002)(26005)(186003)(110136005)(508600001)(36756003)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFOak4wdDhkelNmVVQxS05rSkYvejU4SmQ0aEQ3UlV6ckE3dC9hZTE4RVBX?=
 =?utf-8?B?R1FQUXBNdDd5WHQzSncwQ3NPalhKVTBTeUNMeTFkSmNqcmJiaVUzL3pKZmor?=
 =?utf-8?B?cEE5VlZjRTdBWlNzak9IZlhLY1lpemVKMENFVVllT1VmZjg1dkRBTEJKamNM?=
 =?utf-8?B?a1NUcnN1ZHc4SUJKdi9ScDd3cXEvSXlNZnVXMzU5NW1VQmx0enowUDBwc3Vz?=
 =?utf-8?B?eFZXYXp1d3kreDNEdDU2T2RiT2xkMWgxNGh3MnBGYWVyV2J1ZTZXTXlackkz?=
 =?utf-8?B?M1lUYnhMYzN5NFNNYjg3czdhTTcvQkJDOUsxRTJPMDVGeVRNM3dMMmxTVS8r?=
 =?utf-8?B?L3c5WFU4R0ZaZHVHTTRkREdiOXBydVFUZXZreVNFaHE5UUoyRDNVT0Z3YXRR?=
 =?utf-8?B?K3BXNEFtSjMvb0UrVUxjdU1zV3RLQWwyazlVMDVKVEZIR0NkWUQ3d1IzdGZ1?=
 =?utf-8?B?WXNmTWt3YUZkNnFoQ0xPaTBSYnZSazd0amZxZm1WcjNNZndLT0VRWGdPM3NX?=
 =?utf-8?B?Z0dDdVVzYUNuRTBBVU9SRnNhSDhwb1NyYnVoS3hXTm1LYXVMMDhlRTZNVDlI?=
 =?utf-8?B?bFIvSHI4UmxhY0t0WDZteWs1b3B0cElhcnVTNU05VGtJa2srY1hkYWk5eFJH?=
 =?utf-8?B?T09SRXJhdEwxM1RnYVRaaEVWTjF4akt6ZkZsNDF1RFBDNW5MRWFXaVNROThO?=
 =?utf-8?B?aU9OZVlxeUpSMy9qUjRnMjBLMXdlejZRTlpCM0ttVG4rcUIxL1AwQzlmSWl6?=
 =?utf-8?B?ZWQwN25maE5VRzd1bWszTVA0R1Y5aFU1RllMOEJSUTU1aks1c2NhOTVXWE5W?=
 =?utf-8?B?TmVTckRwdmtyT0J5U3dLcktWZFR3LzY0c2VVcEtpU3Q4VWlFWVhTSENoKzBK?=
 =?utf-8?B?cEc0ZTkzMDc3YTJSeTZmSXg5cXJnVWJObkRIRUVoZmV0Zkl1L3RrOVNzZTkr?=
 =?utf-8?B?R00wNk4zbG5GTlQvM3I4QkYyM0N5S3YvejhPMUliVHJRdFpyV250SkZmZ3VL?=
 =?utf-8?B?S1kvSWtTU1ljMmJPYXdqQjNDYnltRXBxRjZxbi90eFplc3U5TGFyZGliOS9E?=
 =?utf-8?B?Vk9XbXVtYW05SEJOQkxFRU5aMkpHcjN5eHppRGF1dUFvSkpLV3VBa0E3OG50?=
 =?utf-8?B?MHNNYVk4Z3hzcU5GV1VSK1NrV0hiQ0pHbkhiaE11WkM5NERuaFlpZlJSM1po?=
 =?utf-8?B?dDdheXBreW5rMWhZaGFrUzVFWEEreDUyZ2drL3NLUmE0R1dBS0tRQ3V2aU9M?=
 =?utf-8?B?RHhVTGF5UFF6SXVBYVNLRlh4WWVYMThmcXMyaVI4b3U4VmE0VVpzeWxmUElC?=
 =?utf-8?B?RkZ3SERnbFJkbW1NSlJNVTZYcWJlbUZjRGdMMktWTjRWUG8xT3NyeFkweFd1?=
 =?utf-8?B?TGo0YTZvVUNXb1R1Y1VCUHJIVTZscElhQkZWanhCUkFFQ3JaS2JVSXN6dmhB?=
 =?utf-8?B?b1BOQ2NVdzVEUnNHRG8wTWN5Q2hYeXI3TXZYeG8rNXMvbHdyMjNZN01ZdzZD?=
 =?utf-8?B?dG4wb0wzZ1BhZjhwTk1xSlFqbnY5UmNhTmpOTUszalk3UFFTSWVOSmRwTElK?=
 =?utf-8?B?clQyR0dVaEQ5RG1lWTliMU1vTFV0VXliWXIyRnk2aldTZ2NMTUxobDJ4NENR?=
 =?utf-8?B?ZGVRV0xmVFlWQmJicnhhOVNhS3RtRUJGclg1V3RFUGN5QStpaDdPMUFOTlJW?=
 =?utf-8?B?anRkZXZFWUtacVp6VWdUbnRXbGtCSDRhSkVGWHlsVEY4emZrZnVhRzIwWlF1?=
 =?utf-8?B?Sk9mL2ZOejZsNWV3TmZnOElUdndSZTFXWXg0MDBVVXplek5EcVdURUw0V2Rm?=
 =?utf-8?B?aGNNTDYraXRsVG5UUHg3TEl1RlNOY0t6OFRkekFkLytZSmp4SDlBWGVVSDhh?=
 =?utf-8?B?bFgzN293ejFqWGRJWCtycmJOUkR6d2VUWEFQaUR3LzB3WTF1ek1VNXpqUGU5?=
 =?utf-8?B?QUdVRnVPbUs1VlBlcUxRZCtqTkNXRklPcGVZVEpmMmE1MU1xN0RVYWxFMXBw?=
 =?utf-8?B?c1F2UFBSNVlsZXNGZ0hXV3dvbG1JL2NDSVlPY3JmdnJaVk12T25JbTgxM24y?=
 =?utf-8?B?ZnkwTncrT2FkL1B3Z1Q1cENMZUhBY2VPcFg0Y2ZsNHFOczdOR0FqaUpVc2Yx?=
 =?utf-8?B?NzJGOCtJc04rcjJuOUp6T2dLSU5peGt1L0N5ZHV1dWw0WS9UTjlsSk9lNnhO?=
 =?utf-8?B?V3FRcnRZczFuK3BpVUZMNW84UTRRMTFSUHRKTnlJaG90K2E1ejljaUtEM0ZZ?=
 =?utf-8?B?R2NPdmh2OCtPRWd2VkZobmxNbUlrbnNzRE84ZFZpYjlEdy8xcXlUUk4zaEsz?=
 =?utf-8?B?cVF1cno1aGh1STdoQkhCNDFrbDRFUml2ODhLUlFxZFlobHU4STh6bmhDY3lX?=
 =?utf-8?Q?dLWa7YynCIFmH3ws=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8f4e2e-0052-4be8-7165-08da1bca90ce
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 14:50:05.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qk0PPIQT6xFyJSoC0psAICVRAQ53gAaiNzzvMH1v0ClLxyraVP0mGRNY8aKadGmO4cRU2UgHQqCoKmY7E54mhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2937
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/22 11:21 AM, Peter Geis wrote:
> Commit 33fb697ec7e5 ("usb: dwc3: Get clocks individually") moved from
> the clk_bulk api to individual clocks, following the snps,dwc3.yaml
> dt-binding for clock names.
> Unfortunately the rk3328 (and upcoming rk356x support) use the
> rockchip,dwc3.yaml which has different clock names, which are common on
> devices using the glue layer.
> The rk3328 does not use a glue layer, but attaches directly to the dwc3
> core driver.
> The offending patch series failed to account for this, thus dwc3 was
> broken on rk3328.
> 
> To retain backwards compatibility with rk3328 device trees we must also
> check for the alternate clock names.
> 
> Fixes: 33fb697ec7e5 ("usb: dwc3: Get clocks individually")
> 
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> 
> This patch is standalone to fix the backwards compatibility, and is
> necessary no matter if we decide to retain the clock names in
> rockchip,dwc3.yaml as is or align with snps,dwc3.yaml.
> 
>  drivers/usb/dwc3/core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1170b800acdc..5bfd3e88af35 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1690,21 +1690,44 @@ static int dwc3_probe(struct platform_device *pdev)
>  		/*
>  		 * Clocks are optional, but new DT platforms should support all
>  		 * clocks as required by the DT-binding.
> +		 * Some devices have different clock names in legacy device trees,
> +		 * check for them to retain backwards compatibility.
>  		 */
>  		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
>  		if (IS_ERR(dwc->bus_clk))
>  			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
>  					     "could not get bus clock\n");
>  
> +		if (dwc->bus_clk == NULL) {
> +			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
> +			if (IS_ERR(dwc->bus_clk))
> +				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
> +						     "could not get bus clock\n");
> +		}
> +
>  		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
>  		if (IS_ERR(dwc->ref_clk))
>  			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
>  					     "could not get ref clock\n");
>  
> +		if (dwc->ref_clk == NULL) {
> +			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
> +			if (IS_ERR(dwc->ref_clk))
> +				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
> +						     "could not get ref clock\n");
> +		}
> +
>  		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
>  		if (IS_ERR(dwc->susp_clk))
>  			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
>  					     "could not get suspend clock\n");
> +
> +		if (dwc->susp_clk == NULL) {
> +			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
> +			if (IS_ERR(dwc->susp_clk))
> +				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
> +						     "could not get suspend clock\n");
> +		}
>  	}
>  
>  	ret = reset_control_deassert(dwc->reset);
> 

Acked-by: Sean Anderson <sean.anderson@seco.com>
