Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD74FB5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbiDKIYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiDKIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:24:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D53E5C6;
        Mon, 11 Apr 2022 01:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWqPvU6u+hSTzWyM+iN0JXR+I4rSL5kNB9gXuxgE+TLOu1pOp4RLW/DgKdUvsdbvppDXKpaBUE/y6qUoYXLGKy/X7NmxzIPwSRJqOBsu4hkAwQHzGxfxP1/frRIJqD1gsGs4QW8Kp/JvfwgWUD4lxLlhsu1bFxJilG5gNM4PCRdn6EAsszOYb5umlVstcfYBNYCKRWGmHRWpc3FMkzg3UxWSwuJ0w0qsmhwFBgAs59nIcjhA4pJAlrIbVTITC/+e+miw6MNpVOHf2tk+fM1KyuZEDgCeQCkIXjJxzkpR09Ee1ri9TILOvyrO4e2cRQlCX0aQLIGK9gpNTd3vSEoiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2MNybEqh7TU695ur0SU4zJuCIPhHvk4AQPGgau5aC4=;
 b=eHsceKP+nrC0LMSbYJMUYHtlg2UtncDySJtcwmLs2Omlj3zgzEKNYZt71Y+5RUahcK4skFFQrh8w1nMwiFJ1Kmr1DiBrbIaoTG4duOtRYlmf5MWIeUGyIcDIJe/kCa8TPQw+WUw+DGisstopS/oGMZsrMKq8bkxQHTaoGOI0fRoULfDq9AtIPPVec6B1kWi6FrVWc0Pn4HGoS5lBUqtKM70xHzRd5ceVUGfMtZeYqCwx6rPzPx1ryD+EkK07rf4QaqY6ndemGS8ZCMyVaD5qYNzkdQ2NQ47YDY8hiE9QuCIvdFwsSNnI9hg2d0LPTV2Do+oskJWd4KLA1igbA0NUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2MNybEqh7TU695ur0SU4zJuCIPhHvk4AQPGgau5aC4=;
 b=c8qHnNkbroSo5dX3f3oOwQBGkUcSTbANlZWOjo/fFQ6cn30uIi8qztP4Nfgr4agEYpPLeC+0X3Y28yGHcR97x+eQfMtK+VL07cVkcf4vkUSwmacUERf2Fr2UfHsTDeTGQjVh7UvqHtiTLnyew1aheDs/cv7gzUNtusio3tVvFwQjM0NCUDeuQplBIYMgKbH/fqe3HxrzAKB432BwAL2Sbxd42MfidqiJDt3q9L5eJGUwoESm0lT0B/o4wGtWQromHqip/xIylytidkgUYFUzF7zX/S2IYp7MKtBk9qJAQjjqJ/+4rQMZ+7Qk8K52EmtrcQjX70pxHByUbf2QdGNO0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:21:45 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::a185:161d:ce15:3e07%9]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:21:44 +0000
Message-ID: <deef30c1-b213-c483-a3bc-ba06f5c2e37f@nvidia.com>
Date:   Mon, 11 Apr 2022 13:51:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] ASoC: tegra186_asrc: mark runtime-pm functions as
 __maybe_unused
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220411020908.580-1-yuehaibing@huawei.com>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <20220411020908.580-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47162614-202f-44b5-4682-08da1b945066
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27966B65533E01923044113EA7EA9@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UUVqOiCdTTkOQTjth1s7FEMfOFsoGs9U9OqEmRINEWyATGEPYf2KPZ+nH6Eh/skl/zz+YvJ3jkl7AvwiFht9S/HvFEkDFwu+FyaAhr0+CT2ZmvBHTedtule0c7tA5SfJI6i/ekyI2bSMgOXrziJUnPGhgQzdrKe8hlL+XhmNwQQPC/8JH0rBNSgivd+XKBon1tEWoXPVlOXair9daMdM0xWGJG9iI1XRs5tBUcqbppt4Q7odKbD8R90D8MU1ZYzyCsmgzSEafIia1I2yFLRCfC6iJhih71ufSHQFyNY7R6kG3F0BETEB8ZTKtZ71HWuii3JOihFztEZAsk1WKUnSXkgXHgcbD98kbetITghW3OtuHpcHdJUg8EfzGa27J0wd+SLw7or5bvimFvs68kVSGKlxoKWTibbtD3Z8l4OuQgGTbNzDf7Dmlkh6gPLYHpHf4GFIN8I+DjIf3MmmJahT/YjZUj1dLhHuZtT4ZsCR+dW+WlmXoh7lgkNS8uISQVqohsb80j6hcrnGeOG7ZBlTx7fLyB+6NXNBMD2+wdd9g4leWD5q9j/aPZd+X45dSFkUZochnGz3sZNrcMEF9CKQTr+QXSmGnB4D15uDHOiO7f5GctjrnjurZPBBdI63jnA0DoiX7mCahm2Xz5XXzUnb3VILneb/4uCaA0E+xWjlHK2C1b5csmAowATOJzaxQPwCRrkP9KpYXbz6ladqeKnRTXXvwhs562M7Q+HKEI9Zis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(31696002)(26005)(6486002)(508600001)(31686004)(6636002)(36756003)(316002)(66946007)(83380400001)(2616005)(66476007)(6666004)(6506007)(66556008)(53546011)(2906002)(186003)(5660300002)(8936002)(4326008)(8676002)(4744005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NzdmFFdjE5c3NpSlUvV2pEVmN5RXgyOGZlS0xiOFRCWXdGVlZjVVhYNldK?=
 =?utf-8?B?R3dYYnZpQ3N3ZmhEUVFTKzBCa1JEa3VXbUVDdzJMVzJOKzJqdlk1WUlyUzJU?=
 =?utf-8?B?QXRvd1JuUmdpcDNjY3A4Vm5hNTRNYTBibGc0QzI4TEwxNTZ1QTc0VExNZVZK?=
 =?utf-8?B?ZTBZem85TUxZbGxHaHFFUGxKb0lYSDU2OWVuWWcxV3ppTnFtNFdyRVF3YU0v?=
 =?utf-8?B?WVhRL1VuWDhoVHdpVkJ0bFd5Q3pCMkFNNitrdGoydFdnNXZ0K1Eza3R5bHV6?=
 =?utf-8?B?bk4yZmNCYTZaNngxZ3pzODNTUkxCamJ5ZXVNUUNDSGJwaGdNcmxLam10MURJ?=
 =?utf-8?B?ZndnRDc2VzFhVmFhcFY0VlZhblgrM244dWtReXNZVjFRdkMxS0hYekFtV1gz?=
 =?utf-8?B?MXkvZU5pcm05bTNMV2dEVDB1d3pRQ05TRXg1Y01HaHhQZWRIK1AxaDJ0Sjlk?=
 =?utf-8?B?L3dhVWlZY2hhVFlialRjWThtejV0dTc0eWZJU2c4bUpET2dkVkc1ellCSkt6?=
 =?utf-8?B?MTA5OGdIaFFpeXRWMWlHY0hVYW9SaDI1Z0xIazlEM1U2WDFsMVREVWY5Q3Zl?=
 =?utf-8?B?U2lRYU1UZFJRQ2RJNUY1OG1UNGVKWXVyUEh4UEVua0kyZDhOVWpNbGlwbXhX?=
 =?utf-8?B?ayt3MWQ5SHBHcjloSVdkTUliWFJxcFZpVllNWHo5NWhiQUpvOFBvMlhwVUps?=
 =?utf-8?B?WjZDNjF1QTZFdzFJRGlNakhRK3RJaklLNVRkZmlldy9jNCs1Nm9jQ2taNlRp?=
 =?utf-8?B?dDFVOHZVS1hFUkFlTDVKRTc1UkFhUW5WdHFPcGszY0xGYnJ1bEtGWkJFT1hV?=
 =?utf-8?B?K3JNcE1SbWx4dWVPQ3E1N1hPN1dPcjhYWGhmeEdVTDlYdVpPMTNQWXNVTjd0?=
 =?utf-8?B?QzFVb29HMDlpdUh0QnVzRlJaMW85U2xtcCtmR00wSHpaYWZUUGJWR01mbTlt?=
 =?utf-8?B?aWphOGpzWklnZko3b0VkSzBNYkNhczVlWDlZSEdxS1ErZUNuNUNQamlQZXBY?=
 =?utf-8?B?VW1VQUQ3STVURnNYdGkzeFRDUHVoL0RmS0hNQ1hUeW4xcHpLSm5ITWh1UHNv?=
 =?utf-8?B?cGw5b1AzcjlkWWFOL0Z3K0NyNUhqMkJyaHNDMTl3ck9ZL0IreXc5MU14N1dq?=
 =?utf-8?B?L0Q0L0xLbUJvNVRhM2l0eVArQmtvclpWZVNKTnZhbURPaFdqOTJVRTZDNWhV?=
 =?utf-8?B?YVk0ZStPbVhpMFc0c1p3ZnhCcWRRRFRDWThtYlo1L3pEaFVoOVYrT2RiNFlw?=
 =?utf-8?B?QVlvQW9aeU5MYS9YZ2dnbWRzTzFONWZpZXpTeWpjVGdPU3JjVVJXbXZIcTJT?=
 =?utf-8?B?dkVtVmpPRDZXSW5GMDJnb210VE5aaTJFWkxSUVBmaElJWHZKYW9wQ1FxdVh0?=
 =?utf-8?B?Mmp4ODdyNUdaS2FMNXNKdFZEVGNYQTZXYlMxSHFqWEFWYXVtdlVIRndDQmFL?=
 =?utf-8?B?YmhIWVNkWHpmU3pZYTZEbE5NVUZxM2wzYUUyaEFiVWt6dzNEc0lBd2k2dEVW?=
 =?utf-8?B?ZzVxKzVUbnlFQmlIZ05kQnlsQ0M2WjVpNTQ1QlZaUUFjRC9aUGNSdnNXejNP?=
 =?utf-8?B?cUFlY1BFcnozZkJVMXV6bzhKTi9ZV1AxdzB2ODBBN0tUNkhEYzE1U0pmRjZt?=
 =?utf-8?B?cTRKRU4zdjZ2b1RPZis5TkNwd1VmNUZxSXNXUWV1emJUTzBNWmZvazBCY0xX?=
 =?utf-8?B?bmlGZ3MvbFppRWFodGdqY1V3Q0ZZMzZucEJtb1JVSG5nVkJhVTNFOHRUaDdR?=
 =?utf-8?B?VWwvY24rMjFDM0t1MzFMTTlzcXlGbW1XQnFYZ1NwSjVvNjRjelJqcUZvNk9D?=
 =?utf-8?B?NUp0UVl1RytMTDZoY1JVWG1TYStGNFJMTE1Yd3dCc3RZZmE1QXEvd0VSZmtl?=
 =?utf-8?B?Ym5xODZnaHJNdnR3WGhVNm40R3dRTERsaEJZWlBuYXRIM0p5MjBoS3NZb0d6?=
 =?utf-8?B?MmZiajVpLzJqWFZ1VThpdzFhcmRvRGk2T3FGNENyVXdDUm1JU21LaExrQzYv?=
 =?utf-8?B?UDMwRmtLanFKOUFiTVVFcEdTUnhxVnBqdDEyS2VDWHgyNTg2M1NLNStjb0Zi?=
 =?utf-8?B?VUxackRiY1pkaDRXczNTaldlakU1NjczaVBtRFpiUzJuK1V5d0xZT215NnAv?=
 =?utf-8?B?YkRsMERGdDZnSUpRcGZ0dHozMnpHUDFKSCtTWXlmeVpTdU41UXVPUFZETzJN?=
 =?utf-8?B?SHBNVTlxdVNEUytpeHIxUUVEdDJDSXlWNFk4ZzJ3ekZkY0labmZuM1VRZWpn?=
 =?utf-8?B?aURzdkVGVlUxT2NFaDRkVCtyYW1INGZ2M01HS2UwUTQ5QjRBVFFFb1RxaEV4?=
 =?utf-8?B?aUUxdFZOM05ISFU2aGdlazVNcE5NUXBERE9PaVpmTEZTdjVuaXBPZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47162614-202f-44b5-4682-08da1b945066
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 08:21:44.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5EdmBMG1LV9txPftHuOGjZAe5Ezq0Eh39pqUsTOFYOuA995gKX3YHziO++/2b7jIerxWH7QUcWcl4ilSs5BMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-04-2022 07:39, YueHaibing wrote:
> sound/soc/tegra/tegra186_asrc.c:90:12: error: ‘tegra186_asrc_runtime_resume’ defined but not used [-Werror=unused-function]
>   static int tegra186_asrc_runtime_resume(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/tegra/tegra186_asrc.c:80:12: error: ‘tegra186_asrc_runtime_suspend’ defined but not used [-Werror=unused-function]
>   static int tegra186_asrc_runtime_suspend(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Mark these functions as __maybe_unused to avoid this kind of warning.
>
> Fixes: a2df8c2d5b36 ("ASoC: tegra: Add Tegra186 based ASRC driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   sound/soc/tegra/tegra186_asrc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for the patch.

Reviewed-by: Sameer Pujar <spujar@nvidia.com>

