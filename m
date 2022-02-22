Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996404BF324
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBVIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBVIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:07:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A012A99
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:06:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B2E2D1F397;
        Tue, 22 Feb 2022 08:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645517192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehW6wfM086KZA+sOLiBbTPlkvEAXOt9X6KB2AN8WGwg=;
        b=mJ2iEOIeamqg8KzeTaG9JbEdw321KXbt+VC0mifrBnbxGVOsWGnGTmbijRuYVU7RPp6/Y4
        wzlKQSPSuYi3FgssR2Zwb68VEJ9j1psm0wZ74s3QRtHoUso7aeCSywpjHkwGARftb+W97K
        gSKvXn04/zhnA8aEheC/O6e3CIYdnK0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD582A3B87;
        Tue, 22 Feb 2022 08:06:31 +0000 (UTC)
Date:   Tue, 22 Feb 2022 09:06:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YhSZhzUYlW6IAQT9@dhcp22.suse.cz>
References: <20220222054025.3412898-1-surenb@google.com>
 <20220222054025.3412898-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222054025.3412898-3-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-02-22 21:40:25, Suren Baghdasaryan wrote:
> When adjacent vmas are being merged it can result in the vma that was
> originally passed to madvise_update_vma being destroyed.  In the current
> implementation, the name parameter passed to madvise_update_vma points
> directly to vma->anon_name->name and it is used after the call to
> vma_merge.  In the cases when vma_merge merges the original vma and
> destroys it, this will result in use-after-free bug as shown below:
> 
> madvise_vma_behavior << passes vma->anon_name->name as name param
>   madvise_update_vma(name)
>     vma_merge
>       __vma_adjust
>         vm_area_free <-- frees the vma
>     replace_vma_anon_name(name) <-- UAF

This seems to be stale because bare const char pointer is not passed in
the call chain. In fact I am not even sure there is any actual UAF here
after the rework.
Could you be more specific in describing the scenario?

> Fix this by raising the name refcount and stabilizing it.
> 
> Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
> ---
> changes in v3:
> - Reapplied the fix after code refactoring, per Michal Hocko
> 
>  mm/madvise.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a395884aeecb..00e8105430e9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -140,6 +140,8 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
>  /*
>   * Update the vm_flags on region of a vma, splitting it or merging it as
>   * necessary.  Must be called with mmap_sem held for writing;
> + * Caller should ensure anon_name stability by raising its refcount even when
> + * anon_name belongs to a valid vma because this function might free that vma.
>   */
>  static int madvise_update_vma(struct vm_area_struct *vma,
>  			      struct vm_area_struct **prev, unsigned long start,
> @@ -1021,8 +1023,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  	}
>  
>  	anon_name = vma_anon_name(vma);
> +	anon_vma_name_get(anon_name);
>  	error = madvise_update_vma(vma, prev, start, end, new_flags,
>  				   anon_name);
> +	anon_vma_name_put(anon_name);
>  
>  out:
>  	/*
> -- 
> 2.35.1.473.g83b2b277ed-goog

-- 
Michal Hocko
SUSE Labs
