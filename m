Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E384F4FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840230AbiDFBHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446546AbiDEPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A553220F0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:17:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D5FF210FD;
        Tue,  5 Apr 2022 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649168267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvTEfQ7kJIqh1i2okodWWZaOv98eaMhKZYSbbqfbqYA=;
        b=d9XBmlgmY3A70bvfCltmJ743BPcZgNoVojfxXvCHM8d7PWevIOpBrYxcAk0yedES0cZCmP
        CNOw62MQnC5Y4eifXYgoEwgM3YY+C/9/0UUoSLlmAslbdcz2H+losrp4380tiGFQD+6SFh
        7K1OE/Qh8ajN+ALwVhvhTrWzzaaXa5M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2921A3B8A;
        Tue,  5 Apr 2022 14:17:46 +0000 (UTC)
Date:   Tue, 5 Apr 2022 16:17:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mm: swap: locking in release_pages()
Message-ID: <YkxPh8nHhvT7t1OW@dhcp22.suse.cz>
References: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
 <YkwdRnuQBjoJ01YK@dhcp22.suse.cz>
 <dc5eb22d-5389-bacb-3756-253e774a8394@nokia.com>
 <Ykwr7OHllqM+Dpii@dhcp22.suse.cz>
 <404b3d6e-510e-c15f-a28b-7425bcc67cc2@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404b3d6e-510e-c15f-a28b-7425bcc67cc2@nokia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-04-22 16:00:54, Alexander Sverdlin wrote:
> Hello Michal!
> 
> On 05/04/2022 13:45, Michal Hocko wrote:
> >>>> 1. Crash of v5.4.170 on an ARM32 machine:
> >>>>
> >>>> Unable to handle kernel NULL pointer dereference at virtual address 00000104
> >>>> pgd = e138149d
> >>>> [00000104] *pgd=84d2fd003, *pmd=8ffd6f003
> >>>> Internal error: Oops: a07 [#1] PREEMPT SMP ARM
> >>>> ...
> >>>> CPU: 1 PID: 6172 Comm: AaSysInfoRColle Tainted: G    B      O      5.4.170-... #1
> >>>> Hardware name: Keystone
> >>>> PC is at release_pages+0x194/0x358
> >>>> LR is at release_pages+0x10c/0x358
> >>> Which LOC does this correspond to? (faddr2line should give you a nice
> >>> output).
> >> Sorry, I forgot this info in the initial report:
> >>
> >> this is indeed the del_page_from_lru_list() in this crash.
> > Could you be more specific please? Is the problem in list_del or
> > update_lru_size?
> 
> static inline void __list_del(struct list_head * prev, struct list_head * next)
> {
>         next->prev = prev;    <--

OK, I see. AFAICS this means that entry->next is NULL which doesn't look
like somebody else has done list_del as that would leave poison values
behind. Maybe somebody has clobbered the page state.

In any case I would recommend reproducing without stable patches and/or
with the current Linus tree.
-- 
Michal Hocko
SUSE Labs
