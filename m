Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3D5A9D82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiIAQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiIAQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:52:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE39979DA;
        Thu,  1 Sep 2022 09:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C59D4CE28D5;
        Thu,  1 Sep 2022 16:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF7DC433C1;
        Thu,  1 Sep 2022 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662051130;
        bh=fwnNs67ZFBWw6DkWLKvb+7JiRojuVmxIxKtpiQTBCNM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QBTC3Pku9CajQUNAdqMXreZd11O7yedw+JlN+d8sLEP/CH1T6K9M8657vJDcnjl51
         FDATmpHC2FCF4//31dZAq4KzkNfo13Waw7WMQTsw3vvojM6++vPGgI8yO6zliq0rd5
         jPNnxd9OkDjW1aLFcJjrzB2VNOG+AERp2ba5vrlEelbdnPL6S/M+2qhgyYW/a/c88x
         S0qXBtWdxFtFjPl5C8ZNorSsKyvZsw4dk/W0eXwjsD+6v7THXKchtHvhHwO1loaQUa
         j1qy4QNzSwMtNS23pqcvCN/jo15WMkidyhhBO3AfGCYx4Ua87WlqzgzcJm2VvyilUX
         zi10BlrHEw2xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BCBA15C0691; Thu,  1 Sep 2022 09:52:09 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:52:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20220901165209.GA6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
 <20220901112947.GA105556@lothringen>
 <YxCejoKH8dGIeW22@pc636>
 <20220901144158.GV6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901153034.GA106955@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901153034.GA106955@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:30:34PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 07:41:58AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 01, 2022 at 01:59:10PM +0200, Uladzislau Rezki wrote:
> > > On Thu, Sep 01, 2022 at 01:29:47PM +0200, Frederic Weisbecker wrote:
> > > > On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
> > > > > Hello, Frederic.
> > > > > 
> > > > > > 
> > > > > > Although who knows, may be some periodic file operation while idle are specific
> > > > > > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > > > > periods associated.
> > > > > > 
> > > > > > 
> > > > > Everything related to lazy call-backs is about not waking "nocb"
> > > > > kthreads in order to offload one or i should say few callbacks
> > > > > because it is more or less useless. Currently if incoming callback
> > > > > is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> > > > > to offload.
> > > > 
> > > > Not sure this is only about not waking "nocb" kthreads. The grace period
> > > > kthread is also awaken in !NOCB and has quite some work to do. And there,
> > > > having a server expands the issue because you may have a lot of CPUs's extended
> > > > quiescent states to check.
> > > > 
> > > I mean here the following combination: NOCB + call_rcu_lazy() tandem.
> > > The !NOCB is not about power save, IMHO. Because it implies callbacks
> > > to be processed on CPUs they are landed.
> > > 
> > > In this scenario you can not let the EAS scheduler to find a more
> > > efficient CPU for further handling.
> > 
> > Just to follow up, Uladzislau and others did some detailed performance
> > analysis of NOCB on Android.  Of course, this analysis might or might
> > not carry over to servers, but it was pretty detailed.
> 
> Sure I certainly don't deny the benefit on Android and similar workload.
> What I'm worried about is that we are making this feature too specialized
> when it may deserve to be made more generic.
> 
> I'm not convincing anyone though and I don't have the means to provide
> numbers, I would need to produce an actual !NOCB implementation for that.

I have not yet given up on thinking about what measurements I could take
that would be convincing within Meta.  Maybe some idea will present itself
on the plane.  If nothing else, exploratory measurements with rcutop.

> So I'm not entirely comfortable but I'm going to review the current patchset
> anyway and once it lands -rcu I'll try to hack a quick !NOCB implementation
> for measurements purpose.

That sounds like a very good approach!

							Thanx, Paul
