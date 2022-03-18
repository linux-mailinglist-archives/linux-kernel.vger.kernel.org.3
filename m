Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C284DDCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiCRPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiCRPaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC1BF002
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD3560B71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB7C340E8;
        Fri, 18 Mar 2022 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647617327;
        bh=q4+oI4skmfy4MLCDnMmB+ppfg2hO+b8Zapx6UfbH3UE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QXMii/y84Xw2j1PwicNWM8BY0LaRJ1J1wf5FX/ylKKAFYHLkFE9WY8rRTZ7MYVwtI
         hOAb624AnM5AVM55+gadR1yHKNp7321yNkl/ktwqskrJC6ABCmtrVqJVX0sHNZTUg8
         a1PbiSJWyIES+88rm0K8bQokhPIgc91fmj32NgpFGUfRxvVoInQbHn1nVEC379vbvt
         j0ZKzC9mSEVtQVlKBEhkEq5ZhiAliKoNWQo3gavvHBzRt6DlxbRlMXAcA4DmYT3iZ6
         cEOKQ0k0aNGtpiYJNllRg8OTkg6sZCvcsXkG11zm9MkfR9qpprhR+xLnrQTV9fmftr
         gLINnZwIkgZhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AAA5B5C04E0; Fri, 18 Mar 2022 08:28:46 -0700 (PDT)
Date:   Fri, 18 Mar 2022 08:28:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [fixup! EXP srcu]  7bf8d644f8:
 WARNING:at_kernel/rcu/srcutree.c:#process_srcu
Message-ID: <20220318152846.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220312155919.GD1189@xsang-OptiPlex-9020>
 <20220314203814.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220316165342.GA1931135@paulmck-ThinkPad-P17-Gen-1>
 <20220317071608.GB735@xsang-OptiPlex-9020>
 <20220317180129.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <20220318061603.GC12658@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318061603.GC12658@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 02:16:03PM +0800, Oliver Sang wrote:
> Hi Paul,
> 
> On Thu, Mar 17, 2022 at 11:01:29AM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 17, 2022 at 03:16:08PM +0800, Oliver Sang wrote:
> > > hi, Paul,
> > > 
> > > On Wed, Mar 16, 2022 at 09:53:42AM -0700, Paul E. McKenney wrote:
> > > > > 
> > > > > I had a feeling that the simple fix wasn't going to cut it, so thank you
> > > > > for finding a scenario that proves that to be the case.  Fix in progress,
> > > > > to be folded into the original with attribution.
> > > > 
> > > > OK, the attribution isn't quite there yet, but the squished-together
> > > > commit is here:
> > > > 
> > > > ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> > > > 
> > > > Does this version behave better for you?
> > > 
> > > we tested this commit, found the issue gone.
> > > please be noted the issue on 7bf8d644f8 is random and ~25% rate.
> > > so I queued to run 100 times for this new commit, which is finally clean
> > > according to tests.
> > > 
> > > =========================================================================================
> > > compiler/kconfig/rootfs/sleep/tbox_group/testcase:
> > >   gcc-9/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/1/vm-snb/boot
> > > 
> > > commit:
> > >   feebd043ec6b ("Revert "srcu: Avoid expedited GPs and blocking readers from consuming CPU"")
> > >   7bf8d644f869 ("fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls")
> > >   ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> > > 
> > > feebd043ec6b9eab 7bf8d644f869260f63eaaedebab ea0098f191152c7fe3db5181a2e
> > > ---------------- --------------------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> > >            |             |             |             |             |
> > >            :16          25%           4:16           0%            :100   dmesg.RIP:process_srcu
> > >            :16          25%           4:16           0%            :100   dmesg.WARNING:at_kernel/rcu/srcutree.c:#process_srcu
> > 
> > Thank you for testing this!  Tested-by?
> 
> sure!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>
> 
> (and will add this in early mail about testing if I have enough confidence
> in the future :) Thanks)

Please do!  ;-)

And I have it down for my next rebase.

							Thanx, Paul
