Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3649BBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiAYTAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiAYTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:00:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5899C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bt8DG4kv/HiKHmCxuEq4ti3BrhnQMbSnttO4/8+9Xs4=; b=sl1vLhCyZd3T8KmPTjKxZcrVsT
        yHbYNZfD0SvdklJb+XFTy6+SRgqlug+6n3hTafjWom8+t6HNsM/kinSWuwgRZCUGLx7tIXmxgA+dU
        vCS89F3ztYMaw23a4R+qztj+agAyg0rwnXi1SOlME1Uu2GQA1EKzIQhX9cg3e22vquRlV3ICyETMj
        9kV9sCClzEc7Y+vM9ym4CDlTO49jmrIVLe6IwTczO8MrQLT/+dYnmi7pF9mGBTRCiA3IqfrJ0lWAI
        SwpoxqO/d8GcivW55uKjW00PHVJ83rpOncMgm1/HcBGxHsoNe+P5b79TCmqADb1hL4bY20Cuiu5+p
        OJsyB/XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCR2k-003GLD-An; Tue, 25 Jan 2022 18:59:50 +0000
Date:   Tue, 25 Jan 2022 18:59:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfBIpmxvc0+mFByf@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:57:05PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 25, 2022 at 02:09:47PM +0000, Matthew Wilcox wrote:
> > > I think zero-API approach (plus madvise() hints to tweak it) is worth
> > > considering.
> > 
> > I think the zero-API approach actually misses out on a lot of
> > possibilities that the mshare() approach offers.  For example, mshare()
> > allows you to mmap() many small files in the shared region -- you
> > can't do that with zeroAPI.
> 
> Do you consider a use-case for many small files to be common? I would
> think that the main consumer of the feature to be mmap of huge files.
> And in this case zero enabling burden on userspace side sounds like a
> sweet deal.

mmap() of huge files is certainly the Oracle use-case.  With occasional
funny business like mprotect() of a single page in the middle of a 1GB
hugepage.

The approach of designating ranges of a process's address space as
sharable with other processes felt like the cleaner & frankly more
interesting approach that opens up use-cases other than "hurr, durr, we
are Oracle, we like big files, kernel get out of way now, transactions
to perform".
