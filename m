Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6C52B7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiERK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiERK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD85B869;
        Wed, 18 May 2022 03:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 188CD61830;
        Wed, 18 May 2022 10:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA72C385A5;
        Wed, 18 May 2022 10:26:27 +0000 (UTC)
Message-ID: <1c1fda82-334a-04ec-fc2e-d1ea2da466e9@xs4all.nl>
Date:   Wed, 18 May 2022 12:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
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
 <fe24d151-6097-aa8e-7691-5e4d81fa42c6@collabora.com>
 <f80128c50d3dacff0af70bd88521abae42476f85.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <f80128c50d3dacff0af70bd88521abae42476f85.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/22 13:32, Nicolas Dufresne wrote:
> Le jeudi 24 mars 2022 à 21:20 +0300, Dmitry Osipenko a écrit :
>> The root of the problem is that DRM UAPI is more flexible and allows to
>> customize offsets for both S/MPLANEs, while V4L doesn't allow to do it
>> at all. I'm exploring all the potential options, so far neither of the
>> proposed variants is ideal.
> 
> In GStreamer kmssink, the way DRM is used, is that if you have 2 planes in your
> pixel format, but only received 1 DMABuf, we will pass this DMABuf twice (well
> GEM handles, but twice), with appropriate offset.
> 
> With this in mind, the idea for V4L2 could be to always resort to MPLANE for
> this purpose. The tricky part for userland is that it needs to know the dual
> pixel format and map that accordingly. That is a bit difficult and this is
> something Helen was trying to address with the v4l2_buffer_ext (that and
> allowing space to store DRM Modifiers in the future).

FYI: here is Helen's last patch series. Since Helen is no longer active in
the media subsystem, someone else who is sufficiently motivated would have to
take over.

https://patchwork.linuxtv.org/project/linux-media/cover/20210114180738.1758707-1-helen.koike@collabora.com/

I'm not enthusiastic about messing with data_offset: it was - in hindsight - a
bad idea.

Regards,

	Hans

> 
> The second challenge is the overhead. In DRM, as we "prime" the DMABuf into
> handles, this gives a kernel object to store any relevant information about the
> buffer. So having it duplicate can be done at no cost. In V4L2, the driver would
> need to handle that more often. Specially that despite the recommendation
> (except for primary buffer decoder, were this is mandatory), we don't force a
> strict DMABuf / Buffer IDX  mapping.
> 
> Nicolas
