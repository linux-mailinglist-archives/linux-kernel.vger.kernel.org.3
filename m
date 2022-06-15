Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6382C54D28D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbiFOU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiFOU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:28:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E7B35ABE;
        Wed, 15 Jun 2022 13:28:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s12so25471393ejx.3;
        Wed, 15 Jun 2022 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8r+hzet5t8kQ9FT7Pu1Ip98hiFGbKJdzOlAKlpJMkVk=;
        b=CyC4ObBITCEx03cJ+jHHKSflHxNM9MjGRpdEtxv5uX1nBpELCY85SMAVyymEE7lhxj
         noa/brlVupI+G847Uer/1UtQOYKhP4AQJcUX9tm3dle2pFVKBnYcxrAd0vCVo04Lmb+f
         w4UcRyvQUyz9AfxIpx49xKWt/zfKoO4g8gyaSMyk5qWokALZqJKtB8sstf6UHZZpxBQp
         72gwHpcFohzN6o/QP+/l+xcc4Z4Uko8WuVhHc/uCCcsqvsCdHxsCCOUZ8SqmubdaMAJz
         sX74eaqiVVp3aFw3lJYG3MPWIflWgY8myiSBd5caGXpM0wnaPNjDez+qIMnpdgu8D7a6
         31kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8r+hzet5t8kQ9FT7Pu1Ip98hiFGbKJdzOlAKlpJMkVk=;
        b=lI07+NgjeixnKejTCGN4yfz476Z8JOB8vhKrZ9IOJuAO3SyDnD1ayu0fUPe9uE0Mfo
         VLgAYNMAGK3b7gocIg0uh2lIf5alvKdP9CS61t4T/UcVfOZkWzXS1nYLsUj9FqTO5E7P
         ri2rBFqO50eKqQ8ecwFwG+ViH3HPTGURIk8QPf72wCCew/o7F9cfv4kN82zmm0v9dcbQ
         tDvwKP1QvQrEGlxViSMONWPx3xliJ3qYIopTIV7+fdQpRIrGcByovFghlxLvKl7x9KDB
         bULJObPw8sYU1NCpWO4IN3G39hCCJwM/zCqcUu59EeC67qtJeYliQxsgmwbH+TAi+3dk
         eNIQ==
X-Gm-Message-State: AJIora8jf1Pv15tE1MiMfIeEf/mImZyzGiMwx9AfCKdjPrvmuLK9H4PQ
        TqL0FxVge9YJfHLPZzXRkk6ie3RaySktQQwu4qIlb43gLJs=
X-Google-Smtp-Source: AGRyM1tNPxpDe4mD8bUDD6pXlpxTktkWdlFC9EkAckW5lPQxZSrmplL55pnD0HYkRfFtMb4Nx+s1uwirup1f1SLqhvg=
X-Received: by 2002:a17:907:c29:b0:704:fbb:1943 with SMTP id
 ga41-20020a1709070c2900b007040fbb1943mr1447349ejc.486.1655324905282; Wed, 15
 Jun 2022 13:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220615003733.16447-1-zhouzhouyi@gmail.com> <20220615051521.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2wCos5xupRQ2LbJtaLVN1a7i0D5kwaVTq9DEov8C46Gkw@mail.gmail.com>
 <20220615135220.GI1790663@paulmck-ThinkPad-P17-Gen-1> <20220615190936.GA713726@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220615190936.GA713726@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 16 Jun 2022 04:28:14 +0800
Message-ID: <CAABZP2wstbe+Exa3NWWygOAF5S4BtHfgJcb_r78uz-jq2KtU9Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] RFC: torture: add pr_flush to flush the
 results to console
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     john.ogness@linutronix.de, pmladek@suse.com, dave@stgolabs.net,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Paul and Petr for your efforts!

On Thu, Jun 16, 2022 at 3:09 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jun 15, 2022 at 06:52:20AM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 15, 2022 at 08:36:54PM +0800, Zhouyi Zhou wrote:
> > > On Wed, Jun 15, 2022 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 15, 2022 at 08:37:33AM +0800, zhouzhouyi@gmail.com wrote:
> > > > > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > >
> > > > > currently tools/testing/selftests/rcutorture/bin/torture.sh reports
> > > > > false positve because of kthread printing.
> > > > >
> > > > > Commit "printk: add functions to prefer direct printing" (2bb2b7b57f812)
> > > > > have added functions to prefer direct printing activated for the primary
> > > > > import messages.
> > > > >
> > > > > Meanwhile adding printk_prefer_direct_enter/exit to
> > > > > torture_cleanup_begin/end still can't eliminate the false positives
> > > > > for a hundred percent.
> > > > >
> > > > > This patch add pr_flush to torture_cleanup_end because the latter
> > > > > is sleepable.
> > > > >
> > > > > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > >
> > > > Just the one Signed-off-by suffices.  ;-)
> > > Thank Paul for your guidance ;-)
> > > >
> > > > > ---
> > > > >  kernel/torture.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/kernel/torture.c b/kernel/torture.c
> > > > > index 789aeb0e1159..b51e42463a67 100644
> > > > > --- a/kernel/torture.c
> > > > > +++ b/kernel/torture.c
> > > > > @@ -878,6 +878,7 @@ void torture_cleanup_end(void)
> > > > >       mutex_lock(&fullstop_mutex);
> > > > >       torture_type = NULL;
> > > > >       mutex_unlock(&fullstop_mutex);
> > > > > +     pr_flush(1000, true);
> > > >
> > > > But in this case, the kernel keeps on running, correct?  So won't the
> > > > output appear over time?  All of printk()'s kthreads are still running
> > > > after all.
> > > I am doing research on linux-next following your guidance on my Dell
> > > PowerEdge R720 server:
> > > #git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git/
> > > #cd linux-next
> > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > after about 14 hours, the test result show that there have been about
> > > 17 failures, I examine the corresponding console.log, and find the
> > > failures are caused by following reason:
> > > before the message output by
> > > rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
> > > SUCCESS") has reached serial console, torture_shutdown invoked
> > > kernel_power_off(),
> >
> > Ah, got it!  And good show tracking this down, by the way.
> >
> > Does this workaround commit on -rcu do the trick for you?
> >
> > 704ae8dcda84 ("torture: Flush printk() buffers before powering off")
> >
> > The printk() guys are looking at fixes within the printk() system
> > as well:
> >
> > https://lore.kernel.org/all/87tu8pgcj0.fsf@jogness.linutronix.de/
> > https://lore.kernel.org/all/YqdSw%2FfJvnkRbjvc@alley/
>
> And Petr has posted a more official fix, which I have queued on -rcu
> for testing at branch pmladek.2022.06.15a.
I am very happy to see the official fix, and start test it on my Dell
server by invoking
./tools/testing/selftests/rcutorture/bin/torture.sh

It will take 12 hours for the above script to finish if the other guy
who shares the server with me doesn't use it heavily ;-)

Thanks
Sincerely yours
Zhouyi
>
>                                                         Thanx, Paul
>
> > > so the message "End of test: SUCCESS" has not chance of reaching
> > > console.log of host machine.
> > >
> > > Then I add printk_prefer_direct_enter/exit to
> > > torture_cleanup_begin/end, again I invoke
> > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > after about 14 hours, the test result show that there have been about
> > > 5 failures,
> > >
> > > Then I add a debug statement after
> > > rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
> > > SUCCESS") which sends the debug string ("hello world") to
> > > uart_console_write directly, again I invoke
> > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > There is "hello world" in console.log but no "End of test" strings.
> > >
> > > So I guess even with printk_prefer_direct_enter/exit to
> > > torture_cleanup_begin/end,  our main shutdown thread has failed in
> > > competition for console lock (printk.c):
> > > 2401 if (console_trylock_spinning())
> > > 2402     console_unlock();
> > >
> > > Then I add pr_flush to torture_cleanup_end
> > > #./tools/testing/selftests/rcutorture/bin/torture.sh
> > > after 14 hours
> > > all 49 tests are success
> > > >
> > > > Or do you have a use case that requires that the output appear sooner
> > > > than it does?  If so, please let me know what that is.
> > > Thank Paul for your patience,
> > > ./tools/testing/selftests/rcutorture/bin/torture.sh is the only tool
> > > that I use.
> > >
> > > I am very interested in this topic, and very glad to do further
> > > experiments under your guidance ;-)
> >
> > Or are you already running with that commit or one of those patches?
> > They are working reliably for me (so far, anyway), but maybe more is
> > needed in some cases.
> >
> >                                                       Thanx, Paul
> >
> > > Sincerely yours
> > > Thanks
> > > Zhouyi
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(torture_cleanup_end);
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
