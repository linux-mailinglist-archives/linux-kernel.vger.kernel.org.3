Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FA51DEAD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381485AbiEFSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiEFSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:13:23 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7173C6D383;
        Fri,  6 May 2022 11:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heybB6FeabZ+/JOI+kema5WrLRqG+TQSBPH/cXZsvAyI6ASU2BUtOnbizeqnui9bpvwd1o+obSeqpgMehHUkl4YMihgVzKvvZ0Xu/MGk6Fb8WBWi/UGdmwL43PwaUBZi7RkQpHQGuODdwrSg1ju73hm+eGCgeqWC1ENMJ2EZRgHvuHKfLGRKFjAzK5cBCuBp47Zoiy2hYpm2W+CW3IOlH+8dAR75SaKrytT72r6j3IFQwNNEjqhiaxZhH8yXi+VADxI7WN8CTW5w6v3dc+yobKckTdmq+cnJ6cpbX8xXQfGeu38+mc6CHMnackV8mve1kvF6RtMZ9QeFHHOsF25ZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctzNrOOrSLUASDoRSCvKkTcdvkkNnq1wjWFa9nV/ibY=;
 b=J+Tlbjj8vk5cv4wy7f4aF639m+PRclpqjlHgoZfy9tYWJSAl5Znt2+JjKUCVprWMoN5QkHZOTS0SKOTP8UfJQu8zvLX6e32BA3k8mB8jDQmV+VuCivtTsZBryY+Wc8aWK5EvzOQO4fou8RjnD2dw8TbqwUZ7itcrr0QrvbtQEQkAXfx6lEAFirLBVI4KE+vTB6xMjoXC3ItqWnjo1B+oBHiGxvuPc38A+m9E6SulGuOTgFnZgYSAAC04i5VQP2QicbJ8467pUw1mbzDOMen9tUGFaNEDGbbVWs824FfV+C9FLJ2ZSNgRiD58LtqNpoiPrNmEKm6MvmXlJ1qYShoYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctzNrOOrSLUASDoRSCvKkTcdvkkNnq1wjWFa9nV/ibY=;
 b=Ruv2gL+OL7NpJ4muyCsqr8i1hZfBw2hHoFULe0LB0n4yYdLBdKN+E7rNuQ2zInGM7U9erkXUPvbpZTGWam3wJVBUAIGPWB+KC1dCvO+QO92x2fqX8A4NylGVgfzPZNsuErt/plo41Zz3CSj58h3+iwPZ0cTGCT1nsy2fScaFJ3gw+l/5kVpMHAuYoGZd3wm6jEIXC8xJxILVKkNP9pXqbGuxiD4Q9ioLER7DkvLbMMDRDIpKxBWeJlN0suhr86NWt3RNErTv2N/k2k1DJY5oHhelZiL74Ai2nc9KIJXeP8HxA8YLvEO5sDNK0NBMZzJEw8K/41ykZsLw5ZWuQ8TcEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 18:09:37 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 18:09:37 +0000
Message-ID: <6cf909e4-33ca-5cb2-f70b-bd8e8373a929@nvidia.com>
Date:   Fri, 6 May 2022 11:09:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] hte: fix possible use-after-free in
 tegra_hte_test_remove()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     jonathanh@nvidia.com, thierry.reding@gmail.com
References: <20220506084851.3503635-1-yangyingliang@huawei.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220506084851.3503635-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0209.namprd05.prod.outlook.com
 (2603:10b6:a03:330::34) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc91cbc-8a88-4bf7-3fb2-08da2f8b9515
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5761B68F27111F8A9320EEEEAEC59@MN0PR12MB5761.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCtUClMb5eCebEdtvVz/KcPtILlyUEpX3RSWlDeL6WOgHcQEZfJNeyQdWEGG4O9QuPqDEuRQAzuMGxZOGKq9J3BYOH2WK7A82O1qpFAeiRKOJlJ/sdtB4y4mXZpR4zJe4P2nU+IXg19nCva6r56P7Lx/Q5XkJHmfbYGtQcy5Lx1N0ouEzf7M+2GFOO6BlKDwYQENrFzcidEH2xxwNCjQGductHTUE2Ne/XnOjLtfNU7ljAHv16vv5erPl5GYb/B/7HhFwdBySleeWELMCKx9oB8gbyy9bseKA0s79DOUO5hkMKtjTOdsm86AYJlUShT3Ghr5i18PmPjtTLYzCnC0s6iB6cFL/y4MxXnyaI6tFCBYXhGtfbZTb7I8yO4qDcQqaEG3xqa5vXFCur3iNPiQOus7XPaPJyHrYGThK1gVswabUVgVNOrImd3dXWgpz7AggfTzkvV7MGNPAi4d9f98xHyWxmWKU9T0jCxzxFnK9pOApwg8zSEK+uRRAe8bs4yE1CD7d4ANwxywxnyP5YgYEUocvnDfPtTXtAwjPGpK+WKQr99rPqeUpguTSidJER30eQ3/ie7XfjNOgHBG7kYujP99+uwQJfNmXtakOKfIA5JDKHRSe+QbBF+WccEmDlleE+vNnJfKWWRfxEa7b9otiqweP7b4u0LIl2Bi3SL88Z0uyfU4m/35BCbakw2hqDuJLWzI1KCJSbJqZXdXZFSOyUYfIBiaT7piA0FMqWPXSf0EdTWAwsrsVBxgSfxFOwqPI+OKxf0itgsGUxYlMZJ+jBB+sRXRZLe6JQJ25UOUaX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(6512007)(38100700002)(6486002)(2616005)(26005)(186003)(53546011)(6506007)(83380400001)(66476007)(66556008)(66946007)(8936002)(5660300002)(4326008)(8676002)(31686004)(316002)(2906002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHg0blBNZk9yQnBVbEJsNHpNZnhTVk9vNm9wcUk0ZkpKLzlKb0JqUURHdW9N?=
 =?utf-8?B?M21hbkU0U0hickFiL0JXejZ2U29WamovYXNPVFE5QzdaRWoyclhKNlVTUk54?=
 =?utf-8?B?c0lGdGdPR1dPMjJ1OGVtU1QzeDMrWHc0RmRocm1NZHppdEZPRVlzVi9tdHlN?=
 =?utf-8?B?bWlKU0Q1d1pZVWVDSmtzRzFpT3JmMlp0aXE3K09ZQkNWV1Ivd0lGZWYzV1d0?=
 =?utf-8?B?ZmJjQ3NpMGdQUWYvMGptNzBzYzY4c2wvUnIvMm5oZ1FsV0VBRTRMRGZlN3ZY?=
 =?utf-8?B?aVdQOFl5RW1MVTJ1YXNYZFRrZGppSEtOV1hHMWs5QXEvSEd0T3lvcjFQTll4?=
 =?utf-8?B?aStWaUNZQUNDN1ppSGIxOUROY2NzLy8zbVpaT0d2Q3F3NVJRNmJYT2VQUlVj?=
 =?utf-8?B?aVlBVHdtKytGTUdBSFhXdzdPNmM0WTBZSDQzRUkxTU1LQlNwQWw2NlNoYTd5?=
 =?utf-8?B?TUlXemY3N1MyenNVZGpEV1Zqd04vVlF6RHZTZSsxLzNxSU04WElDT3pvMUpt?=
 =?utf-8?B?eENwQWdZZk43dTlHbkEwL0tlMVJMMmhJT3BzYytmQTJkblUxcmh3eVJseFNH?=
 =?utf-8?B?ZlNvR3c0MnlHOG9SdDI1MmZVL2ZCZnc3b3JzK2dscCsxTTEweGN5K1VhT1R1?=
 =?utf-8?B?RUJJZERGVW1vNDFWTlFlUFZ3SlpNd1RSSDM4NjNSb090eldYQjVQMXJySlUw?=
 =?utf-8?B?MDgyTDhhREUxUURzWlVwck95cmpiQVVETStYUkpubVVTOXhGS21Sa0tHR3dq?=
 =?utf-8?B?TjdGMkFCTkpBK0ltT0pPL1FrMzZOZTVVVU9rY0NtRFpzQ2RYWk1QaEEreVR4?=
 =?utf-8?B?M1JNTzI2Q2VKNjhvQm1OVC9jUXg0ajFKY2dET1k4ejJ5N3Z2UWZqWjcwRlcx?=
 =?utf-8?B?UUlHM2hKNUwzSkVaNlFSWjRmNi81d1pWckxISzlNc01uU3RmcUVHTFNZZ1RJ?=
 =?utf-8?B?aWhlVnQ1YW96bWhESzlOa2hpZFFPaG9HZXczaS9jdTEzZkIyWC9yYndubkVj?=
 =?utf-8?B?V1NjNWNHSHZrQmRqMzJJSytwSk56TVpSa0wyVlU5THJVaW9US2JPandIYWNp?=
 =?utf-8?B?SEdwV0VwQXBVOEtJR3BucFFiTUoxZHJoUmlIVXd5V2JlRGtheWVUT2pYSC8v?=
 =?utf-8?B?Vzk1SXBwMGR3Q2ZmVWk5Mi9pMUlEUkdqbUZvYnQrUUxTMXBQVFY5NERCbkg4?=
 =?utf-8?B?YUtqNVFLT21uVGpBcnNnU1k0NEdjTENrRHZuSllqU0ZoTXJPUnhERHdSc0dK?=
 =?utf-8?B?VlVkbGRVNnFzNVMzQ1BzVXBqVk5uMFU4V0E4ZkVXb0xjY3FLQUdxRUpQaUd6?=
 =?utf-8?B?UEFZSTM0MXp2WnpESlZTSGdIYXFjQ2ZtcHJaOGtxSkJnZ20rYmJBZ1c2N1lr?=
 =?utf-8?B?MnlkTW1SaEFaRVRJSHJoTVNYT3pWNUM0bGFycHkybEhDaEMrNkV2aERPaXpu?=
 =?utf-8?B?Tlc5cFd6cXhqNzJvQkNLa1lFdmNSdHh2ck9pSEMrK20rRXk0Z21qNUwrck9X?=
 =?utf-8?B?cVYrNlE0SDVBZGF1TXBkOFI5MXhja0VlQXB0d0hMZ3dHRmxtVHNXYlo4Z2tw?=
 =?utf-8?B?TjN6TVhUbnYwMUVFZzNKZEVlSEFVcTRrSTlWOU44WnNGUlRiMmF4cHI0ekFY?=
 =?utf-8?B?NElYYWxDeVZXbFJNMUlzKzNoT1J4Y3FUYWZoZjNmcHltbzBPRENCdEl2WDk2?=
 =?utf-8?B?YnZsOHdIWGVmSTduVkpoUGpLWXNha3AvQTM5OWc3MllDMThiSXZPd21LNWIw?=
 =?utf-8?B?SVViTnVFczA3MEFBZ0I5NnpjTWJuRU5vczdrREJlL3RZQzEzUWJvTU5IK3hz?=
 =?utf-8?B?OWU0RGJsNmdUd0ZCd3NqRFkwN0FNL3JPTWpWYXhpOVZ3SEVzRW04YUMzVVQ4?=
 =?utf-8?B?TXN5ZkRTNDJRWFBEWDBYNXJ3RzZKWjZCM2NvSTlVeUVGLzF5dXBQd3JtY3k4?=
 =?utf-8?B?aUVQSHlGdmhiRDRkZGF5U3k0SlZsajJLL3N6ZmlvbVJ1cmorTy9naGRpVjZ2?=
 =?utf-8?B?Vmg1WTYybjI0WkhudHIyQ0xLczYvQUhYZSsxNDhXUUNjZnZkWVlack5EQmxC?=
 =?utf-8?B?SmxpOE5vM0ZMaVIwWDhnSTFHNjRwUDlDK0dMT0kvLy9lUFA1QlZtZkt3SlMr?=
 =?utf-8?B?T2l0enhNMFpBTDQ2SSt1M3lOdkhXTVpyTmIvR3VENjlNemJQWVE0ekR3d2E5?=
 =?utf-8?B?c0d1djQrSUlRelh5am9lQjdMeVk3WlhqbFo3VHgvNnF2TThWcHViQWlZQTVl?=
 =?utf-8?B?eWdLem9vTXoxWTFjSmZ6Zm93enRhRzNQNVNGMldTOFZPcVNDaHBOYkVqSmh3?=
 =?utf-8?B?SWxmZXNiL3Zya2RKQXF1NS96aVJ4ZjNhREdsR3FlQWpvSjJ1RHU0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc91cbc-8a88-4bf7-3fb2-08da2f8b9515
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:09:37.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S30bCgBUsWFfC2ep1DXJ9CHD0SjhjSHBGm+J9EycwRWi8faHnuA/f9vaHAQPNUGlWb5kJy5gDryVw4VkZul/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Dipen Patel

Acked-by: Dipen Patel

On 5/6/22 1:48 AM, Yang Yingliang wrote:
> del_timer() does not wait until the timer handler finishing.
> This means that the timer handler may still be running after
> the driver's remove function has finished, which would result
> in a use-after-free.
> Fix it by calling del_timer_sync(), which makes sure the timer
> handler has finished.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/hte/hte-tegra194-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
> index bc3ab18dfdc5..f69a274a7d8d 100644
> --- a/drivers/hte/hte-tegra194-test.c
> +++ b/drivers/hte/hte-tegra194-test.c
> @@ -220,7 +220,7 @@ static int tegra_hte_test_remove(struct platform_device *pdev)
>  	free_irq(hte.gpio_in_irq, &hte);
>  	gpiod_put(hte.gpio_in);
>  	gpiod_put(hte.gpio_out);
> -	del_timer(&hte.timer);
> +	del_timer_sync(&hte.timer);
>  
>  	return 0;
>  }
