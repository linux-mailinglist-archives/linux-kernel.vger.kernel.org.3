Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CEF551F59
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbiFTOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiFTOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:50:32 -0400
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA62C41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:09:53 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 4E1A118E00A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:09:52 +0100 (IST)
Received: (qmail 15998 invoked from network); 20 Jun 2022 14:09:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jun 2022 14:09:51 -0000
Date:   Mon, 20 Jun 2022 15:09:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Zhenhua Ma <mazhenhua@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: Lockups due to "locking/rwsem: Make handoff bit handling more
 consistent"
Message-ID: <20220620140950.GB15453@techsingularity.net>
References: <20220617134325.GC30825@techsingularity.net>
 <b92bdb56-bfed-9cd2-5eb2-0b96a68b21d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b92bdb56-bfed-9cd2-5eb2-0b96a68b21d8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:29:20AM -0400, Waiman Long wrote:
> > The C file and shell script to run it are attached.
> > 
> Thanks for the reproducer and I will try to reproduce it locally.
> 
> It is a known issue that I have receive similar report from an Oracle
> engineer. That is the reason I posted commit 1ee326196c66 ("locking/rwsem:
> Always try to wake waiters in out_nolock path") that was merged in v5.19. I
> believe it helps but it may not be able to eliminate all possible race
> conditions. To make rwsem behave more like before commit d257cc8cb8d5
> ("locking/rwsem: Make handoff bit handling more consistent"), I posted a
> follow-up patch
> 
> https://lore.kernel.org/lkml/20220427173124.1428050-1-longman@redhat.com/
> 
> But it hasn't gotten review yet.
> 

FWIW, the patch passed the test case when applied to both 5.18 and
5.19-rc3.

-- 
Mel Gorman
SUSE Labs
