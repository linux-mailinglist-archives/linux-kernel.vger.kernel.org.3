Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96F54C66ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiB1KNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiB1KNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:13:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E543E5D0;
        Mon, 28 Feb 2022 02:13:04 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:82d4:230a:70ff:cde0] (unknown [IPv6:2a01:e0a:120:3210:82d4:230a:70ff:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5A7F41F4368D;
        Mon, 28 Feb 2022 10:13:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646043182;
        bh=a9FHzNuU92dqrEPvuF93c7HoK44OcyHxWgqx2Pv4lZ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a1GJ7KpwVTPeIKB8GkzTAHYv4gNO/jBIABErVW0R/lTBisjZMbRWAstcjfQ1OA7l2
         jyrXh1r9WEqFSPNWgly5Pp4UvFsPsgRRBAMUtnSQhvZOjhFRJ0fTDTG9DRhaa+bD7r
         toZ9hMGzW7u+VlguVUGEqyb7anYbKYegOXSKMKy2bRI8nLoohBnKCX9fXk8HL+PUtj
         c44Eug0qG4z2cJDqoGm5LttCKU7nCouhDSlWKoRV3LQyxs9yExa7RIsyccAVr/AdwG
         yQxvoeTATK2U8G3yfwq/XMiAfnf/HG7DF4KApGxNly8uqC0cvcOv4EmV3y9zB1xI7E
         gL4RtFGjRpx8w==
Message-ID: <b832271d-cecd-a373-48ff-ba5ce736e47d@collabora.com>
Date:   Mon, 28 Feb 2022 11:13:00 +0100
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
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAHCN7x+AUy4JsqfdyZFqg4ScR1OgoLvqF91za0AZ278NSBJj4A@mail.gmail.com>
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


Le 26/02/2022 à 23:25, Adam Ford a écrit :
> On Fri, Feb 25, 2022 at 4:41 PM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> This series aims to make HEVC uapi stable and usable for hardware
>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
>> and 2 out of the tree drivers (rkvdec and RPI).
>>
>> After the remarks done on version 2, I have completely reworked to patches
>> split so changelogs are meaningless. I have also drop "RFC" from the
>> titles.
>>
>> In this v3 I do all the changes (new controls, documentation, etc..)
>> in the staging directory before moving the HEVC uAPI to stable
>> steps by steps (unlike the big one patch in v2).
>>
>> At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.

I have push a branch here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/HEVC_UAPI_V4

it is the incoming version 4 of this series + patches to enable G2 on my IMX8MQ

Regards,
Benjamin

> Benjamin,
>
> I have an imx8mm and imx8mq that I can test. Do you happen to have a
> repo that I can clone to test this?  The imx8m stuff is spread around
> between the media tree and the imx tree since it hasn't been fully
> merged yet.
>
> thanks,
>
> adam
>
>> Benjamin
>>
>> Benjamin Gaignard (11):
>>    media: uapi: HEVC: Add missing fields in HEVC controls
>>    media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>>      prefix
>>    media: uapi: HEVC: Add document uAPI structure
>>    media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
>>      dynamic array
>>    media: uapi: Move parsed HEVC pixel format out of staging
>>    media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
>>    media: uapi: Move the HEVC stateless control type out of staging
>>    media: controls: Log HEVC stateless control in .std_log
>>    media: uapi: Create a dedicated header for Hantro control
>>    media: uapi: HEVC: fix padding in v4l2 control structures
>>    media: uapi: move HEVC stateless controls out of staging
>>
>> Hans Verkuil (3):
>>    videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>>    v4l2-ctrls: add support for dynamically allocated arrays.
>>    vivid: add dynamic array test control
>>
>>   .../userspace-api/media/drivers/hantro.rst    |   5 -
>>   .../media/v4l/ext-ctrls-codec-stateless.rst   | 831 ++++++++++++++++++
>>   .../media/v4l/ext-ctrls-codec.rst             | 780 ----------------
>>   .../media/v4l/pixfmt-compressed.rst           |   7 +-
>>   .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>>   .../media/v4l/vidioc-queryctrl.rst            |   8 +
>>   .../media/videodev2.h.rst.exceptions          |   5 +
>>   .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>>   drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
>>   drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +-
>>   drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>>   drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>>   drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>>   drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>>   drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>>   .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>>   include/media/hevc-ctrls.h                    | 250 ------
>>   include/media/v4l2-ctrls.h                    |  48 +-
>>   include/uapi/linux/hantro-media.h             |  19 +
>>   include/uapi/linux/v4l2-controls.h            | 436 +++++++++
>>   include/uapi/linux/videodev2.h                |  13 +
>>   22 files changed, 1686 insertions(+), 1169 deletions(-)
>>   delete mode 100644 include/media/hevc-ctrls.h
>>   create mode 100644 include/uapi/linux/hantro-media.h
>>
>> --
>> 2.32.0
>>
