Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF2565A89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiGDQAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiGDQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:00:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997ACB99
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:00:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c13so10363803qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=NF2ZMZsGp1VtNummOog/xQmlja5rA+lmeIJuDNn7Rxg=;
        b=NYc0pAvHKp8mDQc2Kctg9B47elEH2gzrV/uNBz6M6SRSzCCFakjj+mes4AwHIlyYM5
         ZKAtvekUYzEWJAjsyh1j846wh8mSeXcKkZl/JfS71tIfWSbC9IDzLE3Vfibwwfj9bEkT
         7hPz5hSKHkn5KNhMT4+WbAOFQDIjx+vPmmoYRNN5cicMYmsynhCzwE0KIYlPPK94srSn
         oeMfMw4RdpJxCHcH+mbv0TeLxWucZoke80uzDhwX67CyP1GuB4C9Nj8oZcAkfndsxJMI
         xrDwdPK9M31kvmiWR6u0WpTojS/KxkX7EDvFsRXNWLBKv2Mnrs5q70i/r1D9EioZVSLk
         W36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=NF2ZMZsGp1VtNummOog/xQmlja5rA+lmeIJuDNn7Rxg=;
        b=ZfrPNFrDTgP4hlPmPlmAqY940aHAKtksBm+UgLILY11e1M6njlfpnTWtIVV/hCHc/u
         p9BhbY4ISzsHMvCO6OTapxSQILWpbifixZ9P4AjhrdWKqSQc7EuNflf0iyRyQP9iZQ8n
         VMhnP3jCfj7O53HKPM4mKB9tPFuPnQeFlYwQipLd4kVL8wmNzZPXyBWAovdaD2LU621r
         5gccONxB56MiqodmiNkezRaGLu7PAdKi2ghLK9t/BN5D+0DKBQT2mQ+Wl25JUzmw3p3u
         tkffESkzsg3Gf4xdwoIWeECMbUXgMoGtmhIoUStGsuN/vmEJJ1PSrD335k/cRV0E4g4v
         Re5A==
X-Gm-Message-State: AJIora8MmecJf0o8ETw/D5ZHlak7un+NHhynhVG0B/pcJLkuvNTC+beC
        0xIrF2WQGYW0Xo5tpDWIwfMf6A==
X-Google-Smtp-Source: AGRyM1uk54xq+s3dnTxnkewvytBp3W/dthtaMHU7SdvPHQkJr7TQwMN7p1mx/ETr8/ifi0Zxw8S3mg==
X-Received: by 2002:a05:6214:27cb:b0:472:efee:1719 with SMTP id ge11-20020a05621427cb00b00472efee1719mr7561770qvb.57.1656950400652;
        Mon, 04 Jul 2022 09:00:00 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b006b1eb3a8364sm11317407qkb.5.2022.07.04.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:59:59 -0700 (PDT)
Message-ID: <5e8c50cdc031bffd96b19929508f034d1263c8b7.camel@ndufresne.ca>
Subject: Re: [PATCH 1/3] media: videobuf2: Add a transfer error event
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Michael Rodin <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     michael@rodin.online, erosca@de.adit-jv.com,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Date:   Mon, 04 Jul 2022 11:59:58 -0400
In-Reply-To: <20220628180024.451258-2-mrodin@de.adit-jv.com>
References: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
         <20220628180024.451258-1-mrodin@de.adit-jv.com>
         <20220628180024.451258-2-mrodin@de.adit-jv.com>
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

Hi Micheal,

thanks for your work, I have some questions below ...

Le mardi 28 juin 2022 =C3=A0 20:00 +0200, Michael Rodin a =C3=A9crit=C2=A0:
> From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
>=20
> Add a new V4L2_EVENT_XFER_ERROR event to signal if an error happens durin=
g
> video transfer.
>=20
> The use-case that sparked this new event is to signal to the video
> device driver that an error has happen on the CSI-2 bus from the CSI-2
> receiver subdevice.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> [mrodin@de.adit-jv.com: adapted information what to do if this new event =
is received]
> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
> ---
>  .../userspace-api/media/v4l/vidioc-dqevent.rst         | 10 ++++++++++
>  .../userspace-api/media/videodev2.h.rst.exceptions     |  1 +
>  include/uapi/linux/videodev2.h                         |  1 +
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/D=
ocumentation/userspace-api/media/v4l/vidioc-dqevent.rst
> index 6eb40073c906..3cf0b4859784 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> @@ -182,6 +182,16 @@ call.
>  	the regions changes. This event has a struct
>  	:c:type:`v4l2_event_motion_det`
>  	associated with it.
> +    * - ``V4L2_EVENT_XFER_ERROR``

I'm not sure why this event is specific to XFER. Is there uses cases were a
future implementation would have both XFER and RECEIVER error ?

> +      - 7
> +      - This event is triggered when an transfer error is detected while
> +	streaming. For example if an error is detected on a video bus in
> +	the pipeline. If a driver receives this event from an upstream
> +	subdevice, it has to forward the event to userspace. The streaming
> +	application has to check if the transfer error is unrecoverable,
> +	i.e. no new buffers can be dequeued from the kernel after the
> +	expected time. If the error is unrecoverable, the streaming
> +	application should restart streaming if it wants to continue.

The process to determine if an error is recoverable or not isn't clear to m=
e. As
an application developer, I would not know what to do here. Recoverable err=
or
already have a designed mechanism, it consist of marking done a buffer with=
 the
flag V4L2_BUF_FLAG_ERROR. I would like to understand what the existing mech=
anism
needed to be replaced, and the placement should be documented.

Nicolas

>      * - ``V4L2_EVENT_PRIVATE_START``
>        - 0x08000000
>        - Base event number for driver-private events.
> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions=
 b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> index 9cbb7a0c354a..25bde61a1519 100644
> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> @@ -500,6 +500,7 @@ replace define V4L2_EVENT_CTRL event-type
>  replace define V4L2_EVENT_FRAME_SYNC event-type
>  replace define V4L2_EVENT_SOURCE_CHANGE event-type
>  replace define V4L2_EVENT_MOTION_DET event-type
> +replace define V4L2_EVENT_XFER_ERROR event-type
>  replace define V4L2_EVENT_PRIVATE_START event-type
> =20
>  replace define V4L2_EVENT_CTRL_CH_VALUE ctrl-changes-flags
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 5311ac4fde35..44db724d4541 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2385,6 +2385,7 @@ struct v4l2_streamparm {
>  #define V4L2_EVENT_FRAME_SYNC			4
>  #define V4L2_EVENT_SOURCE_CHANGE		5
>  #define V4L2_EVENT_MOTION_DET			6
> +#define V4L2_EVENT_XFER_ERROR			7
>  #define V4L2_EVENT_PRIVATE_START		0x08000000
> =20
>  /* Payload for V4L2_EVENT_VSYNC */

