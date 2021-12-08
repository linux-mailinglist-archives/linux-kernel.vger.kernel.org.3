Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5E46D755
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhLHPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhLHPvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:51:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7DFC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WtEQqwJBUEAbt+Rn6z3KfUtCYF75TrzmNyPUTpmgJXU=; b=hHCEZdU/Kd8ONj9kU8NJqRfE6H
        k97CA/DyB/UhwyLbKrMFYfRANIkWayLr/Yh9r7XD7rArXZiYFNB6RrFBFrMVZy2gaAmoqghXx8yWc
        65oxqcv1UK7gg6CzRsdNIqk7hxw7sSB3csb0l4tSdl9lUhFYvCaSgXNJrAeOZvG0tDTiEDRa6315J
        qyutCDctALOhqiJXtSrP6oNM2OVb5PUu5LKEZ5EIW1+w1dNSX59VZGfkWpX+ppkjV8rBiBVRzto5S
        mVjoOZjde89EJehpTSxX0/ULI/MoksKwJGwvdc1uJLDHcc14LpL1vsJivVft1WiaLWwhzTfs5yXRs
        r8XNJktA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muzA4-008YAI-GF; Wed, 08 Dec 2021 15:47:16 +0000
Date:   Wed, 8 Dec 2021 15:47:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 05/66] Maple Tree: Add new data structure
Message-ID: <YbDThNl56dH0mTHZ@casper.infradead.org>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-6-Liam.Howlett@oracle.com>
 <5ead526d-8499-4810-7657-6af5f2e96ccc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ead526d-8499-4810-7657-6af5f2e96ccc@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:34:44PM +0100, Vlastimil Babka wrote:
> > +/*
> > + * We also reserve values with the bottom two bits set to '10' which are
> > + * below 4096
> > + */
> > +static inline bool mt_is_reserved(const void *entry)
> > +{
> > +	return ((unsigned long)entry < MAPLE_RESERVED_RANGE) &&
> > +		xa_is_internal(entry);
> 
> It's weird to suddenly see xa_ prefix here (and below). AFAICS it's nowhere
> declared that maple tree is derived from xarray so while it's not completely
> surprising given the overlap of authors, wouldn't it be more robust if maple
> tree had its own independent set of these helpers?

My intent is to merge the maple tree and xarray at some point.  The xarray
has some pretty awful worst-case behaviour that the maple tree avoids.
The maple tree doesn't yet have the search mark feature, and it needs a
new leaf node type for dense nodes.  It also needs a replacement for the
private_list used to trim the excess nodes which store workingset values.

When they get merged, my thinking was that the maple tree nomenclature
would be removed in favour of the xarray API, so I haven't been in too
much hurry to add aliases for all the parts of the xarray API that are
in the maple tree.
