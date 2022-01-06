Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40654486D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiAFW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:27:54 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:38007
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244638AbiAFW1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:27:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB5waXAZc24uPS9DGpsw+Pn71iEZ6QWu6WP9e4isVZgB2IlHhj1jPPGTuq7fzpNdmrZfVRDyFrer51+pn4o13Hv5Dk4w4gdWypv1Z7JWzJ0CAs1k6Ij0daILuBZKF4agV1gGO7YBk80VwO5eJU7g4fNl9PecuIW/6A0eZzzJkyBJbS5eReULZJyiNNRyMhxSC8G+iBIkn/2iJ571PbcwM8sGj7DGgzig/TLC8X3Z5GoBHeJboVWO/FNgCcqhzYZQ9dvvlehj15p/QxSYpzzbVkrD7qhobDUP3UJ0srF1VVqmak61hpLI0xyMmT/p+inodfUxoqL7Vcd4T6pBPPNVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwJ+qbOZ83b48HxRhjG+GisiZfhEKIkxriQpO6QsWtc=;
 b=b/KMEZq2bHvIyYfSouh7pA3NxK0Zorr6TKCPXwRN5L6IedDlH8NQxD6UeuhjI1I7LJw/ssAx7d/OrYN3kA+SmGhu4X1AiiyFVKj2slV2wXDEyig/1r6fg8xntoqESJ6tYM4JtP8Ku7WpXpaYffQ5xk4vXpjMS8W5p2JRxd5vhqLK5y/m/Lrr/g3l/BnHs3n8lyqD096oWwxGWklMZgtCweK17Rd8WirGdkjlz8m4oMLW3Sp7pbE1jhBdeJlLfVZNJSuSHVIWr+Y/tNtx9OcSpLUHNSOY7Ape9A5Sq0+OplVtw07X6j/2W+t0zobuOWp3ZVMilfkoTu7VQJavL76PXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwJ+qbOZ83b48HxRhjG+GisiZfhEKIkxriQpO6QsWtc=;
 b=X1zB8ED1v+RGeBAKYgEE+kk0YLl+cCq0YdqI6EwruQ+MvcS9Xzowr/lOE5Gyzl7EsO3SpbVYG9NVpEEL16DCEPNAi3hvknJr5xgPX4OsJ0Gd9in1hg9yoEMramjIkXyx22IDfCOh9xjdU7sUZfE9tu4xbgRbrh2z2BCb2lIfc5+Hw88RrGp3Sri4oGHqDolHJSSqXFkc06auHb9wxZK+rp6oX6ikDaVsmp54WeetDsHQMyZBuwbC+S0fRxV0tOM6Y66Lopz0WSOrAkLfAgr6CecMLtCOUIoCfgDKTSXMd6DSs0gtfgY6GuUF9ekhDjrLXeiUPbAgEHDuymBHj1hhDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3649.namprd12.prod.outlook.com (2603:10b6:a03:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 22:27:50 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4844.015; Thu, 6 Jan 2022
 22:27:50 +0000
Message-ID: <978452be-6377-69e3-4720-520410d32b31@nvidia.com>
Date:   Thu, 6 Jan 2022 14:27:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC v2] mm: introduce page pin owner
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com
References: <20211228175904.3739751-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20211228175904.3739751-1-minchan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5391d5c0-6a31-4715-4f97-08d9d163c5e7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3649:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3649D4601AB7221F1A546A04A84C9@BY5PR12MB3649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pseytxqUzkoEBGPbDXoXqCrgslBAT4FaCeVM0FwImsz4ojA6FVBhCQhjNPKKj2X9wqT9wwZGy+LBUsxxPc6M5n6SQ+6EImwZIwEw7SACVjsqASpo4GBGmhPbRA7vwAbMecnS3nydY1ToHPQckBb2ZBZ1lxRcNeSdwSLNYS5a7qZ2u+CJFTyRPA6weQykIw+UvYJq03KGm7v0hCYghyygMKvMnwAfkBD6/QcFLC2Ett0dFjp8cHnHRdVWH6afcyrY10TFecnD/ujHid0QRlcVTQ0p0mjIl1vaLdymCz0HDvCJx5+iu+dgBrmcZIpJ1sLoNFoxn8ffxvZ0fXHXsOn0oRGXNNP28EkKWR+y966gem0OhMFVRyN/tsAqh6RGl3nrso7PJU5bRWfhlLx/uLYBaNGU8/uBTWV4hEK59zlI8JqvSwN0ovPNncfe3XDuNXMeptkf3R1TZA1oRGwodzIp9s3PGOxv6zFIURiNrjobUVFzpfmif9F2ZvmGDdAcYVSEyqKgbUgsqLlhMgObjSVlKcvtJDw5Eu7G7fofAGgKNUOpzE1XSZlR9YgPVlypBZYMhR/+7LwMlaC9DuUle4X8PCAEmEUY3ViH4dgY8DmmZQ9RsEVfaNdI1q0DDkAJCQ+AaUiQROXL5meaYVMeKrWb5+AGSWkeiEazHfKFK256fvVEXbs4Nm/ig6GDfkK4k4mKeXL8K/s/kbTcZbOxZhX/7aewSHzBPd6S9qomoF/AGratYCs81NHxZoU0esz+5tT6w/QnGCoJJLP0dfofaH1xZKFVt6aA+sJyDBfjMSzd15Z8d+8mggwv5xRSs8A3QuwX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8676002)(508600001)(66946007)(66556008)(53546011)(4326008)(6506007)(6486002)(110136005)(26005)(2616005)(30864003)(66476007)(6512007)(8936002)(38100700002)(316002)(36756003)(2906002)(186003)(5660300002)(86362001)(31686004)(966005)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGl5R0dFbDRiNER5MzdSUS90ZmtxK0tvOFlrY2Q2UHQ3ZEVGbXZ1S0J2RU5L?=
 =?utf-8?B?aG1sbWtMQjFCZmV5YzRTKzBEODh3b2R4bzRZd0pzQTRCMlh2bUtGUCs3VGJk?=
 =?utf-8?B?WVpubjJGOWgzYUR0RnI4NlAreEZEQ0JralZHemVqVnhKdFJTQk5yUm1la3VC?=
 =?utf-8?B?UmkwVzVSQmZCcC9FYy9BU2xEQytSbEowV1MvY0I0MjdadHc4cjZTTmdOSHdu?=
 =?utf-8?B?RWMwU09QT09iYmxCUzJLRlJyTUY2ODFuaTFEbmc5SFJwVi91QUNRSThwbWg0?=
 =?utf-8?B?dDFIeTlVMi9jdEhhUGk4MGhpcVhDeVR4Um1GQ3VWWE1abk41eS9oaEJtaHZ4?=
 =?utf-8?B?ZmdCNkI0UFY4SnRMS0szRE9YWnROMTBrL1J1UEZqb050QVY2Q1hmM2dMaDBL?=
 =?utf-8?B?d1dDY0wzQ281UVQrcW5MU00vTlg1cEE3MnljY3hsR05HeVFZMlBTK2tGN1py?=
 =?utf-8?B?aXlvWFVKYjdmK2FSRHZkMjhNQWJDK2FhVGRqVnZ4NUxyRW1vZXNmai9PQk96?=
 =?utf-8?B?RmtzTnJwNmh4R25TdmRuY2RMZW4rSGNUenFWaUZGVUtyelhzWUFjNzZjZ3pM?=
 =?utf-8?B?ZnBCYUlzY3BYYUtPWk1KS2JBc2dIVjZNN3ZZSDdDY0ZsaVZzZ2tSN3IzT1Jh?=
 =?utf-8?B?cm15aTA5TXpuVkVsWXExN0g2eXdtMVlacmhSLzRFc0RKSXRBU1htSFR6enYx?=
 =?utf-8?B?NmpXV1lnRU1QNytFTFlqQXpJRGc3WXlFUHBpbHlCNk1UWXl1Unpad0orOVpk?=
 =?utf-8?B?MENmcXl5dTlISC9CZG5Nd1BXZkFBN2JtTnMwbmp0K0xXMzAyOUdnT3R3Z3Fr?=
 =?utf-8?B?enYvYWxGYURFTmJickgvYTlvNEVPVkNBNUw3eEZqK2h5TmFxemQ3TGJBME9X?=
 =?utf-8?B?WGU2bWp6V0R3YUUyRWNPeXJrbFlLZXREbHdaTDdKQmhrZk5pOEc4eEprWGNC?=
 =?utf-8?B?Nm83bXNuOVFqRUpYdkRMQ0k0bUoydzZWcHZmZE82blJUSlRCelBzNjV0QWh5?=
 =?utf-8?B?dnp6T05vMXhpaVB2N012NitzUDFOdXhlZFduaUlXVlRhYlZXekt3d01aUE1Z?=
 =?utf-8?B?N1lEcVlhM2tsMTNsOGFjODRZTFVuVENXK0lsRm9zMUFjUTEvY0tveU1vT3gw?=
 =?utf-8?B?eTNUanJSUWExVElMWUhvbFFnU3hReGpLb3Z6V1JHaFhON3RBZ2x0dUpDZW0w?=
 =?utf-8?B?c292YU5XcE9DWUdram44WHFoRnRUOTRxZW5ab0dZaDRoeEdYZzNuYndqR3U0?=
 =?utf-8?B?elZURy9lc1B5T2dIV3lueXk0Yms3TlVyTGZPSDlrdVplRlpoRTRJY04xVnIr?=
 =?utf-8?B?Y091U3I4OEhha2dOb0dncWE4eTVDcU9zdU9iWVMwdlVoRE1tb1FPQi9oWHlr?=
 =?utf-8?B?MEZoUjk0aUdJZXhoYllBc0tsQng2RkJ6R0xtaTJLaDFMOUVHaEFzVXd0US9a?=
 =?utf-8?B?SVUzMDFqakdlaTQ2Y2VPb0RndkFWY2U1M0JEOE0yTkZEVkNrN053YmVoTnNs?=
 =?utf-8?B?Ry9QU2lUSHJOb0JmdHpMUStrd1lPbnJrNVpmQWpBdHVlTXRVZEYzWHdKYmF4?=
 =?utf-8?B?Sm9YNndIbEU5K2o5WHdyVmR2TFFqdTd0TjNlMHJ5eHRUVzQ4b0lMdi9OVG1J?=
 =?utf-8?B?OG9JTjlqckNVNUhKOWowVWc2b3ZLRndMYUlkVlBsSUFyckhDNkJWVjhsYUFH?=
 =?utf-8?B?Z2dINnpaSXZmY0FvMEVJdmQvZXdneFl3T3pCSUVEV0VLS3RoaGhXWUFPdGov?=
 =?utf-8?B?QjN4R0x6T3ViUzRjU083Um1HWVl2NEdEZ1I1R1JoZVRoUlMzV1Z3MjV4U1dO?=
 =?utf-8?B?K2Jhd1BNVnJvaXZzUXU2MXpnaFZYL2x6ZEJiV3AydkozckRBRzAzeXNjTHlh?=
 =?utf-8?B?MXpvckJ0WkRnN2EyNkxQL3Y1T3BObGNXeFIvTXlKT2xHV3d1Um5SR2Y5d2lV?=
 =?utf-8?B?L0lJZk9VblYyYlFFWUxLV0FOT2FrZlpaTlVpeXNBVTRDclhFdHo5NkN2akdX?=
 =?utf-8?B?cUpsTHlXbVJTK0ttQmVYZkFPMWNCVG5jc3ozSWVXdGlsbm9xSWxETHNsbEJQ?=
 =?utf-8?B?UWZ3UXVSdllqYVVZM2E0eHNjMUZVNThYRXUwS0VLMVpuWjgzRGQ3Tnp2dVl0?=
 =?utf-8?B?REc0VGlQbFZsS2NVREk5aWxrcm1iNGg1TDhUSzh3TmFOMWFYMnJ3MXoycGVN?=
 =?utf-8?Q?KBzE5K39vUUbwGUejBKZepc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5391d5c0-6a31-4715-4f97-08d9d163c5e7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 22:27:50.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEX+ET8wCG2lTH+AYDJRqd7JCG7fBSKOsJh6Qbee3She70iV8Xfw54XTLsq1+MJfYpl0spTgAr8wXnGrqZyZ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 09:59, Minchan Kim wrote:
> A Contiguous Memory Allocator(CMA) allocation can fail if any page
> within the requested range has an elevated refcount(a pinned page).
> 
> Debugging such failures is difficult, because the struct pages only
> show a combined refcount, and do not show the callstacks or
> backtraces of the code that acquired each refcount. So the source
> of the page pins remains a mystery, at the time of CMA failure.
> 
> In order to solve this without adding too much overhead, just do
> nothing most of the time, which is pretty low overhead. However,
> once a CMA failure occurs, then mark the page (this requires a
> pointer's worth of space in struct page, but it uses page extensions
> to get that), and start tracing the subsequent put_page() calls.
> As the program finishes up, each page pin will be undone, and
> traced with a backtrace. The programmer reads the trace output and
> sees the list of all page pinning code paths.
> 
> This will consume an additional 8 bytes per 4KB page, or an
> additional 0.2% of RAM. In addition to the storage space, it will
> have some performance cost, due to increasing the size of struct
> page so that it is greater than the cacheline size (or multiples
> thereof) of popular (x86, ...) CPUs.
> 
> The idea can apply every user of migrate_pages as well as CMA to
> know the reason why the page migration failed. To support it,
> the implementation takes "enum migrate_reason" string as filter
> of the tracepoint(see below).
> 

Hi Minchan,

If this is ready to propose, then maybe it's time to remove the "RFC"
qualification from the subject line, and re-post for final review.

And also when you do that, could you please specify which tree or commit
this applies to? I wasn't able to figure that out this time.

> Usage)

This extensive "usage" section is probably helpful, but the commit
log is certainly not the place for the "how to" documentation. Let's
find an .rst file to stash it in, I think.


thanks,
-- 
John Hubbard
NVIDIA

> 
> trace_dir="/sys/kernel/tracing"
> echo 1 > $trace_dir/options/stacktrace
> echo 1 > $trace_dir/events/page_pin_owner/enable
> echo "contig_range" > $trace_dir/events/page_pin_owner/report_page_pinners/filter
> 
> ===
> example:
> If you are interested in compaction failure, you want to use
> "compaction" as a filter instead of "contig_range".
> For the other filter strings, you can refer migrate_reason_names
> in mm/debug.c
> ===
> 
> ..
> run workload
> ..
> 
> cat $trace_dir/trace
> ..
> 
>              bash-7442    [007] ...1.   288.504690: report_page_pinners: pfn=0x91430 flags=uptodate|swapbacked count=2 mapcount=0 mapping=ffff88f5480a2709 mt=5 reason=contig_range err=-11
>              bash-7442    [007] ...1.   288.504691: <stack trace>
>   => trace_event_raw_event_report_page_pinners
>   => __report_page_pinners
>   => migrate_pages
>   => alloc_contig_range
>   => cma_alloc.cold
>   => cma_alloc_write
>   => simple_attr_write
>   => debugfs_attr_write
>   => full_proxy_write
>   => vfs_write
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> ..
> ..
> 
>              bash-7442    [007] ...1.   288.506426: page_pin_owner_put: pfn=0x91430 flags=uptodate|swapbacked count=2 mapcount=0 mapping=ffff88f5480a2709 mt=5
>              bash-7442    [007] ...1.   288.506427: <stack trace>
>   => trace_event_raw_event_page_pin_owner_put
>   => __page_pin_owner_put
>   => put_page
>   => putback_movable_pages
>   => alloc_contig_range
>   => cma_alloc.cold
>   => cma_alloc_write
>   => simple_attr_write
>   => debugfs_attr_write
>   => full_proxy_write
>   => vfs_write
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> ..
>               cc1-31104   [001] d..2.   288.507632: page_pin_owner_put: pfn=0x91430 flags=uptodate|swapbacked count=1 mapcount=0 mapping=ffff88f5480a2709 mt=4
>               cc1-31104   [001] d..2.   288.507636: <stack trace>
>   => trace_event_raw_event_page_pin_owner_put
>   => __page_pin_owner_put
>   => release_pages
>   => tlb_flush_mmu
>   => unmap_page_range
>   => unmap_vmas
>   => exit_mmap
>   => mmput
>   => do_exit
>   => do_group_exit
>   => __x64_sys_exit_group
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> ..
> 
>              make-31157   [007] d..3.   288.508333: page_pin_owner_put: pfn=0x91430 flags=uptodate|lru|swapbacked count=0 mapcount=0 mapping=ffff88f5480a2709 mt=5
>              make-31157   [007] d..3.   288.508335: <stack trace>
>   => trace_event_raw_event_page_pin_owner_put
>   => __page_pin_owner_put
>   => release_pages
>   => __pagevec_lru_add
>   => lru_add_drain_cpu
>   => lru_add_drain
>   => exit_mmap
>   => mmput
>   => begin_new_exec
>   => load_elf_binary
>   => bprm_execve
>   => do_execveat_common.isra.0
>   => __x64_sys_execve
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v1 - https://lore.kernel.org/lkml/20211206184730.858850-1-minchan@kernel.org/
>    * PagePinOwner naming suggestion - jhubbard@
>    * Description/Kconfig suggestion - jhubbard@
>    * General migrate_page supports - huww98@
> 
>   include/linux/mm.h                    |  7 ++-
>   include/linux/page_ext.h              |  3 +
>   include/linux/page_pin_owner.h        | 48 ++++++++++++++
>   include/trace/events/page_pin_owner.h | 81 ++++++++++++++++++++++++
>   mm/Kconfig.debug                      | 15 +++++
>   mm/Makefile                           |  1 +
>   mm/migrate.c                          |  5 +-
>   mm/page_alloc.c                       |  3 +
>   mm/page_ext.c                         |  4 ++
>   mm/page_pin_owner.c                   | 91 +++++++++++++++++++++++++++
>   10 files changed, 256 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/page_pin_owner.h
>   create mode 100644 include/trace/events/page_pin_owner.h
>   create mode 100644 mm/page_pin_owner.c
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 82be88c1fdbb..5c437faf129c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -26,6 +26,7 @@
>   #include <linux/err.h>
>   #include <linux/page-flags.h>
>   #include <linux/page_ref.h>
> +#include <linux/page_pin_owner.h>
>   #include <linux/memremap.h>
>   #include <linux/overflow.h>
>   #include <linux/sizes.h>
> @@ -714,8 +715,12 @@ static inline unsigned int folio_order(struct folio *folio)
>    */
>   static inline int put_page_testzero(struct page *page)
>   {
> +	int ret;
> +
>   	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> -	return page_ref_dec_and_test(page);
> +	ret = page_ref_dec_and_test(page);
> +	page_pin_owner_put(page);
> +	return ret;
>   }
>   
>   static inline int folio_put_testzero(struct folio *folio)
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1e087f..3236efd5ab07 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -23,6 +23,9 @@ enum page_ext_flags {
>   	PAGE_EXT_YOUNG,
>   	PAGE_EXT_IDLE,
>   #endif
> +#if defined(CONFIG_PAGE_PIN_OWNER)
> +	PAGE_EXT_PIN_OWNER,
> +#endif
>   };
>   
>   /*
> diff --git a/include/linux/page_pin_owner.h b/include/linux/page_pin_owner.h
> new file mode 100644
> index 000000000000..e68adcdd6799
> --- /dev/null
> +++ b/include/linux/page_pin_owner.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_PAGE_PIN_OWNER_H
> +#define __LINUX_PAGE_PIN_OWNER_H
> +
> +#include <linux/jump_label.h>
> +
> +#ifdef CONFIG_PAGE_PIN_OWNER
> +extern struct static_key_false page_pin_owner_inited;
> +extern struct page_ext_operations page_pin_owner_ops;
> +
> +void __report_page_pinners(struct page *page, int reason, int err);
> +void __page_pin_owner_put(struct page *page);
> +void __reset_page_pin_owner(struct page *page, unsigned int order);
> +
> +static inline void reset_page_pin_owner(struct page *page, unsigned int order)
> +{
> +	if (static_branch_unlikely(&page_pin_owner_inited))
> +		__reset_page_pin_owner(page, order);
> +}
> +
> +static inline void report_page_pinners(struct page *page, int reason, int err)
> +{
> +	if (!static_branch_unlikely(&page_pin_owner_inited))
> +		return;
> +
> +	__report_page_pinners(page, reason, err);
> +}
> +
> +static inline void page_pin_owner_put(struct page *page)
> +{
> +	if (!static_branch_unlikely(&page_pin_owner_inited))
> +		return;
> +
> +	__page_pin_owner_put(page);
> +}
> +
> +#else
> +static inline void reset_page_pin_owner(struct page *page, unsigned int order)
> +{
> +}
> +static inline void report_page_pinners(struct page *page, int reason, int err)
> +{
> +}
> +static inline void page_pin_owner_put(struct page *page)
> +{
> +}
> +#endif /* CONFIG_PAGE_PIN_OWNER */
> +#endif /*__LINUX_PAGE_PIN_OWNER_H */
> diff --git a/include/trace/events/page_pin_owner.h b/include/trace/events/page_pin_owner.h
> new file mode 100644
> index 000000000000..0096297312f5
> --- /dev/null
> +++ b/include/trace/events/page_pin_owner.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM page_pin_owner
> +
> +#if !defined(_TRACE_PAGE_PIN_OWNER_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PAGE_PIN_OWNER_H
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +#include <trace/events/mmflags.h>
> +
> +TRACE_EVENT(page_pin_owner_put,
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
> +		),
> +
> +	TP_fast_assign(
> +		__entry->pfn = page_to_pfn(page);
> +		__entry->flags = page->flags;
> +		__entry->count = page_ref_count(page);
> +		__entry->mapcount = page_mapcount(page);
> +		__entry->mapping = page->mapping;
> +		__entry->mt = get_pageblock_migratetype(page);
> +		),
> +
> +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
> +			__entry->pfn,
> +			show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> +			__entry->count,
> +			__entry->mapcount, __entry->mapping, __entry->mt)
> +);
> +
> +TRACE_EVENT(report_page_pinners,
> +
> +	TP_PROTO(struct page *page, const char *reason, int err),
> +
> +	TP_ARGS(page, reason, err),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, pfn)
> +		__field(unsigned long, flags)
> +		__field(int, count)
> +		__field(int, mapcount)
> +		__field(void *, mapping)
> +		__field(int, mt)
> +		__field(const char *, reason)
> +		__field(int, err)
> +		),
> +
> +	TP_fast_assign(
> +		__entry->pfn = page_to_pfn(page);
> +		__entry->flags = page->flags;
> +		__entry->count = page_ref_count(page);
> +		__entry->mapcount = page_mapcount(page);
> +		__entry->mapping = page->mapping;
> +		__entry->mt = get_pageblock_migratetype(page);
> +		__entry->reason = reason;
> +		__entry->err = err;
> +		),
> +
> +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d reason=%s err=%d",
> +			__entry->pfn,
> +			show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> +			__entry->count, __entry->mapcount, __entry->mapping,
> +			__entry->mt, __entry->reason, __entry->err)
> +);
> +
> +#endif /* _TRACE_PAGE_PIN_OWNER_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 5bd5bb097252..ed2d5e6450b7 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -86,6 +86,21 @@ config PAGE_TABLE_CHECK_ENFORCED
>   
>   	  If unsure say "n".
>   
> +config PAGE_PIN_OWNER
> +	bool "Track page pinner"
> +	depends on DEBUG_KERNEL && TRACEPOINTS && STACKTRACE_SUPPORT
> +	select PAGE_EXTENSION
> +	select STACKTRACE
> +	help
> +	  This keeps track of what call chain is the pinner of a page, may
> +	  help to find contiguous page allocation(memory-hotplug, compaction,
> +	  cma and so on) failure. Even if you include this feature in your
> +	  build, it is disabled by default. You should pass "page_pin_owner=on"
> +	  to boot parameter in order to enable it. Eats a fair amount of memory
> +	  if enabled.
> +
> +	  If unsure, say N.
> +
>   config PAGE_POISONING
>   	bool "Poison pages after freeing"
>   	help
> diff --git a/mm/Makefile b/mm/Makefile
> index 588d3113f3b0..ca89f4fa38ce 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
>   obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
>   obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
>   obj-$(CONFIG_PAGE_OWNER) += page_owner.o
> +obj-$(CONFIG_PAGE_PIN_OWNER) += page_pin_owner.o
>   obj-$(CONFIG_CLEANCACHE) += cleancache.o
>   obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
>   obj-$(CONFIG_ZPOOL)	+= zpool.o
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7da064b4781..aa8a2c21da8e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1105,6 +1105,8 @@ static int unmap_and_move(new_page_t get_new_page,
>   	rc = __unmap_and_move(page, newpage, force, mode);
>   	if (rc == MIGRATEPAGE_SUCCESS)
>   		set_page_owner_migrate_reason(newpage, reason);
> +	else
> +		report_page_pinners(page, reason, rc);
>   
>   out:
>   	if (rc != -EAGAIN) {
> @@ -1273,7 +1275,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>   	if (rc == MIGRATEPAGE_SUCCESS) {
>   		move_hugetlb_state(hpage, new_hpage, reason);
>   		put_new_page = NULL;
> -	}
> +	} else
> +		report_page_pinners(hpage, reason, rc);
>   
>   out_unlock:
>   	unlock_page(hpage);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b5d62e1c8d81..98125b1b6e7e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -64,6 +64,7 @@
>   #include <linux/sched/rt.h>
>   #include <linux/sched/mm.h>
>   #include <linux/page_owner.h>
> +#include <linux/page_pin_owner.h>
>   #include <linux/page_table_check.h>
>   #include <linux/kthread.h>
>   #include <linux/memcontrol.h>
> @@ -1310,6 +1311,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>   		if (memcg_kmem_enabled() && PageMemcgKmem(page))
>   			__memcg_kmem_uncharge_page(page, order);
>   		reset_page_owner(page, order);
> +		reset_page_pin_owner(page, order);
>   		page_table_check_free(page, order);
>   		return false;
>   	}
> @@ -1350,6 +1352,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>   	page_cpupid_reset_last(page);
>   	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>   	reset_page_owner(page, order);
> +	reset_page_pin_owner(page, order);
>   	page_table_check_free(page, order);
>   
>   	if (!PageHighMem(page)) {
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 2e66d934d63f..3c0df97b9b8b 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -7,6 +7,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/kmemleak.h>
>   #include <linux/page_owner.h>
> +#include <linux/page_pin_owner.h>
>   #include <linux/page_idle.h>
>   #include <linux/page_table_check.h>
>   
> @@ -79,6 +80,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
>   #ifdef CONFIG_PAGE_TABLE_CHECK
>   	&page_table_check_ops,
>   #endif
> +#ifdef CONFIG_PAGE_PIN_OWNER
> +	&page_pin_owner_ops,
> +#endif
>   };
>   
>   unsigned long page_ext_size = sizeof(struct page_ext);
> diff --git a/mm/page_pin_owner.c b/mm/page_pin_owner.c
> new file mode 100644
> index 000000000000..736617df093c
> --- /dev/null
> +++ b/mm/page_pin_owner.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/mm.h>
> +#include <linux/page_pin_owner.h>
> +#include <linux/migrate.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/page_pin_owner.h>
> +
> +static bool page_pin_owner_enabled;
> +DEFINE_STATIC_KEY_FALSE(page_pin_owner_inited);
> +EXPORT_SYMBOL(page_pin_owner_inited);
> +
> +static int __init early_page_pin_owner_param(char *buf)
> +{
> +	return kstrtobool(buf, &page_pin_owner_enabled);
> +}
> +early_param("page_pin_owner", early_page_pin_owner_param);
> +
> +static bool need_page_pin_owner(void)
> +{
> +	return page_pin_owner_enabled;
> +}
> +
> +static void init_page_pin_owner(void)
> +{
> +	if (!page_pin_owner_enabled)
> +		return;
> +
> +	static_branch_enable(&page_pin_owner_inited);
> +}
> +
> +struct page_ext_operations page_pin_owner_ops = {
> +	.need = need_page_pin_owner,
> +	.init = init_page_pin_owner,
> +};
> +
> +void __reset_page_pin_owner(struct page *page, unsigned int order)
> +{
> +	struct page_ext *page_ext;
> +	int i;
> +
> +	page_ext = lookup_page_ext(page);
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		if (!test_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags))
> +			break;
> +
> +		clear_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags);
> +		page_ext = page_ext_next(page_ext);
> +	}
> +}
> +
> +void __report_page_pinners(struct page *page, int reason, int err)
> +{
> +	struct page_ext *page_ext;
> +
> +	page_ext = lookup_page_ext(page);
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	test_and_set_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags);
> +	trace_report_page_pinners(page, migrate_reason_names[reason], err);
> +}
> +
> +void __page_pin_owner_put(struct page *page)
> +{
> +	struct page_ext *page_ext = lookup_page_ext(page);
> +
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	if (!test_bit(PAGE_EXT_PIN_OWNER, &page_ext->flags))
> +		return;
> +
> +	trace_page_pin_owner_put(page);
> +}
> +EXPORT_SYMBOL(__page_pin_owner_put);
> +
> +static int __init page_pin_owner_init(void)
> +{
> +	if (!static_branch_unlikely(&page_pin_owner_inited)) {
> +		pr_info("page_pin_owner is disabled\n");
> +		return 0;
> +	}
> +
> +	pr_info("page_pin_owner is enabled\n");
> +	return 0;
> +}
> +late_initcall(page_pin_owner_init)

