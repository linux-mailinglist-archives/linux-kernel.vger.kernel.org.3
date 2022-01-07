Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D0487A94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbiAGQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348311AbiAGQlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:41:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A0C06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:41:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j11so17540397lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lTPT+dmitAwGRTDpzwc7mnELnHJUbVyQmNF2pcaF2Rk=;
        b=KtS3RNn1icDvaY9ZzuRxXHNPuGylv0dSCZKVjIIDd6vHzWs6kpR0ZBUDiVtG73eArI
         McFELeIhUMda/AhvYaNLZfpGjhlEkQLWK1B1hTXo9deamXDJLqapkp8ix5OO7ngEAPOS
         eInarUcF55ZCpr+RI/neVDNBNJjCh0wfIpzOTc0ZhGZXdgTpF7A9hIkJnfBspnPET2tr
         XiN6m9bI00j5QEGe/Zb/+qFT1miZw1YhtOZE7KBfuVjJYjW95VWG7ti9yvWG9vOfLQl1
         RNy781dpeNYrPOc+jp7g9ANTA0Ly0ZSOAJyTEYPE3DDlEsG8c8QXCjv69KKWsFxNVu2D
         h0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTPT+dmitAwGRTDpzwc7mnELnHJUbVyQmNF2pcaF2Rk=;
        b=QKKTNm7kdlA9IkUalYOGmbuB6gnuVl63/wEwgqG/OomAqKCXKHIqjgfTNRIeIZQyyR
         3Un2VMWeZKhyzlDmTwRrrJOWq6lKhIWS/GojtDJoCz28S2WFsgpbPHWhCp9XrNPXuDij
         Wb6qCci4pJvashaJOZ7ZJdcKB04NA+GP5D9YQU0MRJMQ7p3Fwa/r20V8qM10dkUeFxQv
         fMTf4lKBlW+JEhQHBM2FK310kKRrjcyvl832RPmJMOQ8R10q1CVFZKXk3P3GpS8QDvLo
         oZPlQ7VNmfh1tqRc8Mc6oiQLxpSpT18KHaQYFXNYvw/h8ozUepaNkj2JR4D5onm/8PNs
         DRQQ==
X-Gm-Message-State: AOAM533V84DxITEKArnk4UuNh2P7pdb8NUYTczy9DfZoo4kYHc5lv7wI
        KARCsMQ3w6WaBZPU0urokmGH/jhTKlPH3bH/SJdbPw==
X-Google-Smtp-Source: ABdhPJxbhUQOb/mZfl38h0bjdFgpQVIZe3t1jhXR02261NU1P2OO61nqv+CT8apVEmppCWYjizWWOy5cItgzHBi90sU=
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr55308857lfb.167.1641573694001;
 Fri, 07 Jan 2022 08:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20220105182939.106885-1-paul@crapouillou.net> <20220105182939.106885-2-paul@crapouillou.net>
 <CAPDyKFqiVTcsr03SqCzZsTraivrnM4YxKxPQ7dMmt14dT1uiCQ@mail.gmail.com> <U5MC5R.JX72XLGEKI8P@crapouillou.net>
In-Reply-To: <U5MC5R.JX72XLGEKI8P@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 17:40:57 +0100
Message-ID: <CAPDyKFpPOsoxBbamJWoAso_8cEb--Y1i4zDAnnTQ00EkSySVLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 at 17:37, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Ulf,
>
> Le ven., janv. 7 2022 at 17:26:07 +0100, Ulf Hansson
> <ulf.hansson@linaro.org> a =C3=A9crit :
> > On Wed, 5 Jan 2022 at 19:29, Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >>  The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided
> >> callbacks
> >>  for both runtime PM and system sleep, which is very likely to be a
> >>  mistake, as a system sleep can be triggered while a given device is
> >>  already PM-suspended, which would cause the suspend callback to be
> >>  called twice.
> >>
> >>  The amount of users of UNIVERSAL_DEV_PM_OPS() is also tiny (16
> >>  occurences) compared to the number of places where
> >>  SET_SYSTEM_SLEEP_PM_OPS() is used with pm_runtime_force_suspend()
> >> and
> >>  pm_runtime_force_resume(), which makes me think that none of these
> >> cases
> >>  are actually valid.
> >>
> >>  As this macro is currently unused, remove it before someone starts
> >> to
> >>  use it in yet another invalid case.
> >
> > I assume you refer to DEFINE_UNIVERSAL_DEV_PM_OPS here. Can you
> > perhaps make that more clear?
>
> I can.
>
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>  ---
> >>
> >>  Notes:
> >>      v2: No change
> >>
> >>   include/linux/pm.h | 19 ++++++-------------
> >>   1 file changed, 6 insertions(+), 13 deletions(-)
> >>
> >>  diff --git a/include/linux/pm.h b/include/linux/pm.h
> >>  index e1e9402180b9..31bbaafb06d2 100644
> >>  --- a/include/linux/pm.h
> >>  +++ b/include/linux/pm.h
> >>  @@ -366,6 +366,12 @@ static const struct dev_pm_ops name =3D { \
> >>          SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> >>   }
> >>
> >>  +/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> >>  +#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> >>  +const struct dev_pm_ops __maybe_unused name =3D { \
> >>  +       SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> >>  +}
> >>  +
> >>   /*
> >>    * Use this for defining a set of PM operations to be used in all
> >> situations
> >>    * (system suspend, hibernation or runtime PM).
> >>  @@ -379,19 +385,6 @@ static const struct dev_pm_ops name =3D { \
> >>    * .resume_early(), to the same routines as .runtime_suspend() and
> >>    * .runtime_resume(), respectively (and analogously for
> >> hibernation).
> >>    */
> >>  -#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn,
> >> idle_fn) \
> >>  -static const struct dev_pm_ops name =3D { \
> >>  -       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> >>  -       RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> >>  -}
> >>  -
> >>  -/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> >>  -#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> >>  -const struct dev_pm_ops __maybe_unused name =3D { \
> >>  -       SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> >>  -}
> >>  -
> >>  -/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
> >
> > Shouldn't this macro be deprecated any more?
>
> I can only deprecate it if there is an alternative for it. The
> alternative is DEFINE_RUNTIME_DEV_PM_OPS() which is added in patch 4/6.

I don't think we need an immediate alternative to leave it deprecated, do w=
e?

My point is, a user can still combine the macros in a way so that it
doesn't need to use the UNIVERSAL_DEV_PM_OPS.

>
> Cheers,
> -Paul
>
> >>   #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn)
> >> \
> >>   const struct dev_pm_ops __maybe_unused name =3D { \
> >>          SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> >>  --

Kind regards
Uffe
