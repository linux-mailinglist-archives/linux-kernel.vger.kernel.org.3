Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9F53448C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344775AbiEYTtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbiEYTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:49:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA062CD7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:49:38 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ff90e0937aso151179167b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lcsU1M3aHmWM93+N/Pq2k69CNkfyIQUCxczoLH0OLPk=;
        b=hGvqDCPINlCno6IGVx/RQ4/atSQ+dW08eMaP/4u4J2Rx0AU21Orr25m5AgNUJgVoBC
         3FFOnaz5xSM9a3RRyGWmmLYgiZVdvKzEmj7vsHFg6Sh7EwGqNKrvH43xPCnlETqRbyTJ
         rUgPCSCAGnF+I3fcFxMltq5wx33LgoLK4ERO4IR4Sot/Uaxxldi6tkX+WdLxAvCCiEtI
         QP4xUPzpC2rlJZR8sd1n3W8vuHEHoaO4LC9YRcKisj9Uq+DszGcvpWkcK75IpZtbpf64
         JIxJLJ+6BngIh5kjOcaFiUEdbJbMoovEHpIlAtRm4xeoQYYTe1wf9PGaYkAV8y48Abi0
         +6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lcsU1M3aHmWM93+N/Pq2k69CNkfyIQUCxczoLH0OLPk=;
        b=8IGK/qKfKeKbU8t1/NXvwZtltiT3qd0JNEaxEs+cGzAHVwFjNQIpq0g5hxXP/UgtPv
         MSbdhGFIqrpYLpkKQ2CNoJmc60mBz2MVukaQ0fyxjxiyqA+AhB39dC5YStzEvhtImj0q
         235KFcykSnHxl1BVvgop1nxKXz9XaZi9BG+Ui7c5JFk8tSHx6ffUmJR14dhODJnvsFm8
         iOaK6sPov+zP5yjyFmn3DceuS4oQUJjABjX/M2mt392icW6P4hKa4tAE/Tqw3OXMZQbe
         cAfBJkUG26iQ5tnQy7QCBHfroumpJhdXpYruUjBoclepDu3WIFfiJ8HTOZ0/f4KmtniS
         T8Mw==
X-Gm-Message-State: AOAM531CN9GfIv23Qr9pN9Yjkzh8KWgz9MVI1PTZM0wzFylUgLKs4IDH
        a1XVOQlovixFQ7tN3BMKv/nfb9xbwywXww47SV86wQ==
X-Google-Smtp-Source: ABdhPJye/LYmXdbx2DRGvhYd77idEIGqJLpVK4M7sUVcSaytWZ/KajOi10nwmyuJy9EQw0Od4wYghiCxgCclb01GpVs=
X-Received: by 2002:a81:72c5:0:b0:300:7d0:a642 with SMTP id
 n188-20020a8172c5000000b0030007d0a642mr14402533ywc.80.1653508177547; Wed, 25
 May 2022 12:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X> <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X> <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X> <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X> <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de> <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
 <Yo3WvGnNk3LvLb7R@linutronix.de>
In-Reply-To: <Yo3WvGnNk3LvLb7R@linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 25 May 2022 12:49:00 -0700
Message-ID: <CAGETcx84ja_w_=vXKDOZnM8EVEcuAg1tX9Kqy57PTkDb1=H4FA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 12:12 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-05-24 10:46:49 [-0700], Saravana Kannan wrote:
> > > Removing probe_timeout_waitqueue (as suggested) or setting the timeou=
t
> > > to 0 avoids the delay.
> >
> > In your case, I think it might be working as intended? Curious, what
> > was the call stack in your case where it was blocked?
>
> Why is then there 10sec delay during boot? The backtrace is
> |------------[ cut here ]------------
> |WARNING: CPU: 4 PID: 1 at drivers/base/dd.c:742 wait_for_device_probe+0x=
30/0x110
> |Modules linked in:
> |CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5+ #154
> |RIP: 0010:wait_for_device_probe+0x30/0x110
> |Call Trace:
> | <TASK>
> | prepare_namespace+0x2b/0x160
> | kernel_init_freeable+0x2b3/0x2dd
> | kernel_init+0x11/0x110
> | ret_from_fork+0x22/0x30
> | </TASK>
>
> Looking closer, it can't access init. This in particular box boots
> directly the kernel without an initramfs so the kernel later mounts
> /dev/sda1 and everything is good.  So that seems to be the reason=E2=80=
=A6

Hmmm... that part shouldn't matter. As long as you are hitting the
same code path. My guess is one of them has CONFIG_MODULES enabled and
the other doesn't.

In either case, I think the patch needs to be reverted (I'll send out
one soon), but that'll also mean I need to revert part of my patch
(sets the timeout back to 0) or I need to fix this case:
https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01=
MB4544.jpnprd01.prod.outlook.com/

I'll try to do the latter if I can get something reasonable soon.
Otherwise, I'll just do the revert + partial revert.

-Saravana


> My other machine with an initramfs does not show this problem.
>
> > -Saravana
>
> Sebastian
