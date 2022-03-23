Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030504E543D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbiCWOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiCWOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:30:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C0260EC;
        Wed, 23 Mar 2022 07:28:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 5333C1F44CF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648045708;
        bh=uTVCR5ZdpxUM6s7MkLUaYHnuhsua3Eu575U/P4M4DTk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ooQiBjlAl+SB8sdeVy7w5cNkGkuz8W4WURWbiON3uHiEyZLEVvv/SBJIFfQ3sLroY
         JMK4FVfb1AuJTJyHc7e9VifJ+Iuf0XBLMrgt8TKdE1zzEW3/+L0DSiPe3X0X7f2WdI
         /19ZuRsmqtiPF8mH8uYbFUWq6skILrpgpHxmJvJ7+NyHZcBqvBKxUu690GGhAbo9hj
         4OwfftyZXRJ8Pp7tVc39mADFY+QEDENdtslHU9LV1TYVqrwPyRtJXM9O4HcLKMsX8m
         QQsryjNDuVByheFDU8ZE4agGdg+Ivm37XE4Jkz13EAE33N5j2xa9k4Nij60zQySPLP
         n5AIzuk0YKSng==
Message-ID: <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com>
Date:   Wed, 23 Mar 2022 17:28:24 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 3/23/22 16:05, Nicolas Dufresne wrote:
> Hi Dmitry,
> 
> thanks for giving a second look a this issue.
> 
> Le mardi 22 mars 2022 à 16:23 +0300, Dmitry Osipenko a écrit :
>> Use data offsets provided by applications for multi-planar capture
>> buffers. This allows V4L to import and use dma-bufs exported by other
>> subsystems in cases where application wants to customize data offsets
>> of capture buffers in order to meet hardware alignment requirements of
>> both dma-buf exporter and importer.
>>
>> This feature is wanted for providing a better support of media hardware
>> found on Chromebooks. In particular display and camera ISP hardware of
>> Rockchip and MediaTek SoCs require special handling by userspace because
>> display h/w has specific alignment requirements that don't match default
>> alignments expected by V4L and there is a need to customize the data
>> offsets in case of multi-planar formats.
>>
>> Some drivers already have preliminary support for data offsets
>> customization of capture buffers, like NVIDIA Tegra video decoder driver
>> for example, and V4L allows applications to provide data offsets for
>> multi-planar output buffers, let's support such customization for the
>> capture buffers as well.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  Documentation/userspace-api/media/v4l/buffer.rst | 9 ++++++++-
>>  drivers/media/common/videobuf2/videobuf2-v4l2.c  | 7 +++++++
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
>> index 4638ec64db00..75b1929e2acb 100644
>> --- a/Documentation/userspace-api/media/v4l/buffer.rst
>> +++ b/Documentation/userspace-api/media/v4l/buffer.rst
>> @@ -369,13 +369,20 @@ struct v4l2_plane
>>        - ``data_offset``
>>        - Offset in bytes to video data in the plane. Drivers must set this
>>  	field when ``type`` refers to a capture stream, applications when
>> -	it refers to an output stream.
>> +	it refers to an output or capture stream.
> 
> There is a clear contradiction in this paragraph. Both the driver and the
> application MUST set the data_offset.

I'm not sure where the contradiction is. Application must initialize the
data_offset and driver must set data_offset too, if it's appropriate to
do that for a particular driver.

> Would it be possible to demo your idea by implementing this in a virtual driver
> ? vivid already have data_offset for capture in some cases, you could verify if
> your idea works without any conflict in this scenario.

I actually considered implementing it in the vivid driver, but vivid
driver already sets the data_offset to fixed values [1], so I decided
that not to change it.

But maybe we actually could extend the vivid driver by accepting
data_offset from userspace for the cases where the fixed offset value is
zero in the driver.. not sure.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/media/test-drivers/vivid/vivid-vid-cap.c#L172

I verified my idea using the NVIDIA Tegra video decoder driver, which
already takes data_offsets for capture planes [3] and libvdpau-tegra
imports DRM dma-bufs into the V4L driver [4][5].

[3]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/media/platform/nvidia/tegra-vde/v4l2.c#n236
[4]
https://github.com/grate-driver/libvdpau-tegra/blob/master/src/decoder.c#L685
[5]
https://github.com/grate-driver/libvdpau-tegra/blob/master/src/v4l2.c#L359

The plan is to extend RK ISP driver with support of data_offsets next,
once we'll agree that this acceptable approach and we don't actually
need go back to implementing the new VIDIOC_EXT_QBUF ioctl [6].

[6]
https://patchwork.linuxtv.org/project/linux-media/cover/20210114180738.1758707-1-helen.koike@collabora.com/

This patch solves the problem for userspace when it wants to import
buffers into V4L in case of multi-planar formats, but it doesn't cover
all other possible cases that may require offsets customization too. On
the other hand, it's easy to start accepting data_offset for the capture
MPLANES without introducing new UAPIs, so I decided that will be best to
start easy with the simplest solution.
