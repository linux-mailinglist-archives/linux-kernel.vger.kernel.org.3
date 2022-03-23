Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA204E4D62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiCWHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiCWHfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:35:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5009C28E05
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IL1DTXQ5PLoYDtzOHs2rZCCbl2DebPhnoyDqu6ydMA8=; b=pvTTIq3vz9PCfsGVX4JxViANnB
        Y2YljE0qJSg5q7PdfzAsI6zEB1NELwqox4PWgEe4k3nyAFrGZ0XU+tWpyCsaWHhz4X2egueJxUbI/
        JD9EJSwKZYTBtdgbwK551Bz55MjQmXwcgYEQ2IgI55anLvcR1ESjk4gttuPZl9NbNAD5unn85kGPB
        o45UVIj5pBYktS2mbU5VGdKHgnnRYK1ztvZsRwxiZ80GciDqwMsICKUBoGjyCr/YaI8118csap9Wm
        ev8jYlgQDWtgKU/xdpyOmiZOUqzEN4FeI5r0P4CdW99nG+DQqzYCcRQDuyYctVEt9wXTfcwB3qUYy
        rKjbVFSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWvUk-00D0Ka-5z; Wed, 23 Mar 2022 07:33:26 +0000
Date:   Wed, 23 Mar 2022 00:33:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjrNRpbo/i3tgbAA@infradead.org>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:22:50AM -0700, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 1:39 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > In this cycle, f2fs has some performance improvements for Android workloads such
> > as using read-unfair rwsems [...]
> 
> I've pulled this, but that read-unfair rwsem code looks incredibly
> dodgy. Doing your own locking is always a bad sign, and it ahs
> traditionally come back to bite us pretty much every time. At least it
> uses real lock primitives, just in a really odd way.

FYI, Peter and I both pointed this out when the patches were posted
and NAKed the patch, but the feedback was ignored.
