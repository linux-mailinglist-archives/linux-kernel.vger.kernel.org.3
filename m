Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062F45A67EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiH3QIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiH3QIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:08:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E893F7B1B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:08:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br21so10420023lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PbzCLE7f0NU8ABR6EXH3xv26zLpKLKNRVyw1XV/T+Tc=;
        b=Hf4uAEjakvrb7p03+qv6sa+T9fOUhx/0wTWJsLz+h78/fkQSdkhredb31ae5nkkpuG
         G69KcPxN0MTOteLwWBixR4Eae+Azuzu4p0YGwjjgIjRVsfONxqg/empykAW40yPDpKvu
         00bIDJc5Ps0MMndl7Nlnluj0YGATAKIN34MwiZAtsEpk1wyWGOPS9kWcOTdp+F0LlO+q
         Nk5E/oHzrbqNCtVpW1ptt/Ik7OySOZn/688OzEUD8ckvrdZ7S1lqfVX+/Acgy7u1FnHp
         JnBG7YRSK6Sj3l/nw2yHgtT0j2d5ChQfqeDItVd+6EYO6l62QxZkjZFmMFvprQANM/4w
         5fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PbzCLE7f0NU8ABR6EXH3xv26zLpKLKNRVyw1XV/T+Tc=;
        b=l0boyuL7iW+rPfpx8XTDNru9fcd5ZPi7Q1zwNL91a/BO9/yQMZldocT8WvFPswWcu/
         0VSJS3aCg9PU31VnJJLJB6C7L0BqeQoT6p9ITikBOuHD37ZhnSKFbD9orW38zunuwEnE
         aMG29GJ/60cZQML6ACiNtu5Tu+b5J6C62pIBgO+jy9c76yoSE/tLo7rJh7mwHk8+zI3W
         mCkPLyBrQ2iHyuJ09L33yXUUKoecEPIbddihKLB5ZMxCgbQUh32bkcJVwcI/MLw8mvKA
         uzEPNaqPfppfJZ0ru3+sVZBH7bueaBrThPdGqrDmuHCwWvxpKWnj8J2f0gRtUAtXt+C9
         rjLA==
X-Gm-Message-State: ACgBeo0abk23ELjZ7WBWokxujT+v+m467NukLW602ianycbnhv1fHlfl
        +dme/OO8kG/HpExEF52IEWpE6rkPxEJtfG9fGaw=
X-Google-Smtp-Source: AA6agR6V9tefD+e/XUudSef+jLlRW7RJZ3CjF9QC8V//zBs29Z99oU/n5dCS8ElYsO4/kzyHqOqJm7PDr+SJLghMDz4=
X-Received: by 2002:a05:6512:104f:b0:494:736a:8332 with SMTP id
 c15-20020a056512104f00b00494736a8332mr2090480lfb.683.1661875687922; Tue, 30
 Aug 2022 09:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220830014356.5364-1-avagin@gmail.com> <20220830014356.5364-2-avagin@gmail.com>
 <20220830095750.ljtdk7hekmmzhf2b@wittgenstein>
In-Reply-To: <20220830095750.ljtdk7hekmmzhf2b@wittgenstein>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 30 Aug 2022 09:07:56 -0700
Message-ID: <CANaxB-x=77SDqvoj4vpg8uKvntK+ttHWQyq1gdOhp1LZfAvfsg@mail.gmail.com>
Subject: Re: [PATCH 1/4] seccomp: don't use semaphore and wait_queue together
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
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

On Tue, Aug 30, 2022 at 2:57 AM Christian Brauner <brauner@kernel.org> wrote:

> >
> > +static bool notify_wakeup(struct seccomp_filter *filter)
> > +{
> > +     bool ret;
> > +
> > +     rcu_read_lock();
> > +     ret = atomic_add_unless(&filter->notif->requests, -1, 0);
>
> Can you please spell out why the change to wait_event_interruptible()
> below that calls notify_wakeup() makes it necessary to rcu protect
> ->notif?

This is my mistake. rcu is used here when I tried to implement notify_wakeup
without introducing notif->request. The idea was to enumerate all elements of
notif->notifications. Now, it doesn't matter. In this context, filter->notif
can be dereferenced without any additional locks. Thanks for catching this.

>
> Given that you're using rcu_read_lock() here and the
> WRITE_ONCE(fitler->notify, NULL) + kfree_rcu() sequence in
> seccomp_notify_free() it seems to imply that filter->notif could be NULL
> here and so would need a non-NULL check on ->notif before incrementing?
>
> > +     rcu_read_unlock();
> > +
> > +     return ret;
> > +}
>
>  static long seccomp_notify_recv(struct seccomp_filter *filter,
>                               void __user *buf)
> @@ -1467,7 +1479,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>
>       memset(&unotif, 0, sizeof(unotif));
>
> -     ret = down_interruptible(&filter->notif->request);
> +     ret = wait_event_interruptible(filter->wqh, notify_wakeup(filter));
>       if (ret < 0)
>               return ret;
>

Thanks,
Andrei
