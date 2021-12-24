Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3575C47EA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350880AbhLXB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhLXB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:58:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED555C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 17:58:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso10223628pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 17:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hY9zF0N864/ygbgHrIVShS6KitXV2LyMCC7FyESZcBA=;
        b=kqaT7lw15LbnsRP/mGnaakXfwMLH1TlAsHHs9XsVvVtrprjGR/ZljGhrAtFoVRUKW5
         OTG69UwgFkoc67qI4VVVT6sEO+8ER+o47eMBxbdcuBk+IYzTtfBGDFi/kyReHvq8uAFV
         2Z3jsDOEtKvbLSXE63ikGhr4IJ5Un2luLe6LJH+YAXMzw6weJFigFOcTcRf3GDSee+Q+
         AjviOdv7L9bR2e6O1O/se/g0Armdm9zfFA1wddreNQOocpabP6fe4oinobimpNQI9Gd9
         6DYXrdgSHxTyBaTlGLMAtNw8MqyWqlibN6QGvkelnj5gRBGRcyUFHYR0X8B3JQNKD/A4
         Hkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hY9zF0N864/ygbgHrIVShS6KitXV2LyMCC7FyESZcBA=;
        b=NK9O3cRDw8XIcWt45gGGHANdakDZmctwkeeVCfYralydsktZ8PwpRzBU3zGKs/E498
         XNZb4FYLCFVAt8/O5k3cdSREpkRgUihnoNzitMpkjOMNcfaMlsid5dfHthjITWS2srmE
         UFPY2JQNtjdCFa4V6q2j0c6JJr76SQa+2J1OOy6xkbLi6QSor2Gy71iDWdWU0IJSkfYl
         IOrtWcKtk9u9ia2cucLRhnI3PTKXcsahI2W3VOAydBLyIt5GrHvn6YvWuLtjDaRFB2nf
         3wVovUJaDIZyTvdgG/jO67win5Eoz7Ta7d2kTPbO/N2BbWrcCUgqIo3ki9aUUF/3Svu8
         pUdA==
X-Gm-Message-State: AOAM532ksuMk5guuOYjAkP8/a4eTKiOi1GdI+62qA8aYqJx4JWJgUj8h
        ZQ+tU2c92dFZZCxur5HewQ32tT+9k/W5iAit3gM=
X-Google-Smtp-Source: ABdhPJzPB73PTi0R0r2cSLbUV8IqrHHzgoejiqd8uKxgTZCtfH0jxbd+vSejHJsY/V5bEEn3uf0SUEwuce+N4owOBvM=
X-Received: by 2002:a17:90b:38cd:: with SMTP id nn13mr5708726pjb.37.1640311111865;
 Thu, 23 Dec 2021 17:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20211222091526.8511-1-zhaoxiu.zeng@gmail.com> <YcMAuSFQazD4lBTC@hirez.programming.kicks-ass.net>
In-Reply-To: <YcMAuSFQazD4lBTC@hirez.programming.kicks-ass.net>
From:   Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Date:   Fri, 24 Dec 2021 09:58:21 +0800
Message-ID: <CAHb_TOmEE8Wu-Be3iPbL-FMkDeQf-2o_2B2Xt4tAwPyc7vNtmA@mail.gmail.com>
Subject: Re: [PATCH] schedule: SCHED_RR: Give a fresh time-slice to the task
 after after it suspends or relinquishes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2021=E5=B9=B412=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=89 18:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Dec 22, 2021 at 05:15:26PM +0800, zhaoxiu.zeng wrote:
> > Assuming the sched_rr_timeslice is 100ms, there are several tasks with =
the
> > same priority t1, t2, t3, ..., and t1 sleeps every 80ms, the scheduling
> > timing may be:
> >     t1  t2   t3        t1  t2   t3        t1  t2   t3        t1  t2   t=
3
> >     80, 100, 100, ..., 20, 100, 100, ..., 60, 100, 100, ..., 40, 100, 1=
00
> >
> > After applying this patch, the scheduling timing may be:
> >     t1  t2   t3        t1  t2   t3        t1  t2   t3        t1  t2   t=
3
> >     80, 100, 100, ..., 80, 100, 100, ..., 80, 100, 100, ..., 80, 100, 1=
00
> >
>
> Is this what POSIX mandates or why are you sending this to me ?

Thanks for your reply!

I don't see a definition of this in POSIX.
Give a fresh time-slice may decreases context switches, and be more
fairly to the tasks which suspended then resumed.
