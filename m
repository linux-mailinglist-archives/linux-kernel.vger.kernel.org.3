Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1A561694
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiF3JjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiF3Jiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:38:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D426433A9;
        Thu, 30 Jun 2022 02:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP6pUh9xs3PJkBL+z09eKy04tfRdfuK7Z12kznOq6tG/MqErMAArxeSvE14z4HQwU0FoxMZIO9duBoLnkFs8cFheQwVrG4AH0hW7wfyMkIZ0dfldWKalLARWhrhgybp1RbQsp0ikvzNSEEKRr3CrQFFJ5AyGZkS7gaxO/KKMfAceUTXimP2mQ37C08sGqP2OOl5wZNCurvLh8wF1WAvNnZDSx6klI28le1I+y3AgM1m/PCOCYNV2ZInKahAA+eYrAJObijyc1+G2QF0z00w5hfKcG+5YjpzM+2LuJJmfvETh6Xo12khdxwM75bpRThp6gRZGUb4yeTRCvck/yunMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Heso6uoDQ9VDGxVhrX4LbaAsNYMn5N8yyKiJPVb4S08=;
 b=PgmCWXdwWaGZJPCiOoLJwqzSeIBd9amfztPJzEUW0MrjyBzTeFuElZY/O6rEUjiwPjh8iAvf8XguUo+4o/A8wK21wXDausyMDYIfrOmIgd+wsgob0iOS+B6KUcOwYqNyUok3+bFfHrQAPUIMt7gk0ufmiAozOAGG9NhBQrUqw11g6Xz1Tat2qlHT76tyW7lF5C9+9C+JsccHJ0VB4/I46JjWZJxEVsAZuuGdC3ZJMVAwXSYyvy1COWHFeImgF6NcbvPEXWOTEg2Zeh6s5If8ENPLLUIVYFQlfIj2kIrjFCHipdcS4owk/VtEiCFO1oh50M7POQnduQmEPEk4wU65Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heso6uoDQ9VDGxVhrX4LbaAsNYMn5N8yyKiJPVb4S08=;
 b=MPhSG1aW7ZWj2MsoGVACeIKhIaxivZGDGOxT1QyY7petSWDhewKnzVu/s0+l8RucWc20t6A7O7PA5kHqcvhFTq33+XUAdKXl7HNwkUUqsU+JJhdJsrc3zsy4L9hhFyHXcSmJrV5MiJP1i2sehrh9L6ACL0IjqI/NSXY/auDOPyGbQ3TAkN75n3alV96D70Mo+9DTgX13+e7ke6fT8yLC0nJ1a2gvuDFty6hXWEcmxl2UMlma60FYOXU8groFgfUp/iMhdRO/3TYEVimw46XmcvTBFpbQISKQhNiccSoJ6T+nIcGPByIXvxo+LpFqBCmL6ikjep5xc3AQJM5w+odnMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Thu, 30 Jun 2022 09:38:39 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:38:39 +0000
Message-ID: <c4b92acc-4f88-a0a5-c278-4ddbaa60629c@nvidia.com>
Date:   Thu, 30 Jun 2022 10:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/6] arm64: tegra: Enable native timers on Tegra186
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-5-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1656527344-28861-5-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e059dcf4-1c79-4676-974d-08da5a7c502e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+omFkd5AY8jrH5WAEhtzEcee2hQCeFp2Z7vOnP8ORT+5JAmb8eX5ImeuBr2foCq2b05+tAbWA8ol8YRC1MIK1c2pGUzbf25UXo+b2ofeT/TO9jqjmkZd9I2nzrevnXiI7ib/RnOPbYWMubuywRbToAb6UXSs1TDPTYXAwc6qJJgte0JejvjVU/Uv8fhCLtSkNA/rWBUse9hYO+Q81rl3hFzGu5EnWLnSD5je62WKVp148g1Ytv9jUVbCnZ8/Ko+7B1eXKuOhNHcJC1JTfcrV7PBtG5LRnlhaE4u56lqRfGfm1LKjcMNikkFgPracxu+t1rgMjBeoBViQ4WhRs7UCWYjDM2X/O6V6/ZGSdhuha6GwPJVzBaKiDgWHBaeN2ho8vQrKluROqPqyUufJwNHK/VcC2HEK8lKdznCiHwc2HNc0/YDAwVdDqpm2iBQPWq1/6C51liXP1SIwScdBPspKSdtLIN0rnl0EuWGqtehP2D875p1ZYJjt+hh829c/fzbfgt7o7LTWOjCDxUSJryShkcc5V7Nd1zyYPYFU3zOgQuNPaByyEajXYmHAEzaY0AOm803oWQVwpXa1668P80Q641rFTyMOumM6BrAr+dMHnM98MYXPV+rX64PnkRzdKnjvB9eoE+6++4wCHPKElqAw5vN3dk6e2iMHJeTl2F1W6IXHpmot3yOglxqeoDohZS59LtvlRBXO7xaFZ7MkguqqpPfrAIRsPSNGFNhaMiCc7MjdTrWPYXYle/GooWlH7QR9Yucog9XovL4+MuPirJUOSQPK++d4XjzSbb57GBtaS2CzWs3M6zREARnNQISvQ9MjnwGBUvOgzPvFEtDSyZYrpcHHU+aPObtKDRJHU0xjuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8676002)(921005)(316002)(36756003)(31686004)(66556008)(66476007)(83380400001)(66946007)(2906002)(31696002)(5660300002)(186003)(6666004)(41300700001)(8936002)(86362001)(38100700002)(6486002)(6512007)(26005)(2616005)(53546011)(478600001)(4744005)(6506007)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdmZVRRRHdEbE1TZE5tWFVrd3VkWGYyMExxamh3Z045WXMySlNRcmFiUU9O?=
 =?utf-8?B?Y0cvSkt5N2NGNnp4V0J6SEFUZER6c1NDb3RGK1crNE4ycWdMZlUvdVQ1bWxn?=
 =?utf-8?B?UDk5YmFyWU9XUlJ1L29zbmpxbFFMUnhWdUIzb3Fnb0RTTVU2V1orWkdQeWNQ?=
 =?utf-8?B?aUg0TVU4UVFwOXV3NUhkTGR5VHExd0VlR3gzdER6aHRaTWdSRCs5Y1RVN09F?=
 =?utf-8?B?aldYSUROcENkdDZzenZiYWZXaE9pWk1TUGFjckpVa2tvTHEwK1VtZnlzdnd3?=
 =?utf-8?B?bFZyaXpwaVZaclIwaFNza1oyZndmUVMwa1dXRzRqRnJiQkM4andodWFCZENa?=
 =?utf-8?B?RmxveUFPNEhYbEQ5d2dRV2NPelhYYTRTalQ4dG5UcWhqSTFTUFA0bWlmQXhH?=
 =?utf-8?B?M3g2UVA4eGFwWE4xL2xSbktVSEhwNkZnVlNkaVRCWGk0MXQ5OVlsVlI0ekx0?=
 =?utf-8?B?bDVHbGZGUGp0ZC83cHdIWFA1ZThpRlFuR2tIbzZGR1h0clc1L1hoM0hPR0dR?=
 =?utf-8?B?ZGNCOXgra3B0SzFZS214Njkyam5HUjhuZVdhU0NMa1ZaMWhGVER0WXhyU1Y1?=
 =?utf-8?B?RnA0N2lYTXp4ZUVhUGxrT1hmd3N2a1NjM2trU2lobG1Wb2toYVZkSy9BRmo2?=
 =?utf-8?B?azUrZjZjUWY0Z0FVUGFMRkQxSmZZenNuTTQxUHE3aHJvc2xFcU9wRmdLQWZV?=
 =?utf-8?B?aGQxdytwZS95Y3JpRHA4R3ExTVBOQWw1Vm9yZyt1Q1JJMXZndDJRZS9JeVdQ?=
 =?utf-8?B?cFNsSndCQ3dZbEQ0S0kyYldsZ3BzMFJTMkRDS1dORmVBakZVd21nWVMzbE85?=
 =?utf-8?B?QlBnZkpPSWFsay9qOVpJdjFBMlR2cU1adEtVNjkrcXZkSCtVOUdRd3lQdENX?=
 =?utf-8?B?aVpuZy9WZGJ5QVdMQUl4QjVxN0NGTytqZmhUS3V4NVZPTThzTmd2UWY0Ri9t?=
 =?utf-8?B?a1kvdUFRWUgvQ0RQdW9PUEhZUUh4Tkw3YjFsd0pZb2lNOVFXSXBKc2VEVjRP?=
 =?utf-8?B?Mk1GNlVaYm15aGNOcUJsZk5zYzc2TXVIMFoxM3R4WjA1bUhCK1RCQ0h4ZUZW?=
 =?utf-8?B?UEprS0x5OFZvbEJYeWJ0dnhUNzhJUVJXMndjUG5jZU1BcEVSWEZKTitKUUFh?=
 =?utf-8?B?NDNoVy9UeTF5eXlKUGtVRDNjVWxZaHIrVmJYMEc5cHJWenJIOTRZeEJQS2d0?=
 =?utf-8?B?cEpGT2hRZFI3SHlYM3I1YVRjNzZWRDAwWUxvYklhNnFXcTZmZ2ZVZmhBaHc5?=
 =?utf-8?B?dlErb0Vidm0rVmRmMlpxSkdab1JUY21GNlExYnJFVlBkS2M3WndtcVp0UStJ?=
 =?utf-8?B?eGo5ejVReVVoMVd1QmdjOG03UWltd3dTazJ6TFJOMjg4MkxWUVJZckRIblkx?=
 =?utf-8?B?eFE2a0ZVWjV0akJVUHBCNFplWUM0ampwVHNIMTRUb3pIWC9ETzltLzc4L2Mw?=
 =?utf-8?B?SXFSRDBxaDlJakR2bERyV2xwQjNLd0ZTME1xQVVMd1p4TnhTV3p2VG0vdlQ3?=
 =?utf-8?B?bWhMRDFScGJsQzRUWUM1QiswN2FxZUhPRGRJNW1ES2xWKzArQUpLbjRPTlpa?=
 =?utf-8?B?bWF6TDRBODVWaXFZSmZ4dC9MZVFvb1R2S2JmcWRGSFNUT0NtVnRvUzJtQS9w?=
 =?utf-8?B?alFtZWNQRDhiSnYyelRrTmVYVDZvNTVKcitiLzNHR1dVak5jQXF0TTdxcTd1?=
 =?utf-8?B?TEszNXE1K3VLNzNZSWgreTJjcEpnRFRDTHlGY2JvNGRaeEYwNWVuWHJVNURK?=
 =?utf-8?B?ZnAxQk9lMXcvbkFvaGNaSU5PdnRYdlliQmF2K0JMMVFUQ2xpVFNXanVxKzNp?=
 =?utf-8?B?eWs2VGJiYnhxWEN3NkVwNGFtemVCajE0ZVlpdWkwYzlIK3k3amhIR29HVVZI?=
 =?utf-8?B?RnBPMXhqcXAwaG8wN0o2dEMzcjNjV1A1RVVmS202U0RUN2Nhdzg1QVJ6Qk9G?=
 =?utf-8?B?elNweEMzcXV0dnpFc0JCa2U4clVtSDhCMXkwNENFSnB6MWRFaWhSRTN4clhy?=
 =?utf-8?B?dTJPcEh6SVJ0bm4vcUZXMFNzeUNiUU14UU5HTmtQOG14cGlnSlpMRGtjcXQ2?=
 =?utf-8?B?b2RJak5FZk9zZGk4dmhwQkdZbDU5bVUyYlA5U3luY0NsMUt1TVdqdEQvODVT?=
 =?utf-8?B?R2JEemhJa1lIeGpUcVdjTis3NzB4eGZCbVZRRFhjczZYZGt4cWtpcVVyVEs0?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e059dcf4-1c79-4676-974d-08da5a7c502e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:38:39.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOOhmjCcDPBFiLGsOVxGNZwU4eUTyLeDOklxgt8zh3TaGeFFJ4nPLb1rvUvyMfq0NyU1DLxCEOVynVTSXs78Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2022 19:29, Kartik wrote:
> Enable the native timers on Tegra186 chips to allow using the watchdog
> functionality to recover from system hangs.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index a87b52434939..a07acdaf345f 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -599,7 +599,7 @@
>   			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -		status = "disabled";
> +		status = "okay";
>   	};
>   
>   	uarta: serial@3100000 {


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon
-- 
nvpublic
