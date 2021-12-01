Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6046581E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbhLAVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353679AbhLAVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:06:44 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16027C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:03:23 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kl8so23026790qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zzUyVZkYHJ/EtGhQX/pmQIpQONhG4g4J+RvLaS350ZU=;
        b=ZI7scObmozGOck8w7W6H7cRqNiKozmSQ0jvWo7vGzBlQfhrCf7FkrsMjygkzFh9LFh
         LWITGcH6q8MfYq/EaEHKpk8QbbfnIKtcaBVedIkXcPwhHyI9Z7ziaDZpTsmedGbEJL+E
         nBZFSrmp6/YMldfMIpYRfvWyTeqi5rwwEZudbocxgZZ4lSCN1fwi3O6GJ0y4Vf9JO+XB
         M03fHBu0WzbYlA2kVxuABwvHT24CUnSfKgnV6BYtQZEMR02CwmfntUdzwgFhvtjgsD43
         ALG4hDvTjlTuqivqL5alKt5fdhtVCo/Mq+I8b1oijSnnXOdQfhijgKDnbUxUHCrM2z/X
         FUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zzUyVZkYHJ/EtGhQX/pmQIpQONhG4g4J+RvLaS350ZU=;
        b=PVGEUOzG4896PcajVrhNJosDIMgF+IVsFdLjE/Xj0UFTUfxnCSSaEvFpJFYqvC2o52
         tgXOWUfDYHU5lYa57wOqY1BSwOJ3MZZmSV9nuLdWKAUFCUIzFfbJUsgR6SX6Ly+ThZFi
         g9Vr1Pi/HPavuWZzDYeI6gM7Ekwgzx8y6Y7hHLeTinPfRBV9Eu9SLTtxvUsr9tNei+JJ
         1eEMMnyQnU3MVP95lrEgBQ2IFvu0wPY+qcdMHkzn4DUIaLnqk1B78b4Ak5UD8BM+d51D
         O4WFAmasssljuuewmW2R6pT6a2ZYDRoAKT3+R0XiYqVTLTozcKZm78TTAF171NeTqgFY
         +NYw==
X-Gm-Message-State: AOAM532qu6EHZWMLeYMc0RHNRxJcZVAOzYzlWQd8iM35MiBQUJ9LGpjN
        6wFgSJFC/5sdTyWXvA40jkWOnQ==
X-Google-Smtp-Source: ABdhPJwHo89Y0ElsYVSWh/R6qNsHkOikRJSJcPfLtzPsRdk3EejBbMpKLw8GyLWQT7w8bCh04oLn9Q==
X-Received: by 2002:a05:6214:e41:: with SMTP id o1mr8967705qvc.88.1638392602056;
        Wed, 01 Dec 2021 13:03:22 -0800 (PST)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id w10sm454063qtk.90.2021.12.01.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:03:21 -0800 (PST)
Message-ID: <d8335964ece000814c8ec2ea0274498b3280812c.camel@ndufresne.ca>
Subject: Re: [RFC V2 1/2] media: hantro: Add support for i.MX8M Mini
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Date:   Wed, 01 Dec 2021 16:03:19 -0500
In-Reply-To: <CAAEAJfDqBezv1_ZsF3vjAFprZYuaE7krkSXa4vzAfMZp5_z+sA@mail.gmail.com>
References: <20211201013329.15875-1-aford173@gmail.com>
         <20211201013329.15875-2-aford173@gmail.com>
         <CAAEAJfBBFhRtW2wmoA6T+yyM-nurUbtPqYHKPHjeRdKzA34PcQ@mail.gmail.com>
         <CAHCN7xLGTadbr+=-j2yJHFn233dgHic28njej8LHS2M0WwtqYQ@mail.gmail.com>
         <CAAEAJfDqBezv1_ZsF3vjAFprZYuaE7krkSXa4vzAfMZp5_z+sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 01 décembre 2021 à 09:58 -0300, Ezequiel Garcia a écrit :
> On Wed, 1 Dec 2021 at 09:36, Adam Ford <aford173@gmail.com> wrote:
> > 
> > On Wed, Dec 1, 2021 at 6:25 AM Ezequiel Garcia
> > <ezequiel@vanguardiasur.com.ar> wrote:
> > > 
> > > Hi Adam,
> > > 
> > > On Tue, 30 Nov 2021 at 22:33, Adam Ford <aford173@gmail.com> wrote:
> > > > 
> > > > The i.MX8M Mini has a similar implementation of the Hantro G1 and
> > > > h decoders, but the Mini uses the vpu-blk-ctrl for handling the
> > > > VPU resets through the power domain system.  As such, there are
> > > > functions present in the 8MQ that are not applicable to the Mini
> > > > which requires the driver to have a different compatible flags.
> > > > 
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > 
> > > > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > > > index fb82b9297a2b..2aa1c520be50 100644
> > > > --- a/drivers/staging/media/hantro/hantro_drv.c
> > > > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > > > @@ -592,6 +592,8 @@ static const struct of_device_id of_hantro_match[] = {
> > > >         { .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
> > > >  #endif
> > > >  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> > > > +       { .compatible = "nxp,imx8mm-vpu", .data = &imx8mm_vpu_variant, },
> > > > +       { .compatible = "nxp,imx8mm-vpu-g2", .data = &imx8mm_vpu_g2_variant },
> > > >         { .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
> > > >         { .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
> > > >  #endif
> > > > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> > > > index 267a6d33a47b..ae7c3fff760c 100644
> > > > --- a/drivers/staging/media/hantro/hantro_hw.h
> > > > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > > > @@ -211,6 +211,8 @@ enum hantro_enc_fmt {
> > > >         ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
> > > >  };
> > > > 
> > > > +extern const struct hantro_variant imx8mm_vpu_g2_variant;
> > > > +extern const struct hantro_variant imx8mm_vpu_variant;
> > > >  extern const struct hantro_variant imx8mq_vpu_g2_variant;
> > > >  extern const struct hantro_variant imx8mq_vpu_variant;
> > > >  extern const struct hantro_variant px30_vpu_variant;
> > > > diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > index ea919bfb9891..c68516c00c6d 100644
> > > > --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > @@ -242,6 +242,32 @@ static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
> > > >         },
> > > >  };
> > > > 
> > > > +static const struct hantro_codec_ops imx8mm_vpu_codec_ops[] = {
> > > > +       [HANTRO_MODE_MPEG2_DEC] = {
> > > > +               .run = hantro_g1_mpeg2_dec_run,
> > > > +               .init = hantro_mpeg2_dec_init,
> > > > +               .exit = hantro_mpeg2_dec_exit,
> > > > +       },
> > > > +       [HANTRO_MODE_VP8_DEC] = {
> > > > +               .run = hantro_g1_vp8_dec_run,
> > > > +               .init = hantro_vp8_dec_init,
> > > > +               .exit = hantro_vp8_dec_exit,
> > > > +       },
> > > > +       [HANTRO_MODE_H264_DEC] = {
> > > > +               .run = hantro_g1_h264_dec_run,
> > > > +               .init = hantro_h264_dec_init,
> > > > +               .exit = hantro_h264_dec_exit,
> > > > +       },
> > > > +};
> > > > +
> > > > +static const struct hantro_codec_ops imx8mm_vpu_g2_codec_ops[] = {
> > > > +       [HANTRO_MODE_HEVC_DEC] = {
> > > > +               .run = hantro_g2_hevc_dec_run,
> > > > +               .init = hantro_hevc_dec_init,
> > > > +               .exit = hantro_hevc_dec_exit,
> > > > +       },
> > > > +};
> > > > +
> > > 
> > > I believe you are missing VP9, which explains why you get
> > > a zero fluster score.
> > 
> > That's what I was thinking too and that's why I was wondering if I
> > should wait on G2 until more of those G2 patches have been finalized
> > and accepted.  Is there a way to test the HEVC?  I didn't see one in
> > the fluster list.
> > 
> 
> VP9 is on its way to be merged. There is a pull request from Hans
> already: see https://www.spinics.net/lists/linux-media/msg202448.html
> which includes the git repository and tag you can merge/rebase to test
> it.
> 
> It would be great if you can test G2 on top of that, but it's also fine
> if you want to just submit G1 for now. Up to you.
> 
> Regarding HEVC, currently Benjamin is who knows best how to test it.
> Thinking about it, perhaps we should document this somewhere?

There is GStreamer-H.265-V4L2SL-Gst1.0 decoder already in fluster. And GStreamer
support is still WIP.

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079

We had put on hold the HEVC work in order to focus on VP9. Now that VP9 is on
its way (I've sent another MR today to GStreamer to fix some more tests). I
haven't tested myself imx8mq recently, will likely do soon, so I can give you
the expected score. Your VP8 and H264 score matches the result I got. Note that
H264 driver is missing interlace support, which is half the tests.

We will can resume this work. Help is welcome of course. The HEVC staging API is
by was the worst, so there is quite some work to move this API to stable and
then port all the drivers to the require changes that will be needed.

> 
> Regards,
> Ezequiel

