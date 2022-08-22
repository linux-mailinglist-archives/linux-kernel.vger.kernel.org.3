Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F390859C200
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiHVPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiHVPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:01:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109B31DF3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:01:38 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MBglad022789;
        Mon, 22 Aug 2022 10:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=an2SZUxYDGbfKMkvkefRQ8l02MMjBY1EW+HdPWMAQ/o=;
 b=bqjLkXCBOJ0PjaRpuanLUWuxJncK6kCAPLzyF1rMN14DQm4E38pEcIrBhj+aCYshyNv5
 KX8zEy6ZpNdk920rrI1flNJqF1zbGCMYzXYE852cO7Fmn2B+afhhewYu9Mg8E38sViY/
 4bEKySr0M1/njPcch8ma+GrjmFNC4PrO4nIzL1JH5b6y0bmL2C44RLwOotxGETkLkRbC
 4mQtMe/M/w05l50mooiU92KgX5jxXQJCnIsFRbhLZ5osS5cBNqjgjNld+0bz8BJ8ErHg
 31TDTURhITDZrj0uqp0hcq0m8n19qWHwHVHUoIIUX9iWOhREZyjxhpbZUqa0Tcis39xW og== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j2x12a9ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 10:01:29 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 22 Aug
 2022 10:01:27 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Mon, 22 Aug 2022 10:01:27 -0500
Received: from [198.61.64.120] (unknown [198.61.64.120])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 04484476;
        Mon, 22 Aug 2022 15:01:26 +0000 (UTC)
Message-ID: <fcfdbf9c-0153-d7a0-0657-371cf5672b42@opensource.cirrus.com>
Date:   Mon, 22 Aug 2022 16:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 12/12] ASoC: cs42l42: Add support for Soundwire interrupts
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
 <20220819125230.42731-13-rf@opensource.cirrus.com>
 <b899dbff-91d9-00eb-3879-3ca4b56b33d9@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <b899dbff-91d9-00eb-3879-3ca4b56b33d9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0p7MMcB8hQwfarNpKiKulhFZy3xGUmKU
X-Proofpoint-ORIG-GUID: 0p7MMcB8hQwfarNpKiKulhFZy3xGUmKU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 12:33, Pierre-Louis Bossart wrote:
> 
> 
> On 8/19/22 14:52, Richard Fitzgerald wrote:
>> This adds support for using the Soundwire interrupt mechanism to
>> handle CS42L42 chip interrupts.
>>
>> Soundwire interrupts are used if a hard INT line is not declared.
> 
> This sounds really weird.
> 
> The register access would still use the SoundWire read/writes, which
> raises a number of opens since the interrupt cannot be handled until the
> bus is resumed/operational, so there would be no speed-up at all. Unless

I didn't say it was for speed.
The cs42l42 has various quirks. One is that the interrupt controller can
still assert hard INT while in Soundwire clock-stop but cannot trigger a
Soundwire wake. We could remove INT support from this first submission
if you prefer and add it when/if necessary.

> I completely missed something, this seems like wasting one pin with no
> benefits?
> 

The pin has no other function than INT so it's there whether you use it
or not.

>> Wake-from-clock-stop is not used. The CS42L42 has limited wake
>> capability, but clock-stop is already disabled when a snd_soc_jack is
>> registered to prevent the host controller issuing a bus-reset on exit
>> from clock stop mode, which would clear the interrupt status and break
>> jack and button detection.
> 
> Same open as in previous patch on why this is needed.
> 

As said, the CS42L42 has limited ability to issue a wake from clock
stop and even with its limited capability things won't work well if
it gets bus-reset before the source can be handled.

>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   sound/soc/codecs/cs42l42-sdw.c | 90 +++++++++++++++++++++++++++++++++-
>>   sound/soc/codecs/cs42l42.h     |  3 ++
>>   2 files changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
>> index ed69a0a44d8c..1bdeed93587d 100644
>> --- a/sound/soc/codecs/cs42l42-sdw.c
>> +++ b/sound/soc/codecs/cs42l42-sdw.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/soundwire/sdw.h>
>>   #include <linux/soundwire/sdw_registers.h>
>>   #include <linux/soundwire/sdw_type.h>
>> +#include <linux/workqueue.h>
>>   #include <sound/pcm.h>
>>   #include <sound/pcm_params.h>
>>   #include <sound/soc.h>
>> @@ -26,6 +27,8 @@
>>   /* Register addresses are offset when sent over Soundwire */
>>   #define CS42L42_SDW_ADDR_OFFSET		0x8000
>>   
>> +#define CS42L42_SDW_GEN_INT_STATUS_1	0xc0
>> +#define CS42L42_SDW_GEN_INT_MASK_1	0xc1
>>   #define CS42L42_SDW_MEM_ACCESS_STATUS	0xd0
>>   #define CS42L42_SDW_MEM_READ_DATA	0xd8
>>   
>> @@ -33,6 +36,11 @@
>>   #define CS42L42_SDW_CMD_IN_PROGRESS	BIT(2)
>>   #define CS42L42_SDW_RDATA_RDY		BIT(0)
>>   
>> +#define CS42L42_SDW_M_SCP_IMP_DEF1	BIT(0)
>> +#define CS42L42_GEN_INT_CASCADE		SDW_SCP_INT1_IMPL_DEF
>> +
>> +#define CS42L42_SDW_INT_MASK_CODEC_IRQ	BIT(0)
>> +
>>   #define CS42L42_DELAYED_READ_POLL_US	1
>>   #define CS42L42_DELAYED_READ_TIMEOUT_US	100
>>   
>> @@ -306,6 +314,13 @@ static void cs42l42_sdw_init(struct sdw_slave *peripheral)
>>   	/* Disable internal logic that makes clock-stop conditional */
>>   	regmap_clear_bits(cs42l42->regmap, CS42L42_PWR_CTL3, CS42L42_SW_CLK_STP_STAT_SEL_MASK);
>>   
>> +	/* Enable Soundwire interrupts */
>> +	if (!cs42l42->irq) {
>> +		dev_dbg(cs42l42->dev, "Using Soundwire interrupts\n");
>> +		sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_MASK_1,
>> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
>> +	}
>> +
>>   	/*
>>   	 * pm_runtime is needed to control bus manager suspend, and to
>>   	 * recover from an unattach_request when the manager suspends.
>> @@ -319,6 +334,49 @@ static void cs42l42_sdw_init(struct sdw_slave *peripheral)
>>   	pm_runtime_idle(cs42l42->dev);
>>   }
>>   
>> +static int cs42l42_sdw_interrupt(struct sdw_slave *peripheral,
>> +				 struct sdw_slave_intr_status *status)
>> +{
>> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>> +
>> +	/* Soundwire core holds our pm_runtime when calling this function. */
>> +
>> +	dev_dbg(cs42l42->dev, "int control_port=0x%x\n", status->control_port);
>> +
>> +	if ((status->control_port & CS42L42_GEN_INT_CASCADE) == 0)
>> +		return 0;
>> +
>> +	/*
>> +	 * Clear and mask until it has been handled. The read of GEN_INT_STATUS_1
>> +	 * is required as per the Soundwire spec for interrupt status bits to clear.
> 
> Humm, this explanation is not very clear. What part of the spec are you
> referring to?
> 
> Section 11.1.2 "Interrupt Model" says that a read is necessary to make
> sure a condition is not missed while clearing the status with successful
> write. You need to write the status to clear, and re-read the status to
> see if another condition remains. That's not how I understand the code
> below, which does the write and read in the opposite order.
> 

The spec is
1. The status must be read before it can be cleared
2. It must then be written to clear it
3. Any new events triggered since the read will not be cleared by
the write since there hasn't been another read, and will remain
pending.

Thus the sequence is
1. Read INT_STATUS to ack the interrupts we've seen and enable clearing
them.
2. Write INT_STATUS to clear the interrupts acked by the previous read.
3. New interrupts since the read of INT_STATUS will not clear so we
don't lose them. However since we do a pre-step of masking the input
sources to GEN_INT_STATUS_1 no new interrupt can actually be triggered,
in this register - this prevents an ALERT storm while waiting for the
work function to run and clear the interrupt sources.

(BTW these are custom registers, not SW spec registers, so their
behavior is implementation-defined, although GEN_INT_STATUS_1 does
implement the normal SW read-write-to-clear behavior.)

>> +	 */
>> +	sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_MASK_1, 0);
>> +	sdw_read_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1);
>> +	sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1, 0xFF);
>> +	queue_work(system_power_efficient_wq, &cs42l42->sdw_irq_work);
>> +
>> +	/* Prevent host controller suspending before we handle the interrupt */
>> +	pm_runtime_get_noresume(cs42l42->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cs42l42_sdw_irq_work(struct work_struct *work)
>> +{
>> +	struct cs42l42_private *cs42l42 = container_of(work,
>> +						       struct cs42l42_private,
>> +						       sdw_irq_work);
>> +
>> +	cs42l42_irq_thread(-1, cs42l42);
>> +
>> +	/* unmask interrupt */
>> +	if (!cs42l42->sdw_irq_no_unmask)
>> +		sdw_write_no_pm(cs42l42->sdw_peripheral, CS42L42_SDW_GEN_INT_MASK_1,
>> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
>> +
>> +	pm_runtime_put_autosuspend(cs42l42->dev);
>> +}
>> +
>>   static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
>>   {
>>   	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>> @@ -334,6 +392,14 @@ static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
>>   	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
>>   	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
>>   
>> +	/*
>> +	 * CS42L42 doesn't have a SDW_SCP_INT1_IMPL_DEF mask bit but it must be
>> +	 * set in scp_int1_mask else the Soundwire framework won't notify us
>> +	 * when the IMPL_DEF interrupt is asserted.
>> +	 */
>> +	if (!cs42l42->irq)
>> +		prop->scp_int1_mask |= SDW_SCP_INT1_IMPL_DEF;
> 
> Sorry, I don't follow the explanation. If you don't have a bit defined
> for a specific interrupt, how would that interrupt be handled?

The IMP_DEF interrupt is always unmasked. It does not have a mask bit.

> 
>>   	/* DP1 - capture */
>>   	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
>>   	ports[0].type = SDW_DPN_FULL,
>> @@ -403,6 +469,7 @@ static int __maybe_unused cs42l42_sdw_clk_stop(struct sdw_slave *peripheral,
>>   
>>   static const struct sdw_slave_ops cs42l42_sdw_ops = {
>>   	.read_prop = cs42l42_sdw_read_prop,
>> +	.interrupt_callback = cs42l42_sdw_interrupt,
>>   	.update_status = cs42l42_sdw_update_status,
>>   	.bus_config = cs42l42_sdw_bus_config,
>>   #ifdef DEBUG
>> @@ -473,6 +540,11 @@ static int __maybe_unused cs42l42_sdw_runtime_resume(struct device *dev)
>>   	regcache_sync_region(cs42l42->regmap, CS42L42_MIC_DET_CTL1, CS42L42_MIC_DET_CTL1);
>>   	regcache_sync(cs42l42->regmap);
>>   
>> +	/* Re-enable Soundwire interrupts */
>> +	if (!cs42l42->irq)
>> +		sdw_write_no_pm(cs42l42->sdw_peripheral, CS42L42_SDW_GEN_INT_MASK_1,
>> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -495,6 +567,11 @@ static int __maybe_unused cs42l42_sdw_resume(struct device *dev)
>>   
>>   	cs42l42_resume_restore(dev);
>>   
>> +	/* Re-enable Soundwire interrupts */
>> +	if (!cs42l42->irq)
>> +		sdw_write_no_pm(cs42l42->sdw_peripheral, CS42L42_SDW_GEN_INT_MASK_1,
>> +				CS42L42_SDW_INT_MASK_CODEC_IRQ);
>> +
> 
> that would prevent the device from waking up the system while in
> suspend? How would the resume be triggered then, only by the manager?
> That doesn't seem like a working model for a headset codec.
> 

I don't understand your concern here. When you bus-reset our peripheral
on exit from clock-stop it will reset the custom implementation-defined
interrupt masks. The core code won't restore them because it doesn't
know about them. So we have to restore them otherwise we will never get
any more jack or button ALERTs from the CS42L42. This is no different
from doing a regcache_sync() to restore registers.

> This seems also weird since I don't see where the interrupts are
> disabled on suspend, so this 're-enable' does not have a clear 'disable'
> dual operation.
> 

We don't want to disable them. We need to recover from an Intel forced
bus-reset. It would be simpler if we didn't have to consider a mode 0
clock stop possibly resetting the peripheral, but as Intel does that we
must handle everything the core code can't restore automatically.

>>   	return 0;
>>   }
>>   
>> @@ -546,6 +623,7 @@ static int cs42l42_sdw_probe(struct sdw_slave *peripheral, const struct sdw_devi
>>   	component_drv->dapm_routes = cs42l42_sdw_audio_map;
>>   	component_drv->num_dapm_routes = ARRAY_SIZE(cs42l42_sdw_audio_map);
>>   
>> +	INIT_WORK(&cs42l42->sdw_irq_work, cs42l42_sdw_irq_work);
>>   	cs42l42->dev = dev;
>>   	cs42l42->regmap = regmap;
>>   	cs42l42->sdw_peripheral = peripheral;
>> @@ -562,8 +640,18 @@ static int cs42l42_sdw_remove(struct sdw_slave *peripheral)
>>   {
>>   	struct cs42l42_private *cs42l42 = dev_get_drvdata(&peripheral->dev);
>>   
>> -	/* Resume so that cs42l42_remove() can access registers */
>> +	/* Resume so that we can access registers */
>>   	pm_runtime_get_sync(cs42l42->dev);
>> +
>> +	/* Disable Soundwire interrupts */
>> +	if (!cs42l42->irq) {
>> +		cs42l42->sdw_irq_no_unmask = true;
>> +		cancel_work_sync(&cs42l42->sdw_irq_work);
>> +		sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_MASK_1, 0);
>> +		sdw_read_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1);
>> +		sdw_write_no_pm(peripheral, CS42L42_SDW_GEN_INT_STATUS_1, 0xFF);
>> +	}
>> +
>>   	cs42l42_common_remove(cs42l42);
>>   	pm_runtime_put(cs42l42->dev);
>>   	pm_runtime_disable(cs42l42->dev);
>> diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
>> index 038db45d95b3..b29126d218c4 100644
>> --- a/sound/soc/codecs/cs42l42.h
>> +++ b/sound/soc/codecs/cs42l42.h
>> @@ -19,6 +19,7 @@
>>   #include <linux/regmap.h>
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/soundwire/sdw.h>
>> +#include <linux/workqueue.h>
>>   #include <sound/jack.h>
>>   #include <sound/cs42l42.h>
>>   #include <sound/soc-component.h>
>> @@ -32,6 +33,7 @@ struct  cs42l42_private {
>>   	struct completion pdn_done;
>>   	struct snd_soc_jack *jack;
>>   	struct sdw_slave *sdw_peripheral;
>> +	struct work_struct sdw_irq_work;
>>   	struct mutex irq_lock;
>>   	int irq;
>>   	int pll_config;
>> @@ -52,6 +54,7 @@ struct  cs42l42_private {
>>   	bool hp_adc_up_pending;
>>   	bool suspended;
>>   	bool init_done;
>> +	bool sdw_irq_no_unmask;
>>   };
>>   
>>   extern const struct regmap_config cs42l42_regmap;
