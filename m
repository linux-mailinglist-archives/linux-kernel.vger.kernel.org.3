Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B30524110
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349366AbiEKXdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiEKXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:33:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8661281
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezZb+uQdLcWXgPbhO43Mn1CLIRlqdPN469TZ6maA6PiIY+SRLMrohXCffhYaoolDpEloydmLA926uL+jnE4bhjLZKN1KDqPX+1Nmovg2arDnRKPb+QGG3Jyvz+vm+3D8tkO2ipW6tC9U+vwCXx8yW3spIsKMIU8w6X2/jfvhac788/kz40NPv8L8h1WOiLuKqVukUBA9r1YtjeDBeBGN06lJZiaaEqMu/JA3yRZdCScpk4QPDMQmXQiTZECjZPqIjkCWgX3F42GR6IJ7vAyTZ3TIk+0IIixbjIJ3kIfj9+Q2u4vv5lIYGVa598/7HWB/2V5IiAkwPghAvjU1T4nYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk2I89NyOAB1FUCjOU6HgHme1+Ih+LO1RUjITLyaNC0=;
 b=ZdW+bz7xi8vvBhskQZNSR8sJzPYu74dFWT+LWlsrrpIavleFRpMRupqvDoyW8CaMGxuJYljIWPnjaouiobIi3TU/N2IHr6w4pxRnD0CiRUDfAGflGjdg2n3JOfzRVVhsUg7cgTTehFVpEwPbM7mfM/Wnb+DRAPUfOx+vlbNIP3qQ167uDlQTw1qdgvQMODVPjNr1Ml/6jkamnfRim66InGesbvmL5hQaVwBSGUKqDldRM5B9Ze1M5EqXeBdZNXlbBo3lpzhD46+FvtbeslcUnid9ybD/q3RYa3DSDJj1FinhsUCHHEbPAF0MxU+qlX4DAREIKGNWoI49hNa2UE88GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk2I89NyOAB1FUCjOU6HgHme1+Ih+LO1RUjITLyaNC0=;
 b=lDtCXMl05rPPHuXTHG9e5X3Z/1HsaHCrGmoDcPVE15tB+/qkLury7JtcL5drdPqN2uWlucoM/GL3L5cGel97JwiKfUD/rfY2VsRuFhGe8RvEEBk6OMVXErR5B1EqjG92csM9A/3OecY5yVDixF6VeR1pp2DmJcW8RlgPpD4oiLADuBsvE/1plUnLGFNAyVnbJ06NuqkKHU3GU0Ypk6cuzf6+ilyh0y7xV/x1DFIIWKOPQSrlhV5TbT+qEakjH6H475prXwvuvvg2FqC9ulWEE6W8Pm53ykR4pU3uHElBl8IS96X5Bupd+P/slnVk2SdLFHAyxpDnHD5ierTTHDN82A==
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 23:33:10 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::cb) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 23:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 23:33:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 23:33:09 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 16:33:08 -0700
Message-ID: <1219032d-5ee2-bec5-3975-ae1abcc3bfa0@nvidia.com>
Date:   Wed, 11 May 2022 16:33:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <YnxDhdb4YCo19Qx0@google.com> <YnxGgo9iCsnOOBHE@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YnxGgo9iCsnOOBHE@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7959b07f-eb09-466d-10be-08da33a69be2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB11535D9877339A5A8F48C38CA8C89@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8iM9jMoD7riQMS/GJQTdt7X2GALpTT9bNplPWauSiLNqAzO/7/GWf5bJfEB5ezK5SzhBckt8FJCh10fvgY3R9OnuRRYIUKfDvSpGP+0YJah7VvcBHr+4xNPnLU8fct2kcNiuMPrUui/xNID1v1HDyUmN7Es/SQrcB8smz0bznwtCPaKVbkwQsXXUq64fn2HLtkxNGmrNUFQ+1u9IbVC5hcUtIavybgHPZd9VnzE8yN6qncX7LsrsSW4is4WoMSZkBqyC4tEuDGLTQ6YR9Zv/huYuKoqQ/q6jhXHcg3Zzw68lQXVEt+U2BJcWQn0i28Ub9oB5x9/gYOhIfbSp/TJs3maj63vnWezbAmDzkEBmPxVbfDz8Zi/0my0k0n11TU8ESJN1nKR/kNjpcj5c29v3A8djKoT+8AGGAL4rTN+eiisbnIvjUp0pIBC0MGfkScNRYrUyLS9wCePsYCsOlvyJB+CjwaFlDOl+dYDmzmtqTX6amc1MNg59ZRYa7iQkBB1PJ5AO4z18JHO0nhWX17lGlZixeXTxqtIzHssFjXVKMtzaoHwdB9zEahM5X2zaWo8pVI9wNvPby+kCWjgnyNGSLdiDBQdginLtHSdUlm/VAsRL4E1YElPowXjYYMWSjjJ15V8MfEx7eq3o5eHZj0IhHrwxrAFpCZsutwZzlUN/NZaPcHPVjYbnNceXipdYo2PTxVgnpmyxvIRXoEsHqn79/yS6SQ8yun5yHULpsFYdGCBzGeztHQE6c/hAhjkO8SZ
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(26005)(6666004)(53546011)(508600001)(70586007)(40460700003)(54906003)(6916009)(5660300002)(2906002)(31696002)(16576012)(86362001)(316002)(82310400005)(83380400001)(36860700001)(186003)(47076005)(426003)(336012)(16526019)(81166007)(356005)(31686004)(70206006)(8936002)(4326008)(8676002)(36756003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 23:33:09.8124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7959b07f-eb09-466d-10be-08da33a69be2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 16:28, Minchan Kim wrote:
> This is delta to confirm before posting next revision.
> 
> Are you okay with this one?

Yes, just maybe delete the comment:

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cbf79eb790e0..7b2df6780552 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1626,14 +1626,14 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>   static inline bool is_pinnable_page(struct page *page)
>   {
>   #ifdef CONFIG_CMA
> +       int mt = get_pageblock_migratetype(page);
> +
>          /*
> -        * use volatile to use local variable mt instead of
> -        * refetching mt value.
> +        * "&" operation would prevent compiler split up
> +        * get_pageblock_migratetype two times for each
> +        * condition check: refetching mt value two times.
>           */

If you wanted a useful comment here, I think a description of
what is running at the same time would be good. But otherwise,
I'd just delete the entire comment, because a micro-comment
about "&" is not really worth the vertical space here IMHO.

> -       int __mt = get_pageblock_migratetype(page);
> -       int mt = __READ_ONCE(__mt);
> -
> -       if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> +       if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
>                  return false;
>   #endif
> 

Anyway, I'm comfortable with this now:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
