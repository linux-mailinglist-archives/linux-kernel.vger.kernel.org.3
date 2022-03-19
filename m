Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFE4DE925
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiCSP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbiCSP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:57:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE11C2DA8;
        Sat, 19 Mar 2022 08:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46FBBB80D76;
        Sat, 19 Mar 2022 15:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEE1C340EC;
        Sat, 19 Mar 2022 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647705376;
        bh=mWgn1CBzOkYwjn82yecc5EtFhgvAOyNs7D+zgWA1Pzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a5u8j2xKVrouhv9yF6fTA3Rw6Q70jmd+Vz1ZcX+y02xqeghd2U3FLWrlniJaOXDuL
         acCutNc4HbsZUSdDgaz9zqyGmdBDTfit6QJg5ltZx0TzsI3ynJlbx9kfPOGBduJkE+
         1SRS/hIxYSenlBp6b5lwuC9LPIVLWz4KR32AkIf7/hJMLfbtiXy1kneVwNQtl8CGdY
         nVYeGTsGab5Bvk1L3i4b2mVcOZNJuUKBGwyBjKX49tcPCMx8vWKaOvsGvOTTmFOwOz
         CCSQwFlY0fLTVs/rESAh2N+z1k2tlFkdUPMOmL4JmbE8rIPgsh5efsRvD8EFMJ42Af
         NSOpiPGtrs7rA==
Date:   Sat, 19 Mar 2022 16:03:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/8] iio: adc: ad_sigma_delta: Add sequencer support
Message-ID: <20220319160339.47dd683d@jic23-huawei>
In-Reply-To: <20220318162722.51215-5-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
        <20220318162722.51215-5-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:27:18 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>

If this is originally Lars' patch, the From should match
Lars.  If you've taken if further than appropriate
co-developed tag is needed.

> 
> Some sigma-delta chips support sampling of multiple
> channels in continuous mode.
> 
> When the operating with more than one channel enabled,
> the channel sequencer cycles through the enabled channels
> in sequential order, from first channel to the last one.
> If a channel is disabled, it is skipped by the sequencer.
> 
> If more than one channel is used in continuous mode,
> instruct the device to append the status to the SPI transfer
> (1 extra byte) every time we receive a sample.
> All sigma-delta chips possessing a sampling sequencer have
> this ability. Inside the status register there will be
> the number of the converted channel. In this way, even
> if the CPU won't keep up with the sampling rate, it won't
> send to userspace wrong channel samples.

It would be good to say what it does do if this happens as well
as what it doesn't do.  You have it well commented below, but
I think you should also mention it here.

A few comments inline but the basic approach looks good to me.

Thanks,

Jonathan


> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 134 +++++++++++++++++++++++--
>  include/linux/iio/adc/ad_sigma_delta.h |  33 ++++++
>  2 files changed, 157 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ebcd52526cac..5d1932ad2a22 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -342,15 +342,47 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, IIO_AD_SIGMA_DELTA);
>  static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	unsigned int i, slot, samples_buf_size;
>  	unsigned int channel;
> +	uint8_t *samples_buf;
>  	int ret;
>  
> -	channel = find_first_bit(indio_dev->active_scan_mask,
> -				 indio_dev->masklength);
> -	ret = ad_sigma_delta_set_channel(sigma_delta,
> -		indio_dev->channels[channel].address);
> -	if (ret)
> -		return ret;
> +	if (sigma_delta->num_slots == 1) {
> +		channel = find_first_bit(indio_dev->active_scan_mask,
> +					 indio_dev->masklength);
> +		ret = ad_sigma_delta_set_channel(sigma_delta,
> +						 indio_dev->channels[channel].address);
> +		if (ret)
> +			return ret;
> +		slot = 1;
> +	} else {
> +		/*
> +		 * At this point update_scan_mode already enabled the required channels.
> +		 * For sigma-delta sequencer drivers with multiple slots, an update_scan_mode
> +		 * implementation is mandatory.
> +		 */
> +		slot = 0;
> +		for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +			sigma_delta->slots[slot] = indio_dev->channels[i].address;
> +			slot++;
> +		}
> +	}
> +
> +	sigma_delta->active_slots = slot;
> +	sigma_delta->current_slot = 0;
> +
> +	if (sigma_delta->active_slots > 1) {
> +		ret = ad_sigma_delta_append_status(sigma_delta, true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	samples_buf_size = slot * indio_dev->channels[0].scan_type.storagebits + sizeof(int64_t);

In general slot might be such that this size is not a multiple of 8 bytes so the timestamp
would end up unaligned (it'll just go off the end currently) so you need an ALIGN() to
force the size of slog * indio_dev->channels[0].scan_type.storagebits up to a multiple of 8.

> +	samples_buf = krealloc(sigma_delta->samples_buf, samples_buf_size, GFP_KERNEL);
> +	if (!samples_buf)
> +		return -ENOMEM;

Where is this freed?  Probably a case for a devm_krealloc()

> +
> +	sigma_delta->samples_buf = samples_buf;
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
> @@ -386,6 +418,10 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
>  	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  
> +	if (sigma_delta->status_appended)
> +		ad_sigma_delta_append_status(sigma_delta, false);
> +
> +	ad_sigma_delta_disable_all(sigma_delta);
>  	sigma_delta->bus_locked = false;
>  	return spi_bus_unlock(sigma_delta->spi->master);
>  }
> @@ -396,6 +432,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	uint8_t *data = sigma_delta->rx_buf;
> +	unsigned int transfer_size;
> +	unsigned int sample_size;
> +	unsigned int sample_pos;
> +	unsigned int status_pos;
>  	unsigned int reg_size;
>  	unsigned int data_reg;
>  
> @@ -408,21 +448,63 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	else
>  		data_reg = AD_SD_REG_DATA;
>  
> +	/* Status word will be appended to the sample during transfer */
> +	if (sigma_delta->status_appended)
> +		transfer_size = reg_size + 1;
> +	else
> +		transfer_size = reg_size;
> +
>  	switch (reg_size) {
>  	case 4:
>  	case 2:
>  	case 1:
> -		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
> +		status_pos = reg_size;
> +		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
>  		break;
>  	case 3:
> +		status_pos = reg_size + 1;

This would benefit from a comment.  Why is it not just reg_size?

>  		/* We store 24 bit samples in a 32 bit word. Keep the upper
>  		 * byte set to zero. */
> -		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
> +		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
>  		break;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +	/*
> +	 * For devices sampling only one channel at
> +	 * once, there is no need for sample number tracking.
> +	 */
> +	if (sigma_delta->active_slots == 1) {
> +		iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +		goto irq_handled;
> +	}
> +
> +	if (sigma_delta->status_appended) {
> +		u8 converted_channel;
>  
> +		converted_channel = data[status_pos] & sigma_delta->info->status_ch_mask;
> +		if (converted_channel != sigma_delta->slots[sigma_delta->current_slot]) {
> +			/*
> +			 * Desync occurred during continuous sampling of multiple channels.
> +			 * Drop this incomplete sample and start from first channel again.
> +			 */

Good.  Add this detail to the commit message as well.

> +
> +			sigma_delta->current_slot = 0;
> +			goto irq_handled;
> +		}
> +	}
> +
> +	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
> +	sample_pos = sample_size * sigma_delta->current_slot;
> +	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
> +	sigma_delta->current_slot++;
> +
> +	if (sigma_delta->current_slot == sigma_delta->active_slots) {
> +		sigma_delta->current_slot = 0;
> +		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
> +						   pf->timestamp);
> +	}
> +
> +irq_handled:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	sigma_delta->irq_dis = false;
>  	enable_irq(sigma_delta->spi->irq);
> @@ -430,10 +512,17 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned long *mask)
> +{
> +	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +
> +	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->num_slots;
> +}
> +
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
>  	.postenable = &ad_sd_buffer_postenable,
>  	.postdisable = &ad_sd_buffer_postdisable,
> -	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> +	.validate_scan_mask = &ad_sd_validate_scan_mask,
>  };
>  
>  static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
> @@ -513,8 +602,14 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
>   */
>  int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
>  {
> +	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	int ret;
>  
> +	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->num_slots,
> +					  sizeof(*sigma_delta->slots), GFP_KERNEL);
> +	if (!sigma_delta->slots)
> +		return -ENOMEM;
> +
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      &iio_pollfunc_store_time,
>  					      &ad_sd_trigger_handler,
> @@ -541,6 +636,25 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
>  {
>  	sigma_delta->spi = spi;
>  	sigma_delta->info = info;
> +
> +	/* If the field is unset in ad_sigma_delta_info, asume there can only be 1 slot. */
> +	if (!info->num_slots)
> +		sigma_delta->num_slots = 1;
> +	else
> +		sigma_delta->num_slots = info->num_slots;
> +
> +	if (sigma_delta->num_slots > 1) {
> +		if (!indio_dev->info->update_scan_mode) {
> +			dev_err(&spi->dev, "iio_dev lacks update_scan_mode().\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!info->disable_all) {
> +			dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_all().\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	iio_device_set_drvdata(indio_dev, sigma_delta);
>  
>  	return 0;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index c525fd51652f..b921ceb8adfd 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -32,26 +32,34 @@ struct iio_dev;
>  /**
>   * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
>   * @set_channel: Will be called to select the current channel, may be NULL.
> + * @append_status: Will be called to enable status append at the end of the sample, may be NULL.
>   * @set_mode: Will be called to select the current mode, may be NULL.
> + * @disable_all: Will be called to disable all channels, may be NULL.

Not in the same order as the parameters below.

>   * @postprocess_sample: Is called for each sampled data word, can be used to
>   *		modify or drop the sample data, it, may be NULL.
>   * @has_registers: true if the device has writable and readable registers, false
>   *		if there is just one read-only sample data shift register.
>   * @addr_shift: Shift of the register address in the communications register.
>   * @read_mask: Mask for the communications register having the read bit set.
> + * @status_ch_mask: Mask for the channel number stored in status register.
>   * @data_reg: Address of the data register, if 0 the default address of 0x3 will
>   *   be used.
>   * @irq_flags: flags for the interrupt used by the triggered buffer
> + * @num_slots: Number of sequencer slots
>   */
>  struct ad_sigma_delta_info {
>  	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
> +	int (*append_status)(struct ad_sigma_delta *, bool append);
> +	int (*disable_all)(struct ad_sigma_delta *);
>  	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
>  	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
>  	bool has_registers;
>  	unsigned int addr_shift;
>  	unsigned int read_mask;
> +	unsigned int status_ch_mask;
>  	unsigned int data_reg;
>  	unsigned long irq_flags;
> +	unsigned int num_slots;
>  };
>  
>  /**
> @@ -76,6 +84,13 @@ struct ad_sigma_delta {
>  	uint8_t			comm;
>  
>  	const struct ad_sigma_delta_info *info;
> +	unsigned int		active_slots;
> +	unsigned int		current_slot;
> +	unsigned int		num_slots;
> +	bool			status_appended;
> +	/* map slots to channels in order to know what to expect from devices */
> +	unsigned int		*slots;
> +	uint8_t			*samples_buf;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -97,6 +112,24 @@ static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
>  	return 0;
>  }
>  
> +static inline int ad_sigma_delta_append_status(struct ad_sigma_delta *sd, bool append)
> +{
> +	if (sd->info->append_status) {
> +		sd->status_appended = append;
> +		return sd->info->append_status(sd, append);

Minor but usually a better idea to only set the cached state if
the calls succeeds. So check return value of the call before updating
sd->status_appended.  In some error cases you won't know whether it's
set or not, but meh, we can't handle everything :)

> +	}
> +
> +	return 0;
> +}
> +
> +static inline int ad_sigma_delta_disable_all(struct ad_sigma_delta *sd)
> +{
> +	if (sd->info->disable_all)
> +		return sd->info->disable_all(sd);
> +
> +	return 0;
> +}
> +
>  static inline int ad_sigma_delta_set_mode(struct ad_sigma_delta *sd,
>  	unsigned int mode)
>  {

