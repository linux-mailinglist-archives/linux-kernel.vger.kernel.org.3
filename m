Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB64AB445
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiBGFtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiBGFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:19:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CBFC043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 21:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWE3xQSU+vBkOTrPbttIBxJP0EhQ6wo8VtKHK9KnMkpY2VXYGQ67N4jcRCW82pdFk3aVAkE2D70KTZYA3xcJvEwk7IMmsKlvF0JeTp9Iftw9TIQJulOUAHeUN9xIvRXXUxQOmB5z0sBeei45BdTyouXXK72dB4YrD5mR0T7Ikk6Lwt5SHA8awEhGhj5UPgD1jwxZPM+iun4aAl0eEFjTJKxaR5gsjP9/iqE5LZnsYiXGt0D/oA8iXwUb7V3IHyATQ/FtkV/uUB2L8AlDoZnkSqHcTswCFgQ1T8iuUYlAQpi0YzgymrXXEbbby11EhHpC+pzMxhBE5ndEyL8cG+ZBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRAqy5KRkobPsuaO4NHRU4kgqT2nR38a1IyzJq1qOg0=;
 b=CpeZKHW7fy7/dpDRGGxeb52WfDNij4RV/m1OiId+igxRAuKjrHjZc3F8/qY9Qdlxzl6WWSb78+IUZn9c6F0DtWK8lNvoqM+bKW7jx0rRNO69xOhcIK2J5A6JAo8Gq5ufVoM/xAr132wKNToLvG9LXJvVOLtX1aLJ0SJHoGEIJ3D7HVZvh9M/65PWRzyLwqs36PmPDBJqNiHRrTPrq8a+gziGv20dImrINgc5/mushiWHcpZtvVmvxk9b46AEyZ0tCLo3h37uEFrOngq+qRMMqKd5ZXsAIrxR4bpH54s8AgPmquDbKIqexhy9ylNxyBOTeYypj9LC3CxkEZEJf7eC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRAqy5KRkobPsuaO4NHRU4kgqT2nR38a1IyzJq1qOg0=;
 b=uTvdtT8YGgMmQHu6S9ml7VSoER/J40XuJh/mvO1Y2+FAp4PGvOwJ42uLpwe1wM3Q92vL8fT76qx3y2hRReCTb/HMGM5bQhm6JIUHt+FAQwI+MR7etcFvzV9DHiRSXf/Q8Buzy90OWJiWG5viFTjuQdnsx0/O3SzFtT54maaTCm+yElYrU+6Q9RBL325eCKH++g61P+pzivNgOTvmZKQADbjTG5Tc6CmTyLz5DizKqkUBD8ccE+lNze3tL1l20M5tdVBpAs/BGCcWQqq6GD2IjZ55rsb3YiqgIeO8yvGCadsh2HL0OWcVfpNezAENGY3rMXcH/xbJTZZvZMGNsXfZEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 05:19:37 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 05:19:37 +0000
Message-ID: <9a5e9fac-7597-80b6-1cc8-9818b8ff73cd@nvidia.com>
Date:   Sun, 6 Feb 2022 21:19:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/5] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-2-jhubbard@nvidia.com> <YfzU4Yh/1Oh7Dsw0@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfzU4Yh/1Oh7Dsw0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f168f77-ad5d-4683-9375-08d9e9f96f49
X-MS-TrafficTypeDiagnostic: MW4PR12MB5601:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5601706181635E071ED598FDA82C9@MW4PR12MB5601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWqn9MLwMJ5sbmXP9ofrmQYsIBRNz4QCArNnx9msU0wsx0jGxl6gCqVApvt1P6MD5diqtxWosVJ+m8bqssSFgUag77FPLtVVGzZU/850LqYiN0ee3X20+tmpHhtcfhR9egcgUtluHEqozviZ5G0gEyk115upZPFce45Ww64MScyBPq3JXvDtpPk1IAsR6NyUl0p0YaPiYGflzeuiX5PUIMAhflp7nK+UWXMv3E6SBrVwVne5TjwWbPneIJy5LjFYk0ZCYDss4C17SfZMMQ+/TjeCPviVgSUwQnynbfA2wJ3bgKOH3aXahX/ZK2FluW1d92cuas3u7zikrOmdHrkfv3QKmLPyhkbdAeYGZdi7wrBc68A/CqqItYhrUynStSgdn0VnGIHGGWrn3AzEX0F0PJKZ0fmtfjF3/afPnt6RhODD8weWHuor4e1ShZIjCyya2W9pjH9UKgvD0HAB13uQcTNjARFWWHD0d//6rWAkIiLqDevhCzub8tw/l7jdoo23cUsrMPYhqsvhATBD8Uu/bu5EbRJmJIKmD+TeCWgeDT10PdpXphm4JM7N/VM+/ykHJkpitsRtlbbdmpwUZpRZ/VIO159FoNQ1ybnW9dLhgLSiBhYekVXM7GTxiDXO8LClYlblJ+J9Km6ac+UclyybdnHQupTzK6+bzj0uiq96CqujZ8pEPII4NEt0xnnXae0HAIjcZ69kX8hDEaFmKy3X2Ov4sh2u1FDgtgBEgvsa8zYUQU6LILlO/uW02/wXrFA9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6512007)(2906002)(6506007)(53546011)(2616005)(31686004)(36756003)(31696002)(6486002)(508600001)(86362001)(38100700002)(83380400001)(26005)(7416002)(4326008)(8676002)(4744005)(316002)(54906003)(5660300002)(186003)(66556008)(66946007)(6916009)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlM4MjErSjM5TmpYOWZ0YzF1RjNSNk5pa0pCbndxOVhoU2VPVkMvTTNhbzEy?=
 =?utf-8?B?OXNSN3BZZVREM1NkY3VoY3h5L2pjL09vMFdjQTJCamVrYXNFWnRrNHZsUUNX?=
 =?utf-8?B?QUVDUElqOEpVQmRpMEJLQzlPbTQwMWlacXBZeGl6V09BbTdzZC9RTFdpNGxz?=
 =?utf-8?B?a2NwNXdZN2Y1L2JWMVA0cmV2MFd4ZTNTNlg3Z2ozNmwvNnk1dFRRWTcxV2VG?=
 =?utf-8?B?TUx3VnY1dDNCc3pFYllMRmhMa1JUQUdLVnRKZmpnRWlPWHFxdndBd2dSdG1o?=
 =?utf-8?B?bUF1cmNwNGUzZm85NjdvOTlQSmxPSjQyYnRxV1pYeTRjUDlHeWhQNDhtcmRD?=
 =?utf-8?B?ZENVMmEzazErblZsZjhxM0hmejJPcmNPZ003cE9vcWorY0Z5YXIzaWNpMkpw?=
 =?utf-8?B?NG5rZ0t6SDk4RXY5dE90WktHOEZQRTlBTkpFU3hoSmZtVzJHc2VieTNaOVpa?=
 =?utf-8?B?TG1LQVN1U01qdm4yNFFVSUhmM2FMVDNyMmp1U2FTU0FINWhscGpSNndTa05o?=
 =?utf-8?B?dHVteEU0VHUzUmlqSWFZY0NTeWtkZDRFcHAyVVhUSGhFcVR5bjRpMU5pelhu?=
 =?utf-8?B?Qzg3ZUd1d2E1dWlQZUhReDlkOTFZaWdZbjdZVlpCN2hZUHVYSHJIcElWVVQ0?=
 =?utf-8?B?cU1veE1ZM0hyZlRwSTlQNE56VDlXVUJSSFF5ejlpRHlxejdCTS9SRUM2M2d3?=
 =?utf-8?B?MFlnUGh4NVJuSGJrNGN5c01kVFZnbDdOWjFGeGs2UGNOdkx3OVpvbVlFTTQz?=
 =?utf-8?B?MC9vMEpwbXVFdUFoVU5VbzVxWC9xcE5PNkZTUEJJQUlFMnA5NmMxQ2pETTd2?=
 =?utf-8?B?d21wYldpUUk1Vi9ib29CSFFkT2Q1ZE5rRG1kS0RpWGlVcGRad1NjdG9BRS9p?=
 =?utf-8?B?SzVzYlZtQ0FoZEhVZXhrY2ZJY0ZVeG5mQjlyenoyMGh5dFFrK3lLMDdha1l0?=
 =?utf-8?B?SkVxUzRIMDVpUTRoMzNTUERQdVdGTExPTDJCc1RMaXk0YkV3N1VIZ1dBclcv?=
 =?utf-8?B?SUpDWE1wTVJRYTdFeXAyekRJQlhDWnFNbHNBNnN6dHg2SWxNOERWU1JjdjNu?=
 =?utf-8?B?TVpOYTRWUUg1RUVTYjhXVzdRZDlVSWtWYmN6SUxqeEptNkVMSC91V3h4NkY4?=
 =?utf-8?B?dEFzWVV4N2lnTnR4dlUram85bG4zclhjdzJ3YTJaeTM1UzZzWDFVZHVTTWM1?=
 =?utf-8?B?eXVyeTU5eHYxb2tBY1k2enNwYmoyaG4reFpyRmhuZVlIMTNROC9TS25naWlK?=
 =?utf-8?B?YUM2MlZWVzFGOVdlWjhGTWljVlF2OU41UC9xUXpYeW1sT241bUVJcFlGc0Yw?=
 =?utf-8?B?UnFYWHUxeGEyTzJ3eFVSbVpKSmxJRVQrWUs3RVlKTjdFUnVrTjk1L0dyd1NM?=
 =?utf-8?B?NlBzUFJXMDB5d1JXbjJpck9DWnFuY1Job3NSeWVHVVZTTlpyWDNpSWIvYjBF?=
 =?utf-8?B?ZExJN3ByVXgvcUNaSjhVTG9VZ3ljT3JjVlEwblZoSXFuOHVhNXhGL3FVNVNq?=
 =?utf-8?B?N2FhbXBtcDlLcW5rc2k4TlJCMGEzMXZiSG43SUc2S0c1NkVMczFHVGdVUU1V?=
 =?utf-8?B?Y1U2VDRjdHRZNDhCSVdrM2tuUFJNdy9sS3IvSmVRS0xiRFRRNjRPemFWYmhO?=
 =?utf-8?B?aE1GM3VCb3VPYkZ0V1dXMjU5eng3TUpzeEMvdklwdFYvWWlubHgwK3BCV3dq?=
 =?utf-8?B?d081L3EwOVRjSnc2czFqcmZLN3VsMkJlVGJ5WnRRbVM1R0p4aWRyL1dEZi9B?=
 =?utf-8?B?cXZzeHFMYndIQnIwdXVlRUVOQ3cyR3VqM0JqQ3JhZUxFa3RyZVozejZhdlBW?=
 =?utf-8?B?aDVIWW1xV01acGh6Z0lnZHJVbmFGNTBGYUtYSUthY0V4VnVXdVFhaktmRHRy?=
 =?utf-8?B?M01QRWI1a2tuWXVjWkp0RHZKV2RsMDNvbzUrc2F4VUJ1cDZpelU1T1NsSCs4?=
 =?utf-8?B?clNpRmI1TVNCMHFlOE9rVlFUdDdUS0FLWnh3WEFZOFNqcktOaS9BdXEzOXA1?=
 =?utf-8?B?VWxxMnVuWFk3bGFqUWVDY1R0b1hnU2t3REpRT3ZzOXBSS1JPa0xYUkIzaTNW?=
 =?utf-8?B?WXovOGZjU21yR1FYQ1ROMHZ1MGFOZ0EvL2MxblMrQnM3MFBjclNLbmx6NnRG?=
 =?utf-8?B?b1pCdTJFWDF0aHFWRWU3dEp1MXdYNS9sRkExREZyT2xDUkp5Zy96ajU0dFRW?=
 =?utf-8?Q?ZOr79H601wh3/UmaZzOZy/E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f168f77-ad5d-4683-9375-08d9e9f96f49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 05:19:37.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2Fh6YQs2RxKdT6zigpr9ksxE6oYYjogi139Ilf7nFczeocq3GtXKiNwc8bmh66nKBFMO4YxttuCXhbp2jfp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 23:25, Christoph Hellwig wrote:
> On Thu, Feb 03, 2022 at 06:00:06PM -0800, John Hubbard wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> Alex reported invalid page pointer returned with pin_user_pages_remote() from
>> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
>> pinning with struct vfio_batch").
> 
> This commit message uses overly long lines all over.

I'll reflow it to 72 columns and post a v5 with the full set of
reviewed-by tags.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I appreciate the reviews, from you and everyone, as always.


thanks,
-- 
John Hubbard
NVIDIA
