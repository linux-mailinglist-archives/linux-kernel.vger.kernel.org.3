Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7A4AF9F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiBISb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbiBISb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:31:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DA4C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:31:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F09921107;
        Wed,  9 Feb 2022 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644431487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMhn/foFlPWj85JoD23YnerTlqudGiH7pAqZto4fg9U=;
        b=etFlE1JMkGGbKv6nzsqVSgDCVnS9qgV4AWmz7Ytysy6AI87OYRQRRVglIx+dT0UmrhSIgA
        jIsCL3X8Y/X/RyxIFEjxb/JHu5iL7IyaoKdjD9TpoDzV5SxEp4FjhQGzmQafM0WRPmvBmO
        pbfq7R1on05QzcyFoT8JQsyNZRRAmTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644431487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMhn/foFlPWj85JoD23YnerTlqudGiH7pAqZto4fg9U=;
        b=b2s2T20o/OE+G6C6c8NfWnD9vV2puA8DZ6pxtfEH73W3va/RzzB5l0LBsZxcsZQPXKSe9C
        XCa8hkkFCG+IYuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58AE613D93;
        Wed,  9 Feb 2022 18:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6uHxFH8IBGLqZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Feb 2022 18:31:27 +0000
Message-ID: <4a5bc989-e59a-d421-faf4-8156f700ec99@suse.cz>
Date:   Wed, 9 Feb 2022 19:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
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
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <5ed1f01-3e7e-7e26-cc1-2b7a574e2147@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 01/13] mm/munlock: delete page_mlock() and all its works
In-Reply-To: <5ed1f01-3e7e-7e26-cc1-2b7a574e2147@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/22 22:30, Hugh Dickins wrote:
> We have recommended some applications to mlock their userspace, but that
> turns out to be counter-productive: when many processes mlock the same
> file, contention on rmap's i_mmap_rwsem can become intolerable at exit: it
> is needed for write, to remove any vma mapping that file from rmap's tree;
> but hogged for read by those with mlocks calling page_mlock() (formerly
> known as try_to_munlock()) on *each* page mapped from the file (the
> purpose being to find out whether another process has the page mlocked,
> so therefore it should not be unmlocked yet).
> 
> Several optimizations have been made in the past: one is to skip
> page_mlock() when mapcount tells that nothing else has this page
> mapped; but that doesn't help at all when others do have it mapped.
> This time around, I initially intended to add a preliminary search
> of the rmap tree for overlapping VM_LOCKED ranges; but that gets
> messy with locking order, when in doubt whether a page is actually
> present; and risks adding even more contention on the i_mmap_rwsem.
> 
> A solution would be much easier, if only there were space in struct page
> for an mlock_count... but actually, most of the time, there is space for
> it - an mlocked page spends most of its life on an unevictable LRU, but
> since 3.18 removed the scan_unevictable_pages sysctl, that "LRU" has
> been redundant.  Let's try to reuse its page->lru.
> 
> But leave that until a later patch: in this patch, clear the ground by
> removing page_mlock(), and all the infrastructure that has gathered
> around it - which mostly hinders understanding, and will make reviewing
> new additions harder.  Don't mind those old comments about THPs, they
> date from before 4.5's refcounting rework: splitting is not a risk here.
> 
> Just keep a minimal version of munlock_vma_page(), as reminder of what it
> should attend to (in particular, the odd way PGSTRANDED is counted out of
> PGMUNLOCKED), and likewise a stub for munlock_vma_pages_range().  Move
> unchanged __mlock_posix_error_return() out of the way, down to above its
> caller: this series then makes no further change after mlock_fixup().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

While I understand the reasons to clear the ground first, wonder what are
the implications for bisectability - is there a risk of surprising failures?
Maybe we should at least explicitly spell out the implications here?
IIUC, pages that once become mlocked, will stay mlocked, implicating the
Mlocked meminfo counter and inability to reclaim them. But if e.g. a process
that did mlockall() exits, its exclusive pages will be freed anyway, so it's
not a catastrophic kind of leak, right?
Yet it differs from the existing "failure modes" where pages would be left
as "stranded" due to failure of being isolated, because they would at least
go through TestClearPageMlocked and counters update.

>  
>  /*
> @@ -413,75 +136,11 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
>   *
>   * Returns with VM_LOCKED cleared.  Callers must be prepared to
>   * deal with this.
> - *
> - * We don't save and restore VM_LOCKED here because pages are
> - * still on lru.  In unmap path, pages might be scanned by reclaim
> - * and re-mlocked by page_mlock/try_to_unmap before we unmap and
> - * free them.  This will result in freeing mlocked pages.
>   */
>  void munlock_vma_pages_range(struct vm_area_struct *vma,
>  			     unsigned long start, unsigned long end)
>  {
> -	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;

Should we at least keep doing the flags clearing? I haven't check if there
are some VM_BUG_ONs that would trip on not cleared, but wouldn't be entirely
surprised.
