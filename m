Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37E474729
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhLNQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:10:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51376 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhLNQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:10:01 -0500
Received: from [IPv6:2a01:e0a:120:3210:f73a:96cd:3d21:2902] (unknown [IPv6:2a01:e0a:120:3210:f73a:96cd:3d21:2902])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 27C701F44EA6;
        Tue, 14 Dec 2021 16:10:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639498200; bh=0na2KJPuzWMG6eYK4qSPTD/w3/gdNZ7kdgsr3GSXzdU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ohYUrkaSZv9wDQny19TkMRXpVyVGolydugIR7zU1CZDeAdnuDRVgL6DhlWA1gBW4p
         FxBPSLi+dad6DSNgRC+QoLlLMgIizXYfr/PQTd2DSGED6b3nFjGTdfZEs/1JB+6msD
         NXGimpMuA9mWUE7B5JD1rolG4Va3I5gmrhnPB2FKCmvWPs5uy7bTg5sHY+GQMiyG8m
         iMW0DVDSv1xZ55gtH6icBjgRDO2XnT7zlxZW4zW7ku+8LEg2fbuKoVMmT1luwjW1tT
         oqrxXYtFi6Xksx7Rah662pKB5ArKUp/6NqSaqy6m3r2k95BG8nmP1NScfJAPd6etMl
         b5KEgVkComhag==
Subject: Re: [PATCH v3 0/4] media: HEVC: RPS clean up
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20211125155650.630977-1-benjamin.gaignard@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <3887bbab-b9e6-6147-5147-bad507065484@collabora.com>
Date:   Tue, 14 Dec 2021 17:09:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125155650.630977-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 25/11/2021 à 16:56, Benjamin Gaignard a écrit :
> This series aims to clean up Reference Picture Set usage and flags.
>
> Long term flag was named with RPS prefix while it is not used for RPS
> but for mark long term references in DBP. Remane it and remove the two
> other useless RPS flags.
>
> Clarify documentation about RPS lists content and make sure that Hantro
> driver use them correctly (i.e without look up in DBP).

Dear reviewers,
this series is waiting for feedback ;-)

Thanks lot for your time.
Benjamin

>
> version 3:
> - rebased on top of v5.16-rc1
>
> version 2:
> - change DPB field name from rps to flags
>
> Please note that the only purpose of commits 3 and 4 is to allow to test
> G2 hardware block for IMX8MQ until a proper solution isuing power domain
> can be found. Do not merge them.
>
> GStreamer HEVC plugin merge request can be found here:
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079
>
> With those piece of code fluster score is 77/147.
>
> Benjamin Gaignard (4):
>    media: hevc: Remove RPS named flags
>    media: hevc: Embedded indexes in RPS
>    media: hantro: Use syscon instead of 'ctrl' register
>    arm64: dts: imx8mq: Add node to G2 hardware
>
>   .../media/v4l/ext-ctrls-codec.rst             | 14 +++---
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 43 +++++++++++++----
>   drivers/staging/media/hantro/hantro.h         |  5 +-
>   .../staging/media/hantro/hantro_g2_hevc_dec.c | 27 +++--------
>   drivers/staging/media/hantro/imx8m_vpu_hw.c   | 48 ++++++++++++-------
>   .../staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
>   include/media/hevc-ctrls.h                    |  6 +--
>   7 files changed, 84 insertions(+), 61 deletions(-)
>
