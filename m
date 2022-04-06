Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245F4F65E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiDFQq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiDFQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:45:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E85289B4;
        Wed,  6 Apr 2022 08:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6+eWbQlzyFNzRY5N41o1R0BmtnuuhYxVHHvzEfY/mhn6l2rtCvxYY1jXlZcqs7DyFIiOFgWjpnIW34nMn5Rqqy9PIjT/l0DaYBhAsTwPnnuhEDasjjdNOG2LrKwlPJcZVQg2e/4G5OsFY1xHHssIAUA1yIJPB203W8S6WEoiecLzRKMMUDhLV+NEiJyqzrSoNTdo4v8/OnZTIEGKLGd1TzqKvmXMjzjoqGvDuMopjOPykaqaGQ2IvpLRrNb11HTO6lDMQ1Y01iTNeobw/vQXwIJ4uSaBP1gjPadY8U9rwUFNlllM8UQt0AM9igDuM1YxzJ+u5+Rr0ZUoSf+bkurYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYfyHWl8msvTgBq384XAajfUDILCRKxZhNRLLPIYmsc=;
 b=BbmVg4icF8qKoOkGDA4N3bnIV69ZPBCotQ1INxdaIxgHAHu5i/qyBbdC4/KQgy35F/SbiF3CTwqs5mJc7cH1DPXELUgEUm172yuhohgEPREEz6fbZC8jICRFOiQZ5+2u4oldOPfVizE3lXZcmHxqU8s7UQc4UlZV1Xzy2zg09ul9mS9CWvWSP4PJtkz6zTUbyEiRD0jd0saMGrRyFTv1SPKPU461/EStw1r1c6av3NwsCIqPhsW4FhfppzpGTTC5pOvOVHig139PGygfyKofzgSQJ8HtvlRZA96UVKq6XSZ2NtpAV4kkEDFK8wrRujWMVCxe2k8tcYwIZAfLcE6IfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYfyHWl8msvTgBq384XAajfUDILCRKxZhNRLLPIYmsc=;
 b=V63dq/czM9zvMgT7HAQMVl08gi6ueeL3GilBmOk2Il5gNRb4or+rcB7SDdtvov4I9zkrchH5/6RJHFNZpaaEhngtc3D0ecPI6C4rLb9YYs8j4ge9AT46tnMqulll1nw4BVhu/lea7T6xqH8a2jDj8YFzXc1eIJObnLm4wSUnwcItp0SVWDnY30WFSkkKz49GFtvrIQraOwassNKdpztEWs1FPuTP0MtnO0Z3oB/cJfpegI88HRNyfgC/mhj1XMFLN+ICjzcYMYraO2O3NT4QNqT8Rp950uUQv6VYvfRuSN5H0e+B2XV2cFCQ/pDVWN4Kl3F35S31zYEXemD72Dks2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 15:00:29 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:00:29 +0000
Message-ID: <3bda8b92-6209-1292-88e1-75b8e055c3fa@nvidia.com>
Date:   Wed, 6 Apr 2022 16:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 7/8] ARM: tegra_defconfig: Update CONFIG_TEGRA_VDE
 option
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220220204623.30107-1-digetx@gmail.com>
 <20220220204623.30107-8-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220220204623.30107-8-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dee59e8-ab20-4292-c3d6-08da17de30c6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0268:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0268D1D9C9EDD0A17313FA5CD9E79@DM5PR1201MB0268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGgjL8yquNqdIlEO0PXTen7OF1h7gdwis4VY+SWKP92f8OVcmIeXsG+A+UhLthfwUMzCNYHBj6DURE6tHUdDJMa7OWJkKpLovY+/WETKcG/ETh1pabpeorGoM+swlUpAvQ0TTsCLP17yaBM/NJog6lIJ6PeR1xjQXfmFdSZWzXK28hiaw4YDchsRdMtJFEQsPUVDGre8KkNhAnEjba/udMGuHSILF1Y9LRu32yiap0SAB1fKd/fgM5h6ytnXIlWsHahADRZjH9iZIb6yz9ZmEmQVxqjWAEVYipjQ4WZWwgiZU0XNT3quNuxxtcicpDJkUGI7XaAPGK5G7cLDvBPTw23irUZ9UK+r3e1eHlWwV3YIfBkDFf38ob66q8GbZFqyiuUU6Lj4tgLwupYDFr/eg2MrETqiIkjew5xeNWnu0ju9fHlJedYUyslJ4JCifOcXpqgoK88Tw4TAsune9iouuuR29hz9exIEbz6oPRnnwiHgrSt3/wZU608pU/4fyif8fxyqEXatEL4vBcOxNrq79efh+pWpZ5z7svflvxUCX91dHVTdximraEkLRsXLZlNt9afVXO8JHMmUUqNvmCV89Q6zxLXcOZc5i5rTv9651bnf4YD+yf+blZSufV1Lxp7XrV0+bs3x6exh+aam88G2GffCRpG5yn1IJOCMhi4NekOUaMj9l2VViwB5VsYb/F/T60Y+bPalDEAjHRyhufE6PQ+33R7cW+/+eLoT/wW70NYHUjRyZIkZSajkCV44z97e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(31686004)(86362001)(316002)(6512007)(186003)(36756003)(26005)(31696002)(83380400001)(110136005)(6486002)(5660300002)(2616005)(8676002)(53546011)(4326008)(7416002)(4744005)(508600001)(66476007)(15650500001)(2906002)(66946007)(38100700002)(6506007)(66556008)(6666004)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3QwQ3BSOWRDSDFjTFJrbEJnKzB4RlI0ZFNwL1QrNlNvSG90M2ZnWWhwOUtE?=
 =?utf-8?B?emJaRnFKUm44NXFtaTNWMkRvSmVSVWJpZ21NR0JTRFZIOVBpdzJCTDQySlRi?=
 =?utf-8?B?QzVMdWZVbUpqa1ozOVg1VGs1VUIzSVIrcVJ3ZHMrMytsRmVyOVY1NlpuWE5L?=
 =?utf-8?B?YUgyaGRmaWF1VkFBSTNiZFR2QXpjUWoyZ0I5dGpjbWhwVzB4UW9jT2dCeFRV?=
 =?utf-8?B?Wm9sVEN5NGpSWWxqWUtjT1hJNVFZWXhMeG5DcmJOY3NKcFhhcmFrcGVkeTAy?=
 =?utf-8?B?YWUyUGl4ZmxaWjdCUXVCVmpsSGs1b1pGZlFwR2REOGVHajRsbThwSytXYTQ1?=
 =?utf-8?B?ZTFTdFV5QVc3bkFEMDFzSzh0MTBRQllCUGJ2aVNsMFhORWkxV0w0V0NYUFpJ?=
 =?utf-8?B?bXhQTjYyaEg5dUNWbEl6emJOenlFZkJ1YTR3N2g1WmJRRzBFMDFyUGFjNTI0?=
 =?utf-8?B?WVJEOGIrVi9OWnFzejJWUUloS1BJQUMvdnpoQTVqR0VkOEZJcHdRdk1SZ3Vm?=
 =?utf-8?B?cjVmMXRFOW1YT2YyQnRhcng1MlFuZGljMzFzQ2lNQU1jd0hWSlNRR09jRzVJ?=
 =?utf-8?B?STM5czJiUFdaejRqVXRlUFdabEc3Y0tOcmJTbUgvcmNqTUNYK2RBQWk1Vy95?=
 =?utf-8?B?SEVKa3I5RkJoZUlValNsL0xESklXbkJGcGE5NXNGTXBhbitySk91RTFYUFVi?=
 =?utf-8?B?ZHVSaHZDSS9taWhITTZsZ2pIcXlnM1NqTExPQWMzdHk3S2tkVmNHSDBaNDdD?=
 =?utf-8?B?cCtheTNQNUpNWms5Nlp0VXRJV0hMdDBQclRxYk5ZM2FYNXpGaGlKQmZ1dWFT?=
 =?utf-8?B?N3FjUDR5OVpJWlRXZW1kei9Bb0tRSE5oUFpDV2lFVUptRkVDZmxCQTBhc1JU?=
 =?utf-8?B?cDFPSi9heFYwV2hpN2dtYlRpZjVUaHM3WWZXMlovc0RBbWZnUVhkNkZXMFo1?=
 =?utf-8?B?YzEvTWZFOE5nV0RnQ3pRVENCVWpQazNPZjBSbVMyTlNKRHZmL09rWVl4RE9o?=
 =?utf-8?B?czBCdnZ4L3IxZjVIc1B3TDJVcEw1QnpIZ2JNYStLQjB3ZmJJbUVQd3dpUFZx?=
 =?utf-8?B?MUk3cEZJYXR3Z29LdVRyVHdNTnAyME14VVVmdkwxYm81RkM1UVBxS0duSWp2?=
 =?utf-8?B?azJPN243ME85Y1FPRnNWWUU4dThWakRYOFpJSDE1ays0L2doTjNtb3FnWEpM?=
 =?utf-8?B?eC9PRW0vaGJQVFN1RUxtTGx5czZLOFlTSWYyMVhRTnd0TmdXYUJKSEpza1FX?=
 =?utf-8?B?YjJ0QzZCS0RmV3BDdUQvTFdSdWVjeE1iK3pVWk9NYit6VXg0aXFhbnJodFk1?=
 =?utf-8?B?MDMzeWpwYnhxdUdBOHkzTGFrUFlqQmFDbHRnWHpheFFpNk9zSUdlbDdYMkx6?=
 =?utf-8?B?cmtDZzZnenVqK2prWmJlN1VWaGFINDZvK2Jha1lPMW9xSGpkdFA3K2w1RERG?=
 =?utf-8?B?UGwwUVc4SUhmeUUzelhSWnEwNGR3aUUrVmlOWjQxeEhOa0VEU1hnNXZsQ2FN?=
 =?utf-8?B?T2V6dFkyQkhVd25DSld2MDBPYmkrUE41NDdTeUdjUFY3bS8xZFIyVTNGcUZl?=
 =?utf-8?B?alF1Wko5L1dtalRWNGRudVl3RlhCY09VK1lBbCtnK0w4eGFZSGlobC84VlNk?=
 =?utf-8?B?Ri84dHNoYjI5YlVoMklsby9zWTBibE81NDBCaHJtMDNvRFpwd2NCMXhkVU1D?=
 =?utf-8?B?UmpvcEpZeXo5M2JxYmFCOUE1TjJjWHk4dXlvVG4wZnVEam9XaU1nYjhveVNO?=
 =?utf-8?B?L3IramxWVkltbkRRU21aWmljT1dNeTR4bnVXMXU1TGNtcU55MnFDWHN0bGdh?=
 =?utf-8?B?MFBIQ3ZYN1VyM0o3T2JpeFNRTnlaYmtWUE1vNEVXUXZnU3BUM2hFVDNJNkoz?=
 =?utf-8?B?aHdyN0QybzBrU1VteFZOa0ltMXJycXRYUDZuK0Rxd1I5WmtRYVlmc2MwWTVl?=
 =?utf-8?B?UXVvVjliaEpPM3dtUUJlVERyVzZKcXcwZ2ZtcmJNRmQvOUJETlE5cCtRQUtw?=
 =?utf-8?B?U0hLeEhGdkZaSnV5WWZTVnR3U3FvNTZobFVaOTgvek9nWUZzNlpSdXlib3Ux?=
 =?utf-8?B?RCtTaEpHVUtxcFM5bHJ3VTF4K2srL3YrTVVUNVNxZ3pOWVZyNmN4bXNEcXFr?=
 =?utf-8?B?TlN0ZGRUNXpZdkRUMUNVWFZsdG9nNDc3TXdQb3FEM1J2UVBsZjBvS2tjMUN3?=
 =?utf-8?B?cEExeHV5dU52TmpYczV5Vk1UNDBsMUw2MzNvZFg5ZkpIMCtCVWQ2QXU1bzAy?=
 =?utf-8?B?WVR0THowbFF4QzlXUkl3dkd4aUtNc1l0NmZBUTZ1NGJGekNKZE5kazcxVEFR?=
 =?utf-8?B?ak9yZDkwangrdkkzWWJJWVoxVDF1Z09NTTlVWDFreW05M1FLaG1pRkdNblRL?=
 =?utf-8?Q?IGmBnAAi/TVuNFk0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dee59e8-ab20-4292-c3d6-08da17de30c6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:00:29.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P6CxxywlHKYi0Td4IaStYuxpTfXEEY2xZtPWqx+QETgHFdwlzcJQK66R4ZEeC5BXADpSgI+VNqnX1W5mJiXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2022 20:46, Dmitry Osipenko wrote:
> The CONFIG_TEGRA_VDE has been deprecated and replaced with the new V4L
> options after de-staging of the tegra-vde driver. Update the config entry.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   arch/arm/configs/tegra_defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index e7385c10a30b..0a39033a5c6f 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -298,7 +298,8 @@ CONFIG_SERIO_NVEC_PS2=y
>   CONFIG_NVEC_POWER=y
>   CONFIG_NVEC_PAZ00=y
>   CONFIG_STAGING_MEDIA=y
> -CONFIG_TEGRA_VDE=y
> +CONFIG_V4L_MEM2MEM_DRIVERS=y
> +CONFIG_VIDEO_TEGRA_VDE=y
>   CONFIG_CHROME_PLATFORMS=y
>   CONFIG_CROS_EC=y
>   CONFIG_CROS_EC_I2C=m


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
