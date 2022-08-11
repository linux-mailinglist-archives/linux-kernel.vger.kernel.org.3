Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456A158F675
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiHKDqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiHKDq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:46:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C328277E;
        Wed, 10 Aug 2022 20:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9F4DB81EFF;
        Thu, 11 Aug 2022 03:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8347CC433C1;
        Thu, 11 Aug 2022 03:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660189585;
        bh=Xxh06Q4Yhsx+3pyvHZwT7mx+roo9eT6HXDouomooxbY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M5OWs5FVH2u5LHi69HxnvmDrLH/qE8Oqox2gVylYWe8DkmluDRIQFromGKuBxPYWc
         MJKREDlnSfFuOULgt+lXcsBWY2/IpC56h4egROTTFLFHR5EOf6uPlfH0GP0Pk+zR8a
         6AzGJFqwewVmGdreUemI/skHZK1332XoKMiC21fYy4LWg2siqoJbPw+X5U0WJlr38p
         Yi5+yfKLs79fz5PFkHW0F5Hc9PFvj9xNuBTnI6dn/lG31CAnxJuov6dn31hypDZ0YZ
         U8OzBBCIE81PSgZaOsgDXAL/UYeD7SdqzwJ8q9yOZNBKFKE4tVcbXW/NB8AkLUyrLj
         ANJzdGirn/npg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1FD205C128A; Wed, 10 Aug 2022 20:46:25 -0700 (PDT)
Date:   Wed, 10 Aug 2022 20:46:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and
 miscellaneous fixes
Message-ID: <20220811034625.GX2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <308db02b-b56d-2df1-ee33-7f66e6a85f63@joelfernandes.org>
 <87663566-ed67-fee8-4598-13591f2f072b@joelfernandes.org>
 <20220811025152.GW2125313@paulmck-ThinkPad-P17-Gen-1>
 <07976e09-214d-0d1b-6803-23754a9f3d8a@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07976e09-214d-0d1b-6803-23754a9f3d8a@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:22:13PM -0400, Joel Fernandes wrote:
> 
> 
> On 8/10/2022 10:51 PM, Paul E. McKenney wrote:
> > On Wed, Aug 10, 2022 at 10:31:56PM -0400, Joel Fernandes wrote:
> >>
> >>
> >> On 8/10/2022 10:23 PM, Joel Fernandes wrote:
> >>>
> >>>
> >>> On 8/8/2022 11:45 PM, Joel Fernandes (Google) wrote:
> >>>> Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
> >>>>  https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/
> >>>>
> >>>> I just started working on this again while I have some time during paternity
> >>>> leave ;-) So I thought I'll just send it out again. No other changes other
> >>>> than that 1 debug patch I added on the top.
> >>>>
> >>>> Next I am going to go refine the power results as mentioned in Paul's comments
> >>>> on the last cover letter.
> >>>
> >>> Side note: Here is another big selling point for call_rcu_lazy().
> >>> Instead of _lazy(), if you just increased jiffies_till_first_fqs, and
> >>> slowed *all* call_rcu() down to achieve the same effect, that would
> >>> affect percpu refcounters switching to atomic-mode, for example.
> >>>
> >>> They switch to atomic mode by calling __percpu_ref_switch_mode() which
> >>> is called by percpu_ref_switch_to_atomic_sync().>
> >>> This will slow this call down for the full lazy duration which will slow
> >>> down suspend in blk_pre_runtime_suspend().
> >>
> >> Correction while I am going on the record (got to be careful these
> >> days). It *might* slow down RCU for the full lazy duration, unless of
> >> course a fly-by rescue call_rcu() comes in.
> > 
> > Just unload a module, which if I remember correctly invokes rcu_barrier().
> > Lots of rescue callbacks.  ;-)
> 
> Haha. Yes I suppose the per-cpu atomic switch paths can also invoke
> rcu_barrier() but I suspect somebody might complain about IPIs :-P

There is always a critic!  ;-)

							Thanx, Paul
