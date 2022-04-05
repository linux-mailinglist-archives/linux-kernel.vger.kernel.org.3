Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF54F4377
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383204AbiDEUFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457546AbiDEQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:09:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85A25CD;
        Tue,  5 Apr 2022 09:07:46 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:cf29:3f0:be4d:7211] (unknown [IPv6:2a01:e0a:120:3210:cf29:3f0:be4d:7211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 511F61F43BDC;
        Tue,  5 Apr 2022 17:07:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649174864;
        bh=Y7AMfmbF+pTW6heGBBOtMSPe72VwTuirLOp6bmUM2l8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YdiGwf54xZ2SQaL3Kg7d0z6H9yFy3jkfu5wqfmvXDG3Yoo43FV4nvSf8M7bozm3vQ
         VVZW2A3dSj2jG45xLSvt3K2OZwoa/XmIf31XNDejfWFZ4JEAtRNyxWjl7M38ydvyLK
         B/ELY4LHhInWRfNGtOqjHaytIuFg5ccxSSMzxTDcelnc1USAD0Ay5gysapFchtZ19D
         tGy4YnI0AxLEchVvhSDflRaVbn8ISxd+soOSaX/Bu+cTN4ObX5nvsybHapgxlzoCdJ
         vr+c8fj31gKs28+vpiZDH/FzwrxgFzYoJ41xyTDKpuPMLsqRupBjcVQjMZTf6IQroH
         vvGU7AI/NHllA==
Message-ID: <b6987a9a-56af-f63f-b60a-37df141d6e89@collabora.com>
Date:   Tue, 5 Apr 2022 18:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/8] media: hantro: Add 10-bit support
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/02/2022 à 15:49, Jernej Skrabec a écrit :
> First two patches add 10-bit formats to UAPI, third extends filtering
> mechanism, fourth fixes incorrect assumption, fifth moves register
> configuration code to proper place, sixth and seventh enable 10-bit
> VP9 decoding on Allwinner H6 and last increases core frequency on
> Allwinner H6.
>
> I'm sending this as RFC to get some comments:
> 1. format definitions - are fourcc's ok? are comments/descriptions ok?
> 2. is extended filtering mechanism ok?
>
> I would also like if these patches are tested on some more HW.
> Additionally, can someone test tiled P010?
>
> Please take a look.

Hi Jernej,

I have create a branch to test this series with VP9 and HEVC:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/10bit_imx8m
Feel free to pick what I may need in it.

That doesn't improve fluster scores, I think more dev are still needed in GST
before getting something fully functional.
Anyway I able to select P010 pixel format if the input is a 10bit bitstream.

Regards,
Benjamin

>
> Best regards,
> Jernej
>
> Ezequiel Garcia (1):
>    media: Add P010 tiled format
>
> Jernej Skrabec (7):
>    media: Add P010 format
>    media: hantro: Support format filtering by depth
>    media: hantro: postproc: Fix buffer size calculation
>    media: hantro: postproc: Fix legacy regs configuration
>    media: hantro: Store VP9 bit depth in context
>    media: hantro: sunxi: Enable 10-bit decoding
>    media: hantro: sunxi: Increase frequency
>
>   drivers/media/v4l2-core/v4l2-common.c         |  3 ++
>   drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
>   drivers/staging/media/hantro/hantro.h         |  4 ++
>   drivers/staging/media/hantro/hantro_drv.c     | 23 +++++++++
>   .../staging/media/hantro/hantro_g2_vp9_dec.c  |  8 ---
>   .../staging/media/hantro/hantro_postproc.c    | 34 ++++++++++---
>   drivers/staging/media/hantro/hantro_v4l2.c    | 50 +++++++++++++++++--
>   drivers/staging/media/hantro/hantro_v4l2.h    |  3 ++
>   drivers/staging/media/hantro/sunxi_vpu_hw.c   | 13 ++++-
>   include/uapi/linux/videodev2.h                |  2 +
>   10 files changed, 122 insertions(+), 20 deletions(-)
>
