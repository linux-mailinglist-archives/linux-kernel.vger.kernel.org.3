Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5174B002F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiBIW3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:29:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiBIW23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:28:29 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021BDC1DF65E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:28:31 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so2574501otf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ow76+gGSkaBY1EZZ1MFaphikeMi7h3bSFQ/+/XQlTq0=;
        b=lKOXkVrnz3eFiyfyLCV70oVZ2uqhUlhTnU3QFUzperRTSy4QZUoR4uPenX7xHTwNVI
         XMRpSC15xRvPOm6eJaXes0Krt4wXmHiX+aXgxqpTbkDaVSipu8EARSjH1pk7Xqn7+kR5
         ++RcXbkVSGaZv6GLcEoWPNK4+RWJBFTabSUAUrvPFwGUo2rtYXfWqdwZvPyw6PaYbNX5
         5LWJ5ebin3BSsLtzCorjoC78oCL1zbHNjlpI2/qZbD/y8i2KiQIaJ8q23t2Gx9DCpxHl
         LJkwNpbVGdpflZTg9raNp1gOz+c8JSkhI3TMpvKYL6k5H734BWeHbeuSGD8NxnZNEsKB
         85cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ow76+gGSkaBY1EZZ1MFaphikeMi7h3bSFQ/+/XQlTq0=;
        b=DaAPfb/Ceg1BpRXNWbcf2/7lFwU1lYdlVR/6muIvUUCopCVcEgRhL0DPSZ4HhzPj/4
         pyuecUd3CuCA8ozg6ozGHHh1koLWDUG0EiLV5hw1IXOeAEwnxT/dI3XT4/lDBtpbc8zL
         DliVY8Y3G5v66z7Pp6uwxTnylZaVBeFU1n6EVWns6gYeZXh9yXOGRkc3rxAJ4gQa5A25
         uWSODRJ539lgDr79PNMmXrRXlB9HJxoJIfSRKFwMxUxtlv3Oab3CQi4qDER+I0Y8ZtND
         M6+HrBX26r6vPUYYUdvRiXgI0wQoouwspMA82dNeBhRnTX2q+XoxiyaopAERMjROnxGe
         UTAQ==
X-Gm-Message-State: AOAM5336Wh60RMkvqUIee2LszA2H+EDmsqN37Qokj3xQ5rNDz6Xx2Fr7
        0bZMDBgq8jtf3Q1Yg4Rd+Sac5Q==
X-Google-Smtp-Source: ABdhPJzmBki7ktBHEFQa+yoDyLpAdLuMiGhYDC2N3odDv4pHXR1wMIGMYfAU6QZon5yqJeyuMqH2nw==
X-Received: by 2002:a9d:7856:: with SMTP id c22mr1887179otm.192.1644445710788;
        Wed, 09 Feb 2022 14:28:30 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e16sm7155029otr.11.2022.02.09.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:28:29 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:28:08 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/13] mm/munlock: delete page_mlock() and all its
 works
In-Reply-To: <4a5bc989-e59a-d421-faf4-8156f700ec99@suse.cz>
Message-ID: <ed2c4952-f3e-688d-40c1-53afebe5c7cb@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <5ed1f01-3e7e-7e26-cc1-2b7a574e2147@google.com> <4a5bc989-e59a-d421-faf4-8156f700ec99@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022, Vlastimil Babka wrote:
> On 2/6/22 22:30, Hugh Dickins wrote:
> 
> While I understand the reasons to clear the ground first, wonder what are
> the implications for bisectability - is there a risk of surprising failures?
> Maybe we should at least explicitly spell out the implications here?
> IIUC, pages that once become mlocked, will stay mlocked, implicating the
> Mlocked meminfo counter and inability to reclaim them. But if e.g. a process
> that did mlockall() exits, its exclusive pages will be freed anyway, so it's
> not a catastrophic kind of leak, right?

Thanks for taking a look, Vlastimil.  You make a good point here.

I had satisfied myself that no stage of the series was going to introduce
boot failures or BUGs; and if someone is bisecting some mlock/munlock
misbehaviour, I would not worry about which commit of the series they
alight on, but root cause it keeping all the patches in mind.

But we certainly wouldn't want the series split up into separately
submitted parts (that is, split anywhere between 01/13 and 07/13:
splitting the rest apart wouldn't matter much); and it would be
unfortunate if someone were bisecting some reclaim failure OOM problem
elsewhere, and their test app happened to be using mlock, and their
bisection landed part way between 01 and 07 here - the unimplemented
munlock confusing the bisection for OOM.

The worst of it would be, I think, landing between 05 and 07: where
your mlockall could mlock a variety of shared libraries etc, moving
all their pages to unevictable, and those pagecache pages not getting
moved back to evictable when unmapped.  I forget the current shrinker
situation, whether inode pressure could evict that pagecache or not.

Two mitigations come to mind, let me think on it some more (and hope
nobody's bisecting OOMs meanwhile): one might be to shift 05 (the one
which replaces clear_page_inode() on last unmap by clearance when
freeing) later in the series - its position was always somewhat
arbitrary, but that position is where it's been tested; another might
be to put nothing at all on the unevictable list in between 01 and 07.

Though taking this apart and putting it back together brings its own
dangers.  That second suggestion probably won't fly very well, with
06/13 using mlock_count only while on the unevictable.  I'm not sure
how much rethinking the bisection possibility deserves.

> Yet it differs from the existing "failure modes" where pages would be left
> as "stranded" due to failure of being isolated, because they would at least
> go through TestClearPageMlocked and counters update.
> 
> >  
> >  /*
> > @@ -413,75 +136,11 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
> >   *
> >   * Returns with VM_LOCKED cleared.  Callers must be prepared to
> >   * deal with this.
> > - *
> > - * We don't save and restore VM_LOCKED here because pages are
> > - * still on lru.  In unmap path, pages might be scanned by reclaim
> > - * and re-mlocked by page_mlock/try_to_unmap before we unmap and
> > - * free them.  This will result in freeing mlocked pages.
> >   */
> >  void munlock_vma_pages_range(struct vm_area_struct *vma,
> >  			     unsigned long start, unsigned long end)
> >  {
> > -	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
> 
> Should we at least keep doing the flags clearing? I haven't check if there
> are some VM_BUG_ONs that would trip on not cleared, but wouldn't be entirely
> surprised.

There are two flags in question here, VM_LOCKED and VM_LOCKONFAULT:
I'm not sure which of them you're particularly concerned about.

As to VM_LOCKED: yes, you're right, at this stage of the series the
munlock really ought to be clearing VM_LOCKED (even while it doesn't
go on to do anything about the pages), as it claims in the comment above.
I removed this line at a later stage (07/13), when changing it to
mlock_vma_pages_range() serving both mlock and munlock according to
whether VM_LOCKED is provided - and mistakenly folded back that deletion
to this patch.  End result the same, but better to restore that maskout
in this patch, as you suggest.

As to VM_LOCKONFAULT: I had checked the rest of mm/mlock.c, and the
rest of the tree, and it only ever reached here along with VM_LOCKED;
so when in 07/13 I switched over to "vma->vm_flags = newflags" (or
WRITE_ONCE equivalent), I just didn't see the need to mask it out in
the munlocking case; but could add a VM_BUG_ON that newflags never
has it without VM_LOCKED, if you like. 

(You'll say VM_WARN_ON_ONCE, I'll say VM_BUG_ON because it never happens,
then as soon as I put it in and run LTP or kselftests, I'll be ashamed
to discover I've got it wrong, perhaps.)

Hugh
