Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5954001D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiFGNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiFGNem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55AEC0E3D;
        Tue,  7 Jun 2022 06:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628D66144C;
        Tue,  7 Jun 2022 13:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D96BC385A5;
        Tue,  7 Jun 2022 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654608879;
        bh=CuYxQ35fpR+VuhG0h+xJqZX2h8dcdonxjn9U1FJK+2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRh3nfHmEvi+TS+JUzLl5D6J6dwrs//Eibz339wIB5trml4Np5BTTCA/AKjxImPCs
         t9nh/FFwhbJrzxHZANLfWcq0RYa6JDUG70LR4QnaZcVlqfGMACUeFS9j0p4XeuJAfc
         9IrUJa4f7Qu2AixXO8+ZxaQxW9iV/xQJYmUpCNHofAyJbfmUeLo4sAoWvb+RpBNCPZ
         L6FFCFwTKtqRHBcyTIAmebgomr9HwDuhPU8gR4y7Mqj5LSVFb8aE6gMaRFQbXxLmaj
         5RsgF7ILxWQoIZJAfP2M20TuPXnySwkzelgoaWDRaiyrYj5PASI9/b18go1cWvu3Ri
         5VQ5y9y8anpew==
Date:   Tue, 7 Jun 2022 14:34:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20220607133432.GA32701@willie-the-truck>
References: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> --
>  Documentation/memory-barriers.txt | 119 +++++++++++++++++-------------
>  1 file changed, 67 insertions(+), 52 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..306afa1f9347 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -52,7 +52,7 @@ CONTENTS
>  
>       - Varieties of memory barrier.
>       - What may not be assumed about memory barriers?
> -     - Data dependency barriers (historical).
> +     - Address-dependency barriers (historical).
>       - Control dependencies.
>       - SMP barrier pairing.
>       - Examples of memory barrier sequences.
> @@ -187,7 +187,7 @@ As a further example, consider this sequence of events:
>  	B = 4;		Q = P;
>  	P = &B;		D = *Q;
>  
> -There is an obvious data dependency here, as the value loaded into D depends on
> +There is an obvious address dependency here, as the value loaded into D depends on
>  the address retrieved from P by CPU 2.  At the end of the sequence, any of the
>  following results are possible:
>  
> @@ -391,49 +391,53 @@ Memory barriers come in four basic varieties:
>       memory system as time progresses.  All stores _before_ a write barrier
>       will occur _before_ all the stores after the write barrier.
>  
> -     [!] Note that write barriers should normally be paired with read or data
> +     [!] Note that write barriers should normally be paired with read- or address-
>       dependency barriers; see the "SMP barrier pairing" subsection.
>  
>  
> - (2) Data dependency barriers.
> + (2) Address-dependency barriers (historical).
>  
> -     A data dependency barrier is a weaker form of read barrier.  In the case
> +     An address-dependency barrier is a weaker form of read barrier.  In the case
>       where two loads are performed such that the second depends on the result
>       of the first (eg: the first load retrieves the address to which the second
> -     load will be directed), a data dependency barrier would be required to
> +     load will be directed), an address-dependency barrier would be required to
>       make sure that the target of the second load is updated after the address
>       obtained by the first load is accessed.
>  
> -     A data dependency barrier is a partial ordering on interdependent loads
> +     An address-dependency barrier is a partial ordering on interdependent loads
>       only; it is not required to have any effect on stores, independent loads
>       or overlapping loads.

I suppose this isn't really a comment on your patch, as I much prefer the
updated terminology, but the way this section is now worded really makes it
sounds like address dependencies only order load -> load, whereas they
equally order load -> store. Saying that "An address-dependency barrier...
is not required to have any effect on stores" is really confusing to me: the
barrier should only ever be used in conjunction with an address-dependency
_anyway_ so whether or not it's the barrier or the dependency giving the
order is an implementation detail.

Perhaps the barrier should be called a "Read-read-address-dependency
barrier", an "Address-dependency read barrier" or even a "Consume barrier"
(:p) instead? Dunno, Alan is normally much better at naming these things
than I am.

Alternatively, maybe we should be removing the historical stuff from the
document altogether if it's no longer needed. We don't have any occurrences
of read_barrier_depends() anymore, so why confuse people with it?

Will
