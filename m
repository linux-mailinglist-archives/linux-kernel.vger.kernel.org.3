Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6679B569391
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiGFUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGFUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:49:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0118E0C;
        Wed,  6 Jul 2022 13:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeUj6rsylO9bhR1hTBc0+MOe9j6fjP3noPYPqSt6YIi909WAVi485BHF0okvNuiGIoJhQvq1MGqeh1Eq2mCW8Pv9o5j6rR97nkpiuaLplb6wODCJEjE7sReLQ1jgKKmcV5ZRzgtohsrGeu4izH4HqrM5Etx316P1ANc2cogpG1cmgy2nIVyskuDFdts5EDqi4HG4vuoULKnVIP4zRtIJr3XhhTM0tUsKJNqNWuZcud/t5U7XrQ2oC8Ebj5z1VQqKS1j8kJ0e/l5aewCpInibFwQuROUvqG+PSgUVEisLqJJ5WxP5ByqyHpzNTA/la1L4PMjDrz4tx2XSvbxArXUpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX6Q6P1IoAJ2CkTx8LEfIMjYvNAfln/DtFmyuBm7N4s=;
 b=M/tFV+hx2SByHbVAGuoopw6oV5C4BWVbNeGiWgXbEFEsBzyHj/6W2nL0DvqGSq9e+Uak1YooCqt/oilUW1r6Dn7KDEPruqexaqBVS6SlKjAQqgv/b7EAFgerw2loMktF8pqT7VvhRVUKhI/vfv015zcIiWDnTvyJpEiuG/7VHE7+CbNxJ3X6PfgCl6GRS8SDC+ak1hwC+lt96sf/ktWmU51k3niuR5qxh9dzfF37vaL6styTOopru4fzihENTzi01bp0DE7PNbm3Jh6C6jl5H00F7t9iO9+/xPq+08ZOmtoV9Z7Vi7oEnjtfda/1F1z6WL8Y3IAc0v1koL3kqTuyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX6Q6P1IoAJ2CkTx8LEfIMjYvNAfln/DtFmyuBm7N4s=;
 b=fMz4lh4ly0YDP/NOeOOK8YaOc+dn/xM1NeIeRt7a2UGw3OsmxhwCZZHHh0JmlWBpMu3NcAanHKxQh1Eo8NhciEe423yghtaa+gFS3VKEYHHx3e4Dsi3OpDiuhL4h6Nb3km7avLffLd8xowwjV+posHDltAaEx+e5j0mZlV2DrdEwLq8QCJFqBjEGI/hQmFMMHVxYsmgBpFQ/9MkyPWAE3IE8xA3uwwH+vFNstgwV7lT6KY3DKsn7ADHEZE0LcJCKhfK4EtaExHaSQqcCKm60aa9Y51D1qMoOkc50XnC9Ek0Qt413ibIc/kKf/FzSRLnl+v6jpqM5PuV99sVvPBTlKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN8PR12MB3602.namprd12.prod.outlook.com (2603:10b6:408:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 20:49:00 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 20:49:00 +0000
Message-ID: <7e536472-60cd-c81f-254e-bab9fda7ed37@nvidia.com>
Date:   Wed, 6 Jul 2022 13:48:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/12] docs: tegra194-hte.rst: don't include gpiolib.c
 twice
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <cover.1656759988.git.mchehab@kernel.org>
 <de81b472f552bd651f140f0aa779a29652fffa62.1656759989.git.mchehab@kernel.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <de81b472f552bd651f140f0aa779a29652fffa62.1656759989.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e613f4fe-b6bd-4177-e6fb-08da5f90f45e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3602:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3sSt1EZGFiVhY/XuBTg4uO5faBdMO83fo3Nt1OX8nFXB8fcA7piv6Je4ZTPr0SaoYCsEmRVihspcJ/MCVrOVwJ7clttbdmCMwOzFLdc7O3HHFLKJhjECedBtnwiY8IJfbbFAqRUD61oMxYJleyUtquma0ctzBcIkP+9uy/l3oIG4Kwi4pDyfAPPtQriH3tlqtq3NyK6fpKeeoBQC+pyWq++//EyXIGTLvjU2btBIrnT5xQMdyO3ajDShcuigIDcKyMSTpYUQArZvBp3g3vDO85xbTKQzLJOzAsPcm450Um5D/cA08vZpiKBusMd/9ldgMAwt82fNrYZYnS5pdZgvqTm8uUnfyogXgjsJi9OLnZHXJX3zOePQE4Aoc4gt1ez9OyvlJ9msKzI2ZYyi/lb4txY5fk09jvNeo4XHtk9PN+6TJRTkB548RO47f9PfywVZcJ6Ajo8SSPJUe8sJ1258+ZgSn8D2/rTlgwQne0p1W2EM94vbAzSM1FGXcB0ovb5e2/ZvecDEU65uhZhFHuzemvbIbJPl/xJ3dqRhgr5dPZUdKT8MfpMUxKDyNHt6xbkJDn269/gJbj4EpctZHRkVOt5/zVP151Qe0vWjYoFtIeX6uSM9fpuQWw2B1SfsfT/sm9fuSYj+40hZhhbd1+3bPrscA5yrFMU4ZjCXgvyG0QlDZkOv22HnPok04+63q4WJHYFHflSSRPhkpQPYVP87T/F6+Z9n8C+bAI6mi/fjHOfpvoAcG1mZEzNwd2q+l6hZ+oTtlAnljfeXbRVwaSueXm+QA4LBXyf4YDMYzHMl/JaU5NznBMJnhMxkBfjenkWqfLidkgp2gfZqXmPizdaDfNu1NoOOx195gL4CQU6YDG58SdJO6Bm91L+qRkdhI8+uKoMMkKijXz2BswUiCYQnfxqpnmOT4HK/rnph99kAB11KvtJAt7LsYQVlSSpWw0v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(110136005)(31696002)(83380400001)(6486002)(966005)(478600001)(86362001)(2906002)(53546011)(2616005)(31686004)(186003)(6506007)(38100700002)(36756003)(26005)(66476007)(66556008)(4326008)(8676002)(6512007)(66946007)(41300700001)(8936002)(316002)(5660300002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tYbVl0YVE4NVA4UmRYQldFR2tGWVhWbk9iVUNxdjlGSjcvVFBaS214bE1h?=
 =?utf-8?B?UEtWQjZWbDZVSXI5TnZWYnUvdHFSUml3SXF5bmc5Y3cxVldrRHZIeDlVTDVm?=
 =?utf-8?B?Yk5XVmQ0Yy9QazBGNnVZMmIwZURSdFljSEZ5blNxOWRVRjRKTC91UTJtMGJ1?=
 =?utf-8?B?VE9DQnBSdk5vMmg1dWtyRExCcDZ5S1lHWVJ5QTlqbFNWVUxXN1hzc05hMG5U?=
 =?utf-8?B?WXIyV1J2UndXN3BFR2pobFBhdFdOOXNGaHdWTURiOTFXRW9DYzhCVHlnd2sy?=
 =?utf-8?B?dXI2eFVhRU9kQVZ3bTIwTGtkeThlWENpUDF0bHhFcFRKVzhxK091TnNkUzJl?=
 =?utf-8?B?ZGUwQzlnaFd1Q3ZTYmlYMDcwVjlHV0I3anJUR0RxZVlPWkk0SXdiYkJkanNv?=
 =?utf-8?B?UUMxaEFneDZ5SE9Hd1IxZ2ZmenF4NHFXVjZlY1EyV0ZKUC9Zb1htZEFQT0tq?=
 =?utf-8?B?NUUvMzVxWFU1THR0N2pxRS8xU09vMTdKa2ZaMWVYOGNxY1B6eDVheDJlQzQ3?=
 =?utf-8?B?Q01Vd0FNdm16T0IwaVlnYVZFNXV4ellPZW1mK2NWSmpXd2Rtd29kVnA1N01O?=
 =?utf-8?B?bThBZ3F4a2NIdklRcHZLYlh5N3N1L0p5cy9uekNnSE43Um11djE5ZUhObGw2?=
 =?utf-8?B?NmZKbUpFNG9GYUdRRVBBdGdQYU1Sc3Q5Sk43TURSaktyVEk3MVVQOGtwT25W?=
 =?utf-8?B?SjRFOHU3YlFpUkI1clEram1ObmpGRm5RalNtVFZmZDdrdlZIeTRJZG9GZnRQ?=
 =?utf-8?B?d2h4OWkvZU4wU3VHRHZ0cDk5dEdubUZhTkNVQWppRkVQRXFWOTM2Qmo5TUlM?=
 =?utf-8?B?NmpXR1VpNXU3VEhRVzdBQStqdURCaGhsRkNLLy9jLzNSOWI2VjQzYms0Wkk0?=
 =?utf-8?B?VWlxd1JWdmppNkQyR2NGUm1za3U1WjU0VHNrV1lxZHRPYk1uZUdQTnYvcER6?=
 =?utf-8?B?b1BCSzZZTmFIeC9lM0hUTGxNL3piYnpEM3hrMldsK3ErUkp6RGFvM2ZZKzdX?=
 =?utf-8?B?RVdFN3Z5R2UrUGwwVUFWbC9iV2lnWm5LTWJqTkprRzJMTHpUSzhuOHNCaWRy?=
 =?utf-8?B?MGpGV0RieFZ0eGt0eXRsTHBnWFcrdnA5R2cyVTNtNHQveC9OdDFmaEg4S0dW?=
 =?utf-8?B?TTdNaTFSMzRrd0YvSmwzVVg1eG1WaFg1MnA3MU9pQURIWFl3dGpPOVg3Q0xw?=
 =?utf-8?B?RzZoVXprYXJYNWkrdG5JM0hXWnVGSkJWOGJWcWdrRExIc29uWnpDMWIwWjBN?=
 =?utf-8?B?Q294RURTLzFESzZHT2hoempOSmRnME40LzNvejYrTFc1eGxJelJCM0w5Umk3?=
 =?utf-8?B?c0o0WUhuZ0xCbHNvaXpURzVEbnN3d2hNdjhQOGY3VEFwamVyLzcvcVcwNWNh?=
 =?utf-8?B?d0VyeTdGUkVQOTdGMk42YTc4ZThKZktTQ05od2c4N2tzTmsrWXEzdS9kN2hU?=
 =?utf-8?B?cFlDaGdDd2NSTWJKQ3lRUFpTa2crOTY5eFZPWGtKcU8zbFFoc2haRlBkbmpl?=
 =?utf-8?B?cEVsR25yK3RkcHU3T1pzclNYSmo5anh5SENQbi82cWl3NzY5cU5GSVM2VXJu?=
 =?utf-8?B?eGN2RzhQcVNGa0l0SmZ0SUgwY0tqM3JoRjVZSnBxZ2U5Vk94ZW1uSDJRcDFP?=
 =?utf-8?B?QVljOUU0MjlCcTBlYlhDd1k0dEJWSSsxM3ByS01HU1ppODYvNHdNeitMc1hv?=
 =?utf-8?B?ZEpQamhXSGNuWmREalFMUkRPcW0vQ2lldjA5K0ZoUjAwaTJ3OTBJSnRLTGg4?=
 =?utf-8?B?bjlVYzNsN2djZHIremR0dW8rRE9RRGxkZ2RyQks0dFdXeVBPN3RFSm5yTFh6?=
 =?utf-8?B?bm4yU2wvWmFCbU90aDFZdzQvWlNJdDR1c3JhOW5tQUlma1RzL3MzMjlVdlEw?=
 =?utf-8?B?UWFWVEJMUGpOK2g1T2lXMk14Ums3QVNHcCtiY1I4UWIvRjNNald3UjFnYzRz?=
 =?utf-8?B?ZEE5bFNNeVgzWG5ZdFRtMTVGNEVzMU5mNkt5dlgxbk9IUGl3YXdOWDBTMThM?=
 =?utf-8?B?VThEQVJCNlo0VHFxZXF4R2RlUUs0aVpsdzB0R3o4QVZ6Rk5NcFpnaEUxVnBW?=
 =?utf-8?B?Z1VlbXB3L0VvaTg4Z1N2YkNTb2ZEa0xZelZjcDJQbEx4RUR0UjgvMDB6TXR3?=
 =?utf-8?Q?ddf64OWfX0Hrf1gcxkHMeMxd+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e613f4fe-b6bd-4177-e6fb-08da5f90f45e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:49:00.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fWkwkRY9fg0bXBoo3jBhuOfGKlNKMM/DODFbtFrWyg6zll4p05nJCe763udZsjWZWGzs5DpmJ9iqH02SyyNeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3602
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/22 4:07 AM, Mauro Carvalho Chehab wrote:
> All extern functions of drivers/gpio/gpiolib.c are already
> inside the Kernel documentation, as driver-api/gpio/index.rst
> already includes it.
>
> Placing a kernel-doc here will only cause mess, as the same symbol
> will be placed on two parts of the document, causing breakages
> in cross-references.
>
> So, instead, add a cross-reference there.
>
> This solves those Sphinx 3.1+ warnings:
>     .../Documentation/driver-api/hte/tegra194-hte:28: ./drivers/gpio/gpiolib.c:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
>     .../Documentation/driver-api/hte/tegra194-hte:28: ./drivers/gpio/gpiolib.c:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
>     .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
>     .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
>     .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
>     .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
>     .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
>     .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
>
>  Documentation/driver-api/hte/tegra194-hte.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
> index d29b7fe86f31..f2d617265546 100644
> --- a/Documentation/driver-api/hte/tegra194-hte.rst
> +++ b/Documentation/driver-api/hte/tegra194-hte.rst
> @@ -25,8 +25,7 @@ and userspace consumers. The kernel space consumers can directly talk to HTE
>  subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
>  framework to HTE subsystem.
>  
> -.. kernel-doc:: drivers/gpio/gpiolib.c
> -   :functions: gpiod_enable_hw_timestamp_ns gpiod_disable_hw_timestamp_ns
> +See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
>  
>  For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
>  specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``, which

Acked-by: Dipen Patel <dipenp@nvidia.com>

