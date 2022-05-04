Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7051AB08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359661AbiEDRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356793AbiEDRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:09:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BA1D33C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vxwk6Ijca/aYX+YfbJBlvvvvNjiuUacuBmt+5rQYXNM=; b=oDQFuDC/CbyMdA5t8SUc6eRJ5k
        GEy0MMahpBfiLT+xl7o9H01Qis311BLD46CZS9dMm7n5XRUJFMaXMXzkClGlxtydgQr54gPBNVGt9
        8nD5LiI1/nxKXZJJV/mUAuquq7yTPIrQ/W+3+CbW8U6WzHb00I8BssP90tik+BOuze4dVKJeJ3+wm
        t/BswQz/9H3KUGwY5SXMVPasHKpjQ+zM1t+wrjYHk3qlbRQhjX2iG13ZM+u4oPBj95KXNxtVD6tfy
        Aylv4xN3syksY8sOchC55gU3Snt3/+JrP2ZgG+FcoXg8brg/Pyx4gpwLgwo6ibQIgGlSTiGE9q5Rv
        oxXvVO9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmIHl-00GkfM-On; Wed, 04 May 2022 16:55:33 +0000
Date:   Wed, 4 May 2022 17:55:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnKwBeRAWwIlEVqy@casper.infradead.org>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
 <YnIBbjRYACzvuZpp@google.com>
 <YnIYofrw/GGEvc0U@casper.infradead.org>
 <YnKhLX+jzJc+2KwB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKhLX+jzJc+2KwB@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:52:13AM -0700, Minchan Kim wrote:
> On Wed, May 04, 2022 at 07:09:37AM +0100, Matthew Wilcox wrote:
> > On Tue, May 03, 2022 at 09:30:38PM -0700, Minchan Kim wrote:
> > > On Wed, May 04, 2022 at 04:32:13AM +0100, Matthew Wilcox wrote:
> > > > On Tue, May 03, 2022 at 10:03:41AM -0700, Minchan Kim wrote:
> > > > > -void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
> > > > > -void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
> > > > > +void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
> > > > > +void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
> > > > 
> > > > I see the build bot already beat me to pointing out why this is wrong,
> > > > but do you not look at git log to figure out why code was changed to be
> > > > the way it is now, before you change it back?
> > > 
> > > This patch added a new field as out param like compact_control so
> > > the rmap_walk_control is not immutable.
> > 
> > ... but we have a user which treats it as if it is.
> 
> True. I don't think it will show sizable benefit on runtime overhead
> since rmap_walk is already one of the most expensive operation in MM.
> 
> I could reintroduce the typecast for page_idle_clear_pte_refs to remove
> the const as we had several years.
> 
> If your concern was to make rmap_walk_control mutable back, I could
> change rmap_walk function having return value or adding a addtional
> new out param. However, I thought rmap_walk_control is more readable/
> easier than them.

I haven't thought deeply about it, but I suspect the right approach is
to remove the rather dubious optimisation in page_idle_clear_pte_refs().
