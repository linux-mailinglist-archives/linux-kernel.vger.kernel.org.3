Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7146495822
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378457AbiAUCOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbiAUCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:14:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mMsttHL5yQ5Bam0gaHSIXD7InB+D1TXSs5SzrAG0bSk=; b=KYXhTDyTi334B1jiFPr/nlo7Nx
        Zw1cXlIffzkjqN/ZJCyJnkY2yK+SzelC8tB1iQv4o3bYrnyAL1hbnaqukDfqFbdlNMzd5+DBhXmHh
        8tqJ2IUDqYJM4QXVzqKqq/z1oa3JZWPXnZgA82cSbO1tQwvZbbEtWEtq60SGyGPZgXoNTrXdy4kU+
        fvh7Mng8jrJvOOqzBeF2lsiEr23ThBUM1fWIzUdcdJe8Y+lCG65oP5mO+g0Fw2R8Oo3EICVtTVGNF
        L2bgvhyHninDk0zTvnJSodc6+OwtwYbtlRgwCuXwEk+yQ3mfxgGO+zbvJ4panbZD/G3IVyeuTf5SE
        5UqOZ5zQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAjR2-00F9EU-MD; Fri, 21 Jan 2022 02:13:52 +0000
Date:   Fri, 21 Jan 2022 02:13:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     khalid.aziz@oracle.com, akpm@linux-foundation.org, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, rppt@kernel.org, surenb@google.com
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YeoW4CMiU8qbRFST@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220121010806.5607-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121010806.5607-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:08:06AM +0800, Barry Song wrote:
> > A file under /sys/fs/mshare can be opened and read from. A read from
> > this file returns two long values - (1) starting address, and (2)
> > size of the mshare'd region.
> > 
> > --
> > int mshare_unlink(char *name)
> > 
> > A shared address range created by mshare() can be destroyed using
> > mshare_unlink() which removes the  shared named object. Once all
> > processes have unmapped the shared object, the shared address range
> > references are de-allocated and destroyed.
> 
> > mshare_unlink() returns 0 on success or -1 on error.
> 
> I am still struggling with the user scenarios of these new APIs. This patch
> supposes multiple processes will have same virtual address for the shared
> area? How can this be guaranteed while different processes can map different
> stack, heap, libraries, files?

The two processes choose to share a chunk of their address space.
They can map anything they like in that shared area, and then also
anything they like in the areas that aren't shared.  They can choose
for that shared area to have the same address in both processes
or different locations in each process.

If two processes want to put a shared library in that shared address
space, that should work.  They probably would need to agree to use
the same virtual address for the shared page tables for that to work.

Processes should probably not put their stacks in the shared region.
I mean, it could work, I suppose ... threads manage it in a single
address space.  But I don't see why you'd want to do that.  For
heaps, if you want the other process to be able to access the memory,
I suppose you could put it in the shared region, but heaps aren't
going to be put in the shared region by default.

Think of this like hugetlbfs, only instead of sharing hugetlbfs
memory, you can share _anything_ that's mmapable.

> BTW, it seems you have different intention with the below?
> Shared page tables during fork[1]
> [1] https://lwn.net/Articles/861547/

Yes, that's completely different.
