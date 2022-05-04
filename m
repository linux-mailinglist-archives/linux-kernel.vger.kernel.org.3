Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9075192C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiEDAZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEDAZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:25:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF681A82A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O9G1qrUxw1PUAFie3r2pKVbuy912ttPIKqSliuy3hqI=; b=CvTyp1RECeiQcAhqLPk6rFarqA
        VDJQokGACKdmRSDMQ1F9R8ObmkgL2d2mKwY2gweujJe1+Onf24wrdJvtB8j8cGf6ICLmKvQVuhvJ4
        w2ZTVhJLNztpbH5T9Pwq6oIFByReq0c8ebsnwro9sR1BPcRQRyLWB92oQd8ZJfgSA1EQOuUWWlG7I
        00MlU6T/ZwnOAzbnJsylRynmHhTe1fvO4YtOIF+hotZ5y0vDnEzeftkpvcDaHqtuiWuUKzEQKvdTu
        aplp0oQCN9q3SouH8R9X1JlupOsM8L3NmrihcoiruIpGq54f0oH+DBKxy9tJwaAgEGIYQexh1G+Ap
        dZqoN9hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm2mI-00G50A-Qf; Wed, 04 May 2022 00:22:02 +0000
Date:   Wed, 4 May 2022 01:22:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <YnHHKtql1PWq+0Bx@casper.infradead.org>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
 <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
 <YnG+h13Mh5b2qo5N@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnG+h13Mh5b2qo5N@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:45:11AM +0200, Michal Hocko wrote:
> On Tue 03-05-22 16:15:46, Suren Baghdasaryan wrote:
> > On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> [...]
> > > rcu_read_lock();
> > > vma = vma_lookup();
> > > if (down_read_trylock(&vma->sem)) {
> > >         rcu_read_unlock();
> > > } else {
> > >         rcu_read_unlock();
> > >         mmap_read_lock(mm);
> > >         vma = vma_lookup();
> > >         down_read(&vma->sem);
> > > }
> > >
> > > ... and we then execute the page table allocation under the protection of
> > > the vma->sem.
> > >
> > > At least, that's what I think we agreed to yesterday.
> > 
> > Honestly, I don't remember discussing vma->sem at all.
> 
> This is the rangelocking approach that is effectivelly per-VMA. So that
> should help with the most simplistic case where the mmap contention is
> not on the same VMAs which should be the most common case (e.g. faulting
> from several threads while there is mmap happening in the background).
> 
> There are cases where this could be too coarse of course and RCU would
> be a long term plan. The above seems easy enough and still probably good
> enough for most cases so a good first step.

It also fixes the low-pri monitoring daemon problem as page faults will
not be blocked by a writer (unless the read_trylock fails).

I see three potential outcomes here from the vma rwsem approach:

 - No particular improvement on any workloads.
   Result: we try something else.
 - Minor gains (5-10%).  We benchmark it and discover there's still
   significant contention on the vma_sem.
   Result: we take those wins and keep going towards a full RCU solution
 - Major gains (20-50%).
   Result: We're done, break out the champagne.

