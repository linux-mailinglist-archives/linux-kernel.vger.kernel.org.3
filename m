Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4514B8F44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiBPRgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:36:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiBPRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:36:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F0278286
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:35:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso2162638wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=MZhlxsFvgjP4WZV7dx4SGzteonrtxfsLah0a/XgwIpg=;
        b=vjOR1u4xWVOpTqfTnxqUwm0JNvmYwd+B6HeN3oVi1HTdIX5FfIBD0oatcmcGF8xBK2
         vCtYbZ7WQKOKu+zs9RmNrAhG+TEIpcDOJv2srUaIMvsppNutxTI3nrOdKujWn2l9j056
         m4QKzWtLY8seSz944Eo4pr6DLU/Sax9GWpdLqQFHSOj6KjXPSlgqdR0IrijTYte0mfqF
         Gds60pZNNFzA0fhgr5iTErDdaSeVT5prNIW7p4klpNpSjXM56jULXmacTjBMQOyHDFDr
         x4vg/u0EMbDmSDtYhxqz8aEZCjDLo9ybkaK/OLVI1GDxu+DUc58GRExdkD62Qu4wjqD+
         vn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=MZhlxsFvgjP4WZV7dx4SGzteonrtxfsLah0a/XgwIpg=;
        b=h4iz7qyEFdmN8gKWTCzo7b2rr7dnh+hLU0oKCXsOYDtjNuKl+7thggHUa7ZqD+hUMT
         fhA+D8FiOfHjw5vWMsfIg3/4aCmn7G2PBKFq281fhDHM9dql+XFXLDPOG97nTism00wl
         5g/zZ1BpX+8HWdKfiB9O2BEIyyRMn2QokwR3H/kdex0vokAy2LkMqz8++Psner2ABGD1
         rWz2sKGGlOoAp1QvmQCA125MRn5yy2OC9A6C9L/6l9+v34d1DmM+UNCdbTXvh6k2AR1Q
         SSyCaUs8lJ3oTf+I8KcJIv0amYe8zUK5uYhR/r+83+7FCZAVicqnCbn5MCygX4RTiYr/
         PPOg==
X-Gm-Message-State: AOAM533d+1bYZ3MY/T4GVtBYqeaS7PaAUAzzsMDPp8nEQUlPLGtE6wJS
        3bA3HZTI/IPmXG/yiRgSApNchA==
X-Google-Smtp-Source: ABdhPJzGwvO/1+cOuF9OxnB1a4zo32eW6Gn4iNZg/cppvyowaHV9Dlh9kU84pLZmm2d1MbdzzpArFQ==
X-Received: by 2002:a05:600c:2d41:b0:354:24d2:8e13 with SMTP id a1-20020a05600c2d4100b0035424d28e13mr2651958wmg.138.1645032957655;
        Wed, 16 Feb 2022 09:35:57 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id r14sm9129124wrz.84.2022.02.16.09.35.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 16 Feb 2022 09:35:57 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
Subject: Re: [RFC v2 7/8] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Date:   Wed, 16 Feb 2022 17:35:56 +0000
Message-ID: <r2dq0hpnn99kofoa4uren09nlii38rcdi1@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com> <20220215110103.241297-8-benjamin.gaignard@collabora.com> <a8lp0h15oaibdu1pqrkhsu8nh32v423tur@4ax.com> <846370ec-5c9e-e4cb-eccf-0b0c6bdbc847@collabora.com>
In-Reply-To: <846370ec-5c9e-e4cb-eccf-0b0c6bdbc847@collabora.com>
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

On Wed, 16 Feb 2022 18:19:10 +0100, you wrote:

>
>Le 16/02/2022 =C3=A0 11:54, John Cox a =C3=A9crit=C2=A0:
>> On Tue, 15 Feb 2022 12:01:02 +0100, you wrote:
>>
>>> The number of 'entry point offset' could be very variable.
>>> Rather than use a large static array define a v4l2 dynamic array
>>> of integer control.
>>> The number of entry point offsets is reported by the elems field.
>> If we are going to support multiple slice headers in a single control
>> then we are going to need to know how to split these entries between
>> them as I assume that the entry point offset entries for all slice
>> headers would just be catenated here.  You could add extra elements =
here
>> or generate a completely new control but I think it would be easier to
>> reinstate the num_entry_point_offsets field in the slice_params
>> structure (its a field that userpace has in its hand anyway so its no
>> effort for it to fill in).  num_entry_point_offsets is a field that =
RPi
>> wants (without needing the entry points themselves) so that would help
>> me.
>
>Would that means num_entry_point_offsets field in slice parameter =
control
>+ one control for the entry points themselves ?
>or the both on slice parameter control (like now) ?

I meant num_entry_point_offsets field in each slice parameter control +
one control for the entry points themselves.  Given that you have a
varible number of entry points associated with each slice and you have a
variable number of slices this seems the easiest answer to me both to
construct in userspace and to use in the driver.

Regards

JC

>Regards
>Benjamin
>
>>
>> Regards
>>
>> John Cox
>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>> version 2:
>>> - Define a new CID for entry point offsets parameters
>>> .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 =
+++++++++
>>> include/uapi/linux/v4l2-controls.h                       | 1 +
>>> 2 files changed, 10 insertions(+)
>>>
>>> diff --git =
a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index c3ae97657fa7..679595e94643 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -3101,6 +3101,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field=
 -
>>>
>>>      \normalsize
>>>
>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>> +    Specifies the i-th entry point offset in bytes and is =
represented by
>>> +    offset_len_minus1 plus 1 bits.
>>> +    This control is a dynamically sized array. The number of entry =
point
>>> +    offsets is reported by the ``elems`` field.
>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>> +    They are described in section 7.4.7.1 "General slice segment =
header
>>> +    semantics" of the specification.
>>> +
>>> ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>      Specifies the HEVC scaling matrix parameters used for the =
scaling process
>>>      for transform coefficients.
>>> diff --git a/include/uapi/linux/v4l2-controls.h =
b/include/uapi/linux/v4l2-controls.h
>>> index 27f5d272dc43..700e6cce958c 100644
>>> --- a/include/uapi/linux/v4l2-controls.h
>>> +++ b/include/uapi/linux/v4l2-controls.h
>>> @@ -2314,6 +2314,7 @@ struct v4l2_ctrl_vp9_compressed_hdr {
>>> #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	=
(V4L2_CID_CODEC_STATELESS_BASE + 404)
>>> #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	=
(V4L2_CID_CODEC_STATELESS_BASE + 405)
>>> #define V4L2_CID_STATELESS_HEVC_START_CODE	=
(V4L2_CID_CODEC_STATELESS_BASE + 406)
>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET	=
(V4L2_CID_CODEC_STATELESS_BASE + 407)
>>>
>>> enum v4l2_stateless_hevc_decode_mode {
>>> 	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
