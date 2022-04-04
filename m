Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A34F16CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376901AbiDDONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376505AbiDDONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:13:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4B3ED21
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OSGhNgcMSZj8i4ui18pS1xGCuT1ZlpXgVLZj9Bopt84=; b=CkKP9rJ+cJQFQAODpAw8lKuD17
        SGHViuvdVuqCHLFm6jCtMjHfyWrUEGQ/+ET+pyJvDp3sRa8oLPOtBpHuKT3xpANdfr70g9uOGj8z8
        /4NrXOEhjSUM2YMHflgqy5YI7ZgNEtYjGyVTHomde346KQF+dFcI6ufJhwJaws0AHZTX9t0CD0wwT
        kmGqZQqM7qGdAWR0UqzvvilYS0KjciAgg3z1l610TJYvQgOOHp5Vp7urL52tk1BYWB6hJ+S2e+23C
        RUpnWXbVSUu81CjRn55YWafn4WQaWmV73COnVXeSaYiqHtfHH6JSGsBRMh1u63w+j1TyybRsDBW4Z
        OlTgNYWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbNQd-005mwQ-1U; Mon, 04 Apr 2022 14:11:35 +0000
Date:   Mon, 4 Apr 2022 15:11:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swapfile: unuse_pte can map random data if swap read
 fails
Message-ID: <Ykr8l0sUOtAa3yUY@casper.infradead.org>
References: <20220401072926.45051-1-linmiaohe@huawei.com>
 <ac13a529-5000-19c9-bbd8-3ee634a923cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac13a529-5000-19c9-bbd8-3ee634a923cc@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 03:37:36PM +0200, David Hildenbrand wrote:
> On 01.04.22 09:29, Miaohe Lin wrote:
> > There is a bug in unuse_pte(): when swap page happens to be unreadable,
> > page filled with random data is mapped into user address space. The fix
> > is to check for PageUptodate and fail swapoff in case of error.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/swapfile.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 63c61f8b2611..e72a35de7a0f 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1795,6 +1795,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> >  		ret = 0;
> >  		goto out;
> >  	}
> > +	if (unlikely(!PageUptodate(page))) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> 
> Yeah, we have the same handling in do_swap_page(), whereby we send a
> SIGBUS because we're dealing with an actual access.
> 
> Interestingly, folio_test_uptodate() states:
> 
> "Anonymous and CoW folios are always uptodate."
> 
> @Willy, is that true or is the swapin case not documented there?

Why do we keep a !Uptodate page in the swap cache?  If it can't be
read in from swap, I thought we just freed the page.  Since Miaohe
has observed that not happening, I guess it doesn't work that way,
but why not make it work that way?
