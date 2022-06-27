Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0956255CD60
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiF0ROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiF0ROw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:14:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A7C0D;
        Mon, 27 Jun 2022 10:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1Cwm68/Yg9O64XKyOtnEzh45M92uZSyPUynWntjSJcdu2t868b5xRrSm/jLJXCKJ7kdgQvTFoly3b0rRSZrCRkiNQQbzjIDZtplaULUrGSQYOilja4VIT6r7cZzxRwge2fokBo2c3MV6Sr6PaXZS+jfefxPrE/3eVEecPaWiWLFa+S2GdOZ6x08hhiJpNf3ifLnQtIA53GC48+vc6CKFeHdVUuLoIbddDD5w3twR5t0YkS9TLsBH5Z279WtSFujwHIcTUBlu0wUg31GhyGablX90NS5xVVEbb0yWetT6KcrHy/5tQTGjmXFXWsCmE4OBPdrwvm+zcOrJKgUJz9r0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HevRhSm63gQMXjhVEa8Yn1QnFlwAIIAkd6JNKxTG1Ow=;
 b=Ru5cY5rEdH5p80TWauZ8gz/qcPh6NAo2oX9SIDSl31K3C2dvA+n13RIGb7jcUzOK6mb6+yeS0s79fpnv/k/0pVRrE680zVPLI41DIhmUuNPzAj8d68jrzQa1h7J1tfJZsnITYwWkWjzdgGqmBrZeuh1IAqmA/md2yqz4+pmXNZADsdUMgT0xexjU9nvS7OGwVBu56BJEZuHXwHfFgLbxSRPazXoIkL2OGtOBAchOR03k4X0l9IfI4oDl7vtZ5HWTw71Q38ZuDSZRC7js+Pkqhd79KyfiS6xHWFOKSDILPUhx0eWYbwjTuMPBcsIoWrFqn8Bncy6H+KOC33GM5F5fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HevRhSm63gQMXjhVEa8Yn1QnFlwAIIAkd6JNKxTG1Ow=;
 b=JWnubizx9JNDIzKFHpzdrRiS4SidW0miz+0fUR0QhZH2VdbQfrMF0ggUwmlZwJ+jw8pfnYhP6g8N1Ivllp0bkYQqRRKrluaC4Eol6BivEQEvQmVpEmFG9H5dXcle76y66IpvvMs6etGq92jnZHDs3u/G2ySgjYQGE8L2r+mW5vG66o068h2vlxXBICQrqt1/dJOnw9oaVBv6KWsDUbJ6oSCCdpH81/haIBUoOxCj8dImFPp9skbVSAYrsr3d8anj/c7Jm9IYTCzfHpoCx+MLEkiYNZKGBy7DXVfD+F203okVvaPN5hQEjoyPhoixaa/Ot4oH0daU2FapHciD+Tu82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 17:14:50 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%6]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 17:14:50 +0000
Message-ID: <729aeab5-f3d7-a5fc-c1a6-c07a18572b11@nvidia.com>
Date:   Mon, 27 Jun 2022 10:14:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 17/20] tegra194-hte.rst: fix reference to its binding
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <2e2c86485cb0642455cee01796f9a74de21403e6.1656234456.git.mchehab@kernel.org>
X-Nvconfidentiality: pubic
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <2e2c86485cb0642455cee01796f9a74de21403e6.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3381357c-cb4a-4b16-a0c1-08da58608afb
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5407:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTSNoG0g3q70Ej5S2FWdZKo3zFxhrJIi5juyVz3Xx5qizy0MirY6NBwhCl4HTZ2gSrV34k2htMBWG/goYBOaNCghNgKJN/SSzwo6yjdRn40TJNZ5hIfSs3wewR6ecIwuN/T0fvKCdYV9p2yOEtoELTs7O7bXgLJBloLMw+0DPAh52hhmjKzoZB+D7YZQw+Wmq99A2sKZ66rfp5OZNX3VgZd9rkCFbzRpAvGSigrroTFM4TpS2Ip7vf4xAopv/RoGKfUjgHZqMo/zSlaRNvAofO7YLsyG0eVk6mRhvFfd1AnpZdUan7ACJmMNE9otdSyW86reW1LQ81sgFP5EQz63IDNGE2+sCRdoZOyPVpABRBuUf+tmNa7GMu4YrtWAQzUU9JdbDq2B3bU4pCISk+FYTJTK3ReIes3mWdeF5I7Ah/A1fF1a1PZxIPoLulZFYjKzC+etuwbHtJp6vr8Ay3OVXOR1eaFSepSRIAdauk0p93sAEsXXedL0zX2z5KY7rK7cdLrP/iYUs6/M1vRnVHuY7IYY36M/PD2KhvAguzQV4X/OAnOfTJu5lbKtxfZyDeqoewROear4263pIoVo+65Vmyuw8Y6VGp4Xgj33NH69aMq8cr+8L8LMY90ubfDy8R8kCGm5xuZi1FEte3RAYHbOq3T1Nw6UiJMk0MnHCOeisG1GK6bS2prH0yi/yuAWPi/ibELUIaZZDpzWWuTPfztJW49dzL04GCobCFMc5JDoSWCnFT8QOVS4tROqUYU/0OJf8gCYi+w4lLnCPejGxJIhC28vvjfg+USnFdnBFoTnDao2U1XtHgTfbhYao8S6wLI1VrFYmq1K0vJxjLAgZae2ka3e8IN8xkSMy13VF85KooalMZA18y0R7Cbt/ZRFvMJupByJ9PQZwd+GdiXo83mwMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6512007)(966005)(6486002)(478600001)(26005)(8676002)(4326008)(31686004)(86362001)(6666004)(36756003)(31696002)(41300700001)(2906002)(83380400001)(54906003)(186003)(8936002)(2616005)(38100700002)(316002)(6506007)(53546011)(110136005)(66476007)(5660300002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z240UzlhSGg5aURPeXd4cE1wcDBZS1diQU15M21MQ0xxYVJ6NXorUGVOZy9h?=
 =?utf-8?B?NEI4K3NSNU9CQms4Z1BtckVJVVRxL25kUTAwdFMxUlBoTkgxeHpTNjhHTVRw?=
 =?utf-8?B?ek1tTzVlMjlSRDFwQVBFNFVubkFscGN2WElzZjZYY29pdTdKQmpRQnhWbHlL?=
 =?utf-8?B?YnFaN3owVDFuQ2d3TjhNTHI5YzJjOXV4bTVSWi9tRnBLSSsya0twbkZ0ZUNF?=
 =?utf-8?B?V245NHhhanVqS1JlVVhwNUNRRzNZM08rbXlUcDhFMFlGTXJzZG5mKzRJRTZy?=
 =?utf-8?B?bjA2d0tSaTJHVmhWOWE2YmJvUzc0cnZmdkRWNTZaWWFuSlExa0xMbzNvMnR3?=
 =?utf-8?B?MlF2c0NieFdRZXl6UmpwSnVXVkd6TTFiU0RiQnlGWjMyaWxsa1F6WDRjQkxV?=
 =?utf-8?B?UGdiQU9RSGFpK1F4d2ZVMnN4M3pydERqbEpKSHczbGVuUXpkdkJwbm4rZktP?=
 =?utf-8?B?Y1llcjdsT3cvR3JzdEdYZmEycVJ4NEUvMDZEVWs0bVRSemd5Q0QwemJMVExn?=
 =?utf-8?B?YWFoakJqb3pRbzd0MzRTQ3doNlliOXVsbGthUUVyK2dvMUVMWU1CcG9odnVN?=
 =?utf-8?B?ZjE4RWxvZk5LTzdPOVl3dzZmMGFnbS9uL0hWL2VOUVNmRHFHUTU0NkJRTEFy?=
 =?utf-8?B?QzdJS3pZUk9UdjN0TXF5Rnd6bllMRHhQclNCUVRMUnl0Qk9CQ2xPTkcxR0pu?=
 =?utf-8?B?OWFKdkNKUkE4bFEvVXg3ZnkwQXY1czF3RjhRbjFlUXd0U2tlbHZacXpJZGZM?=
 =?utf-8?B?b2ZqVFgyVW9DakRUenc1ZEJjNDI0MnFWWG1nTytCeGl6aUZ1NDhPczgrZHA5?=
 =?utf-8?B?S1hoUEwyN3Q4cFRKQWZrUmlWTWJCRTczeUNhTEYxa3llcWxLaFN4ZGhSTUJY?=
 =?utf-8?B?Z0tCTTFXdzVObWxsa3RXV3A4eTlyR1BVYTdiS1AxcFJEQzFQUjZpeFZNUnov?=
 =?utf-8?B?NWpBV2FEczUzZmt1ZkU4TnVrNFphZHhiMUVWV3RKMEdaaEswQTZzVVE0QjFQ?=
 =?utf-8?B?YldIMmNyNHRJRUhGZXBkS1Jxbm10Z0tvS2paNUJGODRQZk5vZUgrR1VRNmNm?=
 =?utf-8?B?Z0xLWStWTEFxYlJIb2xoUFRjbXdweW9rZFUvbm94dlNwcno3bXNObEFFVSt6?=
 =?utf-8?B?R3dmM0wrQ0x2dkFRYlU5TVd3TlBRdjVJa3VaRmxFUzhhVXZtV1NBY1J2MGtm?=
 =?utf-8?B?WHV6eEs2VjFVNnFXeG91YW9qb2wvNlE4TVZVczZMZEFwS1l1anRDYzZLUFIv?=
 =?utf-8?B?UU1naCtpa2ExTlE0bmFMNERiaGw4U056TE11K0hrSVRtMERBMFZzVFl4Zy82?=
 =?utf-8?B?aXB4bm41NTREaE81Q2h0T2IraWJEaU1yb3RQSlpjTkhBN3Z2QWF2Vkd5OUZj?=
 =?utf-8?B?cFo2WmxPU2Q4dm55K3VmY2t0THNDZFJDdWkwc1FoRWFjbGRqaVhQbFlVd2dH?=
 =?utf-8?B?WlIyYkR3NnNlcUFZRjIxU3p6ZE55UTFHYXdJN2NvR3g2dC95VzlmWkR1aG9H?=
 =?utf-8?B?N3FicHRiQkNtN1RDRHEvVWgwU1o0dFhJOWZyeWVwNm41T016WHpCejBFdzhT?=
 =?utf-8?B?VlJVZEhiaVl1cW8zMSt0Q2lVOVRzNzJrU3lZZUMxa3k3dWJTS3pnaGhMekVY?=
 =?utf-8?B?Rk5lcVROd3N6V2RDYWI3VVJqYTlrR25XL1RsVUpoOFFWblMwbmxoR1VCSVVI?=
 =?utf-8?B?b04xTW5GS1g5a3VGeUIvMTBHQWw1TjZKVXJiRUpGZ3pXcnlyWk5obE5YV1hh?=
 =?utf-8?B?YmoyUVhyQnJ4KzJVTzBTVHJ1ZlBMNXpXV0NjVGFMaDkyZnJNR1BDdXpFb21l?=
 =?utf-8?B?dkg5Zm9ETTdzNHFOVkpOeDRtV2pSQUgvZHRDNkYyWXZ4blJYUWMwUWpSNDhG?=
 =?utf-8?B?ZnllZ0VqSEZDVEpORmlialY2YVBPenhTcnoyMlIzSSt3US9IR3R0cWQwVEpU?=
 =?utf-8?B?NG5yblJ6dUhlSHhhSWllNFhRVW9aTUZxU2wxNkhGUlNOVENCT0YybmNBUDdj?=
 =?utf-8?B?SEFvaFFHOVFORFJxUm54d3pIMGRCSmlmU3Y2MisrTXhhL2dkd2dzYWFNOWRy?=
 =?utf-8?B?VlNnVGoxaGpuT0lzaEtqQnZ5bVlXRjZhc2FUOStkcy85aE54Si9Fd0RDM2lV?=
 =?utf-8?Q?RwFF/dzC7Wr9a/JHJnIInFeoX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3381357c-cb4a-4b16-a0c1-08da58608afb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 17:14:50.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z31u/TIapYLs+sNzwXB1GWPmpt4bPZyjUm8tqACmXD13gJqmk6TH+SMQaIm0IunRKhqJyiI0O2f73sxCfkXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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

On 6/26/22 2:11 AM, Mauro Carvalho Chehab wrote:
> The binding directory for hte was renamed. Update references accordingly.
>
> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
>
>  Documentation/driver-api/hte/tegra194-hte.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
> index 41983e04d2a0..d29b7fe86f31 100644
> --- a/Documentation/driver-api/hte/tegra194-hte.rst
> +++ b/Documentation/driver-api/hte/tegra194-hte.rst
> @@ -37,7 +37,7 @@ LIC (Legacy Interrupt Controller) IRQ GTE
>  
>  This GTE instance timestamps LIC IRQ lines in real time. There are 352 IRQ
>  lines which this instance can add timestamps to in real time. The hte
> -devicetree binding described at ``Documentation/devicetree/bindings/hte/``
> +devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
>  provides an example of how a consumer can request an IRQ line. Since it is a
>  one-to-one mapping with IRQ GTE provider, consumers can simply specify the IRQ
>  number that they are interested in. There is no userspace consumer support for

Reviewed-by: Dipen Patel <dipenp@nvidia.com>

