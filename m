Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1DD50F287
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbiDZHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbiDZHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:35:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB3103DFF;
        Tue, 26 Apr 2022 00:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrL9d75bwVkY4jmwxvLAo8+h+EWFMGzazoeM95Ozcxn+PzpYcc5gSEWsPjeqXjNaBT4gyWhn5ug+frcQtYRkRP5bUpmXkknkCE2oX87aouM+cjOKNFAKdmN5dxl4uvvU9KumqNQBepmryoeb5qjoKjmUZqw9hbdDDRKoIUNBYfBSyORAgWEu8/y13NdipeKbHQ7YaxOGcysyAEIslHhzatBxg9ZP2s6rNOl59Tw01990iiDaDNB+mfGq5XeIIgslbnWiSqDFrfSQvz1E6FDm/5MVuVO4l8EMTKrYQR07jjHPzQ48DamlX3gg+HaewpFy13L8YBX5oUyCQxWFd5vCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOLDXnyvECzdqyjJTmq0PnHdldefeXIS+xLn/YCfsb4=;
 b=L3nHLbYr+2XBfffjOij6YMeBPjdYrP4PTY6BKcFCRFp5SUBDsjwFDgSXLcBHZ2hJrM3wdFiMyug3Z3jTs+Dz/p2OITiYwe+1bhlE1MD0vGxGZIb3gq+h0TnXYoH5i2G8n/d2l9bMYMngDkQDrLUlSswKTp2IczcAckZ923DJjYQtqtiqVjR2sUV5xLC348yHGMRAnI3vbFCQaSCs5JqitmLW3qlXbh/wQE64nYLVQxFNIj22NVMqdMmLBToJrW5b8rQtYbKBhciLDUSEwoddU9iYzxHhfngA9tl7WHfYCETlVyHMDYVYpBOG/9TTzxmjDOjeBOPsGuiHGtBFlAIb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOLDXnyvECzdqyjJTmq0PnHdldefeXIS+xLn/YCfsb4=;
 b=DfHPopnyho88IR8LZladDdYlDqgFsuLw+z2y7quuSubj1AKalJUi+muMJEp8sOFXWKprDRMCvhLPKoj6Jm0vme4Ia2c2U8X4x/lii2R3bK1gFZqzte4hPkRvoKrMbz5U8X5YALz0du5UrGHq+i7/Md7wZlWiCsLNhtoDaWJEsfR0utnmZMrzgpVLE3APzAzRBLdLGgFArM2Sz89jkfVFw4ixU+mozPeewvK52EIMJmELiMCXIxyFCPT9jEQhGNZRwec4KlJIcyyjK4k6m0WSeH6Gysv7N7lNlpo4/A5utOtNV6jT5goHWRzlRUsXBo/KzPy2gM/O/HScB7NKN6kIDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 07:32:39 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::4d90:3332:acb3:395d%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:32:39 +0000
Message-ID: <691c863c-0923-73f2-eab5-65b4238f545a@nvidia.com>
Date:   Tue, 26 Apr 2022 13:02:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v8 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220425075036.30098-1-amhetre@nvidia.com>
 <20220425075036.30098-2-amhetre@nvidia.com>
 <5ddaf113-c8f6-7c9c-5bf6-27f2f7855d24@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <5ddaf113-c8f6-7c9c-5bf6-27f2f7855d24@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b19c926e-c3ce-45c9-b674-08da2756f0bc
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5663:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB566326BD0CBEE85E91A910C1CAFB9@SJ0PR12MB5663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vtf9r8XiygwdiYIxi+o1+zBRn4Utooh8xsUfrSmsTHWhI2/5M942nMddqOgLoYv4yT77/w6f3V153TLJYsJlWqFyO7hIrkgaxNmVZw38ZrLn9pUpVXyshZIVPBAAhzIhsGpMvn5BaHb002hi8g8m5/pqTOvUxXcqClP626hnlwwUHl/16f/V7o5If1ijbkop00rGkdIdDwB5OYMqCMZVqwwfcbvuFlGqsIkEpWEjSm3Bl1Dnxb1jPjl6seM2+E7Pwz34DMKAsC+Xx9ixfuqnC6fYh3VFiZwd1xl6L5k9Mt71VjbZWiSsFhQ89GYPn4ECkt6uCkXa7JLFtD6Rr06yAsSAwEZZwaD10oJi9qVbOUPUkF0aYT3I4nAUGZpyLzQkuAhp2OaYsk8w8wQLAJDbDiAn9dUI+di3qZfX8jL7LF4HxK2lH03mfXcJh81Km7Ursy6YIak98vi+bKSwHGKUL0nNM42RRjj1iduwkBRw6zldj/YF/zaEeXRYktHIPt+4nqFp9nnvMYX0gZHbPhKcewO1wEDEcRt3Dj0gYd9hFsu9sl16G7XLyaR2p0FFanfWKDVm6fx+Z9BhkMCI/I/UdoseBOd9olg8PQlevK+m8sBn0v7ioIz8gqS6J/w2SSWHr477r7xyqCX5No/Zyl9hYsOIiEUj5+wDCwa/CGv3l9C9KE99sgn+gzvCKUN0sk4gN7N1KNxVnPL8Cc7j4PJ3TSWPi3r7AK8gx085U4B2uAML3NPu1a88LF/Juu3kHoqw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(6506007)(6666004)(6512007)(55236004)(107886003)(53546011)(6486002)(186003)(26005)(508600001)(5660300002)(2616005)(4326008)(31696002)(86362001)(2906002)(8936002)(8676002)(38100700002)(921005)(316002)(31686004)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1hZm9sYUR2dWlUa2JTSU9FajV6S1hZeWY2ZXZEME03cmtselgxY0Y5bVhn?=
 =?utf-8?B?bDE4R0N0eGNZZHpWTnZ3L2xzRmc2elFEOWw5M0xDb1ZEVWE1Uko1Q2hwQW13?=
 =?utf-8?B?blBPRDAvRGI4Z2VuM1R6SlM1MUtQdy9Vc0Uxa1UwWFJ3ZXdma3A2b2xKOTh6?=
 =?utf-8?B?T2szRGc1WElRd3QrWHNnWVhCRjFlMjVZZEVzejdKSXN4OGJabmxuYWdhVDlZ?=
 =?utf-8?B?WXN2V0tENGFaZmpKQlA3WmRSRFJRTHZvRjlNZlZGQjBjQ1JrbXplczE0U0JT?=
 =?utf-8?B?S1BDbE5rRWVFQzNOVjlsY3NkTncwTHQ0TitjdWdZbGFCRi9SQWpLMTZJMnhR?=
 =?utf-8?B?U0VQOFpSYTdURDRVTFN2NjlrSE1Hb0xidXpoT1dmb0RLdFlWRFdWc1pzVGE1?=
 =?utf-8?B?OFk4TEh5QnJPUlZrTDJrU1lUdHkvb2dVSW1CaWZXL1RJYjBNM1RNZzZCQ2Qv?=
 =?utf-8?B?dUNkdWdLZUhweXBUUXdnNjViazRmMUQrM251R0JkWXcvaU1IZEdFQlhoa2Nm?=
 =?utf-8?B?V2FKaVFraVhIRWZydEdKck9UOTNhdy96TnFqY2Z6OHFoaXR0VFhqWE1NaDNq?=
 =?utf-8?B?Y2ZVUGFKZ2ZGVW1MTmJSdUQ0NmZORjZNeTdPNFdVZU43MVdkODcvcmJGa3dG?=
 =?utf-8?B?ckF3bDJuUDdrcWVST0ZERW9QU1JKQ1RaUi96MUxqQjA2SmtYRHlsdk1YYUFh?=
 =?utf-8?B?TWVEK2FuemxyOWxxdldndjdDSEVGVkNzWUJ5QXF5SS9vc1lsYWxaY29ZOXdE?=
 =?utf-8?B?WnJhaVZoVkl4Vm1tTnZnbUtmZjJjTDVaTG8vaTNIWFVlbE45SjZJTGpSQ3Uz?=
 =?utf-8?B?TkVMcGtacGdDZ3VhQ2Y3OGtJZGF0VUxIZjVmWUZQNzA3UnZiQkpSa2hZK2Fi?=
 =?utf-8?B?ZlBJbHE5YTJJUWlVV1lJTUpnamhFS0hYR0kxWmcyaWVmeVJhZmFYb3luNjJW?=
 =?utf-8?B?NUt5RkVtY0hjUDJ5TENsNDZmekJXbHY1TzJzRDBKL0p4aWY2N1lER24rdzMy?=
 =?utf-8?B?cHZTSFRSRjMxYXMzWUVMdDI5K2VvV2pYMWU0aHNtWUFKMTVqQnltL2NmZDB0?=
 =?utf-8?B?MFVIYWhoazYwUDZsMnlTcDk5TFo4ZHBPakJLcVJZOUc5YzRyVW5YN1BVRDF1?=
 =?utf-8?B?Q29lcG1GZExibmY0ejdiZVVzdng1SHVReFNlWUUyRkhqb0FPUEtMekYxcnlM?=
 =?utf-8?B?UXkydWR0clBZTjZOQUlVa05BMWlyclhRWmZCakxQVzZWSVBwY1JkdnpNczlH?=
 =?utf-8?B?MDVGMEtKemtJYWowTkN0MzJ0SVEvakNEYk5vak1SSnNkYlI5QnhKNWlTajdl?=
 =?utf-8?B?Y3BSSzNyTDRLc1lpQmYvZFBPOFE4blJBVFd4L0wxNnJWejUrbVVZTWtURG5I?=
 =?utf-8?B?dkhqZ3hxM0ErQ0F5blI3emdCSWx5UFhGY3ZsRmRiRVF4M09OaWVIREFGaGh6?=
 =?utf-8?B?R1pGY2V2eTB3aUp3d09xMENaTUNIWm02MVJGWVVjVVMyMEdqT0w1ays0Wkc3?=
 =?utf-8?B?SHBVRlBDWGEzd2ZBN1ZMUkVqTXFPcEpkbkVKQmRqOU1ia1kxdlFzVjNIM1hy?=
 =?utf-8?B?bVE0WGs0b3VYZER0eVZUOVRreUkzRXY2a3ZDS0E0QVpHQWRBRVR3eS82Qkgv?=
 =?utf-8?B?dEZiSXd6b3NKZ21IaU9ydGdkWExWRmJwNmNtbTA1eDY0TDAxM2w0Mjc2NFBl?=
 =?utf-8?B?aHh4S1hOdTk2YkU5eDl5NFdmOWlDKytuM2IyWjd1RVpldVBMdjh4SjlvcWRi?=
 =?utf-8?B?VVNEM0N3dmc4emRqQWxmYkRnQXMydWdOWDFFVEh6L0lhbDVYQ1A2WWNuckpv?=
 =?utf-8?B?M0RzL3ZKRkY4VXZwSG5KTVhCbUxQdDdKMVQ5R3Z3VjNRT2Mvenhma3RENFY3?=
 =?utf-8?B?UWhUYmhObU9OZlFEMXk3KzRlRFhscHBxbTdtQ21CaXljdE84algrOXB3b0Ey?=
 =?utf-8?B?LzdnK2RhaWNzNFAxeXl0RUlaOVFEakMxL1FmQzVKdEo0RXV6WlRBZ2t1Qzkv?=
 =?utf-8?B?WC9sQzBLQkNoMkhmcU9QbFNuNG1kQzY4ZEdiZlVkeGxna1VPRW5ELzRpeEt1?=
 =?utf-8?B?VXV1NU5IYUxmTFczN3kyUXhBSkxCczJwb0RMWWF5cWxBb01JbFA1cVAzVGcv?=
 =?utf-8?B?RjQwMXQ4NkUyOVM1MGxuc2dhN05zNW1jVzNRZGFsWTBpQ2hZdjkxRGFxR3NP?=
 =?utf-8?B?ZDFTc1VVc3l1WTNqK0t5a2cwR21vdVNGK0RHV0I2ZnUrdDcyZjZqUlhSeFBS?=
 =?utf-8?B?bmFWVi9KQmFFS08vOUpkcitMWTVobFBrMUh4Tk15c0MxYmhuU0huQ1A1Q2Vx?=
 =?utf-8?B?Y21DUmEyWElCZUE3WVpZUmJraXB5djNuNUw4L0hadURyUzlrZk84dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19c926e-c3ce-45c9-b674-08da2756f0bc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:32:38.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y40NhL9Xq45Rwl5fg4cBcvmoea9WZThK34DwTBaOPjzgNvriJ0SvT34xnWqcdj7WZdEpR69R5saVnKZXgMJJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 12:55 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/25/22 10:50, Ashish Mhetre wrote:
>> +static int tegra186_mc_map_regs(struct tegra_mc *mc)
>> +{
>> +     struct platform_device *pdev = to_platform_device(mc->dev);
>> +     int i;
>> +
>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
>> +     if (IS_ERR(mc->bcast_ch_regs)) {
>> +             if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
>> +                     dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
>> +                     mc->bcast_ch_regs = NULL;
>> +                     return 0;
>> +             }
>> +             return PTR_ERR(mc->bcast_ch_regs);
>> +     }
>> +
>> +     mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels,
>> +                                sizeof(void __iomem *), GFP_KERNEL);
> 
> You should use sizeof(*mc->ch_regs) in general to prevent mistakes.
> 
Okay, I will update this in v9.
>> +     if (!mc->ch_regs)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < mc->soc->num_channels; i++) {
>> +             char name[5];
>> +
>> +             snprintf(name, sizeof(name), "ch%u", i);
> 
> The type of "i" variable is int, change it to unsigned int.
> 
Okay, I will update in next version.

> With that:
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks Dmitry.
