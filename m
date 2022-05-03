Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00B51926B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiECXsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiECXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:48:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0EE05
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:45:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BC5FF1F38D;
        Tue,  3 May 2022 23:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651621514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/BREnaAXdAKe0vrIPYORr32m/YY/Iq3Nvp33ZXNrj8=;
        b=H7CUqco8iD8mefJQVMQjSB1rkfaBzCu+oUuGkvz1EFL5I82jqSkjOOctlUAFI8H7kyevBR
        F7+pEbGr9A+0+NlVlCjkY40XwiN2d2JgLtnVWVwUfzJpg+crySzvV6iJxQDg7eFmYjFY0I
        myprnhN8wxtnsiIxY8icA8om8z5ZqVM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F02352C141;
        Tue,  3 May 2022 23:45:13 +0000 (UTC)
Date:   Wed, 4 May 2022 01:45:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <YnG+h13Mh5b2qo5N@dhcp22.suse.cz>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
 <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-05-22 16:15:46, Suren Baghdasaryan wrote:
> On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
[...]
> > rcu_read_lock();
> > vma = vma_lookup();
> > if (down_read_trylock(&vma->sem)) {
> >         rcu_read_unlock();
> > } else {
> >         rcu_read_unlock();
> >         mmap_read_lock(mm);
> >         vma = vma_lookup();
> >         down_read(&vma->sem);
> > }
> >
> > ... and we then execute the page table allocation under the protection of
> > the vma->sem.
> >
> > At least, that's what I think we agreed to yesterday.
> 
> Honestly, I don't remember discussing vma->sem at all.

This is the rangelocking approach that is effectivelly per-VMA. So that
should help with the most simplistic case where the mmap contention is
not on the same VMAs which should be the most common case (e.g. faulting
from several threads while there is mmap happening in the background).

There are cases where this could be too coarse of course and RCU would
be a long term plan. The above seems easy enough and still probably good
enough for most cases so a good first step.
-- 
Michal Hocko
SUSE Labs
