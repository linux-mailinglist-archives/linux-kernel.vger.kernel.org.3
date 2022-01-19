Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370C4937F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353449AbiASKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353441AbiASKJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:09:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5C8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 02:09:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b14so7312332lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 02:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp8cMbcJDEiYzY+0yULuk+0IcGw5L33ZvIFmWfHUqAU=;
        b=CQvRhkfnbC+xD8QF/rVpqr3rywffgrz1rcm8TJg2p+6bTu3kG30nI17/JHEnfynDsf
         I8kq5s8xsY/LoxUk82328JCQ29XQ0FWGLnpoTGfWTP7M4F8bBb+2vTWmj4KT2oaiAWCF
         z853+DhFFiedtMMyOhmrHprbwX9L0OWxfRbCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp8cMbcJDEiYzY+0yULuk+0IcGw5L33ZvIFmWfHUqAU=;
        b=ePumuGryfQPtgoQUbz1BWn3rQ0SB/pIk/rFet4iP1cyEiu89BnNOfJ3Wan7FeVrM65
         jg/9uaWD8UOt7xTTca7TN+xCq4rYYFREhL4RRfImF9OMYlg/V2SG6aEiF52d04sbWzAG
         IPBVjTp5eW4p3NLgfVhaHZxWzwcHEK/7VvUjX/AgUk/jxDzd1j5fp6W3uWMedTED55WF
         nXVmNPUHD0h9REhOGBQPqx1uTdsqtFIW3kfdXzDMUVRLL/oF6N+QyjuABUBcqxRMPA92
         4rf1Qy7z7TmDJs0kz4BElhEpM1ZYdjuJlkW0DS9ddrBgsuw84FEvFoDSXKjLILOALmOZ
         MLBw==
X-Gm-Message-State: AOAM533iyY8FJY8f4tYzgKf3ZYd6IcqeizReCYr0Jdhc8oMcu0aVAZGq
        uNRdUvaWWZbZeRP33Uup08qjI+kx9toMeP6iZPGYhw==
X-Google-Smtp-Source: ABdhPJzzCt9OqNfhyesxI3ZvR/vgllDW+/NJmVfRwMNDy+lAtRJIOv/McQhcCJ+BEdYu/p5s21P0oPy1na3quUG/R40=
X-Received: by 2002:a2e:2285:: with SMTP id i127mr13773495lji.414.1642586948036;
 Wed, 19 Jan 2022 02:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20220107093455.73766-1-wenst@chromium.org> <20220107093455.73766-2-wenst@chromium.org>
 <Yecq111pZDP9XFNO@eze-laptop>
In-Reply-To: <Yecq111pZDP9XFNO@eze-laptop>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 19 Jan 2022 18:08:57 +0800
Message-ID: <CAGXv+5GfNgQGJOBihdpGQDbdx-1co_wi0m=-HyxiHDn-kKZBsA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/8] media: hantro: jpeg: Relax register writes
 before write starting hardware
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 19, 2022 at 5:02 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi Chen-Yu,
>
> The series looks good, thanks for picking up this task.
>
> Just a one comment.
>
> On Fri, Jan 07, 2022 at 05:34:48PM +0800, Chen-Yu Tsai wrote:
> > In the earlier submissions of the Hantro/Rockchip JPEG encoder driver, a
> > wmb() was inserted before the final register write that starts the
> > encoder. In v11, it was removed and the second-to-last register write
> > was changed to a non-relaxed write, which has an implicit wmb() [1].
> > The rockchip_vpu2 (then rk3399_vpu) variant is even weirder as there
> > is another writel_relaxed() following the non-relaxed one.
> >
> > Turns out only the last writel() needs to be non-relaxed. Device I/O
> > mappings already guarantee strict ordering to the same endpoint, and
> > the writel() triggering the hardware would force all writes to memory
> > to be observed before the writel() to the hardware is observed.
> >
> > [1] https://lore.kernel.org/linux-media/CAAFQd5ArFG0hU6MgcyLd+_UOP3+T_U-aw2FXv6sE7fGqVCVGqw@mail.gmail.com/
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/staging/media/hantro/hantro_h1_jpeg_enc.c        | 3 +--
> >  drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c | 3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> > index 1450013d3685..03db1c3444f8 100644
> > --- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> > +++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> > @@ -123,8 +123,7 @@ int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx)
> >               | H1_REG_AXI_CTRL_INPUT_SWAP32
> >               | H1_REG_AXI_CTRL_OUTPUT_SWAP8
> >               | H1_REG_AXI_CTRL_INPUT_SWAP8;
> > -     /* Make sure that all registers are written at this point. */
> > -     vepu_write(vpu, reg, H1_REG_AXI_CTRL);
> > +     vepu_write_relaxed(vpu, reg, H1_REG_AXI_CTRL);
> >
>
> As far as I can remember, this logic comes from really old Chromium Kernels.
> You might be right, and this barrier isn't needed... but then OTOH the comment
> is here for a reason, so maybe it is needed (or was needed on some RK3288 SoC revision).

I just realized that my commit log is wrong.

" ... a wmb() was inserted before the final register write that starts the
encoder. ... " . It is actually before the second-to-last register write.

> I don't have RK3288 boards near me, but in any case, I'm not sure
> we'd be able to test this easily (maybe there are issues that only
> trigger under a certain load).

I see. I do have a Veyron around that I haven't used in awhile. But as you
said, it might not be an obvious hardware limitation.

> I'd personally avoid this one change, but if you are confident enough with it
> that's fine too.

Unfortunately they didn't leave a whole lot of clues around. For most hardware,
as I mentioned in the commit log, I think the final non-relaxed write should
suffice. I'd point to the decoder drivers not having any barriers or
non-relaxed writes except the final one, but IIUC they are actually two
distinct pieces of hardware.

I suspect we will never know. This JPEG encoder doesn't seem to get used
a lot. The VP8 and H.264 encoders on ChromeOS work correctly without the
extra barrier and get tested a lot, but that's only testing the RK3399.

Hans, would it be possible for you to skip this patch and pick the rest?
Or would you like me to resent without this one?


Thanks
ChenYu

> Thanks!
> Ezequiel
>
> >       reg = H1_REG_ENC_CTRL_WIDTH(MB_WIDTH(ctx->src_fmt.width))
> >               | H1_REG_ENC_CTRL_HEIGHT(MB_HEIGHT(ctx->src_fmt.height))
> > diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> > index 4df16f59fb97..b931fc5fa1a9 100644
> > --- a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> > +++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> > @@ -152,8 +152,7 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
> >               | VEPU_REG_INPUT_SWAP8
> >               | VEPU_REG_INPUT_SWAP16
> >               | VEPU_REG_INPUT_SWAP32;
> > -     /* Make sure that all registers are written at this point. */
> > -     vepu_write(vpu, reg, VEPU_REG_DATA_ENDIAN);
> > +     vepu_write_relaxed(vpu, reg, VEPU_REG_DATA_ENDIAN);
> >
> >       reg = VEPU_REG_AXI_CTRL_BURST_LEN(16);
> >       vepu_write_relaxed(vpu, reg, VEPU_REG_AXI_CTRL);
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
