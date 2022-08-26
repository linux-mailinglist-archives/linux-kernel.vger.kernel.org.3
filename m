Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D855A2E13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiHZSMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiHZSMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:12:32 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E46473
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:12:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m5so1740618qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=jqj6CcmKre2a3pdA+WuRdHVwoA5xZ4Au+UEM5d2qlYI=;
        b=AhKOb0Dh0aWKY6d96FWpxn4yIVV5nL2wo5ox/NLY1mthvh2p2ZnfpN3x8s2PdhXxWV
         K13qAB+y1f6GyNardw43tCJzdztj0cuBk4WLqXXYzmsdGoM1bCe+teQvMPxLWyHIGr3j
         D7QQrD2yJSIZxtywAwzlZPDDRuxFCwp4xEdvwuBImD1pRBfKDFbzrojl2F0sIrEb1acE
         fg7riUIEMJz/ZXg6Kyt/c6LxwnoUMj3DMgu5juB92cScx+XyiLKbZDbdiTOSPeY+74Fl
         Y3rSDHg33KJ2LdC0to0gchzU6Q3cb5E5uesblVsSxDIqhKtkwQQmkrZ/5BzFS+qwXY7H
         bAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=jqj6CcmKre2a3pdA+WuRdHVwoA5xZ4Au+UEM5d2qlYI=;
        b=nkjeGTGZiPRynf5/di/lY4Q1JlfOJlV5urT1d+T2CBYHiuqZHPjKr2IsdAIvivdTUI
         KDWaJfbRhg5RpyTtzkmXK21S+eITl/i7W5kxGjeUpMa0lsSzXSPWTEkJvKn9Z+ydh73v
         54llJLlJhTopNin1aeWdXUjbDQc4mwmO7PUOIieWvq9RnAg1GGGqH/WxuZL/EpVs1a9V
         6FaUtPHVTWagC41uv0DUBKTksqD9ptNVEB1wjVmbplISdhMu7owYIfIe8AE2+CiIhQD0
         NSUAHDeOt8Ei2tGNvg/g/eXmmXJ4486DEUnZR2/NedMc8WFqnUd0G2TtcletiVoGhiCw
         lm8w==
X-Gm-Message-State: ACgBeo2DYCS4gcXBP9uCc46zDmHniRU0FLY9YF2r4Xy2JKML6zNxHFao
        QOnEYsDm10xuAc5VCK5Vlfcrsw==
X-Google-Smtp-Source: AA6agR5eU66wk4zOntFXbAXzXuSJU2xPoFvVoH9OyFvpvFAuSW/cAF20aa0FD+LXKNuMSyIzSjUhsg==
X-Received: by 2002:a05:620a:4546:b0:6bb:d625:1ee1 with SMTP id u6-20020a05620a454600b006bbd6251ee1mr689248qkp.23.1661537549399;
        Fri, 26 Aug 2022 11:12:29 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 14-20020ac84e8e000000b003436103df40sm300699qtp.8.2022.08.26.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:12:29 -0700 (PDT)
Message-ID: <0099cb36956090f7c5f3058b353d3555870aea32.camel@ndufresne.ca>
Subject: Re: [PATCH] [media] v4l2: Add AV1, AVS and AVS2 format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shi Hao <hao.shi@amlogic.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, nanxin.qin@amlogic.com
Date:   Fri, 26 Aug 2022 14:12:27 -0400
In-Reply-To: <YwiPMOyfXKM8lxIR@pendragon.ideasonboard.com>
References: <20220826030003.1066976-1-hao.shi@amlogic.com>
         <YwiPMOyfXKM8lxIR@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 26 ao=C3=BBt 2022 =C3=A0 12:15 +0300, Laurent Pinchart a =C3=A9=
crit=C2=A0:
> Hello Shi,
>=20
> Thank you for the patch.
>=20
> On Fri, Aug 26, 2022 at 11:00:03AM +0800, Shi Hao wrote:
> > From: "hao.shi" <hao.shi@amlogic.com>
> >=20
> > Add AV1, AVS and AVS2 compressed pixel formats. They are
> > the more common formats.
> >=20
> > Signed-off-by: Shi Hao <hao.shi@amlogic.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 3 +++
> >  include/uapi/linux/videodev2.h       | 3 +++
>=20
> The patch also needs to document the formats, in
> Documentation/userspace-api/media/v4l/.
>=20
> >  2 files changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index c314025d977e..7b102c2f59b1 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1497,6 +1497,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >  		case V4L2_PIX_FMT_MT21C:	descr =3D "Mediatek Compressed Format"; bre=
ak;
> >  		case V4L2_PIX_FMT_QC08C:	descr =3D "QCOM Compressed 8-bit Format"; b=
reak;
> >  		case V4L2_PIX_FMT_QC10C:	descr =3D "QCOM Compressed 10-bit Format"; =
break;
> > +		case V4L2_PIX_FMT_AV1:		descr =3D "AV1"; break;

A recommendation while adding proper spec/doc. AV1 have multiple representa=
tion,
the exact expected representation should be specified in the doc. This will
avoid similar issues we had with H.264 (Annex B. vs AVCc formats).

> > +		case V4L2_PIX_FMT_AVS:		descr =3D "AVS"; break;
> > +		case V4L2_PIX_FMT_AVS2:		descr =3D "AVS2"; break;

Same things should be checked for these two, they aren't very common outsid=
e of
China, at least I didn't had a chance to play with these so far.

cheers,
Nicolas

> >  		default:
> >  			if (fmt->description[0])
> >  				return;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 01e630f2ec78..fa8ec0ddde3d 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -738,6 +738,9 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H'=
) /* Stateless FWHT (vicodec) */
> >  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H26=
4 parsed slices */
> >  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEV=
C parsed slices */
> > +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 *=
/
> > +#define V4L2_PIX_FMT_AVS      v4l2_fourcc('A', 'V', 'S', '0') /* AVS *=
/
> > +#define V4L2_PIX_FMT_AVS2     v4l2_fourcc('A', 'V', 'S', '2') /* AVS2 =
*/
> > =20
> >  /*  Vendor-specific formats   */
> >  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1=
 YUV */
> >=20
> > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>=20

