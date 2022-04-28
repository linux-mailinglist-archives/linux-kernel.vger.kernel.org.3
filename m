Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47A513C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbiD1ThE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiD1ThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:37:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303795AA69;
        Thu, 28 Apr 2022 12:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A592B82E58;
        Thu, 28 Apr 2022 19:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3C5C385A9;
        Thu, 28 Apr 2022 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651174423;
        bh=QqUcNDPj9oXW7oZDL8WRfCDYA/DfJzIT02EgX4A9zso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nWprBKk+mQOa3zQwPE+x3RXwLkhIw+WGi+NQYnUkXbGjMI7zqUtd85izBX1SOjQiG
         183RboxTCLwRi758iX667/l29sLnE3JP2JivK2IjjE61a4ksKVlJqTEsqK7JbJoHdx
         snM0LngaaHNtQCaZ+SY+8kbaZVdqs6IHSr6hmpZjb9pYsTf3b9Pb7RZ+YE0B/ADrfa
         UkOVFHQy+uLvaYJi+RtDDiEI4M8PzzMU+TnYaBWhpZxRgYRvT/bCy35L4CEcexqw+8
         3o40W9UHEv2RLClKEXb3Kkt5i+jnmZBVKPu4r7V28Lr/WyWPw03os0zYHM495CtOQ5
         3U368XZwzoAPA==
Date:   Thu, 28 Apr 2022 20:41:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220428204152.1a564078@jic23-huawei>
In-Reply-To: <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
        <20220419154555.24191-3-ddrokosov@sberdevices.ru>
        <20220420115023.00006a25@Huawei.com>
        <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 17:23:24 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Jonathan,
> 
> Thank you for such detailed review. Please find my comments and
> questions below.
> 

Hi Dmitry,

Feel free to crop replies.  No need to agree with things. Anything
you haven't commented on,  I'll assume you agree with and saves
some time on a big driver like this to not have to go looking
for the questions.

Replies inline.

...

> > > +	 */
> > > +	[F_SOFT_RESET_I2C] = REG_FIELD(MSA311_SOFT_RESET, 2, 2),
> > > +	[F_SOFT_RESET_SPI] = REG_FIELD(MSA311_SOFT_RESET, 5, 5),
> > > +
> > > +	/*
> > > +	 * Part ID
> > > +	 *
> > > +	 * Default: 0x13
> > > +	 */
> > > +	[F_PARTID] = REG_FIELD(MSA311_PARTID, 0, 7),  
> > 
> > That's the whole register. What benefit is there in treating it
> > like a field?
> >   
> 
> Actually, I wanted to generalize access to registers with and w/o
> fields in one way. That's why I use REG_FIELD for all types of registers.
> Do you think this is a bad idea and overengineering?

I think so in this case.


> 
> > > +
> > > +	/*
> > > +	 * X_axis Data LSB/MSB
> > > +	 *
> > > +	 * ACC_X = (ACC_X_MSB[7:0] << 4) | ACC_X_LSB[7:4]
> > > +	 */
> > > +	[F_ACC_X_LSB] = REG_FIELD(MSA311_ACC_X_LSB, 4, 7),
> > > +	[F_ACC_X_MSB] = REG_FIELD(MSA311_ACC_X_MSB, 0, 7),  
> > 
> > Using fields for these two registers make it harder to see
> > what is going on in the code. I would access them as whole
> > registers and you should be able to do a bulk read to get
> > them both followed by endian conversion.
> >   
> 
> Ack, I provide more detailed answer below
> 
> > > +
..


> > > +	/*
> > > +	 * Offset Compensation
> > > +	 *
> > > +	 * OFFSET_X[7:0]: the offset compensation value for X axis,
> > > +	 *                1LSB is 3.9mg
> > > +	 * OFFSET_Y[7:0]: the offset compensation value for Y axis,
> > > +	 *                1LSB is 3.9mg
> > > +	 * OFFSET_Z[7:0]: the offset compensation value for Z axis,
> > > +	 *                1LSB is 3.9mg
> > > +	 */
> > > +	[F_OFFSET_X] = REG_FIELD(MSA311_OFFSET_X, 0, 7),
> > > +	[F_OFFSET_Y] = REG_FIELD(MSA311_OFFSET_Y, 0, 7),
> > > +	[F_OFFSET_Z] = REG_FIELD(MSA311_OFFSET_Z, 0, 7),  
> > 
> > Note I've only commented on some of these, but many of the comments apply
> > in multiple places.
> >   
> 
> Okay, I can rework the whole registers access to reg API instead of
> fields API, but actually I don't see any benefits except code style.

Two big ones are bulk reads and I don't think the field code will optimize
out the read when doing a full register write.

> 
> > > +};
> > > +
> > > +#define MSA311_WHO_AM_I 0x13
> > > +
> > > +/* Possible Full Scale ranges */
> > > +enum {
> > > +	MSA311_FS_2G,
> > > +	MSA311_FS_4G,
> > > +	MSA311_FS_8G,
> > > +	MSA311_FS_16G,
> > > +};
> > > +
> > > +#define msa311_fs_available "0.009580 0.019160 0.038320 0.076641"
> > > +static const int msa311_fs_table[] = { 9580, 19160, 38320, 76641 };
> > > +
> > > +/* Possible Output Data Rate values */  
> > 
> > These don't seem to be all supported currently.  So remove the ones that
> > aren't until you have the mode handling in place (or maybe I'm missing something...)
> >   
> 
> Nope, all ODR values are supported currently, but it's not necessary
> handling all of them from the code. I handle only special cases, like
> ODR limitations in the different power modes. Normal ODR values are
> installed from the IIO userspace stack.

Ok. That's fine then.


> 
> > > + */
> > > +static const struct regmap_config msa311_regmap_config = {
> > > +	.name = MSA311_DRV_NAME,
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.max_register = MSA311_OFFSET_Z,
> > > +	.wr_table = &msa311_writeable_table,
> > > +	.rd_table = &msa311_readable_table,
> > > +	.volatile_table = &msa311_volatile_table,
> > > +	.cache_type = REGCACHE_RBTREE,
> > > +};
> > > +
> > > +/**
> > > + * MSA311_GENMASK() - MSA311 reg_field mask generator
> > > + *
> > > + * @field: requested regfield from msa311_reg_fields table
> > > + *
> > > + * @return: This helper returns reg_field mask to be applied.
> > > + */
> > > +#define MSA311_GENMASK(field) ({                \
> > > +	typeof(field) _field = (field);       \
> > > +	GENMASK(msa311_reg_fields[_field].msb,  \
> > > +		msa311_reg_fields[_field].lsb); \
> > > +})
> > > +
> > > +/**
> > > + * struct msa311_priv - MSA311 internal private state
> > > + * @i2c: I2C client object
> > > + * @lock: State guard  
> > 
> > What state?  Need to be very clear what this covers.  There doesn't seem
> > to be a lot of state to guard.  Possibly it's about read modify write
> > cycles, but that's not what this implies.
> >   
> 
> This lock mainly protects register access from different processes.
> We can access different registers during several userspace actions,
> like iio_readdev, iio_attr, iio_reg, etc.
> I've checked regmap code more careful and saw regmap_lock abstraction.
> Looks like it should be enough for me, so I can delete this one and use
> regmap_lock instead.

If you have non trivial read modify write (i.e. you need to do something
inbetween) then it's fine to have a local lock, but then the comment needs
to make that clear.  State is too vague a comment.

> 
> > > + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> > > + *                 to notify external consumers a new sample is ready
> > > + * @new_data_trig_enabled: NEW_DATA interrupt driver trigger state,
> > > + *                         can be changed by trigger->ops->set_trigger_state()
> > > + * @regs: Underlying I2C bus adapter used to abstract slave
> > > + *        register accesses
> > > + * @fields: Abstract objects for each registers fields access
> > > + */
> > > +struct msa311_priv {
> > > +	struct i2c_client *i2c;
> > > +	struct mutex lock; /* state guard */
> > > +
> > > +	struct iio_trigger *new_data_trig;
> > > +	bool new_data_trig_enabled;
> > > +
> > > +	struct regmap *regs;
> > > +	struct regmap_field *fields[F_MAX_FIELDS];
> > > +};

> 
> > > +};
> > > +
> > > +/**
> > > + * MSA311_ACCEL_CHANNEL() - Construct MSA311 accelerometer channel descriptor
> > > + *
> > > + * @axis: axis name in uppercase
> > > + */
> > > +#define MSA311_ACCEL_CHANNEL(axis) {                           \
> > > +	.type = IIO_ACCEL,                                     \
> > > +	.modified = 1,                                         \
> > > +	.channel2 = IIO_MOD_##axis,                            \
> > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),          \
> > > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
> > > +				BIT(IIO_CHAN_INFO_SAMP_FREQ),  \
> > > +	.scan_index = MSA311_SI_##axis,                        \
> > > +	.scan_type = {                                         \
> > > +		.sign = 's',                                   \
> > > +		.realbits = 12,                                \
> > > +		.storagebits = 16,                             \
> > > +		.shift = 4,                                    \
> > > +		.endianness = IIO_LE,                          \  
> > 
> > Looks like you are unwinding the endianness of the data in the driver. You
> > should not be doing that.
> >   
> 
> Do you mean it's better to just apply IIO_CPU type and IIO core will
> resolve this question automatically?
> I'm talking about the function iio_show_fixed_type() from
> drivers/iio/industrialio-buffer.c.

No.  You should not be doing the endian conversion in the buffered
read paths, but do have to do them for the read_raw path because
read_raw can return a mess of different forms of data, (integer,
decimal, fraction and others) so there isn't a single definition of
what endian conversion would even mean for that.

> 
> > > +	},                                                     \
> > > +	.datasheet_name = "ACC_"#axis                          \
> > > +}


> > > +
> > > +/**
> > > + * msa311_set_odr() - Setup Output Data Rate (ODR) value for MSA311 accel
> > > + *
> > > + * @msa311: MSA311 internal private state
> > > + * @odr: requested ODR value
> > > + *
> > > + * This function should be called under msa311->lock. Possible ODR values:
> > > + *     - 1Hz (not available in normal mode)
> > > + *     - 1.95Hz (not available in normal mode)
> > > + *     - 3.9Hz
> > > + *     - 7.81Hz
> > > + *     - 15.63Hz
> > > + *     - 31.25Hz
> > > + *     - 62.5Hz
> > > + *     - 125Hz
> > > + *     - 250Hz
> > > + *     - 500Hz (not available in low power mode)
> > > + *     - 1000Hz (not available in low power mode)
> > > + *
> > > + * @return: 0 on success, -EINVAL for bad ODR value in the certain power mode,
> > > + *          -ERRNO in other failures
> > > + */
> > > +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
> > > +{
> > > +	const char *mode = NULL;
> > > +	unsigned int pwr_mode;
> > > +	bool good_odr = false;
> > > +	int err;
> > > +
> > > +	err = regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
> > > +	if (err) {
> > > +		dev_err(&msa311->i2c->dev, "failed to read pwr_mode (%d)\n",
> > > +			err);
> > > +		return err;
> > > +	}
> > > +
> > > +	/* Filter bad ODR values */
> > > +	switch (pwr_mode) {
> > > +	case MSA311_PWR_MODE_LOW:  
> > 
> > I can't see where the mode is set to LOW. As such, perhaps this is support
> > to add later?
> >   
> 
> I'm not sure we will use LOW mode for any flow. Do you think LOW pwr
> mode should fall through to unknown default branch?

Sounds good.  If we can get there via some initial state then
you may want to make sure we aren't in that mode. (I don't
think that's the case but haven't checked closely).


> 
> > > +		mode = "low";
> > > +		good_odr = (odr < MSA311_ODR_500_HZ);
> > > +		break;
> > > +	case MSA311_PWR_MODE_NORMAL:
> > > +		mode = "normal";
> > > +		good_odr = (odr > MSA311_ODR_1_95_HZ);
> > > +		break;
> > > +	case MSA311_PWR_MODE_SUSPEND:
> > > +		mode = "suspend";
> > > +		break;
> > > +	default:
> > > +		mode = "unknown";
> > > +		break;
> > > +	}
> > > +
> > > +	if (!good_odr) {
> > > +		dev_err(&msa311->i2c->dev,
> > > +			"failed to set odr %u.%uHz, not available in %s mode\n",
> > > +			msa311_odr_table[odr].val,
> > > +			msa311_odr_table[odr].val2 / 1000, mode);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	err = regmap_field_write(msa311->fields[F_ODR], odr);
> > > +	if (err)
> > > +		dev_err(&msa311->i2c->dev, "failed to set odr value (%d)\n",
> > > +			err);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +/**
> > > + * msa311_wait_for_next_data() - Wait next accel data available after resume
> > > + *
> > > + * @msa311: MSA311 internal private state
> > > + *
> > > + * @return: 0 on success, -EINTR if msleep() was interrupted,
> > > + *          -ERRNO in other failures
> > > + */
> > > +static int msa311_wait_for_next_data(struct msa311_priv *msa311)
> > > +{
> > > +	static const int unintr_thresh_ms = 20;
> > > +	unsigned int odr;
> > > +	unsigned long wait_ms;
> > > +	unsigned long freq_uhz;
> > > +	int err;
> > > +
> > > +	err = msa311_get_odr(msa311, &odr);
> > > +	if (err) {
> > > +		dev_warn(&msa311->i2c->dev,
> > > +			 "cannot get actual freq (%d)\n", err);
> > > +		/* Use lowest Output Data Rate, this is not fatal error */  
> > 
> > Say why this error can happen.  To me it looks like a comms failure so
> > it might as well be fatal.
> >   
> 
> Function msa311_wait_for_next_data() is used from power mode transition
> flow (SUSPEND -> NORMAL) to achieve actual accel data after resume is
> done. I suppose it's better to work on the lowest ODR than not work at
> all and stay in the SUSPEND mode.

Hmm. Trying to carry on when you've had a comms failure is always hit
and miss. Often we just assume the state is invalid and that other
stuff might not work after comms has broken once.

If you want to paper over this one case, then I guess I don't really mind,
just seems like it's probably not worth the effort.


> 
> > > +
> > > +	err = regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
> > > +	if (err) {
> > > +		dev_err(&msa311->i2c->dev,
> > > +			"cannot %s buffer due to new_data_int failure (%d)\n",
> > > +			state ? "enable" : "disable", err);
> > > +		if (state) {
> > > +			mutex_unlock(&msa311->lock);
> > > +			msa311_powerdown(msa311);
> > > +			return err;
> > > +		}
> > > +	}
> > > +
> > > +	mutex_unlock(&msa311->lock);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +/**
> > > + * msa311_reenable() - IIO trigger interface to reenable trigger interrupt
> > > + *
> > > + * @trig: The IIO device trigger wanted to reenable
> > > + */
> > > +static void msa311_reenable(struct iio_trigger *trig)
> > > +{
> > > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > > +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> > > +	int err;
> > > +
> > > +	mutex_lock(&msa311->lock);
> > > +
> > > +	/* Reset all latched interrupts */  
> > 
> > Should only be resetting interrupts related to the trigger.  Otherwise you have
> > a race against handling of other interrupts (once added).
> >   
> 
> Unfortunately, MSA311 has only one IRQ (multifunctional).
> You can enable different IRQ functions through the IRQ event mapping,
> but from hardware perspective it will be only one IRQ.
> It means MSA311 can reset only one IRQ line with all enabled functions
> together.

That's fairly normal.  But generally if you get an interrupt, you
have a status field (often write one to clear) and if you clear
the interrupt that you read and have handled from that status, the
interrupt line remains active, so you immediately reenter the handler.

If you have an edge interrupt (which is nasty for this sort of shared
wire case) then you should really do a dance where you clear the
interrupts you think you have dealt with and then check to see if
there are any others - deal with them - then clear them etc
until none are set.

Otherwise you tend to get race conditions.  Even if there aren't any
it's not immediately obvious to a reviewer and making reviewers think
hard is never popular :)

> 
> > > +	err = regmap_field_write(msa311->fields[F_RESET_INT], 1);
> > > +
> > > +	mutex_unlock(&msa311->lock);
> > > +
> > > +	if (err)
> > > +		dev_err(&msa311->i2c->dev,
> > > +			"cannot reset all latched interrupts (%d)\n", err);
> > > +}
> > > +
> > > +/**
> > > + * msa311_validate_device() - IIO trigger interface to validate requested device
> > > + *
> > > + * @trig: Appropriate IIO trigger
> > > + * @indio_dev: Requested IIO device
> > > + *
> > > + * @return: 0 on success,
> > > + *         -EINVAL when indio_dev isn't linked with appropriate trigger
> > > + */
> > > +static int msa311_validate_device(struct iio_trigger *trig,
> > > +				  struct iio_dev *indio_dev)
> > > +{
> > > +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> > > +
> > > +	if (indio != indio_dev)
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * msa311_buffer_thread() - IIO buffer thread to push channels actual data
> > > + *
> > > + * @irq:  The software interrupt assigned to @p
> > > + * @p: The IIO poll function dispatched by external trigger our device is
> > > + *     attached to.
> > > + *
> > > + * @return: IRQ_HANDLED all the time
> > > + */
> > > +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> > > +	const struct iio_chan_spec *chan;
> > > +	unsigned int axis;
> > > +	int bit = 0, err, i = 0;
> > > +
> > > +	/* Ensure correct alignment of time stamp when present */
> > > +	struct {
> > > +		s16 channels[MSA311_SI_Z + 1];  
> > 
> > Why +1?  Just to ensure no holes to get zeroing to work?
> >   
> 
> Nope, it's just because MSA311_SI_Z is an index, but we need to declare
> an array for all channels.

Ah. Good point.

> > > +
> > > +	mutex_lock(&msa311->lock);
> > > +
> > > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > +			 indio_dev->masklength) {
> > > +		chan = &msa311_channels[bit];
> > > +		err = msa311_get_axis(msa311, chan, &axis);
> > > +		if (err) {
> > > +			dev_err(&msa311->i2c->dev,
> > > +				"cannot get axis %s (%d)\n",
> > > +				chan->datasheet_name, err);
> > > +			mutex_unlock(&msa311->lock);
> > > +			goto err;
> > > +		}
> > > +		buf.channels[i++] = sign_extend32(axis,
> > > +						  chan->scan_type.realbits - 1);  
> > 
> > That should be up to userspace, not done in kernel which should present the raw data
> > without sign extension.
> > 
> >   
> 
> I agree, it's bad idea to adjust sign bits from buffer raw data
> perspective. But what's about IIO_CHAN_INFO_RAW IIO iface? Is it
> applicable there too? As I see in the libiio channel implementation
> can convert all data to appropriate format (take into account sign and
> endianness values).

For read_raw interface it's necessary to unwind shift etc, just not the buffered
interface.  The thought is that read_raw is generally low perf and it makes
the userspace processing simpler.

> It means we shouldn't extend sign bits for IIO_CHAN_INFO_RAW as well.
> Please correct me if I'm wrong.
> 
> > > +	}
> > > +
> > > +	mutex_unlock(&msa311->lock);
> > > +
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, &buf, pf->timestamp);
> > > +
> > > +err:
> > > +	iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> 
> > > +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> > > +	unsigned int new_data_int_status;
> > > +	int err;
> > > +
> > > +	mutex_lock(&msa311->lock);
> > > +
> > > +	/* TODO: push motion events */
> > > +
> > > +	/* Ack NEW_DATA interrupt */
> > > +	err = regmap_field_read(msa311->fields[F_NEW_DATA_INT],
> > > +				&new_data_int_status);
> > > +
> > > +	mutex_unlock(&msa311->lock);  
> > 
> > I'd expect to see iio_trigger_poll_chained() (one day I'll give
> > that function a better name) in here after we
> > have verified that the interrupt in question was the right one.
> > Note that will break use of top half measurement of timestamp
> > for the buffer so you would need to handle that.
> > 
> >   
> 
> Could you please explain which benefit we have with
> iio_trigger_poll_chained()? Is it lower latency due to top half handling?
> I've deeped into this function and compared it with
> iio_trigger_poll() and looks like the main difference is top/bottom half
> location for trigger handlers. Is that the correct understanding?

Yes.  The idea is you first check what the interrupt is and only
then act on it if it is a trigger rather than something else.
That can only happen in the thread.

> 
> > > +
> > > +	if (err)
> > > +		dev_err(&msa311->i2c->dev,
> > > +			"cannot retrieve new_data interrupt status (%d)\n",
> > > +			err);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}

...

> > > +
> > > +	err = msa311_suspend_mode(msa311);
> > > +	if (err) {
> > > +		dev_err(&msa311->i2c->dev,
> > > +			"bad suspend pwr mode transition (%d)\n", err);
> > > +		goto err_lock_destroy;
> > > +	}
> > > +
> > > +	err = pm_runtime_set_active(&i2c->dev);  
> > 
> > I'm confused. You seem to have suspended the chip then specified that it is not
> > suspended to runtime_pm.
> >   
> 
> Yes, because of using autosuspend pm flow.
> But maybe pm_runtime_set_active() is an extra step, because we don't use
> any register communication before auto-suspend event raising up.

Maybe pm_runtime_set_suspended()?  That should avoid auto suspending
a device that is already autosuspended.  Mind you I get lost in
runtime pm sometimes so that might not work how I think it does...

> 
> > > + * @dev: Device object associated with MSA311
> > > + *
> > > + * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try later  
> > 
> > This is new syntax to me. It 'might' be fine but please run the kernel-doc
> > build script on the whole file and fix any warnings.
> >   
> 
> I've run kernel-doc with dtb checkers, they didn't show any errors or warnings.
> This is reguired step in the our internal patch preparing process.
> 

Fair enough. Guess @return got added when I wasn't looking :)

> 
> > > + */
> > > +static int __maybe_unused msa311_runtime_resume(struct device *dev)  
> > 
> > With changes suggested below you won't need the __maybe_unused on these.
> >   
> 
> I didn't know about pm_ptr() and PTR_IF(). Incredible macro, thank you
> for suggestion!

Only got added recently.  It's indeed and excellent bit of macro magic :)

> > > +
> > > +static const struct i2c_device_id msa311_i2c_id[] = {
> > > +	{ .name = MSA311_DRV_NAME },  
> > 
> > I'd rather see the string here than a define given we are matching
> > on it so good to see what it is directly.
> >   
> 
> I use one string definition for regmap config, i2c device name,
> and i2c driver name. Do you mean I need to duplicate it or
> use different strings?

Same string is fine, but there are some places where explicit matching
is going on like this where hiding it behind a define makes it a bit
trickier to follow the code.  If the content of the string matters
then I think it should be visible at that location.  If it's just
a cookie, or debug info then it's fine to have a define hiding
it's actual content.

Minor thing though, so I'm not that bothered if you really want to use
the define.  Note the compiler may well fuse all the matching strings
anyway.

> I suppose if we can use one string, maybe better to define it in the one place.
> 

> > > +static const struct of_device_id msa311_of_match[] = {
> > > +	{ .compatible = "memsensing,msa311" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, msa311_of_match);
> > > +#else
> > > +#define msa311_of_match NULL
> > > +#endif
> > > +
> > > +static struct i2c_driver msa311_driver = {
> > > +	.driver = {
> > > +		.name = MSA311_DRV_NAME,
> > > +		.owner = THIS_MODULE,
> > > +		.of_match_table = of_match_ptr(msa311_of_match),  
> > 
> > Don't use of_match_ptr(). It prevents use of this table for
> > ACPI PRP0001 based bindings and it's not worth doing just
> > to save a few bytes on non DT systems.
> >   
> 
> Okay. Should I use .acpi_match_table in addition to .of_match_table?
Nope. Just drop of_match_ptr() protection and it will all work with PRP0001.

For .acpi_match_table you would need a valid ACPI device ID and
I doubt anyone has allocated one for this device.

Thanks,

Jonathan
