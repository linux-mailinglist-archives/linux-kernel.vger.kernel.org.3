Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC514C266F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiBXImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiBXImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:42:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A891363
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:42:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AFB132114E;
        Thu, 24 Feb 2022 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645692132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8xBfceNBe4Yzgfbg7B0K0osO5apIfPg7Z+FN0VzNuA=;
        b=aiHMutdJS2iej3G/i7bAfS6bfOobP5V+v+6CCu0jO0F4TLtZ9FqA1hsGaodueamB5/vUQp
        AreNOTfOYoxS1j5jcQkr/XfxfzSPD8PdRUkdoxX+5hk2T9zLWn+ni9Vov6um74jnmvPkQM
        NxBJo/tzML0uxPnW9Mt+lXE4VGuLgFU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2AEA7A3B84;
        Thu, 24 Feb 2022 08:42:08 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:42:11 +0100
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
Subject: Re: [PATCH v2 2/3] mm: prevent vm_area_struct::anon_name refcount
 saturation
Message-ID: <YhdE4x3rpAqP2rjC@dhcp22.suse.cz>
References: <20220223153613.835563-1-surenb@google.com>
 <20220223153613.835563-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223153613.835563-2-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 07:36:12, Suren Baghdasaryan wrote:
> A deep process chain with many vmas could grow really high.
> With default sysctl_max_map_count (64k) and default pid_max (32k)
> the max number of vmas in the system is 2147450880 and the
> refcounter has headroom of 1073774592 before it reaches
> REFCOUNT_SATURATED (3221225472). Therefore it's unlikely that
> an anonymous name refcounter will overflow with these defaults.
> Currently the max for pid_max is PID_MAX_LIMIT (4194304) and
> for sysctl_max_map_count it's INT_MAX (2147483647). In this
> configuration anon_vma_name refcount overflow becomes
> theoretically possible (that still require heavy sharing of
> that anon_vma_name between processes).
> kref refcounting interface used in anon_vma_name structure will
> detect a counter overflow when it reaches REFCOUNT_SATURATED value
> but will only generate a warning about broken refcounter.

If I am reading the refcounter code properly the "overflow" will simply
make the ref counter frozen and the object will never be freed. A
determined attacker could leak memory like that but it would be rather
expensive and inefficient way to do so. Still good to have it covered.

> To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
> sharing when the refcount reaches REFCOUNT_MAX (2147483647), which
> still leaves INT_MAX/2 (1073741823) values before the counter reaches
> REFCOUNT_SATURATED. This should provide enough headroom for raising
> the refcounts temporarily.

I am not sure this is the intended way refcounter users should avoid
overflows but I do not see other interface that would be usable. Maybe
somebody else can come up with a better suggestion but this approach
makes sense to me.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> changes in v2:
> - Updated description to include calculation details, per Michal Hocko
> 
>  include/linux/mm_inline.h | 18 ++++++++++++++----
>  mm/madvise.c              |  3 +--
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 4bad32507570..f82085ff8a6b 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -161,15 +161,25 @@ static inline void anon_vma_name_put(struct anon_vma_name *anon_name)
>  		kref_put(&anon_name->kref, anon_vma_name_free);
>  }
>  
> +static inline
> +struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
> +{
> +	/* Prevent anon_name refcount saturation early on */
> +	if (kref_read(&anon_name->kref) < REFCOUNT_MAX) {
> +		anon_vma_name_get(anon_name);
> +		return anon_name;
> +
> +	}
> +	return anon_vma_name_alloc(anon_name->name);
> +}
> +
>  static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
>  				     struct vm_area_struct *new_vma)
>  {
>  	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
>  
> -	if (anon_name) {
> -		anon_vma_name_get(anon_name);
> -		new_vma->anon_name = anon_name;
> -	}
> +	if (anon_name)
> +		new_vma->anon_name = anon_vma_name_reuse(anon_name);
>  }
>  
>  static inline void free_anon_vma_name(struct vm_area_struct *vma)
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 081b1cded21e..1f2693dccf7b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -113,8 +113,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
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
