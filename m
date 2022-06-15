Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1454C8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348789AbiFOMhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbiFOMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:37:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ABB31383;
        Wed, 15 Jun 2022 05:37:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so22907933ejj.10;
        Wed, 15 Jun 2022 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/WQo9UxHiAIQSpHuTEJOdPrvxBtqOsfkDuOHXT4fi8=;
        b=mynfaxJn8Yi4N5AnFgJURBMSq6edLrV6kfdVtE/cTBvkdGR+1pymZMt5tGuslErUc2
         fRWug5XbN8UZArtXaKxYC3oA4rAwvVN2XAfs/LE1iG9Rz3rIxQGoamNeSjojOF4IJnMR
         6gktE1M0kPpQlCQDrshBcfIUd1PwGbANqs7GxEgEPq2m4lA9LdIQ65vRI4ZSsY3SUVIA
         2NxU16tB//7HH+axMHn1ncxoepAmd6+Z4qnqqHgtn11LjRzJS9SRA95u28jWQCH2mJwk
         bo+dhvfMOTVGOfxr8jFs4NUIkWSsTVuKFjK4UNBkcI7RYBw3TDIZdzDNRxtc4HDzNY+g
         RK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/WQo9UxHiAIQSpHuTEJOdPrvxBtqOsfkDuOHXT4fi8=;
        b=RfQ3ZhwdmaDJS0fxFZWUxmr88hweV5VW9qbhgjrYnV6rb2Lk7gq1bfB8WcJ0Xt8abb
         z+obPJc1KPr4wBtj9gYTa3NveKrb4dxzoOzCFk6nhRQ/13arazg8L4Eipc71YGf2UUsm
         8TZdF//1C1cP9Z/Zt8R4Mp4XTGDi/Fwb8Psdz97XBxCsZvZVGh3HIXjEARfdIn0M9ilD
         h202RYnBUTn/Yid+Ra1vnJ6/h36kCrBRg6JnapbIGLN6Y8pQi+/oISpJZF4bVPNGL7ts
         7nm+DIv4aouU+v4vvHswn+XzAX0RM2HBm5j8R3lWXGZfJAIr7j3v2i6xavy2fBY/3FfJ
         knTA==
X-Gm-Message-State: AJIora+0uIXTzBXEmSfb5vc4BV962AkmV+MjaHKlPxmTvHs3Yqval6BN
        lSLhOdkA9OzhWXEwsNXEnomSls1CAznQoiByC1k=
X-Google-Smtp-Source: ABdhPJylDinb4fCzaItR8dWPh3GXyvMp29GxcUN2YDleOJDJHdNjuEmPigJmt+Ifl8rLUqLlWoaEZioBql0P4yFAOg0=
X-Received: by 2002:a17:906:73d2:b0:716:14a4:43d with SMTP id
 n18-20020a17090673d200b0071614a4043dmr8559822ejl.434.1655296627996; Wed, 15
 Jun 2022 05:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220615003733.16447-1-zhouzhouyi@gmail.com> <20220615051521.GH1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220615051521.GH1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 15 Jun 2022 20:36:54 +0800
Message-ID: <CAABZP2wCos5xupRQ2LbJtaLVN1a7i0D5kwaVTq9DEov8C46Gkw@mail.gmail.com>
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

On Wed, Jun 15, 2022 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jun 15, 2022 at 08:37:33AM +0800, zhouzhouyi@gmail.com wrote:
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > currently tools/testing/selftests/rcutorture/bin/torture.sh reports
> > false positve because of kthread printing.
> >
> > Commit "printk: add functions to prefer direct printing" (2bb2b7b57f812)
> > have added functions to prefer direct printing activated for the primary
> > import messages.
> >
> > Meanwhile adding printk_prefer_direct_enter/exit to
> > torture_cleanup_begin/end still can't eliminate the false positives
> > for a hundred percent.
> >
> > This patch add pr_flush to torture_cleanup_end because the latter
> > is sleepable.
> >
> > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Just the one Signed-off-by suffices.  ;-)
Thank Paul for your guidance ;-)
>
> > ---
> >  kernel/torture.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/torture.c b/kernel/torture.c
> > index 789aeb0e1159..b51e42463a67 100644
> > --- a/kernel/torture.c
> > +++ b/kernel/torture.c
> > @@ -878,6 +878,7 @@ void torture_cleanup_end(void)
> >       mutex_lock(&fullstop_mutex);
> >       torture_type = NULL;
> >       mutex_unlock(&fullstop_mutex);
> > +     pr_flush(1000, true);
>
> But in this case, the kernel keeps on running, correct?  So won't the
> output appear over time?  All of printk()'s kthreads are still running
> after all.
I am doing research on linux-next following your guidance on my Dell
PowerEdge R720 server:
#git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git/
#cd linux-next
#./tools/testing/selftests/rcutorture/bin/torture.sh
after about 14 hours, the test result show that there have been about
17 failures, I examine the corresponding console.log, and find the
failures are caused by following reason:
before the message output by
rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
SUCCESS") has reached serial console, torture_shutdown invoked
kernel_power_off(),
so the message "End of test: SUCCESS" has not chance of reaching
console.log of host machine.

Then I add printk_prefer_direct_enter/exit to
torture_cleanup_begin/end, again I invoke
#./tools/testing/selftests/rcutorture/bin/torture.sh
after about 14 hours, the test result show that there have been about
5 failures,

Then I add a debug statement after
rcu/lock/scf_torture_print_module_parms(cur_ops, "End of test:
SUCCESS") which sends the debug string ("hello world") to
uart_console_write directly, again I invoke
#./tools/testing/selftests/rcutorture/bin/torture.sh
There is "hello world" in console.log but no "End of test" strings.

So I guess even with printk_prefer_direct_enter/exit to
torture_cleanup_begin/end,  our main shutdown thread has failed in
competition for console lock (printk.c):
2401 if (console_trylock_spinning())
2402     console_unlock();

Then I add pr_flush to torture_cleanup_end
#./tools/testing/selftests/rcutorture/bin/torture.sh
after 14 hours
all 49 tests are success
>
> Or do you have a use case that requires that the output appear sooner
> than it does?  If so, please let me know what that is.
Thank Paul for your patience,
./tools/testing/selftests/rcutorture/bin/torture.sh is the only tool
that I use.

I am very interested in this topic, and very glad to do further
experiments under your guidance ;-)

Sincerely yours
Thanks
Zhouyi
>
>                                                         Thanx, Paul
>
> >  }
> >  EXPORT_SYMBOL_GPL(torture_cleanup_end);
> >
> > --
> > 2.25.1
> >
