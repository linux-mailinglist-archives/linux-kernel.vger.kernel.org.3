Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD85B4B8634
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiBPKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:54:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBPKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:54:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E329E97E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:54:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d27so2775430wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=ClOLZY2s6erQ+u2yEpXcBXJSNoeGTddd6B8yRMY6wL4=;
        b=eNEz6NhpTsFzWQBtRE9zwpW37SRHMx0YzNhudaEl0A8Z09+wrJ3160zP8mJD67kawa
         0OfB7zz00GLJS6n7vdJFaK5d0u1kb5mc/+XwFkEmPktyNRXxcAOOyoVdSRY/fa9+dzP4
         lBh4U4FGkicKmYQkFXAkZcmdew25LCRzweGPkPkkY+rIb7XV90ZUIlDk4yacOVYwtMhT
         bGpudUzYg/kLEQxNpr3E+5ucBAmSHk0H4bCmqG1Gbhdn/XZzQAHd7HBCAaHJEtEhMpt7
         lqlPPjIWU0rMTAEpShE2bpVzLCwdyX9UcwnbK4salLxhlF4jYnDb9O+IMEl458eJeOEK
         UwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=ClOLZY2s6erQ+u2yEpXcBXJSNoeGTddd6B8yRMY6wL4=;
        b=C35y9W7Cloovd/gDUaQylZHTnPGK7sKGZ1gZNRYizWjs/ON1AiiCm4Mt4l0YOfcCbf
         +7S4e1FkaYAbRhjKPk3sAjRRKXaQxvDbADzquHdRMi7IwKW6D9OR0/fHJS4o08U3Gbsp
         cUHGU/isaTCiPTdMvBzXJ18S3Ewcks7eLBScYVaXHOeDhbS+YU20ekr1c+MzS4A9o+BR
         lU6hVp5HC+noI8uDBE+aWH3NVHNmbG9YOISgkV4045MrnJpL1ezcv6sBzKo+JdiG1+dL
         e377r8JVV7uwccPRr1Jt8uWlv9Nv1psjYbGivNi9Lg0VuhVXjf1CxMxSM40xWlxkGBq2
         3xgQ==
X-Gm-Message-State: AOAM530U0KyiAVQn6J9/AYMj1ALbiBG6vwyVgIvr5Xn8gjKDB1E/eSD9
        cwNCIAlxqWEZ5+rMoMflRc/04w==
X-Google-Smtp-Source: ABdhPJx8f0L6XdikIJB+SwJtluNj1SfqDSYDPy1RMa2dm+E0gOMPUn7l4cDxeXKEJZ0xSaU7vh1LFA==
X-Received: by 2002:adf:f3cc:0:b0:1e7:4fd9:6fd3 with SMTP id g12-20020adff3cc000000b001e74fd96fd3mr1820954wrp.266.1645008871610;
        Wed, 16 Feb 2022 02:54:31 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id c18sm29982042wro.81.2022.02.16.02.54.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 16 Feb 2022 02:54:31 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [RFC v2 7/8] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Date:   Wed, 16 Feb 2022 10:54:29 +0000
Message-ID: <a8lp0h15oaibdu1pqrkhsu8nh32v423tur@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com> <20220215110103.241297-8-benjamin.gaignard@collabora.com>
In-Reply-To: <20220215110103.241297-8-benjamin.gaignard@collabora.com>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 12:01:02 +0100, you wrote:

>The number of 'entry point offset' could be very variable.
>Rather than use a large static array define a v4l2 dynamic array
>of integer control.
>The number of entry point offsets is reported by the elems field.

If we are going to support multiple slice headers in a single control
then we are going to need to know how to split these entries between
them as I assume that the entry point offset entries for all slice
headers would just be catenated here.  You could add extra elements here
or generate a completely new control but I think it would be easier to
reinstate the num_entry_point_offsets field in the slice_params
structure (its a field that userpace has in its hand anyway so its no
effort for it to fill in).  num_entry_point_offsets is a field that RPi
wants (without needing the entry points themselves) so that would help
me.

Regards

John Cox

>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
>version 2:
>- Define a new CID for entry point offsets parameters
> .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++++
> include/uapi/linux/v4l2-controls.h                       | 1 +
> 2 files changed, 10 insertions(+)
>
>diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>index c3ae97657fa7..679595e94643 100644
>--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>@@ -3101,6 +3101,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>=20
>     \normalsize
>=20
>+``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>+    Specifies the i-th entry point offset in bytes and is represented =
by
>+    offset_len_minus1 plus 1 bits.
>+    This control is a dynamically sized array. The number of entry =
point
>+    offsets is reported by the ``elems`` field.
>+    This bitstream parameter is defined according to :ref:`hevc`.
>+    They are described in section 7.4.7.1 "General slice segment header
>+    semantics" of the specification.
>+
> ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>     Specifies the HEVC scaling matrix parameters used for the scaling =
process
>     for transform coefficients.
>diff --git a/include/uapi/linux/v4l2-controls.h =
b/include/uapi/linux/v4l2-controls.h
>index 27f5d272dc43..700e6cce958c 100644
>--- a/include/uapi/linux/v4l2-controls.h
>+++ b/include/uapi/linux/v4l2-controls.h
>@@ -2314,6 +2314,7 @@ struct v4l2_ctrl_vp9_compressed_hdr {
> #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	=
(V4L2_CID_CODEC_STATELESS_BASE + 404)
> #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	=
(V4L2_CID_CODEC_STATELESS_BASE + 405)
> #define V4L2_CID_STATELESS_HEVC_START_CODE	=
(V4L2_CID_CODEC_STATELESS_BASE + 406)
>+#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET	=
(V4L2_CID_CODEC_STATELESS_BASE + 407)
>=20
> enum v4l2_stateless_hevc_decode_mode {
> 	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
