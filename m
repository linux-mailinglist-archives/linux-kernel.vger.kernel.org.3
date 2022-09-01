Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC035A9AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIAOmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiIAOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:42:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032B33432;
        Thu,  1 Sep 2022 07:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E125B8279B;
        Thu,  1 Sep 2022 14:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E89EC433D6;
        Thu,  1 Sep 2022 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662043319;
        bh=WfNj29C+5KHDK6bBnFVAMPOGb27NTNmhf37YXvmoPfc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=adYhbO/Wv20BG1IqtNDoevPQqjrZA0nhagO6vPmMST+sB3scv1Ne4V8jcz602+U+Q
         SLqE6g0fKuZ+6n4pEX/+L27KcssAwpwa5Sw9oF6oJUyQk+y9yL6go5KBdq/avS47Ot
         zGZPujMNVUcytPPwsWDZdhFbB6VQ2uSzvXzQeS/mPHyMJ+5UiMZDlYzRZblbDKdu3e
         55G69OvZfPNTLaTVv5R9Pic62Vba0OwiQ5j7jUtLI18RuUlPKrx+htzSunt6dJCaD3
         dDfqlQdK/4maD7CrdzKELletHw2jjXdzaYHSg2KX0mCkrcf+kY/4ZMs6y7Ynxq9tC6
         csSUHoOubDTkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B84C95C05A0; Thu,  1 Sep 2022 07:41:58 -0700 (PDT)
Date:   Thu, 1 Sep 2022 07:41:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220901144158.GV6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
 <20220901112947.GA105556@lothringen>
 <YxCejoKH8dGIeW22@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxCejoKH8dGIeW22@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:59:10PM +0200, Uladzislau Rezki wrote:
> On Thu, Sep 01, 2022 at 01:29:47PM +0200, Frederic Weisbecker wrote:
> > On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
> > > Hello, Frederic.
> > > 
> > > > 
> > > > Although who knows, may be some periodic file operation while idle are specific
> > > > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > > periods associated.
> > > > 
> > > > 
> > > Everything related to lazy call-backs is about not waking "nocb"
> > > kthreads in order to offload one or i should say few callbacks
> > > because it is more or less useless. Currently if incoming callback
> > > is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> > > to offload.
> > 
> > Not sure this is only about not waking "nocb" kthreads. The grace period
> > kthread is also awaken in !NOCB and has quite some work to do. And there,
> > having a server expands the issue because you may have a lot of CPUs's extended
> > quiescent states to check.
> > 
> I mean here the following combination: NOCB + call_rcu_lazy() tandem.
> The !NOCB is not about power save, IMHO. Because it implies callbacks
> to be processed on CPUs they are landed.
> 
> In this scenario you can not let the EAS scheduler to find a more
> efficient CPU for further handling.

Just to follow up, Uladzislau and others did some detailed performance
analysis of NOCB on Android.  Of course, this analysis might or might
not carry over to servers, but it was pretty detailed.

							Thanx, Paul

> > Also in !NOCB, pending callbacks retain the timer tick of a CPU (see
> > rcu_needs_cpu()), and cpuidle relies on the tick to be stopped before
> > allowing the CPU into low power mode. So a lazy callback may delay a CPU from
> > entering into low power mode for a few milliseconds.
> > 
> > And I can observe those retained ticks on my idle box.
> >
> Maybe !NOCB is more about performance. But i have no clue about
> workloads and if such workloads exist nowadays.
> 
> --
> Uladzislau Rezki
