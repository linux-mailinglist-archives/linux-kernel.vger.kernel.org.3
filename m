Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E597566FC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiGENrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiGENqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:46:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274221262
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:12:39 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v6so8622424qkh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=AkHI+llNzm+hM4YodPeAwl6t2q/edly/G1Vxd+nJK0g=;
        b=GYj+MYAfVwvtVxOQuvBQQ+IIi4UM1YxvO0pNwOjuqbnm3TSBtzrPvb1VxGbBuijqmB
         f1Y0RUQHxqwpdZBF1Ov7+5r2E2UH5lcDg6pfhvbXBUctaQH599qAO5RbgI91Gn1h0qfA
         Dy5IqmIgPmgFnD+GiA/HaC6xUSjGpy+kZLFLD8lNaEHzf4s/ojSD/oYn/Bq7EtHaAA1g
         AUlYfkeMbRSvd9QjtknswlxcZZl0IWKCaL9g7ivDuvS8fJ8nRdnHyogv7muAHuacs+BC
         lOTQRohStlSzo3Ru7jntsMJ6eAc/vaEgmk2bq6pFUrd17UvbMU3PkllVGx6GPVKDBWZj
         RNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=AkHI+llNzm+hM4YodPeAwl6t2q/edly/G1Vxd+nJK0g=;
        b=lZDj6VfV0/tSfCRJRVLeh/P2qkbquB96qSWOfdy0j2Dd+arLkO0unZ34gOI94/euDU
         uROaLXUuHq9d6NfHXq4x1cEknZSbBaTD3Gav2j2eN8kb2t4ArNMyPSRAI1K/3tBTgnFp
         iNN7ssUNxGqNO0JooALzRxcI2qAzPEaL+E8PLAGl3QQiqm72HzRQk8JIWHpESSA5lT6t
         W1UjE/+15CICjf6iS0zeOyNa77RpB8MnktlaJWXYo7LO7gP9/1IStjhFxa+2YtcC/bdE
         hPJkZOkxDqrv7MECCPmBpHpgHkFFUKav5o4fzw7h6FzZU+xGCWuVFBTYJChxs8+xRdOw
         E9Ww==
X-Gm-Message-State: AJIora/xgQJY+tLkYdLk2I4Elkko+CiYY2E8vf8p+0M4nBpibe0R8Qbt
        BWOU9wTh6YulWLe3hv/m/lveqw==
X-Google-Smtp-Source: AGRyM1t4IVWRLjMHxlMTVuYebK8pL6YI3RMoDCUOmBYFcQMUQlbv2nAF+RUNT6pikhNs6cKTHSTDPQ==
X-Received: by 2002:a37:9f95:0:b0:6ae:fb2d:eee2 with SMTP id i143-20020a379f95000000b006aefb2deee2mr23135918qke.251.1657026758436;
        Tue, 05 Jul 2022 06:12:38 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id l26-20020ac848da000000b003177969a48fsm22230581qtr.21.2022.07.05.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:12:38 -0700 (PDT)
Message-ID: <3754827c8296d3f6712c12a50e36048bbb9f66aa.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_CODECCONFIG flag
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
Date:   Tue, 05 Jul 2022 09:12:36 -0400
In-Reply-To: <AM6PR04MB6341F78F9B7355C5C9188932E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628021909.14620-1-ming.qian@nxp.com>
         <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
         <AM6PR04MB6341FA1173A9C5645554F882E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB6341F78F9B7355C5C9188932E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 juillet 2022 =C3=A0 11:34 +0000, Ming Qian a =C3=A9crit=C2=A0:
> > > From: Ming Qian
> > > Sent: 2022=E5=B9=B47=E6=9C=885=E6=97=A5 9:52
> > > To: Nicolas Dufresne <nicolas@ndufresne.ca>; mchehab@kernel.org;
> > > hverkuil-cisco@xs4all.nl
> > > Cc: shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > > <linux-imx@nxp.com>; linux-media@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: RE: [EXT] Re: [PATCH] media: videobuf2: add
> > > V4L2_BUF_FLAG_CODECCONFIG flag
> > >=20
> > > > From: Nicolas Dufresne <nicolas@ndufresne.ca>
> > > > Sent: 2022=E5=B9=B47=E6=9C=884=E6=97=A5 23:53
> > > > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> > > > hverkuil-cisco@xs4all.nl
> > > > Cc: shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de=
;
> > > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > > > <linux-imx@nxp.com>; linux-media@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > > Subject: [EXT] Re: [PATCH] media: videobuf2: add
> > > > V4L2_BUF_FLAG_CODECCONFIG flag
> > > >=20
> > > > Caution: EXT Email
> > > >=20
> > > > Le mardi 28 juin 2022 =C3=A0 10:19 +0800, Ming Qian a =C3=A9crit :
> > > > > By setting the V4L2_BUF_FLAG_CODECCONFIG flag, user-space should =
be
> > > > > able to hint decoder the vb2 only contains codec config header, b=
ut
> > > > > does not contain any frame data.
> > > > > It's only used for parsing header, and can't be decoded.
> > > >=20
> > > > This is copied from OMX specification. I think we we import this, w=
e
> > > > should at least refer to the original.
> > > >=20
> > >=20
> > > Hi Nicolas,
> > > =C2=A0=C2=A0=C2=A0Do you mean OMX_BUFFERFLAG_CODECCONFIG?
> > > =C2=A0=C2=A0=C2=A0I'm sorry that I didn't notice it before.
> > > =C2=A0=C2=A0=C2=A0Currently we only encounter this requirement on And=
roid, I'm not sure
> > > if
> > > it has a reference to omx.
> > > =C2=A0=C2=A0=C2=A0And thank you very much for pointing out it.
> > >=20
> >=20
> > Android media stack has been based on OMX for the last decade. They are
> > slowly moving to CODEC2 which more or less is a similar abstraction wit=
h
> > similar ideas. Let's research prior art, so we don't screw compatibilit=
y.
> >=20
>=20
> I got it, I'll try to study the android codec2,=20
> and do you agree that we should add V4L2_BUF_FLAG_CODECCONFIG flag, just =
like
> OMX_BUFFERFLAG_CODECCONFIG?
> Or is there any other solution that can handle this case?

We can probably discuss the name. CODECCONFIG is a bit strange, could be
CODEC_HEADER, HEADER_ONLY, CONFIG_ONLY, something along these lines. I'm ju=
st
wondering what is the best rule, since more specification is needed here.
Current userland expect full frames into each encoded buffer. If we start
splitting these up, we'll break non-android userland (and Android userland =
does
not seems to be very upstream thing, every vendor forks it).

I also think that what the CODECCONFIG contains and its format need to be
strictly documented for every CODEC that would allow it. In H.264 notably, =
the
headers could be packed in Annex B. or AVCc NAL headers. If we look at FFMP=
EG,
which uses codec_data name, they only requires this when the header are not
"inline", which means only for AVCc. Also, many codec_data is for other cod=
ecs
get wrapped into ISOMP4 or Matroska (webm) envelope.

On the other hand, I don't remember if the 1 frame per buffer is an actual =
rule
or simply what existing userland expect. Also, I'll be fair, there is no re=
ason
this must come from the driver. Android OMX or CODEC2 COMPONENT is a userla=
nd
component, it could do bitstream scanning (using traditional boyer-more) to=
 find
and split appart the config to satisfy its internal API. This can be done w=
ith
low overhead and zero-copy.

>=20
> > > Ming
> > >=20
> > > > >=20
> > > > > Current, it's usually used by android.
> > > > >=20
> > > > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > > > ---
> > > > > =C2=A0Documentation/userspace-api/media/v4l/buffer.rst | 9 ++++++=
+++
> > > > > =C2=A0include/uapi/linux/videodev2.h                   | 2 ++
> > > > > =C2=A02 files changed, 11 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst
> > > > > b/Documentation/userspace-api/media/v4l/buffer.rst
> > > > > index 4638ec64db00..acdc4556f4f4 100644
> > > > > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > > > > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > > > > @@ -607,6 +607,15 @@ Buffer Flags
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the format. Any subsequent ca=
ll to the
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:ref:`VIDIOC_DQBUF <VIDIOC_QB=
UF>` ioctl will not block anymore,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0but return an ``EPIPE`` error=
 code.
> > > > > +    * .. _`V4L2-BUF-FLAG-CODECCONFIG`:
> > > > > +
> > > > > +      - ``V4L2_BUF_FLAG_CODECCONFIG``
> > > > > +      - 0x00200000
> > > > > +      - This flag may be set when the buffer only contains codec
> > > > > config
> > > > > +    header, but does not contain any frame data. Usually the cod=
ec
> > > config
> > > > > +    header is merged to the next idr frame, with the flag
> > > > > +    ``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes t=
hat
> > > will
> > > > > +    split the header and queue it separately.
> > > >=20
> > > > I think the documentation is clear. Now, if a driver uses this, wil=
l
> > > > existing userland (perhaps good to check GStreamer, FFMPEG and
> > > > Chromium ?) will break ?
> > > > So we need existing driver to do this when flagged to, and just
> > > > copy/append when the userland didn't opt-in that feature ?
> > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* .. _`V4L2-BUF-FLAG-REQUEST-FD`:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- ``V4L2_BUF_FLAG_REQUE=
ST_FD`` diff --git
> > > > > a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > > > > index 5311ac4fde35..8708ef257710
> > > > > 100644
> > > > > --- a/include/uapi/linux/videodev2.h
> > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > @@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(cons=
t
> > > > struct timeval *tv)
> > > > > =C2=A0#define V4L2_BUF_FLAG_TSTAMP_SRC_SOE         0x00010000
> > > > > =C2=A0/* mem2mem encoder/decoder */
> > > > > =C2=A0#define V4L2_BUF_FLAG_LAST                   0x00100000
> > > > > +/* Buffer only contains codec header */
> > > > > +#define V4L2_BUF_FLAG_CODECCONFIG            0x00200000
> > > > > =C2=A0/* request_fd is valid */
> > > > > =C2=A0#define V4L2_BUF_FLAG_REQUEST_FD             0x00800000
> > > > >=20
>=20

