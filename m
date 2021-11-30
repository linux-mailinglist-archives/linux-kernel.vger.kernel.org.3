Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28BA463647
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhK3ORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbhK3ORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:17:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2565C061748;
        Tue, 30 Nov 2021 06:14:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E41211F45147
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638281661; bh=z92avPrY/qcLPDFYS3uEC/hntI9LLBiS1GNCBUPvwRc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CunOnmX6RnFuxh97PUptAPwb9nVxcYZkXFoO0OC0w0y3iKZkb/Gk5URpbaJhoLCZx
         E1vIVyHwaXhKJ260zg3q+LyR5/Ze7Ec2u2+f14Cx8jDmliYIhR8+g4hxXYFelgIsj+
         R/AdjTiv7UWBbWfDsaq4/+uNnEJw32k8ZFs1DCKNSTc25MbMcmksbHFEtAH5dv3KPB
         8QTCEfNmv+WEKI/qCGk/U8A95Nvm2o/oVSrN8frbPIr+bn8S02lzETx7ZT7qRB4phr
         fHb5oYa+n9vcObvVSargSOG+GtOpXlVx6L87ekpexMrzKG8kuTyJVp7zbLGDcBWfoi
         KolgQbhyM0IEA==
Subject: Re: [PATCH v2 0/2] drm/msm: Fix dsi/bridge probe
To:     robdclark@gmail.com
Cc:     dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, maxime@cerno.tech, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        jami.kettunen@somainline.org
References: <20211130141048.294246-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1a3b307f-5e01-8fa8-67de-2bf0b9f6601f@collabora.com>
Date:   Tue, 30 Nov 2021 15:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130141048.294246-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/11/21 15:10, AngeloGioacchino Del Regno ha scritto:
> Context, from patch 2/2:
> Since commit 8f59ee9a570c ("drm/msm/dsi: Adjust probe order"), the
> DSI host gets initialized earlier, but this caused unability to probe
> the entire stack of components because they all depend on interrupts
> coming from the main `mdss` node (mdp5, or dpu1).
> 
> Series v2:
> After a very nice conversation with Dmitry, it turned out that my first
> approach to solve this issue wasn't great: even though it appeared to
> actually work, it was introducing a number of issues, one of which was
> critical as it was not removing down the DRM device when it's supposed to.
> 
> Instead of actually fixing that patch, I went for "simplifying" the
> approach by not initializing the entire MDSS, but just the interrupt
> controller, which still untangles the infinite probe deferrals, but
> actually doesn't even touch most of the already present logic in place.
> 
> AngeloGioacchino Del Regno (2):
>    drm/msm: Allocate msm_drm_private early and pass it as driver data
>    drm/msm: Initialize MDSS irq domain at probe time
> 
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 16 ++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    |  4 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c   | 50 ++++++++++------
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  3 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c  | 58 +++++++++++++------
>   drivers/gpu/drm/msm/dp/dp_display.c        | 10 +---
>   drivers/gpu/drm/msm/dsi/dsi.c              |  6 +-
>   drivers/gpu/drm/msm/edp/edp.c              |  6 +-
>   drivers/gpu/drm/msm/hdmi/hdmi.c            |  7 +--
>   drivers/gpu/drm/msm/msm_drv.c              | 67 +++++++++++++---------
>   drivers/gpu/drm/msm/msm_kms.h              |  3 +
>   11 files changed, 133 insertions(+), 97 deletions(-)
> 

Dmitry, just as a note: I've obviously dropped your R-b when sending v2
as despite having a very similar title and description, this is, in the end,
a different thing.

Cheers,
- Angelo
