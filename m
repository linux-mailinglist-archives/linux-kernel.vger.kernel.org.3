Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3472C4B0A03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiBJJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:52:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiBJJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:52:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E5E260
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:52:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 795FA1F39E;
        Thu, 10 Feb 2022 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644486752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6GJn+T84R1s3QqBKa+NtkToxwVpusGQeVmkWbu88iU=;
        b=pgS0N+5qo+bTJDY2+ExZLBoTQGzSf8xFR/qxENFs/HGpWqHkbu42fFgEDIehnNB6kiFTt8
        dY+osM7i42Jvm7wccQjr81pmy0tlFtJ2qWCQE0FU+A0WzJ9cMUb+mO/QaM/M3j63F2mtE4
        9MA2484/TZttw046gKPrvd4SLM9O4mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644486752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6GJn+T84R1s3QqBKa+NtkToxwVpusGQeVmkWbu88iU=;
        b=gooBhHaAkbfz22D/kJNhv/7mwHFFkQQBsPxACjaWouyHFyAoVPgP2QP5yzcIjqUf6g+puy
        p8PuWlluiqGK3JAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4472D13B35;
        Thu, 10 Feb 2022 09:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mHv5D2DgBGKoWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Feb 2022 09:52:32 +0000
Message-ID: <957e2ea6-d01e-256f-51a0-d927a93b50a5@suse.cz>
Date:   Thu, 10 Feb 2022 10:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <5ed1f01-3e7e-7e26-cc1-2b7a574e2147@google.com>
 <4a5bc989-e59a-d421-faf4-8156f700ec99@suse.cz>
 <ed2c4952-f3e-688d-40c1-53afebe5c7cb@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 01/13] mm/munlock: delete page_mlock() and all its works
In-Reply-To: <ed2c4952-f3e-688d-40c1-53afebe5c7cb@google.com>
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

On 2/9/22 23:28, Hugh Dickins wrote:
> On Wed, 9 Feb 2022, Vlastimil Babka wrote:
>> On 2/6/22 22:30, Hugh Dickins wrote:
> Thanks for taking a look, Vlastimil.  You make a good point here.
> 
> I had satisfied myself that no stage of the series was going to introduce
> boot failures or BUGs; and if someone is bisecting some mlock/munlock
> misbehaviour, I would not worry about which commit of the series they
> alight on, but root cause it keeping all the patches in mind.
> 
> But we certainly wouldn't want the series split up into separately
> submitted parts (that is, split anywhere between 01/13 and 07/13:
> splitting the rest apart wouldn't matter much); and it would be
> unfortunate if someone were bisecting some reclaim failure OOM problem
> elsewhere, and their test app happened to be using mlock, and their
> bisection landed part way between 01 and 07 here - the unimplemented
> munlock confusing the bisection for OOM.
> 
> The worst of it would be, I think, landing between 05 and 07: where
> your mlockall could mlock a variety of shared libraries etc, moving
> all their pages to unevictable, and those pagecache pages not getting
> moved back to evictable when unmapped.  I forget the current shrinker
> situation, whether inode pressure could evict that pagecache or not.
> 
> Two mitigations come to mind, let me think on it some more (and hope
> nobody's bisecting OOMs meanwhile): one might be to shift 05 (the one
> which replaces clear_page_inode() on last unmap by clearance when
> freeing) later in the series - its position was always somewhat
> arbitrary, but that position is where it's been tested; another might
> be to put nothing at all on the unevictable list in between 01 and 07.
> 
> Though taking this apart and putting it back together brings its own
> dangers.  That second suggestion probably won't fly very well, with
> 06/13 using mlock_count only while on the unevictable.  I'm not sure
> how much rethinking the bisection possibility deserves.

Right, if it's impractical to change for a potential and hopefully unlikely
bad bisection luck, just a note at the end of each patch's changelog
mentioning what temporarily doesn't work, should be enough.

>> Yet it differs from the existing "failure modes" where pages would be left
>> as "stranded" due to failure of being isolated, because they would at least
>> go through TestClearPageMlocked and counters update.
>> 
>> >  
>> >  /*
>> > @@ -413,75 +136,11 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
>> >   *
>> >   * Returns with VM_LOCKED cleared.  Callers must be prepared to
>> >   * deal with this.
>> > - *
>> > - * We don't save and restore VM_LOCKED here because pages are
>> > - * still on lru.  In unmap path, pages might be scanned by reclaim
>> > - * and re-mlocked by page_mlock/try_to_unmap before we unmap and
>> > - * free them.  This will result in freeing mlocked pages.
>> >   */
>> >  void munlock_vma_pages_range(struct vm_area_struct *vma,
>> >  			     unsigned long start, unsigned long end)
>> >  {
>> > -	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
>> 
>> Should we at least keep doing the flags clearing? I haven't check if there
>> are some VM_BUG_ONs that would trip on not cleared, but wouldn't be entirely
>> surprised.
> 
> There are two flags in question here, VM_LOCKED and VM_LOCKONFAULT:
> I'm not sure which of them you're particularly concerned about.

Well, either of those, but I said I didn't dig for possible consequences as
simply not removing line above looked simpler and matched the comment.

> As to VM_LOCKED: yes, you're right, at this stage of the series the
> munlock really ought to be clearing VM_LOCKED (even while it doesn't
> go on to do anything about the pages), as it claims in the comment above.
> I removed this line at a later stage (07/13), when changing it to
> mlock_vma_pages_range() serving both mlock and munlock according to
> whether VM_LOCKED is provided - and mistakenly folded back that deletion
> to this patch.  End result the same, but better to restore that maskout
> in this patch, as you suggest.

Great, thanks. That restores any effect on VM_LOCKONFAULT in any case as well.

> As to VM_LOCKONFAULT: I had checked the rest of mm/mlock.c, and the
> rest of the tree, and it only ever reached here along with VM_LOCKED;
> so when in 07/13 I switched over to "vma->vm_flags = newflags" (or
> WRITE_ONCE equivalent), I just didn't see the need to mask it out in
> the munlocking case; but could add a VM_BUG_ON that newflags never
> has it without VM_LOCKED, if you like. 
> 
> (You'll say VM_WARN_ON_ONCE, I'll say VM_BUG_ON because it never happens,
> then as soon as I put it in and run LTP or kselftests, I'll be ashamed
> to discover I've got it wrong, perhaps.)

Wasn't suggesting new VM_BUG_ONs just worried if the patch were breaking any
existing ones.

> Hugh

