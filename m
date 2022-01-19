Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B92493979
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354092AbiASL2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:28:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiASL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:28:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BB5251F42FBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642591694;
        bh=lb7PPlcJ+GrMTYv/gT1LuwvO/b872pTbvdtVBiWTWtY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FI84BMt5ymarsviUxIfVek2WSCGHenxzSp/V9xEAzp/naQnjWaEE+ph6KJ6URxnyD
         RjALW9mRrRtOVSDRt2UCx+WddhsLIP0AuL8h9bhZ7eTRkJIiGQJzVm1Dsq6uWiqkCH
         qUaCGhR4O6thcK62LABbAbE+uuRBLPvny0QyHADtXFHau/npGxjNZtqUEBGoouI7Xe
         oPsRthgEao7In+tmmKBXwvRYEcs/s1dET5oae7hb4/rfuEvWI4nMFw1IwEeFsm8hyv
         uFxBBCN76vlf16ErqiU2bk7H2nOiPSZb/GkltZyqWBqdeqmuEOO09BOM3Jqb2DkrI/
         yvOQqSY7fAr0g==
Subject: Re: [PATCH v5, 15/15] media: mtk-vcodec: support stateless VP9
 decoding
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220117094001.20049-1-yunfei.dong@mediatek.com>
 <20220117094001.20049-16-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <275affff-12d9-4659-e900-aa9c306e6701@collabora.com>
Date:   Wed, 19 Jan 2022 12:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220117094001.20049-16-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/01/22 10:40, Yunfei Dong ha scritto:
> Add support for VP9 decoding using the stateless API,
> as supported by MT8192. And the drivers is lat and core architecture.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: George Sun <george.sun@mediatek.com>
> ---
>   drivers/media/platform/mtk-vcodec/Makefile    |    1 +
>   .../mtk-vcodec/mtk_vcodec_dec_stateless.c     |   26 +-
>   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |    1 +
>   .../mtk-vcodec/vdec/vdec_vp9_req_lat_if.c     | 1973 +++++++++++++++++
>   .../media/platform/mtk-vcodec/vdec_drv_if.c   |    4 +
>   .../media/platform/mtk-vcodec/vdec_drv_if.h   |    1 +
>   6 files changed, 2003 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_req_lat_if.c
> 

Hello Yunfei,
this driver is based on an older version of the VP9 stateless decoder uAPI,
hence this is not applicable upstream.

The latest linux-next tag (as of today) already contains the new and
accepted code; can you please rebase over that one?

Thanks,
Angelo
