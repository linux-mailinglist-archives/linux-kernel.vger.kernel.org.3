Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05806496CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiAVQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiAVQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:09:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8073BC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kb74F43BLvLHWOm3OwbStCcd3tcNlftQe6dpkaPslG4=; b=jvi1a1/cpna0okOzXXnVQ3/7Vy
        megpSp0hPM9ZIPP1FIzcMtnA1eNBNjsr+oDk+2DO3XYvF5a9YQKrw33LtEYC5wcy3B6GX3InyZDvQ
        NaeU3bDHj9HyOoa5rvtkRBGq1cr9yN4Ne263a3Q3g1I8LDyvyS3FYWqJCpwunM3nuE10CLlChLDVZ
        NddyjQEgrb4VSQBT27gGv/XfG2J5Mz0yvXjBq4cLOK+Agqs89TJWWR/iJTLTy8Wknh0SoHxda06fK
        YmIl4Wg4Kjdoc5uuBFexqZdB7ViLXBL/QHoXmqk6fRZxOwYjOQKk9vzYfspjR7rIOgTi5QUP1vzCW
        2Iqq6ewg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBIx0-00GT0o-0O; Sat, 22 Jan 2022 16:09:14 +0000
Date:   Sat, 22 Jan 2022 16:09:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>,
        Barry Song <21cnbao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YewsKfCUb6tI5jHs@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220121010806.5607-1-21cnbao@gmail.com>
 <YeoW4CMiU8qbRFST@casper.infradead.org>
 <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
 <YerHceldiYXLk2DE@casper.infradead.org>
 <0ec88ae7-9740-835d-1f07-60bd57081fcd@oracle.com>
 <b34ded1e11154eabbce07618bf0a6676@huawei.com>
 <Yetgy/eT+rZBgSq7@casper.infradead.org>
 <cb55951f-3c30-61e3-23a3-7a99064918b7@schoebel-theuer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb55951f-3c30-61e3-23a3-7a99064918b7@schoebel-theuer.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 11:18:14AM +0100, Thomas Schoebel-Theuer wrote:
> On 1/22/22 2:41 AM, Matthew Wilcox wrote:
> > On Sat, Jan 22, 2022 at 01:39:46AM +0000, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> > > > > Our use case is that we have some very large files stored on persistent
> > > > > memory which we want to mmap in thousands of processes.  So the first
> > > The memory overhead of PTEs would be significantly saved if we use
> > > hugetlbfs in this case, but why not?
> > Because we want the files to be persistent across reboots.
> 
> 100% agree. There is another use case: geo-redundancy.
> 
> My view is publicly documented at
> https://github.com/schoebel/mars/tree/master/docu and click at
> architecture-guide-geo-redundancy.pdf

That's a 160+ page PDF.  No offence, Thomas, I'm not reading that to
try to understand how you want to use page table sharing.

> In some scenarios, migration or (temporary) co-existence of block devices
> from/between hardware architecture A to/between hardware architecture B
> might become a future requirement for me.

I'm not sure how sharing block devices between systems matches up with
sharing page tables between processes.

> It would be great if msharefs is not only low-footprint, but also would be
> usable from kernelspace.

I don't understand what you want here either.  Kernel threads already
share their page tables.
