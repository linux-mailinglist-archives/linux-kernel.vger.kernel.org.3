Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303A9568B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiGFOQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGFOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:16:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E818B25
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=spDbvDQWUmUV9Fd4NZJ6VhVOxQ0NJCSUNMtTb1+7S74=; b=WvWMSWeRl0GTyVbSQush2ye0Sn
        B624SNIS/SB0D8t/nP4K+d8fVc2kMcknm5V0J7apUos2SN8lBsZmZIyDYayexMAauo/HU2lU0ISwq
        emGos7UpUHD2kamsKgqElEzRVT7XeEyv45lzaUNNrE7xy9/UwxpgO2yWR4nZ3oRQDN2wB+CjWLdx6
        LkAMQ7q/XsD6P4Bjxz3B6gi3OPqKtVCX7Z3rG3tmjR+EkEc9VVbLQWB0mW+q5sFbJTm3HR0yJRXvd
        bmTkou2D1KlXuC2gB8uqXGDF6HRglW/5wp5Y8WDLgfTfVzmYFiBnzUP1+D1fCvjplCH3rsjLiTRRr
        5RO+wyOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o95pN-001hva-24; Wed, 06 Jul 2022 14:16:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52D7830015E;
        Wed,  6 Jul 2022 16:16:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A92C28711D52; Wed,  6 Jul 2022 16:16:27 +0200 (CEST)
Date:   Wed, 6 Jul 2022 16:16:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] locking/qspinlock: merge qspinlock_paravirt.h into
 qspinlock.c
Message-ID: <YsWZO3WM1WQzysIm@hirez.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-7-npiggin@gmail.com>
 <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
 <7e1a7093-2dbd-e5aa-3fae-9ade787cbd41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1a7093-2dbd-e5aa-3fae-9ade787cbd41@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:35:48AM -0400, Waiman Long wrote:
> On 7/5/22 13:20, Peter Zijlstra wrote:
> > On Tue, Jul 05, 2022 at 12:38:13AM +1000, Nicholas Piggin wrote:
> > > There isn't much reason to keep these separate.
> > The reason was so that other paravirt implementations could be added.
> > 
> > The CNA thing was also implemented this way...
> 
> Do you have any plan to take CNA [1] some time in the future?

I do mean to look at it, but somehow I never get around to it :-(
ISTR the O(n) on unlock got fixed.

Also; and I think this is why it never really gets to the top of the
todo list, I do still feel it is fixing the wrong problem. IIRC the
whole reason for CNA is the futex hash lock and I think that a better
futex ABI would be a *much* better solution there.

> Anyway, the main reason the paravirt code is separated into a separated file
> is to leave only the core part in qspinlock.c so that new users are
> overwhelmed with the messy details for the paravirt code. Putting everything
> into a single can make it harder to read for the newbies.
> 
> Also eliminating the preprocessor trick will make it harder to integrate a
> different qspinlock variant, like CNA, into the code base.

Fixed that already: YsR8BIyrSCQ8AlEo@worktop.programming.kicks-ass.net
