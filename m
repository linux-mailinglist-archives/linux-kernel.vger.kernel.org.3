Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8154FF8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiDMOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDMOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D060AB6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0069261B16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C594C385A4;
        Wed, 13 Apr 2022 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649858850;
        bh=tpnTO7ifhPyjScygUAYWKtoTBApBszAm9vZ8/m0rpwI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nHhG27wYTs7bWZi6v0dVsVL9a8EKB3vaMEybk+PKP2cLItIg61MfjJQ+/CatpUPrj
         Bd5q9Mxa5+Re0xcbny0G8Fp6szFH1h2FUpD4TNk/fbh+itfdENUUWkJY7S+MTefk89
         CQJyUueVzf0EmW8QSLxO+/KOGzceXfXfpLWvCEBgewzp5ZKBRktIlaFDa2SXuWuKI+
         1fHFAID6yEv8jmgoUPBadZzCBmyUkn59Nt+RMcK/VHKLVCjP93DlYRHdw4Fbk0XtYy
         zd/kgG/FmwNH9mR8mxtSvZAJMxvtJcRBLm2ZjbuyKcsTFC8YVS42TI0Vi6C9WXlous
         SG7UT/+MwRziA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC0D15C0134; Wed, 13 Apr 2022 07:07:29 -0700 (PDT)
Date:   Wed, 13 Apr 2022 07:07:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220413140729.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220409071740.6024-1-hdanton@sina.com>
 <20220413113711.1263-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413113711.1263-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 07:37:11PM +0800, Hillf Danton wrote:
> On Sat, 9 Apr 2022 08:56:12 -0700 Paul E. McKenney wrote:
> > On Sat, Apr 09, 2022 at 03:17:40PM +0800, Hillf Danton wrote:
> > > On Fri, 8 Apr 2022 10:53:53 -0700 Kalesh Singh wrote
> > > > Thanks for the discussion everyone.
> > > > 
> > > > We didn't fully switch to kthread workers to avoid changing the
> > > > behavior for users that dont need this low latency exp GPs. Another
> > > > (and perhaps more important) reason is because kthread_worker offers
> > > > reduced concurrency than workqueues which Pual reported can pose
> > > > issues on systems with a large number of CPUs.
> > > 
> > > A second ... what issues were reported wrt concurrency, given the output
> > > of grep -nr workqueue block mm drivers.
> > > 
> > > Feel free to post a URL link to the issues.
> > 
> > The issues can be easily seen by inspecting kthread_queue_work() and
> > the functions that it invokes.  In contrast, normal workqueues uses
> > per-CPU mechanisms to avoid contention, as can equally easily be seen
> > by inspecting queue_work_on() and the functions that it invokes.
> 
> The worker from kthread_create_worker() roughly matches unbound workqueue
> that can get every CPU overloaded, thus the difference in implementation
> details between kthread worker and WQ worker (either bound or unbound) can
> be safely ignored if the kthread method works, given that prioirty is barely
> a cure to concurrency issues.

Please look again, this time taking lock contention in to account,
keeping in mind that systems with several hundred CPUs are reasonably
common and that systems with more than a thousand CPUs are not unheard of.

							Thanx, Paul

> Hillf
> > 
> > Please do feel free to take a look.
> > 
> > If taking a look does not convince you, please construct some in-kernel
> > benchmarks to test the scalability of these two mechanisms.  Please note
> > that some care will be required to make sure that you are doing a valid
> > apples-to-apples comparison.
> > 
> > 							Thanx, Paul
> > 
