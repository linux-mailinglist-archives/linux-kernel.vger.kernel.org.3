Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4784F65EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiDFQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiDFQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:45:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7319F46E;
        Wed,  6 Apr 2022 08:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efHec0WBDfRCWsmvTIOxW3QQRI6SlNCxuaFg97t5UCZSpZmjv/du+2NB7rqViQnc2BfOCOEs9rMg8OzTpyTstLLfyELaN+HamGcvFhcSphvocFOyESdhx7s2ljp1rCUL/eGJ4c0PkhOmCoV+wU87Tlw4/WOEbF4hL9gv0o2x1aBmenIW1WkYXyg6VKDVd5wSaqNc85+0dv2vKattx9W8OI/pL9si9diVOwnmaoi1UDS23mscr3MoYrwKYekeui/i0ht/pX9TKqRKNotvPDvGb7GI5XErKRzCO5rTB1vrdfQMLEJegvDErLw++m7/9mSX/JsCMfS5D+M/FK25Vn4VMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahYDaq9ZR+P6mxI6wkgaTFY4XgAir/QkOo4z0BoaWls=;
 b=aKiAt0Es1OZ+2RF6K6JPuYAU+n4Hin61UicU4HUkkvAwcIBvRJMqFh3QoAQLOJSYMjkymgDV0qc/8CLdkGw3/w4Om31QQLp66nkqN5bhjEh1d4PWAIATvoEOAsushbG0/xnwVJITOt3wvzDx2PlHb6WKzbmU4OIdY515xZjtN4xXXZB9uSxb89OsCZkJ31RNjaVaAhXhFDsGfqqIaPdX9xsoUwm3VKzgUBk7pd9Oj0hoCPmVX2iyINhd/Wlgg58hMhQEas1AkcN9dY1cxIX7Hy3ttDCSwYF9DjYoaPZNdR+nWtj3R2G7WMzk2/uEcxsevoCuPLGiwCIYFgCDjE8vLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahYDaq9ZR+P6mxI6wkgaTFY4XgAir/QkOo4z0BoaWls=;
 b=HshgILOg2qOPvmQt7U3NBzvOm56f2vYgD4HOiKezWZV8L4Ff8leu7Sypp/Eaeg194V+YucFX+JveF7M+Pie6uupcwmPauaZ0dD2d+zUxi3DaORVFqo0woE9cReQbvXj+qrDYLR/RnRbiU1MWMBIyYt8uFSp+pfbBxfMa3g2RUFObIfpCyICreip+M/mmePwkl/Nd9A9dJp5it1Wep0VbIahRQn+Y4UGbrSO3rNJfI1Ne/+cwXaKVQ6iEG/2QamNYY5rAZG2vnmOK41p1EorWzqFFjtBS+XJPDehtRlKo9hoy7nEs+OKg6n3edRCQCm85zPIwiyZ0n01cR2IKCyAJDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY4PR12MB1336.namprd12.prod.outlook.com (2603:10b6:903:40::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.21; Wed, 6 Apr 2022 15:00:44 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:00:44 +0000
Message-ID: <ba7c3271-20b7-a8a7-8fc4-293e8420e2ea@nvidia.com>
Date:   Wed, 6 Apr 2022 16:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 8/8] ARM: config: multi v7: Enable NVIDIA Tegra video
 decoder driver
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
 <20220220204623.30107-9-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220220204623.30107-9-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da43a58e-a314-4907-6ee9-08da17de393c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1336:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1336044C32A54A8040F15CD6D9E79@CY4PR12MB1336.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUurKofeE542hsEnvUF4MDxTIljqeTXyu49SF0/2B56YSuox1NAmcW+UVKC4G7m/o0YjeZJQu3WKeAD1YTbLEQ1bk1xPAaJXuUcPIDYTQG9OBMj7Jo+URLFXC+b/GNcJPcAwC/+F6SeaalQ0MIntaPj6ItD2z5lSyLowLKr3fw7ELKh3QM4+criIsQVI0VP+dzYlT6PysxxeOzM9mAZvTyeZZO+s69DyiP+liju0hf1nPoQFkVJVoNFCi58IYrPKexSuo10X4ACLnR1onEe8zjZhYrQyMy8apyNk2RqjsbMjID+1ZVDYbSVFdxnmPOEYZ0pm47/IfAcOJ40FDN/TghsHSNUaPvJ3EvVQGR2W4voZXVlqxai/73vpoDBxE6eNLkD/bEWO8gLIkarQH7IT0NS1xYsXJAMwbzG/zchm07Fi1kOKhRY+fQv5xfXhskm/K6kzPNJU1e86BWAUCkv0gTIeyAnQ2jOFkIjrJjtedQ817GjHh5tCPMZlvCHswIxWpuwfKimMeH/lbM9f7zg6Zyg/odfkORuxACyfqIkWyXzKr/TReNVYsdpBu8mnWqpMip1Czs8HK908Vvf6oiF2C5qTMEwajl20tGbQOFHn6ICIsKD0H0Knxc9J+ktgJykChsrb2e+G69K9SUBBiSM4kqaUnLMwK2RoSngSR03cf1tMrohDmHbH/9a/TSuQ7xCPLmhpU39qZDgR6HklpRPksRjxxDE2IGpuM8S2lzVOxQEXIeiR+yWA3Zttqtb+bUBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(316002)(2616005)(110136005)(53546011)(508600001)(6486002)(55236004)(6512007)(6666004)(6506007)(38100700002)(31696002)(86362001)(31686004)(4326008)(2906002)(8676002)(36756003)(66476007)(66556008)(66946007)(4744005)(7416002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJsZDc2S1k5QnprZDQ2RkJ6OW1PTUhGUlZkTzBOWlhPVDlYNmRGcDdpWVI1?=
 =?utf-8?B?WG5XTGRzOXdBWWs3RVpXbzB5SDZmZjAvb1BtdlNXdW5RU2ZpTEU5WDNGazFT?=
 =?utf-8?B?L0xJZTc5NVovQXY0NGtVdXRTYjdUREg1UVRTMlhlRERNWUZZWWlhaC9weHF1?=
 =?utf-8?B?eTFVK0tHSENWNmRReW5MMGJNMzhyZXNESnNFN01qUmZzOUprbWZaRTRJWWxH?=
 =?utf-8?B?Qms2OGVUYnNVeml2RytYUVVOMkxTQXppSzFNZVJxZExlY3BJaTJhTnJNTWR0?=
 =?utf-8?B?MDFvekJnbWRjcVAxdnkvZy80aU1COVRCVUtGd0JtMkFGdngzQnFRdmY2QUJS?=
 =?utf-8?B?bE9zbzJZd1Y1RkpCMmlQdmFlcUpuR1ZkckM1U01Yd00ra3U2MkJncFVhUEp6?=
 =?utf-8?B?TktlU0U0VnpDb1l2RkZVaExmcWt5L0djRFpjT0E2M21GemFnZENPU0NOZHI5?=
 =?utf-8?B?MnBYNzJvMzJ4U0NoZWhmMFJQaHJ2cUxtV3NFSzlBUDc4V3NaaVVSM0RyTlFE?=
 =?utf-8?B?ZVIvR0IrdWRmTmFzZGF2cmlxYmhkU3pFeUlGUWdVOUgvbEU5cEtIT0ZjZW5k?=
 =?utf-8?B?VTArSzl0YyszcU1GS2tIVmlTcHZPU2Z1dWswM0N5OGZUaHo2aEhNbFJYbnlW?=
 =?utf-8?B?UUtXaHRkVnBmRElFZ3hydW9JSkhhVWR5b08zWWFTeUNjbkN4MGNhNkhlMUlp?=
 =?utf-8?B?VFg2RkVTYU95Y0xwWHNVTVNNM2RSaWQ3YlhXUys1L1I5d25YRHlRMUZUK2pX?=
 =?utf-8?B?Ylp5bG5VbVY4QkJiR0pDTEFtVEZHV210M0RrNWlCUXMxbC80cm90ektrNWE3?=
 =?utf-8?B?RGVWYzByODc0Zyt0c3VJRzNuek9SM0dIQVVFa0JDd0pINHdzY0J2UVZobHBQ?=
 =?utf-8?B?R0JVZlg2K3JUQ1pDREZTNFdGQnV0akJIUFVaZmRlMThTR2IyMjVKcUtCZGs0?=
 =?utf-8?B?Ylg1VlMzQkZuY2xQWlhzbUtTNmhDWm91QUkrL0I1YXM4R0FUeWVWSWlaTVJv?=
 =?utf-8?B?ZGpWL2F6WmRJZjQ3eUJBMmphZi9qOWRmbzJPUUg3U1lWUU9DNEJ4dkw0ZFVS?=
 =?utf-8?B?WDRHQUM0QnFSQnozVmhPRUFjUWxwQW1Fc3hrelZMVE9YdFRIa3lpN1BVWWc2?=
 =?utf-8?B?MnF4T0E5R3NUOWNpMXJLQlJtMGtjVFNKaDZBdmp3anM0cFE3eHZ2c1lRVUJN?=
 =?utf-8?B?Wnl6d3VzWGlTek9MSFlYcmFSWWlWd1JCYXhzZVl4bFhvVk9aZnlybmowMy9n?=
 =?utf-8?B?UGM0OXJwdWhkb0NncTBUV0FZSitEVFZaYzY3VGVNNTcvSHd0ZDZtSllMMWc5?=
 =?utf-8?B?WjduOHZUWVZUTWpaUmNvZDlvSzJPakVQMmtLZ0tjTnhrT2JwaTMvOVgzTjBk?=
 =?utf-8?B?YXFjWEc5eE84aCtLc2ZMNkkyRXl3NHpzeFJrZ2VrZUpoaWExMjFRbnZMbWZx?=
 =?utf-8?B?WU1xYnFKd0o0SVdmdUF5R0ZuYUVWOFZ3TG0rZXliK1NWQ2pSVDFoOUcyUHdu?=
 =?utf-8?B?Zmp6MjBBWkpHSW5qdmRMNTRNUVFmbk9rM2wxbHRiRTVodEFIKzVSQVgyMDJL?=
 =?utf-8?B?NjhzcE5FWVkvb291UkZHeGVBaVhqOWpEaGtzUDhUOVFpQkJqQUhKZGQ5VlZR?=
 =?utf-8?B?SlNSb0s3YVBYbURrQXA0TzZxYTA3dVVIajJGUjA1VFE5UzBEUHkvajc1cUZX?=
 =?utf-8?B?RldmV1o3OG8zdjBDdElVTG1vYi9BRFNtbmJJeXdBTW5SRFBIQmJUOElJYUE5?=
 =?utf-8?B?SmpsQWNWbE5MOHh2V1BaelhqTzQ2dFIvTmJINHo0ZmFDaWNUZXpHUXNEMjk0?=
 =?utf-8?B?KzBlNHFGRUU1Y1FvNnlUWlhTK2p0TXFMSVJyZHR3Uy8wRm0yRU9yek1SaVBX?=
 =?utf-8?B?cHJ6QlJQQ01Qck0xZWJtbnJlV253MW44SGNCaURLTndVK1VaRzdMNnUyMTdJ?=
 =?utf-8?B?eTBrWnViNGx6eHFmYnYzcmtrYWpDR2pHVjVuU3Q0bjhhR3FTMFZzRTlXV1RM?=
 =?utf-8?B?UllEV0Zpc2JlWXhhQzNSV2ZRU1RkdDM3bXpVUjJRT1JoMU5RV0pmUEw1RTIz?=
 =?utf-8?B?bFJMSmFZSEdJamlNSll1Nng1WVlNbmwxVWxoN1ltR0k0WHNwOEFOeFFFd0VV?=
 =?utf-8?B?c2QxSGlSMDlVaHZaRW41NHVwcXBISzg5QjlHTlBLajBwRjZ0dHp6SUwwdjVu?=
 =?utf-8?B?cCsra3EyRk1rY0Y3emtmd2lZMDhhVVZFOHZWdmM3MTR6NmJYWUp3cDhTREFI?=
 =?utf-8?B?ZWlmSjU2M1dsblM0elBlanNERXBqaDdMTm01V256cENZRWduUWF6U3pJT1RM?=
 =?utf-8?B?bklHRllmZXgrRlloUDFadVlBcCtsYlV5Tk96MEtnekVmejdtWExEZ2x0L0dO?=
 =?utf-8?Q?cQJaSATRY0+NHlSY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da43a58e-a314-4907-6ee9-08da17de393c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:00:43.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrZ/UJjLYfZU0J90JERCYZ4KpauuRCb75erbAVRyO/4oTvczJEnIbD17P0QlgmPkcxc9ffrMYmzFH3vQD56hmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1336
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        SUBJECT_DRUG_GAP_L,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2022 20:46, Dmitry Osipenko wrote:
> Enable NVIDIA Tegra V4L2 video decoder driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index dc0581deea9f..8a360d7f517e 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -669,6 +669,7 @@ CONFIG_VIDEO_STI_DELTA=m
>   CONFIG_VIDEO_RENESAS_FDP1=m
>   CONFIG_VIDEO_RENESAS_JPU=m
>   CONFIG_VIDEO_RENESAS_VSP1=m
> +CONFIG_VIDEO_TEGRA_VDE=m
>   CONFIG_V4L_TEST_DRIVERS=y
>   CONFIG_VIDEO_VIVID=m
>   CONFIG_VIDEO_ADV7180=m

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
