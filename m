Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65D5663D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGEHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGEHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:19:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F4A1A8;
        Tue,  5 Jul 2022 00:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D05B5B8162E;
        Tue,  5 Jul 2022 07:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CC6C341C7;
        Tue,  5 Jul 2022 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657005587;
        bh=nBS8lG+9F44KSXw0/0LYCtol2wEliplh73wRQQdVkzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdLrazqr1Ri1IBpqvD8+ADX+FpA1BHrc93abMNaGhGJAhFOhv/RAbjTHKJVcoPx5W
         r7WZaaCzUY3MpCc9O/MejASDMJMRgMW4We5HFMXj2qPon5N6XgrGxpSroHe68S8f7L
         iGp9fOYLl88AYeKA3JzJOAvqNkQakeMurzJEKI96UAtVgBtg3jkwpCBPgcbfHpw3hx
         Q3Sbx7XKcgfyGGvcbcpG/QR4D1zhM3JRYHJN3tgGFJbztAr9qz3OHZedez/mmEL0yh
         Qh63BI5p0PZkuU35ObrseIbaBBGGvp2n6CtchsUAHdeiP5NX7Bh0h6YsOa2wCuelz8
         qVsPeTAW4C7NA==
Date:   Tue, 5 Jul 2022 12:49:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/3] phy: qcom-qmp: add regulator_set_load to dp phy
Message-ID: <YsPmD08mdcgBXwHx@matsya>
References: <1655830891-19025-1-git-send-email-quic_khsieh@quicinc.com>
 <1655830891-19025-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655830891-19025-3-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 10:01, Kuogee Hsieh wrote:
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 43 ++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 893b5a4..df62980 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -604,6 +604,18 @@ static const struct qmp_phy_init_tbl qmp_v4_dp_tx_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TX_EMP_POST1_LVL, 0x20),
>  };
>  
> +

this makes it double blank lines, pls remove

> +/* list of regulators */
> +struct qmp_regulator_data {
> +	const char *name;
> +	unsigned int enable_load;
> +};
> +
> +struct qmp_regulator_data qmp_phy_vreg_l[] = {
> +	{ .name = "vdda-phy", .enable_load = 21800 },
> +	{ .name = "vdda-pll", .enable_load = 36000 },
> +};
> +
>  struct qmp_phy;
>  
>  /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -646,7 +658,7 @@ struct qmp_phy_cfg {
>  	const char * const *reset_list;
>  	int num_resets;
>  	/* regulators to be requested */
> -	const char * const *vreg_list;
> +	const struct qmp_regulator_data *vreg_list;
>  	int num_vregs;
>  
>  	/* array of registers with different offsets */
> @@ -809,11 +821,6 @@ static const char * const sc7180_usb3phy_reset_l[] = {
>  	"phy",
>  };
>  
> -/* list of regulators */
> -static const char * const qmp_phy_vreg_l[] = {
> -	"vdda-phy", "vdda-pll",
> -};
> -
>  static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
>  	.type			= PHY_TYPE_USB3,
>  	.nlanes			= 1,
> @@ -1969,16 +1976,32 @@ static int qcom_qmp_phy_combo_vreg_init(struct device *dev, const struct qmp_phy
>  {
>  	struct qcom_qmp *qmp = dev_get_drvdata(dev);
>  	int num = cfg->num_vregs;
> -	int i;
> +	int ret, i;
>  
>  	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>  	if (!qmp->vregs)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < num; i++)
> -		qmp->vregs[i].supply = cfg->vreg_list[i];
> -
> -	return devm_regulator_bulk_get(dev, num, qmp->vregs);
> +		qmp->vregs[i].supply = cfg->vreg_list[i].name;
> +
> +        ret = devm_regulator_bulk_get(dev, num, qmp->vregs);
> +        if (ret) {
> +                dev_err(dev, "failed at devm_regulator_bulk_get\n");
> +                return ret;
> +        }
> +
> +        for (i = 0; i < num; i++) {
> +                ret = regulator_set_load(qmp->vregs[i].consumer,
> +                                         cfg->vreg_list[i].enable_load);
> +                if (ret) {
> +                        dev_err(dev, "failed to set load at %s\n",
> +                                qmp->vregs[i].supply);
> +                        return ret;
> +                }
> +        }
> +
> +        return 0;

argh!
checkpatch says:
total: 15 errors, 25 warnings, 1 checks, 277 lines checked

Looks like all lines use spaces and not tabs :-(

Pls fix that and resend

-- 
~Vinod
