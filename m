Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EA54D159
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355407AbiFOTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiFOTJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:09:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E869393DC;
        Wed, 15 Jun 2022 12:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E1CDB82168;
        Wed, 15 Jun 2022 19:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6662C34115;
        Wed, 15 Jun 2022 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655320176;
        bh=8J1oUy3Hn+J2l+W/L3+RREE0V/VeAu707W0U1jX7HOs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f9BrWPSgmtrFmoinhMd25QuAigfiIZxK9mMMGkFp+TCzbtGrp/BKppf2hpfnyaMdx
         s11K4I2KNOnx6pywjqEA9SR/P6wfR6AuJyEmSnkrXMDC6nZLwmZdxwLFTCnh4HCzEe
         sSWgM+cQi1BVv2slbBU32My9L+k6DCWGMFlPr6qZbkFpS4VKOyillaNjVibTrbd7mJ
         MEY/AV6iNHQVs4Bt/xfIM+85YoidDa7Q3Rtt1Ajfofuuu2Bg/e5ndL4MlC15/z27GE
         zd2A9wHS3uJnUZBTL0IFBdqh4qHiAqCGYsDR0xUmaXAyyzhEzN2GjAw/f8NQnyREpa
         Vf+i0Zxkvv9+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 251865C014C; Wed, 15 Jun 2022 12:09:36 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:09:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     john.ogness@linutronix.de, pmladek@suse.com, dave@stgolabs.net,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH linux-next] RFC: torture: add pr_flush to flush the
 results to console
Message-ID: <20220615190936.GA713726@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220615003733.16447-1-zhouzhouyi@gmail.com>
 <20220615051521.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wCos5xupRQ2LbJtaLVN1a7i0D5kwaVTq9DEov8C46Gkw@mail.gmail.com>
 <20220615135220.GI1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615135220.GI1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 06:52:20AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 15, 2022 at 08:36:54PM +0800, Zhouyi Zhou wrote:
> > On Wed, Jun 15, 2022 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Jun 15, 2022 at 08:37:33AM +0800, zhouzhouyi@gmail.com wrote:
> > > > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > >
> > > > currently tools/testing/selftests/rcutorture/bin/torture.sh reports
> > > > false positve because of kthread printing.
> > > >
> > > > Commit "printk: add functions to prefer direct printing" (2bb2b7b57f812)
> > > > have added functions to prefer direct printing activated for the primary
> > > > import messages.
> > > >
> > > > Meanwhile adding printk_prefer_direct_enter/exit to
> > > > torture_cleanup_begin/end still can't eliminate the false positives
> > > > for a hundred percent.
> > > >
> > > > This patch add pr_flush to torture_cleanup_end because the latter
> > > > is sleepable.
> > > >
> > > > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >
> > > Just the one Signed-off-by suffices.  ;-)
> > Thank Paul for your guidance ;-)
> > >
> > > > ---
> > > >  kernel/torture.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/kernel/torture.c b/kernel/torture.c
> > > > index 789aeb0e1159..b51e42463a67 100644
> > > > --- a/kernel/torture.c
> > > > +++ b/kernel/torture.c
> > > > @@ -878,6 +878,7 @@ void torture_cleanup_end(void)
> > > >       mutex_lock(&fullstop_mutex);
> > > >       torture_type = NULL;
> > > >       mutex_unlock(&fullstop_mutex);
> > > > +     pr_flush(1000, true);
> > >
> > > But in this case, the kernel keeps on running, correct?  So won't the
> > > output appear over time?  All of printk()'s kthreads are still running
> > > after all.
> > I am doing research on linux-next following your guidance on my Dell
> > PowerEdge R720 server:
> > #git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git/
> > #cd linux-next
> > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > after about 14 hours, the test result show that there have been about
> > 17 failures, I examine the corresponding console.log, and find the
> > failures are caused by following reason:
> > before the message output by
> > rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
> > SUCCESS") has reached serial console, torture_shutdown invoked
> > kernel_power_off(),
> 
> Ah, got it!  And good show tracking this down, by the way.
> 
> Does this workaround commit on -rcu do the trick for you?
> 
> 704ae8dcda84 ("torture: Flush printk() buffers before powering off")
> 
> The printk() guys are looking at fixes within the printk() system
> as well:
> 
> https://lore.kernel.org/all/87tu8pgcj0.fsf@jogness.linutronix.de/
> https://lore.kernel.org/all/YqdSw%2FfJvnkRbjvc@alley/

And Petr has posted a more official fix, which I have queued on -rcu
for testing at branch pmladek.2022.06.15a.

							Thanx, Paul

> > so the message "End of test: SUCCESS" has not chance of reaching
> > console.log of host machine.
> > 
> > Then I add printk_prefer_direct_enter/exit to
> > torture_cleanup_begin/end, again I invoke
> > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > after about 14 hours, the test result show that there have been about
> > 5 failures,
> > 
> > Then I add a debug statement after
> > rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
> > SUCCESS") which sends the debug string ("hello world") to
> > uart_console_write directly, again I invoke
> > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > There is "hello world" in console.log but no "End of test" strings.
> > 
> > So I guess even with printk_prefer_direct_enter/exit to
> > torture_cleanup_begin/end,  our main shutdown thread has failed in
> > competition for console lock (printk.c):
> > 2401 if (console_trylock_spinning())
> > 2402     console_unlock();
> > 
> > Then I add pr_flush to torture_cleanup_end
> > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > after 14 hours
> > all 49 tests are success
> > >
> > > Or do you have a use case that requires that the output appear sooner
> > > than it does?  If so, please let me know what that is.
> > Thank Paul for your patience,
> > ./tools/testing/selftests/rcutorture/bin/torture.sh is the only tool
> > that I use.
> > 
> > I am very interested in this topic, and very glad to do further
> > experiments under your guidance ;-)
> 
> Or are you already running with that commit or one of those patches?
> They are working reliably for me (so far, anyway), but maybe more is
> needed in some cases.
> 
> 							Thanx, Paul
> 
> > Sincerely yours
> > Thanks
> > Zhouyi
> > >
> > >                                                         Thanx, Paul
> > >
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(torture_cleanup_end);
> > > >
> > > > --
> > > > 2.25.1
> > > >
