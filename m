Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E954EEDF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbiDANUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiDANUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:20:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826BE5045B;
        Fri,  1 Apr 2022 06:18:46 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:a2c0:2ef3:44e0:633b] (unknown [IPv6:2a01:e0a:120:3210:a2c0:2ef3:44e0:633b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3CCF01F47939;
        Fri,  1 Apr 2022 14:18:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648819124;
        bh=7v8TCx/Kj5ELlw8I2aKq0GItt14ep/CbDiUKjFQ0BWQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=aCoSe9GFvS8N20ultU35dtAW/lMJ7mDvjo8RapHP11UgfAZp0UvxLjkmGNKBitqa3
         5sjS3FdjzVB98Aj49v85+rJRGzPYSTSCsVHabj8/MeU7NMtfnivd1YQ8nNHoWhZwOJ
         OQIm1XDVc2k0+Sp5CQ6RMMt/2xunaAKKLKnKD6n1x09Y0Tzm7ckfTS86aJ4zML9UMi
         I+x7UDkRRFvv1GPuJk3EYwfZpwQ1R9gth/F9SmK0S9KDkJ3KNfUcPTm9AKs4Fqd0Cn
         UBRnNZ5Y6a1Sjh5hb7R+bHTcnuErJwwjBWJ5NVp/2T+rp443Lo6+cFVwd2C/soOd8J
         1HjPJMB8LWofQ==
Message-ID: <3f778844-f655-74a7-0a00-05caa84eca35@collabora.com>
Date:   Fri, 1 Apr 2022 15:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 00/15] Move HEVC stateless controls out of staging
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
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
In-Reply-To: <79a9c925-d930-ad23-dc53-9ebc16d1328a@collabora.com>
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


Le 31/03/2022 à 08:53, Benjamin Gaignard a écrit :
>
> Le 30/03/2022 à 20:52, Adam Ford a écrit :
>> On Wed, Mar 30, 2022 at 2:53 AM Benjamin Gaignard
>> <benjamin.gaignard@collabora.com> wrote:
>>>
>>> Le 28/02/2022 à 15:08, Benjamin Gaignard a écrit :
>>>> This series aims to make HEVC uapi stable and usable for hardware
>>>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
>>>> and 2 out of the tree drivers (rkvdec and RPI).
>>>>
>>>> After the remarks done on version 2, I have completely reworked to 
>>>> patches
>>>> split so changelogs are meaningless. I have also drop "RFC" from the
>>>> titles.
>>>>
>>>> Version 4:
>>>> - Add num_entry_point_offsets field in  struct 
>>>> v4l2_ctrl_hevc_slice_params
>>>> - Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
>>>> - Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
>>>> - Fix space/tab issue in kernel-doc
>>>> - Add patch to change data_bit_offset definition
>>>> - Fix hantro-media SPDX license
>>>> - put controls under stateless section in v4l2-ctrls-defs.c
>>>>
>>>> At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>>> Dear reviewers,
>>>
>>> This series is waiting for your feedback,
>> I tried several times with the suggested repos for both the kernel and
>> g-streamer without success getting Fluster to pass any tests on the
>> imx8mq.  I can try again but I likely won't get to it until this
>> weekend.  If I can get it working, I'll test both the 8mq and 8mm.
>
> Thanks a lot for that.
>
> Benjamin

Adam,

You may need to check if h265parse and v4l2slh265dec are available on your board.

fluster check if v4l2slh265dec is working fine with this command line:

gst-launch-1.0 appsrc num-buffers=0 ! h265parse ! v4l2slh265dec ! fakesink

so if one of them is missing it won't work.

Regards,
Benjamin

>
>>
>> adam
>>> Thanks,
>>> Benjamin
>>>
>>>> Benjamin
>>>>
>>>>
>>>> Benjamin Gaignard (12):
>>>>     media: uapi: HEVC: Add missing fields in HEVC controls
>>>>     media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>>>>       prefix
>>>>     media: uapi: HEVC: Add document uAPI structure
>>>>     media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS 
>>>> as a
>>>>       dynamic array
>>>>     media: uapi: Move parsed HEVC pixel format out of staging
>>>>     media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS 
>>>> control
>>>>     media: uapi: Move the HEVC stateless control type out of staging
>>>>     media: controls: Log HEVC stateless control in .std_log
>>>>     media: uapi: Create a dedicated header for Hantro control
>>>>     media: uapi: HEVC: fix padding in v4l2 control structures
>>>>     media: uapi: Change data_bit_offset definition
>>>>     media: uapi: move HEVC stateless controls out of staging
>>>>
>>>> Hans Verkuil (3):
>>>>     videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>>>>     v4l2-ctrls: add support for dynamically allocated arrays.
>>>>     vivid: add dynamic array test control
>>>>
>>>>    .../userspace-api/media/drivers/hantro.rst    |   5 -
>>>>    .../media/v4l/ext-ctrls-codec-stateless.rst   | 833 
>>>> ++++++++++++++++++
>>>>    .../media/v4l/ext-ctrls-codec.rst             | 780 
>>>> ----------------
>>>>    .../media/v4l/pixfmt-compressed.rst           |   7 +-
>>>>    .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>>>>    .../media/v4l/vidioc-queryctrl.rst            |   8 +
>>>>    .../media/videodev2.h.rst.exceptions          |   5 +
>>>>    .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>>>>    drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
>>>>    drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
>>>>    drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  37 +-
>>>>    drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>>>>    drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>>>>    drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>>>>    drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>>>>    drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>>>>    .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>>>>    .../staging/media/sunxi/cedrus/cedrus_h265.c  |   2 +-
>>>>    include/media/hevc-ctrls.h                    | 250 ------
>>>>    include/media/v4l2-ctrls.h                    |  48 +-
>>>>    include/uapi/linux/hantro-media.h             |  19 +
>>>>    include/uapi/linux/v4l2-controls.h            | 439 +++++++++
>>>>    include/uapi/linux/videodev2.h                |  13 +
>>>>    23 files changed, 1697 insertions(+), 1170 deletions(-)
>>>>    delete mode 100644 include/media/hevc-ctrls.h
>>>>    create mode 100644 include/uapi/linux/hantro-media.h
>>>>
