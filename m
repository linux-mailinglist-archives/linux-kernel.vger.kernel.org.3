Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07A259BF29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiHVMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiHVMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:00:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AE11EEF6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661169600; x=1692705600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rwVBU5aAOEwE8/qVdFGsbYbMpI+icllJZ7FFpD72ytE=;
  b=d5DLWzJfTshYQtwruuhuBwAzVZXCr+H6bnOR8TQ7LV90cfiZaD7s25dY
   2Zgbc/oikaXOmEuMQXHQK5sHzCPGuPuWB/UU+NxWhjM1VqSJ2LqWn18Pj
   T4BRkcHQ5H9gvK+LvMSwMIdpMFeaAAVktUAPD7mTUTRlg5ONwQhbNT4Hh
   b8XGbgd0uNoNyCYOUMTauupHJ8KHtTa0HKwbz404jWD9w8Y+Fj/E0tWkz
   ybUDRKVwPucCjW+mu6Lal8TmhZcQxoXIbFAWhUd6imx048Zv/LiP4lz1M
   /YsTFKfYaqkbgICv7OKJWCpuyB647wqO9GbGaiovvtlfP/ARofa8Xc0BV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="293391779"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="293391779"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 05:00:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="712154892"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO [10.249.43.69]) ([10.249.43.69])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 04:59:58 -0700
Message-ID: <b899dbff-91d9-00eb-3879-3ca4b56b33d9@linux.intel.com>
Date:   Mon, 22 Aug 2022 13:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 12/12] ASoC: cs42l42: Add support for Soundwire interrupts
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
 <20220819125230.42731-13-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220819125230.42731-13-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/22 14:52, Richard Fitzgerald wrote:
> This adds support for using the Soundwire interrupt mechanism to
> handle CS42L42 chip interrupts.
> 
> Soundwire interrupts are used if a hard INT line is not declared.

This sounds really weird.

The register access would still use the SoundWire read/writes, which
raises a number of opens since the interrupt cannot be handled until the
bus is resumed/operational, so there would be no speed-up at all. Unless
I completely missed something, this seems like wasting one pin with no
benefits?

> Wake-from-clock-stop is not used. The CS42L42 has limited wake
> capability, but clock-stop is already disabled when a snd_soc_jack is
> registered to prevent the host controller issuing a bus-reset on exit
> from clock stop mode, which would clear the interrupt status and break
> jack and button detection.

Same open as in previous patch on why this is needed.

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  sound/soc/codecs/cs42l42-sdw.c | 90 +++++++++++++++++++++++++++++++++-
>  sound/soc/codecs/cs42l42.h     |  3 ++
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
> index ed69a0a44d8c..1bdeed93587d 100644
> --- a/sound/soc/codecs/cs42l42-sdw.c
> +++ b/sound/soc/codecs/cs42l42-sdw.c
> @@ -14,6 +14,7 @@
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
>  #include <linux/soundwire/sdw_type.h>
> +#include <linux/workqueue.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -26,6 +27,8 @@
>  /* Register addresses are offset when sent over Soundwire */
>  #define CS42L42_SDW_ADDR_OFFSET		0x8000
>  
> +#define CS42L42_SDW_GEN_INT_STATUS_1	0xc0
> +#define CS42L42_SDW_GEN_INT_MASK_1	0xc1
>  #define CS42L42_SDW_MEM_ACCESS_STATUS	0xd0
>  #define CS42L42_SDW_MEM_READ_DATA	0xd8
>  
> @@ -33,6 +36,11 @@
>  #define CS42L42_SDW_CMD_IN_PROGRESS	BIT(2)
>  #define CS42L42_SDW_RDATA_RDY		BIT(0)
>  
> +#define CS42L42_SDW_M_SCP_IMP_DEF1	BIT(0)
> +#define CS42L42_GEN_INT_CASCADE		SDW_SCP_INT1_IMPL_DEF
> +
> +#define CS42L42_SDW_INT_MASK_CODEC_IRQ	BIT(0)
> +
>  #define CS42L42_DELAYED_READ_POLL_US	1
>  #define CS42L42_DELAYED_READ_TIMEOUT_US	100
>  
> @@ -306,6 +314,13 @@ static void cs42l42_sdw_init(struct sdw_slave *peripheral)
>  	/* Disable internal logic that makes clock-stop conditional */
>  	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL3, CS42L42_SW_CLK_STP_STAT_SEL_MASK);
>  
> +	/* Enable Soundwire interrupts */
> +	if (!cs42l42->irq) {
> +		dev_dbg(cs42l42->dev, "Using Soundwire interrupts\n");
> +		sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_MASK_1,
> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
> +	}
> +
>  	/*
>  	 * pm_runtime is needed to control bus manager suspend, and to
>  	 * recover from an unattach_request when the manager suspends.
> @@ -319,6 +334,49 @@ static void cs42l42_sdw_init(struct sdw_slave *peripheral)
>  	pm_runtime_idle(cs42l42->dev);
>  }
>  
> +static int cs42l42_sdw_interrupt(struct sdw_slave *peripheral,
> +				 struct sdw_slave_intr_status *status)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> +
> +	/* Soundwire core holds our pm_runtime when calling this function. */
> +
> +	dev_dbg(cs42l42->dev, "int control_port=0x%x\n", status->control_port);
> +
> +	if ((status->control_port & CS42L42_GEN_INT_CASCADE) == 0)
> +		return 0;
> +
> +	/*
> +	 * Clear and mask until it has been handled. The read of GEN_INT_STATUS_1
> +	 * is required as per the Soundwire spec for interrupt status bits to clear.

Humm, this explanation is not very clear. What part of the spec are you
referring to?

Section 11.1.2 "Interrupt Model" says that a read is necessary to make
sure a condition is not missed while clearing the status with successful
write. You need to write the status to clear, and re-read the status to
see if another condition remains. That's not how I understand the code
below, which does the write and read in the opposite order.

> +	 */
> +	sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_MASK_1, 0);
> +	sdw_read_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1);
> +	sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1, 0xFF);
> +	queue_work(system_power_efficient_wq, &cs42l42->sdw_irq_work);
> +
> +	/* Prevent host controller suspending before we handle the interrupt */
> +	pm_runtime_get_noresume(cs42l42->dev);
> +
> +	return 0;
> +}
> +
> +static void cs42l42_sdw_irq_work(struct work_struct *work)
> +{
> +	struct cs42l42_private *cs42l42 = container_of(work,
> +						       struct cs42l42_private,
> +						       sdw_irq_work);
> +
> +	cs42l42_irq_thread(-1, cs42l42);
> +
> +	/* unmask interrupt */
> +	if (!cs42l42->sdw_irq_no_unmask)
> +		sdw_write_no_pm(cs42l42->sdw_peripheral, CS42L42_SDW_GEN_INT_MASK_1,
> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
> +
> +	pm_runtime_put_autosuspend(cs42l42->dev);
> +}
> +
>  static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
>  {
>  	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
> @@ -334,6 +392,14 @@ static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
>  	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
>  	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
>  
> +	/*
> +	 * CS42L42 doesn't have a SDW_SCP_INT1_IMPL_DEF mask bit but it must be
> +	 * set in scp_int1_mask else the Soundwire framework won't notify us
> +	 * when the IMPL_DEF interrupt is asserted.
> +	 */
> +	if (!cs42l42->irq)
> +		prop->scp_int1_mask |= SDW_SCP_INT1_IMPL_DEF;

Sorry, I don't follow the explanation. If you don't have a bit defined
for a specific interrupt, how would that interrupt be handled?

>  	/* DP1 - capture */
>  	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
>  	ports[0].type = SDW_DPN_FULL,
> @@ -403,6 +469,7 @@ static int __maybe_unused cs42l42_sdw_clk_stop(struct sdw_slave *peripheral,
>  
>  static const struct sdw_slave_ops cs42l42_sdw_ops = {
>  	.read_prop = cs42l42_sdw_read_prop,
> +	.interrupt_callback = cs42l42_sdw_interrupt,
>  	.update_status = cs42l42_sdw_update_status,
>  	.bus_config = cs42l42_sdw_bus_config,
>  #ifdef DEBUG
> @@ -473,6 +540,11 @@ static int __maybe_unused cs42l42_sdw_runtime_resume(struct device *dev)
>  	regcache_sync_region(cs42l42->regmap, CS42L42_MIC_DET_CTL1, CS42L42_MIC_DET_CTL1);
>  	regcache_sync(cs42l42->regmap);
>  
> +	/* Re-enable Soundwire interrupts */
> +	if (!cs42l42->irq)
> +		sdw_write_no_pm(cs42l42->sdw_peripheral, CS42L42_SDW_GEN_INT_MASK_1,
> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
> +
>  	return 0;
>  }
>  
> @@ -495,6 +567,11 @@ static int __maybe_unused cs42l42_sdw_resume(struct device *dev)
>  
>  	cs42l42_resume_restore(dev);
>  
> +	/* Re-enable Soundwire interrupts */
> +	if (!cs42l42->irq)
> +		sdw_write_no_pm(cs42l42->sdw_peripheral, CS42L42_SDW_GEN_INT_MASK_1,
> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
> +

that would prevent the device from waking up the system while in
suspend? How would the resume be triggered then, only by the manager?
That doesn't seem like a working model for a headset codec.

This seems also weird since I don't see where the interrupts are
disabled on suspend, so this 're-enable' does not have a clear 'disable'
dual operation.

>  	return 0;
>  }
>  
> @@ -546,6 +623,7 @@ static int cs42l42_sdw_probe(struct sdw_slave *peripheral, const struct sdw_devi
>  	component_drv->dapm_routes = cs42l42_sdw_audio_map;
>  	component_drv->num_dapm_routes = ARRAY_SIZE(cs42l42_sdw_audio_map);
>  
> +	INIT_WORK(&cs42l42->sdw_irq_work, cs42l42_sdw_irq_work);
>  	cs42l42->dev = dev;
>  	cs42l42->regmap = regmap;
>  	cs42l42->sdw_peripheral = peripheral;
> @@ -562,8 +640,18 @@ static int cs42l42_sdw_remove(struct sdw_slave *peripheral)
>  {
>  	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>  
> -	/* Resume so that cs42l42_remove() can access registers */
> +	/* Resume so that we can access registers */
>  	pm_runtime_get_sync(cs42l42->dev);
> +
> +	/* Disable Soundwire interrupts */
> +	if (!cs42l42->irq) {
> +		cs42l42->sdw_irq_no_unmask = true;
> +		cancel_work_sync(&cs42l42->sdw_irq_work);
> +		sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_MASK_1, 0);
> +		sdw_read_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1);
> +		sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1, 0xFF);
> +	}
> +
>  	cs42l42_common_remove(cs42l42);
>  	pm_runtime_put(cs42l42->dev);
>  	pm_runtime_disable(cs42l42->dev);
> diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
> index 038db45d95b3..b29126d218c4 100644
> --- a/sound/soc/codecs/cs42l42.h
> +++ b/sound/soc/codecs/cs42l42.h
> @@ -19,6 +19,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/soundwire/sdw.h>
> +#include <linux/workqueue.h>
>  #include <sound/jack.h>
>  #include <sound/cs42l42.h>
>  #include <sound/soc-component.h>
> @@ -32,6 +33,7 @@ struct  cs42l42_private {
>  	struct completion pdn_done;
>  	struct snd_soc_jack *jack;
>  	struct sdw_slave *sdw_peripheral;
> +	struct work_struct sdw_irq_work;
>  	struct mutex irq_lock;
>  	int irq;
>  	int pll_config;
> @@ -52,6 +54,7 @@ struct  cs42l42_private {
>  	bool hp_adc_up_pending;
>  	bool suspended;
>  	bool init_done;
> +	bool sdw_irq_no_unmask;
>  };
>  
>  extern const struct regmap_config cs42l42_regmap;
