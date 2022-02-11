Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448E4B2348
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiBKKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:34:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiBKKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C9EA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D53BB1F385;
        Fri, 11 Feb 2022 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644575656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uSDjhUl1nOZHU5pEKXLZDfVBsvQRq/Com4smsm9i6gU=;
        b=awKCh6S5XIHwjhCiwMNtbbB4dhsqkpJwjewrf2kH+GFGJ8D/5LFZtgJTnhvy2XXB919W0q
        FgW/QuF5WxuCy25L0isHYaLcjBteFvymw3SHIzEFPb2kaPaOTVg5+J3a3q12XXHfRsUsk5
        xp2/arpZHxZBl+XdFophoJRZydEcZcU=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 802E7A3B95;
        Fri, 11 Feb 2022 10:34:16 +0000 (UTC)
Date:   Fri, 11 Feb 2022 11:34:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: count warnings and make count accessible to
 userspace
Message-ID: <YgY7qC+/+Hu2Z3X4@alley>
References: <20220118060431.1368538-1-jsperbeck@google.com>
 <Yef9hPon8s8swQMn@alley>
 <CAFNjLiX6n9C6LqfC=x160RqkEKC9_F6upEPpKG2LRGCU96hfYQ@mail.gmail.com>
 <Ye+6S0YYImktieos@alley>
 <CAFNjLiVpE22987=4S6ph-xNReizHuN0=ewehjYq9qs70DqqHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFNjLiVpE22987=4S6ph-xNReizHuN0=ewehjYq9qs70DqqHMA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I am sorry for the late reply. I had vacation last week. Many things
accumulated...


On Wed 2022-01-26 16:23:31, John Sperbeck wrote:
> On Tue, Jan 25, 2022 at 12:52 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Adding Andrew back to Cc :-)
> >
> > On Sat 2022-01-22 12:58:39, John Sperbeck wrote:
> > > On Wed, Jan 19, 2022 at 4:01 AM Petr Mladek <pmladek@suse.com> wrote:
> > > >
> > > > Adding Andrew into Cc. Most changes in panic.c go via his tree.
> > > >
> > > > On Tue 2022-01-18 06:04:31, John Sperbeck wrote:
> > > > > When testing, it's common to consider a warning to be a test failure,
> > > > > but it's currently awkward to determine which of multiple sequential
> > > > > tests is responsible for triggering a warning.  Scraping dmesg or
> > > > > /var/log/messages is somewhat expensive and error-prone.  Setting
> > > > > panic_on_warn is reliable, but spoils test runs for minor issues.
> > > > > Looking at the taint bit is also reliable, but only works for a single
> > > > > warning.
> > > > >
> > > > > We can track the warning count and expose it as a sysfs file.  Test
> > > > > infrastructures can snapshot the value before and after a test.  If
> > > > > the value changes, they can do more expensive things like extracting
> > > > > logs.
> > > >
> > > > The counter makes sense. It might be useful even for normal debugging.
> > > > It would be nice to show the value in the log.
> > > >
> > > > > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > > > > ---
> > > > >  kernel/panic.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > > > index cefd7d82366f..5262c2a0ebf4 100644
> > > > > --- a/kernel/panic.c
> > > > > +++ b/kernel/panic.c
> > > > > @@ -571,6 +571,8 @@ struct warn_args {
> > > > >       va_list args;
> > > > >  };
> > > > >
> > > > > +static atomic_t  __maybe_unused warn_counter;
> > > > > +
> > > > >  void __warn(const char *file, int line, void *caller, unsigned taint,
> > > > >           struct pt_regs *regs, struct warn_args *args)
> > > > >  {
> > > > > @@ -612,6 +614,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
> > > > >
> > > > >       /* Just a warning, don't kill lockdep. */
> > > > >       add_taint(taint, LOCKDEP_STILL_OK);
> > > > > +
> > > > > +     atomic_inc(&warn_counter);
> > > > >  }
> > > > >
> > > > >  #ifndef __WARN_FLAGS
> > > > > @@ -667,6 +671,7 @@ static __init int register_warn_debugfs(void)
> > > > >       /* Don't care about failure */
> > > > >       debugfs_create_file_unsafe("clear_warn_once", 0200, NULL, NULL,
> > > > >                                  &clear_warn_once_fops);
> > > > > +     debugfs_create_atomic_t("warn_count", 0444, NULL, &warn_counter);
> > > >
> > > > Is the sysfs interface really important for you use case, please?
> > > > Would the value in the log be enough?
> > > >
> > > > Anyway, we already count the number WARN() reports. It is quite hidden
> > > > and hashed in init_oops_id()/print_oops_end_marker().
> > > >
> > > > A solution would be to make this hidden counter more explicit.
> > > > Something like:
> > > >
> > > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > > index cefd7d82366f..8ac19124ceb4 100644
> > > > --- a/kernel/panic.c
> > > > +++ b/kernel/panic.c
> > > > @@ -537,13 +537,12 @@ void oops_enter(void)
> > > >   * 64-bit random ID for oopses:
> > > >   */
> > > >  static u64 oops_id;
> > > > +static int oops_cnt;
> > > >
> > > >  static int init_oops_id(void)
> > > >  {
> > > >         if (!oops_id)
> > > >                 get_random_bytes(&oops_id, sizeof(oops_id));
> > > > -       else
> > > > -               oops_id++;
> > > >
> > > >         return 0;
> > > >  }
> > > > @@ -552,7 +551,9 @@ late_initcall(init_oops_id);
> > > >  static void print_oops_end_marker(void)
> > > >  {
> > > >         init_oops_id();
> > > > -       pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
> > > > +       oops_cnt++;
> > > > +       pr_warn("---[ end trace %016llx:%d ]---\n",
> > > > +               (unsigned long long)oops_id, oops_cnt);
> > > >  }
> > > >
> > > >  /*
> > > >
> > > >
> > > > The report would like like:
> > > >
> > > > [ 1871.476204] WARNING: CPU: 2 PID: 2003 at samples/livepatch/livepatch-sample.c:60 livepatch_init+0x11/0x20 [livepatch_sample]
> > > > [ 1871.476905] Modules linked in: livepatch_sample(EK+) [last unloaded: livepatch_sample]
> > > > [ 1871.477509] CPU: 2 PID: 2003 Comm: modprobe Tainted: G        W   E K   5.16.0-default+ #312
> > > > [ 1871.478175] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > > > [ 1871.478858] RIP: 0010:livepatch_init+0x11/0x20 [livepatch_sample]
> > > > [...]
> > > > [ 1871.489801] hardirqs last disabled at (9188): [<ffffffffb217aa4e>] vprintk_emit+0x21e/0x2b0
> > > > [ 1871.489803] softirqs last  enabled at (9096): [<ffffffffb3000364>] __do_softirq+0x364/0x4ab
> > > > [ 1871.489805] softirqs last disabled at (9083): [<ffffffffb20efb5d>] irq_exit_rcu+0x10d/0x120
> > > > [ 1871.489807] ---[ end trace a19f0f55262cfcc8:2 ]---
> > > >
> > > > Best Regards,
> > > > Petr
> > >
> > > Thanks for adding the CC.
> > >
> > > The sysfs interface was kind of the main thing I'm after.  The intent is
> > > to avoid parsing logs unless something interesting is likely to be there.
> > >
> > > If we were to rely entirely on log parsing, adding a count to the logs
> > > doesn't add much, I think.  That is, if a warning is parsed, then we
> > > already know it occurred, and don't need the counter value in the message
> > > that we parsed to tell us what we just discovered.
> >
> > Fair enough.
> >
> > > I see some precedent for exposing counts for things like this:  lockdep,
> > > kfence, DMA-API debug.  Warnings, KASAN, and UBSAN are some areas that
> > > don't have this convenience.
> >
> > I see.
> >
> > > If the sysfs interface isn't palatable, that's okay.  Supporting a
> > > three-line patch locally isn't a tremendous burden.
> >
> > I am not against the debugfs interface. The counter might be useful.
> >
> > Well, I would still combine it with my proposal. The number of
> > warnings is already "counted" by the number printed in
> > 'end trace XXXXXXXXXXXXXX' line. It does not make sense to
> > add yet another counter.
> >
> > Best Regards,
> > Petr
> 
> I'm not sure I understand the comment that it doesn't make sense to
> add yet another counter?  Isn't the alternate proposal to add
> 'oops_cnt' adding a counter?

The 2nd counter is already there. 'oops_id' is initialized with a random
number but it is always incremented when print_oops_end_marker() is
called.

I though that 'oops_id' should be incremented together with your
'warn_count' to keep them in sync. But I see that
print_oops_end_marker() is called in various situations when
a backtrace is printed.

I agree that we need another counter for __warn() calls.

> Also, is a simple 'int' adequate?  Are there any concerns about
> multiple CPUs calling warn at the same time?

Yes, it should be atomic to avoid any race. But oops_id is 'int'.
Also oops_in_progress is simple 'int'. And it seems to be good
enough.

Well, it makes sense to do it properly when introducing new counter.

The patch makes sense after all. Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

Andrew, do you want to take it via -mm tree?

Best Regards,
Petr
