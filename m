Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D0B588EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiHCOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHCOZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:25:20 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B333616B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:25:18 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9E6521F5C9;
        Wed,  3 Aug 2022 16:25:14 +0200 (CEST)
Date:   Wed, 3 Aug 2022 16:25:12 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] drm/msm/dsi: Fix number of regulators for SDM660
Message-ID: <20220803142512.f5d2umiymqwbxfzt@SoMainline.org>
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.2.I94b3c3e412b7c208061349f05659e126483171b1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802153434.v3.2.I94b3c3e412b7c208061349f05659e126483171b1@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-02 15:37:34, Douglas Anderson wrote:
> 1 regulators is specified listed but the number 2 is specified. This
> presumably means we try to get a regulator with no name. Fix it.
> 
> Fixes: 033f47f7f121 ("drm/msm/dsi: Add DSI configuration for SDM660")

This should be:

Fixes: 462f7017a691 ("drm/msm/dsi: Fix DSI and DSI PHY regulator config from SDM660")

The original patch included two regulators; that "fix" patch removed
"vdd".

After that:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - ("Fix number of regulators for SDM660") new for v2.
> 
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 02000a7b7a18..72c018e26f47 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -148,7 +148,7 @@ static const char * const dsi_sdm660_bus_clk_names[] = {
>  static const struct msm_dsi_config sdm660_dsi_cfg = {
>  	.io_offset = DSI_6G_REG_SHIFT,
>  	.reg_cfg = {
> -		.num = 2,
> +		.num = 1,
>  		.regs = {
>  			{"vdda", 12560, 4 },	/* 1.2 V */
>  		},
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
