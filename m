Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292524E688F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352590AbiCXSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352588AbiCXSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:22:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE6B7C45;
        Thu, 24 Mar 2022 11:20:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C85C11F45A62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648146034;
        bh=xRKbfVwHbv6Tlcj1D9mUeCTfn3yd5MK7Xi2DPZnTJQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i2GevZ+8+KZtfwHQNmE7IC1fAyxaISzgKDii3VbZC0JszgIaBrHJvo8oxkopyRxNC
         a7fBlUNd55MHh/9Hd0BdVeZ7q8+XKVDnN3BSBTaDRDf8ngN/9xqx15GTdGzwybKMXK
         9uhOcbQ72ekuY+KU5ONED7iyAj82jAGJQcSHTPbUPfD23X3TaiHniiKTbwUiXn6v9y
         hDHwKXOS0jfeX7M7h9W5Fpd66I7MI2xn2YGfiW32kZwovKzPOpzCEEo6QlmxWhs1wU
         UIGgUGYk4JD/bKNu6pmwJT3JXq0wIyg/ukUP3fgh4tOdquoILoNbyMEhIqV+BJwSAa
         p3nOah2vlLRCw==
Message-ID: <fe24d151-6097-aa8e-7691-5e4d81fa42c6@collabora.com>
Date:   Thu, 24 Mar 2022 21:20:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
 <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
 <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com>
 <5be83f0b343c04d877a2c2d805fb5f71ca9973b1.camel@ndufresne.ca>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <5be83f0b343c04d877a2c2d805fb5f71ca9973b1.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 22:21, Nicolas Dufresne wrote:
> Le mercredi 23 mars 2022 à 17:28 +0300, Dmitry Osipenko a écrit :
>> Hi Nicolas,
>>
>> On 3/23/22 16:05, Nicolas Dufresne wrote:
>>> Hi Dmitry,
>>>
>>> thanks for giving a second look a this issue.
>>>
>>> Le mardi 22 mars 2022 à 16:23 +0300, Dmitry Osipenko a écrit :
>>>> Use data offsets provided by applications for multi-planar capture
>>>> buffers. This allows V4L to import and use dma-bufs exported by other
>>>> subsystems in cases where application wants to customize data offsets
>>>> of capture buffers in order to meet hardware alignment requirements of
>>>> both dma-buf exporter and importer.
>>>>
>>>> This feature is wanted for providing a better support of media hardware
>>>> found on Chromebooks. In particular display and camera ISP hardware of
>>>> Rockchip and MediaTek SoCs require special handling by userspace because
>>>> display h/w has specific alignment requirements that don't match default
>>>> alignments expected by V4L and there is a need to customize the data
>>>> offsets in case of multi-planar formats.
>>>>
>>>> Some drivers already have preliminary support for data offsets
>>>> customization of capture buffers, like NVIDIA Tegra video decoder driver
>>>> for example, and V4L allows applications to provide data offsets for
>>>> multi-planar output buffers, let's support such customization for the
>>>> capture buffers as well.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>  Documentation/userspace-api/media/v4l/buffer.rst | 9 ++++++++-
>>>>  drivers/media/common/videobuf2/videobuf2-v4l2.c  | 7 +++++++
>>>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
>>>> index 4638ec64db00..75b1929e2acb 100644
>>>> --- a/Documentation/userspace-api/media/v4l/buffer.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/buffer.rst
>>>> @@ -369,13 +369,20 @@ struct v4l2_plane
>>>>        - ``data_offset``
>>>>        - Offset in bytes to video data in the plane. Drivers must set this
>>>>  	field when ``type`` refers to a capture stream, applications when
>>>> -	it refers to an output stream.
>>>> +	it refers to an output or capture stream.
>>>
>>> There is a clear contradiction in this paragraph. Both the driver and the
>>> application MUST set the data_offset.
>>
>> I'm not sure where the contradiction is. Application must initialize the
>> data_offset and driver must set data_offset too, if it's appropriate to
>> do that for a particular driver.
>>
>>> Would it be possible to demo your idea by implementing this in a virtual driver
>>> ? vivid already have data_offset for capture in some cases, you could verify if
>>> your idea works without any conflict in this scenario.
>>
>> I actually considered implementing it in the vivid driver, but vivid
>> driver already sets the data_offset to fixed values [1], so I decided
>> that not to change it.
>>
>> But maybe we actually could extend the vivid driver by accepting
>> data_offset from userspace for the cases where the fixed offset value is
>> zero in the driver.. not sure.
> 
> The is the core of the issue, how do you represent both a driver use of
> data_offset and a userland provided data_offset at the same time. Contradiction
> might be the wrong term, but minimally there is a large gap in the specification
> for which I don't have an easy answer.

In the doc-comment I said: "Handling of application's offsets is
driver-dependent, application must use the resulting buffer offset."

This can be made stricter using a new
V4L2_BUF_FLAG_USE_CAPTURE_MPLANE_DATA_OFFSET, for example. But then it
doesn't feel good anymore to me because output buffers don't require a
special flag, hence it feels inconsistent.

There is another variant with adding new data_offset fields to the
v4l2_plane_pix_format and then will be possible to set data offsets
using VIDIOC_S_FMT for both S/MPLANEs, assuming that we won't need more
than 3 offsets for SPLANEs. But this is a much more invasive and
questionable UAPI extension.

--- >8 ---
@@ -2268,12 +2268,14 @@ struct v4l2_mpeg_vbi_fmt_ivtv {
  *                     this plane will be used
  * @bytesperline:      distance in bytes between the leftmost pixels in two
  *                     adjacent lines
+ * @data_offset                offset in bytes to the beginning of the
plane's data
  * @reserved:          drivers and applications must zero this array
  */
 struct v4l2_plane_pix_format {
        __u32           sizeimage;
        __u32           bytesperline;
-       __u16           reserved[6];
+       __u32           data_offset[3];
 } __attribute__ ((packed));
--- >8 ---

The root of the problem is that DRM UAPI is more flexible and allows to
customize offsets for both S/MPLANEs, while V4L doesn't allow to do it
at all. I'm exploring all the potential options, so far neither of the
proposed variants is ideal.
