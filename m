Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E51526300
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381040AbiEMNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381016AbiEMNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:30:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB6455361
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652448628; x=1683984628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GbwRrmrBZu/Lv55WNBz8knNqDfcJ9KLX3FqKzwPPSmQ=;
  b=nZeLx+6RmtIgf1jL5wS+GxSYrYGHY746w+teU6ACdRTnySJCXxWsDHO5
   YyKgYBJwaN9SddCW5AeSA1nZ/l4IFaFs7Wl20JesmmOgTOQ0fGe3IbDDH
   ShqqGaF6dzh1kRRj9UUUmkML/wwjSsKaGX+qDD89TztYPxCn7/K6/G206
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 May 2022 06:30:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:30:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 06:30:26 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 06:30:26 -0700
Date:   Fri, 13 May 2022 09:30:22 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 67/69] mm: remove the vma linked list
Message-ID: <20220513133022.GA482@qian>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-52-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220504011345.662299-52-Liam.Howlett@oracle.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:14:07AM +0000, Liam Howlett wrote:
...
> @@ -2488,13 +2380,20 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
>  		    unsigned long end, struct list_head *uf, bool downgrade)
>  {
> -	struct vm_area_struct *prev, *last;
> +	struct vm_area_struct *prev, *next = NULL;
> +	struct maple_tree mt_detach;
> +	int count = 0;
>  	int error = -ENOMEM;
> -	/* we have start < vma->vm_end  */
> +	MA_STATE(mas_detach, &mt_detach, start, end - 1);
> +	mt_init_flags(&mt_detach, MM_MT_FLAGS);
> +	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
>  
>  	if (mas_preallocate(mas, vma, GFP_KERNEL))
>  		return -ENOMEM;
>  
> +	if (mas_preallocate(&mas_detach, vma, GFP_KERNEL))

This guy was reported as leaks as well.

unreferenced object 0xffff0802d49b5500 (size 256):
  comm "trinity-c22", pid 107245, jiffies 4295674711 (age 816.980s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
     kmem_cache_alloc
     mas_alloc_nodes
     mas_preallocate
     do_mas_align_munmap.constprop.0
     do_mas_align_munmap at mm/mmap.c:2384
     do_mas_munmap
     __vm_munmap
     __arm64_sys_munmap
     invoke_syscall
     el0_svc_common.constprop.0
     do_el0_svc
     el0_svc
     el0t_64_sync_handler
     el0t_64_sync

> +		return -ENOMEM;
> +
>  	mas->last = end - 1;
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
