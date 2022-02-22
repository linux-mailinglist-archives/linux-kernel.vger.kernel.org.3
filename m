Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C327E4C0283
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiBVT4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiBVTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:55:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD2C5D9F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559732; x=1677095732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fb9LNxAZehNZGlRVuozFIeYkxpG6Ih/D1zN47x3V20E=;
  b=jPJGC32XKZTSx+ESXoB20tBvxwijPfJxJjb/mxf1pcmMvFcqcSyEEzfh
   fi5zz/HlGu0+D2D1OU/xcGNFtY/xVJHRrThh31IAAKejOexHTrSCbe0aI
   TBu+nEkO8DcCZXhqNpW4vO3uFzujfBfsqbJgT0FIkxPMez9OUHpTwB7LL
   8mzGLcnz6Z99GHaoMxtYJtlVJA6791NnUCVco9WkkZZzo/8D3D8DuMrP9
   dojYME7uOs62OlOD8qfgmIo7KhfsKUzJ1Jl2Erv5fAryVxGQgC/1d4DIQ
   5GMTTeFe3W+dHNvccKQzvYxS4X8678jotxAXUJ9yWN/21ab1Os0B0Ky3e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231772637"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231772637"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:55:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="639032076"
Received: from mjpatel-mobl.amr.corp.intel.com (HELO [10.212.37.223]) ([10.212.37.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:55:19 -0800
Message-ID: <a2a6f631-b1b6-e015-f6bd-0c3851fdaa83@linux.intel.com>
Date:   Tue, 22 Feb 2022 13:53:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/10] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        quic_srivasam@quicinc.com
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
 <20220221131037.8809-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220221131037.8809-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/22 07:10, Srinivas Kandagatla wrote:
> WSA881x codecs can not cope up with clk stop and requires a full reset after suspend.

isn't clock stop mode0 a peripheral requirement in SoundWire 1.x? I
don't see any permission to skip this mode, the only thing I see in the
spec is the permission to implement an always-ready capability (SCSP_SM)

The current assumption is that ALL peripherals support that mode, but
that Managers may or may not support clock stop.

It wouldn't be a big deal to add a quirk, but IMHO this needs to be
captured at the bus/manager level since the decision to enter this mode
is made at that level.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/wsa881x.c | 54 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index 0222370ff95d..d851ba14fbdd 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
>  #include <linux/soundwire/sdw_type.h>
> @@ -198,6 +199,7 @@
>  #define WSA881X_OCP_CTL_TIMER_SEC 2
>  #define WSA881X_OCP_CTL_TEMP_CELSIUS 25
>  #define WSA881X_OCP_CTL_POLL_TIMER_SEC 60
> +#define WSA881X_PROBE_TIMEOUT 1000
>  
>  #define WSA881X_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
>  {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
> @@ -747,6 +749,12 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
>  	unsigned int mask = (1 << fls(max)) - 1;
>  	int val, ret, min_gain, max_gain;
>  
> +	ret = pm_runtime_get_sync(comp->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(comp->dev);
> +		return ret;
> +	}
> +
>  	max_gain = (max - ucontrol->value.integer.value[0]) & mask;
>  	/*
>  	 * Gain has to set incrementally in 4 steps
> @@ -773,6 +781,9 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
>  		usleep_range(1000, 1010);
>  	}
>  
> +	pm_runtime_mark_last_busy(comp->dev);
> +	pm_runtime_put_autosuspend(comp->dev);
> +
>  	return 1;
>  }
>  
> @@ -1101,6 +1112,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>  			 const struct sdw_device_id *id)
>  {
>  	struct wsa881x_priv *wsa881x;
> +	struct device *dev = &pdev->dev;
>  
>  	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
>  	if (!wsa881x)
> @@ -1124,6 +1136,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>  	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
>  	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
>  	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +	pdev->prop.simple_clk_stop_capable = true;
>  	gpiod_direction_output(wsa881x->sd_n, 1);
>  
>  	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
> @@ -1132,12 +1145,52 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>  		return PTR_ERR(wsa881x->regmap);
>  	}
>  
> +	pm_runtime_set_autosuspend_delay(dev, 3000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>  	return devm_snd_soc_register_component(&pdev->dev,
>  					       &wsa881x_component_drv,
>  					       wsa881x_dais,
>  					       ARRAY_SIZE(wsa881x_dais));
>  }
>  
> +static int __maybe_unused wsa881x_runtime_suspend(struct device *dev)
> +{
> +	struct regmap *regmap = dev_get_regmap(dev, NULL);
> +	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
> +
> +	gpiod_direction_output(wsa881x->sd_n, 0);
> +
> +	regcache_cache_only(regmap, true);
> +	regcache_mark_dirty(regmap);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct regmap *regmap = dev_get_regmap(dev, NULL);
> +	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
> +
> +	gpiod_direction_output(wsa881x->sd_n, 1);
> +
> +	wait_for_completion_timeout(&slave->initialization_complete,
> +				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
> +
> +	regcache_cache_only(regmap, false);
> +	regcache_sync(regmap);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops wsa881x_pm_ops = {
> +	SET_RUNTIME_PM_OPS(wsa881x_runtime_suspend, wsa881x_runtime_resume, NULL)
> +};
> +
>  static const struct sdw_device_id wsa881x_slave_id[] = {
>  	SDW_SLAVE_ENTRY(0x0217, 0x2010, 0),
>  	SDW_SLAVE_ENTRY(0x0217, 0x2110, 0),
> @@ -1151,6 +1204,7 @@ static struct sdw_driver wsa881x_codec_driver = {
>  	.id_table = wsa881x_slave_id,
>  	.driver = {
>  		.name	= "wsa881x-codec",
> +		.pm = &wsa881x_pm_ops,
>  	}
>  };
>  module_sdw_driver(wsa881x_codec_driver);
