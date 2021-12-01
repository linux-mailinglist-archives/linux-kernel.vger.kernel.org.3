Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A2464DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349338AbhLAMjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbhLAMjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:39:52 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DCC061574;
        Wed,  1 Dec 2021 04:36:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so100849526eda.11;
        Wed, 01 Dec 2021 04:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSROiNgB2UD7hNEXl0pvdtL5Q+m1xl2P/sbsa7knooE=;
        b=SoPfXemzg5TzT+sBidzycYY9aJtz55gqbZKRgPbjofKMsQEgUsRJp7eiFKrC5FRIiC
         3efWgavyxuItZt0vmKspBT5/wx3zan6mD5oaAsRAbemEZa9Vw0tWCkJUs3lGl4atg39M
         kbYJFMZ4Ovkhx744nToxDBL0wv/kwzCdfE+E537/O3ajUNvlwyOeQdtaBfaix8a0MzdE
         ADfYtO7gorce92DA5CzMmIQrmRMIWOJkh0B+8GWV5AujiqmqaTFkoZkVxuFKOubAd54E
         9PCmTKPwGnU2ewXjlVibv2wo27uMEGYurWPRoeXVuOofVkL/qXMaRCPWCB/8XEJ3tX+g
         +3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSROiNgB2UD7hNEXl0pvdtL5Q+m1xl2P/sbsa7knooE=;
        b=lO4d1LBod5s3D/TYpggRhbjZ7Ay4ZKpAT9e1o/wsH2o3qM6VfxJ8FM8xysc5eQ6Zvv
         bGtwUDobqfoIp6Pgr2c3I2KAiKHcCzV1HOLi0t4XEir8/xNiS2Rawl2Gw4BIMdC4xBLE
         dQ16D4F9rEzBhmnLXw71dCtBXDvI0nzubdbdhnqd2DZdmRbXhf1El32d6luFf6HTLHLP
         AtCDBcu1sJt5ML69WzTBiSNfM4RKSG6RzZHTojYQR+YaF3K1Lh9u/znaCC/ibwWNvLZs
         ZAbPJKSb1YLFAK/UX5ZiYLPo7EqTumyHHFhom1tvRANy8nx1xQ9C9rObeFLuoOgwrwRr
         RLuA==
X-Gm-Message-State: AOAM531wbOH/vl3Y7ViYAhhaV/pWu2oiMxsMTM8ZXTiL0T4yF7tojvks
        EM/752JyNfTBqqTpkNyxTMN9P7BGvaInMsNST7E=
X-Google-Smtp-Source: ABdhPJwRBzIkt+7WMfehsNJxTzyw1z+gmeMXpKs1X1qC9gIGtgcHmbIx5M/4LYRrbSurRB/40F9cWFs5Grlb+4QS8Oo=
X-Received: by 2002:a17:906:1993:: with SMTP id g19mr6900902ejd.50.1638362189981;
 Wed, 01 Dec 2021 04:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com> <20211201013329.15875-2-aford173@gmail.com>
 <CAAEAJfBBFhRtW2wmoA6T+yyM-nurUbtPqYHKPHjeRdKzA34PcQ@mail.gmail.com>
In-Reply-To: <CAAEAJfBBFhRtW2wmoA6T+yyM-nurUbtPqYHKPHjeRdKzA34PcQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 1 Dec 2021 06:36:18 -0600
Message-ID: <CAHCN7xLGTadbr+=-j2yJHFn233dgHic28njej8LHS2M0WwtqYQ@mail.gmail.com>
Subject: Re: [RFC V2 1/2] media: hantro: Add support for i.MX8M Mini
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Tim Harvey <tharvey@gateworks.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 6:25 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi Adam,
>
> On Tue, 30 Nov 2021 at 22:33, Adam Ford <aford173@gmail.com> wrote:
> >
> > The i.MX8M Mini has a similar implementation of the Hantro G1 and
> > h decoders, but the Mini uses the vpu-blk-ctrl for handling the
> > VPU resets through the power domain system.  As such, there are
> > functions present in the 8MQ that are not applicable to the Mini
> > which requires the driver to have a different compatible flags.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > index fb82b9297a2b..2aa1c520be50 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -592,6 +592,8 @@ static const struct of_device_id of_hantro_match[] = {
> >         { .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
> >  #endif
> >  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> > +       { .compatible = "nxp,imx8mm-vpu", .data = &imx8mm_vpu_variant, },
> > +       { .compatible = "nxp,imx8mm-vpu-g2", .data = &imx8mm_vpu_g2_variant },
> >         { .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
> >         { .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
> >  #endif
> > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> > index 267a6d33a47b..ae7c3fff760c 100644
> > --- a/drivers/staging/media/hantro/hantro_hw.h
> > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > @@ -211,6 +211,8 @@ enum hantro_enc_fmt {
> >         ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
> >  };
> >
> > +extern const struct hantro_variant imx8mm_vpu_g2_variant;
> > +extern const struct hantro_variant imx8mm_vpu_variant;
> >  extern const struct hantro_variant imx8mq_vpu_g2_variant;
> >  extern const struct hantro_variant imx8mq_vpu_variant;
> >  extern const struct hantro_variant px30_vpu_variant;
> > diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > index ea919bfb9891..c68516c00c6d 100644
> > --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > @@ -242,6 +242,32 @@ static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
> >         },
> >  };
> >
> > +static const struct hantro_codec_ops imx8mm_vpu_codec_ops[] = {
> > +       [HANTRO_MODE_MPEG2_DEC] = {
> > +               .run = hantro_g1_mpeg2_dec_run,
> > +               .init = hantro_mpeg2_dec_init,
> > +               .exit = hantro_mpeg2_dec_exit,
> > +       },
> > +       [HANTRO_MODE_VP8_DEC] = {
> > +               .run = hantro_g1_vp8_dec_run,
> > +               .init = hantro_vp8_dec_init,
> > +               .exit = hantro_vp8_dec_exit,
> > +       },
> > +       [HANTRO_MODE_H264_DEC] = {
> > +               .run = hantro_g1_h264_dec_run,
> > +               .init = hantro_h264_dec_init,
> > +               .exit = hantro_h264_dec_exit,
> > +       },
> > +};
> > +
> > +static const struct hantro_codec_ops imx8mm_vpu_g2_codec_ops[] = {
> > +       [HANTRO_MODE_HEVC_DEC] = {
> > +               .run = hantro_g2_hevc_dec_run,
> > +               .init = hantro_hevc_dec_init,
> > +               .exit = hantro_hevc_dec_exit,
> > +       },
> > +};
> > +
>
> I believe you are missing VP9, which explains why you get
> a zero fluster score.

That's what I was thinking too and that's why I was wondering if I
should wait on G2 until more of those G2 patches have been finalized
and accepted.  Is there a way to test the HEVC?  I didn't see one in
the fluster list.

adam
>
> Thanks,
> Ezequiel
