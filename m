Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4297E4939FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354386AbiASMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354369AbiASMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:00:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2441C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:00:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so10329110edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BZXEWpLZHNGFLnHvF+VUrdwjsLd9cNgSucSnPROzJ4=;
        b=OzbGVXBL5geph+h5UpYKQFMaYOvOFUNOW9r1GtHvF42MqCILSEJuzWweeMYMiVywz2
         HIWYHcUvDh8D1JM1GPIIqNL+UYPrBNH/BN0Vx+hhuAGi8Rd/QYIjii/K81k0nSBGY9qg
         tEdOi9gydP/ZKVyHMhD5nflgNWmoOZ7EC4sRylfCwNI0OjBN9xqW8/fOuBaNXFFHDevA
         TDloC4Lcx9EsoIL0rl+Vq05B6PQLVDuFpLcBbEG6f6jOa1KsyGRDyuIfg+eiyizj0GvX
         163UvWCZZZtx7r6z9TIn0lwEGPQpbvJpa9NEEtZ3NPCKKce9ZLL6B3X5/opzn/anpWK9
         HwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BZXEWpLZHNGFLnHvF+VUrdwjsLd9cNgSucSnPROzJ4=;
        b=xXgUrfv1s8f5B73hq7seVx8hAbPuVlRlO2cO1XC9aurQUkFYbuH68Qz+Wo6fU2VySV
         WrBAIGSc6c+juClES1GGii6oQ66Ye2zbzOyIHpeB+zPzBCTlPNLt2WKbNjqe7We9aSOj
         dw6Hb1BOHLEsDtfI8YIA3fjLjGhc0YXhojTZ1Go7fDYqAbBd7WOv8dk66p6PmGI6eWDH
         ezmfSQgt9YsNebH4po1E3oPuIXhldEuYg20y6NCCSb18tQdZVhPdzzyTEElBPfWpdyG0
         Qp07yx2mcJR5qef8erAttCUuK+gnCt9HX8zT/inOmpehqguLhErl0DeQV1KXZWlOlq6m
         9HWg==
X-Gm-Message-State: AOAM533AlrQ58pODozP8lLlFbXYLKsZTudOapOWlnE8RKZZ6Ap0Indgq
        d7wQpyTcRgo/gvDeiYya9MNvfWky0H0TAwY7R9ZM+Q==
X-Google-Smtp-Source: ABdhPJx698OCGgL9gobCcTHcx/x3zyqw6IuDjzeKHZeQHHEMq40nl0OIDYQzfYebVsR+hUN+VulaPBPAjUESyzV4Gqc=
X-Received: by 2002:a17:907:972a:: with SMTP id jg42mr25276206ejc.757.1642593607306;
 Wed, 19 Jan 2022 04:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20220107093455.73766-1-wenst@chromium.org> <20220107093455.73766-2-wenst@chromium.org>
 <Yecq111pZDP9XFNO@eze-laptop> <CAGXv+5GfNgQGJOBihdpGQDbdx-1co_wi0m=-HyxiHDn-kKZBsA@mail.gmail.com>
In-Reply-To: <CAGXv+5GfNgQGJOBihdpGQDbdx-1co_wi0m=-HyxiHDn-kKZBsA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 19 Jan 2022 08:59:51 -0300
Message-ID: <CAAEAJfBM4d4hd1Av_TO-WVXQoUCNUckm+YHawdg6PY3urkB9nA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/8] media: hantro: jpeg: Relax register writes
 before write starting hardware
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 07:09, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jan 19, 2022 at 5:02 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > Hi Chen-Yu,
> >
> > The series looks good, thanks for picking up this task.
> >
> > Just a one comment.
> >
> > On Fri, Jan 07, 2022 at 05:34:48PM +0800, Chen-Yu Tsai wrote:
> > > In the earlier submissions of the Hantro/Rockchip JPEG encoder driver, a
> > > wmb() was inserted before the final register write that starts the
> > > encoder. In v11, it was removed and the second-to-last register write
> > > was changed to a non-relaxed write, which has an implicit wmb() [1].
> > > The rockchip_vpu2 (then rk3399_vpu) variant is even weirder as there
> > > is another writel_relaxed() following the non-relaxed one.
> > >
> > > Turns out only the last writel() needs to be non-relaxed. Device I/O
> > > mappings already guarantee strict ordering to the same endpoint, and
> > > the writel() triggering the hardware would force all writes to memory
> > > to be observed before the writel() to the hardware is observed.
> > >
> > > [1] https://lore.kernel.org/linux-media/CAAFQd5ArFG0hU6MgcyLd+_UOP3+T_U-aw2FXv6sE7fGqVCVGqw@mail.gmail.com/
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >  drivers/staging/media/hantro/hantro_h1_jpeg_enc.c        | 3 +--
> > >  drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c | 3 +--
> > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> > > index 1450013d3685..03db1c3444f8 100644
> > > --- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> > > +++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> > > @@ -123,8 +123,7 @@ int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx)
> > >               | H1_REG_AXI_CTRL_INPUT_SWAP32
> > >               | H1_REG_AXI_CTRL_OUTPUT_SWAP8
> > >               | H1_REG_AXI_CTRL_INPUT_SWAP8;
> > > -     /* Make sure that all registers are written at this point. */
> > > -     vepu_write(vpu, reg, H1_REG_AXI_CTRL);
> > > +     vepu_write_relaxed(vpu, reg, H1_REG_AXI_CTRL);
> > >
> >
> > As far as I can remember, this logic comes from really old Chromium Kernels.
> > You might be right, and this barrier isn't needed... but then OTOH the comment
> > is here for a reason, so maybe it is needed (or was needed on some RK3288 SoC revision).
>
> I just realized that my commit log is wrong.
>
> " ... a wmb() was inserted before the final register write that starts the
> encoder. ... " . It is actually before the second-to-last register write.
>
> > I don't have RK3288 boards near me, but in any case, I'm not sure
> > we'd be able to test this easily (maybe there are issues that only
> > trigger under a certain load).
>
> I see. I do have a Veyron around that I haven't used in awhile. But as you
> said, it might not be an obvious hardware limitation.
>
> > I'd personally avoid this one change, but if you are confident enough with it
> > that's fine too.
>
> Unfortunately they didn't leave a whole lot of clues around. For most hardware,
> as I mentioned in the commit log, I think the final non-relaxed write should
> suffice. I'd point to the decoder drivers not having any barriers or
> non-relaxed writes except the final one, but IIUC they are actually two
> distinct pieces of hardware.
>
> I suspect we will never know. This JPEG encoder doesn't seem to get used
> a lot. The VP8 and H.264 encoders on ChromeOS work correctly without the
> extra barrier and get tested a lot, but that's only testing the RK3399.
>
> Hans, would it be possible for you to skip this patch and pick the rest?
> Or would you like me to resent without this one?
>

If you decide to resend, feel free to add:

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

to the whole series.

Thanks,
Ezequiel
