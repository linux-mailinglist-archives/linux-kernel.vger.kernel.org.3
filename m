Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33CE513A02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbiD1QmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349713AbiD1QmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:42:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA18FB1AB0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:38:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e1so2340588ile.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Hm2rO8bTt2LsrgTybQvBlpYVMhdwmj3STvDv/63wWw=;
        b=k6/8kKFYbHCbeDhkgAQdKoqsj4vSjtq4LSrR2uZbGDvTsggui/pmFYhkEKOSb6x6I3
         p7P8hrksG7ngHqR3RaVwlrmou/QCzNjnHee4V9HpaKFrjwr92Wrl2YIiLn3jE47AU4yO
         hkrVUXpXWoLGJwg/ikdq3YPEMcoNg3jJi8PEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Hm2rO8bTt2LsrgTybQvBlpYVMhdwmj3STvDv/63wWw=;
        b=CWRzvZ+yla7G87hdn+Kmouize691iRANmPZYi4Y6p3SJgSF2FvvJt9qCmWqKT5miGx
         9ziLspNkJjBfa/X6XwCEhw3yjxs+ht/oB1/JyaCpcFkrLcqOYDxsRgvMRaRHNEYhtI5R
         TdB5z4Y9J0GPPJ/z1t9xXVXusJoUcCItI9eZzUZwb5wuSKoGmImdo0j6GDQbnThoj9Xt
         oto0JTD2KaouM5ViPjrFR6M4gYxf66lS8oWeeZ6UN4J1eTM6BvVbHyBizDA6iM2bXhdp
         2lS1elocENReCi2K0nZx0wCYhPwDzgBm/F/hQoKgfmNm4434/r9J8VYzu7PVhFfsKd6A
         CLdQ==
X-Gm-Message-State: AOAM533SMyjzSISsCrXGWb+YnxXdPOD/hJFWZM4IjiCRy/yOJy9z2uFU
        rMO1pRX0E6FgAsmIa5nMLvjuHMSNcHhXjrNjJhnzSA==
X-Google-Smtp-Source: ABdhPJzJ8+9mPlaD5AbyFFLS86dTWkDcpaY16GThKG1IJJLzW2CwsR5gAyGlCa2DZp4S/s+YfD3o3ajq/6xStB6u8OM=
X-Received: by 2002:a05:6e02:12b4:b0:2ca:e755:ee4a with SMTP id
 f20-20020a056e0212b400b002cae755ee4amr14111503ilr.65.1651163927107; Thu, 28
 Apr 2022 09:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220428015447.13661-1-sargun@sargun.me> <20220428015447.13661-2-sargun@sargun.me>
 <YmqTh68UkjVsTnUX@cisco>
In-Reply-To: <YmqTh68UkjVsTnUX@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 28 Apr 2022 09:38:10 -0700
Message-ID: <CAMp4zn-725wHy2su_Dz8pEdzUv7tG=gQ+9=7hj5PXfZpQeOLjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/seccomp: Ensure that notifications come in
 FIFO order
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 6:15 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Wed, Apr 27, 2022 at 06:54:47PM -0700, Sargun Dhillon wrote:
> > +     /* Start children, and them generate notifications */
>                            ^^ - they maybe?
>
Whoops, this was supposed to be:
 /* Start children, and generate notifications */
> > +     for (i = 0; i < ARRAY_SIZE(pids); i++) {
> > +             pid = fork();
> > +             if (pid == 0) {
> > +                     ret = syscall(__NR_getppid);
> > +                     exit(ret != USER_NOTIF_MAGIC);
> > +             }
> > +             pids[i] = pid;
> > +     }
> > +
> > +     /* This spins until all of the children are sleeping */
> > +restart_wait:
> > +     for (i = 0; i < ARRAY_SIZE(pids); i++) {
> > +             if (get_proc_stat(pids[i]) != 'S') {
> > +                     nanosleep(&delay, NULL);
> > +                     goto restart_wait;
> > +             }
> > +     }
>
> I wonder if we should/can combine this loop with the previous one, and
> wait for the child to sleep in getppid() before we fork the next one.
> Otherwise isn't racy in the case that your loop continues to the next
> iteration before the child processes are scheduled, so things might be
> out of order? Maybe I'm missing something.
>
> In any case, this change seems reasonable to me.
>
> Tycho
It's okay if the child processes are started out of order. The test just
verifies that the calls are delivered in FIFO order according to when
the syscall was called (not when the process was started), and we do
this by just looking at the notification ID. It doesn't care about which
process generated the notification.
