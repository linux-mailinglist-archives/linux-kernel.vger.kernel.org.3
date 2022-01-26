Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20ED49D2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbiAZTpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiAZTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:45:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EC8C06161C;
        Wed, 26 Jan 2022 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ACAyZTvosBZV5f3Muo3XS+bWrJuj3fQ11EBT7uBZp5w=; b=VP45iQ0ChXDykOM7S+unP06z5a
        oDnFAamCR+F7PiYpBDm0wtBWM/6D1KeIhAlrPAQDuwWM5jy3jtZlTXkx2/M7Bcp1Tm1AXqQtssZqT
        vm+O1K9e6lzmfFohVMH+Ql7sITbOnIuvT+v/1AgFVWFKKqn1LpqUVy7kjbUo7Wc7JurI5MDT5FuXm
        IGSPTYyLJrX8PCPJT3NMyjNWBAOLSfokfSV5At8f34dW+zJDUY/t7QX6KAqyfCb0WfMWRVNUbdGTi
        1/oJyl75PcqmSdz/zRNdfrN8hYoGkSh7gVQgxcIl7Ytk7zVt3wi2cBeBjvH9q6mqgGxDFLlv/DWSK
        /ATx8L7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCoEA-004NlA-QO; Wed, 26 Jan 2022 19:45:11 +0000
Date:   Wed, 26 Jan 2022 19:45:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for
 page->_refcount
Message-ID: <YfGkxtQd0KE8YNXt@casper.infradead.org>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com>
 <YfGZ/0hhkqVeX04p@casper.infradead.org>
 <CA+CK2bDHkOQbTrK=GbsGbojAj_6gaAX_8w3cBCd_LWqXt--yZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDHkOQbTrK=GbsGbojAj_6gaAX_8w3cBCd_LWqXt--yZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:22:26PM -0500, Pasha Tatashin wrote:
> On Wed, Jan 26, 2022 at 1:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 06:34:21PM +0000, Pasha Tatashin wrote:
> > > The problems with page->_refcount are hard to debug, because usually
> > > when they are detected, the damage has occurred a long time ago. Yet,
> > > the problems with invalid page refcount may be catastrophic and lead to
> > > memory corruptions.
> > >
> > > Reduce the scope of when the _refcount problems manifest themselves by
> > > adding checks for underflows and overflows into functions that modify
> > > _refcount.
> >
> > If you're chasing a bug like this, presumably you turn on page
> > tracepoints.  So could we reduce the cost of this by putting the
> > VM_BUG_ON_PAGE parts into __page_ref_mod() et al?  Yes, we'd need to
> > change the arguments to those functions to pass in old & new, but that
> > should be a cheap change compared to embedding the VM_BUG_ON_PAGE.
> 
> This is not only about chasing a bug. This also about preventing
> memory corruption and information leaking that are caused by ref_count
> bugs from happening.
> Several months ago a memory corruption bug was discovered by accident:
> an engineer was studying a process core from a production system and
> noticed that some memory does not look like it belongs to the original
> process. We tried to manually reproduce that bug but failed. However,
> later analysis by our team, explained that the problem occured due to
> ref_count bug in Linux, and the bug itself was root caused and fixed
> (mentioned in the cover letter).  This work would have prevented
> similar ref_count bugs from yielding to the memory corruption
> situation.

But the VM_BUG_ON_PAGE tells us next to nothing useful.  To take
your first example [1] as the kind of thing you say this is going to
help fix:

1. Page p is allocated by thread a (refcount 1)
2. Thread b gets mistaken pointer to p
3. Thread b calls put_page(), __put_page(), page goes to memory
   allocator.
4. Thread c calls alloc_page(), also gets page p (refcount 1 again).
5. Thread a calls put_page(), __put_page()
6. Thread c calls put_page() and gets a VM_BUG_ON_PAGE.

How do we find thread b's involvement?  I don't think we can even see
thread a's involvement in all of this!  All we know is a backtrace
pointing to thread c, who is a completely innocent bystander.  I think
you have to enable page tracepoints to have any shot at finding thread
b's involvement.

[1] https://lore.kernel.org/stable/20211122171825.1582436-1-gthelen@google.com/
