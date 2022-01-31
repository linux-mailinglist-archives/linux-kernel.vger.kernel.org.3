Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928164A507E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350888AbiAaUtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:49:42 -0500
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:23104
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbiAaUtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt40wrjJCDAbrLno6o1o2CI19vH5Bwo8N7argEjFTvAsfdklZPw5CrkSUfpLVXjdFrYUbu4215fMVj3BD4ZhDHq8h+lTrkBateWwnhffsV/ZTi/0jzuoU1+0gxF45vRxzjwzHM+W+0xMb/AmPc4U/6IsRx9klp+UNFwVAv2ho6tRYgY4JT0tLkyIysbGXhEOlsa/SydBcHS9taNKApc6eLFH/TXEI4LR6OI/u9oSkGzrhT2ykrj5Evwm+Ekmun4FoNsS74mbKmYW0HIyVJwAF7ryXvT3UrPEwOzanOcHPqSD2Zqm+EtNtqrBUDREGUAfnovz/QqLML4fvn5HwC4KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+neI5nFZK2gQAMsihHSWH8yTTxmMHy0dVAfuyzjxwsM=;
 b=YMlTGjo2ESGJQFyBAX/i6OdABnwUeovrIhy58m1POVPKNW9fgf7Skb4F7smvqNrMz/T5zQJC9nVqi3V7BIHjk9Mh0FcuOPYCpIu6N9XYkNMVZhpdqg7PqYKgWYExkspaxWXCh8v62lVtLjZ6J7G2bfWX1cD/imCsJ9QSEYK8g/y1jAOn+VkigEO31/PLgRMXVpneoiV+MZo0+ntM1v66Rg5rnCvT+SY/GQIE/BcmUlDCMjdCDijFiUYYzaswY4WG3xZBdJcxQ3M+v7x5ReygxKIQGaZ8C/HgDGyJf1IZp3RlIfmNQgtr7NsmRBaOVhp7BLZGiHTFKp6kxA5uludaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+neI5nFZK2gQAMsihHSWH8yTTxmMHy0dVAfuyzjxwsM=;
 b=ekrVm487t/sKSbo5O1GUdRPK8Aps4oBRD8aTrNnH+hT8Kcev4MdTStommM4szWAOTuqtk6j3OgxwDqRmlI8vPRnaFLUAqfv2zd2YrUMFxdP6PnQ3w8DDScb/lRQ9R4b/G4IdNMOIDvs5P5/F0C71Me0SQtmJ/CMjFfXkxVnZ4bsUokpFJ2zvMOZ5dOxiZzF0qGqtRuW84xeA7m/ULdgyb1qaBirBlPfi7xFWYCEg7BxEhAqWHXuBh0yrWEqfDDxgEldZfa9/agUnPysyXn79vyq9ENNDOa/2BXs7skOKiZLIURyV1iXzO1BJSRfuwkAmi5diC85rPIbnum3xaP1UjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3459.namprd12.prod.outlook.com (2603:10b6:408:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 20:49:36 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 20:49:36 +0000
Message-ID: <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
Date:   Mon, 31 Jan 2022 12:49:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
Content-Language: en-US
To:     Will McVicker <willmcvicker@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@android.com, Minchan Kim <minchan@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220131203504.3458775-1-willmcvicker@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220131203504.3458775-1-willmcvicker@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3ddc10-71d5-41ac-45c0-08d9e4fb315d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3459:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3459F54CD9F34D11CE229DDEA8259@BN8PR12MB3459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAkGNGszOmZSxXlLik2zFbmsWFHTd6GgTMn0LDM6YlpxIC7cjGA5LQVTRNIlIW65V34+MEWCJRwDrvdOIW95zqD+qGXkyjWxvzN+GWhImJQXR66mXONLKsrqhVteLRXmE/GENEj5al8adERqsao0OmlXvDSxXxU8lvbvwEaFi8kedwSwUzRtUmQ35ghwaEA70Qhyqt08gV030JikfO//xsdQGJb6Dc5AnzhcIFWPY/U+ohLzsJFruWh8ZQfNFkLkevfCm7Mk2DaHDij3IELnojE2vr0GWakcuk3sGppse/UnjHDHyrAnSSVekMTUpGZ3gpYgujSGAOqCE0mDHj67Wp0cWRXszX6wtxiAIA9UEvv9imZ5rnE1gZF0z6Ye+jb45fSLEdY21E3nWh0CI8SNQPa9mE2Wk4pwRGPYuaO5IWCYFCUIfsT4vvZF2UC1fR12tvaK/W8xTDDpUg65uIN2V6efjP/Se6O0caqPacqlfWLsGY1sti2b0X2kf5iL0lqGzN4rTBsYvwUujMYZXIaPZOoF42m0nNpEmiY++w43WKMfsiP7CA1SCn81rBfJf4+xHYOMt9mAy4IBURkxMmLTJiqpUY48DIPxn2kdK+x8G1GuYEarntqX4WRaTc38/1mDU7YfxZ5z+Xo80LDKPY4M87VeAuxXpw444yMv5Hb5hoQgWWGEoRrazgdNJBgc2mrXIWyHoDw9JSdGcTo/1G683BYtvsYC8DRkYxtU6p3ow8LfprR961W+9nUAX42bZzOH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(38100700002)(36756003)(86362001)(26005)(186003)(8936002)(508600001)(31696002)(8676002)(66946007)(83380400001)(66556008)(6512007)(53546011)(4326008)(6506007)(110136005)(31686004)(2906002)(6486002)(316002)(2616005)(5660300002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNlZ1JsbEtGa1gwamFBU3ovRGZZQ3MxZ2J2NE5ZcmlRVUk1WDFFS3FaU2Mw?=
 =?utf-8?B?R3FjOGQ3bThaY2thV2RmS0t4NFJ6aW1laVhqd3cxVUZrYWxuUVQxYzAxLzNt?=
 =?utf-8?B?TWxRZkd5Z1U2OFlkcFJ4a2RiY01MbkJQNXB3UDl5RmlTeFBoUkhJOGRuK056?=
 =?utf-8?B?d3NqUzJwMUFRb3FtOUVQY2l2RmE2T1dsMGRrOWhHZzRyQkZNMW9SNkpZaHZi?=
 =?utf-8?B?NUhvWk1Xdm5RWHcvN3Y5eWVSYWlTM3YyRXptV3NmeDRMQWhWQzBLY0NtbUZK?=
 =?utf-8?B?bE81dTFSeXNFS1pNRndiSldIc3FiUEN1T2RPYklRam93WjFSbG9Hc0xQSjZx?=
 =?utf-8?B?NzJici9tNTdCM2h5aGtJaUtVYkJGSGhqaDJKNE4wYXNWNkVWbkdQYldYL0Zt?=
 =?utf-8?B?Zlo0UUpUSllMd044QUZDMVBxTGlDRTR0NlkvcDVqZWkzbE4vakNzam9ZYWI3?=
 =?utf-8?B?NFFFaGxTb2ZVdjFtS2VNS3pKSlhxd3laYllHZ0lBdkxRMWdzSXdmR200N3hQ?=
 =?utf-8?B?N2pVczh4Y2xBZzBaUUUzbDArRjhrU253SmZyUXpRMng2Q3h3Y0FLOS9XZTRO?=
 =?utf-8?B?RzVBcUcvWTU3WGJ2WTlXNWdVY3BPMFRKNEF0a283ZU5HOGkwK2pGSXNxOVV4?=
 =?utf-8?B?ZEpRSSs1ZGVOM2dRMEZ6VnFJeDFnQjFvai9GOWVUbXcrQmNCemJQaFEwYlJR?=
 =?utf-8?B?R3VJYTcvNWVkaXRyVDEwMVZINDd6MlQ5L1VBdlRPRHY3QU1URTIvSTJrWEdM?=
 =?utf-8?B?b2V5YlovbDB4c0d0OVlOUGF1SE9vZnFDbkxFNHlYT2JrSXAxNFdYTllWRkFM?=
 =?utf-8?B?OEREMTFvVGNkdnU3bkdrR3J3Q050Sy91cEcvK1FqN3ZpNjE0SWE1dDB5SjRh?=
 =?utf-8?B?TFB4M1dnT2h3NjNkbmJhMkYzNzFZSlhBS205YVUvL0daZ2xSVGJicmdtUFRW?=
 =?utf-8?B?MGttL282NTVpSmhGUTN0OS9UM0lvMFU2NXd5anJ1NWxMUnRuNXRzMk96K1pz?=
 =?utf-8?B?eGVYRklaTE9mYWJVd1dsSzc1KzFCNDFNLzBteldVcnBPUGJQNVpZeHZ3MDhs?=
 =?utf-8?B?SnQ1a1RPK1J2Q1BDOXNwRVhmT1pjb2xYUCttZEJFTlFWK0xRSGdhMzB1Ryt5?=
 =?utf-8?B?UzNtZjdPQlAyQ0dEQ3cxd29ORWFsZ1R5aVA3clpUaHdRN0NRR1hOQmNtSGd6?=
 =?utf-8?B?emV4bUEyY091STNxVUVabVlMNitSbmtjQldpY3NCeXVUMkRDZGxFVXBtNHY5?=
 =?utf-8?B?bjJ0WmNwdU1wd0g0d3NqQmF3ay9YdDN6Z3hiZ3RsTXorSW11WjdXTUJlRDdm?=
 =?utf-8?B?MDJWSWoyeGJ3Sy9YNXp3cmk4SFNuMDhyV1VqZVordVpuYVJxeW5QTkVJQzd6?=
 =?utf-8?B?bzZ3VW40TE1PSHl0Nm0xR09wZ0l1cUdqQmlQVWpyTUV4WFBkWHkvZFRTeFcw?=
 =?utf-8?B?Qi8zZXVxOFVHUTRGTlppcVhZSmt1VVBjYXpTTkNEeStBb29qNEZVK2o1d21M?=
 =?utf-8?B?VW1vUDdyMEVDVTJUdW9KL3ppYjVURlJLMWtjYXJWOFhaR0tpenllWjZFeHQr?=
 =?utf-8?B?V0VmSnFPWW9WSlFSSStBYllTOURDcnNWVFZSbTZUKzFWcTNwSHczOS9pWnJM?=
 =?utf-8?B?SHZvd09RMytlams2WXJvZTI4eWcvbkNWNCtOYVU5K09WS3U1SHNnbm1UY0cv?=
 =?utf-8?B?aGFuVFhRdTVEQTBsUXVSakdXTm4xSzVrSHJIQkhWOVJjd3I4UHlER2ozTWx4?=
 =?utf-8?B?VU5oWGFzS0tMVWRxQ1E5UU5kTnZ5UW5oelNERENEa0FrNnVoWUhuWWZzZHpO?=
 =?utf-8?B?eFRNQ096WmpFbzZjR2xiOFB5eDlVaEZkb3VpblVtTnBxTUZtYmR4aCtHdkNR?=
 =?utf-8?B?ejlWcUY3bjRRODdZbU5qdU44a1ZjV1lxZE5HS09aRUNJRmJlNGcrRlZYVlN5?=
 =?utf-8?B?TDlRbGhXNmlIUkt0QmVjdDFxdENnVjZ5Ynp5QkVaVlg1SkhvV01icWQ0UFIx?=
 =?utf-8?B?L0RJNlkzRmxLRXBmV3NobkhTKzlzRTR5dW02V2tHU3M4cjNJVWlRS1NROFda?=
 =?utf-8?B?Q3BtRGhkb3JYaFpPUGlnMDdENGN3TGo1RllDeW55b3RsTlAwcENFRzBYWkdy?=
 =?utf-8?B?aXBVYzJUUUtlQS9zZTExblpKSlJsbCthYTNQc01YaTl4cGthS1BQNjMxT3pt?=
 =?utf-8?Q?GseIvAJQ+zxz/Oqg+hS5kgM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3ddc10-71d5-41ac-45c0-08d9e4fb315d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 20:49:36.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYlkz6+QDf6WamXOgPfRU2LPsSRetTbO/dRxMkjdgzatK67Re7u4QK3wbZWvl7vLg4mt1OVPlBasxX6gO6eitA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 12:35, Will McVicker wrote:
> This fixes commit 54d516b1d62f ("mm/gup: small refactoring: simplify
> try_grab_page()") which refactors try_grab_page() to call
> try_grab_compound_head() with refs=1. The refactor commit is causing
> pin_user_pages() to return -ENOMEM when we try to pin one user page that
> is migratable and not in the movable zone. Previously, try_grab_page()
> didn't check if the page was pinnable for FOLL_PIN. To match the same
> functionality, this fix adds the check `refs > 1 &&` to skip the call to
> is_pinnable_page().
>

That's a clear write-up of what you're seeing, what caused it, and how
you'd like to correct it. The previous code had a loophole, and you want
to keep that loophole. More below...

> This issue is reproducible with the Pixel 6 on the 5.15 LTS kernel. Here
> is the call stack to reproduce the -ENOMEM error:
...
> Fixes: 54d516b1d62f ("mm/gup: small refactoring: simplify try_grab_page()")
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Minchan Kim <minchan@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f0af462ac1e2..0509c49c46a3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -135,7 +135,7 @@ struct page *try_grab_compound_head(struct page *page,
>   		 * right zone, so fail and let the caller fall back to the slow
>   		 * path.
>   		 */
> -		if (unlikely((flags & FOLL_LONGTERM) &&
> +		if (refs > 1 && unlikely((flags & FOLL_LONGTERM) &&
>   			     !is_pinnable_page(page)))
>   			return NULL;
>   

...but are you really sure that this is the best way to "fix" the
problem? This trades correctness for "bug-for-bug compatibility" with
the previous code. It says, "it's OK to violate the pinnable and
longterm checks, as long as you do it one page at a time, rather than in
larger chunks.

Wouldn't it be better to try to fix up the calling code so that it's
not in violation of these zone rules?


thanks,
-- 
John Hubbard
NVIDIA
