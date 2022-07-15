Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D1575ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiGOFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 01:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGOFKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:10:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82A753BF;
        Thu, 14 Jul 2022 22:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aALAk3EcZPg5/NXhpp3EvMP2Spq8bsMu1U5TlVpfMK03JgoFCCMoP1ZHzEHg8XoVYj1+nhiftc+yePdDG66Jqg+V+pMmCNqkOAipcMcXX0a5m1E4PaTxqq6mEzsVgGS4cjPzfdH2ZGW4rS9C6aBS6DgM0uuw9Y49fs1RKq/K1G7pMTXh/iV1mdyazG10UgFRis/w+o2FadiPaQa7lbW/5lVmnG1FCmElgU1QYonPKCdygdPckCLQqPtjpIBvJxU2sm58zs9kV+s0+kKxh/1c296rPyIC+XvGEjsok8Ad5Do1+nP8g/u3iMIkqysAF39JXOMkXyBEzVqRe14d3e2hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPfB2/g2dm3kf5N6t8yRF12FQICyz+2JU/TBz4fO3CY=;
 b=Cwo9GGtJIFsKUHhxLagymnNgr5iaKpiIHNqdTzFdmTgTqCYrZRrT1nqK2gr59EpyC3v+BBRTd853tY/5dEMcTyBNcSWdF6djNcAE8+anE8qOQJo9YX3PqNZ6T8ZHecqlVORPWuSLKVsi0oUv7xcy32gHmg6AUNENgO9Zq3SC35nqpSWAZXKl/k6wmvy2fkV7iRUA0Wz1NWpU961JPU8sGGWTDs/K59C4tF8n7MgwXyf1Ls0W3mxutscs51/HOTTD4ygiX8zdAtmQ5QF51xtZs80IiFgXTLCGu+4DAKuvYQdPX0L5I+Hqa6Sr8LuLerIiI12Lk0X/g5Z9asyg/392jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPfB2/g2dm3kf5N6t8yRF12FQICyz+2JU/TBz4fO3CY=;
 b=rYt9Sjj9gaNYhRVFhmjocvYdwGv3z0AMaCDWBAwYuTa8k6D9z5tdFCK8BymYXCeCbWRHGoKAXZ+MXZQnpgVeR1AeXAyQfAyheb6MDNYyEYcG7lBJFNhv8flFADYwI7rxZLneIMI760W7U9kkrGXbMUh2uP6PL7s//B7avtPKAR9gianZUw2Z0iKorUrsx4cVW6Z4N2xjVI32vktN3XmjCB4INUsISFVf9yUn5TmpMuwm4Yx9E8iIryyMIJMLCJvwcmOLmgj48QqsseKYuGYvo6DyHm9oAOc6iirrzYuVs+vcHy1oB7prF1N58dsRqsP8kOl6BsQ2VoRU9WQmiayeqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN6PR1201MB0196.namprd12.prod.outlook.com (2603:10b6:405:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 05:10:06 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 05:10:06 +0000
Message-ID: <634d07cf-596d-c116-df41-3e4ad05179c5@nvidia.com>
Date:   Thu, 14 Jul 2022 22:10:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/6] gpiolib: cdev: simplify parameter in call to
 hte_edge_setup
Content-Language: en-US
To:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com
References: <20220714020319.72952-1-warthog618@gmail.com>
 <20220714020319.72952-3-warthog618@gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220714020319.72952-3-warthog618@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c178d22-b5e6-407c-562e-08da66204869
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3haBAtcnzPvvmr9bP4BSrEjb00OhxgXaSpPHi2v2oSkPAyDF2ftU1e7JutownCTr+x9Xl6dq+Z547QglXiHmgPqMdqL9ox5xLD3w9mcNoNLkGTNtPPNdE2Y+FOAk701l7I4fW9M29HkR/8NxNIt8XypdOPi4x1cyR/18gUQWZ0AnaFQV108qUcBL1RjCXScV6gWE3Gvq4YlW0PJ+EHfLY7Ds2qjNA9D3FSLRazNkYTnQh71F4atKyP2bttIxpUirvnlAvWGCHNvXEx8PJ1OHexBwrsbRPCA4zHTQkQ7ANWjpcl1IGCD8iBWDVsmrqNoOnYcUZoRJSlCqJEQNX1Ib37tQf7C4Tx0Y5t5tpjofMjG+oLJG6zdrXmL1SnQV1VTPI5myZC7crfs+YgM328glpi5AWyms6vakMgbVYYjtHOivm8k2+IFX595Q2A69x8q3PihVga+vKJmGzSkeITx30b6pWp1Iy7Fuun5VLcbOdphbm8vmbFDITKHLup4WbAAhxb7lu8cMmTdsqYmWpYR2k9/gCjzW31zzwo8eO07zgsPAoZZOVFT9hM8Ol8FneZXCuTrR+WRAZwzshRgWJIc7bX4eO2sLjplbRtgqfnp1Rumrw95X2RDHD/D60QlR5MPEIj4a41/HTTpvel+M8UH5W70DQ7H2c9zjNDYwUHN60/LHt5FjqzyD+LWuMNSiUt2g3E7GGLnEFA7M+n0eCdvL9vFKcTx+hhE0qvRMncaFn5lNiFxsVkqLo22S3/vWux1YgMOdioeInEsOCPqKu0+kExMX3GUWqqwwzKIYJgC7/B/0YLNOZI1HL/asYsAH7WcJckOAU5ikj82cIUKSBcoEUjswvLoocKGn+EK118NJrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(31696002)(86362001)(36756003)(38100700002)(186003)(31686004)(83380400001)(2616005)(4744005)(8936002)(26005)(5660300002)(6666004)(41300700001)(478600001)(6506007)(53546011)(6486002)(66476007)(66946007)(66556008)(6512007)(8676002)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpaekFzWGoxZVVQdlhmQUFVQnJPcGJZSkNPU2s3MU1qNGhpcFZiTUV5Rysr?=
 =?utf-8?B?ZjJQVHpCWkswZzByMkhJajI3ZDB2c0hUMnF2TmNla2lSZ2lmbGtOYm1JK3hV?=
 =?utf-8?B?VlRRRm1pZG9uNW5HSjZQVW0wTk5XQXdYTHU2cnJoVjB0Q2UrYTVnUFBiTGxj?=
 =?utf-8?B?WEtWNHFjWFZEcms3N09mUDJ0YUpWd3RuSElDaEd6WWpjNUhCL0ZKSHVGR2tX?=
 =?utf-8?B?WFVESi9SYTZtZU9EOFY5UU5OQUZYRzlsYzRneHlIdTNVQnkzMzl5QVRXaWhR?=
 =?utf-8?B?TlFVa21NcEQzUVE4VVhYaHBNeGppY0lZQVc1NjVocHhmb2l0dC9Ma29ZL1hY?=
 =?utf-8?B?b29VcGsxSEZuQ3h4Y1hld09RNDgyUDZNdUt6aFRiZS9vRmMxcW5qSWNGRXI1?=
 =?utf-8?B?TVJ0L0c1aTIwZzFiUDQrMEJjVVo2QndEZjJUc2s5c1BqamtheVJoY3NkcTNJ?=
 =?utf-8?B?bWVFS1hnMWtxWVR2NkEyRU5VUFBwYTFVeHY5VzhpRTdoTkx0MXFMb1RmNXdI?=
 =?utf-8?B?aXlqR3BNbWhYSU9iVHg5MXl5TmQ0WndkanlvK3pROGQzWXNYRVQwMkFsN0VZ?=
 =?utf-8?B?encwQ21FZXBJVnhkWEY0ZGNBUG1saWtqSnY3cmFzQ0JHNWdLaEtJanVYYWRk?=
 =?utf-8?B?ZVl1RGt4anNPYm1WRGFCRWVnWjB0TTRxeUsyRHlLSmEwbG9BbjlxdWJxZFVU?=
 =?utf-8?B?VzJOMEtrMm5URncveEVHYmtpZEVBZTE2QkJRaG5FQjJoSFFJR0t0RGZPTUVO?=
 =?utf-8?B?dlJHZUplZ0hIclNrYk53Mk12S01Gd3NXODlaeVNzRmRXbFNyOWUxMVJ3QlY5?=
 =?utf-8?B?Q1VuT3lYMCtxNUZwelNPMkRUbU8xay9PWDhnVmJSdWY0OWxSb3paWEdzZSs1?=
 =?utf-8?B?bGVRUVBYN2ltSXB5REExRGQyL1IwMjAwVGJidVJsSWt2eFlxdUo4REJ5YUhn?=
 =?utf-8?B?Y1RWQUhpQ3NpZGpsclN2Yk9VNVhBUjNIM3ZrVDJBK3hLM1pZZzlGZWZYNTZW?=
 =?utf-8?B?SjFFZGpxbGJ4ZUtKVUpNNU91RTlYNVpKTlBzTXgvZ240bURpdUZyRlJSdDBK?=
 =?utf-8?B?ckVTckhTRy9hdnR0eUVvR1hNOTN2MW1BR2h6ZGQ3SnIwMlJTM0FnOXA2YzFG?=
 =?utf-8?B?Y09YS0I4S3RHZkpZZHluWDQ4eWxVZnJLR3Z4a2QrRUgxL3JpbEZTSlg2NnhI?=
 =?utf-8?B?dzRNU3Vpd1NuZEhua0QrVTlXTlUwTXk2RGZMTXpzSHdDQW5EVmZOYUVzZ3l6?=
 =?utf-8?B?bU9xbzVmOGpoTS9jcDRQZTUvVWlrS1ZmampLZnhFK2E3S3I2S01oVFFpTURB?=
 =?utf-8?B?aEF0ekpyMzh4T012ejdKRU55clJYbllYaStWdmkyTnYrYlRRU3BGK0tnM3ZS?=
 =?utf-8?B?eE1uSmp1Q1k5cHNOY1Rna3JGOVdtRmtTRlB4a3ZMWWllRG50WHVIdmUzZUsy?=
 =?utf-8?B?c05Rd1NNLzNaZzQ5VklLdWZIMlEvMWFFa09FOXh1TUtCQ1hZRzBoQTJ3aHdh?=
 =?utf-8?B?Ylg0UFlyd01IaFIrK3hRRmtGZFVPQm02Q0NTU2RHdHRIQzlMclprV3FCb21K?=
 =?utf-8?B?aTF2YjV6NXlidjMrR1RUT0pSNnBkTjhGd3M4Tnd6LzBHaFdJYnIvdC8vdEVJ?=
 =?utf-8?B?R243TkpjUmYxR2JDaS9YcnlvNWo1bEx2cVBDWmdMSWNKVk55K2F5cmsyZ05a?=
 =?utf-8?B?UW1QdUdlUnRuZFNKNkZuQzJuM0xDUUU1WkVwL3ZzUGluRE9MS1dsYXo1d2Zi?=
 =?utf-8?B?cXhMV3Y3QUVUVDB2dVp5MldJc0NuM2lEOEZSNVZsZzdoQXErSmRBNlJ0eFo3?=
 =?utf-8?B?SDQ3TUltNG9jWXlRTmUzSkh2S1Rac2pqc1NXb3BJR0E2a0VnaFhsZFJEU2t1?=
 =?utf-8?B?bkw0Vi8yL08yd1lSaGV1ZzMxUmpFNVFRcDNZbm10YU1LMHlzbFBZbjV4c2ky?=
 =?utf-8?B?STNIa2VmTE1TbTZDS05nY1VNY1RrcFdVYTJrSWZNdGp2ajdwQ0FvWHh3MkJs?=
 =?utf-8?B?NU1Zc2lQMmtUOXk0a0l3NENoMGZ1UzlIVkt3TGdhMTZqVVJNeHUrc3N1Q2VY?=
 =?utf-8?B?cDUzUm5RRjd1M3BNU1UvNHFuOVU2dVh3RWRwaDNPSSsxa2FHUmFoVFRndkk5?=
 =?utf-8?Q?GqKcaauSYNfq4Y35lhR3MgK2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c178d22-b5e6-407c-562e-08da66204869
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 05:10:06.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdy3PD24qw3WRqB8FYc9OhJe15W3nWS2HObeFxS71AlNBgDPuaxkf+Aiyzxso3jIguph9tvEvzsAdODnFokpJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0196
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 7:03 PM, Kent Gibson wrote:
> Improve readability by using the GPIO_V2_LINE_FLAG_EDGE_BOTH instead
> of combining the rising and falling edge flags.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index b44526e3630e..f635bbbb6a6d 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -885,9 +885,7 @@ static int debounce_setup(struct line *line,
>  				return ret;
>  			line->irq = irq;
>  		} else {
> -			ret = hte_edge_setup(line,
> -					     GPIO_V2_LINE_FLAG_EDGE_RISING |
> -					     GPIO_V2_LINE_FLAG_EDGE_FALLING);
> +			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
>  			if (ret)
>  				return ret;
>  		}

Acked-by: Dipen Patel <dipenp@nvidia.com>

