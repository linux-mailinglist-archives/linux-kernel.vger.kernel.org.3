Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB850667A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349701AbiDSIHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiDSIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:07:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64CC10DD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBCMWIqHpfZ8lMZEFFy9l2d9wotrRE8apT9zH4seg2okFYwp/YBUiAlv9HfI86+wDmy3YRSxrzkC5tgKXi5VKE5COfvvzLvAEIW6wuGukZhadij4mBabvA12Um8/xdPbtKZxW7GGuS6tS3YaxjphLI+p0tkUe2hoDzA33qqZ4DFt9KlYXuoWMvEcRXUUV2V0pZQGqSXG1GtuDmVfKvkBuerwqZwd+w2lP+LXQPXVrvpjE4rE9dSehYDst3xu15mbl+Oig5tSXhYbW7SfK5ICk8MfkoybHyNpGoStZR3BcEjwgzWkdgJdK4H+E/U43fKoUd1epXSLaESs4hoqLE2HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpClhYBofjTS4bNwbh0QqxhGUY24ZOOwXwE39O3W1hM=;
 b=V/2zjA0gWwgeoZ+zqpeROLRkJyLpaYuSd5h9mDzTbEgu8PswIRaNaUSziq6OCCtE5doXPPNtDN3Hl0Z9CxKzvUyQO6kJ8TlAgesYToBbHj6oE+8E1I2gnx3dPh7mfHM2hJh80oVaRlOtvWNmUl4//zyQTnhUf2cv76NllHhD/+KzD1LMuIk94TrIoq4mgzS02co4XbbnUAkJmfyyNsp3LleWvk/xoKH4kSFXCFYzyncwMCo+Tu3touV3kaBItR44Gh75lT+6ru+TuwyNhiJxaQbPP5kzx0DO0hRh231P63tTiAWfGZ9fJ79KT7xgtAfLgv6dx+C0q1D/Tvvf0rjLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpClhYBofjTS4bNwbh0QqxhGUY24ZOOwXwE39O3W1hM=;
 b=k+HFCLkI2H8XSDpQA1QIauQcqn0n0IldERaF8FDJWfTmbbTvgwLRYiXF7QNiK7MzfKJdURO8m2flD/Fcpo20s5J84Ycz4Z3UQ3UmgCEgx8r3vCcB4qd85faEtTEKR3v5KoCvh9acRfCndAgEqgx8KJbrUzdzy+31R3i8Q8lb4QA0d3j6tWVxYWXv8dvM+KV+Br6ZcLLGXE/vYZQ2OMTjll40l0T6L0jRoKS3fCGo8zUACxbj31X11J5YuZwIoLPa/JJE30iiY9XS/UaP2i3KRi6fp5tOE/eX6JD1KK2uKG9EqCVqaV2h58MSOD5rXoKN8LZwLyX+YR48TWhKwKJ+cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:04:48 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:04:48 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        surenb@google.com, minchan@kernel.org, peterx@redhat.com,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Date:   Tue, 19 Apr 2022 17:53:03 +1000
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <87tuapk9n7.fsf@nvdebian.thelocal>
Message-ID: <87r15tjy76.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 393e22b4-5f6f-4894-5dbe-08da21db45cf
X-MS-TrafficTypeDiagnostic: MWHPR12MB1599:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1599A8DDFCB2BECCEED4BE10DFF29@MWHPR12MB1599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kkkTloBvfrasZ/9HBLnpOBUYVo+k5DsS0DvGu4I0DSPKs3NjE2q0qYMX6mkRj09NnISho3tAf80iqVgj3022fg2z9fvd484FmQhpXgDnS2R8JQjn29CToPxBYgpqd7s+PC2OMdLLTfFH7lhTuvMcL2SkJyEmmltLUuYBFfAsvM8lX2cqbJpsEktyn2ogL/fsL06ogCpwUR3jreL/KKn524Iezdy63tMpYce86l6Mxoa0km1T19uRFUD83fn2HHtx7pKV3+a4g8kinXcSBxeDxoxBxE05EGKUIMpyVFesD+vF1Jn4JgHHr9w55TkU7cnP8k9RwsPV+T4husEz+aRod1ZnjiK6T25u12D5mGNEsxgWMFSTrLWFNXp6GJYRXhpQis4zpGtbrLQg+EaNU2dojTVqCiGtW+WHwG3aMOT7uDbwjFeDCOju9+imFsWy8Zj7BSx/Hevl11NirEu1MYKIOHK2BzgCYKCt1GpZW2mP7ghQnlQE+qjFbs8LjJLOzpFodmjuHuws0s+/OCDQjU/o8rtDhI1T54X3O8ZZI8Ti3WnkYFR0kfrasjseCTRB4VUSOeMWZXCncipV9YRfgu47aHU9j3tzJx2hpRLZHhLardPXS270B00owhzGns+MR7nM4G5/9n3B+A65cz/YJ6VXSzsP4WBlyUULkR/GrJ+UZ0GX9gv1fFPszp/GDlABYm6K26MjAjH9gcGXuWUSnWPyzYOx0fvRi8WyDQRJXgIs34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44144004)(6666004)(316002)(9686003)(6916009)(8936002)(5660300002)(6512007)(508600001)(2906002)(6486002)(38100700002)(186003)(6506007)(7416002)(26005)(86362001)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TtRaD1OKjfkH3i/SfGHl+ruhqZekt6ToWiDgGJyoRA2eVRUC9zGRRGkK8Xeh?=
 =?us-ascii?Q?mOfk8DGSZMIbjZtNXVhfBVoTyqV9tpKfJIZn/jGxsgl9oozZPoUoXOgORxSz?=
 =?us-ascii?Q?t7C8wkxS4i8QfdO7Z7MDNQ0CWVUl99KUjUmhkzCfJVz3Jboy+HGK6sr5YjXI?=
 =?us-ascii?Q?w8Benvww+tXqU/kyadsF144+H/Fyc4Cz6K21maxGgveWl+5FRIOTT/cl/J59?=
 =?us-ascii?Q?tdUfwBfLDC6Yh4BCMO8d+7eKXWTg7+iFnIKKSadDHdQpJ3UwmtMQNPMszquF?=
 =?us-ascii?Q?a7tdktJGipWgO93nQ68p/uMzIORw3Sv4D2+uTqECD7DiokJE/W/3XsPLKoSD?=
 =?us-ascii?Q?eyBKoSZNjWi4uFfOwgHZjzZdUunRHPbQBhVrk+JL1xrrPE+/gJ+wSZ6OHlOD?=
 =?us-ascii?Q?yD3cteursiLo0M/kqRwJhhQQyKVt3jLft2CEG5CRdSdPacqis+0+J4DJtNnt?=
 =?us-ascii?Q?+hT45IBH3rghpk9KOSxXR/5N5jEIJET7Q7HARtfYpfKyzRkFjknYULVgsrSj?=
 =?us-ascii?Q?ShI+iJBpNhUHHDVofYfyK83yUppbAu8pzITFGqkOtfItUxLXooPL23y4w2IS?=
 =?us-ascii?Q?PCKyGpcOi11Tw34FslThR6ZKfPVI1WKVi1VjJ7qoG4wBQx16NP5PM+iwx9+D?=
 =?us-ascii?Q?gVVj/2E+DAGMCrO9WNG79XEDgWu3esFyxrqxu0+BZcPSc1Ler5qAAJ8VPrtU?=
 =?us-ascii?Q?o7d6PO4fVK/VWhJfa0mRwaMiJV0iGlYjT/C+188MgVq6/JJLdsHSNzvEc/Y5?=
 =?us-ascii?Q?CitMwgiqFReiy1HLU+43arUgu7BQKXoX0O8qqtjRv4qTbAmRREcQCOaJCAKT?=
 =?us-ascii?Q?zQ4lSI/K4eka8XLBUWWvJ6ecdf90KkE/5wQYjjO3pwG9TnK0f2I+K7RYsdTC?=
 =?us-ascii?Q?oNVn3hcRnMbVCHXumKDZYE/nXwWouinWBJifT0z8u5bkucQdzCXKOXvHeNqb?=
 =?us-ascii?Q?+GjLlwV4/Qtg/7T7HLUBgD+xVJSixe/T1v/dNavIJxqRDXZ0gyQfG/eR6pC7?=
 =?us-ascii?Q?+zh2eZCt0NIaW6+7CcmoXSF9dzlDEwBvBthCmlIBMFlMe4qiXmgph9UoRrPr?=
 =?us-ascii?Q?ovtvY2riuV884hFN2eHjTKbJTw55vvk/Gg5vfuv0etLOCzcA8Tp1DhnAAcpq?=
 =?us-ascii?Q?R5+Dyew9l+RMCIMzAUOw6+aISYRpJfFt8aXhZKYUsvDlKdEvsTeMrGC8+wdi?=
 =?us-ascii?Q?5XP6tyXDPcI4LR0GUL9OWaPvVN0frZ0C4Cuizv7KQxY8XU4NK+52sqaoai6u?=
 =?us-ascii?Q?SXMz+50QWvJgi9JRQ92sze6OXtYf2nQZZqLA/jBC4XapXOSaqsV2OyPxwRNa?=
 =?us-ascii?Q?ScoUlUJzb194YHcSzSU+Jrnb3JJiGH6Xk8hY2eZLo/Jq2jjMO8fnSKweR6uU?=
 =?us-ascii?Q?knGlHrTQDQAd8b/xveAuPIlYaHSNhM07j/8cI6ptP/LM220AEqsFQp5P49Us?=
 =?us-ascii?Q?/xmSmUtlGjT1sDoDzRnxGelHMoBHwjJTco3V0qzjFIZ9ujt+aIfxO6HUJCvJ?=
 =?us-ascii?Q?NnOc9mgCS4uaiX+liC2ixqRFbIXkyAKtqijFr8V8lUyMtSWtZLUYIHIi3rrU?=
 =?us-ascii?Q?01aWolXEQIpcnZ4ufI0GnYIr4ZYxNmw9Mo+kSGc/wcD/7Bc0EJPEACV60DVI?=
 =?us-ascii?Q?BABMs1a06GZPIf05y8X1ZHN1G7QMvIeULRHC9JdsFYC8xErvGls4zG4ThVdQ?=
 =?us-ascii?Q?dPj2XuDmPCiAG1V96SVjvhtgAxDcVM08nCEsX4qmYHZu3JMzts+wlg8B0SLk?=
 =?us-ascii?Q?JLjDdjDUlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393e22b4-5f6f-4894-5dbe-08da21db45cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 08:04:48.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/MQ4tnfYVQxymTSc7rYRbovVLgjGbnsZTubT9b65BfpvUiVX8+xHuevPeketAdRQiKash3syGjVJQTcytpQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1599
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Also in madvise_free_pte_range() you could just remove the swap entry as it's no
longer needed.

Alistair Popple <apopple@nvidia.com> writes:

> Miaohe Lin <linmiaohe@huawei.com> writes:
>
>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>> page filled with random data is mapped into user address space. In case
>> of error, a special swap entry indicating swap read fails is set to the
>> page table. So the swapcache page can be freed and the user won't end up
>> with a permanently mounted swap because a sector is bad. And if the page
>> is accessed later, the user process will be killed so that corrupted data
>> is never consumed. On the other hand, if the page is never accessed, the
>> user won't even notice it.
>
> Hi Miaohe,
>
> It seems we're not actually using the pfn that gets stored in the special swap
> entry here. Is my understanding correct? If so I think it would be better to use
> the new PTE markers Peter introduced[1] rather than adding another swap entry
> type.
>
> [1] - <https://lore.kernel.org/linux-mm/20220405014833.14015-1-peterx@redhat.com/>
>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>> v2:
>>   use special swap entry to avoid permanently mounted swap
>>   free the bad page in swapcache
>> ---
>>  include/linux/swap.h    |  7 ++++++-
>>  include/linux/swapops.h | 10 ++++++++++
>>  mm/memory.c             |  5 ++++-
>>  mm/swapfile.c           | 11 +++++++++++
>>  4 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index d112434f85df..03c576111737 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>>   * actions on faults.
>>   */
>>
>> +#define SWAP_READ_ERROR_NUM 1
>> +#define SWAP_READ_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
>> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
>> +			     SWP_PTE_MARKER_NUM)
>>  /*
>>   * PTE markers are used to persist information onto PTEs that are mapped with
>>   * file-backed memories.  As its name "PTE" hints, it should only be applied to
>> @@ -120,7 +124,8 @@ static inline int current_is_kswapd(void)
>>
>>  #define MAX_SWAPFILES \
>>  	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
>> -	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
>> +	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
>> +	SWP_PTE_MARKER_NUM - SWAP_READ_ERROR_NUM)
>>
>>  /*
>>   * Magic header for a swap area. The first part of the union is
>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>> index fffbba0036f6..d1093384de9f 100644
>> --- a/include/linux/swapops.h
>> +++ b/include/linux/swapops.h
>> @@ -108,6 +108,16 @@ static inline void *swp_to_radix_entry(swp_entry_t entry)
>>  	return xa_mk_value(entry.val);
>>  }
>>
>> +static inline swp_entry_t make_swapin_error_entry(struct page *page)
>> +{
>> +	return swp_entry(SWAP_READ_ERROR, page_to_pfn(page));
>> +}
>> +
>> +static inline int is_swapin_error_entry(swp_entry_t entry)
>> +{
>> +	return swp_type(entry) == SWAP_READ_ERROR;
>> +}
>> +
>>  #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
>>  static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
>>  {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index e6434b824009..34d1d66a05bd 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1476,7 +1476,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>  			/* Only drop the uffd-wp marker if explicitly requested */
>>  			if (!zap_drop_file_uffd_wp(details))
>>  				continue;
>> -		} else if (is_hwpoison_entry(entry)) {
>> +		} else if (is_hwpoison_entry(entry) ||
>> +			   is_swapin_error_entry(entry)) {
>>  			if (!should_zap_cows(details))
>>  				continue;
>>  		} else {
>> @@ -3724,6 +3725,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
>>  		} else if (is_hwpoison_entry(entry)) {
>>  			ret = VM_FAULT_HWPOISON;
>> +		} else if (is_swapin_error_entry(entry)) {
>> +			ret = VM_FAULT_SIGBUS;
>>  		} else if (is_pte_marker_entry(entry)) {
>>  			ret = handle_pte_marker(vmf);
>>  		} else {
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 9398e915b36b..95b63f69f388 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1797,6 +1797,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  		goto out;
>>  	}
>>
>> +	if (unlikely(!PageUptodate(page))) {
>> +		pte_t pteval;
>> +
>> +		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>> +		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
>> +		set_pte_at(vma->vm_mm, addr, pte, pteval);
>> +		swap_free(entry);
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>>  	/* See do_swap_page() */
>>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));

--=-=-=--
