Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6754B1628
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiBJTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:20:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbiBJTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA08B60
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0o21pjWoeyjqU8d+SdDR4ErOKgZ+rejsTeZ7tshQTTcK7Z4eFddrN07jP43xP4JN67cPAp5wTWCVee+9rN7Sl4u4c+72eZ0JbIVsjrevnP2AMRkPO/Q0HC8X0IcjeFlFgNv/vEPEMLQGe4lb3951uNTOwNIjMY3F0hBvc8k2tJIYyPHvUe+31CyXOJYf4DVp+LY5g3NJfCQM/NCBcrPpiNpcZRnOVMaZGKlKVqclK2aaPbVhsR0HGRO/n4A5bKIaERehJjrn1psdaolVswmtQlfqPJIY8xtQirgrupEVAqsS3AIFzLouIdgoIzxsdvpn/khFFsrFQg6RLA84h/vEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDZKyUpg+NQFPLVeIVRHxQAS1RCtaGjxr/Z4O8BkGtQ=;
 b=UD3RrjdBSlW4sm6SG53jIU9ojExq9L7MqCf3MtlHpF/15zqg5waY6QQyWsK7g3nKFlgbdOKDL12hm27aTyxNH/luHf5jsC8wKeb0Brsp4HRdjFw0KGEERhzqNFmhieqp9+tdZFpcsbcBcXdqzxpuw4Fp/YvRl4CKgHJuWsDKTM+SaeJl/sGI5Oosip8lN+pxJWUSu3Y0djAprsKbbhAki6HGUvAHKHrY16jt5hRPS4dweB2il6JGMnqJ/9t7VlUf9OdJ/htZHRl3ZBRHMpHQnJfCTgKUNHwKWwj+IbIVJ02p3rL5NxluI3bTnfRb2s0w24qtB+/l+3s/fxqoD1oUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDZKyUpg+NQFPLVeIVRHxQAS1RCtaGjxr/Z4O8BkGtQ=;
 b=Mc8WOzZ9TGw4lxnl1GVA/G7Er3qE3aBHQb5c5yWHau3hwxLK9Z36GROnRXT5tUF7yknmtpyxEfDcMPTlFL+hNZ0ICBYRkrkFQbUiyxraIAEXqgzz+kKuDpVFjFnZYqf25B1qYawPaSs/HOz6Kjz3LtNVl0HXzwQeRSMci656i7zjfrFeFA4wU/c7yxqMAvCn5VQWZiJCqf8icOTr81HC169r4llspOGfdGiGx4YUHf/KQTNRMXwCjQGsKUDfhG9v4++qI2/ZUWjImvVtsZ1SOOeLKZuh4OLCkyqKvX1VOOPvcrz5TvfqiPfLJsRpPEx2treN6N/QU3egx0a2vZsdAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 19:20:32 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 19:20:32 +0000
Message-ID: <7b19b521-01cf-fafb-e616-21deced2cd5b@nvidia.com>
Date:   Thu, 10 Feb 2022 11:20:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: pin_user_pages supports NULL pages arguments?
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <YgVkxwYtLov6Z5WZ@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YgVkxwYtLov6Z5WZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e15092c3-4ae6-4bc9-5b97-08d9ecca680d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3738321FE7AF77D579A28EBBA82F9@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soOuUI/Z3/dDORBKm9XZ8967av+VERbjoaZGd3qKSUq9KcqgkvyXfukedNl1qmeomsDOgydH7Jf/6DrI1s6kV7sWD5bb82MJpvLMXmK1PvAcx/KmhUxgnUEYlmBTMBd8b1hG82A6sqg4OukXI/esxG85q9AjQHwMt7STbxRs1SeD51uMmUGV2wQgnhPjnuFmxScZxH1KmEdxi23F1fHlNn1iN+4eXueQGwPZkTDn2bZZGCa2/7rJA6IZRrc/HAQUF6AsyeQXlsL+g3R32KGaOvBCt/qv/tzFPsZxPcX4NeVVzmxnxmvGB8T7JvJbrCbEo4/m8LvrT1VSf5lUuX0ReFoybvYwGfsMUcUQqPDQaYMJCtneFwWUG5K6dwVvwAzIpPwsid1eIRaQNw5U0dqW4Zn1FnGCFiEEhwAqfFrYR4uLTnW5HRjmE2Q0hgPjEWwK+HMtj0H49mHvLV2YOpwkkXKFAKgBStyAZ1bHHziU1J8npZ6dPCXN1alaQc80r1Vk2wssUd8iWRP4PMyxCvV1H2BcFyEoWHPntttk6TJfIMITwwUiD2839dM5OEJMLocFryLP6XK//NWKtzzvI6m2vKqvKk9/Oy1cGnS/qWCLcn28ERpN9KvkPLd+d+O0Xk6gWRd/+pZSqdWE278fMf8VBFU3R8NHaf1oHYIUh2ivXim3o6goKXWw3MtjoKPBg4myEWTft0xy46cw4K9fYFXefEtHqiiVnByUEjq92PtDO6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(2906002)(316002)(86362001)(54906003)(186003)(66946007)(53546011)(31696002)(83380400001)(6512007)(26005)(6506007)(31686004)(4326008)(6486002)(4744005)(38100700002)(2616005)(8676002)(36756003)(66556008)(66476007)(508600001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTZiSDR1b1JBQ1drKzNvc1hLaFRTa1RXakVxQWNNWitMOWhMN1MvZENFVmZ4?=
 =?utf-8?B?Qld6V2tZaHViNXEzZEdnUlFETnJIcFZueVpPSFpNNmg4QVQrdnZ5UmFPWEwy?=
 =?utf-8?B?dGVMdEJzd2pKVk5IM3lzRzlKYmQ3bENWd0tSVXhqSWFVVXA5WCswRHJyN0ZJ?=
 =?utf-8?B?dWxjNW5YZEJpb2NENHZXWFlaU1ZIQWN2R2ZaMUhINVRIS2xkOVQvczdCdDNH?=
 =?utf-8?B?RFZub3ZEOUplbUcvUWxMSkFNWnQrVDJrZTZZN25lSFJJWFFHQ1NKcDBJRTV1?=
 =?utf-8?B?NW5RUEM1cnlrZUgzMEIySndEeWsvMmxVTXJVSzcvRm81SUZsV1p5bjNtTGtj?=
 =?utf-8?B?YVI2UlQxUVFWTXY1YktoTG9sZ0tFY09SaDNwck0xK2dVMnRscW0rU20zZklB?=
 =?utf-8?B?LzBCMVo4SVk0V29FMVc1WHRDQWlXK0xnQm9YMXp0Q1pyYlg1NmF2UGdYbjRm?=
 =?utf-8?B?VWJ6MFRKN3AxYjc5YkRYalc0Um9LcDVoc2llMW9KT0NBN1BRd2dGMFRrTW1Q?=
 =?utf-8?B?NlJtTVltYzlubTBldEJQWitiNVNpeCsvWFAyM285bnJEb2tSaDV1U3ZqQ0l2?=
 =?utf-8?B?bTZMOEhNV05CdU9vbVFUSUU5TVIrdzBvTUllZnZjT0RKWTZ4YkNCc1gvdUpD?=
 =?utf-8?B?TGFQZnNJZnBuUXZRSFZURUJwNnJ1Z2lEZ0NnSHV3NitSelYvYzBuVTdTQTI5?=
 =?utf-8?B?NDRPQ0lYNVk3cGR5eFBWdjBPdzRLdjI0aGxQcysrNm4wSndtMDlPQ2RCbHox?=
 =?utf-8?B?ZURPYWJMc3NaR3dha1VrNm1Sc0s5YmZBazUzOUovNmxnM05UMk5hUFJBVlQ0?=
 =?utf-8?B?Uy9MVHYxUXU1SFJBdklUZmJkL2hYU1JCMUhKNGZpNk1xdTUvWXdaYWg4Ly9r?=
 =?utf-8?B?YjJSVlBwaHJFVGRGM0g3S3dOSzM4TDhBME1FaXZDeEsrMEJ2R1daZnAraitY?=
 =?utf-8?B?eUZHTHo0UnRLNG0rdGt4MnJyc1BBblZIajEvSFFhaDB1MzlwYkVOcXM3L01v?=
 =?utf-8?B?K25STXV2QXExS0k0MFE3YTFNOXdta1JJRGZkdEVMb09BOFNiUGw3QVRweVVI?=
 =?utf-8?B?Y0lZYUl0ckJRaGpHekt0dFdLNVYrNFc2cEhBcm1LUnlieFZFcERKZjQ3bFdn?=
 =?utf-8?B?cU9wYjI3R0ExODQvTkIrczNtNjF3TDhESUU1UmRUNTh6UDlaY0w4ejZKSkVt?=
 =?utf-8?B?YUpqa2R0aEVKYnBQTzIvOXRjZUdPUzJCUnlyNURsMS9leHVjZ21DRXdRcGdx?=
 =?utf-8?B?aXVid09SOUpvaWRRZ3psc2dTZU9KY3k3OFNCM0NWTFhSMnlaTXRseUUwNzVz?=
 =?utf-8?B?aUIwR0plV3U1YzdadlpVWUdtZzNnakF0MUZFZVZ2V1hwKzdZaDlTZVBKc3FG?=
 =?utf-8?B?dmtLanJGY2ttUjZmTWJXUFB5TlRTREJmbkVQc2x4QldtSWcrWVNaR1ZEYmpB?=
 =?utf-8?B?QW0vTk42Z25Rc2tGOHNzQmJ1VGJ3K00zK3FidGo5cHU2V0MzSlZTSUQwY0lU?=
 =?utf-8?B?M2M2SXA1bnVzL1NOMFhrdkVkaldPRFp2S0RvUGpTNUJEQjZTNDVMeWpMRDR2?=
 =?utf-8?B?cnNMQ3RCZk1GY2tsRXJQVHJ1Y3RnK3BCUkowNzNGUjJQcVVXdEtPSlBlNGdF?=
 =?utf-8?B?M0JWeXZFTEVRTnpvOEh1TnlQWi9WUWhwcEdhcmpUVk1JYTByQ3FOUzFaRlh3?=
 =?utf-8?B?N3J0VENGc2lXb2tEYmFNRjdTcjU5Zzgyc1JLT1p1WXVEUVEwZm1CdlNjV0JQ?=
 =?utf-8?B?YzQvWTYxTm5FcjFqbDBhdWx5MUZ4NXhPd0p0eTFjOXBLNG9qWmR0aEV6RjVK?=
 =?utf-8?B?YTNqai94WDRVazJqc1NlTWRySytSSW1HZHdkRVp6cFlFanVZOTV0c0IzYVkv?=
 =?utf-8?B?WTc1YjBOQWR2TWNFeFpmUm1mZ2E2RGRjUmlWT21odjhPRnZjaXd4b3hjVG1m?=
 =?utf-8?B?N2tnN2VhWGxnaXM0ampIL3VYNTVpazYxNm82UmV2aWo2eTVWUGdWTncxbm4y?=
 =?utf-8?B?L0dySFBoSFBDR3YxQWQzc01RbWVWYlFQdEI1UlMzVmp5Y3ZwVGY3dm9RdDRX?=
 =?utf-8?B?SmxPUDVNMzAzR0h1cmg0dHZISWlxYk5WRkxXZlg2eHlHSWhjK1F1NDk1d0Rk?=
 =?utf-8?B?Rk9DRU91Q2RxZlBWNUhxM0E0VjVSNExyZjhaemo5VE1VOUp2ZmhOc2JJNDl1?=
 =?utf-8?Q?tpVCi5TNclidvdX7S6x5jU0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15092c3-4ae6-4bc9-5b97-08d9ecca680d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:20:32.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+YG0hm3UEx7rrUikV6Y05OsuQsgoD34h+A5ok6I9dq2ofEs7AVq6r6mGzIPbXRohejXXw65gsAIlRrStRPJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 11:17, Minchan Kim wrote:
>   * pin_user_pages() - pin user pages in memory for use by other devices
>   < snip >
>   * @pages:      array that receives pointers to the pages pinned.
>   *              Should be at least nr_pages long. Or NULL, if caller
>   *              only intends to ensure the pages are faulted in.
> 
> pin_user_pages(,, pages = NULL, );
>    gup_flags |= FOLL_PIN
>    __get_user_pages_locked
>      __get_user_pages
>        ..
>        VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));

Only FOLL_GET or FOLL_PIN are supposed to fill in the **pages array. So
if a caller passes a null **pages arg, then that caller must not also
set FOLL_GET or FOLL_PIN. That's what the VM_BUG_ON() is expressing.

Perhaps that should be part of the documentation. It sort of is already,
for get_user_pages*().

thanks,
-- 
John Hubbard
NVIDIA
