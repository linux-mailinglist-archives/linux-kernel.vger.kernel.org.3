Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D70536D30
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiE1N51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiE1N5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:57:24 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EAA6AA46F
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:57:19 -0700 (PDT)
Received: (qmail 126261 invoked by uid 1000); 28 May 2022 09:57:19 -0400
Date:   Sat, 28 May 2022 09:57:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH -lkmm] docs/memory-barriers: Fix inconsistent name of
 'data dependency barrier'
Message-ID: <YpIqP2CiLa6Y4BnG@rowland.harvard.edu>
References: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 01:15:30PM +0900, Akira Yokosawa wrote:
> The term "data dependency barrier", which has been in
> memory-barriers.txt ever since it was first authored by David Howells,
> has become confusing due to the fact that in LKMM's explanations.txt
> and elsewhere, "data dependency" is used mostly for load-to-store data
> dependency.
> 
> To prevent further confusions, do the following changes:
> 
>   - substitute "address-dependency barrier" for "data dependency barrier";
>   - add note on the removal of kernel APIs for explicit address-
>     dependency barriers in kernel release v5.9;
>   - add note on the section title rename;
>   - use READ_ONCE_OLD() for READ_ONCE() of pre-4.15 (no address-
>     dependency implication) in code snippets;
>   - fix number of CPU memory barrier APIs;
>   - and a few more context adjustments.
> 
> Note: Line break cleanups are deferred to a follow-up patch.
> 
> Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
> This is a response to Michael's report back in last November [1].
> 
> [1]: "data dependency naming inconsistency":
>      https://lore.kernel.org/r/20211011064233-mutt-send-email-mst@kernel.org/
> 
> In the thread, I suggested removing all the explanations of "data dependency
> barriers", which Paul thought was reasonable.
> 
> However, such removals would require rewriting the notoriously
> hard-to-grasp document, which I'm not quite up to.
> I have become more inclined to just substitute "address-dependency
> barrier" for "data dependency barrier" considering the fact that
> READ_ONCE() has an implicit memory barrier for Alpha.
> 
> This RFC patch is the result of such an attempt.
> 
> Note: I made a mistake in the thread above. Kernel APIs for explicit data
> dependency barriers were removed in v5.9.
> I confused the removal with the addition of the barrier to Alpha's
> READ_ONCE() in v4.15.
> 
> Any feedback is welcome!
> 
>         Thanks, Akira

This looks great!  Thanks a lot for working on it.  The way
memory-barriers.txt misuses "data dependency" to mean "address
dependency" has bothered me for a long time; I'm very glad that it
will finally get cleaned up.

Alan
