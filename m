Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2459BF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiHVMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiHVMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:00:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD339B81
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661169595; x=1692705595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bEunYMOLYqJpSKfpNeorsewefm96D+UnEFIXg+SfeHo=;
  b=HQbbTrhi4BWEh0Vg9kQDBpGusrxTjSDI6ioysid0KU6l4I3lxSI+SqT5
   HhxCL5KmigAn0twpCTaXYnCVDul7WCQligJW+4BNqreNfe8N9COG62cp5
   MfgPERjFMUsm33hDMqyBUEN8UtROcq4s64ZnhGgyyqEuRA02ZlVedEDiT
   KhY+tUxQvZHmQzMChshUEid4ev2s1azGC+5EKfSEls/JUg5i8Sc/j0F1N
   6jouikWZKOdh4TkZYm8x+bM+whotL7zA+Pbp3A9KTFyQWqxu0VV5nbsCp
   2oo0vw4FO63RETcUvazjn5PY4TwLZujrO56OTfId2pJyxnGvGrnOCFSd/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="357375420"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="357375420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 04:59:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="712154880"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO [10.249.43.69]) ([10.249.43.69])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 04:59:52 -0700
Message-ID: <44359e9c-4891-17e7-5e0d-392d4751ccf5@linux.intel.com>
Date:   Mon, 22 Aug 2022 13:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 11/12] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
 <20220819125230.42731-12-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220819125230.42731-12-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Richard, this looks quite good.

Nit-pick for the entire patch: SoundWire (capital W).


> - Intel Soundwire host controllers have a low-power clock-stop mode that
>   requires resetting all peripherals when resuming. This is not compatible
>   with the plug-detect and button-detect because it will clear the
>   condition that caused the wakeup before the driver can handle it. So
>   clock-stop must be blocked when a snd_soc_jack handler is registered.

What do you mean by 'clock-stop must be blocked'? The peripheral cannot
prevent the host from stopping the clock. Maybe this is explained
further down in this patch, but that statement is a bit odd.

Even if the condition that caused the wakeup was cleared, presumably
when resetting the device the same condition will be raised again, no?

> +static int cs42l42_sdw_dai_hw_params(struct snd_pcm_substream *substream,
> +				     struct snd_pcm_hw_params *params,
> +				     struct snd_soc_dai *dai)
> +{
> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
> +	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
> +	struct sdw_stream_config sconfig;
> +	struct sdw_port_config pconfig;
> +	unsigned int pdn_mask;
> +	int ret;
> +
> +	if (!sdw_stream)
> +		return -EINVAL;
> +
> +	/* Needed for PLL configuration when we are notified of new bus config */
> +	cs42l42->sample_rate = params_rate(params);
> +
> +	memset(&sconfig, 0, sizeof(sconfig));
> +	memset(&pconfig, 0, sizeof(pconfig));
> +
> +	sconfig.frame_rate = params_rate(params);
> +	sconfig.ch_count = params_channels(params);
> +	sconfig.bps = snd_pcm_format_width(params_format(params));
> +	pconfig.ch_mask = GENMASK(sconfig.ch_count - 1, 0);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		sconfig.direction = SDW_DATA_DIR_RX;
> +		pconfig.num = CS42L42_SDW_PLAYBACK_PORT;
> +		pdn_mask = CS42L42_HP_PDN_MASK;
> +	} else {
> +		sconfig.direction = SDW_DATA_DIR_TX;
> +		pconfig.num = CS42L42_SDW_CAPTURE_PORT;
> +		pdn_mask = CS42L42_ADC_PDN_MASK;
> +	}
> +
> +	/*
> +	 * The DAI-link prepare() will trigger Soundwire DP prepare. But CS42L42
> +	 * DP will only prepare if the HP/ADC is already powered-up. The
> +	 * DAI prepare() and DAPM sequence run after DAI-link prepare() so the
> +	 * PDN bit must be written here.
> +	 */

Why not make use of the callbacks that were added precisely to let the
codec driver perform device-specific operations? You can add your own
code in pre and post operation for both prepare and bank switch. It's
not clear why you would do this in a hw_params (which can be called
multiple times per ALSA conventions).

> +	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL1, pdn_mask);
> +	usleep_range(CS42L42_HP_ADC_EN_TIME_US, CS42L42_HP_ADC_EN_TIME_US + 1000);
> +
> +	ret = sdw_stream_add_slave(cs42l42->sdw_peripheral, &sconfig, &pconfig, 1, sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Failed to add sdw stream: %d\n", ret);
> +		goto err;
> +	}
> +
> +	cs42l42_src_config(dai->component, params_rate(params));
> +
> +	return 0;
> +
> +err:
> +	regmap_set_bits(cs42l42->regmap, CS42L42_PWR_CTL1, pdn_mask);
> +
> +	return ret;
> +}
> +
> +static int cs42l42_sdw_dai_prepare(struct snd_pcm_substream *substream,
> +				   struct snd_soc_dai *dai)
> +{
> +	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(dai->component);
> +
> +	dev_dbg(dai->dev, "dai_prepare: sclk=%u rate=%u\n", cs42l42->sclk, cs42l42->sample_rate);
> +
> +	if (!cs42l42->sclk || !cs42l42->sample_rate)

what does sclk mean in the SoundWire context?

> +		return -EINVAL;
> +
> +	return cs42l42_pll_config(dai->component, cs42l42->sclk, cs42l42->sample_rate);
> +}
> +

There should be a really big comment here that the following functions
implement delayed reads and writes - this was not needed for previous
codecs.

> +static int cs42l42_sdw_poll_status(struct sdw_slave *peripheral, u8 mask, u8 match)
> +{
> +	int ret, sdwret;
> +
> +	ret = read_poll_timeout(sdw_read_no_pm, sdwret,
> +				(sdwret < 0) || ((sdwret & mask) == match),
> +				CS42L42_DELAYED_READ_POLL_US, CS42L42_DELAYED_READ_TIMEOUT_US,
> +				false, peripheral, CS42L42_SDW_MEM_ACCESS_STATUS);
> +	if (ret == 0)
> +		ret = sdwret;
> +
> +	if (ret < 0)
> +		dev_err(&peripheral->dev, "MEM_ACCESS_STATUS & %#x for %#x fail: %d\n",
> +			mask, match, ret);
> +
> +	return ret;
> +}
> +
> +static int cs42l42_sdw_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct sdw_slave *peripheral = context;
> +	u8 data;
> +	int ret;
> +
> +	reg += CS42L42_SDW_ADDR_OFFSET;
> +
> +	ret = cs42l42_sdw_poll_status(peripheral, CS42L42_SDW_CMD_IN_PROGRESS, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sdw_read_no_pm(peripheral, reg);
> +	if (ret < 0) {
> +		dev_err(&peripheral->dev, "Failed to issue read @0x%x: %d\n", reg, ret);
> +		return ret;
> +	}
> +
> +	data = (u8)ret;	/* possible non-delayed read value */
> +	ret = sdw_read_no_pm(peripheral, CS42L42_SDW_MEM_ACCESS_STATUS);
> +	if (ret < 0) {
> +		dev_err(&peripheral->dev, "Failed to read MEM_ACCESS_STATUS: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* If read was not delayed we already have the result */
> +	if ((ret & CS42L42_SDW_LAST_LATE) == 0) {
> +		*val = data;
> +		return 0;
> +	}
> +
> +	/* Poll for delayed read completion */
> +	if ((ret & CS42L42_SDW_RDATA_RDY) == 0) {
> +		ret = cs42l42_sdw_poll_status(peripheral,
> +					      CS42L42_SDW_RDATA_RDY, CS42L42_SDW_RDATA_RDY);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = sdw_read_no_pm(peripheral, CS42L42_SDW_MEM_READ_DATA);
> +	if (ret < 0) {
> +		dev_err(&peripheral->dev, "Failed to read READ_DATA: %d\n", ret);
> +		return ret;
> +	}
> +
> +	*val = (u8)ret;
> +
> +	return 0;
> +}
> +
> +static int cs42l42_sdw_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct sdw_slave *peripheral = context;
> +	int ret;
> +
> +	ret = cs42l42_sdw_poll_status(peripheral, CS42L42_SDW_CMD_IN_PROGRESS, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sdw_write_no_pm(peripheral, reg + CS42L42_SDW_ADDR_OFFSET, (u8)val);
> +}
> +
> +static void cs42l42_sdw_init(struct sdw_slave *peripheral)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +	int ret = 0;
> +
> +	regcache_cache_only(cs42l42->regmap, false);
> +
> +	ret = cs42l42_init(cs42l42);
> +	if (ret < 0) {
> +		regcache_cache_only(cs42l42->regmap, true);
> +		return;
> +	}
> +
> +	/* Write out any cached changes that happened between probe and attach */
> +	ret = regcache_sync(cs42l42->regmap);
> +	if (ret < 0)
> +		dev_warn(cs42l42->dev, "Failed to sync cache: %d\n", ret);
> +
> +	/* Disable internal logic that makes clock-stop conditional */
> +	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL3, CS42L42_SW_CLK_STP_STAT_SEL_MASK);
> +
> +	/*
> +	 * pm_runtime is needed to control bus manager suspend, and to

I don't think the intent is that the codec can control the manager
suspend, but that the manager cannot be suspended by the framework
unless the codec suspends first?

> +	 * recover from an unattach_request when the manager suspends.
> +	 * Autosuspend delay must be long enough to enumerate.

No, this last sentence is not correct. The enumeration can be done no
matter what pm_runtime state the Linux codec device is in. And it's
really the other way around, it's when the codec reports as ATTACHED
that the codec driver will be resumed.

> +	 */
> +	pm_runtime_set_autosuspend_delay(cs42l42->dev, 3000);
> +	pm_runtime_use_autosuspend(cs42l42->dev);
> +	pm_runtime_set_active(cs42l42->dev);
> +	pm_runtime_enable(cs42l42->dev);
> +	pm_runtime_mark_last_busy(cs42l42->dev);
> +	pm_runtime_idle(cs42l42->dev);
> +}
> +
> +static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +	struct sdw_slave_prop *prop = &peripheral->prop;
> +	struct sdw_dpn_prop *ports;
> +
> +	ports = devm_kcalloc(cs42l42->dev, 2, sizeof(*ports), GFP_KERNEL);
> +	if (!ports)
> +		return -ENOMEM;
> +
> +	prop->source_ports = BIT(CS42L42_SDW_CAPTURE_PORT);
> +	prop->sink_ports = BIT(CS42L42_SDW_PLAYBACK_PORT);
> +	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> +	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +
> +	/* DP1 - capture */
> +	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
> +	ports[0].type = SDW_DPN_FULL,
> +	ports[0].ch_prep_timeout = 10,
> +	prop->src_dpn_prop = &ports[0];
> +
> +	/* DP2 - playback */
> +	ports[1].num = CS42L42_SDW_PLAYBACK_PORT,
> +	ports[1].type = SDW_DPN_FULL,
> +	ports[1].ch_prep_timeout = 10,
> +	prop->sink_dpn_prop = &ports[1];
> +
> +	return 0;
> +}

> +static int cs42l42_sdw_bus_config(struct sdw_slave *peripheral,
> +				  struct sdw_bus_params *params)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +	unsigned int new_sclk = params->curr_dr_freq / 2;
> +
> +	/* The cs42l42 cannot support a glitchless SWIRE_CLK change. */

nit-pick: SoundWire

> +	if ((new_sclk != cs42l42->sclk) && cs42l42->stream_use) {
> +		dev_warn(cs42l42->dev, "Rejected SCLK change while audio active\n");
> +		return -EBUSY;
> +	}

It's good to have this test but so far we haven't changed the bus clock
on the fly so it's not tested.

> +
> +	cs42l42->sclk = new_sclk;
> +
> +	dev_dbg(cs42l42->dev, "bus_config: sclk=%u c=%u r=%u\n",
> +		cs42l42->sclk, params->col, params->row);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l42_sdw_clk_stop(struct sdw_slave *peripheral,
> +				enum sdw_clk_stop_mode mode,
> +				enum sdw_clk_stop_type type)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +
> +	dev_dbg(cs42l42->dev, "clk_stop mode:%d type:%d\n", mode, type);
> +
> +	return 0;
> +}
> +
> +static const struct sdw_slave_ops cs42l42_sdw_ops = {
> +	.read_prop = cs42l42_sdw_read_prop,
> +	.update_status = cs42l42_sdw_update_status,
> +	.bus_config = cs42l42_sdw_bus_config,
> +#ifdef DEBUG
> +	.clk_stop = cs42l42_sdw_clk_stop,
> +#endif

do you really need this wrapper?

> +};
> +
> +static int __maybe_unused cs42l42_sdw_runtime_suspend(struct device *dev)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "Runtime suspend\n");
> +
> +	/* The host controller could suspend, which would mean no register access */
> +	regcache_cache_only(cs42l42->regmap, true);
> +
> +	return 0;
> +}
> +
> +static const struct reg_sequence __maybe_unused cs42l42_soft_reboot_seq[] = {
> +	REG_SEQ0(CS42L42_SOFT_RESET_REBOOT, 0x1e),
> +};
>
> +static int __maybe_unused cs42l42_sdw_resume(struct device *dev)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "System resume\n");
> +
> +	/* Power-up so it can re-enumerate */

??
You cannot power-up with the bus, did you mean that side channels are
used for powering up?

> +	ret = cs42l42_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for re-attach */
> +	ret = cs42l42_sdw_handle_unattach(cs42l42);
> +	if (ret < 0)
> +		return ret;
> +
> +	cs42l42_resume_restore(dev);
> +
> +	return 0;
> +}
> +
> +static int cs42l42_sdw_probe(struct sdw_slave *peripheral, const struct sdw_device_id *id)
> +{
> +	struct device *dev = &peripheral->dev;
> +	struct cs42l42_private *cs42l42;
> +	struct regmap_config *regmap_conf;
> +	struct regmap *regmap;
> +	struct snd_soc_component_driver *component_drv;
> +	int irq, ret;
> +
> +	cs42l42 = devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
> +	if (!cs42l42)
> +		return -ENOMEM;
> +
> +	if (has_acpi_companion(dev))
> +		irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
> +	else
> +		irq = of_irq_get(dev->of_node, 0);

why do you need an interrupt when SoundWire provides an in-band one? You
need a lot more explanations on the requirement and what you intend to
do with this interrupt?

> +
> +	if (irq == -ENOENT)
> +		irq = 0;
> +	else if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> +
> +	regmap_conf = devm_kmemdup(dev, &cs42l42_regmap, sizeof(cs42l42_regmap), GFP_KERNEL);
> +	if (!regmap_conf)
> +		return -ENOMEM;
> +	regmap_conf->reg_bits = 16;
> +	regmap_conf->num_ranges = 0;
> +	regmap_conf->reg_read = cs42l42_sdw_read;
> +	regmap_conf->reg_write = cs42l42_sdw_write;
> +
> +	regmap = devm_regmap_init(dev, NULL, peripheral, regmap_conf);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to allocate register map\n");
> +
> +	/* Start in cache-only until device is enumerated */
> +	regcache_cache_only(regmap, true);
> +
> +	component_drv = devm_kmemdup(dev,
> +				     &cs42l42_soc_component,
> +				     sizeof(cs42l42_soc_component),
> +				     GFP_KERNEL);
> +	if (!component_drv)
> +		return -ENOMEM;
> +
> +	component_drv->dapm_routes = cs42l42_sdw_audio_map;
> +	component_drv->num_dapm_routes = ARRAY_SIZE(cs42l42_sdw_audio_map);
> +
> +	cs42l42->dev = dev;
> +	cs42l42->regmap = regmap;
> +	cs42l42->sdw_peripheral = peripheral;
> +	cs42l42->irq = irq;
> +
> +	ret = cs42l42_common_probe(cs42l42, component_drv, &cs42l42_sdw_dai);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int cs42l42_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +
> +	/* Resume so that cs42l42_remove() can access registers */
> +	pm_runtime_get_sync(cs42l42->dev);

you need to test if this resume succeeded, and possibly use
pm_resume_resume_and_get() to avoid issues.

> +	cs42l42_common_remove(cs42l42);
> +	pm_runtime_put(cs42l42->dev);
> +	pm_runtime_disable(cs42l42->dev);
> +
> +	return 0;
> +}

>  static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
> @@ -559,6 +564,20 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
>  {
>  	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
>  
> +	/*
> +	 * If the Soundwire controller issues bus reset when coming out of
> +	 * clock-stop it will erase the jack state. This can lose button press
> +	 * events, and plug/unplug interrupt bits take between 125ms and 1500ms
> +	 * before they are valid again.
> +	 * Prevent this by holding our pm_runtime to block clock-stop.
> +	 */
> +	if (cs42l42->sdw_peripheral) {
> +		if (jk)
> +			pm_runtime_get_sync(cs42l42->dev);
> +		else
> +			pm_runtime_put_autosuspend(cs42l42->dev);
> +	}
> +

I *really* don't understand this sequence.

The bus will be suspended when ALL devices have been idle for some time.
If the user presses a button AFTER the bus is suspended, the device can
still use the in-band wake and resume.
Granted the button press will be lost but the plug/unplug status will
still be handled with a delay.

>  	/* Prevent race with interrupt handler */
>  	mutex_lock(&cs42l42->irq_lock);
>  	cs42l42->jack = jk;
> @@ -1645,9 +1664,11 @@ irqreturn_t cs42l42_irq_thread(int irq, void *data)
>  	unsigned int current_button_status;
>  	unsigned int i;
>  
> +	pm_runtime_get_sync(cs42l42->dev);
>  	mutex_lock(&cs42l42->irq_lock);
>  	if (cs42l42->suspended || !cs42l42->init_done) {
>  		mutex_unlock(&cs42l42->irq_lock);
> +		pm_runtime_put_autosuspend(cs42l42->dev);
>  		return IRQ_NONE;
>  	}
>  
> @@ -1750,6 +1771,8 @@ irqreturn_t cs42l42_irq_thread(int irq, void *data)
>  	}
>  
>  	mutex_unlock(&cs42l42->irq_lock);
> +	pm_runtime_mark_last_busy(cs42l42->dev);
> +	pm_runtime_put_autosuspend(cs42l42->dev);
>  
>  	return IRQ_HANDLED;

Again in SoundWire more you should not use a dedicated interrupt.
There's something missing in the explanations on why this thread is
required.

