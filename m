Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561E35887CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiHCHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiHCHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:19:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E2F175A3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:19:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so18003945ljl.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9qWosSLXhyptc60Y7AzA5SZJpqZuA+8KmqVAtrjeBq8=;
        b=ZzSM1bueO0NTpO74C+tO6GnDLLj76TrW+4XYe3o5ZiCcjdQrcc8xG75ruStb6Qp2NB
         ol/HnraOGLcStmk1KS86MLbDyA2HxMEM+MHqXtKkNX0rkS+X7NC1e0Hv9PevITZk+tlc
         6iHUTeyK0IvfE1qxrdUo04QloDRZ8McSS6NeEp4XsmHJUXbm9LakYizL3be2SvyYosl5
         Gjh23j7NYHcCibZdpNuQkazLuXP5FcGAKrylYVl3jawBv5l10s9Dvp3Qrn9rmkKI2GI8
         xTVw5d+pRy0y/aqTQG59x4dQGIPwVGENSGb6gIEgCUJ/Cmdy+mFVeKrj1GveyN2+oKFW
         K4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9qWosSLXhyptc60Y7AzA5SZJpqZuA+8KmqVAtrjeBq8=;
        b=MH7op9jcvMlt4zKmI7BVcgC0k6M1yje++yas8JWOsRRhl/ejqokPF8qGzjkdiZ/nOV
         M4kfKsbKDrbWmy8fAbHpAOViPnPvE2NFacTzbXY34qJe6Mm95zad/+RgZeYsgNKAXiPO
         O68r30UjebhpgfwIAOTuab1HEOU8afQ96uWJA/5lE9Hkw5Tj+Tm0+U3j8BzqEzuou/9x
         /q6BWD4KZ6R6zz2lB21kMpx+f9CZmbDaHBuL+rwhYas8vKeMRctkJlMrxRYgdiOwpumc
         OwtMD0YnCqr5jvVi62FTIuwA1RzGTDojNeIyHjOMUf8Q/0uwS9OI/bG6HgQOlPt5eAcO
         qu8A==
X-Gm-Message-State: ACgBeo3LkQNLVgKfFN0OEsOUBBKus1z2tM49QiZ8u0RAaa30LBt9cxs4
        Nif7ewbHYdIjAbwFeEfMjygV5w==
X-Google-Smtp-Source: AA6agR4m8eXNXB/epkX5NIGw5gtrqihlWFLmZBQ/K5mkZcX5VyNEOs/67u0bqyznWFTBGERH32dlog==
X-Received: by 2002:a05:651c:905:b0:25e:67a8:4dd0 with SMTP id e5-20020a05651c090500b0025e67a84dd0mr1396572ljq.232.1659511138894;
        Wed, 03 Aug 2022 00:18:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v5-20020a2ea605000000b0025dd5b3fabesm2119728ljp.102.2022.08.03.00.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:18:58 -0700 (PDT)
Message-ID: <228e5e34-6467-a75b-129d-2b37b32acf13@linaro.org>
Date:   Wed, 3 Aug 2022 10:18:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/6] drm/msm/dsi: Take advantage of
 devm_regulator_bulk_get_const()
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.5.I55a9e65cb1c22221316629e98768ff473f47a067@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220802153434.v3.5.I55a9e65cb1c22221316629e98768ff473f47a067@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 01:37, Douglas Anderson wrote:
> As of the commit 1de452a0edda ("regulator: core: Allow drivers to
> define their init data as const") we no longer need to do copying of
> regulator bulk data from initdata to something dynamic. Let's take
> advantage of that.
> 
> In addition to saving some code, this also moves us to using
> ARRAY_SIZE() to specify how many regulators we have which is less
> error prone.
> 
> This gets rid of some layers of wrappers which makes it obvious that
> we can get rid of an extra error print.
> devm_regulator_bulk_get_const() prints errors for you so you don't
> need an extra layer of printing.
> 
> In all cases here I have preserved the old settings without any
> investigation about whether the loads being set are sensible. In the
> cases of some of the PHYs if several PHYs in the same file used
> exactly the same settings I had them point to the same data structure.
> 
> NOTE: Though I haven't done the math, this is likely an overall
> savings in terms of "static const" data. We previously always
> allocated space for 8 supplies. Each of these supplies took up 36
> bytes of data (32 for name, 4 for an int).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Ah, so to array conversion is already done. That's great.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
> 
> Changes in v3:
> - Do all the PHYs too.

It would have been easier if DSI and DSI PHY were split to separate patches.

> - Get rid of error print after devm_regulator_bulk_get_const().
> - Just directly call the bulk commands; get rid of the wrapper.
> - Update commit message to point at the git hash of the regulator change.
> 
> Changes in v2:
> - ("Take advantage of devm_regulator_bulk_get_const") new for v2.
> 
>   drivers/gpu/drm/msm/dsi/dsi.h                 |  12 --
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 172 +++++++++---------
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h             |   3 +-
>   drivers/gpu/drm/msm/dsi/dsi_host.c            |  42 ++---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |  37 +---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |   5 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    |  20 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    |  32 ++--
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c    |  14 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    |  28 +--
>   .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   |  12 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     |  32 ++--
>   12 files changed, 167 insertions(+), 242 deletions(-)

-- 
With best wishes
Dmitry
