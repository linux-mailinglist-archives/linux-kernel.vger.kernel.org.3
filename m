Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45D14CD4A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiCDNEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:04:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8B15F088;
        Fri,  4 Mar 2022 05:03:39 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:7306:9b30:8b22:3e7d] (unknown [IPv6:2a01:e0a:120:3210:7306:9b30:8b22:3e7d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B9F121F467C9;
        Fri,  4 Mar 2022 13:03:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646399017;
        bh=XSIU2CUwRQX0q44W9oyLMp1FVDE8AkmbaKY3IYhEFVM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Se5fLHUC23LwTn1gDukrluSyFAqo6fJBp5FGnCz9DjZMXyFEOBrQV7iW7j8DugLco
         rKVQ07C0B05SmEuluwmpQgUzQ4uHY7PQVbv7AY1OhQH5JYTkX5kLKtmb8F0vX7ASK1
         uacoLRvfw2Zd4jX8xFxNrnvMeoVUuFOCaKvXSzUF2oJx21enINPlNwvYt6r4MSlzcF
         VZ14eEkDeBtvarnc3sWM7YpNCz0Vs0bkvMcE93J+zET5x1onVyLnNH1rEJ5Sz2Q/3g
         o6iDX4eO1Knxlw98FXT9YhiTxOoWhtXntW/WO0PFaiMqe82227BA7sq8nULsL/1Dyc
         ep+ChUhGWCMcw==
Message-ID: <a0360b52-246e-21a2-1499-b9a03de21a30@collabora.com>
Date:   Fri, 4 Mar 2022 14:03:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 00/14] Move HEVC stateless controls out of staging
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, kernel <kernel@collabora.com>,
        knaerzche@gmail.com, jc@kynesim.co.uk
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
 <CAHCN7x+AUy4JsqfdyZFqg4ScR1OgoLvqF91za0AZ278NSBJj4A@mail.gmail.com>
 <b832271d-cecd-a373-48ff-ba5ce736e47d@collabora.com>
 <CAHCN7xJ3K2bLEc8dcTM+x-E0brDW-t4yrUdkUe0jCfuzH8v9pA@mail.gmail.com>
 <678c1f01-c6cd-d1be-bd0b-277a808b006a@collabora.com>
 <CAHCN7xL-+1cXbcOpRU8BRXoyAkecERqT-O8vM_069er8WWWEaw@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAHCN7xL-+1cXbcOpRU8BRXoyAkecERqT-O8vM_069er8WWWEaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04/03/2022 à 13:59, Adam Ford a écrit :
> On Thu, Mar 3, 2022 at 4:13 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>>
>> Le 03/03/2022 à 02:23, Adam Ford a écrit :
>>> On Mon, Feb 28, 2022 at 4:13 AM Benjamin Gaignard
>>> <benjamin.gaignard@collabora.com> wrote:
>>>> Le 26/02/2022 à 23:25, Adam Ford a écrit :
>>>>> On Fri, Feb 25, 2022 at 4:41 PM Benjamin Gaignard
>>>>> <benjamin.gaignard@collabora.com> wrote:
>>>>>> This series aims to make HEVC uapi stable and usable for hardware
>>>>>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
>>>>>> and 2 out of the tree drivers (rkvdec and RPI).
>>>>>>
>>>>>> After the remarks done on version 2, I have completely reworked to patches
>>>>>> split so changelogs are meaningless. I have also drop "RFC" from the
>>>>>> titles.
>>>>>>
>>>>>> In this v3 I do all the changes (new controls, documentation, etc..)
>>>>>> in the staging directory before moving the HEVC uAPI to stable
>>>>>> steps by steps (unlike the big one patch in v2).
>>>>>>
>>>>>> At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>>>> I have push a branch here:
>>>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/HEVC_UAPI_V4
>>>>
>>>> it is the incoming version 4 of this series + patches to enable G2 on my IMX8MQ
>>> Benjamin,
>>>
>>> I checked this repo out, and built it along with pulling the latest
>>> versions of G-streamer and fluster.
>>> When I check for v4l2 compatibility, I get the following:
>>>
>>>       GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
>>> GStreamer 1.0... ❌
>>>       GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
>>> GStreamer 1.0... ✔️
>>>       GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
>>> GStreamer 1.0... ❌
>>>       GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
>>> GStreamer 1.0... ❌
>>>       GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
>>> GStreamer 1.0... ❌
>>>       GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer 1.0... ❌
>>>       GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
>>> GStreamer 1.0... ✔️
>>>       GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
>>> GStreamer 1.0... ✔️
>>>
>>> I see H,264, VP8 and VP9, but I would have also expected
>>> GStreamer-H.265-V4L2SL-Gst1.0 to return with a check box.
>>>
>>> When I checked to see if both decoders were being enumerated, I found they were.
>>> [gst-main] root@localhost:~/gstreamer/fluster# dmesg |grep -i hantro
>>> [   16.044243] hantro_vpu: module is from the staging directory, the
>>> quality is unknown, you have been warned.
>>> [   16.044243] hantro_vpu: module is from the staging directory, the
>>> quality is unknown, you have been warned.
>>> [   16.095661] hantro-vpu 38300000.video-codec: registered
>>> nxp,imx8mq-vpu-g1-dec as /dev/video0
>>> [   16.096782] hantro-vpu 38310000.video-codec: registered
>>> nxp,imx8mq-vpu-g2-dec as /dev/video1
>>>
>>> Did I do something wrong, or did I miss something?
>> Hi Adam,
>>
>> I guess it could be a misalignment between v4l2 kernel headers
>> and GStreamer v4l2 headers.
>> I have push a new version of the GST merge request which is aligned with
>> HEVC uAPI v4 proposal.
>>
>> When you inspect v4l2codecs gst plugin (gst-inspect-1.0 v4l2codecs) do
>> you see v4l2slh265dec plugin ?
>> I have fluster happy with it:
>> ./fluster.py list -c
> I pulled the latest from g-streamer's git repo again, and re-built.
> gst-instpect does not appear to show the h265 codec anymore.
>
> # gst-inspect-1.0 |grep v4l2codecs
> v4l2codecs:  v4l2slh264dec: V4L2 Stateless H.264 Video Decoder
> v4l2codecs:  v4l2slmpeg2dec: V4L2 Stateless Mpeg2 Video Decoder
> v4l2codecs:  v4l2slvp8alphadecodebin: VP8 Alpha Decoder
> v4l2codecs:  v4l2slvp8dec: V4L2 Stateless VP8 Video Decoder
> v4l2codecs:  v4l2slvp9alphadecodebin: VP9 Alpha Decoder
> v4l2codecs:  v4l2slvp9dec: V4L2 Stateless VP9 Video Decoder
>
> Is there a specific branch of g-streamer I should be using that can
> handle the newer API?

You can use this branch:

https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_aligned_with_kernel_5.15

It is the one used to create the merge request for h265 plugin.

Benjamin

adam

>>
>> H265
>>       ...
>>       GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for GStreamer 1.0... ❌
>>       GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for GStreamer 1.0... ✔️
>>       GStreamer-H.265-VA-Gst1.0: GStreamer H.265 VA decoder for GStreamer 1.0... ❌
>>       GStreamer-H.265-VAAPI-Gst1.0: GStreamer H.265 VAAPI decoder for GStreamer 1.0... ❌
>>       JCT-VT-H.265: JCT-VT H.265/HEVC reference decoder... ❌
>>
>> I hope that will help you,
>>
>> Regards,
>> Benjamin
>>
>>> adam
>>>
>>>> Regards,
>>>> Benjamin
>>>>
>>>>> Benjamin,
>>>>>
>>>>> I have an imx8mm and imx8mq that I can test. Do you happen to have a
>>>>> repo that I can clone to test this?  The imx8m stuff is spread around
>>>>> between the media tree and the imx tree since it hasn't been fully
>>>>> merged yet.
>>>>>
>>>>> thanks,
>>>>>
>>>>> adam
>>>>>
>>>>>> Benjamin
>>>>>>
>>>>>> Benjamin Gaignard (11):
>>>>>>      media: uapi: HEVC: Add missing fields in HEVC controls
>>>>>>      media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>>>>>>        prefix
>>>>>>      media: uapi: HEVC: Add document uAPI structure
>>>>>>      media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
>>>>>>        dynamic array
>>>>>>      media: uapi: Move parsed HEVC pixel format out of staging
>>>>>>      media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
>>>>>>      media: uapi: Move the HEVC stateless control type out of staging
>>>>>>      media: controls: Log HEVC stateless control in .std_log
>>>>>>      media: uapi: Create a dedicated header for Hantro control
>>>>>>      media: uapi: HEVC: fix padding in v4l2 control structures
>>>>>>      media: uapi: move HEVC stateless controls out of staging
>>>>>>
>>>>>> Hans Verkuil (3):
>>>>>>      videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>>>>>>      v4l2-ctrls: add support for dynamically allocated arrays.
>>>>>>      vivid: add dynamic array test control
>>>>>>
>>>>>>     .../userspace-api/media/drivers/hantro.rst    |   5 -
>>>>>>     .../media/v4l/ext-ctrls-codec-stateless.rst   | 831 ++++++++++++++++++
>>>>>>     .../media/v4l/ext-ctrls-codec.rst             | 780 ----------------
>>>>>>     .../media/v4l/pixfmt-compressed.rst           |   7 +-
>>>>>>     .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>>>>>>     .../media/v4l/vidioc-queryctrl.rst            |   8 +
>>>>>>     .../media/videodev2.h.rst.exceptions          |   5 +
>>>>>>     .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>>>>>>     drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
>>>>>>     drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
>>>>>>     drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +-
>>>>>>     drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>>>>>>     drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>>>>>>     drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>>>>>>     drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>>>>>>     drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>>>>>>     .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>>>>>>     include/media/hevc-ctrls.h                    | 250 ------
>>>>>>     include/media/v4l2-ctrls.h                    |  48 +-
>>>>>>     include/uapi/linux/hantro-media.h             |  19 +
>>>>>>     include/uapi/linux/v4l2-controls.h            | 436 +++++++++
>>>>>>     include/uapi/linux/videodev2.h                |  13 +
>>>>>>     22 files changed, 1686 insertions(+), 1169 deletions(-)
>>>>>>     delete mode 100644 include/media/hevc-ctrls.h
>>>>>>     create mode 100644 include/uapi/linux/hantro-media.h
>>>>>>
>>>>>> --
>>>>>> 2.32.0
>>>>>>
