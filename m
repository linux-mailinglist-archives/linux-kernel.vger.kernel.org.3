Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC154F72C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382044AbiFQME4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381795AbiFQMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:04:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DAD6B7DA;
        Fri, 17 Jun 2022 05:04:52 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e] (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57E84660179A;
        Fri, 17 Jun 2022 13:04:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467490;
        bh=9LT9TBmpX+iklRTLTEkirvb5pG6BvIzQn9IYxu2sTaw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NyJ3FZJq1G1P2Gl7/FhAwV7gF4sq+eOFpT62CN+8ZaTweGSe7f/u8//yPqBwvLmyY
         nepzxZmDcbjFrbQSWrRGnx8uxyV+ZK0xB2MRnA172wWAX+kmxk3Rvuwh8C//cpYWwk
         iL4OPgwfYE2uTtDrl3mmlQmrxow4Z4QtGlG8XOG0LfQzf3KTON6BAEMM5EkNZTsfWK
         94+7C0CL+bzU+Jx+faW0V3bqDZKymVLud1zjEjDSFLTqxZ7OGoMePB2SjKz2p6lDNz
         jPlW3YTbxRlLz2gey+pscn0n4ZzXQKoTr34W5lsN0qF1BJfSi7v3ct+J5WcFZC0FUS
         29DL/ZJIr9MIA==
Message-ID: <5ad90377-a9b1-f73a-e15b-ae553202f2a8@collabora.com>
Date:   Fri, 17 Jun 2022 14:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/7] media: hantro: Add 10-bit support
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220616202513.351039-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 16/06/2022 à 22:25, Jernej Skrabec a écrit :
> This series adds support for 10-bit format handling in Hantro driver.
> Most patches adjust postproc behaviour to be more universal. There is
> a lot of assumptions, which need to be replaced with more generalized.
>
> Tested on Allwinner H6. Tested with vp92-2-20-10bit-yuv420.webm sample,
> which produces correct checksum.
>
> Please take a look.

I have send a complementary series to this one to enable 10-bit
for HEVC on Hantro/G2 on IMX8MQ.
With these two patchset I'm able to decode all the 10-bit conformance
test files.

For this series:
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

>
> Best regards,
> Jernej
>
> Changes from RFC:
> - fixed typo in function name
> - removed merged patch (P010 format)
> - removed broken patch (sunxi frequency change)
> - added new patch (media: hantro: postproc: Properly calculate chroma offset)
> - added r-b from Ezequiel
>
> Ezequiel Garcia (1):
>    media: Add P010 tiled format
>
> Jernej Skrabec (6):
>    media: hantro: Support format filtering by depth
>    media: hantro: postproc: Fix buffer size calculation
>    media: hantro: postproc: Fix legacy regs configuration
>    media: hantro: postproc: Properly calculate chroma offset
>    media: hantro: Store VP9 bit depth in context
>    media: hantro: sunxi: Enable 10-bit decoding
>
>   drivers/media/v4l2-core/v4l2-common.c         |  1 +
>   drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>   drivers/staging/media/hantro/hantro.h         |  4 ++
>   drivers/staging/media/hantro/hantro_drv.c     | 23 +++++++++
>   .../staging/media/hantro/hantro_g2_vp9_dec.c  |  8 ---
>   .../staging/media/hantro/hantro_postproc.c    | 38 +++++++++++---
>   drivers/staging/media/hantro/hantro_v4l2.c    | 50 +++++++++++++++++--
>   drivers/staging/media/hantro/hantro_v4l2.h    |  3 ++
>   drivers/staging/media/hantro/sunxi_vpu_hw.c   | 27 ++++++++++
>   include/uapi/linux/videodev2.h                |  1 +
>   10 files changed, 136 insertions(+), 20 deletions(-)
>
