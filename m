Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1166C49D6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiA0AXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0AXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:23:44 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CDC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:23:44 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id o9so1362427qvy.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tI16jrShdh+VWHQZPdGxnK3ku5D8/sdLyRbvj9dibg=;
        b=JMnAmWe1PTJ/rCd3Nuaz23/Y5eOwJCQNl6Gg+fDD5p2zqtrA244C9U+CCbdgQuuDHB
         Odvziiz7W3A17WxQvVFLfAOYLQq5BNgygS7gNnWJ1MItDbeHETMYC3JPQVU6fVZxTzlS
         zsiohl958LV/g3PLYgz+Ud45FRh81dZ3JMcn1AfYToH9w/wWhwk0SLmB0C9fIVrr+Nye
         YSY8KdXjVOsffJQf6vqvKF1KGTAFgKya/Ny8Qyjjg1KFj7uNjQ7oYU1bf3ylq5k22dX0
         IuUBQ3mZPeiqKDOT+PNBtlmf7IMNLrLrRnUPIVQLErqRA6970m8R7vq/jJIiEjaKHmtq
         K8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tI16jrShdh+VWHQZPdGxnK3ku5D8/sdLyRbvj9dibg=;
        b=GxqSeOSoHdQa18+ruz3n5tmPlN/OqoqR5eErXDFl2Y2JFGiTsBZAQl51/Xe/mFiwgt
         gTcoQBj+O+N4trGywMzXT2vR2YxIrIkQ7jgJHLByil24l3060Vs7CqCXq40CYkduNDzq
         Uadf11mERBd2U8mMoW8qUx8mQ320AT4k08brkemJFUvcazNwhLFu8JO8eO7w1bmkhD1P
         DoB8Noablnu/k7LA0T0xwamgKl9SHwWDyqadEQhnJyYIznUhRasFImcj16e55EnWmz/Z
         HmlvU3NDvQ+kDS6FvtVoD0YmBJ8OTrcgNcKiXgsLW4SWTtdQLeDnPSj57iGLSIXBfSLM
         0CrA==
X-Gm-Message-State: AOAM533cCbSY6khTTUe6bfUnX7geGtrtvUMOZToOxXHiGYLtuz1rYLDJ
        nuLz6qF1SYx6mqjLCzXz7S0edrRghWjH4L9yJdoeh9x5JJSFcQ==
X-Google-Smtp-Source: ABdhPJxumsMGuV2uul20AMyNJvE11D0z3QKxMSCLgr//ERcQ3IAMTUqy12FcqARXbC02hRsaf4MLW7nZw0Q2zNtLnD8=
X-Received: by 2002:ad4:5fce:: with SMTP id jq14mr1198737qvb.54.1643243023053;
 Wed, 26 Jan 2022 16:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20220118060431.1368538-1-jsperbeck@google.com>
 <Yef9hPon8s8swQMn@alley> <CAFNjLiX6n9C6LqfC=x160RqkEKC9_F6upEPpKG2LRGCU96hfYQ@mail.gmail.com>
 <Ye+6S0YYImktieos@alley>
In-Reply-To: <Ye+6S0YYImktieos@alley>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Wed, 26 Jan 2022 16:23:31 -0800
Message-ID: <CAFNjLiVpE22987=4S6ph-xNReizHuN0=ewehjYq9qs70DqqHMA@mail.gmail.com>
Subject: Re: [PATCH] kernel: count warnings and make count accessible to userspace
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:52 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Adding Andrew back to Cc :-)
>
> On Sat 2022-01-22 12:58:39, John Sperbeck wrote:
> > On Wed, Jan 19, 2022 at 4:01 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > Adding Andrew into Cc. Most changes in panic.c go via his tree.
> > >
> > > On Tue 2022-01-18 06:04:31, John Sperbeck wrote:
> > > > When testing, it's common to consider a warning to be a test failure,
> > > > but it's currently awkward to determine which of multiple sequential
> > > > tests is responsible for triggering a warning.  Scraping dmesg or
> > > > /var/log/messages is somewhat expensive and error-prone.  Setting
> > > > panic_on_warn is reliable, but spoils test runs for minor issues.
> > > > Looking at the taint bit is also reliable, but only works for a single
> > > > warning.
> > > >
> > > > We can track the warning count and expose it as a sysfs file.  Test
> > > > infrastructures can snapshot the value before and after a test.  If
> > > > the value changes, they can do more expensive things like extracting
> > > > logs.
> > >
> > > The counter makes sense. It might be useful even for normal debugging.
> > > It would be nice to show the value in the log.
> > >
> > > > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > > > ---
> > > >  kernel/panic.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > > index cefd7d82366f..5262c2a0ebf4 100644
> > > > --- a/kernel/panic.c
> > > > +++ b/kernel/panic.c
> > > > @@ -571,6 +571,8 @@ struct warn_args {
> > > >       va_list args;
> > > >  };
> > > >
> > > > +static atomic_t  __maybe_unused warn_counter;
> > > > +
> > > >  void __warn(const char *file, int line, void *caller, unsigned taint,
> > > >           struct pt_regs *regs, struct warn_args *args)
> > > >  {
> > > > @@ -612,6 +614,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
> > > >
> > > >       /* Just a warning, don't kill lockdep. */
> > > >       add_taint(taint, LOCKDEP_STILL_OK);
> > > > +
> > > > +     atomic_inc(&warn_counter);
> > > >  }
> > > >
> > > >  #ifndef __WARN_FLAGS
> > > > @@ -667,6 +671,7 @@ static __init int register_warn_debugfs(void)
> > > >       /* Don't care about failure */
> > > >       debugfs_create_file_unsafe("clear_warn_once", 0200, NULL, NULL,
> > > >                                  &clear_warn_once_fops);
> > > > +     debugfs_create_atomic_t("warn_count", 0444, NULL, &warn_counter);
> > >
> > > Is the sysfs interface really important for you use case, please?
> > > Would the value in the log be enough?
> > >
> > > Anyway, we already count the number WARN() reports. It is quite hidden
> > > and hashed in init_oops_id()/print_oops_end_marker().
> > >
> > > A solution would be to make this hidden counter more explicit.
> > > Something like:
> > >
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index cefd7d82366f..8ac19124ceb4 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -537,13 +537,12 @@ void oops_enter(void)
> > >   * 64-bit random ID for oopses:
> > >   */
> > >  static u64 oops_id;
> > > +static int oops_cnt;
> > >
> > >  static int init_oops_id(void)
> > >  {
> > >         if (!oops_id)
> > >                 get_random_bytes(&oops_id, sizeof(oops_id));
> > > -       else
> > > -               oops_id++;
> > >
> > >         return 0;
> > >  }
> > > @@ -552,7 +551,9 @@ late_initcall(init_oops_id);
> > >  static void print_oops_end_marker(void)
> > >  {
> > >         init_oops_id();
> > > -       pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
> > > +       oops_cnt++;
> > > +       pr_warn("---[ end trace %016llx:%d ]---\n",
> > > +               (unsigned long long)oops_id, oops_cnt);
> > >  }
> > >
> > >  /*
> > >
> > >
> > > The report would like like:
> > >
> > > [ 1871.476204] WARNING: CPU: 2 PID: 2003 at samples/livepatch/livepatch-sample.c:60 livepatch_init+0x11/0x20 [livepatch_sample]
> > > [ 1871.476905] Modules linked in: livepatch_sample(EK+) [last unloaded: livepatch_sample]
> > > [ 1871.477509] CPU: 2 PID: 2003 Comm: modprobe Tainted: G        W   E K   5.16.0-default+ #312
> > > [ 1871.478175] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > > [ 1871.478858] RIP: 0010:livepatch_init+0x11/0x20 [livepatch_sample]
> > > [...]
> > > [ 1871.489801] hardirqs last disabled at (9188): [<ffffffffb217aa4e>] vprintk_emit+0x21e/0x2b0
> > > [ 1871.489803] softirqs last  enabled at (9096): [<ffffffffb3000364>] __do_softirq+0x364/0x4ab
> > > [ 1871.489805] softirqs last disabled at (9083): [<ffffffffb20efb5d>] irq_exit_rcu+0x10d/0x120
> > > [ 1871.489807] ---[ end trace a19f0f55262cfcc8:2 ]---
> > >
> > > Best Regards,
> > > Petr
> >
> > Thanks for adding the CC.
> >
> > The sysfs interface was kind of the main thing I'm after.  The intent is
> > to avoid parsing logs unless something interesting is likely to be there.
> >
> > If we were to rely entirely on log parsing, adding a count to the logs
> > doesn't add much, I think.  That is, if a warning is parsed, then we
> > already know it occurred, and don't need the counter value in the message
> > that we parsed to tell us what we just discovered.
>
> Fair enough.
>
> > I see some precedent for exposing counts for things like this:  lockdep,
> > kfence, DMA-API debug.  Warnings, KASAN, and UBSAN are some areas that
> > don't have this convenience.
>
> I see.
>
> > If the sysfs interface isn't palatable, that's okay.  Supporting a
> > three-line patch locally isn't a tremendous burden.
>
> I am not against the debugfs interface. The counter might be useful.
>
> Well, I would still combine it with my proposal. The number of
> warnings is already "counted" by the number printed in
> 'end trace XXXXXXXXXXXXXX' line. It does not make sense to
> add yet another counter.
>
> Best Regards,
> Petr

I'm not sure I understand the comment that it doesn't make sense to
add yet another counter?  Isn't the alternate proposal to add
'oops_cnt' adding a counter?

Also, is a simple 'int' adequate?  Are there any concerns about
multiple CPUs calling warn at the same time?

I'm also wondering about the ramifications of changing the format of a
string that the log-scraping crowd might use for identifying the end
of a warning?

Finally, wouldn't dropping the 'oops_id++' from init_oops_id() lose
the intent of d6624f996ae5 ("oops: increment the oops UUID every time
we oops")?
