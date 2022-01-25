Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A649BA62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356286AbiAYRak convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 12:30:40 -0500
Received: from mail-yb1-f172.google.com ([209.85.219.172]:45924 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384201AbiAYR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:29:09 -0500
Received: by mail-yb1-f172.google.com with SMTP id h14so63728021ybe.12;
        Tue, 25 Jan 2022 09:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nH3zjGyDXrTCkD+SrEQ+bHdMeVEd+ziilyCXIE7LNxI=;
        b=EOeizZEuZtM4gf5uhIoBxIr5CLsCV8e1rM2Kf7KDbwLQ/HCqRdRuIXBjpqjQak5Wlt
         rxBfhLBkZfi4dR7mKxqS+0bl3cqICyj6c6g8+Leae/Znit8fmk189EI/odRkTUUhrMh8
         BgF1XB1fXb/9Cr+bTIMrTy8KNs9wot+nxMRBJn2wLV5VfAWZwMSM6ZNIqdwLEHGOV1//
         JO42vltCRDLbeis7KCNXjAa8S/1AQdHU6GlzUmN+Ymx3D3d4cngIMNbLvSYQhOZgEXVx
         PYXknoKLRKHSey6w0ns75z86/AaLNewgKs5wicafkhzB3oPJ5fqRDx+pB+aZeQDEHilK
         lhog==
X-Gm-Message-State: AOAM530yDx3sXJ9sSqaER1PZ/hnsLK6oe92Zs+Z4TsB+bmlc0duI+MFc
        7KGyJ0s1th56PItRqvTrbP0Oq2bvw8krZuergYs=
X-Google-Smtp-Source: ABdhPJyJlhgdbmyEwooYOYDrNFL1zY/0eNyBxiemZOcna8CwX01xgtDP0r+H23GuuV6P1VUPXw++EluMUdJnU/h1zjw=
X-Received: by 2002:a25:1e0b:: with SMTP id e11mr29990235ybe.272.1643131743781;
 Tue, 25 Jan 2022 09:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20220113184420.2504545-1-gregkh@linuxfoundation.org> <YeFL+g64SL3m/mVW@google.com>
In-Reply-To: <YeFL+g64SL3m/mVW@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 18:28:52 +0100
Message-ID: <CAJZ5v0gOZg1-iWvDjdsCEJGvAUc8bSy33idFU1S=+DSZV=PgsQ@mail.gmail.com>
Subject: Re: [PATCH] pm / wakeup: simplify the output logic of pm_show_wakelocks()
To:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:10 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 13 Jan 2022, Greg Kroah-Hartman wrote:
>
> > The buffer handling in pm_show_wakelocks() is tricky, and hopefully
> > correct.  Ensure it really is correct by using sysfs_emit_at() which
> > handles all of the tricky string handling logic in a PAGE_SIZE buffer
> > for us automatically as this is a sysfs file being read from.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/power/wakelock.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
>
> Reviewed-by: Lee Jones <lee.jones@linaro.org>

Applied as 5.18 material, thanks!

>
> > diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> > index 105df4dfc783..52571dcad768 100644
> > --- a/kernel/power/wakelock.c
> > +++ b/kernel/power/wakelock.c
> > @@ -39,23 +39,20 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
> >  {
> >       struct rb_node *node;
> >       struct wakelock *wl;
> > -     char *str = buf;
> > -     char *end = buf + PAGE_SIZE;
> > +     int len = 0;
> >
> >       mutex_lock(&wakelocks_lock);
> >
> >       for (node = rb_first(&wakelocks_tree); node; node = rb_next(node)) {
> >               wl = rb_entry(node, struct wakelock, node);
> >               if (wl->ws->active == show_active)
> > -                     str += scnprintf(str, end - str, "%s ", wl->name);
> > +                     len += sysfs_emit_at(buf, len, "%s ", wl->name);
> >       }
> > -     if (str > buf)
> > -             str--;
> >
> > -     str += scnprintf(str, end - str, "\n");
> > +     len += sysfs_emit_at(buf, len, "\n");
> >
> >       mutex_unlock(&wakelocks_lock);
> > -     return (str - buf);
> > +     return len;
> >  }
> >
> >  #if CONFIG_PM_WAKELOCKS_LIMIT > 0
>
> --
> Lee Jones [李琼斯]
> Principal Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
