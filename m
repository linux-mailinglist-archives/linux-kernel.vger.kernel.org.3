Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4725542D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiFVGVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiFVGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:21:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B0369C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:21:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso15786568pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2l9YHnTCHEZbmX1vqIKgTsBl4LuPnmzfnEVIEO95Yuk=;
        b=Vl93CrA/UtQLYvuumeHVdrEweooBfop0R+dDLntKS4n2ikh/TXiUNXQbmHovjn/s6w
         G0c1JCo8UyQc3UNEzuYovHxq0f2lsG4hhC8lrA/vVLRD1C4atRIBGy7b+fpsfpE+ymVg
         e9wEzdOabfUlvuIV4H2GfIUL21uG76AZEqSjXIH/8jwYkL5ZF/H5014CciBuUtQy0e8T
         Ab+U6g6fxmIGgtKmsTCC+gtDBqrS08XRYJv6udAhG8Y6SZGBftVk+Rh4KKJ5f1T+Ke/5
         fb7vDdswWfQ7Bcpks0fig5C67kQBVCteU9kBD4ikKxjYnK9IF1/DTFiEdCvIA8UIyeeS
         X/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2l9YHnTCHEZbmX1vqIKgTsBl4LuPnmzfnEVIEO95Yuk=;
        b=3og+3B76EhX7dARQN817QFBeEPPNBL2iX+Ne76U/UQvbtpo4iyK5LwQxFEiEV1LeG2
         qwkxZF9ErosdFlUdacJU8Jna5bH3oYVa2O7eM7hLq69bL40uBybLRm9HDd0/KxKC/un8
         sjS6/LICCT6eqDu/gKeb2ZryoJah3dd2dD9MJKbDIL8nuUB3zaw3zpW1x6fv19tYwpjg
         o/sjfJyZ31g9rdcOwaC5WFVhhz1LQO/9XOpecOLho517PLYsBeAch9vD8yBhqaNNtuDV
         0J/ryIw37eFx2nC0Pi3iY0ofD97QczvODucPmvEsg43MZahS7+omdj2WWuU/WrD1UhRm
         XcFQ==
X-Gm-Message-State: AJIora+QBDwuP65UZeJzM0sfODJ/JTIKug6uQstz5CJ3ykpXwlPqj6yV
        t/dyqIZYRf6mcAyKdoo4/CGQPQ==
X-Google-Smtp-Source: AGRyM1uYRu1M8vsdu4fWKSIrkfoZvszKA5zB9WnFh2GsKIMSN2uogA/zjFuVFCiBFUMQ21o8FhZhqQ==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr9884251pjj.82.1655878889648;
        Tue, 21 Jun 2022 23:21:29 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b0015e8d4eb1easm8942900pla.52.2022.06.21.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:21:29 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:21:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hugetlb: skip irrelevant nodes in
 hugetlb_show_meminfo()
Message-ID: <YrK05aLPyfwVusN8@FVFYT0MHHV2J.usts.net>
References: <20220622040043.25462-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622040043.25462-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:00:42PM +0800, Gang Li wrote:
> show_free_areas() allows to filter out node specific data which is
> irrelevant to the allocation request. But hugetlb_show_meminfo() still
> show hugetlb on all nodes, which is redundant and unnecessary.
> 
> Use show_mem_node_skip() to skip irrelevant nodes in
> hugetlb_show_meminfo().
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/linux/hugetlb.h | 4 ++--
>  include/linux/mm.h      | 1 +
>  mm/hugetlb.c            | 7 +++++--
>  mm/page_alloc.c         | 4 ++--
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 642a39016f9a..1913ac6bf10a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -155,7 +155,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>  			  struct page *ref_page, zap_flags_t zap_flags);
>  void hugetlb_report_meminfo(struct seq_file *);
>  int hugetlb_report_node_meminfo(char *buf, int len, int nid);
> -void hugetlb_show_meminfo(void);
> +void hugetlb_show_meminfo(unsigned int filter, nodemask_t *nodemask);
>  unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
> @@ -300,7 +300,7 @@ static inline int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>  	return 0;
>  }
>  
> -static inline void hugetlb_show_meminfo(void)
> +static inline void hugetlb_show_meminfo(unsigned int filter, nodemask_t *nodemask)
>  {
>  }
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 764dc0fdae5e..f72c1b21cde3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1873,6 +1873,7 @@ extern void pagefault_out_of_memory(void);
>   */
>  #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
>  
> +extern bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask);

Exporting this to the only user of HugeTLB is not a good idea.

>  extern void show_free_areas(unsigned int flags, nodemask_t *nodemask);
>  
>  #ifdef CONFIG_MMU
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 98492733cc64..632826e6fea5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4486,7 +4486,7 @@ int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>  			     nid, h->surplus_huge_pages_node[nid]);
>  }
>  
> -void hugetlb_show_meminfo(void)
> +void hugetlb_show_meminfo(unsigned int filter, nodemask_t *nodemask)
>  {

I suggest making this function show meminfo for a specific node.
like hugetlb_show_meminfo_node(int nid) which only show meminfo
for node @nid.

>  	struct hstate *h;
>  	int nid;
> @@ -4494,7 +4494,9 @@ void hugetlb_show_meminfo(void)
>  	if (!hugepages_supported())
>  		return;
>  
> -	for_each_node_state(nid, N_MEMORY)
> +	for_each_node_state(nid, N_MEMORY) {
> +		if (show_mem_node_skip(filter, nid, nodemask))
> +			continue;
>  		for_each_hstate(h)
>  			pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
>  				nid,
> @@ -4502,6 +4504,7 @@ void hugetlb_show_meminfo(void)
>  				h->free_huge_pages_node[nid],
>  				h->surplus_huge_pages_node[nid],
>  				huge_page_size(h) / SZ_1K);
> +	}
>  }
>  
>  void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 84781094b478..5896b5a9101f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5951,7 +5951,7 @@ void si_meminfo_node(struct sysinfo *val, int nid)
>   * Determine whether the node should be displayed or not, depending on whether
>   * SHOW_MEM_FILTER_NODES was passed to show_free_areas().
>   */
> -static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
> +bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
>  {
>  	if (!(flags & SHOW_MEM_FILTER_NODES))
>  		return false;
> @@ -6196,7 +6196,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  		printk(KERN_CONT "= %lukB\n", K(total));
>  	}
>

Just like the above case. We can check nid here instead of in hugetlb_show_meminfo().
Then you do not need to export show_mem_node_skip().

for_each_online_node(nid) {
	if (show_mem_node_skip(filter, nid, nodemask))
		continue;
	hugetlb_show_meminfo_node(nid);
}

Thanks.

> -	hugetlb_show_meminfo();
> +	hugetlb_show_meminfo(filter, nodemask);
>  
>  	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
>  
> -- 
> 2.20.1
> 
> 
