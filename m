Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D923520144
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiEIPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiEIPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C48511C352
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652110559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5IinSFbYgIpGW+C2tI1BnIe1xA/osRKfs/xAi+YC1Xo=;
        b=cQm5HlcqhYred6vRVaAq8FT25E6x9hzG17hxuadv0erWZ7i7DkGXV5E6V348ofgpTNgsp2
        1cksrQym0lG1HlHjqblGZDB8rp4ltZ5V0JdC7Xkvvz4bLDbwd2QeegGuwCmoemcBICwFTC
        F9i8JTgbOqMXSk6eNtyefJSbBJucTFc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70--MIBZkx-NzGTHOj4m1zVyg-1; Mon, 09 May 2022 11:35:56 -0400
X-MC-Unique: -MIBZkx-NzGTHOj4m1zVyg-1
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso10182947ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5IinSFbYgIpGW+C2tI1BnIe1xA/osRKfs/xAi+YC1Xo=;
        b=GhgKkOk08d+gLPHLV26C4cCaRwxOJScJ8uaDQd7T7SOqNMSyVCmruO1mMlUrAOS7eF
         wBjBX4/a5XduUJ6E56tHLrXeRUt3uMk9exCxw4udKKH8p5DKZlTuBL7UXis7qFbxkvNQ
         LCwn/1nj46Pf2YiPE6w9jD7wL6Q5Tss/U496r9vfAPaathT8NnbX3VCBjvHFQLKh2sZX
         DpUd4PXKxzyl1Ry2xFpYISGuTB1WFhtGQxi4085k40MJUX8Sm1FK8qS+JeWdgfroP5xp
         1ZB0Vr6YEDXi0Pp4DM1x9mXxqlt5+8zGOfMtJu2mYuWjZTRrQM1gRuYa1Pjviwv2sc6O
         GyVQ==
X-Gm-Message-State: AOAM530iHEo8bYIvZ46Wvdq/CHWL3R8cSdkk6NWaOb0L7B0ioYJB6Sqb
        oJFSzECB7fH2+ok2maMp6m1C5IpdKcaS/9HSexn4nugkqsFOgEA3tZlfGny6Su1EiBse/kHqjdo
        AMGfqiAhleGw7/ugpDVKzpL2p
X-Received: by 2002:a05:6602:2d0e:b0:64f:d1ff:ac9c with SMTP id c14-20020a0566022d0e00b0064fd1ffac9cmr7033924iow.41.1652110555882;
        Mon, 09 May 2022 08:35:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9QLULhbb34b5iihWpQAmLWw870QjWP3+bSlbZ5W3tvF7u/zlrKIlwnf+6kmosxcXnuyfBgw==
X-Received: by 2002:a05:6602:2d0e:b0:64f:d1ff:ac9c with SMTP id c14-20020a0566022d0e00b0064fd1ffac9cmr7033911iow.41.1652110555572;
        Mon, 09 May 2022 08:35:55 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id n13-20020a02c78d000000b0032b3a7817basm3672148jao.126.2022.05.09.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:35:54 -0700 (PDT)
Date:   Mon, 9 May 2022 11:35:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <Ynk02co/piCrs7iM@xz-m1.local>
References: <20220505211748.41127-1-peterx@redhat.com>
 <YnWEmsUwJt9KOUN0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnWEmsUwJt9KOUN0@cmpxchg.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Johannes,

On Fri, May 06, 2022 at 04:27:06PM -0400, Johannes Weiner wrote:
> On Thu, May 05, 2022 at 05:17:48PM -0400, Peter Xu wrote:
> > I observed that for each of the shared file-backed page faults, we're very
> > likely to retry one more time for the 1st write fault upon no page.  It's
> > because we'll need to release the mmap lock for dirty rate limit purpose
> > with balance_dirty_pages_ratelimited() (in fault_dirty_shared_page()).
> > 
> > Then after that throttling we return VM_FAULT_RETRY.
> > 
> > We did that probably because VM_FAULT_RETRY is the only way we can return
> > to the fault handler at that time telling it we've released the mmap lock.
> > 
> > However that's not ideal because it's very likely the fault does not need
> > to be retried at all since the pgtable was well installed before the
> > throttling, so the next continuous fault (including taking mmap read lock,
> > walk the pgtable, etc.) could be in most cases unnecessary.
> > 
> > It's not only slowing down page faults for shared file-backed, but also add
> > more mmap lock contention which is in most cases not needed at all.
> > 
> > To observe this, one could try to write to some shmem page and look at
> > "pgfault" value in /proc/vmstat, then we should expect 2 counts for each
> > shmem write simply because we retried, and vm event "pgfault" will capture
> > that.
> > 
> > To make it more efficient, add a new VM_FAULT_COMPLETED return code just to
> > show that we've completed the whole fault and released the lock.  It's also
> > a hint that we should very possibly not need another fault immediately on
> > this page because we've just completed it.
> > 
> > This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> > program sequentially dirtying 400MB shmem file being mmap()ed:
> > 
> >   Before: 650980.20 (+-1.94%)
> >   After:  569396.40 (+-1.38%)
> > 
> > I believe it could help more than that.
> > 
> > We need some special care on GUP and the s390 pgfault handler (for gmap
> > code before returning from pgfault), the rest changes in the page fault
> > handlers should be relatively straightforward.
> > 
> > Another thing to mention is that mm_account_fault() does take this new
> > fault as a generic fault to be accounted, unlike VM_FAULT_RETRY.
> > 
> > I explicitly didn't touch hmm_vma_fault() and break_ksm() because they do
> > not handle VM_FAULT_RETRY even with existing code, so I'm literally keeping
> > them as-is.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> The change makes sense to me, but the unlock/retry signaling is
> tricky...
> 
> > @@ -1227,6 +1247,18 @@ int fixup_user_fault(struct mm_struct *mm,
> >  		return -EINTR;
> >  
> >  	ret = handle_mm_fault(vma, address, fault_flags, NULL);
> > +
> > +	if (ret & VM_FAULT_COMPLETED) {
> > +		/*
> > +		 * NOTE: it's a pity that we need to retake the lock here
> > +		 * to pair with the unlock() in the callers. Ideally we
> > +		 * could tell the callers so they do not need to unlock.
> > +		 */
> > +		mmap_read_lock(mm);
> > +		*unlocked = true;
> > +		return 0;
> > +	}
> 
> unlocked can be NULL inside the function, yet you assume it's non-NULL
> here. This is okay because COMPLETED can only be returned if RETRY is
> set, and when RETRY is set unlocked must be non-NULL. It's correct but
> not very obvious.
> 
> It might be cleaner to have separate flags for ALLOW_RETRY and
> ALLOW_UNLOCK, with corresponding VM_FAULT_RETRY and VM_FAULT_UNLOCKED?
> Even if not all combinations are used.

I can do that, but note that I don't see a major difference even if we're
going to introduce ALLOW_UNLOCK.  IOW, afaict when we have ALLOW_RETRY then
we probably will also have ALLOW_UNLOCK, and vice versa. If that's the case
then it kind of loses the benefit of introducing a new flag.

What I want to achieve with this patch is to provide a variance of
VM_FAULT_RETRY.  I did it because VM_FAULT_RETRY actually contains more
than one meaning:

  (1) It means we have released the mmap_sem read lock, AND,
  (2) It needs the caller to retry one more time on the fault.

Here the tricky thing is (2) depends on (1) so when we have (2) we must
have (1).

However it's not the same the other way round: we could have (1) only but
without (2), just like what we're doing with fault_dirty_shared_page()
right now, where we may only want (1) but we're using (1+2) because we
don't have a retval that only contains (1).

So I see the new VM_FAULT_COMPLETED as a new variance of VM_FAULT_RETRY
just with condition (2) removed.

> 
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2942,7 +2942,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
> >  		balance_dirty_pages_ratelimited(mapping);
> >  		if (fpin) {
> >  			fput(fpin);
> > -			return VM_FAULT_RETRY;
> > +			return VM_FAULT_COMPLETED;
> 
> There is one oddity in this now.
> 
> It completes the fault and no longer triggers a retry. Yet it's still
> using maybe_unlock_mmap_for_io() and subject to retry limiting. This
> means that if the fault already retried once, this code won't drop the
> mmap_sem to call balance_dirty_pages() - even though it safely could
> and should do so, without risking endless retries.

This sounds like another change to me.  It's about whether we should
consider using maybe_unlock_mmap_for_io() even for after-first page faults
if it has retried already.

It looks good to me, but I don't know enough on the rate limiting code path
so I can't really provide anything more useful.  I do see quite a few other
callers of maybe_unlock_mmap_for_io() outside of this call site so we'll
want to analyze all of them to make a conclusion, IMHO.

What I can say is if one day we choose to do so then as long as fpin is set
then I think we can still safely return the VM_FAULT_COMPLETED here as long
as all the assumptions keep the same - firstly we released mmap_sem, then
we have finished the current page fault processing as a hint to be
delivered upward to the callers.

Thanks,

-- 
Peter Xu

