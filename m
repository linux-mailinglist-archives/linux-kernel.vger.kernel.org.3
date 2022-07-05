Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031BF5663EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiGEHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiGEHUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:20:40 -0400
Received: from outbound-smtp24.blacknight.com (outbound-smtp24.blacknight.com [81.17.249.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B73B487
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:20:39 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id A3646C0C3B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:20:37 +0100 (IST)
Received: (qmail 23578 invoked from network); 5 Jul 2022 07:20:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Jul 2022 07:20:37 -0000
Date:   Tue, 5 Jul 2022 08:20:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/7] mm/page_alloc: Protect PCP lists with a spinlock
Message-ID: <20220705072034.GC27531@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
 <20220624125423.6126-6-mgorman@techsingularity.net>
 <5f464a89-91b4-f432-99a9-45968fc80631@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5f464a89-91b4-f432-99a9-45968fc80631@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 02:31:17PM +0200, Vlastimil Babka wrote:
> On 6/24/22 14:54, Mel Gorman wrote:
> > Currently the PCP lists are protected by using local_lock_irqsave to
> > prevent migration and IRQ reentrancy but this is inconvenient.  Remote
> > draining of the lists is impossible and a workqueue is required and every
> > task allocation/free must disable then enable interrupts which is
> > expensive.
> > 
> > As preparation for dealing with both of those problems, protect the lists
> > with a spinlock.  The IRQ-unsafe version of the lock is used because IRQs
> > are already disabled by local_lock_irqsave.  spin_trylock is used in
> > preparation for a time when local_lock could be used instead of
> > lock_lock_irqsave.
> 
>   ^ local_lock_irqsave?
> 

More appropriate given how the series evolved would be;

spin_trylock is used in combination with local_lock_irqsave() but later
will be replaced with a spin_trylock_irqsave when the local_lock is
removed.

-- 
Mel Gorman
SUSE Labs
