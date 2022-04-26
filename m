Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E68510B19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355330AbiDZVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355329AbiDZVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:20:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A2C865B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h0WM/OGYr1vmddkP3aThoTDj/4ylnz0kGYAAy3EuZGE=; b=kyguCSba/X6mQN+uANNGnuh6F/
        AF0v4xllc6XsTsqebSYH2ppi/bm/62UZRT13hR9l9rtDgtTieEpaXnocYc/Q7Qv/W7WklIsbeiE0i
        4QinJ/i97z7pcmWJkvkHNutWrYDjeyk3/FfmiicUPHaCdT3PjHE5Z2gwSLTNO3vSrGXTwibBwYuTF
        V4Ncqn0p2LHcsNVDsGEG5o4VTM9R2lqV4xtixba06P7K7mPYZ/vNYf1mZJfnAzpyrXa3txdP8ZomX
        jL0lgbQ9BMmLmHEzdAaLD1Pk1l9F69L3WKKepkohrtPADyPob5E6r0BOoaWDqpzTQSk0DpWHDIh4n
        ucWqiC9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njSYz-00A1ET-5j; Tue, 26 Apr 2022 21:17:37 +0000
Date:   Tue, 26 Apr 2022 22:17:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] mm/filemap: Fix NULL pointer dereference in
 pagecache_get_page
Message-ID: <YmhhcQuXO7ZKjolH@casper.infradead.org>
References: <20220426082549.590899-1-wanjiabing@vivo.com>
 <YmfgqKcMmstgfz+0@casper.infradead.org>
 <20220426140641.cc78a429e1fa32ed0e15520b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426140641.cc78a429e1fa32ed0e15520b@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:06:41PM -0700, Andrew Morton wrote:
> On Tue, 26 Apr 2022 13:08:08 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Apr 26, 2022 at 04:25:48PM +0800, Wan Jiabing wrote:
> > > Fix following coccicheck error:
> > > mm/folio-compat.c:128:17-21: ERROR: folio is NULL but dereferenced.
> > >  	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> > > -	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
> > > +	if (!folio)
> > > +		return NULL;
> > > +	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
> > >  		return &folio->page;
> > 
> > That doesn't dereference the folio.  Coccicheck is wrong.
> 
> Doing
> 
> 		return &(0->page);
> 
> is a rather obscure way of doing `return NULL;'.
> 
> I agree the patch doesn't fix anything, but it results in saner-looking code?

I suppose that's in the eye of the beholder?  The original code makes
more sense to me.  Besides, it's in the folio-compat file; nobody
should be looking at that except to figure out "What function should I
be transitioning to?"
