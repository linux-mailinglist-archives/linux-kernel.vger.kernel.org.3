Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16252F217
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352432AbiETSJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiETSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:09:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4318C074
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:09:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id fu47so7537673qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=NR3kZ49dmkT1KeVAfKZ4S7OqnOEH8qjrvmWh2/OGKUI=;
        b=vhA7rOy41zBfrp7nAjtyoVUjn1qW+jwuo0H36oHDZu1PGGIoqBjwWZTQqj5pohxFcU
         pKr2w1tqeku841iCY46Qlx8V9+ekdS/0R9ZvgB/F2vhL17kHlkkVdlyTyyG1Ri7hvJb+
         dfVc5L7Ein0cyBCQ3m5HkrZSlAs9VkRfjUvR2R2U+9YIKbAabIueTdVvFPUVqQQQamqn
         ZHTHhcuPHwDduWtQn62rp51FYZ1UHCCNO0LL2T1l72o1rD8Hiza0l+q9DT33K7KGGM7q
         M4YycQCOJzFsn6dR1BHS6ZWEzph/zY5+1rtwzOILcVgAPfpBEhWqnzkaulsuqf8Gbg07
         7Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=NR3kZ49dmkT1KeVAfKZ4S7OqnOEH8qjrvmWh2/OGKUI=;
        b=engvhXS7Yo2twFPhPq8XY9j/qiXWlLReQKM9RExm8Rhq2j9/ozwd8rBkK9PCBm139M
         E8bpqrap+x/TNwVi8eXKK4EZYZs6nL1P8SksCS20HRr+q587vcJWzvm/IesnDArfi1VA
         AsUA2fUVxRKaeLHpVaaNF/hXWVyDdrZG2S81+E6xGdQuXeBOC43k0NhsGC7dwor+zJcz
         vwC/0uQMpFI9sDriqKDclAoDxbIM98AGif9vLR2NYc/FMmoGWZv9NL8Cd35TRl2UrWi5
         BkgtbnPieAhF02tRi7U3BqSrzVQstLR6/I3O5SmdFDT8PhJiDTjT/vgVaVIIvEcTAwwR
         Gx8g==
X-Gm-Message-State: AOAM532p0SnB3o8N025EnV46guRoAoWyv6q7y1mzMxvyeSoPR3thMzm/
        PCTP+IzSrS9pjHtPJs1hI/Iw9A==
X-Google-Smtp-Source: ABdhPJzQMahI/6mv9fxIYp/N8Ntlckg1blDgzhWZsiFQ79buITzh8AG5WIt0Cth3NvMWJ658ylfNiQ==
X-Received: by 2002:ac8:5b4d:0:b0:2f6:3ee7:6231 with SMTP id n13-20020ac85b4d000000b002f63ee76231mr8916799qtw.4.1653070166133;
        Fri, 20 May 2022 11:09:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id f21-20020a05622a1a1500b002f917d2d3cbsm74318qtb.76.2022.05.20.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:09:25 -0700 (PDT)
Message-ID: <6187a0514757dd50734175ceebcc0061d8eb6c5b.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH] media: amphion: return error if format is
 unsupported by vpu
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
Date:   Fri, 20 May 2022 14:09:22 -0400
In-Reply-To: <DB8PR04MB634682E34667F804608E3018E7D39@DB8PR04MB6346.eurprd04.prod.outlook.com>
References: <20220519072844.31792-1-ming.qian@nxp.com>
         <e03669333c20c07d40d0b1ce05eb771f5dbd4139.camel@ndufresne.ca>
         <DB8PR04MB634682E34667F804608E3018E7D39@DB8PR04MB6346.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 20 mai 2022 =C3=A0 01:25 +0000, Ming Qian a =C3=A9crit=C2=A0:
> > From: Nicolas Dufresne [mailto:nicolas@ndufresne.ca]
> > Sent: Friday, May 20, 2022 2:13 AM
> > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> > hverkuil-cisco@xs4all.nl
> > Cc: shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; linux-media@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH] media: amphion: return error if format is
> > unsupported by vpu
> >=20
> > Caution: EXT Email
> >=20
> > Hi Ming Qian,
> >=20
> > Le jeudi 19 mai 2022 =C3=A0 15:28 +0800, Ming Qian a =C3=A9crit :
> > > return error if format is unsupported by vpu, otherwise the vpu will
> > > be stalled at decoding
> >=20
> > I have a reasonable doubt about this patch. I don't think such a case s=
hould
> > be
> > reachable by users. Normally, calls to S_FMT should ensure the driver f=
ormat
> > state is valid on both ends but modifying the relevant structures. As a=
n
> > example, for decoders, setting the CODEC (OUTPUT queue) format, may
> > change the raw format (CAPTURE queue) implicitly to prevent this situat=
ion.
> > Are we certain this change isn't papering around some missing format
> > propagation ?
> >=20
> > regards,
> > Nicolas
> >=20
>=20
> Hi Nicolas,
> =C2=A0=C2=A0=C2=A0=C2=A0You're right, it's not reachable currently.
> =C2=A0=C2=A0=C2=A0=C2=A0And there are some formats supported by VPU, but =
I didn't add support in
> driver, as they are not defined in kernel yet.
> So if someone wants to enable them in future, and if he only adds a forma=
t
> into vdec_formats[] without modifying the vpu_malone part , then he can
> enum_fmt and set_fmt successfully, but meet vpu hang without any error
> message.
> 	I think driver should report an error in case of the new format is
> not implemented fully.

Fair point, but it should be bug_on or at least an error trace.

regards,
Nicolas

>=20
> Ming
>=20
> > >=20
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > ---
> > > =C2=A0drivers/media/platform/amphion/vpu_malone.c | 2 ++
> > > =C2=A0drivers/media/platform/amphion/vpu_v4l2.c   | 4 ++--
> > > =C2=A02 files changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/amphion/vpu_malone.c
> > > b/drivers/media/platform/amphion/vpu_malone.c
> > > index f29c223eefce..0930b6ba8c42 100644
> > > --- a/drivers/media/platform/amphion/vpu_malone.c
> > > +++ b/drivers/media/platform/amphion/vpu_malone.c
> > > @@ -610,6 +610,8 @@ static int vpu_malone_set_params(struct
> > vpu_shared_addr *shared,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum vpu_malone_format malone_for=
mat;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0malone_format =3D
> > vpu_malone_format_remap(params->codec_format);
> > > +     if (malone_format =3D=3D MALONE_FMT_NULL)
> > > +             return -EINVAL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iface->udata_buffer[instance].bas=
e =3D params->udata.base;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iface->udata_buffer[instance].slo=
t_size =3D params->udata.size;
> > >=20
> > > diff --git a/drivers/media/platform/amphion/vpu_v4l2.c
> > > b/drivers/media/platform/amphion/vpu_v4l2.c
> > > index 446f07d09d0b..89b88e063e45 100644
> > > --- a/drivers/media/platform/amphion/vpu_v4l2.c
> > > +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> > > @@ -500,10 +500,10 @@ static int vpu_vb2_start_streaming(struct
> > vb2_queue *q, unsigned int count)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0fmt->sizeimage[1], fmt->bytesperline[1],
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0fmt->sizeimage[2], fmt->bytesperline[2],
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0q->num_buffers);
> > > -     call_void_vop(inst, start, q->type);
> > > +     ret =3D call_vop(inst, start, q->type);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vb2_clear_last_buffer_dequeued(q)=
;
> > >=20
> > > -     return 0;
> > > +     return ret;
> > > =C2=A0}
> > >=20
> > > =C2=A0static void vpu_vb2_stop_streaming(struct vb2_queue *q)
>=20

