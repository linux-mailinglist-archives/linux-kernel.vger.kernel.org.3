Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5B471F36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 02:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhLMB4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 20:56:42 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:58881
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230368AbhLMB4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 20:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWFLipO+5SmPoAyHphvQc/IiBm41OZUdS5PSX/a+ssDMMGhlr5nba2oKdyX62clK734SEPA7BcWsTM5Fwu0J6FOQh38hYGuDFKfCW5dHDlXLNur4+I8tB/Q8kBW2SVaShf7a1iHIee6n3CqdVFmWnm8MvxItRMvY7XaCuFAe2xHYwhvAlIc3LO5o60RnQvD30KhFGZC9iQmXHcDCo0PQVBD2iih8GdzwaXHEN9GdyWqAjwX45NR1I+kCMxahO49fLOON1vitiTwSv9WxYIktLai7f5O0mrhpv6SS/W/x6lIwdei7Wt4mteKV41dvea7c4s0zBjmGGVlF8y5b6rv+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQqIA401AFzXdV6meYc1BkSJca7+VvXYVN+tx1GvfP0=;
 b=H+pBbzhK4f6GBOfwn/6DVkCpSPfrW8xJWcqrpzv/a3G9+jR036/u2mwFq3HGbvqQtoLz3pjgBPBjV2ZcCTLiWVZBKR/nWqMyNFPRKNPI+rUxyyxl+FYbPvNUdxg1zUskFpUvC9SdwmnCToJ1Zqh5ZRz6rKiHE40gMLcB8wNm9BTYSXzVFnWNmYcUdtsQsfqbfZWcChptIZmK5FPxMYJdycraiZsZctuJ1Zqifg6YeLFQeLdNZtfGLQYCCxuoQ+N6NQKKpLajU+o1phJ6AOnLAAVkJOxDgj5RkLx1j/GdNS+9N++Ie0+uZkWb4l1gL+epVx1H1obxFP2rKrtq6f8lKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQqIA401AFzXdV6meYc1BkSJca7+VvXYVN+tx1GvfP0=;
 b=ZEZqxaHqgH3BJ2vkJ2EbaTkEKpmCzyRWvMFsmSK5bDI5M3zx0NRNTWKYRN99+wc3W/h1YMo3RD2StwvZn9zi2MENT0pVIqvuGGbY2EYQ0ZVEnCD3qzP6YalxPDHIa2kpt2cPXCmqa9hwIReRTRiB0YwW8hid2nsiDYofsTUlVlDi6NhR9KQJQ1HeeZaDOtuOpXawVCgciRtj9frJffSEatftcciNbcLkxRH5qDdZ8exY39sILjOXd/MvGYY1rr3rl7F24W9Cx8JKDVN1XB3DUp9kBYYfBPvKvU7soN71O0g6NogH1FJKGPK9p8H+Q/8TnTxjMZclAzKRj+5PbPHm0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Mon, 13 Dec
 2021 01:56:38 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 01:56:38 +0000
Message-ID: <78b01f68-ffe7-378b-fcaf-0bd3140da088@nvidia.com>
Date:   Sun, 12 Dec 2021 17:56:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC] mm: introduce page pinner
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
References: <20211206184730.858850-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20211206184730.858850-1-minchan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50aa6239-af4f-451f-eb09-08d9bddbcc93
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB43063EC1462883F1DBFA8CA3A8749@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2jHnQpkHOvBGgyvCHA3B9gBpCoKCLPODTK2FA+rtRTl29HqusJAcyN4euwz7fUJj9GwxPasxeQMO7szOs3KXafn6+cWMCLKFK8LKc559fCbkfjWSTixgCemcGC4Vet58bOZTAn1T0+0nzz1BNEfZqqIHfwSf4WR4YDs+ZbSijkwCY1ACqCdvp0u9VTS7wwUBH5ka1IXyyb6qFIsrQ2hpbamAXpWbY8ov1qKXJtcvDs3QVJPNwZREwTQlqy+xspmVdarC1UgYFqdXL6YoEy7bdQwlQBjdax1v6umHG4hYXhaJUb4Hbxxo2kEFSW8Fo/4vpKSkOGeeF31RwO2rDCFDM8DJlgimTUt7ZQpdqKTryLpk/VxJhQlaJ1jY8JgdUWPgayHmWctGPK0Ze+h/x/+knFS7xM8MuaTU4TYig39jTIYxCq6D+C6uvC04hHqSp03Fl5fAPD5UkZj3tZvQ/qiE40F8Nrda1NZVZ5NGdTX7zNfBBWlkA8pTe4UvIUQaiet2pdP+h28jHjinBmDeMl1mXp9+Wa6iTPiVOPdIJ958ql0V63POKoLIS94dKUxKIJIDvfiI65V8wz6cNae6YnVWGRiYlSRzoZdfZWsHZcwtT/JPAzGe8so69R9rxejXgHCsR/WZ7mD88K8ncIG1EvL5brVUB4HIo/tLb1DLht9R92/v3AQ4as3Is8NDSIpRL8+kdBIgZzl4lFqfsXDzk26bo5ZzYBupClf2wLam64ui0+eckl+MvBadaAUujKyE6nf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6506007)(53546011)(30864003)(36756003)(66476007)(86362001)(6666004)(26005)(6486002)(508600001)(4326008)(38100700002)(66946007)(8936002)(31686004)(54906003)(110136005)(6512007)(2906002)(2616005)(5660300002)(31696002)(83380400001)(316002)(186003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGV1N3BmdEczUXNhd2pOSTBTaDFKSTkraDkrTCs5RDkzVzBhUG9OM08wTlRs?=
 =?utf-8?B?Nmp6ZE9KR0YwY3lpby8yWHB4bkRQcFdIMlJlS0lBWXlVZUQ1aVJieGp2U2U1?=
 =?utf-8?B?RHBsV2w4cjEybkhINkRtOU1KRGJDV0w5RzNtWEVPUFRuVWhCaS9SYWNnOCsx?=
 =?utf-8?B?dGdlSm1iRzkxSDBhNkxHN25RM0dGbGQ4YW9OZWp1T1RwNEd3d2ZwaWVzYk1M?=
 =?utf-8?B?UkpTYmFnQzFzeExON1ZWa0c2UjZ0eHk5U0k4eEUzckd6dkVFTVd0WDFyRFZz?=
 =?utf-8?B?THgweHYvYXFnWE1qNjl6SkNOR044bDIxeTE3T1BFRGdNV2IyWTlPRkRoS3Vt?=
 =?utf-8?B?SUtzWmdyMFcxM2x1THRQWktEVkFDSk5Kb2lqYkowQVorZGI2TTVTakhtT0hV?=
 =?utf-8?B?Mm8zZWxzUlp5MDZodjlkREpjelNZRmZBNXRzYTJDeHoxRlNGSjEraTh6Y1Zi?=
 =?utf-8?B?ZU8rT2diVWE2bno3RzRPQzV5U0tMa1NrdjFDc0RwdHNZVDFIeUwwVUt0YVRt?=
 =?utf-8?B?elhtNE5kSVBMN0d2L1BnbldPamJzWGlkR2w1Q2F3UmE2azhqVW1QbkxNdGVP?=
 =?utf-8?B?WmNxVjFuWXAxKzZPUGQrR0lpMmdadjNtLzhXNW9PTFp0U085RzZuRE1TNUVV?=
 =?utf-8?B?Tzdwc3BKVEx0cEpHY2JNQSs1VDZBN2VQVFhDWVJPVVVaT3pISU42UldrdnJi?=
 =?utf-8?B?K1FLbGJXSlFVdFNna1lPZ1V6Nk9CaC8xRnkrUTNsQjcyTGliYmdrc1V5cDNi?=
 =?utf-8?B?SFhaRXVUTUY1K0ZiR3VNNEllQWMwaDROVzJnRlpHeE1WelJIcUdsY1lRWHBv?=
 =?utf-8?B?YkpCYWYyMlNpeFBQL2ltUXFuL0ZjZVRDQ3RPZUR1QzE3UUJrcE9kZUtjQlM1?=
 =?utf-8?B?WXl2QXVKU0dSSnNoZHo2ZkFsWWkvc2lDeThZMmdzdjBuU3JET3QyeVk0eWd1?=
 =?utf-8?B?Z2hNUEpTRGlmR09ZK1o1bTl5cHNZK0RwNTZQKysvNkQrelhaM1kxSEw1MVRj?=
 =?utf-8?B?czY0WGFjZUVndllyM1JuODAvcHVTa1YxdHkvb0hRNnZINU9EUjVvanBqY2Qy?=
 =?utf-8?B?WHBNcHJjYUlVdzdEQnZadmhqb3pkdzVyTlFSUFlQSGJvM1Mwa0FVWWhvVnJa?=
 =?utf-8?B?VUpUd2djYXhUcXd6dTdmK2lXSWxqOXBVU3dxbllnN0xNYnE2NnVkMktERWlC?=
 =?utf-8?B?TGx4YlNTWHVDYlRJVjZwb2NETDk0SlU3bTAwalJ3NXA3bHZib2huUzFDKzEy?=
 =?utf-8?B?cHhLVk5YQmpvOUVpYjNMRWtiVndrOUh0QjZaR3VOczBmRFd2REVGaE5TdEJM?=
 =?utf-8?B?UmU5cDhob0lVOUFEZjVXbGhUU09GbzhqSjJGSG11RnQrdlppSTFNTjRPSjRy?=
 =?utf-8?B?elNZbElNUzVRSFNCM0huQWwreWhaNFI2STRqeEkwWWI1VnBib1creXJuRUE0?=
 =?utf-8?B?NS93c2NUYUNVSXJyaUQ4Q2NCc3FpMkUyWCt4TlUrLytjTWMvZXFnWWYzWGpv?=
 =?utf-8?B?NXBIbnhSYTBnVEx1QnJHV1VtdEkwRzRpeXY4Y09EL1RVV2d4VlVSK2dqelZN?=
 =?utf-8?B?U3VHdEN2Y2RSZUdQVW11UzRER2pZS3hadXZia25IOXl5eU9WbGo5VW9UVVBp?=
 =?utf-8?B?U1lDZitXcWFPbjNnTWRlV2RVazZXOHp3ODRoZEM3dzNVaVN5SzUvUUgxVXZu?=
 =?utf-8?B?REJaajZTUVRodkFENk9nTFMzQzlTSkF5ZnVpNEliL3laQm9jV3JUWGhBbWhT?=
 =?utf-8?B?S1VBZURXWDU1L1A1dUN3VG1XMDVkZWgxTzJZdXU0cDVvaEdkOHJuZGVlTW92?=
 =?utf-8?B?TVZBaUNtZFA0c0NjWUV2VmpFUFk1bFMybE51MUo0SVFlcG9kVytwclRYZHhP?=
 =?utf-8?B?djFHSk1sM20yVnh3ZSt1S2ZiS29wYXplUlh5dWwvRlh1cDZRb3gvYjRRMWFB?=
 =?utf-8?B?cTBUVmhBYmdjT3JPd0tKTytjN0M3MFdleTlmYkpvTXNJeTdwREU4d1l0OGx1?=
 =?utf-8?B?czFJbm9OeGFtVENmdGJsUm03cXY2Wi91QXBTOHh2YVY1bTN3UHRjU1pvYTFo?=
 =?utf-8?B?NFF1SDU5Z2lXSTlvOHJHVWc4QUpqbGpmT0poMnExczNrRXZiYjRoaUQxL3k5?=
 =?utf-8?B?VjRoZEQzY012Q0xkWVIwRTl2b3E4enRDN0g0dTE0QXNGZTNHK0tNTXY0YlRs?=
 =?utf-8?Q?5AkCBLZn7jY2hpedN/37WiA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aa6239-af4f-451f-eb09-08d9bddbcc93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 01:56:38.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U5aAx/wffRpLAucqP3Ux+DKLXpS36vGmS5dCnVDKD/POUG23j0/FgnTRlRLKzaQKaqu+42gcgkAcLAsl2cKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 10:47, Minchan Kim wrote:
> The contiguous memory allocation fails if one of the pages in
> requested range has unexpected elevated reference count since
> VM couldn't migrate the page out. It's very common pattern for
> CMA allocation failure. The temporal elevated page refcount
> could happen from various places and it's really hard to chase
> who held the temporal page refcount at that time, which is the
> vital information to debug the allocation failure.
> 
> This patch introduces page pinner to keep track of Page Pinner
> who caused the CMA allocation failure. How page pinner work is
> once VM found the non-migrated page after trying migration
> during contiguos allocation, it marks the page and every page-put
> operation on the page since then will have event trace. Since
> page-put is always with page-get, the page-put event trace helps
> to deduce where the pair page-get originated from.
> 
> The reason why the feature tracks page-put instead of page-get
> indirectly is that since VM couldn't expect when page migration
> fails, it should keep track of every page-get for migratable page
> to dump information at failure. Considering backtrace as vitial
> information as well as page's get/put is one of hottest path,
> it's too heavy approach. Thus, to minimize runtime overhead,
> this feature adds a new PAGE_EXT_PINNER flag under PAGE_EXT
> debugging option to indicate migration-failed page and only
> tracks every page-put operation for the page since the failure.

Hi Minchan,

This looks very useful, so I have a bunch of hopefully very
easy-to-deal-with naming and documentation comments that are intended to
tighten it up and get it ready for merging.

Starting with the subject line and commit description: rather than
nitpick on these, I've studied the patch and written up a proposed
replacement for the subject line and the lines above this comment.
Please see if you like it:


mm: introduce page pin reporter

A Contiguous Memory Allocator (CMA) allocation can fail if any page
within the requested range has an elevated refcount (a pinned page).

Debugging such failures is difficult, because the struct pages only show
a combined refcount, and do not show the callstacks or backtraces of the
code that acquired each refcount. So the source of the page pins remains
a mystery, at the time of CMA failure.

In order to solve this without adding too much overhead, just do nothing
most of the time, which is pretty low overhead. :) However, once a CMA
failure occurs, then mark the page (this requires a pointer's worth of
space in struct page, but it uses page extensions to get that), and
start tracing the subsequent put_page() calls. As the program finishes
up, each page pin will be undone, and traced with a backtrace. The
programmer reads the trace output and sees the list of all page pinning
code paths.

This will consume an additional 8 bytes per 4KB page, or an additional
0.2% of RAM. In addition to the storage space, it will have some
performance cost, due to increasing the size of struct page so that it
is greater than the cacheline size (or multiples thereof) of popular
(x86, ...) CPUs.


> 
> usage:
> 
> trace_dir="/sys/kernel/tracing"
> echo 1 > $trace_dir/events/page_pinner/enable
> echo 1 > $trace_dir/options/stacktrace
> ..
> run workload
> ..
> ..
> 
> cat $trace_dir/trace
> 
>             <...>-498     [006] .... 33306.301621: page_pinner_failure: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=1 mapcount=0 mapping=00000000aec7812a mt=5
>             <...>-498     [006] .... 33306.301625: <stack trace>
>   => __page_pinner_failure
>   => test_pages_isolated
>   => alloc_contig_range
>   => cma_alloc
>   => cma_heap_allocate
>   => dma_heap_ioctl
>   => __arm64_sys_ioctl
>   => el0_svc_common
>   => do_el0_svc
>   => el0_svc
>   => el0_sync_handler
>   => el0_sync
>             <...>-24965   [001] .... 33306.392836: page_pinner_put: pfn=0x9f0bb0 flags=uptodate|lru|swapbacked count=0 mapcount=0 mapping=00000000aec7812a mt=5
>             <...>-24965   [001] .... 33306.392846: <stack trace>
>   => __page_pinner_put
>   => release_pages
>   => free_pages_and_swap_cache
>   => tlb_flush_mmu_free
>   => tlb_flush_mmu
>   => zap_pte_range
>   => unmap_page_range
>   => unmap_vmas
>   => exit_mmap
>   => __mmput
>   => mmput
>   => exit_mm
>   => do_exit
>   => do_group_exit
>   => get_signal
>   => do_signal
>   => do_notify_resume
>   => work_pending
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> The PagePinner named after PageOwner since I wanted to keep track of
> page refcount holder. Feel free to suggest better names.


I understand how you arrived at the name, and it makes sense from that
perspective. However, from an "I just read this code" perspective, it
sounds like:

a) This is a tool to pin pages, and

b) It has a key API call to help report when it *fails* to pin pages.

...both of which are completely wrong statements, of course. :)

So, I'd recommend renaming:

     page_pinner --> page_pin_owner (and all variations of the name)

     page_pinner_failure --> report_page_pinners


> Actually, I had alloc_contig_failure tracker as a candidate.
> 
>   include/linux/mm.h                 |  7 ++-
>   include/linux/page_ext.h           |  3 +
>   include/linux/page_pinner.h        | 47 ++++++++++++++++
>   include/trace/events/page_pinner.h | 60 ++++++++++++++++++++
>   mm/Kconfig.debug                   | 13 +++++
>   mm/Makefile                        |  1 +
>   mm/page_alloc.c                    |  3 +
>   mm/page_ext.c                      |  4 ++
>   mm/page_isolation.c                |  3 +
>   mm/page_pinner.c                   | 90 ++++++++++++++++++++++++++++++
>   10 files changed, 230 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/page_pinner.h
>   create mode 100644 include/trace/events/page_pinner.h
>   create mode 100644 mm/page_pinner.c
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..a640cae593f9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -26,6 +26,7 @@
>   #include <linux/err.h>
>   #include <linux/page-flags.h>
>   #include <linux/page_ref.h>
> +#include <linux/page_pinner.h>
>   #include <linux/memremap.h>
>   #include <linux/overflow.h>
>   #include <linux/sizes.h>
> @@ -744,8 +745,12 @@ struct inode;
>    */
>   static inline int put_page_testzero(struct page *page)
>   {
> +	int ret;
> +
>   	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> -	return page_ref_dec_and_test(page);
> +	ret = page_ref_dec_and_test(page);
> +	page_pinner_put(page);
> +	return ret;
>   }
>   
>   /*
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1e087f..561d8458dc5a 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -23,6 +23,9 @@ enum page_ext_flags {
>   	PAGE_EXT_YOUNG,
>   	PAGE_EXT_IDLE,
>   #endif
> +#if defined(CONFIG_PAGE_PINNER)
> +	PAGE_EXT_PINNER,
> +#endif
>   };
>   
>   /*
> diff --git a/include/linux/page_pinner.h b/include/linux/page_pinner.h
> new file mode 100644
> index 000000000000..3f93a753b8e0
> --- /dev/null
> +++ b/include/linux/page_pinner.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_PAGE_PINNER_H
> +#define __LINUX_PAGE_PINNER_H
> +
> +#include <linux/jump_label.h>
> +
> +#ifdef CONFIG_PAGE_PINNER
> +extern struct static_key_false page_pinner_inited;
> +extern struct page_ext_operations page_pinner_ops;
> +
> +void __page_pinner_failure(struct page *page);
> +void __page_pinner_put(struct page *page);
> +void __reset_page_pinner(struct page *page, unsigned int order);
> +
> +static inline void reset_page_pinner(struct page *page, unsigned int order)
> +{
> +	if (static_branch_unlikely(&page_pinner_inited))
> +		__reset_page_pinner(page, order);
> +}
> +
> +static inline void page_pinner_failure(struct page *page)
> +{
> +	if (!static_branch_unlikely(&page_pinner_inited))
> +		return;
> +
> +	__page_pinner_failure(page);
> +}
> +
> +static inline void page_pinner_put(struct page *page)
> +{
> +	if (!static_branch_unlikely(&page_pinner_inited))
> +		return;
> +
> +	__page_pinner_put(page);
> +}
> +#else
> +static inline void reset_page_pinner(struct page *page, unsigned int order)
> +{
> +}
> +static inline void page_pinner_failure(struct page *page)
> +{
> +}
> +static inline void page_pinner_put(struct page *page)
> +{
> +}
> +#endif /* CONFIG_PAGE_PINNER */
> +#endif /* __LINUX_PAGE_PINNER_H */
> diff --git a/include/trace/events/page_pinner.h b/include/trace/events/page_pinner.h
> new file mode 100644
> index 000000000000..69ccd5c30f66
> --- /dev/null
> +++ b/include/trace/events/page_pinner.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM page_pinner
> +
> +#if !defined(_TRACE_PAGE_PINNER_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PAGE_PINNER_H
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +#include <trace/events/mmflags.h>
> +
> +DECLARE_EVENT_CLASS(page_pinner_template,
> +
> +	TP_PROTO(struct page *page),
> +
> +	TP_ARGS(page),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, pfn)
> +		__field(unsigned long, flags)
> +		__field(int, count)
> +		__field(int, mapcount)
> +		__field(void *, mapping)
> +		__field(int, mt)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pfn = page_to_pfn(page);
> +		__entry->flags = page->flags;
> +		__entry->count = page_ref_count(page);
> +		__entry->mapcount = page_mapcount(page);
> +		__entry->mapping = page->mapping;
> +		__entry->mt = get_pageblock_migratetype(page);
> +	),
> +
> +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
> +		__entry->pfn,
> +		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> +		__entry->count,
> +		__entry->mapcount, __entry->mapping, __entry->mt)
> +);
> +
> +DEFINE_EVENT(page_pinner_template, page_pinner_failure,
> +
> +	TP_PROTO(struct page *page),
> +
> +	TP_ARGS(page)
> +);
> +
> +DEFINE_EVENT(page_pinner_template, page_pinner_put,
> +
> +	TP_PROTO(struct page *page),
> +
> +	TP_ARGS(page)
> +);
> +
> +#endif /* _TRACE_PAGE_PINNER_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 1e73717802f8..0ad4a3b8f4eb 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -62,6 +62,19 @@ config PAGE_OWNER
>   
>   	  If unsure, say N.
>   
> +config PAGE_PINNER
> +	bool "Track page pinner"
> +	select PAGE_EXTENSION
> +	depends on DEBUG_KERNEL && TRACEPOINTS
> +	help
> +	  This keeps track of what call chain is the pinner of a page, may
> +	  help to find contiguos page allocation failure. Even if you include
> +	  this feature in your build, it is disabled by default. You should
> +	  pass "page_pinner=on" to boot parameter in order to enable it. Eats
> +	  a fair amount of memory if enabled.


We can do a *lot* better in documenting this, than "a fair bit of
memory". How about something more like this (borrowing from the updated
commit description):

   This keeps track of what call chain is the pinner of a page. That may
   help to debug Contiguous Memory Allocator (CMA) allocation failures.
   Even if you include this feature in your build, it is disabled by
   default. In order to enable the feature, you must pass
   "page_pinner=on" as a boot parameter.

   When enabled, this will consume an additional 8 bytes per 4KB page, or
   an additional 0.2% of RAM. In addition to the storage space, it will
   have some performance cost, due to increasing the size of struct page
   so that it is greater than the cacheline size (or multiples thereof)
   of popular (x86, ...) CPUs.


thanks,
-- 
John Hubbard
NVIDIA
