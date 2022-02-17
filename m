Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8024B9678
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiBQDQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:16:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiBQDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:15:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CDC27AFD5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:15:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slksq7s/IxxmYq6ZOnsrrCWE3Tzba7XDuDVwN1jTb/bELkeucYjIIFROv4dd1l66i1TMrZnSur3oBheEImjY94p+v/s9hUeLigBhI8mgf667fUibPD57qNXe6sJhjTVlr7M4s5hps4rvZ0imtFZnbokQ1x8U2a8gsgwQ4mfDGXOkHbgLGoUOVNfUkUGKWSVTJ+uSdJdcX1vQQKxS2uCxQQwF9avkNKT/q5J4eeRZX66GDd5X/hxts5NhBnXF1IYCWU5AN5o2V8m4HYgrJ4mUu5RWBccLbuOUe77UbB6bHxpBL8haIXCsvG61JgY2e0jzxSZmkGMHrodJDPtpqrNacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xRFDth4Z4oKEWcGSIj6PwTIJhotbPBm1e9tE25nFLQ=;
 b=LsIzdTq1qBeZ0N74m5O3+U6n3gsdtkgL2v9mGUi8pbzfUAXVjNFZcmuLdeEci2bf9S0diXkceVVQzwivACxHdNuT/Fm6RwTX3vWL6jMSjdjDJH9FAJOPMSDQMOFDIXfoPqLpNIjPIyQ5I9MZ8glvAQVFW7afOsZ2y1nCXePDyY4DXaetOxm6xKiKejCgqx8AXxiGe1JrN7h5ayMncL1YuUtlNEuW5ID2dkr9YOqP4bid+bB68DwcW9C0n9BJPWYaEp+5f/j0u3Q9JniCqwKAGdAyfXNU76bcVm+bo46YhN7hGVPh6qWSr/0Pod5y04ojm1YxidLMhFmGxjNapf2hQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xRFDth4Z4oKEWcGSIj6PwTIJhotbPBm1e9tE25nFLQ=;
 b=S+jq2P/J+MN3AFHF/ogNw2ppH86QuCKiI9fegvjvj7Lq2qEIYQEidPbFqE0TVA6OgPU9mqZT376khG7AMEU5+g1RUW7f7fjoRJyIM/04YUFh3i+gVqgsF2WKiv0ws/GEHDd+wv00Gz77sIOcviKBArflDhBy4l+xER/6PugRWmGxYgPRikdKENDR0/h/mKzHf1CGkU080HsFPbkcXirurmaEJwnAvWyuLGkYEmiGTSCZZ7x+DqzgLcqF4qMDcWHFxumSI2BFFVu3ar3ZGd3jql9qdQ3FBgSdqSk0YU2TLAWGWr/UwTWzYd7fUXIIgbiUGo03eVV/DziO/TgONGCd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3746.namprd12.prod.outlook.com (2603:10b6:a03:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 03:15:34 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 03:15:34 +0000
Message-ID: <da98141f-c8d8-f796-d8ec-352d9b2abd6a@nvidia.com>
Date:   Wed, 16 Feb 2022 19:15:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/4] mm: Don't skip swap entry even if zap_details
 specified
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-2-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220216094810.60572-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14be4d20-4820-4bc4-6535-08d9f1c3c2d9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3746:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB374659256A629D309B533FA2A8369@BY5PR12MB3746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjQ6IPplm6iqFvP5XHFZrsn0ISIKGcICY+wsOftJ+JVglnF4++GKAfwlB5SsYg4nUQe504WkFbBdMSStcZTk+R5Z+KQ4eJXmopX1RL6gdUr356AEKcCn6RCtqANiU22dnnSMUO5XMlDOdDtvq+VwigGiDQdaSTFtAeuNnDZabl5P3r5EWB2Gu935LearxO43nKwjiSTrE+Iv5/+TYMMW7RDkBcLEIUUykNWzNzxgr/7206njJdKH8TYXqApnpjkb5e0rqobk/xVPZ10m8BR/+S16wPqAYCoKDaaQCIWwqyu4XmFSPLAPwSAjbcqS3t9ed/9s8f3EVRwRm/gTIh5CTfjx3RMjs8r9uxCb6rQBMeCP676vTRg0BrMtNGWKvrwsr9SkhFiskJqf+YskeUt0iOe5mNtk5VqdcvXMveyWi0viw/Jnz214VNN8qFdhtRjIvJoeJQ7K/jqYHd76+BfPhwW9C6X/8xyv3orMeZVhik3Ov4edmVHAXP39RCNzTMI1zXcoXADQyUhJyn/WR/XtYg0zhR+XvpBR0j0aO4DVKr5nQ3vR2qOiELZgqFFIfbgft0AplMK87rWdy1bJQERM33pXqOO0ly5JWcL4ImJ4QRq34TAYoellrz+HkWHDGLFUa0rr0M9WZswj9BB8pAr8SlJUNQ+WgJlyReNESjq8Ni1zl9wXbEjXouBzUsx835C/EGl6F6SpwRLtoqktn6QlTEPHjNBgJMXtmcfF0Eda6JSgNvNCzPK1Eyd6oDpX9S/l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(8936002)(7416002)(36756003)(31696002)(2906002)(53546011)(2616005)(26005)(186003)(6506007)(6666004)(6512007)(83380400001)(31686004)(6486002)(4326008)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(38100700002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBOYXhKUWkrdkdmOGVPSWVpVjB4Rko3Kzhxd0lSWElhUDlvM010TXdRTkNr?=
 =?utf-8?B?RWZud3VuWVV5UW81bFFEQkRjYXNXSXBUcE5OMkdSUGRsVER2dmRzVmZJMWY0?=
 =?utf-8?B?bE9IcGYwU2pvM3MxbElyRkRDRXFoa1IrWTdVanVyVEY2a3FXMTNkcDBZZU5P?=
 =?utf-8?B?ck10czNXOVhsOC9iVDk0UVlQb25jYzR2ZTFDMDVab2g2cnA5cjUvL3lDTkpK?=
 =?utf-8?B?TVB4YW9RMkkzN2xielM5Y1BZVHM5Qk1nYlZxV1VvSEZseFBadk10NDF6TFhp?=
 =?utf-8?B?TC8vTjVSNlZGVDlJVW5URGpOc0xHaU0vOUFQMUxXMWN3aU5hSHY5ZVdtbXA1?=
 =?utf-8?B?UTQvVEswMEo2WXIyajlnRlluNk9MZTJIZ2thSkRFVEltTHRSeCtncVFodWl1?=
 =?utf-8?B?c3pPanlRWWJNWExkUXNPUnNGYzh1TUFEVkwvVkN5TXVTYlhLK0c2MGJ5aTQr?=
 =?utf-8?B?TWEyK3VJZFRnV1NheHhyLzVGdElrUDBVbndaaUVBQU5FcUkwQm1lNHEvVG5p?=
 =?utf-8?B?N214bE9NR3NHMGZ6WWJ5Y3dFQVl4WElLRkx6TnJwOGZxQ1I4a2p6L0N2V1ND?=
 =?utf-8?B?ckZWTmo4NWZ6dldOZVJnOEdwY1ZrNERJV0lGaGtXM0pjN0pMYnVIcUR4WS9H?=
 =?utf-8?B?RHg1dmF4a1hBcndMR252dUdac250RERiNURQWnN4ZzdiVUhwdDkzbHA3WHdP?=
 =?utf-8?B?ZjhMMTJaWjljUmdINGNsZm1UUVFPVnhFVE9Tei9IZEkwRE9sczBhYVFWaGY2?=
 =?utf-8?B?VGplWmJrRTZNTGVsK3FQeEVuU1B4cExnR283VG1SQ3ZISmpONjlWeVNGSTNS?=
 =?utf-8?B?UlBJYW9sWHFaaFNpTUlEczBoVFJ0VWpvWWhLRjR2Z1Ezekh1aFpEVGMvRFZN?=
 =?utf-8?B?NG5iaWR0eDR4OHJjT2NSYXI3cExxMW9pb1pqUHNjUFVOWXBNaEJWUnhhUTdC?=
 =?utf-8?B?OG1YSjZSVERDb1owQ3RwSWlGUXNDeDM3VExTN2dWUCtwc3h1SmUxdktGOWtl?=
 =?utf-8?B?UUtucHdiUUJneGc3dTlGVWdXdlNIN2xpdVgyTzc1S1lpRS9EMXM0dVBjQlUv?=
 =?utf-8?B?Zmx2NnFuRG5XOC9qT1dxUnppblR2Y3BtR1REL3ZwZnpiRkRHZHRPaEM3c3N0?=
 =?utf-8?B?YnhkbGp5SlFrYkRUVkpnYkFhM1VaTzBjWjVYOFNPcS9XNk90bHlzZS84c3U5?=
 =?utf-8?B?eXBvcEIxYjdJa2VMdEJpNlAybkZodUJTZnV6TXhDWlJWdk1kbnA0NEc0eThh?=
 =?utf-8?B?NEFkZlpyM1FOak5VS2N1RW9kd0RSRDNGK0hZUWk3YXFUdXpVMGxMUEF0YjRQ?=
 =?utf-8?B?WVBwTEtoT3krRVFhOUNlTXpDZVB4YjFrZTZUaVQrTWhSajBUWE52V0NnQVU3?=
 =?utf-8?B?dlhZd1RQck1OQkNJT0thZFpxYThGVkFsWnJiSWZJUzlRY3IyS09lSDFoS2Iy?=
 =?utf-8?B?ams4YjNDQXhYL2xYMmdoUWplVnJqR2twaldhNnptdmtFQVlxWlFKNXZFT2s2?=
 =?utf-8?B?MCtUeEpmU0tIV3RKUHhTeDRBRHl2WldrTzVseXlndERNNHF1clBSWXhZV0o5?=
 =?utf-8?B?b2dRc0hHNUtUcGloQlRJb3NRSnl1RjFYMGg4ZktyYjY2Q0VRTGxMYUpwNTh2?=
 =?utf-8?B?VHNKV3cwWWd1WnhzcFBRSmh1ckhkODZUcjBOcU4xV1dmblhTdUdJTjI5Wjdv?=
 =?utf-8?B?UDZWWnNnQmQySGswV2xiRm1jaG1wN2M2MGdTeDhqdjNEU0taa2hXUU52azQz?=
 =?utf-8?B?YlMvQVBHU0ZUTysvbzNMc0lHMWtIVHhyRFhXT0kzcFgrSmIybnA3K3FtNTVW?=
 =?utf-8?B?OXp2TUwwTnBQSlhpY2grU29Ta0VhUU9CTWpLNmJRV1NUZnJGNXhKNVJFM3p5?=
 =?utf-8?B?T3ozbitKVU5TSnVJaktPS3VuNEltY1cyV090dmRtaDJ6dUNwNHpjSGQrR1Y2?=
 =?utf-8?B?TXc2cWFrZnFaWHB0ajdhQW9Qb0VKN1c5VmNWb3JwQmRKQlpJeUMrNlZRVnQz?=
 =?utf-8?B?RXlIY202RXhTTmJPSVFpRFEyMERMVVQ2TWZHcnluRlMrRVBNbFNQbmVpUk5H?=
 =?utf-8?B?Ni9XcThtODNMS0c5azEyZnBhQlp1NGVZV2o1S0RsRmxTZXFnNUdhaS9OSEt3?=
 =?utf-8?B?YUlTaSt5ZGtlS2s1dzI2MVJtS0ZHNHZRRm53amMrcWVXN2NSVzU0YVQ2Q0Vr?=
 =?utf-8?Q?Mjun1eVaaSADydVd4315DFQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14be4d20-4820-4bc4-6535-08d9f1c3c2d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 03:15:34.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM+oBRN9m0+MAbbDkiDpHqaURNw8i7aF+yJNqKLJN6vvxvlCiuKklrrYZYp+JN3Jn8AkzOQXwLOjBwk3h5gEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3746
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 1:48 AM, Peter Xu wrote:
> The "details" pointer shouldn't be the token to decide whether we should skip
> swap entries.  For example, when the user specified details->zap_mapping==NULL,
> it means the user wants to zap all the pages (including COWed pages), then we
> need to look into swap entries because there can be private COWed pages that
> was swapped out.

Hi Peter,

The changes look good, just some minor readability suggestions below:

(btw, hch is going to ask you to reflow all of the commit descriptions
to 72 cols, so you might as well do it in advance. :)

> 
> Skipping some swap entries when details is non-NULL may lead to wrongly leaving
> some of the swap entries while we should have zapped them.
> 
> A reproducer of the problem:
> 
> ===8<===
>         #define _GNU_SOURCE         /* See feature_test_macros(7) */
>         #include <stdio.h>
>         #include <assert.h>
>         #include <unistd.h>
>         #include <sys/mman.h>
>         #include <sys/types.h>
> 
>         int page_size;
>         int shmem_fd;
>         char *buffer;
> 
>         void main(void)
>         {
>                 int ret;
>                 char val;
> 
>                 page_size = getpagesize();
>                 shmem_fd = memfd_create("test", 0);
>                 assert(shmem_fd >= 0);
> 
>                 ret = ftruncate(shmem_fd, page_size * 2);
>                 assert(ret == 0);
> 
>                 buffer = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
>                                 MAP_PRIVATE, shmem_fd, 0);
>                 assert(buffer != MAP_FAILED);
> 
>                 /* Write private page, swap it out */
>                 buffer[page_size] = 1;
>                 madvise(buffer, page_size * 2, MADV_PAGEOUT);
> 
>                 /* This should drop private buffer[page_size] already */
>                 ret = ftruncate(shmem_fd, page_size);
>                 assert(ret == 0);
>                 /* Recover the size */
>                 ret = ftruncate(shmem_fd, page_size * 2);
>                 assert(ret == 0);
> 
>                 /* Re-read the data, it should be all zero */
>                 val = buffer[page_size];
>                 if (val == 0)
>                         printf("Good\n");
>                 else
>                         printf("BUG\n");
>         }
> ===8<===
> 
> We don't need to touch up the pmd path, because pmd never had a issue with swap
> entries.  For example, shmem pmd migration will always be split into pte level,
> and same to swapping on anonymous.
> 
> Add another helper should_zap_cows() so that we can also check whether we
> should zap private mappings when there's no page pointer specified.
> 
> This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> should do the same check upon migration entry, hwpoison entry and genuine swap
> entries too.  To be explicit, we should still remember to keep the private
> entries if even_cows==false, and always zap them when even_cows==true.
> 
> The issue seems to exist starting from the initial commit of git.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..4bfeaca7cbc7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1313,6 +1313,17 @@ struct zap_details {
>  	struct folio *single_folio;	/* Locked folio to be unmapped */
>  };
>  
> +/* Whether we should zap all COWed (private) pages too */
> +static inline bool should_zap_cows(struct zap_details *details)
> +{
> +	/* By default, zap all pages */
> +	if (!details)
> +		return true;
> +
> +	/* Or, we zap COWed pages only if the caller wants to */
> +	return !details->zap_mapping;
> +}
> +
>  /*
>   * We set details->zap_mapping when we want to unmap shared but keep private
>   * pages. Return true if skip zapping this page, false otherwise.
> @@ -1320,11 +1331,15 @@ struct zap_details {
>  static inline bool
>  zap_skip_check_mapping(struct zap_details *details, struct page *page)
>  {
> -	if (!details || !page)
> +	/* If we can make a decision without *page.. */
> +	if (should_zap_cows(details))
>  		return false;
>  
> -	return details->zap_mapping &&
> -		(details->zap_mapping != page_rmapping(page));
> +	/* E.g. zero page */

It's a bit confusing to see a comment that "this could be the zero page", if 
the value is NULL. Maybe, "the caller passes NULL for the case of a zero 
page", or something along those lines? 


> +	if (!page)
> +		return false;
> +
> +	return details->zap_mapping != page_rmapping(page);
>  }
>  
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> @@ -1405,17 +1420,29 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			continue;
>  		}
>  
> -		/* If details->check_mapping, we leave swap entries. */
> -		if (unlikely(details))
> -			continue;
> -
> -		if (!non_swap_entry(entry))
> +		if (!non_swap_entry(entry)) {
> +			/*
> +			 * If this is a genuine swap entry, then it must be an
> +			 * private anon page.  If the caller wants to skip
> +			 * COWed pages, ignore it.
> +			 */

How about this instead:

			/* Genuine swap entry, and therefore a private anon page. */

> +			if (!should_zap_cows(details))
> +				continue;
>  			rss[MM_SWAPENTS]--;
> -		else if (is_migration_entry(entry)) {

Can we put a newline here, and before each "else" block? Because now it
is getting very dense, and the visual separation really helps.

> +		} else if (is_migration_entry(entry)) {
>  			struct page *page;
>  
>  			page = pfn_swap_entry_to_page(entry);
> +			if (zap_skip_check_mapping(details, page))
> +				continue;
>  			rss[mm_counter(page)]--;

Newline here.

> +		} else if (is_hwpoison_entry(entry)) {
> +			/* If the caller wants to skip COWed pages, ignore it */

Likewise, I'd prefer we delete that comment, because it exactly matches 
what the following line of code says.

> +			if (!should_zap_cows(details))
> +				continue;

And newline here too.

> +		} else {
> +			/* We should have covered all the swap entry types */
> +			WARN_ON_ONCE(1);
>  		}
>  		if (unlikely(!free_swap_and_cache(entry)))
>  			print_bad_pte(vma, addr, ptent, NULL);

Those are all just nits, and as I mentioned, the actual changes look good
to me, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
