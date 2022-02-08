Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0D4AD454
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349652AbiBHJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiBHJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:07:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC600C0401F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A61C3B812A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE818C004E1;
        Tue,  8 Feb 2022 09:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644311238;
        bh=L0Queu/J22hPtJlTspT9X3XGQIvM4Eac6YqmWHNc+DU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EW8ROf3bW4Vrqq2Ld2IiU8cCkWLdVnOSyKbCyAxGIpHKABy95z412qcuIGgpbJ1OF
         fv5NQDwtPa4BLABcTBzbMYRd+Zvl7iUQBr0lkKLUsTcjFeCinEwvrgAnQeFRTA6nhR
         37XkOpBlMHsJ+czh00cFa3oL2fGPHFHvznCR0zP0ZvQ9zAbVj3tG1DlUP8BtfCfq/R
         gXb9c5Ue27dCA/QMT7a+ZB2gddXn8FTswx44Su4k08oJqAKxXmBZsGjYEIZDVsHVo8
         P+exbaXwa+8U5FTikoP9XLhD/uDWxvnCFmBcfKJ2t2uts90YE2don5ZV2bljYHvzK4
         bk9gPeMYWXMgw==
Date:   Tue, 8 Feb 2022 11:07:07 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 33/35] arm64/mm: attempt speculative mm faults first
Message-ID: <YgIyu93laY2ezKSJ@kernel.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-34-michel@lespinasse.org>
 <YfZWtsC3QIzXR0LI@kernel.org>
 <20220131080729.GA785@lespinasse.org>
 <Yfj2G3oOC6cZx0IL@kernel.org>
 <20220207173919.GB12302@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207173919.GB12302@lespinasse.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:39:19AM -0800, Michel Lespinasse wrote:
> On Tue, Feb 01, 2022 at 10:58:03AM +0200, Mike Rapoport wrote:
> > On Mon, Jan 31, 2022 at 12:07:29AM -0800, Michel Lespinasse wrote:
> > > On Sun, Jan 30, 2022 at 11:13:26AM +0200, Mike Rapoport wrote:
> > > > The speculative page fault implementation here (and for PowerPC as well)
> > > > looks very similar to x86. Can we factor it our rather than copy 3 (or
> > > > more) times?
> > > 
> > > In each arch, the speculative code was written along the lines of the
> > > existing non-speculative code, so that behavior would be unchanged
> > > when speculation succeeds.
> > > 
> > > Now each arch's existing, non-speculative code paths are quite similar,
> > > but they do have small differences as to how they implement various
> > > permission checks, protection keys and the like. The same small
> > > differences end up being reflected in the new speculative code paths.
> > > 
> > > I agree it would be nice if this code could be unified between archs,
> > > but IMO this should start with the existing non-speculative code -
> > > I don't think it would make sense to try unifying the new speculative
> > > code while trying to follow the behavior of the non-unified old
> > > non-speculative code paths...
> > 
> > Then maybe this unification can be done as the ground work for the
> > speculative page fault handling?
> 
> I feel like this is quite unrelated, and that introducing such
> artificial dependencies is a bad work habit we have here in linux MM...

The reduction of the code duplication in page fault handlers per se is
indeed not very related to SPF work, but since the SPF patches increase
the code duplication, I believe that the refactoring that prevents this
additional code duplication is related and is in scope of this work.
 
> That said, unifying the PF code between archs would be an interesting
> project on its own. The way I see it, there could be a unified page
> fault handler, with some arch specific parts defined as inline
> functions.  I can see myself making an x86/arm64/powerpc initial
> proposal if there is enough interest for it, but I'm not sure how
> extending it to more exotic archs would go - I think this would have
> to involve arch maintainers at least for testing purposes, and I'm not
> sure if they'd have any bandwidth for such a project...

There is no need to convert all architectures and surely not at once.
The parts of page fault handler that are shared by several architectures
can live under #ifdef ARCH_WANTS_GENERIC_PAGE_FAULT or something like this.

> --
> Michel "walken" Lespinasse

-- 
Sincerely yours,
Mike.
