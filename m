Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD0157A774
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiGSTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiGSTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:52:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD2252DD4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:52:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f11so12941466plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hz6RNQpYNLS/y0QYmC1fYMnpSS2GeTHzolaO2NiULnw=;
        b=DODJtFbxBiF70MVS7GwSLYSzSQ/DwBmYNe09upT7h3SL5NkF9Ob3moqtNqdswbZZQg
         k9iJm9ZUVvT1G3ppPOzN/0sfNjH1S1Q3VrbrHmYinzMBXYo2BmJJQ8bz+uXT7/68DBc1
         kcZuS7UaGdF4czgi9mCTw1xQfgu75ftUEv3OhaB+B+oKH9UI80FzJ5joDzAlUa2+gPrG
         UGg0GwcCObas/Kvy1e1oFp6/Pvnptt90ZpkuOwPF9Gy9cCFaBp3i+pyxVmuN7/QFFw0g
         jQ5U8vZsK4z6qtOOZ8N86lHw0khgsSQd2pRuuVh5JlNHgw3X262KSk/iZmhos+TGUWB9
         0q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hz6RNQpYNLS/y0QYmC1fYMnpSS2GeTHzolaO2NiULnw=;
        b=AaUev3hGEFk8EZUDuVvtUbIyHTtlrgnMCZBXRezl2h6FgW1/Abw7PH4OkEvDuoeLr1
         wgtWMPnbaG7xeSzHceG9ieE6WUbokUiD6fNMIud7kbt8tqzwRrm9kFRGmV+PczY6rjws
         IcZ89qejmK1TKK+fmZPIhBGOK9XbzMiEoaamewc/yHblBkjqX+gShQYlzmZYG1JZQpXI
         3Xk0uWmKygyIENEt508XVY61EbEPTylDF9wlA5XZGSgeWhRvoO3xbUJpr38eOCRvvMqH
         3Etd9VFo+Anu4H4bdrbMRdkgNX2qE5vbAFREZUZdQ7iamm5xLXHJadkx2Q4D9s5gcgpI
         czyQ==
X-Gm-Message-State: AJIora9zX12+un3xIROYim0MjHwLcYtuIYBxjTaMhigtqpE4ThuKsDII
        a63FfkhvAyamjYSrFDMZYhvSBA==
X-Google-Smtp-Source: AGRyM1sCqZ/94OQrbc0VgK56E56KNgWWZx1A4Pgtq3cUZmmExP5j/ftqtQSDwD4QwF/Q+29f/enmwg==
X-Received: by 2002:a17:902:74cc:b0:16c:6435:8cac with SMTP id f12-20020a17090274cc00b0016c64358cacmr35637780plt.98.1658260364781;
        Tue, 19 Jul 2022 12:52:44 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id t187-20020a625fc4000000b0052ab8a92496sm11461198pfb.168.2022.07.19.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:52:44 -0700 (PDT)
Date:   Tue, 19 Jul 2022 19:52:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 05/12] KVM: X86/MMU: Clear unsync bit directly in
 __mmu_unsync_walk()
Message-ID: <YtcLiNskPb8z/2Qc@google.com>
References: <20220605064342.309219-1-jiangshanlai@gmail.com>
 <20220605064342.309219-6-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605064342.309219-6-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> mmu_unsync_walk() and __mmu_unsync_walk() requires the caller to clear
> unsync for the shadow pages in the resulted pvec by synching them or
> zapping them.
> 
> All callers does so.
> 
> Otherwise mmu_unsync_walk() and __mmu_unsync_walk() can't work because
> they always walk from the beginning.
> 
> It is possible to make mmu_unsync_walk() and __mmu_unsync_walk() lists
> unsync shadow pages in the resulted pvec without needing synching them
> or zapping them later.  It would require to change mmu_unsync_walk()
> and __mmu_unsync_walk() and make it walk from the last visited position
> derived from the resulted pvec of the previous call of mmu_unsync_walk().
> 
> It would complicate the walk and no callers require the possible new
> behavior.
> 
> It is better to keep the original behavior.
> 
> Since the shadow pages in the resulted pvec will be synced or zapped,
> and clear_unsync_child_bit() for parents will be called anyway later.
> 
> Call clear_unsync_child_bit() earlier and directly in __mmu_unsync_walk()
> to make the code more efficient (the memory of the shadow pages is hot
> in the CPU cache, and no need to visit the shadow pages again later).

The changelog and shortlog do a poor job of capturing what this patch actually
does.  This is a prime example of why I prefer that changelogs first document
what the patch is doing, and only then dive into background details and alternatives.

This changelog has 6-7 paragraphs talking about current KVM behaviors and
alternatives before talking about the patch itself, and then doesn't actually
describe the net effect of the change.

The use of "directly" in the shortlog is also confusing because __mmu_unsync_walk()
already invokes clear_unsync_child_bit(), e.g. this patch only affects
__mmu_unsync_walk().  IIUC, the change is that __mmu_unsync_walk() will clear
the unsync info when adding to @pvec instead of having to redo the walk after
zapping/synching the page.

  KVM: x86/mmu: Clear unsync child _before_ final zap/sync

  Clear the unsync child information for a shadow page when adding it to
  the array of to-be-zapped/synced shadow pages, i.e. _before_ the actual
  zap/sync that effects the "no longer unsync" state change.  Callers of
  mmu_unsync_walk() and __mmu_unsync_walk() are required to zap/sync all
  entries in @pvec before dropping mmu_lock, i.e. once a shadow page is
  added to the set of pages to zap/sync, success is guaranteed.

  Clearing the unsync info when adding to the array yields more efficient
  code as KVM will no longer need to rewalk the shadow pages to "discover"
  that the child   pages is no longer unsync, and as a bonus, the metadata
  for the shadow   page will be hot in the CPU cache.

  Note, this obviously doesn't work if success isn't guaranteed, but
  mmu_unsync_walk() and __mmu_unsync_walk() would require significant
  changes to allow restarting a walk after failure to zap/sync.  I.e.
  this is but one of many details that would need to change.

> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f35fd5c59c38..2446ede0b7b9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1794,19 +1794,23 @@ static int __mmu_unsync_walk(struct kvm_mmu_page *sp,
>  				return -ENOSPC;
>  
>  			ret = __mmu_unsync_walk(child, pvec);
> -			if (!ret) {
> -				clear_unsync_child_bit(sp, i);
> -				continue;
> -			} else if (ret > 0) {
> -				nr_unsync_leaf += ret;
> -			} else
> +			if (ret < 0)
>  				return ret;
> -		} else if (child->unsync) {
> +			nr_unsync_leaf += ret;
> +		}
> +
> +		/*
> +		 * Clear unsync bit for @child directly if @child is fully
> +		 * walked and all the unsync shadow pages descended from
> +		 * @child (including itself) are added into @pvec, the caller
> +		 * must sync or zap all the unsync shadow pages in @pvec.
> +		 */
> +		clear_unsync_child_bit(sp, i);
> +		if (child->unsync) {
>  			nr_unsync_leaf++;
>  			if (mmu_pages_add(pvec, child, i))

This ordering is wrong, no?  If the child itself is unsync and can't be added to
@pvec, i.e. fails here, then clearing its bit in unsync_child_bitmap is wrong.

I also dislike that that this patch obfuscates that a shadow page can't be unsync
itself _and_ have unsync children (because only PG_LEVEL_4K can be unsync).  In
other words, keep the

	if (child->unsync_children) {

	} else if (child->unsync) {

	}

And at that point, we can streamline this further:

	int i, ret, nr_unsync_leaf = 0;

	for_each_set_bit(i, sp->unsync_child_bitmap, 512) {
		struct kvm_mmu_page *child;
		u64 ent = sp->spt[i];

		if (is_shadow_present_pte(ent) && !is_large_pte(ent)) {
			child = to_shadow_page(ent & PT64_BASE_ADDR_MASK);
			if (child->unsync_children) {
				ret = __mmu_unsync_walk_and_clear(child, pvec);
				if (ret < 0)
					return ret;
				nr_unsync_leaf += ret;
			} else if (child->unsync) {
				if (mmu_pages_add(pvec, child))
					return -ENOSPC;
				nr_unsync_leaf++;
			}
		}

		/*
		 * Clear the unsync info, the child is either already sync
		 * (bitmap is stale) or is guaranteed to be zapped/synced by
		 * the caller before mmu_lock is released.  Note, the caller is
		 * required to zap/sync all entries in @pvec even if an error
		 * is returned!
		 */
		clear_unsync_child_bit(sp, i);
	}

	return nr_unsync_leaf;
