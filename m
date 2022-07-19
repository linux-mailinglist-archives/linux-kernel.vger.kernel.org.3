Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC50157A909
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiGSVfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGSVfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:35:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C595B8;
        Tue, 19 Jul 2022 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=jjeVl4qs5CeEaP49NnnXRnAsqGSBkzv6YXSjxpIqWXs=; b=WJW0EgnCnITflTYYEBppwGUjM0
        eqqcvxADvOynG0SnFLguO5WpJlMWCANotaPLnjeeSkRKYRawoaVFLb29TBbWvDj4uz+BHzFvq02a5
        GFHSNlYWf66DF5PIey8y5iDChY56ySa8q961jnne7LxMTUh2ITZduhkRrsAVs/lBo+t04ZjORtIQj
        I2fxvLaw7V8q3emrv+Pd8q65Ud4UD7mXKs9yrGRr3RDIkP3PFSBaZAoWNyijLp517ygP2p41WPA+Z
        elFNNa+qdY0SEpDDPBWRUQHyOsVRg2e6/i1UUkj8uJq+0s9GezHr26tY/W1PWPl7oanL088zccC87
        705VS7GA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDurv-00DGKc-Oh; Tue, 19 Jul 2022 21:35:03 +0000
Date:   Tue, 19 Jul 2022 14:35:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Song Liu <song@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Replace kmap() with kmap_local_page()
Message-ID: <Ytcjhw6tckKe7V/U@bombadil.infradead.org>
References: <20220718002645.28817-1-fmdefrancesco@gmail.com>
 <YtXchtEwetMvKrKY@bombadil.infradead.org>
 <5303077.Sb9uPGUboI@opensuse>
 <YtcS1QNcIrTt0DN1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtcS1QNcIrTt0DN1@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:23:49PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 19, 2022 at 11:19:24AM +0200, Fabio M. De Francesco wrote:
> > On martedì 19 luglio 2022 00:19:50 CEST Luis Chamberlain wrote:
> > > > Therefore, replace kmap() with kmap_local_page().
> > > 
> > > While this churn is going on everywhere I was wondering why not
> > > go ahead and adopt kmap_local_folio() instead?
> > 
> > I'm sorry but, due to my lack of knowledge and experience, I'm not sure to 
> > understand how kmap_local_folio() could help here. My fault. I'm going to 
> > make some research and ask for help from more experienced developers. 
> 
> I haven't made this suggestion to Fabio before for a few reasons.
> 
> First, it makes his work harder.  He not only has to understand the
> implications of the kmap semantic changes but also the implications of
> the folio change.
> 
> Then, I'm not sure that I necessarily have enough infrastructure in place
> for doing a folio conversion everywhere that he's doing a kmap/kmap_atomic
> to kmap_local_page conversion.
> 
> What makes it particularly tricky is that you can only kmap a single
> page out of a folio at a time; there's no ability to kmap the entire
> folio, no matter how large it is.  I've looked at doing the conversion
> for ext2 directories, and it's _tricky_.  There's only one 'checked'
> flag for the entire folio, but ext2_check_page() needs to take a mapped
> page.  So now we have to make a judgement call about whether to support
> caching ext2 directories with large folios or whether to restrict them
> to single-page folios.
> 
> So yes, there's probably a second patch coming for maintainers to look
> at that will convert the kmap_local_page() to kmap_local_folio().
> However, I think it's actually less of a burden for maintainers if
> these two different conversions happen separately because there are very
> different considerations to review.  Also, there's no equivalent to kmap()
> or kmap_atomic() for folios (deliberately), so the more conversions to
> kmap_local_page() Fabio gets done, the easier it will be for a later
> folio conversion.

Makes sense, thanks for the feedback. I'll wrestle with ensuring the first
step to kmap_local_page() doens't break things where I see them
suggested first.

  Luis
