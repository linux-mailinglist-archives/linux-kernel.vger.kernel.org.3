Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F952D062
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiESKWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiESKWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:22:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DEC49925;
        Thu, 19 May 2022 03:22:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 4DE7D1F45A25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652955762;
        bh=R0JOHH16vdw7dxb0Uon4A7HZbfdfttE9NlpiqAveo/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dr6VEg8eUZL4lOg2f7qxCQ6uM3ykZdOJfOJG+9F3ufmOzHC3VG/lqvrFyDmXcGDGm
         wQ11Amugo8ecPHuAT4n8X084mUILIClzfTmZGgCdsEuv+zaP8xAbErHvAcr97UoeyX
         74d34MIVic5XsAut/WWMIZvKuvEAbreMJafGlJtXfsCmCF2Rl8qtVSfkQJjn3LsitQ
         2+nr0e0Bi89ZcKDIHOakTShvWpYWNAxN1RiweKl0LPiZXRObHAxjm3V7NojGgMa+2p
         PwaePMdyCC+GIBhHvC3cHScL2NkM+MN+IknWl+2d+i0V4pf8/hY3ymp0UHN2UhaoBK
         tkbTUXOCu7wcA==
Message-ID: <11bd51f2-ca35-4e01-95e9-ad35b37f26d8@collabora.com>
Date:   Thu, 19 May 2022 13:22:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
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
 <1c1fda82-334a-04ec-fc2e-d1ea2da466e9@xs4all.nl>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1c1fda82-334a-04ec-fc2e-d1ea2da466e9@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On 5/18/22 13:26, Hans Verkuil wrote:
> 
> 
> On 3/25/22 13:32, Nicolas Dufresne wrote:
>> Le jeudi 24 mars 2022 à 21:20 +0300, Dmitry Osipenko a écrit :
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
> 
> FYI: here is Helen's last patch series. Since Helen is no longer active in
> the media subsystem, someone else who is sufficiently motivated would have to
> take over.
> 
> https://patchwork.linuxtv.org/project/linux-media/cover/20210114180738.1758707-1-helen.koike@collabora.com/
> 
> I'm not enthusiastic about messing with data_offset: it was - in hindsight - a
> bad idea.

I'm aware of the Helen's work. To me the addition of the new IOCTLs that
partially duplicate the older ones doesn't feel like the best approach.
But since you're good with it, then I'll try to refresh the Helen's work
for 5.20 and we'll see where it will go.

-- 
Best regards,
Dmitry
