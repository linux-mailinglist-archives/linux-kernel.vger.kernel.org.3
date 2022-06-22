Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4847554EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359104AbiFVPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358972AbiFVPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:09:50 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E879A3DDFA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:09:48 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 3F06B1C37B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:09:47 +0100 (IST)
Received: (qmail 13388 invoked from network); 22 Jun 2022 15:09:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Jun 2022 15:09:46 -0000
Date:   Wed, 22 Jun 2022 16:09:44 +0100
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
Message-ID: <20220622150944.GG15453@techsingularity.net>
References: <20220617134325.GC30825@techsingularity.net>
 <b92bdb56-bfed-9cd2-5eb2-0b96a68b21d8@redhat.com>
 <20220620140950.GB15453@techsingularity.net>
 <2c4084e3-9bd0-76ef-a11c-857de96a83e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2c4084e3-9bd0-76ef-a11c-857de96a83e5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:32:12PM -0400, Waiman Long wrote:
> On 6/20/22 10:09, Mel Gorman wrote:
> > On Fri, Jun 17, 2022 at 10:29:20AM -0400, Waiman Long wrote:
> > > > The C file and shell script to run it are attached.
> > > > 
> > > Thanks for the reproducer and I will try to reproduce it locally.
> > > 
> > > It is a known issue that I have receive similar report from an Oracle
> > > engineer. That is the reason I posted commit 1ee326196c66 ("locking/rwsem:
> > > Always try to wake waiters in out_nolock path") that was merged in v5.19. I
> > > believe it helps but it may not be able to eliminate all possible race
> > > conditions. To make rwsem behave more like before commit d257cc8cb8d5
> > > ("locking/rwsem: Make handoff bit handling more consistent"), I posted a
> > > follow-up patch
> > > 
> > > https://lore.kernel.org/lkml/20220427173124.1428050-1-longman@redhat.com/
> > > 
> > > But it hasn't gotten review yet.
> > > 
> > FWIW, the patch passed the test case when applied to both 5.18 and
> > 5.19-rc3.
> 
> Thanks for running the test. Do you mean that both 5.18 and 5.19-rc3 fail
> the test and they pass only after applying the patch?
> 

Yes.

> Anyway, I am not able to reproduce the failure in both 5.18 and 5.19-rc3.
> Perhaps it is due to the difference in the running environment, i.e. gcc,
> glibc, etc. What operating environment (SuSE version) do you use to
> reproduce the failure? I used RHEL8 which is the most convenient one for me.
> 

It was reproduced on Leap 15.4 with a 2-socket machine with 40 cores
(SMT-2). The kernel built was based on the distribution config. gcc
version was based on 7.5.0.

> BTW, do you mind if I put down your name with a "Tested-by:" tag to the
> patch?
> 

No problem.

-- 
Mel Gorman
SUSE Labs
