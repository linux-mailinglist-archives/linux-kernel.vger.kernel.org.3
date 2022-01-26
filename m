Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA349C26F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiAZEFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiAZEFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:05:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57540C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EPZFnvZSWtUChiByJXbpNdnEgj2wHr/YrtyphezMlas=; b=BBI1rbHtRZSKR2sbOcH13dmoNT
        y5yXJMal1+Uj54eCJG+FCI1ETERDdclBEcueKTbe4P0phjm0qh/sTnZISl/TDDVpMyVQyAgFtbM15
        EmGXjM26rumanCA1V9JoY054wqvTc/c4RPHsoWDz2dPRkx/WJKbI1rVPIjH0JFZ3srGcF5K6P1aNG
        Rhwmlsd4UqcLPDpHMJ5RMOhgHAhXCf+VVUZhb/4WMu82BWMdGUo/stCaJ6EPA7ElcLjLw632r5ktS
        xrtIUvkEsPgRoJXx/QJA9LNoCTrf6XJVOSRPDC46UsgQQ9I97Jcr9e3CvUzqWEFNbyii7wiV9dbPf
        6vaIM4xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCZY8-003hFg-Gl; Wed, 26 Jan 2022 04:04:48 +0000
Date:   Wed, 26 Jan 2022 04:04:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfDIYKygRHX4RIri@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBIpmxvc0+mFByf@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:59:50PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 25, 2022 at 09:57:05PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jan 25, 2022 at 02:09:47PM +0000, Matthew Wilcox wrote:
> > > > I think zero-API approach (plus madvise() hints to tweak it) is worth
> > > > considering.
> > > 
> > > I think the zero-API approach actually misses out on a lot of
> > > possibilities that the mshare() approach offers.  For example, mshare()
> > > allows you to mmap() many small files in the shared region -- you
> > > can't do that with zeroAPI.
> > 
> > Do you consider a use-case for many small files to be common? I would
> > think that the main consumer of the feature to be mmap of huge files.
> > And in this case zero enabling burden on userspace side sounds like a
> > sweet deal.
> 
> mmap() of huge files is certainly the Oracle use-case.  With occasional
> funny business like mprotect() of a single page in the middle of a 1GB
> hugepage.

Bill and I were talking about this earlier and realised that this is
the key point.  There's a requirement that when one process mprotects
a page that it gets protected in all processes.  You can't do that
without *some* API because that's different behaviour than any existing
API would produce.

So how about something like this ...

int mcreate(const char *name, int flags, mode_t mode);

creates a new mm_struct with a refcount of 2.  returns an fd (one
of the two refcounts) and creates a name for it (inside msharefs,
holds the other refcount).

You can then mmap() that fd to attach it to a chunk of your address
space.  Once attached, you can start to populate it by calling
mmap() and specifying an address inside the attached mm as the first
argument to mmap().

Maybe mcreate() is just a library call, and it's really a thin wrapper
around open() that happens to know where msharefs is mounted.
