Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7118E566F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiGENiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiGENh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:37:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FEA7BD00
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:59:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x1so13463946qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=OcCzp3/I2S1Lj2WiWjf+IVXJz5y+wSXmaCXx6oy51R4=;
        b=MujJyB/23qhfekOKjeLTm4xManAfIMczJHZUilG6Po9qwwvUJlx/wEkIj0+1LWks1C
         L8xPcDXK47Mro267I/Ry0acKOUHrC5G+9s3uKojLwv0sambB5WtEwE2oHdB20wFycoc9
         wfFcZUS0RDpodCtOLLdghxBHBUpfbMFueJUbFgcjoVk0PfeeuZlv/fHooeWdIYy70TEa
         pUJ+k4eGBC/RnP+nTAnPjmSGaz0BhkgertJK/Ko7SKyOFrJJARCBXTKhQ9F1JIyE85dS
         wQdTmc1o2HVc+fA3SJvx3cHCIw+7mENH5TG/U3i8ZPYuEf7wZS1e6btK62DWMB9bC7C+
         KN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=OcCzp3/I2S1Lj2WiWjf+IVXJz5y+wSXmaCXx6oy51R4=;
        b=zFMT02HWk+bHvvUHNvYsVe+4ANBQeHD+NUfd52AIp3XVqRfmbrrfv3VWXSA06GgUqV
         wByuJQ87TQKO+jUi0UzdFpANtz3MiRNzXojaGrkwz4rAqbNTva9CWbgbY+Kt2/RKh07R
         yc+OXQ5yVzuUPQ523O5AP19l1AedK/QoyGBW6IOmlAg9tJpy8JM+tVffU1r9vsFK0cki
         kGt58i2KAqBPQu8JP8zr+iQvNKOON2HzY6pk8ygHvUp5jswQrmbH8B3Ce7r+qawBw80x
         G5h4FL/ozQd7ZYdqduUfGN+cGSyrUhKBcAEOBML/rebdj9v9Qc5L0rwnVXQVZIVQj4hC
         k9aw==
X-Gm-Message-State: AJIora+pBFylT1oPB3ZP1M72wOUZbEBnaRUzhJA1IilParOKZ9RpXbv5
        G7oC3TYalrFx7EGvvSlTfetOWA==
X-Google-Smtp-Source: AGRyM1s6Ap3z2L+CmoX67bFaxVHJdK0WVqG8dR58i0XDYQMI8+KD2oirAljxhMaQtELYPMsItiPL+g==
X-Received: by 2002:a05:6214:c22:b0:472:f86e:47b2 with SMTP id a2-20020a0562140c2200b00472f86e47b2mr7376314qvd.102.1657025953568;
        Tue, 05 Jul 2022 05:59:13 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05620a458d00b006af10bd3635sm21454592qkb.57.2022.07.05.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:59:12 -0700 (PDT)
Message-ID: <42ba6a9516f4359b757d2f94b16c1bb23cc41cb2.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH] media: amphion: only insert the first
 sequence startcode for vc1l format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 05 Jul 2022 08:59:11 -0400
In-Reply-To: <AM6PR04MB634136824EC98EE804FAD0CEE7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
         <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
         <AM6PR04MB6341F4EB028CAE9B61C85157E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB634136824EC98EE804FAD0CEE7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 juillet 2022 =C3=A0 11:27 +0000, Ming Qian a =C3=A9crit=C2=A0:
> > > From: Ming Qian
> > > Sent: 2022=E5=B9=B47=E6=9C=885=E6=97=A5 10:00
> > > To: Nicolas Dufresne <nicolas@ndufresne.ca>; mchehab@kernel.org;
> > > hverkuil-cisco@xs4all.nl
> > > Cc: shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > > <linux-imx@nxp.com>; linux-media@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: RE: [EXT] Re: [PATCH] media: amphion: only insert the first
> > > sequence
> > > startcode for vc1l format
> > >=20
> > > > From: Nicolas Dufresne <nicolas@ndufresne.ca>
> > > > Sent: 2022=E5=B9=B47=E6=9C=885=E6=97=A5 0:06
> > > > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> > > > hverkuil-cisco@xs4all.nl
> > > > Cc: shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de=
;
> > > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > > > <linux-imx@nxp.com>; linux-media@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > > Subject: [EXT] Re: [PATCH] media: amphion: only insert the first
> > > > sequence startcode for vc1l format
> > > >=20
> > > > Caution: EXT Email
> > > >=20
> > > > Hi Ming,
> > > >=20
> > > > Le mardi 28 juin 2022 =C3=A0 13:20 +0800, Ming Qian a =C3=A9crit :
> > > > > For some formats, the amphion vpu requires startcode before seque=
nce
> > > > > and frame, such as vc1, vp8.
> > > >=20
> > > > I'm not sure why VP8 is being mentioned here. There is no specified
> > > > sartcode for VP8, and no split of headers either.
> > > >=20
> > >=20
> > > Hi Nicolas,
> > > =C2=A0=C2=A0=C2=A0This patch has nothing to do with vp8, and indeed t=
here is no specified
> > > startcode for VP8.
> > > But amphion vpu requires driver to help insert some custom startcode =
for
> > > vp8
> > > and vc1.
> > > It's custom behavior.
> > >=20
> > Instead of exposing the custom format, you should use data_offset like =
VENUS
> > driver do.  They vp8/9 codec in VENUS have the frame prefixed with an I=
VF
> > header, the data_offset let the userland skip it.
>=20
> Hi Nicolas,
> =C2=A0=C2=A0=C2=A0=C2=A0There is a stream buffer, and driver will copy th=
e coded frame data to the
> stream buffer, driver can decide to insert custom startcode or not, userl=
and
> won't know about it, so I don't think it's necessary to use data_offset t=
o let
> userland skip something.
> =C2=A0=C2=A0=C2=A0=C2=A0Currently , driver will insert startcode for form=
at vp8 and vc1. This is
> transparent to the user.

Can't you save the slow copy by using data_offset then ? I think most of th=
e
confusion comes from this commit message, someone else then you should be a=
ble
to understand what it means.

regards,
Nicolas

>=20
> Ming
>=20
> > > =C2=A0=C2=A0=C2=A0I'm sorry that my description include some confusio=
n
> > >=20
> > > Ming
> > >=20
> > > > >=20
> > > > > But for V4L2_PIX_FMT_VC1_ANNEX_L, only the first sequence startco=
de
> > > > > is needed, the extra startcode will cause decoding error.
> > > > > So after seek, we don't need to insert the sequence startcode.
> > > > >=20
> > > > > In other words, for V4L2_PIX_FMT_VC1_ANNEX_L, the vpu doesn't
> > > > > support dynamic resolution change.
> > > > >=20
> > > > > Fixes: 145e936380edb ("media: amphion: implement malone decoder r=
pc
> > > > > interface")
> > > > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > > > ---
> > > > > =C2=A0drivers/media/platform/amphion/vdec.c       | 1 +
> > > > > =C2=A0drivers/media/platform/amphion/vpu.h        | 1 +
> > > > > =C2=A0drivers/media/platform/amphion/vpu_malone.c | 2 ++
> > > > > =C2=A0drivers/media/platform/amphion/vpu_rpc.h    | 7 ++++++-
> > > > > =C2=A04 files changed, 10 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/media/platform/amphion/vdec.c
> > > > > b/drivers/media/platform/amphion/vdec.c
> > > > > index 09d4f27970ec..51218a41a5ac 100644
> > > > > --- a/drivers/media/platform/amphion/vdec.c
> > > > > +++ b/drivers/media/platform/amphion/vdec.c
> > > > > @@ -731,6 +731,7 @@ static void vdec_stop_done(struct vpu_inst *i=
nst)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vdec->eos_received =3D 0;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vdec->is_source_changed =3D f=
alse;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vdec->source_change =3D 0;
> > > > > +     inst->total_input_count =3D 0;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vpu_inst_unlock(inst);
> > > > > =C2=A0}
> > > > >=20
> > > > > diff --git a/drivers/media/platform/amphion/vpu.h
> > > > > b/drivers/media/platform/amphion/vpu.h
> > > > > index e56b96a7e5d3..f914de6ed81e 100644
> > > > > --- a/drivers/media/platform/amphion/vpu.h
> > > > > +++ b/drivers/media/platform/amphion/vpu.h
> > > > > @@ -258,6 +258,7 @@ struct vpu_inst {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct vpu_format cap_format;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 min_buffer_cap;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 min_buffer_out;
> > > > > +     u32 total_input_count;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct v4l2_rect crop;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 colorspace;
> > > > > diff --git a/drivers/media/platform/amphion/vpu_malone.c
> > > > > b/drivers/media/platform/amphion/vpu_malone.c
> > > > > index c62b49e85060..f4a488bf9880 100644
> > > > > --- a/drivers/media/platform/amphion/vpu_malone.c
> > > > > +++ b/drivers/media/platform/amphion/vpu_malone.c
> > > > > @@ -1314,6 +1314,8 @@ static int
> > > > vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int size =3D 0;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 rcv_seqhdr[MALONE_VC1_RCV_=
SEQ_HEADER_LEN];
> > > > >=20
> > > > > +     if (scode->inst->total_input_count)
> > > > > +             return 0;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scode->need_data =3D 0;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D vpu_malone_insert_sco=
de_seq(scode,
> > > > > MALONE_CODEC_ID_VC1_SIMPLE, sizeof(rcv_seqhdr)); diff --git
> > > > > a/drivers/media/platform/amphion/vpu_rpc.h
> > > > > b/drivers/media/platform/amphion/vpu_rpc.h
> > > > > index 25119e5e807e..7eb6f01e6ab5 100644
> > > > > --- a/drivers/media/platform/amphion/vpu_rpc.h
> > > > > +++ b/drivers/media/platform/amphion/vpu_rpc.h
> > > > > @@ -312,11 +312,16 @@ static inline int vpu_iface_input_frame(str=
uct
> > > > vpu_inst *inst,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0struct vb2_buffer *vb)  {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct vpu_iface_ops *ops =3D=
 vpu_core_get_iface(inst->core);
> > > > > +     int ret;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ops || !ops->input_frame=
)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > >=20
> > > > > -     return ops->input_frame(inst->core->iface, inst, vb);
> > > > > +     ret =3D ops->input_frame(inst->core->iface, inst, vb);
> > > > > +     if (ret < 0)
> > > > > +             return ret;
> > > > > +     inst->total_input_count++;
> > > > > +     return ret;
> > > > > =C2=A0}
> > > > >=20
> > > > > =C2=A0static inline int vpu_iface_config_memory_resource(struct v=
pu_inst
> > > > > *inst,
>=20

