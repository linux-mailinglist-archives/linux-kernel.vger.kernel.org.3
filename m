Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18BF4E559C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245219AbiCWPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiCWPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:46:59 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A942A1F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:45:28 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j2so3491028ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Jg8J2Luezibyjk1NCAMPgRdiTMvuzb9dL7PYt8b/pT4=;
        b=m4b+05YQmZoqM0Oog9rYw5jSEDMRJg+lBgVfzPUSbdpC/97wTed4wgrZFdUZBOYLU/
         r9g1UMk2KtlAA4HXLgjq+fLaETKtg0lx3+n1M0VklJZhyJsTpIWDboYl9znZi47V7ybJ
         n0IMkDJ87hxH/r4LG5RBHh8w2Ag9aJqMa2Bgm4vzoUbKrDtKBrDYrMqTvn8vcpKOYOJP
         F9YsJ5X6mUoQn0Eizph1CNTumX1BnHY+PL5HFZJlaX87pnWvqFe0QyI7sAem1wUuyVSg
         VsUuKDotOFlxVaIa3UVewzw423y+tp7gp4sSfSe8dYdkYTv+F32e86pG7rjW7SqoUWca
         td0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Jg8J2Luezibyjk1NCAMPgRdiTMvuzb9dL7PYt8b/pT4=;
        b=viTL4iV7v3hrObphDbszezoZspczf8eXxh+hWYpuy1CwLBI3fMx4mETMM9S0M87G9S
         CqK1yHzlmnIirVahlQAmUzokhMm+7F+fHwB2fbHL9nSELxwBSHqYxEjU8I/g+UTPGQvT
         qk4Gpk7KlHC44Ibd8joGzDlC2HDuqq7Us8yvl8erGPyEG5mUwVrYeLlUsaA7Epi2l6UN
         5TPJm985WgbJCBuKJ1uy9DULF9Ue5IL3IT120I1kGnYrKbc3Ax+98JX4aJPmXQDnhksQ
         0kufxMhONMzf0eBQur4qLMnuybgvPLGBQmW0bWOmH17TtK5ZyrWZO5LWTpF0f2joPlEj
         LKYQ==
X-Gm-Message-State: AOAM532z6JFog/23x4Q8m4pgYXifou42dFKiYB0CAJlnAKx2rd6N0OEm
        X+qNYB/j3zeEgiTjgM8RX7oVoOM8LgwrEtfOqPwDy3hrmyc=
X-Google-Smtp-Source: ABdhPJx2tcbrYhRxeJUEifY+gbcCvk6tv3LKFUxreuNRIAU2AlYNvIxd9L5CDWzeu9C9+GVgFoVPAYA9Oy4aDAj2nV4=
X-Received: by 2002:a25:7d87:0:b0:628:88e1:9065 with SMTP id
 y129-20020a257d87000000b0062888e19065mr562106ybc.52.1648050327984; Wed, 23
 Mar 2022 08:45:27 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 23 Mar 2022 21:15:16 +0530
Message-ID: <CAOuPNLhB8pojv4wqv6d4FvhoBbNvUxD19ciK-6E8HtbbrnjF9g@mail.gmail.com>
Subject: kernel space: finding cpu usage of individual process/thread
To:     open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Johannes Weiner <hannes@cmpxchg.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
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

Hi,

For one of my requirements I need to find cpu usage or load_avg of an
individual process or thread using "for_each_process_thread(process,
thread)" where process/thread is a pointer to "task_struct".

But, currently I am not able to figure out which is the right field
from task_struct to get this value, or how to manipulate it.

I see some fields there but I'm not sure if these values are correct.
a) sched_entity -> sched_avg -> load/load_avg/load_sum/util_avg/etc.
b) stime + utime : What time I get from here ?
c) prev_cputime
d) vtime
e) acct_timexpd
f) ???

It will be good if I can get some references in kernel space.

When I use (a) above (load_avg) I get this value:
pid=2 , comm=kthread, load=51
pid=96, comm=cat , load=1024
etc...

When I use (stime + utime) I get:
pid=2 , comm=kthread, load=3978848
pid=96, comm=cat , load=11786176

So, not sure which one is correct ?


Thanks,
Pintu
