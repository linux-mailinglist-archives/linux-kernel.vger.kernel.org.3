Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D14BF483
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiBVJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBVJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:17:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A06149B85
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:17:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F1CC41F399;
        Tue, 22 Feb 2022 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645521425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhOvZfGOGrjbPfhUhj9jbloPC8ssJktuoLOV8VfSkkM=;
        b=cmmHVuM6ZKpJd5Jt2yvNZ5BhR46fnCHamITtJlqBbPhCzsMPpwUzAJs0nWJncJKMJppEMc
        9QPGngkX9OUjXPvYGS20VkkIL51pH6k+dw3pTjKSwYnemZBZOKs1PtLWS/SWQCWMzR4bgP
        HNY5xVq6qk2ap5UFU7JYQBApNRHpiAA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1DE63A3B81;
        Tue, 22 Feb 2022 09:17:03 +0000 (UTC)
Date:   Tue, 22 Feb 2022 10:17:02 +0100
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
        kernel-team@android.com
Subject: Re: [PATCH 2/3] mm: prevent vm_area_struct::anon_name refcount
 saturation
Message-ID: <YhSqDvSTN7nbz4C9@dhcp22.suse.cz>
References: <20220222054025.3412898-1-surenb@google.com>
 <20220222054025.3412898-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222054025.3412898-2-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-02-22 21:40:24, Suren Baghdasaryan wrote:
> A deep process chain with many vmas could grow really high.

This would really benefit from some numbers. With default
sysctl_max_map_count (64k) and default pid_max (32k) the INT_MAX could
be theoretically reached but I find it impractical because not all vmas
can be anonymous same as all available pids can be consumed for a
theoretical attack (if my counting is proper).
On the other hand any non-default configuration with any of the values
increased could hit this theoretically.

> kref
> refcounting interface used in anon_vma_name structure will detect
> a counter overflow when it reaches REFCOUNT_SATURATED value but will
> only generate a warning about broken refcounting.
> To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
> sharing when the refcount reaches INT_MAX, which still leaves INT_MAX/2
> values before the counter reaches REFCOUNT_SATURATED. This should provide
> enough headroom for raising the refcounts temporarily.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm_inline.h | 18 ++++++++++++++----
>  mm/madvise.c              |  3 +--
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 70b619442d56..b189e2638843 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -156,15 +156,25 @@ static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
>  
>  extern void anon_vma_name_put(struct anon_vma_name *anon_name);
>  
> +static inline
> +struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
> +{
> +	/* Prevent anon_name refcount saturation early on */
> +	if (kref_read(&anon_name->kref) < INT_MAX) {

REFCOUNT_MAX seems to be defined by the kref framework.

Other than that looks good to me.

> +		anon_vma_name_get(anon_name);
> +		return anon_name;
> +
> +	}
> +	return anon_vma_name_alloc(anon_name->name);
> +}
> +
>  static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
>  				     struct vm_area_struct *new_vma)
>  {
>  	struct anon_vma_name *anon_name = vma_anon_name(orig_vma);
>  
> -	if (anon_name) {
> -		anon_vma_name_get(anon_name);
> -		new_vma->anon_name = anon_name;
> -	}
> +	if (anon_name)
> +		new_vma->anon_name = anon_vma_name_reuse(anon_name);
>  }
>  
>  static inline void free_vma_anon_name(struct vm_area_struct *vma)
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f81d62d8ce9b..a395884aeecb 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -122,8 +122,7 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
>  	if (anon_vma_name_eq(orig_name, anon_name))
>  		return 0;
>  
> -	anon_vma_name_get(anon_name);
> -	vma->anon_name = anon_name;
> +	vma->anon_name = anon_vma_name_reuse(anon_name);
>  	anon_vma_name_put(orig_name);
>  
>  	return 0;
> -- 
> 2.35.1.473.g83b2b277ed-goog

-- 
Michal Hocko
SUSE Labs
