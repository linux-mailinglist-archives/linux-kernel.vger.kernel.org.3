Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0850C488
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiDVXMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiDVXK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:10:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B2CA0FC;
        Fri, 22 Apr 2022 15:50:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 0C79E1F46BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650667808;
        bh=L6RAxxyxxLpHhLGcPBmYtZ/tE9DimItHz6GaN0DngLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fcXzbLCDoHgYhKXjc2pQmObm+ibrAt4vIRZBwfC71DKGxl0MsT0TTUeS7ytCjCT73
         v57tjh2mrfrASYalN8TBzU1mBrm1gT5xVNy/veTRLGDEnftCtHbT3kPaU0Bj8LYEIX
         NTXMDtLjyeAZach/OXp/JQNGwrrKJ4MyBJHhCkCxiad/EvOWCponlEN1tUrekQjtFT
         gtZmHOWJa122J4CIpsHt98Y5dxH073wKEDQoNDx6x5lSYfW1Qq4jR7Nyda9b9FSyQy
         +gV10uRIrRx+06blynB23rpRTm/2dsjHEyxymMXxxBk2UQ22ToPXI0t73M13uZklGf
         hoZfBJSHUvNcw==
Message-ID: <ad030c70-19eb-ce15-5a78-4c04450b7ad3@collabora.com>
Date:   Sat, 23 Apr 2022 01:50:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
Content-Language: en-US
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
 <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
 <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com>
 <5be83f0b343c04d877a2c2d805fb5f71ca9973b1.camel@ndufresne.ca>
 <fe24d151-6097-aa8e-7691-5e4d81fa42c6@collabora.com>
 <f80128c50d3dacff0af70bd88521abae42476f85.camel@ndufresne.ca>
 <CAPY8ntBQBrWytYRbv50F-4TZJdCaSQs86r3vY6kJdp+oc6SxEQ@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAPY8ntBQBrWytYRbv50F-4TZJdCaSQs86r3vY6kJdp+oc6SxEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 16:11, Dave Stevenson wrote:
> Hi Nicolas & Dmitry
> 
> On Fri, 25 Mar 2022 at 12:32, Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>
>> Le jeudi 24 mars 2022 à 21:20 +0300, Dmitry Osipenko a écrit :
>>> The root of the problem is that DRM UAPI is more flexible and allows to
>>> customize offsets for both S/MPLANEs, while V4L doesn't allow to do it
>>> at all. I'm exploring all the potential options, so far neither of the
>>> proposed variants is ideal.
>>
>> In GStreamer kmssink, the way DRM is used, is that if you have 2 planes in your
>> pixel format, but only received 1 DMABuf, we will pass this DMABuf twice (well
>> GEM handles, but twice), with appropriate offset.
>>
>> With this in mind, the idea for V4L2 could be to always resort to MPLANE for
>> this purpose. The tricky part for userland is that it needs to know the dual
>> pixel format and map that accordingly. That is a bit difficult and this is
>> something Helen was trying to address with the v4l2_buffer_ext (that and
>> allowing space to store DRM Modifiers in the future).
>>
>> The second challenge is the overhead. In DRM, as we "prime" the DMABuf into
>> handles, this gives a kernel object to store any relevant information about the
>> buffer. So having it duplicate can be done at no cost. In V4L2, the driver would
>> need to handle that more often. Specially that despite the recommendation
>> (except for primary buffer decoder, were this is mandatory), we don't force a
>> strict DMABuf / Buffer IDX  mapping.
> 
> To throw another use case of data offsets into the mix, I'm keeping a
> watching eye on implementing stereoscopic capture into libcamera where
> we want to present the same buffer to the ISP twice (once for each
> eye) with either a vertical or horizontal offset between the two
> passes.
> Adding a data_offset of either a half line or half the frame is the
> easiest way around that one, although it could potentially be
> accommodated through the selection API setting a compose region
> instead.

Hi Dave,

Thank you for the suggestion about the stereoscopic capture! If you'll
manage to test this patch and it will work for you, then please feel
free to give yours tested-by.

I'll need to do couple extra checks to ensure that we really need this
new feature for the Chromebooks, this will take time. But if you'll be
able to confirm that this variant of the patch works for yours case with
the stereo cams, then we may try to proceed using the current variant
right away.

