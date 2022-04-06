Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A474F63BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiDFPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiDFPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:44:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140161947AF;
        Wed,  6 Apr 2022 06:01:21 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:ff63:de1f:2a77:5241] (unknown [IPv6:2a01:e0a:120:3210:ff63:de1f:2a77:5241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 13CE91F43AC3;
        Wed,  6 Apr 2022 14:01:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649250079;
        bh=MUvsdDAfMQa/i0ELUbJR6cqA9Y3XPIqUH6bnBulk36I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gYK5yFc0UcZ2+EpM+dk9BbIX3WWdGGCOKwPqczUKXZgoR4FP1/nb3sN7ID1LA7gcd
         KEtubwDNEPXcrzPz74r3Ac1QJ4rBll0YEvrLfbWDWqjOxO41DyHE6X2HZDOT+Jot1m
         bfVIeeo8u6OC57NVCDJUEkARi253rbEANExTsOVhTiQtnMKfM5U+eJavWg3t0dhpvk
         oZkQRDS/1UqYjtR8WDA1kFiYLh5ZRxoO51Tyr8Pbs8iTCVxp8Znmp/zeaD+03yTdkx
         Izg3j1zdDFOe4cw8/xViHibPMoBwBO5Xa1bYs9AgiITLEauXFRpHN8hKt/+Z4NVW6H
         5wy94Ucg+HLCQ==
Message-ID: <307a372d-a90b-511f-884a-2709d88fe5e9@collabora.com>
Date:   Wed, 6 Apr 2022 15:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 00/15] Move HEVC stateless controls out of staging
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
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
 <eefa63b3-2a4d-4470-9a4e-517087ebcfaf@collabora.com>
 <CAHCN7xL2uZTMy30FGfDkDK4Lym6wvfr_MTv7QwtchrkTXMQiuw@mail.gmail.com>
 <79a9c925-d930-ad23-dc53-9ebc16d1328a@collabora.com>
 <3f778844-f655-74a7-0a00-05caa84eca35@collabora.com>
 <CAHCN7xLy2381AFLWhLxk5YuRV7C=OwLX=XPXONX8sbkg-SqMjA@mail.gmail.com>
 <CAHCN7xJWQa-uXb0-+CSvAr1JhFmQYt80Q=uGvaY8uyptNcfbgw@mail.gmail.com>
 <163202bd-ea51-e80a-1481-568fae25b045@collabora.com>
 <CAHCN7x+AwNauiyaVL=NGARkmxWOL9uLS5-AO4TjkvLGNQ=3r+Q@mail.gmail.com>
 <bb462ee8-7bf9-5574-7cc2-098cc66e5ef0@collabora.com>
 <CAHCN7x+DTjeP7zQJYPyqzdz=hXWjz6Br0v1sWh4n1J3TJPb+9g@mail.gmail.com>
 <8d23c99a-4ad0-e65a-0134-12f5d119e8bb@collabora.com>
 <CAHCN7x+YuXFrMe6dYo_VhkG7ey1jcPTpOMCM1=qoTivZO9U2Rw@mail.gmail.com>
 <f495aa2b-81f7-a3cd-a6dd-cc5ae5f0a81f@collabora.com>
 <CAHCN7x+CYSOfVnjHVoL7fmjrEZBmAtMeZ6NvS_1E3aLtv3M8Cg@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAHCN7x+CYSOfVnjHVoL7fmjrEZBmAtMeZ6NvS_1E3aLtv3M8Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06/04/2022 à 14:55, Adam Ford a écrit :
> On Wed, Apr 6, 2022 at 7:50 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>>
>> Le 06/04/2022 à 14:46, Adam Ford a écrit :
>>> On Wed, Apr 6, 2022 at 7:41 AM Benjamin Gaignard
>>> <benjamin.gaignard@collabora.com> wrote:
>>>> Le 06/04/2022 à 14:28, Adam Ford a écrit :
>>>>> On Wed, Apr 6, 2022 at 1:56 AM Benjamin Gaignard
>>>>> <benjamin.gaignard@collabora.com> wrote:
>>>>>> Le 05/04/2022 à 23:27, Adam Ford a écrit :
>>>>>>> On Mon, Apr 4, 2022 at 10:56 AM Benjamin Gaignard
>>>>>>> <benjamin.gaignard@collabora.com> wrote:
>>>>>>>> Le 02/04/2022 à 18:59, Adam Ford a écrit :
>>>>>>>>> On Sat, Apr 2, 2022 at 11:22 AM Adam Ford <aford173@gmail.com> wrote:
>>>>>>>>>> On Fri, Apr 1, 2022 at 8:18 AM Benjamin Gaignard
>>>>>>>>>> <benjamin.gaignard@collabora.com> wrote:
>>>>>>>>>>> Le 31/03/2022 à 08:53, Benjamin Gaignard a écrit :
>>>>>>>>>>>> Le 30/03/2022 à 20:52, Adam Ford a écrit :
>>>>>>>>>>>>> On Wed, Mar 30, 2022 at 2:53 AM Benjamin Gaignard
>>>>>>>>>>>>> <benjamin.gaignard@collabora.com> wrote:
>>>>>>>>>>>>>> Le 28/02/2022 à 15:08, Benjamin Gaignard a écrit :
>>>>>>>>>>>>>>> This series aims to make HEVC uapi stable and usable for hardware
>>>>>>>>>>>>>>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
>>>>>>>>>>>>>>> and 2 out of the tree drivers (rkvdec and RPI).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> After the remarks done on version 2, I have completely reworked to
>>>>>>>>>>>>>>> patches
>>>>>>>>>>>>>>> split so changelogs are meaningless. I have also drop "RFC" from the
>>>>>>>>>>>>>>> titles.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Version 4:
>>>>>>>>>>>>>>> - Add num_entry_point_offsets field in  struct
>>>>>>>>>>>>>>> v4l2_ctrl_hevc_slice_params
>>>>>>>>>>>>>>> - Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
>>>>>>>>>>>>>>> - Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
>>>>>>>>>>>>>>> - Fix space/tab issue in kernel-doc
>>>>>>>>>>>>>>> - Add patch to change data_bit_offset definition
>>>>>>>>>>>>>>> - Fix hantro-media SPDX license
>>>>>>>>>>>>>>> - put controls under stateless section in v4l2-ctrls-defs.c
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>>>>>>>>>>>>>> Dear reviewers,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This series is waiting for your feedback,
>>>>>>>>>>>>> I tried several times with the suggested repos for both the kernel and
>>>>>>>>>>>>> g-streamer without success getting Fluster to pass any tests on the
>>>>>>>>>>>>> imx8mq.  I can try again but I likely won't get to it until this
>>>>>>>>>>>>> weekend.  If I can get it working, I'll test both the 8mq and 8mm.
>>>>>>>>>>>> Thanks a lot for that.
>>>>>>>>>>>>
>>>>>>>>>>>> Benjamin
>>>>>>>>>>> Adam,
>>>>>>>>>>>
>>>>>>>>>>> You may need to check if h265parse and v4l2slh265dec are available on your board.
>>>>>>>>>> I ran gst-inspect to see what showed up with 265 in the name.
>>>>>>>>>>
>>>>>>>>>> # gst-inspect-1.0 |grep 265
>>>>>>>>>> libav:  avdec_h265: libav HEVC (High Efficiency Video Coding) decoder
>>>>>>>>>> rtp:  rtph265depay: RTP H265 depayloader
>>>>>>>>>> rtp:  rtph265pay: RTP H265 payloader
>>>>>>>>>> typefindfunctions: video/x-h265: h265, x265, 265
>>>>>>>>>> v4l2codecs:  v4l2slh265dec: V4L2 Stateless H.265 Video Decoder
>>>>>>>>>> videoparsersbad:  h265parse: H.265 parser
>>>>>>>>>>
>>>>>>>>>> It appears I have both h265parse and v4l2slh265dec.
>>>>>>>>>>
>>>>>>>>>>> fluster check if v4l2slh265dec is working fine with this command line:
>>>>>>>>>>>
>>>>>>>>>>> gst-launch-1.0 appsrc num-buffers=0 ! h265parse ! v4l2slh265dec ! fakesink
>>>>>>>>>>>
>>>>>>>>>>> so if one of them is missing it won't work.
>>>>>>>>>> gst-launch-1.0 appsrc num-buffers=0 ! h265parse ! v4l2slh265dec ! fakesink
>>>>>>>>>> Setting pipeline to PAUSED ...
>>>>>>>>>> 0:00:00.098389938   526 0xaaaaf9d86ac0 ERROR     v4l2codecs-decoder
>>>>>>>>>> gstv4l2decoder.c:725:gst_v4l2_decoder_get_controls:<v4l2decoder2>
>>>>>>>>>> VIDIOC_G_EXT_CTRLS failed: Invalid argument
>>>>>>>>>> ERROR: from element
>>>>>>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0: Driver did not
>>>>>>>>>> report framing and start code method.
>>>>>>>>>> Additional debug info:
>>>>>>>>>> ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codech265dec.c(155):
>>>>>>>>>> gst_v4l2_codec_h265_dec_open ():
>>>>>>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0:
>>>>>>>>>> gst_v4l2_decoder_get_controls() failed: Invalid argument
>>>>>>>>>> ERROR: pipeline doesn't want to preroll.
>>>>>>>>>> ERROR: from element
>>>>>>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0: Could not
>>>>>>>>>> initialize supporting library.
>>>>>>>>>> Additional debug info:
>>>>>>>>>> ../subprojects/gst-plugins-base/gst-libs/gst/video/gstvideodecoder.c(2909):
>>>>>>>>>> gst_video_decoder_change_state ():
>>>>>>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0:
>>>>>>>>>> Failed to open decoder
>>>>>>>>>> ERROR: pipeline doesn't want to preroll.
>>>>>>>>>> Failed to set pipeline to PAUSED.
>>>>>>>>>> Setting pipeline to NULL ...
>>>>>>>>>> Freeing pipeline ...
>>>>>>>>>>
>>>>>>>>>> Does this mean I have a wrong version of the kernel and/or incomplete patches?
>>>>>>>>> I double checked the branches.
>>>>>>>>>
>>>>>>>>> Kernel:
>>>>>>>>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream.git
>>>>>>>>> branch:  origin/HEVC_UAPI_V4
>>>>>>>>>
>>>>>>>>> Gstreamer:
>>>>>>>>> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer.git
>>>>>>>>> branch:  origin/benjamin.gaignard1/gstreamer-HEVC_aligned_with_kernel_5.15
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I am still not able to run h.265/HEVC tests.
>>>>>>>> Hello Adam,
>>>>>>>>
>>>>>>>> I have updated the following branches with the versions I have used today:
>>>>>>>>
>>>>>>>> Kernel:
>>>>>>>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream.git
>>>>>>>> branch: origin/HEVC_UAPI_V5 only one change in documentation vs version 4 but rebased in v5.18-rc1
>>>>>>>>
>>>>>>>> Gstreamer:
>>>>>>>> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer.git
>>>>>>>> branch:  origin/benjamin.gaignard1/gstreamer-HEVC_aligned_with_kernel_5.15 updated on the latest GST main branch
>>>>>>>>
>>>>>>>> I hope this will work fine this time.
>>>>>>> I wish I had better news for you:
>>>>>>>
>>>>>>> dmesg shows the hantro driver is being loaded:
>>>>>>>
>>>>>>> [   38.612243] hantro-vpu 38300000.video-codec: registered
>>>>>>> nxp,imx8mq-vpu-g1-dec as /dev/video0
>>>>>>> [   38.612618] hantro-vpu 38310000.video-codec: registered
>>>>>>> nxp,imx8mq-vpu-g2-dec as /dev/video1
>>>>>>>
>>>>>>> # gst-inspect-1.0 |grep 265
>>>>>>> libav:  avdec_h265: libav HEVC (High Efficiency Video Coding) decoder
>>>>>>> rtp:  rtph265depay: RTP H265 depayloader
>>>>>>> rtp:  rtph265pay: RTP H265 payloader
>>>>>>> typefindfunctions: video/x-h265: h265, x265, 265
>>>>>>> v4l2codecs:  v4l2slh265dec: V4L2 Stateless H.265 Video Decoder
>>>>>>> videoparsersbad:  h265parse: H.265 parser
>>>>>>>
>>>>>>> Fluster reports:
>>>>>>> GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
>>>>>>> GStreamer 1.0... ❌
>>>>>> Still the same error about non supported control ?
>>>>> # gst-lagst-launch-1.0 appsrc num-buffers=0 ! h265parse !
>>>>> v4l2slh265dec ! fakesink
>>>>> Setting pipeline to PAUSED ...
>>>>> 0:00:01.704385508   420 0xaaaaec0a76c0 ERROR     v4l2codecs-decoder
>>>>> gstv4l2decoder.c:725:gst_v4l2_decoder_get_controls:<v4l2decoder2>
>>>>> VIDIOC_G_EXT_CTRLS failed: Invalid argument
>>>>> ERROR: from element
>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0: Driver did not
>>>>> report framing and start code method.
>>>>> Additional debug info:
>>>>> ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codech265dec.c(155):
>>>>> gst_v4l2_codec_h265_dec_open ():
>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0:
>>>>> gst_v4l2_decoder_get_controls() failed: Invalid argument
>>>>> ERROR: pipeline doesn't want to preroll.
>>>>> ERROR: from element
>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0: Could not
>>>>> initialize supporting library.
>>>>> Additional debug info:
>>>>> ../subprojects/gst-plugins-base/gst-libs/gst/video/gstvideodecoder.c(2909):
>>>>> gst_video_decoder_change_state ():
>>>>> /GstPipeline:pipeline0/v4l2slh265dec:v4l2slh265dec0:
>>>>> Failed to open decoder
>>>>> ERROR: pipeline doesn't want to preroll.
>>>>> Failed to set pipeline to PAUSED.
>>>>> Setting pipeline to NULL ...
>>>>> Freeing pipeline ...
>>>> What is the result of v4l2-ctl ?
>>>> Here I have:
>>>> v4l2-ctl --all -d 1
>>>> Driver Info:
>>>>           Driver name      : hantro-vpu
>>>>           Card type        : nxp,imx8mq-vpu-g2-dec
>>>>           Bus info         : platform: hantro-vpu
>>>>           Driver version   : 5.18.0
>>>>           Capabilities     : 0x84204000
>>>>                   Video Memory-to-Memory Multiplanar
>>>>                   Streaming
>>>>                   Extended Pix Format
>>>>                   Device Capabilities
>>>>           Device Caps      : 0x04204000
>>>>                   Video Memory-to-Memory Multiplanar
>>>>                   Streaming
>>>>                   Extended Pix Format
>>>> Media Driver Info:
>>>>           Driver name      : hantro-vpu
>>>>           Model            : hantro-vpu
>>>>           Serial           :
>>>>           Bus info         : platform: hantro-vpu
>>>>           Media version    : 5.18.0
>>>>           Hardware revision: 0x00000000 (0)
>>>>           Driver version   : 5.18.0
>>>> Interface Info:
>>>>           ID               : 0x0300000c
>>>>           Type             : V4L Video
>>>> Entity Info:
>>>>           ID               : 0x00000001 (1)
>>>>           Name             : nxp,imx8mq-vpu-g2-dec-source
>>>>           Function         : V4L2 I/O
>>>>           Pad 0x01000002   : 0: Source
>>>>             Link 0x02000008: to remote pad 0x1000004 of entity 'nxp,imx8mq-vpu-g2-dec-proc': Data, Enabled, Immutable
>>>> Priority: 2
>>>> Format Video Capture Multiplanar:
>>>>           Width/Height      : 48/48
>>>>           Pixel Format      : 'VT12' (Y/CbCr 4:2:0 (4x4 Linear))
>>>>           Field             : None
>>>>           Number of planes  : 1
>>>>           Flags             :
>>>>           Colorspace        : JPEG
>>>>           Transfer Function : Default
>>>>           YCbCr/HSV Encoding: Default
>>>>           Quantization      : Default
>>>>           Plane 0           :
>>>>              Bytes per Line : 48
>>>>              Size Image     : 3600
>>>> Format Video Output Multiplanar:
>>>>           Width/Height      : 48/48
>>>>           Pixel Format      : 'S265' (HEVC Parsed Slice Data)
>>>>           Field             : None
>>>>           Number of planes  : 1
>>>>           Flags             :
>>>>           Colorspace        : JPEG
>>>>           Transfer Function : Default
>>>>           YCbCr/HSV Encoding: Default
>>>>           Quantization      : Default
>>>>           Plane 0           :
>>>>              Bytes per Line : 0
>>>>              Size Image     : 4608
>>>>
>>>> User Controls
>>>>
>>>> hantro_hevc_slice_header_skip_b 0x00981a80 (int)    : min=0 max=256 step=1 default=0 value=0
>>>>
>>>> Codec Controls
>>>>
>>>>                       hevc_profile 0x00990b67 (menu)   : min=0 max=2 default=0 value=0
>>>>                                   0: Main
>>>>                                   1: Main Still Picture
>>>>                                   2: Main 10
>>>>                         hevc_level 0x00990b68 (menu)   : min=0 max=8 default=0 value=0
>>>>                                   0: 1
>>>>                                   1: 2
>>>>                                   2: 2.1
>>>>                                   3: 3
>>>>                                   4: 3.1
>>>>                                   5: 4
>>>>                                   6: 4.1
>>>>                                   7: 5
>>>>                                   8: 5.1
>>>>
>>>> Stateless Codec Controls
>>>>
>>>>        vp9_frame_decode_parameters 0x00a40a2c (unknown): type=261 flags=has-payload
>>>>          vp9_probabilities_updates 0x00a40a2d (unknown): type=260 flags=has-payload
>>>>        hevc_sequence_parameter_set 0x00a40a90 (unknown): type=270 flags=has-payload
>>>>         hevc_picture_parameter_set 0x00a40a91 (unknown): type=271 flags=has-payload
>>>>                hevc_scaling_matrix 0x00a40a93 (unknown): type=273 flags=has-payload
>>>>             hevc_decode_parameters 0x00a40a94 (unknown): type=274 flags=has-payload
>>>>                   hevc_decode_mode 0x00a40a95 (menu)   : min=1 max=1 default=1 value=1
>>>>                                   1: Frame-Based
>>>>                    hevc_start_code 0x00a40a96 (menu)   : min=1 max=1 default=1 value=1
>>>>                                   1: Annex B Start Code
>>>>
>>> Mine looks like:
>>>
>>> # v4l2-ctl --all -d 1
>>> Driver Info:
>>> Driver name      : hantro-vpu
>>> Card type        : nxp,imx8mq-vpu-g2-dec
>>> Bus info         : platform: hantro-vpu
>>> Driver version   : 5.18.0
>>> Capabilities     : 0x84204000
>>> Video Memory-to-Memory Multiplanar
>>> Streaming
>>> Extended Pix Format
>>> Device Capabilities
>>> Device Caps      : 0x04204000
>>> Video Memory-to-Memory Multiplanar
>>> Streaming
>>> Extended Pix Format
>>> Media Driver Info:
>>> Driver name      : hantro-vpu
>>> Model            : hantro-vpu
>>> Serial           :
>>> Bus info         : platform: hantro-vpu
>>> Media version    : 5.18.0
>>> Hardware revision: 0x00000000 (0)
>>> Driver version   : 5.18.0
>>> Interface Info:
>>> ID               : 0x0300000c
>>> Type             : V4L Video
>>> Entity Info:
>>> ID               : 0x00000001 (1)
>>> Name             : nxp,imx8mq-vpu-g2-dec-source
>>> Function         : V4L2 I/O
>>> Pad 0x01000002   : 0: Source
>>>     Link 0x02000008: to remote pad 0x1000004 of entity
>>> 'nxp,imx8mq-vpu-g2-dec-proc': Data, Enabled, Immutable
>>> Priority: 2
>>> Format Video Capture Multiplanar:
>>> Width/Height      : 48/48
>>> Pixel Format      : 'VT12' (Y/CbCr 4:2:0 (4x4 Linear))
>>> Field             : None
>>> Number of planes  : 1
>>> Flags             :
>>> Colorspace        : JPEG
>>> Transfer Function : Default
>>> YCbCr/HSV Encoding: Default
>>> Quantization      : Default
>>> Plane 0           :
>>>      Bytes per Line : 48
>>>      Size Image     : 3600
>>> Format Video Output Multiplanar:
>>> Width/Height      : 48/48
>>> Pixel Format      : 'S265' (HEVC Parsed Slice Data)
>>> Field             : None
>>> Number of planes  : 1
>>> Flags             :
>>> Colorspace        : JPEG
>>> Transfer Function : Default
>>> YCbCr/HSV Encoding: Default
>>> Quantization      : Default
>>> Plane 0           :
>>>      Bytes per Line : 0
>>>      Size Image     : 4608
>>>
>>> User Controls
>>>
>>> hantro_hevc_slice_header_skip_b 0x00981a80 (int)    : min=0 max=256
>>> step=1 default=0 value=0
>>>
>>> Codec Controls
>>>
>>>                      hevc_profile 0x00990b67 (menu)   : min=0 max=2
>>> default=0 value=0
>>> 0: Main
>>> 1: Main Still Picture
>>> 2: Main 10
>>>                        hevc_level 0x00990b68 (menu)   : min=0 max=8
>>> default=0 value=0
>>> 0: 1
>>> 1: 2
>>> 2: 2.1
>>> 3: 3
>>> 4: 3.1
>>> 5: 4
>>> 6: 4.1
>>> 7: 5
>>> 8: 5.1
>>>
>>> Stateless Codec Controls
>>>
>>>       vp9_frame_decode_parameters 0x00a40a2c (unknown): type=261 flags=has-payload
>>>         vp9_probabilities_updates 0x00a40a2d (unknown): type=260 flags=has-payload
>>>       hevc_sequence_parameter_set 0x00a40a90 (unknown): type=270 flags=has-payload
>>>        hevc_picture_parameter_set 0x00a40a91 (unknown): type=271 flags=has-payload
>>>               hevc_scaling_matrix 0x00a40a93 (unknown): type=273 flags=has-payload
>>>            hevc_decode_parameters 0x00a40a94 (unknown): type=274 flags=has-payload
>>>                  hevc_decode_mode 0x00a40a95 (menu)   : min=1 max=1
>>> default=1 value=1
>>> 1: Frame-Based
>>>                   hevc_start_code 0x00a40a96 (menu)   : min=1 max=1
>>> default=1 value=1
>>> 1: Annex B Start Code
>> It is the same so that suggest the issue is coming from GStreamer plugin.
> Do I need to build Gtreamer in a special way?  I just invoked  meson
> then ninja, but I didn't pass any additional parameters other than the
> build directory name.

Maybe make sure that the plugin is well rebuild ?

On my side I have this version:
gst-inspect-1.0 v4l2slh265dec
...
Plugin Details:
   Name                     v4l2codecs
   Description              V4L2 CODEC Accelerators plugin
   Filename                 /home/user/gstreamer/build/subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so
   Version                  1.21.0.1
   License                  LGPL
   Source module            gst-plugins-bad
   Binary package           GStreamer Bad Plug-ins git
   Origin URL               Unknown package origin
...

>
> adam
>>>>>> Benjamin
>>>>>>
>>>>>>> adam
>>>>>>>> Benjamin
>>>>>>>>
>>>>>>>>> adam
>>>>>>>>>> adam
>>>>>>>>>>> Regards,
>>>>>>>>>>> Benjamin
>>>>>>>>>>>
>>>>>>>>>>>>> adam
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> Benjamin
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Benjamin
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Benjamin Gaignard (12):
>>>>>>>>>>>>>>>          media: uapi: HEVC: Add missing fields in HEVC controls
>>>>>>>>>>>>>>>          media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>>>>>>>>>>>>>>>            prefix
>>>>>>>>>>>>>>>          media: uapi: HEVC: Add document uAPI structure
>>>>>>>>>>>>>>>          media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS
>>>>>>>>>>>>>>> as a
>>>>>>>>>>>>>>>            dynamic array
>>>>>>>>>>>>>>>          media: uapi: Move parsed HEVC pixel format out of staging
>>>>>>>>>>>>>>>          media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
>>>>>>>>>>>>>>> control
>>>>>>>>>>>>>>>          media: uapi: Move the HEVC stateless control type out of staging
>>>>>>>>>>>>>>>          media: controls: Log HEVC stateless control in .std_log
>>>>>>>>>>>>>>>          media: uapi: Create a dedicated header for Hantro control
>>>>>>>>>>>>>>>          media: uapi: HEVC: fix padding in v4l2 control structures
>>>>>>>>>>>>>>>          media: uapi: Change data_bit_offset definition
>>>>>>>>>>>>>>>          media: uapi: move HEVC stateless controls out of staging
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hans Verkuil (3):
>>>>>>>>>>>>>>>          videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>>>>>>>>>>>>>>>          v4l2-ctrls: add support for dynamically allocated arrays.
>>>>>>>>>>>>>>>          vivid: add dynamic array test control
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>         .../userspace-api/media/drivers/hantro.rst    |   5 -
>>>>>>>>>>>>>>>         .../media/v4l/ext-ctrls-codec-stateless.rst   | 833
>>>>>>>>>>>>>>> ++++++++++++++++++
>>>>>>>>>>>>>>>         .../media/v4l/ext-ctrls-codec.rst             | 780
>>>>>>>>>>>>>>> ----------------
>>>>>>>>>>>>>>>         .../media/v4l/pixfmt-compressed.rst           |   7 +-
>>>>>>>>>>>>>>>         .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>>>>>>>>>>>>>>>         .../media/v4l/vidioc-queryctrl.rst            |   8 +
>>>>>>>>>>>>>>>         .../media/videodev2.h.rst.exceptions          |   5 +
>>>>>>>>>>>>>>>         .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>>>>>>>>>>>>>>>         drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
>>>>>>>>>>>>>>>         drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
>>>>>>>>>>>>>>>         drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  37 +-
>>>>>>>>>>>>>>>         drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>>>>>>>>>>>>>>>         drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>>>>>>>>>>>>>>>         drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>>>>>>>>>>>>>>>         drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>>>>>>>>>>>>>>>         drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>>>>>>>>>>>>>>>         .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>>>>>>>>>>>>>>>         .../staging/media/sunxi/cedrus/cedrus_h265.c  |   2 +-
>>>>>>>>>>>>>>>         include/media/hevc-ctrls.h                    | 250 ------
>>>>>>>>>>>>>>>         include/media/v4l2-ctrls.h                    |  48 +-
>>>>>>>>>>>>>>>         include/uapi/linux/hantro-media.h             |  19 +
>>>>>>>>>>>>>>>         include/uapi/linux/v4l2-controls.h            | 439 +++++++++
>>>>>>>>>>>>>>>         include/uapi/linux/videodev2.h                |  13 +
>>>>>>>>>>>>>>>         23 files changed, 1697 insertions(+), 1170 deletions(-)
>>>>>>>>>>>>>>>         delete mode 100644 include/media/hevc-ctrls.h
>>>>>>>>>>>>>>>         create mode 100644 include/uapi/linux/hantro-media.h
>>>>>>>>>>>>>>>
