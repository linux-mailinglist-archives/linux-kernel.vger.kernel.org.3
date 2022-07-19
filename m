Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B657A82A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiGSUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiGSUYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C8E3FA19;
        Tue, 19 Jul 2022 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=u8oopSHac3jAE+8NMeybfxni/MQzhvEmpTnO4gjiYYg=; b=NQucyI/8BzDtUqhyMIkdmfE21C
        PBg5VrarOl8oiCeI5Es7bC64lW0ilVfPE3YYXVLvZHU2vRp1GfpeknIsmz04zH3JoG/Hfo4tI+vW5
        5pkbFoMPWkGnhdaqNAyruHWOQDtSUCadJ0ptMXnOhNyEAAAEpFUAkqpzhdCGuJx92pE13xDLtnXuD
        JWzYj/RAPN4PabCQ+/dkvH0pIoITdrKcR41UyWV08Y2lpwgh+1nkw+oXGDYiJLm9d+DOlmTUPQmlv
        NGNigKgxL+DD7AALhEFUNj0JulS0WcB0AQQuNH0/J5Kvq0ssyONEN7mip0bP5weE93jpfbPmbNaDu
        hh/e6Brw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDtkz-00Drg7-Ms; Tue, 19 Jul 2022 20:23:49 +0000
Date:   Tue, 19 Jul 2022 21:23:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Song Liu <song@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Replace kmap() with kmap_local_page()
Message-ID: <YtcS1QNcIrTt0DN1@casper.infradead.org>
References: <20220718002645.28817-1-fmdefrancesco@gmail.com>
 <YtXchtEwetMvKrKY@bombadil.infradead.org>
 <5303077.Sb9uPGUboI@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5303077.Sb9uPGUboI@opensuse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:19:24AM +0200, Fabio M. De Francesco wrote:
> On martedì 19 luglio 2022 00:19:50 CEST Luis Chamberlain wrote:
> > > Therefore, replace kmap() with kmap_local_page().
> > 
> > While this churn is going on everywhere I was wondering why not
> > go ahead and adopt kmap_local_folio() instead?
> 
> I'm sorry but, due to my lack of knowledge and experience, I'm not sure to 
> understand how kmap_local_folio() could help here. My fault. I'm going to 
> make some research and ask for help from more experienced developers. 

I haven't made this suggestion to Fabio before for a few reasons.

First, it makes his work harder.  He not only has to understand the
implications of the kmap semantic changes but also the implications of
the folio change.

Then, I'm not sure that I necessarily have enough infrastructure in place
for doing a folio conversion everywhere that he's doing a kmap/kmap_atomic
to kmap_local_page conversion.

What makes it particularly tricky is that you can only kmap a single
page out of a folio at a time; there's no ability to kmap the entire
folio, no matter how large it is.  I've looked at doing the conversion
for ext2 directories, and it's _tricky_.  There's only one 'checked'
flag for the entire folio, but ext2_check_page() needs to take a mapped
page.  So now we have to make a judgement call about whether to support
caching ext2 directories with large folios or whether to restrict them
to single-page folios.

So yes, there's probably a second patch coming for maintainers to look
at that will convert the kmap_local_page() to kmap_local_folio().
However, I think it's actually less of a burden for maintainers if
these two different conversions happen separately because there are very
different considerations to review.  Also, there's no equivalent to kmap()
or kmap_atomic() for folios (deliberately), so the more conversions to
kmap_local_page() Fabio gets done, the easier it will be for a later
folio conversion.
