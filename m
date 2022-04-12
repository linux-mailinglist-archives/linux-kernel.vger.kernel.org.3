Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FFF4FCC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiDLCSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbiDLCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F433E05;
        Mon, 11 Apr 2022 19:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E592616B4;
        Tue, 12 Apr 2022 02:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F72DC385A4;
        Tue, 12 Apr 2022 02:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729784;
        bh=czcqbI3NFXXdksle1p+xxdrXMUzuEzwDxXYTfL5oygc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rQA0FJhIvd3j58VrCNw7I1Yfx0ql9MAgEtN6wa/W51NW9ByMZZi7Af4aiWAOCcGev
         l203DMHBLREf/WeMVdQJvt10IiSkJaXQK+nP5Mr2J8mjmckbSDbH2MLxYT67D0h2y0
         8eC7yVrTHMivKkxXx8Iah8DroA5D+MGlY9IBvK/4=
Date:   Mon, 11 Apr 2022 19:16:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?ISO-8859-1?Q? "Holger_Hoffst=E4tte" ?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
Message-Id: <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-9-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-9-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 21:15:20 -0600 Yu Zhao <yuzhao@google.com> wrote:

>
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6083,6 +6083,29 @@ static void mem_cgroup_move_task(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_LRU_GEN
> +static void mem_cgroup_attach(struct cgroup_taskset *tset)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct task_struct *task = NULL;
> +
> +	cgroup_taskset_for_each_leader(task, css, tset)
> +		break;

Does this actually do anything?

> +	if (!task)
> +		return;
> +
> +	task_lock(task);
> +	if (task->mm && task->mm->owner == task)
> +		lru_gen_migrate_mm(task->mm);
> +	task_unlock(task);
> +}
>  
> ...
>
> +static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> +			      int old_gen, int new_gen)
> +{
> +	int type = folio_is_file_lru(folio);
> +	int zone = folio_zonenum(folio);
> +	int delta = folio_nr_pages(folio);
> +
> +	VM_BUG_ON(old_gen >= MAX_NR_GENS);
> +	VM_BUG_ON(new_gen >= MAX_NR_GENS);

General rule: don't add new BUG_ONs, because they crash the kenrel. 
It's better to use WARN_ON or WARN_ON_ONCE then try to figure out a way
to keep the kernel limping along.  At least so the poor user can gather logs.

> +	walk->batched++;
> +
> +	walk->nr_pages[old_gen][type][zone] -= delta;
> +	walk->nr_pages[new_gen][type][zone] += delta;
> +}
> +

