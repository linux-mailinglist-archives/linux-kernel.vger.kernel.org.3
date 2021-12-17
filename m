Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C25478EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbhLQPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhLQPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:06:18 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661AC061574;
        Fri, 17 Dec 2021 07:06:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so8885603edb.8;
        Fri, 17 Dec 2021 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrO+5tCBVwi3dHMMdMTZMMTrnVmLv4B3ynaYuBuEgWI=;
        b=W0L3ZZe0yg5YXP3H04rCaj1LWLOfuJQ/YqsO6rJ7yYUHmpJt+lLzbzJkPKi9zLEcnV
         0kb2/tvBgoFG4+Ot3zW4aZcxBYx1VkpPVxdFyXRceygy/5UivxxPCHnuXDdK+qNqYjwR
         /8vlS1Ii6w5io6oEEq3fvbEM9R89+ukzlWIN2rTKbpAyVqiqRvr4NrrbTIq66ilh6rPv
         vqtp5DiBirwjn9VKW4yA6ecAIA/WvbWmS1Vw077ptAaQsgj6Pma2J395Q/qtkcexAmh5
         mxPWaz0wXnwof8Uk0ZsX/lh0+7cGoi9q4MgB2dXLwuFJ7scWJr8KA/gvMJyRKX7MKNSm
         B2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrO+5tCBVwi3dHMMdMTZMMTrnVmLv4B3ynaYuBuEgWI=;
        b=DOwTHMcGqKFU22q6vrhnKGEYOie2ZNh1sAGtS//AqLI478PaDZtE7ih1LlbnLAqNqi
         U/DVVTHue93NarOaawDinzf15h1igmdl187IG3NuCd1cGxRnuUWF78K2f2lHtzSRI57C
         fx59xVEEdXFRwYZcUKmKJhAXIZ2GDK6cWIK3cURSm3qdEJrHkX8gj1m81OmhbLiHBm60
         4oTag7YVXYEDNP76Hy7RAnxjWkjkBIkh4luPBGxLLC0l1135sO1rnfMJ7OsWxiC8fRTA
         zA2v0CmpeqkRMz+TdYAC31a9w7kEcmhXSgq+PlcmE8QJFG44OKSJPBvdOlTG2Vyn4pRW
         mvRg==
X-Gm-Message-State: AOAM532ut7uU3yjp6DWl5eZi21+DxobDOJi8ficsXiqfcVuY9DjA2Vtj
        sdiJs+uuKHIwaE/wRGT6QqO5w83KKPXkjK5Gffc=
X-Google-Smtp-Source: ABdhPJwsMhiSSh7ZunvjuEXkwXYl6bLbA4p+WWapf8ST/Zlcwju0BVfRGdsZuLBjpVr7cpXFX9roobxiu5pEHS4NRNg=
X-Received: by 2002:a50:9d48:: with SMTP id j8mr3181101edk.192.1639753576821;
 Fri, 17 Dec 2021 07:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20211215111845.2514-1-urezki@gmail.com> <20211215111845.2514-5-urezki@gmail.com>
 <YbpFfsTvB96g4+yU@pc638.lan> <YbtxBvfGR97C8r8U@google.com>
In-Reply-To: <YbtxBvfGR97C8r8U@google.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Fri, 17 Dec 2021 16:06:05 +0100
Message-ID: <CA+KHdyWn=+Y=EHK6zWvMQBrh37gxqtiMAe-5yPh=rqPXF_GkmA@mail.gmail.com>
Subject: Re: [PATCH] mfd: dln2: Switch to kvfree_rcu() API
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 6:02 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 15 Dec 2021, Uladzislau Rezki wrote:
>
> > On Wed, Dec 15, 2021 at 12:18:41PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Instead of invoking a synchronize_rcu() to free a pointer
> > > after a grace period we can directly make use of new API
> > > that does the same but in more efficient way.
> > >
> > > TO: Lee Jones <lee.jones@linaro.org>
> > > TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  drivers/mfd/dln2.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > > index 852129ea0766..365e3e77cac4 100644
> > > --- a/drivers/mfd/dln2.c
> > > +++ b/drivers/mfd/dln2.c
> > > @@ -179,10 +179,8 @@ void dln2_unregister_event_cb(struct platform_device *pdev, u16 id)
> > >
> > >     spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
> > >
> > > -   if (found) {
> > > -           synchronize_rcu();
> > > -           kfree(i);
> > > -   }
> > > +   if (found)
> > > +           kvfree_rcu(i);
> > >  }
> > >  EXPORT_SYMBOL(dln2_unregister_event_cb);
> > >
> > + Lee Jones <lee.jones@linaro.org>
> > + Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>
> I can't do anything with this.
>
> Send it properly please.
>
I got. Will do.

Thanks!

-- 
Uladzislau Rezki
