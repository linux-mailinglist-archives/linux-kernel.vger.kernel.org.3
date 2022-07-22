Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353ED57E291
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiGVNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiGVNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD8F074DD9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658497906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NA/icI4SGPUsAzJtXWUBBRXNCfBWprjzwJ+ZmvXATQQ=;
        b=h8pZ4ebe8npqZeVGZdaObCHU6LVfXFlg3+RN6o2lUP4eznFzm5qFnC/wsjdlbxiuaD+nHX
        bBd9r9udjZuSYRfQuwN0DDJUfbhnwxwMHBTB4WG+RZaG86HB5GO3ZLK9wyH2KM1P9Qd18J
        NtbndHEYMlaNV8kFB96Az0xdFyIgPc8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-II6iXlPzPwKGpBvjhmq-rQ-1; Fri, 22 Jul 2022 09:51:45 -0400
X-MC-Unique: II6iXlPzPwKGpBvjhmq-rQ-1
Received: by mail-qv1-f71.google.com with SMTP id lp7-20020a056214590700b004733d9feaf6so3065561qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NA/icI4SGPUsAzJtXWUBBRXNCfBWprjzwJ+ZmvXATQQ=;
        b=eMJPl6cr2cwPd1nNlN6Ojn8/mrTc/pRoJa1Fx0WzYvxmfu20EmMAcpw4CE5w+vlHQb
         atSrlyThWuv71QuyeiFDGL3MiOPRuLpbQTIHvuEq4v1JWlnjnI6t7c6iVM4XB+f+E4Lk
         8roqutAfmN4Js6ATpeJN8l5eOzCUJi3pXZ7sKwzbLAvfLMtBLcMW4tQqarU3ic++SKPq
         x69yGW0YNJOOeI5SbzhGPJiWAJ8b0jnd586TyTcZsSx32npWcbwPWS0nl76rr3l8y9fo
         ZI7z1Xj+E8QAQNXuHmtpbGGI8SZip7bpe64y+aMrVDEx52s0fDvfc8ZCWcWP9a5CkoPn
         9cKA==
X-Gm-Message-State: AJIora+SAzAa8RjNrhl5hGsbL7dwHASz3dNU/AvDWYQs02beQci7P8uS
        VTWldOXXfBw5s62wogOKEmExh6m3OR9JD0MkIOfFcae41BTH7RWZBuHck51uddHYtghofFV0c5U
        HLcQxyCS86Ftq+c73Pg9n/osA
X-Received: by 2002:a05:622a:1308:b0:31e:f8fd:5366 with SMTP id v8-20020a05622a130800b0031ef8fd5366mr95624qtk.387.1658497905285;
        Fri, 22 Jul 2022 06:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQNMEVj5gQNfhym5zCEbYFG/gOOUlew9W3SgLJHiWDxgOLaddfFp36LG4rHCSPtgn2qmC4Bw==
X-Received: by 2002:a05:622a:1308:b0:31e:f8fd:5366 with SMTP id v8-20020a05622a130800b0031ef8fd5366mr95613qtk.387.1658497905025;
        Fri, 22 Jul 2022 06:51:45 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id fw8-20020a05622a4a8800b0031eb643c0f5sm3007707qtb.94.2022.07.22.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:51:44 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:51:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Ytqrb0ffgs+tA+0n@xz-m1.local>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-2-peterx@redhat.com>
 <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 09:08:59AM +0200, David Hildenbrand wrote:
> On 21.07.22 20:33, Peter Xu wrote:
> > The check wanted to make sure when soft-dirty tracking is enabled we won't
> > grant write bit by accident, as a page fault is needed for dirty tracking.
> > The intention is correct but we didn't check it right because VM_SOFTDIRTY
> > set actually means soft-dirty tracking disabled.  Fix it.
> > 
> > There's another thing tricky about soft-dirty is that, we can't check the
> > vma flag !(vma_flags & VM_SOFTDIRTY) directly but only check it after we
> > checked CONFIG_MEM_SOFT_DIRTY because otherwise VM_SOFTDIRTY will be
> > defined as zero, and !(vma_flags & VM_SOFTDIRTY) will constantly return
> > true.  To avoid misuse, introduce a helper for checking whether vma has
> > soft-dirty tracking enabled.
> > 
> 
> 
> [...]
> 
> > 
> > Here we attach a Fixes to commit 64fe24a3e05e only for easy tracking, as
> > this patch won't apply to a tree before that point.  However the commit
> > wasn't the source of problem, it's just that then anonymous memory will
> > also suffer from this problem with mprotect().
> 
> I'd remove that paragraph and also add
> 
> Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs after VM_SOFTDIRTY cleared")
> 
> That introduced this wrong check for pagecache pages AFAIKS.
> 
> We don't care if the patch applies before 64fe24a3e05e, if someone wants to
> backport the fix, they can just adjust it accordingly.

IMO besides marking the culprit commit, Fixes can also provide input to
stable trees to see whether we should try pick some patch up.  What I
wanted to express here is we don't need to try pick this patch up before
kernel that doesn't have 64fe24a3e05e because it won't apply.

I can attach both Fixes with the hope that it'll help in both cases if
you're fine with it, with slight explanations.

> 
> > 
> > Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/internal.h | 18 ++++++++++++++++++
> >  mm/mmap.c     |  2 +-
> >  mm/mprotect.c |  2 +-
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 15e8cb118832..e2d442e3c0b2 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -860,4 +860,22 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
> >  
> >  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> >  
> > +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> > +{
> > +	/*
> > +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> > +	 * enablements, because when without soft-dirty being compiled in,
> > +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> > +	 * will be constantly true.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +		return false;
> > +
> > +	/*
> > +	 * Soft-dirty is kind of special: its tracking is enabled when the
> > +	 * vma flags not set.
> > +	 */
> > +	return !(vma->vm_flags & VM_SOFTDIRTY);
> > +}
> 
> That will come in handy in other patches I'm cooking.
> 
> > +
> >  #endif	/* __MM_INTERNAL_H */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 125e8903c93c..93f9913409ea 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1518,7 +1518,7 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
> >  		return 0;
> >  
> >  	/* Do we need to track softdirty? */
> > -	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !(vm_flags & VM_SOFTDIRTY))
> > +	if (vma_soft_dirty_enabled(vma))
> >  		return 1;
> >  
> >  	/* Specialty mapping? */
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 0420c3ed936c..c403e84129d4 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -49,7 +49,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
> >  		return false;
> >  
> >  	/* Do we need write faults for softdirty tracking? */
> > -	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> > +	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
> >  		return false;
> >  
> >  	/* Do we need write faults for uffd-wp tracking? */
> 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu

