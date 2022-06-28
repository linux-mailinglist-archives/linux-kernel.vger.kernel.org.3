Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352855C29F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbiF1HFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiF1HFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:05:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDED27FC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:04:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c13so16142122eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yWK2i+HyLRsoCZd+vTN29Q2YEjkKWRk+CQpa4XDa6BY=;
        b=fOgLokJSTExyqOjCNm2VxyMHWEQDeV705+1o1af5yokGij64Z4nDxITK+ZMbEIQBvr
         KgRmUxfl4VAjrnmHrMA6gG6pEsTaZ1VajlmM9lTd1dNtH8YtPH4lR5ZTHMnCbrcPa4BF
         C3K8hGaPWmIOCmCkmsURro6qKh7wd2fmlZXZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yWK2i+HyLRsoCZd+vTN29Q2YEjkKWRk+CQpa4XDa6BY=;
        b=6H7wGiHR07rMx18Qf8esv/9QLXfkCm4M6G8SHUvciNXkHHE2P2WhdCfDbjkOJr9t4B
         eLWu/btnqVV3FkfVCutOozkWYGedklAM6fG0F4NhXa7fRF/xYQpMATn1eopptGZe2uGT
         jWQm3qKIwUHOAsMHuxxtb+ac068lVfAArUf+QKvikESwR3G16cigKsUoyKxS92zR8+4D
         llpkrP9xBwDd3AFGlvlfT9Gct3rELqzCac2JJa1sBHFWoc/zksmUVYbT2fXKO3ZkeIvC
         tUjo6H4kuyW0Ks1YbZQndeeIu56RfJx3SaOHjN4l2HWXy9w3nDJbs5TkFOb5HD5mDu+G
         NmTg==
X-Gm-Message-State: AJIora8Sv25EYJ+GyowxMKsf/EPf3I7hR4mqQWST5R6dR3DIWxGIhX34
        WsPBaZRxj6sLDyodCcm3Bja81OQqg129pZc7Q9h1Sf8kxE9zBg==
X-Google-Smtp-Source: AGRyM1t7TY1dIg6Bf+r11jbnnZRsYTZLxxtxdnijV+IZHWl/hdOH3aSsx56n1VZxEycMGDqZVRkU6+QDg1Pc/5XcKZ4=
X-Received: by 2002:a05:6402:1cad:b0:437:8234:fdff with SMTP id
 cz13-20020a0564021cad00b004378234fdffmr14575130edb.99.1656399873651; Tue, 28
 Jun 2022 00:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220627112402.2332046-1-wenst@chromium.org> <20220627112402.2332046-2-wenst@chromium.org>
 <f5e68826df868ae5a3cd5737fd9d7f7683bbad73.camel@collabora.com>
 <CAGXv+5GA04LBN0bnLDdL8g_+_8HXpc-KwtPxpXyXi_WgUOPrtQ@mail.gmail.com> <f05953a93fb8f250f4da7c3384b6e1c43c7b1605.camel@collabora.com>
In-Reply-To: <f05953a93fb8f250f4da7c3384b6e1c43c7b1605.camel@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 28 Jun 2022 15:04:22 +0800
Message-ID: <CAGXv+5G-C1S3HKiMx5CjS_qqKN7kj+QfswG+u_O5sE4YAxZmYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: mediatek: vcodec: dec: Fix 4K frame size enumeration
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 3:28 AM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le mardi 28 juin 2022 =C3=A0 00:08 +0800, Chen-Yu Tsai a =C3=A9crit :
> > On Mon, Jun 27, 2022 at 11:32 PM Nicolas Dufresne
> > <nicolas.dufresne@collabora.com> wrote:
> > >
> > > Hi Chen-Yu,
> > >
> > > Le lundi 27 juin 2022 =C3=A0 19:23 +0800, Chen-Yu Tsai a =C3=A9crit :
> > > > This partially reverts commit b018be06f3c7 ("media: mediatek: vcode=
c:
> > > > Read max resolution from dec_capability"). In this commit, the maxi=
mum
> > > > resolution ended up being a function of both the firmware capabilit=
y and
> > > > the current set format.
> > > >
> > > > However, frame size enumeration for output (coded) formats should n=
ot
> > > > depend on the format set, but should return supported resolutions f=
or
> > > > the format requested by userspace.
> > >
> > > Good point. Though, I don't see any special casing for the CAPTURE ca=
se. As this
> > > HW does not include a scaler, it must only return 1 resolution when b=
eing
> > > enumerated for CAPTURE side (or not implement that enumeration, but i=
ts
> > > complicated to half implement something in m2m). The return unique si=
ze should
> > > match what G_FMT(CAPTURE) would return.
> >
> > There are no frame sizes added for the capture formats, so this functio=
n
> > effectively returns -EINVAL for any of them. This is also what rkvdec
> > does: it only looks through the list of coded formats.
>
> This is effectively against the spec, ENOTTY would be the only alternativ=
e to
> not implementing both sides. Though, I'll agree with you, this bugs preda=
tes
> anything here. Perhaps you could at add MM21 to the switch and returns EN=
OTTY
> there ?

I think you are slightly misreading the code? The switch/case is in the
function that adds supported formats, not the ioctl callback.

But yeah, I can have the enum_framesizes callback match against capture
formats and return -ENOTTY for them.

For unmatched formats, either capture or output, is it still correct
to return -EINVAL?

> >
> > Also, struct v4l2_frmsizeenum does not have a field saying whether it's
> > capture or output side; it simply specifies a pixel format.
>
> Acked.
>
> >
> > >
> > > >
> > > > Fix this so that the driver returns the supported resolutions corre=
ctly,
> > > > even if the instance only has default settings, or if the output fo=
rmat
> > > > is currently set to VP8F, which does not support 4K.
> > > >
> > > > Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution =
from dec_capability")
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c    | 2 --
> > > >  .../platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c    | 7 +++=
++++
> > > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.=
c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > > index 5d6fdf18c3a6..fcb4b8131c49 100644
> > > > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > > @@ -595,8 +595,6 @@ static int vidioc_enum_framesizes(struct file *=
file, void *priv,
> > > >               fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> > > >               fsize->stepwise =3D dec_pdata->vdec_framesizes[i].ste=
pwise;
> > > >
> > > > -             fsize->stepwise.max_width =3D ctx->max_width;
> > > > -             fsize->stepwise.max_height =3D ctx->max_height;
> > > >               mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
> > > >                               ctx->dev->dec_capability,
> > > >                               fsize->stepwise.min_width,
> > > > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_=
stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statele=
ss.c
> > > > index 16d55785d84b..9a4d3e3658aa 100644
> > > > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statele=
ss.c
> > > > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statele=
ss.c
> > > > @@ -360,6 +360,13 @@ static void mtk_vcodec_add_formats(unsigned in=
t fourcc,
> > > >
> > > >               mtk_vdec_framesizes[count_framesizes].fourcc =3D four=
cc;
> > > >               mtk_vdec_framesizes[count_framesizes].stepwise =3D st=
epwise_fhd;
> > > > +             if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K=
_DISABLED) &&
> > > > +                 fourcc !=3D V4L2_PIX_FMT_VP8_FRAME) {
> > > > +                     mtk_vdec_framesizes[count_framesizes].stepwis=
e.max_width =3D
> > > > +                             VCODEC_DEC_4K_CODED_WIDTH;
> > > > +                     mtk_vdec_framesizes[count_framesizes].stepwis=
e.max_height =3D
> > > > +                             VCODEC_DEC_4K_CODED_HEIGHT;
> > > > +             }
> > >
> > > I don't particularly like to see this special cased check being added=
 into
> > > multiple places. Its also in your patch 2, and I think it exist in a =
third
> > > place. Could it be possible to have an internal helper to ensure we d=
on't
> >
> > It's also in s_fmt(), so touched on in patch 4. I could also rewrite it=
 so
> > only this spot has the special case, and all the other places look thou=
gh
> > mtk_vdec_framesizes to get the maximum, like what I did for try_fmt in
> > patch 3. What do you think?
>
> I don't have a strong opinion, could be a totally internal (and unrelated=
 to any
> ioctl naming) helper that does the right thing.

According to offline discussions in chat, and looking at the code again,
it seems we can get rid of ctx->max_{width,height} altogether.

The check will only exist in mtk_vcodec_add_formats(), and the resolution
clamping will only happen in the try_fmt callback.

ChenYu

> >
> > Ultimately I think it would be better to move framesizes into the
> > (driver-specific) pixel format data structure. That is a bigger refacto=
ring
> > than a simple fix though.
>
> Agreed.
>
> >
> > > duplicate this logic ? Somehow, it seems there is something in common=
 between
> > > set_default, try_fmt and this code.
> >
> > Yes. That is what I mentioned in chat about refactoring the ioctls and =
format
> > handling code. set_default should really not set anything format specif=
ic,
> > but instead call set_fmt with a default format.
>
> So if this could have a simple helper that returns the max width/height f=
or the
> specified format and HW capability, I'm then fine with the series. If you=
 can
> change the EINVAL (which means nothing is supported) into ENOTTY for the =
MM21
> case, I'd also be more confortable (even though still a bit odd, but no l=
onger a
> lie).
>
> regards,
> Nicolas
>
> >
> >
> > Regards
> > ChenYu
> >
> > >
> > > >               num_framesizes++;
> > > >               break;
> > > >       case V4L2_PIX_FMT_MM21:
> > >
>
