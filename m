Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73D2578CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiGRVcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiGRVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:32:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A131919;
        Mon, 18 Jul 2022 14:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHGt68cXFdoja/R287XuYHmrxTTpCL+APk6e2sU2xAXUXORo274IoynJUAb0YIFhWYn2HWMotr4inWg3dZ7Vhed91PgUkByWvPO4XJtOuZtpG8CA6/SNSRI5Yu0PTquui8m/jxUTVc97visw6R6Dfh14l/52PYicBDOxNqVY3yNkFhmPcSUOFjnFYN3Bi/w+eEgSnPmtvG0289OSKeETmg4KFjMJp6THJ5EiV09fHK5B7KkZK0ZNbc8VHBRabzKT7MI4bzrzzS8bxCoYPZl96Wa81wrKXtmO1rUAYToxQsKeD2jUdZaG4/ivhCVx5x4nzPOVv03VUwrwkfDLAQGnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9Bd+JE3v0qb9gopO3AqeQuMBvXmF/Vrczu5FnY3G2g=;
 b=IYIXglijl3GukbHLh0mJbEeFvsJtv6Lw4kNTCSCLhAryx9EATxD5w1ouXqXgHpTEo3pqblA8BMXfgoYIAkhq/R8l8QKgJBJTp28WzdNelxM+1Oj/0l504R+Q2XQw9njj2Y+YairWm/U6fcUJl20yW96P++qmKVTLvCeiJOy2O2yAGhxE2xnyCbmNBHt/GfrW+5UxwKn0B9AIfb83cT8xtPt5s8sg+RLgNKoU1zcO0xTYkJ6mzkauxww5gXGT7qO95mmcPwoSBhN2qL85MTSBSkhy9/J+bJrEqWAJZd/3cTnf0Y4Gi9jTVOvB1SJwDbGSgBWr8dtth0zcrfXM2fg7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9Bd+JE3v0qb9gopO3AqeQuMBvXmF/Vrczu5FnY3G2g=;
 b=Xuh1kQqhfwdw8wQ2IB1yhFMI9JzUq7YapqLwyq4yRY2yUlOqOXNhUuuteMucjyCkSgFGi9PxqKlFhskWE1opdpAZG+kHzoqGdyEzjRGKPrvmUJvKiZWd+mlAKg31wiVgCn3HetSjEGnDuWSi3CaHmXQUfS65r/y8P2BQLR3APLR6bY/eSq/jEZuJ+CxL4HKXx5imwEkMzRXE1K00MLDN4FPhGwveg4agEWZD7Ef4bPmv2S1ivIihqtiQixN4Dx2SWZNLpDEcuTNBFwmmsq3Q3ND0RQh/xJuoZ9wGANvggIutkwKP3onF4xCl7e+6wIEU3AsfVZCbLebfMwyTq8xlbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 18 Jul
 2022 21:32:05 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:32:05 +0000
Message-ID: <57f1b92b-3422-7d3c-96ae-10ad5d3d22c4@nvidia.com>
Date:   Mon, 18 Jul 2022 14:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/6] gpiolib: cdev: code cleanup following hte
 integration
Content-Language: en-US
To:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com
References: <20220714020319.72952-1-warthog618@gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220714020319.72952-1-warthog618@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8712accb-a310-4051-3af5-08da6904f5ff
X-MS-TrafficTypeDiagnostic: IA1PR12MB6066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THIWAYLkvmWSZr0Y02XIkRX5sbtTQFxFpGILnSnxJm2JtlNiDroJvYCybyxHAP2QAZOKYForz/WUk92RVWaUek97bHzn3tRz/ejtkuX00V95BdlqSd2fy1fQnSvsSlcVTcp6/wOjmjPjL1VGjYTYkpn+peWlJhlTgswjE9L3xcLzSEYGpFZr+o+RC23fFnBfwoDsCVxzeJZJRvjAG6M/rXfBi+bwAp+oVrLoPDdQh14NKASOpDMR7PBlZNaFd7OETKTxxM5Cox9Vgl1A9rTXuuPxm4dwUgTQmFbEnaOXWtP60KYktGnq+6ppL9e13qEk3WD8GRKWS2Mvc+NhnHJecPmTv3nUT09ZfL4SdvClqswb/2M+Xlp7/lrzGgsl0avcofY0Ed9Ik3v0xnnTHlXUpcAmkkJSQXybvjyHPN3idvQUKsbkhMBrWPOBcbNNJjwSb0maf9NaEvjRG3YNuT6/Fe1xHNBJ+IFtcml1Wukgq9lbzKS44Sobw0ephtY5+e5OWSp06cuAuwFC3NlTyqel57Gz0Ud4PY0Weh3bUFaxeI+g8OfkCP/2okaTEaUKKAQWWZsKTelkjypfCujbsS3xG+cIberIjJapYrBHQ8wliM8W2FwoN7DMv5if5pxcakkcKnJR+Wz95SxQ1yq9BMLsdwDwREm1i/oKyTIq7PeoBSJORg7Bm5MLz8IsHUIeswGPQSAZ+/0UBNv3CMyrDnFrqYvIJptkM7cIKvWf0OY/dKy3ga0pSDYRYxjHwzJLpwCaIgkk1dbMU66th+Pusj/xeUnO3TCC1MBbNRyJIr53pid6UsUl7KVmzMiKcBlYAfFi7J29Eu0XQkopkwPa59TDKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(26005)(66476007)(83380400001)(66946007)(86362001)(2616005)(66556008)(31696002)(6506007)(38100700002)(6512007)(316002)(53546011)(41300700001)(5660300002)(2906002)(6486002)(478600001)(8936002)(31686004)(186003)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHkraGhHM0VwRHU2TWNKa2lTUG42SnpNVHltMEt2Q2lINDg2WXcwbUFoNStz?=
 =?utf-8?B?VTlNbHpMYzZ2TktQS040VXlRa1dDZ015dm5kY2hUcTlaZkR1SmFVcll6anNn?=
 =?utf-8?B?NDJXK1ROWDJJYU4wM05xVWRFTUIrZDJTeUZWbVpLcENvdWNPek8xeG9UQkcz?=
 =?utf-8?B?dEw1QzJHZkNFNS9PS2VQa1NiVEF2ckxZc1kvY0RVVEpzaks5WkVJWVkwTlBO?=
 =?utf-8?B?YlZhM1dQb3VlUlFWOHZxcVFBcGpOR0lNZ2ZOR3lhcEZVaERjNS9CRHljMTlj?=
 =?utf-8?B?S2ErUjZpSnJqdlhQWFFOa01LNTZrZVBnRTVlREd2bDhBNHd3MDA5YXlNNU1n?=
 =?utf-8?B?WUh2cDNBc2RGS2pkVkZoek1SV2FJMjVOUGtPY0Q3WWdEc3NZRWlEWjVMQW9x?=
 =?utf-8?B?MnEwbFo5NmlhTG52L0JUeDlYRm5pOHFkRlNBWGtmUlVvSkNNTkZzR2xmdS90?=
 =?utf-8?B?Sys1M1ZjZk1hRjBwdkNVWDV2N2pjKytsMmcyckM2NklpZkFVN3MxM2czbmpi?=
 =?utf-8?B?T3RNZjNqaVlmemNBZTFWa3BJNHNiaVpTa1RGbm15Yk8zRnpqNTA4Qm5IRCsr?=
 =?utf-8?B?Q2dWOVhJSFBtanpxNFlhVHRWRk5TV2tUa2dvVmtPNlYzWit0ZklzMlplazlv?=
 =?utf-8?B?bytjZHNOaFN3VEdqTE93OUlXL0xIUFU1SE40b3RFYlpVSXhXaU9xTHNWOGMw?=
 =?utf-8?B?bXBBU3FYaXJ3b0xnU3FUQ3FrRkxyclVPZWlocVNRcWdTUjU5a0JOSE56RXY5?=
 =?utf-8?B?ajYzS2ZTckc4WWJYVmVabjZBdDdYZUZuNDlFNk5tQnNySkYwVGV5allEaFdi?=
 =?utf-8?B?a2x6blh3dHZ5VUNReStRVnJ1ZmE4a0ZXN1VISVVGVk4yWHBvUVZtNklxZ0JM?=
 =?utf-8?B?YVgraUVHaG16KzNHdjhsRDhRNE5JbmdWaWEzMnM4TXpZcmc4TW9FUjVZeER2?=
 =?utf-8?B?SE9RdlJSTHFmTlNYbWJBRkYrUmFadEI2Mnhyazc3QjQ1N3FqZHhtQ3JXTGRL?=
 =?utf-8?B?WVduTnJqMmU0TjJ0NXZUNUhUMEMrREJJZUpGdndnNy9IamZFVlUxUWp2Um5I?=
 =?utf-8?B?cDBOQlJtaVJZVFV4R2JXYlZtTXhPNGoyY08velZucUhuOVV0T3VOMXptMFo0?=
 =?utf-8?B?MWl0NW56ckdaVm1wbVdJL3BXQjNySnlvNzE0WU1iRXVwS1dwN2FVbXlHSkli?=
 =?utf-8?B?RFpjdWJMREVrOFd5VFpNWUpTWHdqRllUWDRlWmM4ZWpwbHF4OWJodXl0YVJy?=
 =?utf-8?B?WUxYZU5VRkQ2QUl2TWY1Z0NRZWE2eGdPRVBwRG52K0V4dG9sYlYzS0VQclg2?=
 =?utf-8?B?THpuYnNBb3JObW5yUDgwalpFck1FSi9jWDJUdXMrRGdJRVZ0QVU2ZnducnFU?=
 =?utf-8?B?UFhHa1diK25TR3ZDenV3YU9mdnNMOFNXRlV5ZE4xU0tuVlc2MXdpRHN5dWgx?=
 =?utf-8?B?TW9XN1luanZLTXhkUzhvNXN3amJEL09nVkhyakZzYUhRanlKYmZvWS9vc3Bw?=
 =?utf-8?B?MWFtN2Q4K2xqZDZhcnJrNkVpVFNkT1dQc0JIRURCYml1M0hjV3ZrcTZub1hS?=
 =?utf-8?B?emtqVkxhb2JxUUgxYTRLZlpuRnFWditwN2puSFAxOWV4RHcwU2JudXBrOXpD?=
 =?utf-8?B?YmxUNUhoSmgzUCt2UStUeDgycDBIUDJWSHF2TjNWU0xwc0VZb20weDlZbGhm?=
 =?utf-8?B?NTJKQ09YMzhqTFcxbXJ2NjZWd2NZcUpwblFPU1NGVDQzY2tRSWMrQ001Z2dP?=
 =?utf-8?B?a3BXU3plZVNlYjg2UXI3ejVORHQ1U0FIWjRUYnBkbVU4cEx0bG1CYXBlSFJ0?=
 =?utf-8?B?Q0NudzZpM0psUC9DQkpHNXk2alhDT1IzWlBEcXhiUlhOd2dhR3IrMnhqeHA4?=
 =?utf-8?B?NVNONlJBTVg5WGpiWXFFNGVKeHBGU1REOUpPSHNsdW52OUVPd3l6ZEoyRERM?=
 =?utf-8?B?NHBNTTR6SytkUjY5eGxPRkdMY0h0VnoxQmlWN3BkeHlZTHFvL29MMWxJYkJ1?=
 =?utf-8?B?RzJBOUd6eUpZNlNWOXZyTUZ1RHJkQk9BcjU0bGRBWUVFWmRrTHRUTnNrRUxR?=
 =?utf-8?B?aWJNQ21OdVlKaFc1WjBDN0VJb3R4NzlYNEh5UTg4TDhIK05kWEtGcnl2Qnk3?=
 =?utf-8?Q?yqJ7LNWdVEp8YSZ8+MvAIjgpf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8712accb-a310-4051-3af5-08da6904f5ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 21:32:05.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcNszoO3UyMfvLwsm8HkP4FNm4iAnT/agIBHRTwG4ZYc/GAf7/5ZYqDQRU3kpIUJ2XxNMb8YcW7kyK+FqNYrYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 7:03 PM, Kent Gibson wrote:
> This patch series is a collection of improvements to simplify the
> code, improve readability, and compile out unused code.
> There are no functional changes.
>
> The first patch is a cleanup for my recent linereq_free() fix. I
> noted then that the edge_detector_stop() could probably be safely
> moved inside the line desc check block, but wanted to keep that
> change minimal just in case.  It can be safely moved, and so here
> it is.
>
> Patch 2 makes use of an existing macro to simplify a call.
>
> Patch 3 replaces some more if-else chains with switches, which is
> more readable (YMMV).
>
> Patch 4 reorganizes the line identification code to share code
> common to alternate paths.
>
> Patch 5 consolidates a number of separate flags into one.  This
> reduces code complexity, simplifies any future edge source additions,
> and makes patch 6 significantly simpler.
>
> Patch 6 totally compiles out the hte specific code when CONFIG_HTE
> is not selected.
>
> I've based this series on gpio/for-current, as it requires the fix
> patch -
> commit c8e27a4a5136 ("gpiolib: cdev: fix null pointer dereference in linereq_free()")
> Happy to rebase if that doesn't suit.
>
> Dipen, I don't have any HTE compatible hardware to test with, so
> could you check that this still works for you?

Only hte logic

Tested-by: Dipen Patel <dipenp@nvidia.com>

>
> Changes v1 -> v2:
>  Address Andy's review comments, specifically
>   - Patch 4 move ternary initializer into a helper function.
>   - Patch 5 variable declaration ordering.
>   - Patch 6 remove obsoleted comment and tidy some if expressions.
>
> Kent Gibson (6):
>   gpiolib: cdev: simplify linereq_free
>   gpiolib: cdev: simplify parameter in call to hte_edge_setup
>   gpiolib: cdev: replace if-else chains with switches
>   gpiolib: cdev: simplify line event identification
>   gpiolib: cdev: consolidate edge detector configuration flags
>   gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
>
>  drivers/gpio/gpiolib-cdev.c | 291 +++++++++++++++++++-----------------
>  1 file changed, 151 insertions(+), 140 deletions(-)
>
>
> base-commit: 7329b071729645e243b6207e76bca2f4951c991b


