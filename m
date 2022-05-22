Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED353057D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbiEVTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiEVTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:42:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C362FFC1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VJOiU6BQi5P886CY3iFuhDrifu3rFeIvy3Ts/J6ugWs=; b=rQdbGHWULvJr/+YfcZL2BWrq9P
        oblMQR2ONoZ8H6J19kBsRKhePWr3eYFB20yLweMhTw3F/IwXNEXqmYc9+BPeM+yUyyl/QUnXNSkhU
        a0+0SPge7Oy2nI1lnaebibi+fSjO6GMLNeGwTncNF33YaBhDJURU8vgfKWmj+PQ7YnDsHeccvwH8T
        rCLiLgGsZNYiRpKCN/VuHJZxZW743LKi6358SohTqtJdBgsvihnj8N+gu2BLyLcHLqrjZ2ZM10hiB
        DeW/V8ci9utfz5HFPMr+zRk9RMMS/R4wnBVyYVFaFjJtQsxIB5aokIgduAGC3FpL0+5PQvQ+ngtcW
        sHW9DZXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsrRU-00FZ4M-P3; Sun, 22 May 2022 19:40:44 +0000
Date:   Sun, 22 May 2022 20:40:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Message-ID: <YoqRvDn2P+9i0SrF@casper.infradead.org>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
 <YolHr1GwfA++i9jj@casper.infradead.org>
 <64d0da08-6ffd-4bce-bc66-5097913937b4@kernel.org>
 <YomERsAM3gF7XxRZ@casper.infradead.org>
 <c82ac102-7935-4b07-9d8c-82a2efe59956@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c82ac102-7935-4b07-9d8c-82a2efe59956@www.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 08:20:05AM -0700, Andy Lutomirski wrote:
> On Sat, May 21, 2022, at 5:31 PM, Matthew Wilcox wrote:
> > On Sat, May 21, 2022 at 03:19:24PM -0700, Andy Lutomirski wrote:
> >> I can see a rather different use for this type of shared-pagetable
> >> technology, though: monstrous MAP_SHARED mappings.  For database and some VM
> >> users, multiple processes will map the same file.  If there was a way to
> >> ensure appropriate alignment (or at least encourage it) and a way to handle
> >> mappings that don't cover the whole file, then having multiple mappings
> >> share the same page tables could be a decent efficiently gain.  This doesn't
> >> even need COW -- it's "just" pagetable sharing.
> >
> > The mshare proposal did not get a warm reception at LSFMM ;-(
> >
> > The conceptual model doesn't seem to work for the MM developers who were
> > in the room.  "Fear" was the most-used word.  Not sure how we're going
> > to get to a model of sharing page tables that doesn't scare people.
> 
> FWIW, I didn’t like mshare.  mshare was weird: it seemed to have
> one mm own some page tables and other mms share them.  I’m talking
> about having a *file* own page tables and mms map them.  This seems less
> fear-inducing to me.  Circular dependencies are impossible, mmap calls
> don’t need to propagate, etc.

OK, so that doesn't work for our use case.  We need an object to own page
tables that can be shared between different (co-operating) processes.
Because we need the property that calling mprotect() changes the
protection in all processes at the same time.

Obviously we want that object to be referenced by a file descriptor, and
it can also have a name.  That object doesn't have to be an mm_struct.
Maybe that would be enough of a change to remove the fear.
