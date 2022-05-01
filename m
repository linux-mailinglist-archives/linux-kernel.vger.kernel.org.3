Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B05168ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 01:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356161AbiEBAAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEBAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:00:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6E41981
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 16:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7009BB81020
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB327C385AE;
        Sun,  1 May 2022 23:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651449399;
        bh=E3IU7wp+u3xButnlu57iaqCHUQJvl7jir8ysbnCd3lI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EFR6Rgf+Ae6rGv1Wap4GiK0sCiqyhF/2eM2nybh6VJDsGTrMwxKAUt3FpuJ8rupEO
         tjWFXoJi+JdomJfFCdlmlzTlXen/XmBrzdIR5siEDIOJK17fhC+b1NOWcwHz7O2IKB
         hejdCuxWt8/k3ikeUgQbMj7l18qea9I8+RKjjjcs=
Date:   Sun, 1 May 2022 16:56:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-Id: <20220501165633.056319565dce429e36d25a0a@linux-foundation.org>
In-Reply-To: <20220501202532.y6zmznzshbe33nwx@offworld>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
        <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
        <20220427140832.mpvnnkkhrbupk46i@revolver>
        <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
        <YmmHqlR6lV84KDrO@casper.infradead.org>
        <20220501202532.y6zmznzshbe33nwx@offworld>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022 13:26:34 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 27 Apr 2022, Matthew Wilcox wrote:
> 
> >On Wed, Apr 27, 2022 at 10:33:31AM -0700, Andrew Morton wrote:
> >> On Wed, 27 Apr 2022 14:08:39 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> >> > The benchmarks are around the same as they have always been.
> >>
> >> So it's presently a wash.
> >>
> >> That makes "the plan" (below) really critical, otherwise there seems
> >> little point in merging this code at this time?
> >>
> >> Please send me many very soothing words about how confident we should
> >> be that the plan will be implemented and that it shall be good?
> >
> >Yes, performance-wise it's a wash.  However, Davidlohr was very
> >impressed that it was a wash because we're actually getting rid of three
> >data structures here; the linked list, the rbtree and the vmacache.
> >His opinion was that we should push the maple tree in now, in advance
> >of the future RCU uses.
> 
> Yes I like the maple tree, and at this stage I don't think we can ask
> for more from this series wrt the MM - albeit there seems to still be
> some folks reporting breakage. Fundamentally I see Liam's work to (re)move
> complexity out of the MM (not to say that the actual maple tree is not
> complex) by consolidating the three complimentary data structures very
> much worth it considering performance does not take a hit. This was
> very much a turn off with the range locking approach, which worst case
> scenario incurred in prohibitive overhead. Also as Liam and Matthew
> have mentioned, RCU opens up a lot of nice performance opportunities,
> and in addition academia[1] has shown outstanding scalability of address
> spaces with the foundation of replacing the locked rbtree with RCU
> aware trees.

Thanks.   That sounded like a wordy acked-by to me? :)

Liam, I think the above is useful background for the [0/N].

> [1] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

As is that.  The paper seems shockingly relevant.  Do we know the
authors or is it a cosmic coincidence?

