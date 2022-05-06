Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C1F51DEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353874AbiEFSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiEFSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:12:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7F16A071;
        Fri,  6 May 2022 11:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVfVvbd3hxCT3tkOwv5vgsmzO05yDcQlq/ROp94yUWDhhqKBQD94rnomtJstiJE3epkPQ9hh5sNUv5tdEqkeAyoC+ihXVPJies5hzlg0TiTW+ZjkgMIwLwfzbUP40ipxErpl5YTyS+t9RseiVThT9sbVIUW1PQ5cyKdDXf1qAhzuPqI1fvA++9G563XUR0MUfGQuW5dx/TJIg1YQjpPyBc0T82KeEHoaxfzhCejjSbUw/SVHt8KrbYkEPMbjpoyu7y+AyrbxQI5KADTApcf8la+CtmV1NXD5a3hSfV8lbu/1zCGnMJw7EjEeVFZa6RyLijpNlDogM8Xg+DJx7j8HEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gur0kZ2jKjXidwY5qe8VfCjxZSCbRWVdhoqa+SRwH3A=;
 b=Ap9PV/4NhPic4kAPSNFF7Y16/hf+5gBGAKgeyMzPhH71f1Ozu5Bc9ciB/xuXtb4f4S5D9JKRLHyI3QQPyQdZkWn8UbyJNoouWuYqZVA2l1DPcI2yK78kujDZvrL/puIcqcZzyHiaqIwuW2+jfxn+I4UrGkL8+f1OCnd1ThAEngEEYg3LfIFaoK4muV3lygRL/DeEXDQYZBXSebu4HKVKzwrIHDOUwngV0COc+s/CKoU/s5KLDQSsGcvDlVGgWFrbTrls+KNty9eJeGWAaZQovUl6m4YZD8N3aWiCyGAymd82np0+90pZO5TWNopYPbQoz4kd7hSFk7wetVcxPg3gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gur0kZ2jKjXidwY5qe8VfCjxZSCbRWVdhoqa+SRwH3A=;
 b=AENaYxdsJECXMxdi8C4hb3JK5HGmeFSbESvTDnsZfddHrRvWF+ZHCB/WHRqfzfMuac2d3f+Ad5mOZShSrRYwmg0sM1ak1QC2ZL0Ss00aCTb/w/Wow0+w5b0OmK611LwXexB5UKTFV/TBaRBaBJPL11RBdEUaKvJvxZDgUE2U1tCQnpIgvA+Ky6EYMaId0BVZOfvBxGQhgs9RfG6DcQrfQwMLfvqC3hXyt8hqBf3Ly3FQ0+cheGwAt+d1CCFF0G8y9FgBxz9TnoRbsVyD6vaqXjqpzm5U7MKrKx8+4OTXoYZRUrodT0X64cNEVDVJuh9knd27o7sVtCwwhGcqLUggcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 18:08:19 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 18:08:19 +0000
Message-ID: <0d567a2b-89c7-9022-8481-fe6be426f433@nvidia.com>
Date:   Fri, 6 May 2022 11:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hte: Remove unused including <linux/version.h>
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220506034209.59848-1-jiapeng.chong@linux.alibaba.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220506034209.59848-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 104fccf8-ce41-443e-1b06-08da2f8b665f
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5761A852B7861990B10AE661AEC59@MN0PR12MB5761.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCcY20Sf9LxUIgt5z5KTLvSKhgts6Ky8GKbC7MTuOnZNbe3G4gtIsSUP65KGYnVZbHiUiUYIZ7uA7iq32zMIhsB53B/9RGMRqCSNLcK2iy0zizrd5c0RZMFjwASXuguemhdx6fYxOpDwac4E2WLV+tW/yfi5GH8C6Kmw2cFW0ZoAi9Yaj8gILnw4cOQqACG5nZgQT5CPhiYJD97Gm+Uh6CZNmtJbU5a05q8ysJ4Lcf/H61SfLvjhj3XeU6YJamXhHEr7cTkiiqCtnnpKC4Xmm8C5FFdN1RfLiIfR5toNISODxogWieEjfLSxDXeRoVJNPADLHaty+3HjRNnJAv/poyHvkCCYSps7tREbJHYvTZcxIqFOxQvTY4Wl+x9ctzerIHLuCJN/Lo7TK9bksMaXzSq4D77ugNqsRpnakNf+eOHLKrbCZNEPuhbCorZMDBuozyImWZfMZlmFv3sXTEwUj/EjH7LwRdvg4Jms//WGbrAndv5qkL52ftGxA2ns5yyzVMslh3s0GuXGhS2TGMcsROWDvmznV9MQ9XyCiNDZJandDs8hTLyfcFp5sXHVAn4iYZcXjUO0x0Dtc632zSEFjZQ8hyjCgiACUiHx385FRuYtq7Mfip1FKLPZOj89+AO4M0OeyuOdCwb9ydAScEg5ApLDzy0v9+sCuwNnyRKTjuxiYD7g9TDDUzHbdf7zV7TwxIfsM/OL+uzJPIvjgNBnzR4meQMFdrI3u4mVESIsQoxffn6U6JAY18P6ZYsviHZgvYHQnQYEuCjWr9SY53BRNvrMIYlXxeCkSPtm3Y3XgtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(6512007)(38100700002)(6486002)(2616005)(26005)(186003)(53546011)(6506007)(83380400001)(6666004)(66476007)(66556008)(66946007)(8936002)(5660300002)(4326008)(8676002)(31686004)(316002)(2906002)(6916009)(31696002)(86362001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGpJQ2VSZDFaVDdsdUMwYldUNXZ2eStaelJCd1ZtWHJsZWMzTFN0UWxrQnNp?=
 =?utf-8?B?bnZjR2kybEVBTjRsQW8rdDFWNXFqY1FWeW9DenByNEU5azVBbmhWd3BJSEI5?=
 =?utf-8?B?bm5JeTVPRzdqSjNha09xRFFMalc0NlA5NXZPRjhzNVZtOWZJR2owSXNJTENW?=
 =?utf-8?B?dmZsZEExcmVqd0YzWGlsNXFReDhlYUdjZTJtR255QVZNMXJNMEhLKy9GRXRt?=
 =?utf-8?B?RFNyWWI3RzFsRE1xMlRwOFZMeU5SN2pIdG1nRkUxOVY4ZlQyNjdabk1jZkRq?=
 =?utf-8?B?aFRvTENQcTVWSVZZUlk3TXc3dEY4UWFUcTRkRzdDY0hya2VIalZLYVJCZE43?=
 =?utf-8?B?dUFJOElJdDk2cDc0MlYxc0ZKOGxRVTd1djlrS2xLdFF5Q1pleVh5QW1POW5O?=
 =?utf-8?B?ZDhVY2FMWXNmMFNjZ2lGZmdaNkltaGZielJIQ3Vlbm5lYzhVb3EwM3VCcDAz?=
 =?utf-8?B?L3MvYllmS2dvOEMyWjQxVVhlTDl3WllxeVZXNDRQNnNnYTRlRE16dHlOTjRk?=
 =?utf-8?B?LzVKRGlHcTN3Y1N1WmUrcVV2ZmxIMXZHQXpQRjhXNzlrM1hNK3lVcmNJQmFn?=
 =?utf-8?B?L0dVMlFLbHJoSk5MOXJlb2Q0TWhHVVN6MkJNbmVsYXVidXpheU5tZTlyekVO?=
 =?utf-8?B?c3NXZTZBK05FTGF3TjM1S20wSExlaTZpWTVsK0dDRDlaKzZrdks3VWMyZThn?=
 =?utf-8?B?Y0RXWXZpRDhhVG8xK2taY2d5OHBnK0hnZFZ0RzNUdVdFMEE0YnpRYW43Vlhk?=
 =?utf-8?B?VXdiTlJhUnBtczh6S2ZpUVpnOVROQlRtbm1SZDhrb29YL3Eyd1BrazB1UUtY?=
 =?utf-8?B?SUNJOGpuOFJZRlJWemRUNythK1UwTUxteVJQZUFmenN3YmRQaDJPZDlORXRx?=
 =?utf-8?B?TVRIaW1wUmpJRFFId3h5dWwvNEUvU2daQlM3SitVOHNERzg4dkZ0VUdOL3NO?=
 =?utf-8?B?RmdrcGRSU0lxdURhajRkUkN1WnJQR1MvUTlKL3dTT3U2bFJ3cmw2UDhrM0J6?=
 =?utf-8?B?akM3TnZuR2pzV2dyeUswTHJJWDQ3cTFUb2pzMWt1S3NML3AvbCtPQk5uMzhl?=
 =?utf-8?B?b1JPWnlqWjFIV0FhTTkzU3ZqV3ZsdVhrelFDZ3JhZUZHczY2V3FZeGM5d3Q3?=
 =?utf-8?B?SFpkUEZmZEpFMnhzWWV4dE9oeWRtZ2NONWtuY21MOVllYzlMSVpCdDZNTWZm?=
 =?utf-8?B?NklPdlVoVE5DNkY5N1U3STUwem4xeHZLRlpJREM5L0REUlZWa2VUUlRibXpE?=
 =?utf-8?B?WWtFWloyb2dyRmN6MERWeGZNYU9rZklGRktDSFdEc3dSM1F3NW95a0xrbDVP?=
 =?utf-8?B?VTFzVGg0VGtkeVA1N3QrM01zc2N3ZGRBR2xCYVVSYnE5MnZ4KzJqVnBxcjk4?=
 =?utf-8?B?S3hCT3A3SUhDdVh5d1lvckhhdGpkdXhBK2ZQWnFlNm9LRFNTanVLcTFRWk5q?=
 =?utf-8?B?Q1hoTWhPWi94am9ScVcrcFhvY00rN09qajlaQS9nc1FSb0M5ZTh3TGE0S3o5?=
 =?utf-8?B?NWt4VDljNE9EWnI4M0JlUUc0MHh5OXNuSFJBVnFvRVdiR200cXVxeU85Tjl5?=
 =?utf-8?B?ZDZxVURpcW5uZzUrd2RuRFVBOEhMejE0NnA2ZFFpUU5Rem9FN3hDZXJkeXpJ?=
 =?utf-8?B?WDFxb1hVVDNoTkE4eUpwcGJ5Rys4c21SKyszdTBGSlhmOTR4NlErTlA4eHNW?=
 =?utf-8?B?RHBtZnZDcVUyVkJLQS9idVFOVmx5WFpXbzM3SnFFZWUwUkdJRUo3bDVZMkR5?=
 =?utf-8?B?ekRPdFpDUlBZdzVFK1l3N0JtQ3dVajNvTnYrTDVDMFY4TWliWjdacUpZSTlk?=
 =?utf-8?B?dWVmSnF0QUxodHM2QjYrZVgzMUxHaWxhWE85Qld0czArS1cxVXIzbmxrRmVw?=
 =?utf-8?B?eENhUHFLY1VKenBUaUpMMUVHRTc0Q2duNTZoTmZsYlBwR1NxTzlpM3hpY055?=
 =?utf-8?B?TGFmcXBaYmVUVEJBZW1JdXd4MmVtK2pvTC9vTmJ2cTRwMm53U3dyazdMWmdn?=
 =?utf-8?B?eXFrdmNnVjl5U2JvSzlDaW9SaS8va0s5VkczRC9KNHhZQW50dTVqNi9jS0N0?=
 =?utf-8?B?MTl4R205eVhEM0lXUlkwbjdYY2w4WmdLK3lqYkFsTTRLT25EQnIzS2VQUDlo?=
 =?utf-8?B?MDBuRDUrZTZJcGZqS052TEpLNGNZOE12NS9wdTBTN2xOcUdDQkNjS3dWY0xQ?=
 =?utf-8?B?cU1sN1RqaHJoU25yZC9RaENDNFdxNkxlUU9NYkdNaWo2VDBmT1V2c2c1dVU5?=
 =?utf-8?B?SlJuMVlOSUVpZmlsWisxUGNwcGxwYzRDUWFldFE3SzYyb0RSNGlKakhRaFo0?=
 =?utf-8?B?Z3pDVHkxaW1CcFdxcHFSQ08xL1lNNDllZ3JvUWFyR2hTRkR0NmxyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104fccf8-ce41-443e-1b06-08da2f8b665f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:08:19.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6n3rBgH48BgCNEsB2RCX8303TjayChGN8bhYLbPBZjflogFqFmsCqFV6e9ZUtWFkwfgBKIzzMBNuyz6ZkFJHg==
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

On 5/5/22 8:42 PM, Jiapeng Chong wrote:
> Eliminate the follow versioncheck warning:
>
> ./drivers/hte/hte-tegra194-test.c: 8 linux/version.h not needed.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hte/hte-tegra194-test.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
> index bc3ab18dfdc5..6a3e57b57a34 100644
> --- a/drivers/hte/hte-tegra194-test.c
> +++ b/drivers/hte/hte-tegra194-test.c
> @@ -5,7 +5,6 @@
>   * Author: Dipen Patel <dipenp@nvidia.com>
>   */
>  
> -#include <linux/version.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
