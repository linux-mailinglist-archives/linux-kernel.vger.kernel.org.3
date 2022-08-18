Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEFA59806F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiHRIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiHRIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:54:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7648CA6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:54:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1oObIZ-0001Iu-3G; Thu, 18 Aug 2022 10:54:43 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1oObIU-0008RM-BW; Thu, 18 Aug 2022 10:54:38 +0200
Date:   Thu, 18 Aug 2022 10:54:38 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] drm/msm/a6xx: Ensure CX collapse during gpu
 recovery
Message-ID: <20220818085438.GA29793@pengutronix.de>
References: <1660749261-7602-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220817204224.v4.5.I176567525af2b9439a7e485d0ca130528666a55c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817204224.v4.5.I176567525af2b9439a7e485d0ca130528666a55c@changeid>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akhil,

On Wed, Aug 17, 2022 at 08:44:18PM +0530, Akhil P Oommen wrote:
> Because there could be transient votes from other drivers/tz/hyp which
> may keep the cx gdsc enabled, we should poll until cx gdsc collapses.
> We can use the reset framework to poll for cx gdsc collapse from gpucc
> clk driver.
> 
> This feature requires support from the platform's gpucc driver.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Use reset interface from gpucc driver to poll for cx gdsc collapse
>   https://patchwork.freedesktop.org/series/106860/
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++++
>  drivers/gpu/drm/msm/msm_gpu.c         | 4 ++++
>  drivers/gpu/drm/msm/msm_gpu.h         | 4 ++++
>  3 files changed, 12 insertions(+)
> 
[...]
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 07e55a6..4a57627 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
[...]
> @@ -903,6 +904,9 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  	if (IS_ERR(gpu->gpu_cx))
>  		gpu->gpu_cx = NULL;
>  
> +	gpu->cx_collapse = devm_reset_control_get_optional(&pdev->dev,
> +			"cx_collapse");

Please use devm_reset_control_get_optional_exclusive() instead.

With that,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
