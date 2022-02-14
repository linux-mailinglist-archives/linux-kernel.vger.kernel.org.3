Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C84B4D29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348749AbiBNKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:45:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349101AbiBNKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:44:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45419BC9D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:07:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00CAA210EC;
        Mon, 14 Feb 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644833223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+72dd9i2dKPgLkrK9l7LAsT6WmguVVk+/wOxv28xopg=;
        b=E5x2yLSgPfZyMGWvWNYQkuer+RuAcL54G2pyS/cQQS0/1V4mEfHsKv1rf2KCBB+AhEwpin
        gVqjWDokUVFXZQVeM9jOKWtfgD4lkXcXOBTQF60qnoLMbXLYVHQEdznnGV9anuG9pX6Ja/
        R1TQH7sI21yn+4LFF3ECaPhAH7umdvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644833223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+72dd9i2dKPgLkrK9l7LAsT6WmguVVk+/wOxv28xopg=;
        b=HJDw8vxtElWuZxUEz8sglubYXcadMkFL59Xzlh52RHBoOvXFz4E308F/eGKCzDskII2zOA
        bpKh+4crkPy0guCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A876B13A3C;
        Mon, 14 Feb 2022 10:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WnXkJsYpCmIROwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 14 Feb 2022 10:07:02 +0000
Message-ID: <b8037dbf-77de-43e9-31a0-f96a1e31727a@suse.cz>
Date:   Mon, 14 Feb 2022 11:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 01/13] mm/munlock: delete page_mlock() and all its
 works
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
 <4a5bc989-e59a-d421-faf4-8156f700ec99@suse.cz>
 <ed2c4952-f3e-688d-40c1-53afebe5c7cb@google.com>
 <957e2ea6-d01e-256f-51a0-d927a93b50a5@suse.cz>
 <eeee75ac-c888-6458-3438-24fe39adccae@google.com>
 <f795d6e9-f87b-c1d9-eb5a-561db0d7b9a@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f795d6e9-f87b-c1d9-eb5a-561db0d7b9a@google.com>
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

On 2/14/22 07:59, Hugh Dickins wrote:
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
> After this and each following commit, the kernel builds, boots and runs;
> but with deficiencies which may show up in testing of mlock and munlock.
> The system calls succeed or fail as before, and mlock remains effective
> in preventing page reclaim; but meminfo's Unevictable and Mlocked amounts
> may be shown too low after mlock, grow, then stay too high after munlock:
> with previously mlocked pages remaining unevictable for too long, until
> finally unmapped and freed and counts corrected. Normal service will be
> resumed in "mm/munlock: mlock_pte_range() when mlocking or munlocking".

Great!

> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

