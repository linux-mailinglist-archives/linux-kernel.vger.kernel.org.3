Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4C4DBCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349719AbiCQCZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiCQCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:25:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8121C910;
        Wed, 16 Mar 2022 19:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6FBDB81D77;
        Thu, 17 Mar 2022 02:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB34C340E9;
        Thu, 17 Mar 2022 02:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647483856;
        bh=Ix1jQ+FTzwE7Py6xt22i052YfsEmKH5ZWqPAWdPOfew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOU9qujVX+uI4/9wMBgvpeASYF6Pp7QCCm7v8rFExMAZYljME4XvGhHrvM8+Lem7q
         dreeq5nCd89J0a1oej6Lz3z0E6cLTph6Fa7Gc0Nm8DCa48vEsk3izsQSCWvvUnirVQ
         oYW3k5XYpC9y+mkIaDGQsdG9Pb6gBdS+weljL0jRp7OwM9vD5sfrISLVQjehrQoY2A
         6+RimgJFqSLbg7rKS/Kvrno9QzEDM1kC3Td2OMrG9mzOj+XJ4CSiHI+AcF72nRjQ4e
         0SaPZfS/oGJwWGDgjLVJvMsXjJtFs8eeuKVLfpmo9AadwgL/RqoVOhwsG04c99WOTt
         Fd+wbtdwqIQQw==
Date:   Thu, 17 Mar 2022 10:24:11 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
        aaronyu@google.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 1/5] ASoC: mediatek: mt8195: merge machine driver
Message-ID: <YjKby/RYpMtcxeUm@google.com>
References: <20220316060139.6211-1-trevor.wu@mediatek.com>
 <20220316060139.6211-2-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316060139.6211-2-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I didn't review too many details because I found the patch is not easy to
review.  Please consider to not reorder symbols if it can.  If it is still
hard to generate reasonable chunks or the reorders are necessary, it could
put some refactor patches prior to the "merge".

On Wed, Mar 16, 2022 at 02:01:35PM +0800, Trevor Wu wrote:
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
[...]
>  #include <linux/input.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <sound/jack.h>
>  #include <sound/pcm_params.h>
>  #include <sound/rt5682.h>
> -#include <sound/sof.h>

Why does it remove the header?

> +struct mt8195_mt6359_priv {
> +	struct snd_soc_jack headset_jack;
> +	struct snd_soc_jack dp_jack;
> +	struct snd_soc_jack hdmi_jack;
> +	struct clk *i2so1_mclk;
> +};
> +
> +struct mt8195_card_data {
> +	const char *name;
> +	unsigned long quirk;
> +};
> +
> +struct sof_conn_stream {
> +	const char *normal_link;
> +	const char *sof_link;
> +	const char *sof_dma;
> +	int stream_dir;
> +};
[...]
> -struct sof_conn_stream {
> -	const char *normal_link;
> -	const char *sof_link;
> -	const char *sof_dma;
> -	int stream_dir;
> -};
> -
> -struct mt8195_mt6359_rt1019_rt5682_priv {
> -	struct snd_soc_jack headset_jack;
> -	struct snd_soc_jack dp_jack;
> -	struct snd_soc_jack hdmi_jack;
> -	struct clk *i2so1_mclk;
> -};

The effective operation here: rename from mt8195_mt6359_rt1019_rt5682_priv
to mt8195_mt6359_priv.  However, it somehow reorders the code.  As a result,
the change looks like more complicated than just a "merge" operation.

> -static const struct snd_soc_dapm_route mt8195_mt6359_rt1019_rt5682_routes[] = {
> -	/* speaker */
> -	{ "Speakers", NULL, "Speaker" },
> +static const struct snd_kcontrol_new mt8195_mt6359_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +};
> +
> +static const struct snd_soc_dapm_route mt8195_mt6359_routes[] = {
>  	/* headset */
>  	{ "Headphone Jack", NULL, "HPOL" },
>  	{ "Headphone Jack", NULL, "HPOR" },
> @@ -80,55 +94,31 @@ static const struct snd_soc_dapm_route mt8195_mt6359_rt1019_rt5682_routes[] = {
>  	{"I021", NULL, SOF_DMA_DL3},
>  };
>  
> -static const struct snd_kcontrol_new mt8195_mt6359_rt1019_rt5682_controls[] = {
> -	SOC_DAPM_PIN_SWITCH("Speakers"),
> -	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
> -	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +static const struct snd_soc_dapm_widget mt8195_dual_speaker_widgets[] = {
> +	SND_SOC_DAPM_SPK("Left Speaker", NULL),
> +	SND_SOC_DAPM_SPK("Right Speaker", NULL),
>  };
>  
> -static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
> -					struct snd_pcm_hw_params *params)
> -{
[...]
> +static const struct snd_kcontrol_new mt8195_dual_speaker_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Left Speaker"),
> +	SOC_DAPM_PIN_SWITCH("Right Speaker"),
> +};

Ditto.  I would expect it only renames and adds something.  However, if you
look at the block and the following, it looks like changed a lot.

> @@ -143,20 +133,20 @@ static int mt8195_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>  	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
>  	struct mt8195_afe_private *afe_priv = afe->platform_priv;
>  	struct mtkaif_param *param = &afe_priv->mtkaif_params;
> -	int phase;
> -	unsigned int monitor;
> -	int mtkaif_calibration_num_phase;
> +	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
> +	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
>  	int test_done_1, test_done_2, test_done_3;
>  	int cycle_1, cycle_2, cycle_3;
> -	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
> -	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
> -	int counter;
> -	bool mtkaif_calibration_ok;
>  	int mtkaif_chosen_phase[MT8195_MTKAIF_MISO_NUM];
>  	int mtkaif_phase_cycle[MT8195_MTKAIF_MISO_NUM];
> +	int mtkaif_calibration_num_phase;
> +	bool mtkaif_calibration_ok;
> +	unsigned int monitor;
> +	int counter;
> +	int phase;
>  	int i;

The reorder of variable declaration is irrelevant to the patch.  Drop them.
If it has good reason to do so, send another patch for the purpose.

> @@ -513,7 +446,7 @@ static int mt8195_playback_startup(struct snd_pcm_substream *substream)
>  	return 0;
>  }
>  
> -static const struct snd_soc_ops mt8195_playback_ops = {
> +const struct snd_soc_ops mt8195_playback_ops = {
>  	.startup = mt8195_playback_startup,

Why does it remove the `static`?

> +static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
>  {
[...]
> +	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
> +	if (!match || !match->data)
> +		return -EINVAL;
> +
> +	card_data = (struct mt8195_card_data *)match->data;

Use of_device_get_match_data().

> -static const struct dev_pm_ops mt8195_mt6359_rt1019_rt5682_pm_ops = {
> +const struct dev_pm_ops mt8195_mt6359_pm_ops = {
>  	.poweroff = snd_soc_poweroff,
>  	.restore = snd_soc_resume,
>  };

Why does it remove the `static`?
