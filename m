Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732ED476260
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhLOT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhLOT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:57:56 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF9BC061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:57:56 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b19so33196001ljr.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xzBRnW091E2hYttdO0EPFhJ6cH97SZxsTkE7s33U1XU=;
        b=Q2astHq+BVkv2Vzv5F6Jicrgstv08rqCGISGYvZkbqqszqIAgWCfeFEkkxulWzaFEX
         tGxPmgR9JbL9EuTp3fWKlyzHuy03tFWz6eSb7Gultp+R2w1dK4+TXJluBeQl8KWn67ax
         Tvs6HtfUOt6CGBWcLYMj7d53/RjOfCGYAIwCwOGLfdorsOycBmxcjF9szZOrAzkoTujq
         ZudgJ5hf44CqIaZQo23qs5tiHVXR6rYaj/sOm8aP8bxM93Pc3Mtqpu27WLL/zyme9uut
         etZmFER6akRkdIZVw06QXlH6BxKk38L319qQ3INexdQB468zOwUAZ0rRiHqzONN941tD
         5Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xzBRnW091E2hYttdO0EPFhJ6cH97SZxsTkE7s33U1XU=;
        b=8BpbsTqfHbR5YEyyvm9cbrShlA8oh3n8oZxGy0G9gMYEcpHKrgolF9h7W6iVCpJMM/
         jEyvSCiCifj9w+vU/y48uW4mf5zQveydQ5/dbPprHGmkltSYG0kmru9IcvszKd6Qvi/7
         oMYmWX+KQVHWHfR5+I8NxZi9+HKDRT0jKjcQGZ2RlxVo0LluaeuXYHX/7oI1H1jqX7f4
         TsCEAwD80i0Rh0ShR+eS9mZn4K/Sc0LhM5XDLhxJGQ1jOX91yCeQyNis4z1U4vIck7tt
         +BP8epaOeJOkSn6XtmdgdJxzXKJ7NBNDNbyre71IP6M5bJqsOYKnUAsxgsvJ9PwzJ0vX
         qkUQ==
X-Gm-Message-State: AOAM531KQpbmaAbyyL8hBYZUOsblGXuldf11qqAJcDPt3BZbECuS4vCa
        Moj+O/4gtbXDDRk99qJQiZ5uhg==
X-Google-Smtp-Source: ABdhPJxdumx8QChUC4wNlRA2hk//MDt1M3tNJWiARcl992IAZ/D8QucGCmYEjmGxyRU6uRxW6Fr3xA==
X-Received: by 2002:a2e:b0ee:: with SMTP id h14mr11902221ljl.478.1639598274332;
        Wed, 15 Dec 2021 11:57:54 -0800 (PST)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u17sm468737lfm.279.2021.12.15.11.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:57:53 -0800 (PST)
Message-ID: <e1e7f91c-fcdb-7789-0094-80e2b5b09d4f@linaro.org>
Date:   Wed, 15 Dec 2021 22:57:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/2] drm/msm/dsi: Use "ref" fw clock instead of global
 name for VCO parent
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>
References: <20210911131922.387964-1-marijn.suijten@somainline.org>
 <20210911131922.387964-2-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20210911131922.387964-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2021 16:19, Marijn Suijten wrote:
> All DSI PHY/PLL drivers were referencing their VCO parent clock by a
> global name, most of which don't exist or have been renamed.  These
> clock drivers seem to function fine without that except the 14nm driver
> for sdm6xx [1].
> 
> At the same time all DTs provide a "ref" clock as per the requirements
> of dsi-phy-common.yaml, but the clock is never used.  This patchset puts
> that clock to use without relying on a global clock name, so that all
> dependencies are explicitly defined in DT (the firmware) in the end.
> 
> Note that this patch intentionally breaks older firmware (DT) that
> relies on the clock to be found globally instead.  The only affected
> platform is msm8974 [2] for whose dsi_phy_28nm a .name="xo" fallback is
> left in place to accommodate a more graceful transition period.  All
> other platforms had the "ref" clock added to their phy node since its
> inception, or in a followup patch some time after.  These patches
> wrongly assumed that the "ref" clock was actively used and have hence
> been listed as "Fixes:" below.
> Furthermore apq8064 was providing the wrong 19.2MHz cxo instead of
> 27MHz pxo clock, which has been addressed in [3].
> 
> It is expected that both [2] and [3] are applied to the tree well in
> advance of this patch such that any actual breakage is extremely
> unlikely, but might still occur if kernel upgrades are performed without
> the DT to match.  After some time the fallback for msm8974 can be
> removed again as well.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/386db1a6-a1cd-3c7d-a88e-dc83f8a1be96@somainline.org/
> [2]: https://lore.kernel.org/linux-arm-msm/20210830175739.143401-1-marijn.suijten@somainline.org/
> [3]: https://lore.kernel.org/linux-arm-msm/20210829203027.276143-2-marijn.suijten@somainline.org/
> 
> Fixes: 79e51645a1dd ("arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY")
> Fixes: 6969d1d9c615 ("ARM: dts: qcom-apq8064: Set 'cxo_board' as ref clock of the DSI PHY")
> Fixes: 0c0e72705a33 ("arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c      | 4 +++-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c      | 4 +++-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c      | 4 +++-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 4 +++-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c       | 4 +++-
>   5 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> index e46b10fc793a..3cbb1f1475e8 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> @@ -562,7 +562,9 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm, struct clk_hw **prov
>   	char clk_name[32], parent[32], vco_name[32];
>   	char parent2[32], parent3[32], parent4[32];
>   	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "ref",
> +		},
>   		.num_parents = 1,
>   		.name = vco_name,
>   		.flags = CLK_IGNORE_UNUSED,
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> index ebedbb6c8961..789b08c24d25 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> @@ -802,7 +802,9 @@ static int pll_14nm_register(struct dsi_pll_14nm *pll_14nm, struct clk_hw **prov
>   {
>   	char clk_name[32], parent[32], vco_name[32];
>   	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "ref",
> +		},
>   		.num_parents = 1,
>   		.name = vco_name,
>   		.flags = CLK_IGNORE_UNUSED,
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> index eb1b8ff61da1..531c4b65aede 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> @@ -521,7 +521,9 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>   {
>   	char clk_name[32], parent1[32], parent2[32], vco_name[32];
>   	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "ref", .name = "xo",
> +		},
>   		.num_parents = 1,
>   		.name = vco_name,
>   		.flags = CLK_IGNORE_UNUSED,
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
> index aaa37456f4ee..9662cb236468 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
> @@ -385,7 +385,9 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>   {
>   	char *clk_name, *parent_name, *vco_name;
>   	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "ref",
> +		},
>   		.num_parents = 1,
>   		.flags = CLK_IGNORE_UNUSED,
>   		.ops = &clk_ops_dsi_pll_28nm_vco,
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> index 9eade6d81a54..1a5abbd9fb76 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -588,7 +588,9 @@ static int pll_7nm_register(struct dsi_pll_7nm *pll_7nm, struct clk_hw **provide
>   	char clk_name[32], parent[32], vco_name[32];
>   	char parent2[32], parent3[32], parent4[32];
>   	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "bi_tcxo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "ref",
> +		},
>   		.num_parents = 1,
>   		.name = vco_name,
>   		.flags = CLK_IGNORE_UNUSED,
> --
> 2.33.0
> 


-- 
With best wishes
Dmitry
