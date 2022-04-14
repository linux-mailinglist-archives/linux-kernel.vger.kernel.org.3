Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3532950066F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDNGxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiDNGxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FDC488B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 23:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA5661EAD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422DFC385A7;
        Thu, 14 Apr 2022 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649919070;
        bh=JkilULHevFIfJrxY8jNAk6p2FJfGE3znPacyac70Oy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iFmSLkrvAI2ASG47Ak9njvHuM5LsHUGkJvl59/qtFaWftlxK291CEAP5Pop76HOPj
         FkpEJzAHyuI3SUtYmboh1zj1uH/ySfZRow+qCkCh6qUt4eL4gJPIQM/rH3yE/lhvqJ
         gjl1HY+JOrQvj81Req4Q2ElZl2mYu2fAVJmYvV5w=
Date:   Wed, 13 Apr 2022 23:51:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 26/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Message-Id: <20220413235109.132da02b3c2a883332ada39c@linux-foundation.org>
In-Reply-To: <20220404143501.2016403-27-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
        <20220404143501.2016403-27-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 14:35:43 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Changing mmap_region() to use the maple tree state and the advanced
> maple tree interface allows for a lot less tree walking.
> 
> This change removes the last caller of munmap_vma_range(), so drop this
> unused function.
> 
> Add vma_expand() to expand a VMA if possible by doing the necessary
> hugepage check, uprobe_munmap of files, dcache flush, modifications then
> undoing the detaches, etc.
> 

Merging this with Yang Shi's "mm: mmap: register suitable readonly file
vmas for khugepaged"
(https://lkml.kernel.org/r/20220404200250.321455-9-shy828301@gmail.com)

> ...
>
> @@ -1741,13 +1868,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			goto free_vma;
>  	}
>  
> -	vma_link(mm, vma, prev);
> +	if (vma->vm_file)
> +		i_mmap_lock_write(vma->vm_file->f_mapping);
> +
> +	vma_mas_store(vma, &mas);
> +	__vma_link_list(mm, vma, prev);
> +	mm->map_count++;
> +	if (vma->vm_file) {
> +		if (vma->vm_flags & VM_SHARED)
> +			mapping_allow_writable(vma->vm_file->f_mapping);
> +
> +		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
> +		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
> +		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	}
> +
>  	/* Once vma denies write, undo our temporary denial count */
>  unmap_writable:
>  	if (file && vm_flags & VM_SHARED)
>  		mapping_unmap_writable(file->f_mapping);

I'm unsure whether this hunk should be inside or outside the call to
the cheerfully undocumented khugepaged_enter_vma()?


Code snippet as I presently have it:

	if (vma->vm_file)
		i_mmap_lock_write(vma->vm_file->f_mapping);

	vma_mas_store(vma, &mas);
	mm->map_count++;
	if (vma->vm_file) {
		if (vma->vm_flags & VM_SHARED)
			mapping_allow_writable(vma->vm_file->f_mapping);

		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
		i_mmap_unlock_write(vma->vm_file->f_mapping);
	}

	/*
	 * vma_merge() calls khugepaged_enter_vma() either, the below
	 * call covers the non-merge case.
	 */
	khugepaged_enter_vma(vma, vma->vm_flags);

	/* Once vma denies write, undo our temporary denial count */
unmap_writable:
	if (file && vm_flags & VM_SHARED)
		mapping_unmap_writable(file->f_mapping);

btw, "vma_merge() calls khugepaged_enter_vma() either" isn't
understandable.  Should that be "also"?
