Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD59511F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiD0Rgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbiD0Rgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:36:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35DD633A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28275B828A2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40F3C385A7;
        Wed, 27 Apr 2022 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651080811;
        bh=O7AppN2/GeSeVztx+YVjK3Wc9TzGWKgcYLWspYyO5xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C7m9PX5lzopGA6xPav9eZkeUHRA4Di6MOlOidDzWtG347twpfec2w/FTNKix1t5fh
         tmMH+JSus+PJ0OrO4g+8RmHyFcYXQd/uih3ORIp+3E6hSx+SxtMMhakkUTphOQKJAi
         p1+bdXIBPJrLvWPXx2Y3mRKbqxRSRYJXQdc0X1cs=
Date:   Wed, 27 Apr 2022 10:33:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-Id: <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
In-Reply-To: <20220427140832.mpvnnkkhrbupk46i@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
        <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
        <20220427140832.mpvnnkkhrbupk46i@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 14:08:39 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> > > 
> > > The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> > > nodes.  With the increased branching factor, it is significantly shorter than
> > > the rbtree so it has fewer cache misses.  The removal of the linked list
> > > between subsequent entries also reduces the cache misses and the need to pull
> > > in the previous and next VMA during many tree alterations.
> > 
> > Do we have any quantitative testing results?
> 
> I was waiting for the mmtests sweep to complete before sending them but
> I didn't want to hold up Yu Zhao's testing of the combined tree as it
> has proved useful already. Please don't include the results in the first
> commit as it wouldn't make much sense.  If you intend to put them in a
> commit message, please put them in the patch introducing the maple tree.

I did that.

> The benchmarks are around the same as they have always been.

So it's presently a wash.

That makes "the plan" (below) really critical, otherwise there seems
little point in merging this code at this time?

Please send me many very soothing words about how confident we should
be that the plan will be implemented and that it shall be good?

> > 
> > What's the plan on utilizing this to further reduce mmap_lock contention?
> 
> The plan is to get to the point where we use the maple tree in RCU mode.
> Readers will not block for writers.  A single write operation will be
> allowed at a time.  A reader re-walks if stale data is encountered. VMAs
> would be RCU enabled and this mode would be entered once multiple tasks
> are using the mm_struct.  I can go into more details if you want.

Uh, that's very important information.  It's really the whole point
of the patchset!   I added this to the [0/n] changelog.
