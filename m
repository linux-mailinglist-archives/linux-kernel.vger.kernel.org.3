Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07D4898CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiAJMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245632AbiAJMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:45:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCEC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:45:03 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e198so14927701ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P551vXMJtNOZg3UvulkEAqSICcinl0woD2ztefNS7o=;
        b=J8HT5LkxET+0mA/gLuJ/3I8tJ0L1dk9wNhAOo5DNNY42Isd7GnY4vVgeym1jIAII2B
         bvQt1mrEEzlsg5P4duvDpbkgIZRSJzSTr3LCqsRK2HjFvfLSwEYkMX0Z4EkSQkLeEmsS
         SMH1+FtPy+xbvVMMKNaUum/LkvsBs7FV0YOpMH0yap7J8BOTb2Xg3g8RGwxPhmEWnoYz
         tJfU3dJM2REGP9rRTf1HrXs19n529ELk+fOGcWZO3sNhJUi8k2Unc1m1lFXG6Mp9yPyz
         kNoKClvpJ8IAb2ZAOAKFZ80zAsEslE/hUTtJbsWl0wLarmgu4uW/Iw9Wc3Ik+LQ2rSFX
         GEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P551vXMJtNOZg3UvulkEAqSICcinl0woD2ztefNS7o=;
        b=Jga1lWVUBKnlSS0hY855tgSOXowIa4zp0vl3wuDvsLQQBIW8wPQRlvHi/cxObW3uox
         H3rMgrkBvmlu9U0dT2tOF4s4GWqVXL0sdWITf0dcyPbHHVUuMNNS2fn1HiyBH33ZNIbr
         DOFBVkmRisUX/3TuFggJBTkuK0oqpEQemXpc8C/QsIJH6gy8l3jH0KtmWsxuPTyEFGYs
         nEKO7QY8YRlSvxlTkgaQ6uvfI2dEML6493y1tUjtODO2Ae+yQ/4R8xchp84gYQr96HPS
         T8AuxOFWRfuNGgEV6zml+ElebnyGCk6Rmvij5YU/CnaI5h8+mJNgNG8QwL2XkQd+GAl9
         bqsA==
X-Gm-Message-State: AOAM531A7zoTs5qZYslzngyGYnwO5K+fhtD2xMn7XGoNCXk5/mGcDuhV
        BOhUXfvDQY6rxEycxfeL97Wyr4Djvi0koxvjla0kpA==
X-Google-Smtp-Source: ABdhPJycy2dWcyvhhb6q58G9qtGURkXbwLiSXEN+llTRHtfSBr0UI1jHi2mIcsMkEMzGfGjYnibJ42BIPjr7DUTTC8g=
X-Received: by 2002:a05:6902:1106:: with SMTP id o6mr67371292ybu.89.1641818702890;
 Mon, 10 Jan 2022 04:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20210402055745.3690281-1-varmam@google.com> <CAMyCerJ2wjdXeEP3iRaKOgXOm94rdqVkzAf5iy2cwpjMWVj0hA@mail.gmail.com>
In-Reply-To: <CAMyCerJ2wjdXeEP3iRaKOgXOm94rdqVkzAf5iy2cwpjMWVj0hA@mail.gmail.com>
From:   Manish Varma <varmam@google.com>
Date:   Mon, 10 Jan 2022 18:14:51 +0530
Message-ID: <CAMyCerLCsP=oHLkLZhfQmU8ZTxQWkOBboo_V1KY8LCk7BtmYxg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: Improve eventpoll logging to stop indicting timerfd
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kernel test robot <lkp@intel.com>,
        Kelly Rossmoyer <krossmo@google.com>,
        Vijay Nayak <nayakvij@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander and Thomas,

Friendly ping if you could share feedback (if any) to get this patch
merged.

Thanks,
Manish


On Tue, Jun 22, 2021 at 3:36 AM Manish Varma <varmam@google.com> wrote:
>
> Hello Alexander and Thomas,
>
> Please share if you have any further feedback on this patch, or if
> there's any other action required from my end to before this gets
> merged.
>
> Thanks,
> Manish
>
> On Thu, Apr 1, 2021 at 10:57 PM Manish Varma <varmam@google.com> wrote:
> >
> > timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> > it names them after the underlying file descriptor, and since all
> > timerfd file descriptors are named "[timerfd]" (which saves memory on
> > systems like desktops with potentially many timerfd instances), all
> > wakesources created as a result of using the eventpoll-on-timerfd idiom
> > are called... "[timerfd]".
> >
> > However, it becomes impossible to tell which "[timerfd]" wakesource is
> > affliated with which process and hence troubleshooting is difficult.
> >
> > This change addresses this problem by changing the way eventpoll
> > wakesources are named:
> >
> > 1) the top-level per-process eventpoll wakesource is now named "epoll:P"
> > (instead of just "eventpoll"), where P, is the PID of the creating
> > process.
> > 2) individual per-underlying-filedescriptor eventpoll wakesources are
> > now named "epollitemN:P.F", where N is a unique ID token and P is PID
> > of the creating process and F is the name of the underlying file
> > descriptor.
> >
> > All together that should be splitted up into a change to eventpoll and
> > timerfd (or other file descriptors).
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
> > Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
> > Signed-off-by: Manish Varma <varmam@google.com>
> > ---
> >  drivers/base/power/wakeup.c | 10 ++++++++--
> >  fs/eventpoll.c              | 10 ++++++++--
> >  include/linux/pm_wakeup.h   |  4 ++--
> >  3 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 01057f640233..3628536c67a5 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -216,13 +216,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
> >  /**
> >   * wakeup_source_register - Create wakeup source and add it to the list.
> >   * @dev: Device this wakeup source is associated with (or NULL if virtual).
> > - * @name: Name of the wakeup source to register.
> > + * @fmt: format string for the wakeup source name
> >   */
> >  struct wakeup_source *wakeup_source_register(struct device *dev,
> > -                                            const char *name)
> > +                                            const char *fmt, ...)
> >  {
> >         struct wakeup_source *ws;
> >         int ret;
> > +       char name[128];
> > +       va_list args;
> > +
> > +       va_start(args, fmt);
> > +       vsnprintf(name, sizeof(name), fmt, args);
> > +       va_end(args);
> >
> >         ws = wakeup_source_create(name);
> >         if (ws) {
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 7df8c0fa462b..7c35987a8887 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -312,6 +312,7 @@ struct ctl_table epoll_table[] = {
> >  };
> >  #endif /* CONFIG_SYSCTL */
> >
> > +static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
> >  static const struct file_operations eventpoll_fops;
> >
> >  static inline int is_file_epoll(struct file *f)
> > @@ -1451,15 +1452,20 @@ static int ep_create_wakeup_source(struct epitem *epi)
> >  {
> >         struct name_snapshot n;
> >         struct wakeup_source *ws;
> > +       pid_t task_pid;
> > +       int id;
> > +
> > +       task_pid = task_pid_nr(current);
> >
> >         if (!epi->ep->ws) {
> > -               epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
> > +               epi->ep->ws = wakeup_source_register(NULL, "epoll:%d", task_pid);
> >                 if (!epi->ep->ws)
> >                         return -ENOMEM;
> >         }
> >
> > +       id = atomic_inc_return(&wakesource_create_id);
> >         take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
> > -       ws = wakeup_source_register(NULL, n.name.name);
> > +       ws = wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task_pid, n.name.name);
> >         release_dentry_name_snapshot(&n);
> >
> >         if (!ws)
> > diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> > index aa3da6611533..cb91c84f6f08 100644
> > --- a/include/linux/pm_wakeup.h
> > +++ b/include/linux/pm_wakeup.h
> > @@ -95,7 +95,7 @@ extern void wakeup_source_destroy(struct wakeup_source *ws);
> >  extern void wakeup_source_add(struct wakeup_source *ws);
> >  extern void wakeup_source_remove(struct wakeup_source *ws);
> >  extern struct wakeup_source *wakeup_source_register(struct device *dev,
> > -                                                   const char *name);
> > +                                                   const char *fmt, ...);
> >  extern void wakeup_source_unregister(struct wakeup_source *ws);
> >  extern int wakeup_sources_read_lock(void);
> >  extern void wakeup_sources_read_unlock(int idx);
> > @@ -137,7 +137,7 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
> >  static inline void wakeup_source_remove(struct wakeup_source *ws) {}
> >
> >  static inline struct wakeup_source *wakeup_source_register(struct device *dev,
> > -                                                          const char *name)
> > +                                                          const char *fmt, ...)
> >  {
> >         return NULL;
> >  }
> > --
> > 2.31.0.208.g409f899ff0-goog
> >
>
>
> --
> Manish Varma | Software Engineer | varmam@google.com | 650-686-0858
