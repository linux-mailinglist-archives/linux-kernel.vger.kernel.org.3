Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7856BD92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiGHP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiGHP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:58:40 -0400
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C815A2F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:58:38 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 30C05CABF0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:58:37 +0100 (IST)
Received: (qmail 2989 invoked from network); 8 Jul 2022 15:58:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jul 2022 15:58:37 -0000
Date:   Fri, 8 Jul 2022 16:58:35 +0100
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
Subject: Re: [PATCH] mm/page_alloc: replace local_lock with normal spinlock
 -fix -fix
Message-ID: <20220708155835.GK27531@techsingularity.net>
References: <20220708144406.GJ27531@techsingularity.net>
 <a78f95e9-298a-bc97-9776-14e0f02f62b9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a78f95e9-298a-bc97-9776-14e0f02f62b9@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:54:47PM +0200, Vlastimil Babka wrote:
> On 7/8/22 16:44, Mel Gorman wrote:
> > pcpu_spin_unlock and pcpu_spin_unlock_irqrestore both unlock
> > pcp->lock and then enable preemption. This lacks symmetry against
> > both the pcpu_spin helpers and differs from how local_unlock_* is
> > implemented. While this is harmless, it's unnecessary and it's generally
> > better to unwind locks and preemption state in the reverse order as
> > they were acquired.
> 
> Hm I'm confused, it seems it's done in reverse order (which I agree with)
> before this -fix-fix, but not after it?
> 
> before, pcpu_spin_lock() (and variants) do pcpu_task_pin() and then
> spin_lock() (or variant), and pcpu_spin_unlock() does spin_unlock() and then
> pcpu_task_unpin(). That seems symmetrical, i.e. reverse order to me? And
> seems to match what local_lock family does too.
> 

You're not confused, I am. The patch and the changelog are outright brain
damage from excessive context switching and a sign that it's time for the
weekend to start.

Sorry for this absolute misfortune.

-- 
Mel Gorman
SUSE Labs
