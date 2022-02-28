Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DBB4C65FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiB1JsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiB1JsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:48:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6205140F9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:47:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v21so14426967wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=WOsjPChuIl+kUePfrAPa71neh0lHex3RttBKXvPfdoQ=;
        b=TLq5hpkPHku3PLxi7HJbuJQsDP5Wa7qmaxuH26hMsQgWK2StXMrHE79lPn12BYrQyn
         36Ckju9r6Hg7T6NbCnE8YfIgER8Ni5YGmcs9hOo7u4MwKQBxmrAK257ZQkgoawpWdRwJ
         DlGl1bAHqToyAi3tVc+kngINC02Nv/oewNYInyNN/iFxs5sVEWMcYJeJSidWEPmgMgJW
         VRhhtweBy8BSnG5qDSak01L4h4ZAhijRKIluKCCOY4NsVuvOIqxQS//H6BAqX97/OOuf
         AK4MvT1gl3aaMEO01QZM4uV+WrNRAVoZaAcp234fHj7KPR8tQVTl/oUXvpvPoEQvLCNk
         qD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=WOsjPChuIl+kUePfrAPa71neh0lHex3RttBKXvPfdoQ=;
        b=SVuXkp/7PJTAjEU11Dgu24Vhx0a9Rmkc3bhVxb8GwBsYoxniHhdWsQseS6vOvxITZf
         g0rwcldZpNAIU100l6Gea6VN7MjJYxXux1NqRWYB4J7FteeCUfyqALMo4cSwQVGpI4MH
         p4BcUK0+rLjgzyvWQDSpcB1gP1IVP+lZwaneyL8sO6fsYYTF//Rh2wwHN9hqBN8gckSD
         odGNPVl0JnIYQgI6hFhCkfGcSP0v10M8yeJq7s8xhKtLGi7kimIUUe0AR0C5Tk923Qm3
         0DO6IBPsfEIdw7qVPk99W3KQn5qbDXQmj/0kwyOrZbsoUU0adM5LGXmaHsSHJ3swKwgZ
         9+sQ==
X-Gm-Message-State: AOAM531myqSRhJBhNTjaH006IvVbiU4hRAKQt8FIfjzNlaUQTRf7MdqW
        lUWrX3wSXjxzOvMKUxx09Ty/MD2Andfs7ifQ
X-Google-Smtp-Source: ABdhPJzp3i6tmpmN3z5O/ACtJUvC9C0191qzOsrE2xxczwXXbQmhrl6UAPBNDXyzNtGo0jFeNgtLww==
X-Received: by 2002:adf:e0ce:0:b0:1ef:706d:d6b9 with SMTP id m14-20020adfe0ce000000b001ef706dd6b9mr11022135wri.71.1646041640166;
        Mon, 28 Feb 2022 01:47:20 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b0034efd01ee16sm10388339wmj.42.2022.02.28.01.47.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 28 Feb 2022 01:47:19 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
Subject: Re: [PATCH v3 09/14] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Date:   Mon, 28 Feb 2022 09:47:18 +0000
Message-ID: <me5p1hpnrarnqqaefoofrtqb898afl0rsn@4ax.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com> <4378293.LvFx2qVVIh@kista> <1884298.PYKUYFuaPT@kista> <7348885.EvYhyI6sBW@kista>
In-Reply-To: <7348885.EvYhyI6sBW@kista>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Feb 2022 19:17:46 +0100, you wrote:

>Dne sobota, 26. februar 2022 ob 18:59:18 CET je Jernej =C5=A0krabec =
napisal(a):
>> Hi!
>>=20
>> Dne petek, 25. februar 2022 ob 20:30:20 CET je Jernej =C5=A0krabec =
napisal(a):
>> > Hi!
>> >=20
>> > Dne petek, 25. februar 2022 ob 17:45:55 CET je Benjamin Gaignard=20
>napisal(a):
>> > > The number of 'entry point offset' could be very variable.
>> > > Rather than use a large static array define a v4l2 dynamic array
>> > > of integer control.
>> >=20
>> > I suggest we should be more specific and say U32 =
(V4L2_CTRL_TYPE_U32).
>> >=20
>> > > The number of entry point offsets is reported by the elems field.
>>=20
>> I did few more tests and these are my findings:
>> 1. dynamic array can't be set over size, specified in .dims array
>> 2. entry point offsets are per slice, so if we make slices dynamic =
array,=20
>then=20
>> entry points would become two dimensional dynamic array
>> 3. num_entry_point_offsets must be part of slice control, because it =
can be=20
>> zero, but size of array can't be
>
>Clarification: num_entry_point_offsets is needed in any case, even =
without entry=20
>point list.

I thought that at least one decoder wanted the entry points or have we
decided that we don't? Whilst they aren't required for decode, what they
give you, if your h/w supports it, is the ability to decode multiple
lines of CTBs in parallel (with a 2 CTB offset between lines), so they
aren't useless.

If we do decided we want the entry point offset control, now or later,
then num_entry_points in the slice_param allows you to determine which
offsets apply to which slices without the complexity of a variable array
of variable arrays.

But whether or not we end up supporting entry point offsets, the Pi h/w
requires me to generate 1 table entry for each CTB line and
num_entry_points is the parameter I need for that, so I really want it
in the slice_params.

Regards

John Cox

>> 4. fortunately, not setting entry points doesn't impact decoding=20
>correctness.=20
>> This is in line what John told me about them.
>>=20
>> Hans, can you comment points 1-3? I might misunderstand point 1.
>>=20
>> In short, it seems like we don't really need entry points, even if =
they are=20
>> used in BSP library. In both cases, I got fluster score 119/138 =
(10-bit=20
>> excluded), so we can just drop this patch, although I'm a bit uneasy =
not=20
>> setting entry points...
>>=20
>> Best regards,
>> Jernej
>>=20
>> > >=20
>> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> > > ---
>> > >  .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 =
+++++++++
>> > >  include/media/hevc-ctrls.h                               | 1 +
>> > >  2 files changed, 10 insertions(+)
>> > >=20
>> > > diff --git =
a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>> > Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > > index 44a268a948c0..71f7dc1c1ccd 100644
>> > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > > @@ -3128,6 +3128,15 @@ enum =
v4l2_mpeg_video_hevc_size_of_length_field -
>> > > =20
>> > >      \normalsize
>> > > =20
>> > > +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>> >=20
>> > Here you have OFFSETS (plural) ...
>> >=20
>> > > +    Specifies the i-th entry point offset in bytes and is =
represented by
>> > > +    offset_len_minus1 plus 1 bits.
>> >=20
>> > You probably mean entry_point_offset_minus1? offset_len_minus1 just =
tells=20
>how=20
>> > much bits need to be read for each element and it's not important =
for=20
>actual=20
>> > decoding.
>> >=20
>> > > +    This control is a dynamically sized array. The number of =
entry=20
>point
>> > > +    offsets is reported by the ``elems`` field.
>> > > +    This bitstream parameter is defined according to :ref:`hevc`.
>> > > +    They are described in section 7.4.7.1 "General slice segment =
header
>> > > +    semantics" of the specification.
>> > > +
>> > >  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>> > >      Specifies the HEVC scaling matrix parameters used for the =
scaling=20
>> > process
>> > >      for transform coefficients.
>> > > diff --git a/include/media/hevc-ctrls.h =
b/include/media/hevc-ctrls.h
>> > > index 3016c1abb1d0..3f8a67924df3 100644
>> > > --- a/include/media/hevc-ctrls.h
>> > > +++ b/include/media/hevc-ctrls.h
>> > > @@ -20,6 +20,7 @@
>> > >  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	=
(V4L2_CID_CODEC_BASE +=20
>> > 1012)
>> > >  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE =
+=20
>> > 1015)
>> > >  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE=20
>+=20
>> 1016)
>> > > +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET =
(V4L2_CID_CODEC_BASE=20
>+=20
>> > 1017)
>> >=20
>> > ... and here you have OFFSET (singlular). I suggest plural form to =
be used=20
>> in=20
>> > all places, including subject line of this commit.
>> >=20
>> > Additionally, it would be nice if control is initialized, like so:
>> > https://github.com/jernejsk/linux-1/commit/
>> > f938e162cd8dd77c9f6f1b248d80144840a37bce
>> >=20
>> > Best regards,
>> > Jernej
>> >=20
>> > > =20
>> > >  /* enum v4l2_ctrl_type type values */
>> > >  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>> > > --=20
>> > > 2.32.0
>> > >=20
>> > >=20
>> >=20
>> >=20
>> >=20
>>=20
>>=20
>>=20
>
