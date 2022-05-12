Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A256525322
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356793AbiELRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356818AbiELRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:01:09 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD995F4A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652374866; x=1683910866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZZTVVPejmnnjzcb0Y6aYldJcyupZeutNKdvKmzjyXA=;
  b=rrvtLnxnfNkNHTR16ys5f3gYTXrT7ylP/V+lOeLwbG/hB0gg/dlm+ucx
   1zBSk0//Xy94UjMSE5uFOZ8J9WqC7YDm5zGGrJHVK/8T02kD59DGQXGdf
   peFHxYv9qngs5blqAVpW9fd5U6jRJ2Ix5nGKo8AnSi1tV+fWRMWFmkTlQ
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 May 2022 10:01:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:01:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 10:01:04 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 10:01:03 -0700
Date:   Thu, 12 May 2022 13:01:00 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Message-ID: <20220512170100.GA74@qian>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
 <20220504010716.661115-10-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220504010716.661115-10-Liam.Howlett@oracle.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:07:52AM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Start tracking the VMAs with the new maple tree structure in parallel with
> the rb_tree.  Add debug and trace events for maple tree operations and
> duplicate the rb_tree that is created on forks into the maple tree.
> 
> The maple tree is added to the mm_struct including the mm_init struct,
> added support in required mm/mmap functions, added tracking in kernel/fork
> for process forking, and used to find the unmapped_area and checked
> against what the rbtree finds.
> 
> This also moves the mmap_lock() in exit_mmap() since the oom reaper call
> does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
...
> @@ -2479,9 +2693,14 @@ int expand_downwards(struct vm_area_struct *vma,
>  			return -ENOMEM;
>  	}
>  
> +	if (mas_preallocate(&mas, vma, GFP_KERNEL))

We have thousands of leaks reports here from kmemleak while running some
syscall fuzzers on today's linux-next tree.

unreferenced object 0xffff0803c0063d00 (size 256):
  comm "trinity-c25", pid 177739, jiffies 4297781293 (age 354.988s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
     slab_post_alloc_hook
     kmem_cache_alloc_bulk
     mas_alloc_nodes
     mas_preallocate
     mas_preallocate at lib/maple_tree.c:5579
     expand_downwards
     expand_downwards at mm/mmap.c:2094
     expand_stack
     do_page_fault
     do_translation_fault
     do_mem_abort
     el1_abort
     el1h_64_sync_handler
     el1h_64_sync
     handle_futex_death
     exit_robust_list
     futex_exit_release
     exit_mm_release

> +		return -ENOMEM;
> +
>  	/* We must make sure the anon_vma is allocated. */
> -	if (unlikely(anon_vma_prepare(vma)))
> +	if (unlikely(anon_vma_prepare(vma))) {
> +		mas_destroy(&mas);
>  		return -ENOMEM;
> +	}
>  
>  	/*
>  	 * vma->vm_start/vm_end cannot change under us because the caller
