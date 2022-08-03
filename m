Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40D05887B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiHCHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiHCHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:07:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4002A102A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:07:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y23so7628477ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=umnD8l+pmIj3F8d2bI9z4JVgak5mWcgtg1JJ//tmyOE=;
        b=XiDjPDkB2gI+cwSzR3BWx61USQuEAzJUNP2sNOsn+h45GpCSrlW5/w8oHpEZn7m6+9
         IhBmM31jArQbu63iTr4JjcTlgHmD2NtHnbKRhIdEw1SZcAdB7ECP2qSgPtI9M5QBcwX9
         ikohWvYgf80KpTnekm8OcGBd54V8z3el2IfB5nkgaFZCrSnzV9XeJoFN2MSlQfotVHiw
         VZ16+y7PEkZu2+vkE+7sv/QuH2kXNDy0YfedKi+jtGonWBf1mWi3rPnVKZ6/Nb58115H
         lx1svUbKLUVBNfQCK8d73cRLv/oRbxc32idvIPakJi40QHpiRSDnn2Wt3SDjQwcDnn4C
         E+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=umnD8l+pmIj3F8d2bI9z4JVgak5mWcgtg1JJ//tmyOE=;
        b=2wcuRcALH1CenZAdDqLtE/tvduPZsc5pYhXMCj7S/OY2uHoxlmlkhiR3hcqDilhHC0
         I0I4C7Sxm/wwKmy9qBaZ8G4VJ2IXhjUvK2SjlCe4rwbVBhbqEO1GP4UWFD1uS21+WoPv
         sLcfoFW7+ub2k+MGUJAB1y1YLazyHm35DHSyCbvcOoUAmAns0ELTHrlEp18ujXZ0lEtf
         otEIUOD8ezCBPbNyqjirT+4br9VQnRHB3YI5BV4wGVs0Uug2E9nmckmSekN8k6WYMWzu
         e7l+zcWSBDcy+r/gyXBu9hjK0PE80SJGPXzFUDOiNEi6fsSyMJq7rU8OYWTBuhe1czY4
         XWdg==
X-Gm-Message-State: AJIora9RJHMrY+CPnP4JOOXn5BIDRAVOJgNLwcm4M1HMr47gcOZF3bkT
        Kxg65nXxPbDqcIayQ5GK4mYcgg==
X-Google-Smtp-Source: AGRyM1uGNCl2MuIdZQOPWzzztW0K/9EaXwm0cN2z5tM+CjfgRSXB57xopgDH0Hfo79bKEZfmEuz2JA==
X-Received: by 2002:a05:651c:886:b0:25d:64c0:27b1 with SMTP id d6-20020a05651c088600b0025d64c027b1mr8156579ljq.396.1659510439634;
        Wed, 03 Aug 2022 00:07:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k2-20020a2ea262000000b0025d9552fcafsm1676638ljm.97.2022.08.03.00.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:07:19 -0700 (PDT)
Message-ID: <1c75d832-cb9a-3e51-abdb-10d7fb7275bd@linaro.org>
Date:   Wed, 3 Aug 2022 10:07:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/6] drm/msm/dsi: Don't set a load before disabling a
 regulator
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.3.If1f94fbbdb7c1d0fb3961de61483a851ad1971a7@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220802153434.v3.3.If1f94fbbdb7c1d0fb3961de61483a851ad1971a7@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 01:37, Douglas Anderson wrote:
> As of commit 5451781dadf8 ("regulator: core: Only count load for
> enabled consumers"), a load isn't counted for a disabled
> regulator. That means all the code in the DSI driver to specify and
> set loads before disabling a regulator is not actually doing anything
> useful. Let's remove it.
> 
> It should be noted that all of the loads set that were being specified
> were pointless noise anyway. The only use for this number is to pick
> between low power and high power modes of regulators. Regulators
> appear to do this changeover at loads on the order of 10000 uA. You
> would need a lot of clients of the same rail for that 100 uA number to
> count for anything.
> 
> Note that now that we get rid of the setting of the load at disable
> time, we can just set the load once when we first get the regulator
> and then forget it.
> 
> It should also be noted that the regulator functions
> regulator_bulk_enable() and regulator_set_load() already print error
> messages when they encounter problems so while moving things around we
> get rid of some extra error prints.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> Changes in v3:
> - Fix typo in commit message.
> - Just directly call the bulk commands; get rid of the wrapper.
> 
>   drivers/gpu/drm/msm/dsi/dsi.h                 |  1 -
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 52 +++++++-------
>   drivers/gpu/drm/msm/dsi/dsi_host.c            | 71 ++++---------------
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         | 52 ++------------
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    |  4 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    |  6 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c    |  4 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    |  6 +-
>   .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   |  2 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     |  6 +-
>   10 files changed, 60 insertions(+), 144 deletions(-)
> 


-- 
With best wishes
Dmitry
