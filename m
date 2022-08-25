Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7A5A0C42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiHYJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiHYJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:11:32 -0400
Received: from outbound-smtp10.blacknight.com (outbound-smtp10.blacknight.com [46.22.139.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C1352090
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:11:28 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 75DDA1C3E90
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:11:27 +0100 (IST)
Received: (qmail 13199 invoked from network); 25 Aug 2022 09:11:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Aug 2022 09:11:27 -0000
Date:   Thu, 25 Aug 2022 10:11:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-ID: <20220825091051.7awtjp25yh7bv3xf@techsingularity.net>
References: <20220824141802.23395-1-mgorman@techsingularity.net>
 <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:58:26PM -0600, Yu Zhao wrote:
> On Wed, Aug 24, 2022 at 8:18 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> > allocating from the PCP must not re-enter the allocator from IRQ context.
> > In each instance where IRQ-reentrancy is possible, the lock is acquired using
> > pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> > is impossible.
> >
> > Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> > case at the cost of some IRQ allocations taking a slower path. If the PCP
> > lists need to be refilled, the zone lock still needs to disable IRQs but
> > that will only happen on PCP refill and drain. If an IRQ is raised when
> > a PCP allocation is in progress, the trylock will fail and fallback to
> > using the buddy lists directly. Note that this may not be a universal win
> > if an interrupt-intensive workload also allocates heavily from interrupt
> > context and contends heavily on the zone->lock as a result.
> 
> Hi,
> 
> This patch caused the following warning. Please take a look.
> 

Thanks. I see the patch is already taken out of mm-unstable so back to
the drawing board!

-- 
Mel Gorman
SUSE Labs
