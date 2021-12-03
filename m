Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1C467CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358978AbhLCSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353418AbhLCSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:08:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8257EC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:05:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b40so8350721lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LOiGOK72jQHcJwoA9Ug2io1X5E1YQyHePMydjO5mgtE=;
        b=ZH734NJ6asdTCwD8zssB/MDSVhw2Ea9HMTnQ5NlS9FVW0xYqLtrjULzRMbkPKKDk1a
         63uSPDsQIpC1Q+U15xhELiS5dYuxX65tGyjA8DyFje+5NvLqmCBwk6eitsG1ohXa7zmF
         Yge2n+zFe/Uzh3qleWKozSLmGxnPqrSbB992M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LOiGOK72jQHcJwoA9Ug2io1X5E1YQyHePMydjO5mgtE=;
        b=LqFnL2eaU0vaXBgQCMyaw12sA0hPRxHZdvXubF+i8dfobz/RXbMZ811SfCrlygiW9i
         0Fj2Pj0o/MMf5/MA8PF1o1ygC1rVF/ghDk02PiYIgEHU6b0b01T5xhos0uMQbSBFmcD8
         2iGp+I2TtdiauWP2DdokGtoyRwnzhjX1nTwxkvs6dZ6twDuy50gBj2wIj1d6OxFhERdG
         aAMHoeQoP920Qjm/ipZD8aGVeAvaXqkayIxXBlR+YP3qZgqaXUmWhuHasCLHC2GkP+hV
         G4vjGi9kQxRUMKACHlTriefxb08p3KdY+MUROILFfd34LlL1jqmoMvMtkiILjzVWst7t
         KWXw==
X-Gm-Message-State: AOAM533yOL/tguelZgv4RNCwgG///wfwLVcpNtuLVRwLjdbxL2IrU4W3
        cdthe/9NR9Qq9Fwp+hb+Lch83P9HDnagPMswPRfVrw==
X-Google-Smtp-Source: ABdhPJzcyJiqOMfZdIjPReNTh4Qh5YzW+O9ImzeTsNE6g4mOFb/VawZlaUXicREe25+UeUHc0Yve5btAIqdJlsAyRvY=
X-Received: by 2002:a19:7417:: with SMTP id v23mr19418211lfe.19.1638554732834;
 Fri, 03 Dec 2021 10:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20211202151200.3125685-1-markyacoub@chromium.org>
 <392a239a-14da-c544-a1f9-09d8b25d3e07@gmail.com> <35169619-479d-24f4-c830-a95a9ef49bb1@mailbox.org>
In-Reply-To: <35169619-479d-24f4-c830-a95a9ef49bb1@mailbox.org>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Fri, 3 Dec 2021 13:05:21 -0500
Message-ID: <CAJUqKUob5j86d==Xh_U90moygJo2QueaarmMXy1FZ2btnpfAWA@mail.gmail.com>
Subject: Re: [PATCH] drm: send vblank event with the attached sequence rather
 than current
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, jason-jh.lin@mediatek.com,
        linux-kernel@vger.kernel.org, tzungbi@google.com,
        seanpaul@chromium.org, Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:03 PM Michel D=C3=A4nzer <michel.daenzer@mailbox.o=
rg> wrote:
>
> On 2021-12-03 16:58, Matthias Brugger wrote:
> > Hi Mark,
> >
> > On 02/12/2021 16:11, Mark Yacoub wrote:
> >> From: Mark Yacoub <markyacoub@google.com>
> >>
> >
> > please make sure to add the linux-mediatek mailinglist in any follow-up=
 communication.
> >
> > Regards,
> > Matthias
> >
> >> [Why]
> >> drm_handle_vblank_events loops over vblank_event_list to send any even=
t
> >> that is current or has passed.
> >> More than 1 event could be pending with past sequence time that need t=
o
> >> be send. This can be a side effect of drivers without hardware vblank
> >> counter and they depend on the difference in the timestamps and the
> >> frame/field duration calculated in drm_update_vblank_count. This can
> >> lead to 1 vblirq being ignored due to very small diff,
>
> That sounds like the real issue which needs to be addressed. As Ville wro=
te, the sequence value in the event is supposed to be the current sequence,=
 not the one which was specified originally by user space. So this change w=
ould basically break the universe. ;)
>
I don't wanna be the reason to break the universe :)) I guess I
misunderstood what the call does, will look into the real issue more.
Thanks everyone!
>
> >> resulting in a subsequent vblank with 2 pending vblank events to be se=
nt, each with a
> >> unique sequence expected by user space.
> >>
> >> [How]
> >> Send each pending vblank event with the sequence it's waiting on inste=
ad
> >> of assigning the current sequence to all of them.
> >>
> >> Fixes igt@kms_flip "Unexpected frame sequence"
> >> Tested on Jacuzzi (MT8183)
> >>
> >> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> >> ---
> >>   drivers/gpu/drm/drm_vblank.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank=
.c
> >> index 3417e1ac79185..47da8056abc14 100644
> >> --- a/drivers/gpu/drm/drm_vblank.c
> >> +++ b/drivers/gpu/drm/drm_vblank.c
> >> @@ -1902,7 +1902,7 @@ static void drm_handle_vblank_events(struct drm_=
device *dev, unsigned int pipe)
> >>             list_del(&e->base.link);
> >>           drm_vblank_put(dev, pipe);
> >> -        send_vblank_event(dev, e, seq, now);
> >> +        send_vblank_event(dev, e, e->sequence, now);
> >>       }
> >>         if (crtc && crtc->funcs->get_vblank_timestamp)
> >>
>
>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
