Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1614C2690
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiBXIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiBXIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:46:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9116040C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:45:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9AE3721155;
        Thu, 24 Feb 2022 08:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645692335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m54wP8QDH9xsCu8tvqikfzHGy3YusnIQ1dTaWJQjT18=;
        b=fG3w9T8oaJOm3aWcAp6tCn+DBj+sv9XOBoMBEW/P3HUkdeJNjvOc44CyTyffx1WBCV5vxZ
        fZrlrv97q4u6vBDfPifrp4qrNthvpUMRoaHnd8m8yvinraCHWd2JA4UuO10h1QcqtycHeS
        ybhxNb8Jp6EO6XPm6kgWhqCRETSYBCs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 33888A3B84;
        Thu, 24 Feb 2022 08:45:31 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:45:34 +0100
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
Subject: Re: [PATCH v5 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YhdFrgL8jkTsFi/A@dhcp22.suse.cz>
References: <20220223153613.835563-1-surenb@google.com>
 <20220223153613.835563-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223153613.835563-3-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 07:36:13, Suren Baghdasaryan wrote:
> When adjacent vmas are being merged it can result in the vma that was
> originally passed to madvise_update_vma being destroyed.  In the current
> implementation, the name parameter passed to madvise_update_vma points
> directly to vma->anon_name and it is used after the call to
> vma_merge.  In the cases when vma_merge merges the original vma and
> destroys it, this will result in use-after-free bug as shown below:

Not that I want to nit pick on the wording here because destruction of
the original vma will not result in UAF automatically. For that it would
need to hold anon_vma_name with the last reference. So I would
reformulate:
"In cases when vma_merge merges the original vma and destroys it, it
might result in UAF. For that the original vma would have to hold the
anon_vma_name with the last reference. The following vma would need to
contain a different anon_vma_name object with the same string.

> madvise_vma_behavior(vma)
>   madvise_update_vma(vma, ..., anon_name == vma->anon_name)
>     vma_merge(vma)
>       __vma_adjust(vma) <-- merges vma with adjacent one
>         vm_area_free(vma) <-- frees the original vma
>     replace_vma_anon_name(anon_name) <-- UAF of vma->anon_name
> 
> Fix this by raising the name refcount and stabilizing it.
> 
> Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> changes in v5:
> - Updated description, per Michal Hocko
> 
>  mm/madvise.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 1f2693dccf7b..38d0f515d548 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -131,6 +131,8 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
>  /*
>   * Update the vm_flags on region of a vma, splitting it or merging it as
>   * necessary.  Must be called with mmap_sem held for writing;
> + * Caller should ensure anon_name stability by raising its refcount even when
> + * anon_name belongs to a valid vma because this function might free that vma.
>   */
>  static int madvise_update_vma(struct vm_area_struct *vma,
>  			      struct vm_area_struct **prev, unsigned long start,
> @@ -945,6 +947,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  				unsigned long behavior)
>  {
>  	int error;
> +	struct anon_vma_name *anon_name;
>  	unsigned long new_flags = vma->vm_flags;
>  
>  	switch (behavior) {
> @@ -1010,8 +1013,11 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  		break;
>  	}
>  
> +	anon_name = anon_vma_name(vma);
> +	anon_vma_name_get(anon_name);
>  	error = madvise_update_vma(vma, prev, start, end, new_flags,
> -				   anon_vma_name(vma));
> +				   anon_name);
> +	anon_vma_name_put(anon_name);
>  
>  out:
>  	/*
> -- 
> 2.35.1.473.g83b2b277ed-goog

-- 
Michal Hocko
SUSE Labs
