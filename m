Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291DA55064E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiFRRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiFRRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:17:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0813D66;
        Sat, 18 Jun 2022 10:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33438CE0986;
        Sat, 18 Jun 2022 17:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670B6C3411A;
        Sat, 18 Jun 2022 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655572622;
        bh=7XCDDYfV83xMFA1Nq8ZlvM/SnMA5iCTP9CKgyrzuITY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ua5hSurVhYvagLVmj4e5BG3ry/6fhC+ZrheQkl4FbCNmZk+ecO4eTg3E4ZKp1SaZb
         zhaCcdzdHpzMOqgk8aMLtzhpuN8Qe8QQSy1rC3ZlwLFEJU9pisF4Z9j3Kxw+wx3zqj
         H6ioOzG2BKQZIkZyadTnQRZlBdeXbgfXNmE/I9aQKZwXh1Dera6ryH4+805xh6dnse
         eOyL32HehyDn7ULyg/k5KG7ZHGxAztVpROqnG80SiOSvipmOcXV8vYm4CId5P+UPP3
         Vu/GZmhhKcEAeSwKS4v8q0j9IFMFtQLXE/OVaLKPfqR1kOX3Q6eWHp1oc1yZi+A7qS
         SbG/2WjFklQCA==
Date:   Sat, 18 Jun 2022 18:26:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <andrea.merello@iit.it>
Cc:     <mchehab+huawei@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>
Subject: Re: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20220618182618.4da1df69@jic23-huawei>
In-Reply-To: <20220613120534.36991-9-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
        <20220613120534.36991-9-andrea.merello@iit.it>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 14:05:28 +0200
<andrea.merello@iit.it> wrote:

> From: Andrea Merello <andrea.merello@iit.it>
> 
> Add the core driver for the BNO055 IMU from Bosch. This IMU can be
> connected via both serial and I2C busses; separate patches will add support
> for them.
> 
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also does calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
> 
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass filters
> cut-off frequency and sensors' ranges are fixed, while in AMG mode they can
> be customized; this is why AMG mode can still be interesting.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
Hi Andrea,

A few trivial things from me this time seeing as you are going to be doing a v7.

Thanks,

Jonathan



> +
> +static ssize_t bno055_get_calib_status(struct device *dev, char *buf, int which)
> +{
> +	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +	int calib;
> +	int ret;
> +	int val;
> +
> +	if (priv->operation_mode == BNO055_OPR_MODE_AMG ||
> +	    (priv->operation_mode == BNO055_OPR_MODE_FUSION_FMC_OFF &&
> +	     which == BNO055_CALIB_STAT_MAGN_SHIFT)) {
> +		calib = 0;
> +	} else {
> +		mutex_lock(&priv->lock);
> +		ret = regmap_read(priv->regmap, BNO055_CALIB_STAT_REG, &val);
> +		mutex_unlock(&priv->lock);
> +
> +		if (ret)
> +			return -EIO;
> +
> +		calib = ((val >> which) & BNO055_CALIB_STAT_MASK) + 1;
Hmm. This is an unsual field get.  I wonder if it is good idea to
have what looks like a field mask in BNO055_CALIB_STAT_MASK but isn't
really because we are applying it to a shifted value.  Maybe we 
are better off just encoding it directly here as  GENMASK(1, 0)

> +	}
> +
> +	return sysfs_emit(buf, "%d\n", calib);
> +}
> +

> +#ifdef CONFIG_DEBUG_FS

I'm not particularly keen on ifdef fun in c files. How bad is it if we
just don't bother and use __maybe_unused.  debug_fs_createfile is visible to
the compiler in !CONFIG_DEBUG_FS so it should manage to remove everything
except *_debugfs_reg_access() but that is trivial in size anyway.

> +static int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
> +				     unsigned int writeval, unsigned int *readval)
> +{
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +
> +	if (readval)
> +		return regmap_read(priv->regmap, reg, readval);
> +	else
> +		return regmap_write(priv->regmap, reg, writeval);
> +}
> +
> +static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct bno055_priv *priv = file->private_data;
> +	int rev, ver;
> +	char *buf;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_LSB_REG, &rev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, BNO055_SW_REV_MSB_REG, &ver);
> +	if (ret)
> +		return ret;
> +
> +	buf = kasprintf(GFP_KERNEL, "ver: 0x%x, rev: 0x%x\n", ver, rev);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations bno055_fw_version_ops = {
> +	.open = simple_open,
> +	.read = bno055_show_fw_version,
> +	.llseek = default_llseek,
> +	.owner = THIS_MODULE,
> +};
> +
> +static void bno055_debugfs_remove(void *debugfs)
> +{
> +	debugfs_remove((struct dentry *)debugfs);
> +}
> +
> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
> +{
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +
> +	priv->debugfs = debugfs_create_file("firmware_version", 0400,
> +					    iio_get_debugfs_dentry(iio_dev),
> +					    priv, &bno055_fw_version_ops);
> +
> +	devm_add_action_or_reset(priv->dev, bno055_debugfs_remove, priv->debugfs);
> +}
> +#else
> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
> +{
> +}
> +
> +static int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
> +				     unsigned int writeval, unsigned int *readval)
> +{
> +	return 0;
> +}
> +#endif
> +

...


> +
> +static irqreturn_t bno055_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio_dev = pf->indio_dev;
> +	struct bno055_priv *priv = iio_priv(iio_dev);
> +	int xfer_start, start, end, prev_end;
> +	unsigned long mask;
> +	int quat_extra_len;
> +	bool first = true;
> +	int buf_idx = 0;
> +	bool thr_hit;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/*
> +	 * Walk the bitmap and eventually perform several transfers.
> +	 * Bitmap ones-fields that are separated by gaps <= xfer_burst_break_thr
> +	 * will be included in same transfer.
> +	 * Every time the bitmap contains a gap wider than xfer_burst_break_thr
> +	 * then we split the transfer, skipping the gap.
> +	 */
> +	for_each_set_bitrange(start, end, iio_dev->active_scan_mask,
> +			      iio_dev->masklength) {
> +		/*
> +		 * First transfer will start from the beginning of the first
> +		 * ones-field in the bitmap
> +		 */
> +		if (first) {
> +			xfer_start = start;
> +		} else {
> +			/*
> +			 * We found the next ones-field; check whether to
> +			 * include it in * the current transfer or not (i.e.
> +			 * let's perform the current * transfer and prepare for
> +			 * another one).
> +			 */
> +
> +			/*
> +			 * In case the zeros-gap contains the quaternion bit,
> +			 * then its length is actually 4 words instead of 1
> +			 * (i.e. +3 wrt other channels).
> +			 */
> +			quat_extra_len = ((start > BNO055_SCAN_QUATERNION) &&

you could reduce the scope of quat_extra_len and thr_hit, perhaps
to just within the for loop.  Perhaps it's not worth bothering though. Up to you.


> +					  (prev_end <= BNO055_SCAN_QUATERNION)) ? 3 : 0;
> +
> +			/* If the gap is wider than xfer_burst_break_thr then.. */
> +			thr_hit = (start - prev_end + quat_extra_len) >
> +				priv->xfer_burst_break_thr;
> +
> +			/*
> +			 * .. transfer all the data up to the gap. Then set the
> +			 * next transfer start index at right after the gap
> +			 * (i.e. at the start of this ones-field).
> +			 */
> +			if (thr_hit) {
> +				mask = *iio_dev->active_scan_mask >> xfer_start;
> +				ret = bno055_scan_xfer(priv, xfer_start,
> +						       prev_end - xfer_start,
> +						       mask, priv->buf.chans, &buf_idx);
> +				if (ret)
> +					goto done;
> +				xfer_start = start;
> +			}
> +		}
> +		first = false;
> +		prev_end = end;
> +	}
> +
> +	/*
> +	 * We finished walking the bitmap; no more gaps to check for. Just
> +	 * perform the current transfer.
> +	 */
> +	mask = *iio_dev->active_scan_mask >> xfer_start;
> +	ret = bno055_scan_xfer(priv, xfer_start,
> +			       prev_end - xfer_start,
> +			       mask, priv->buf.chans, &buf_idx);

Check ret and if it's an error don't push the data.

> +
> +	iio_push_to_buffers_with_timestamp(iio_dev, &priv->buf, pf->timestamp);
> +done:
> +	mutex_unlock(&priv->lock);
> +	iio_trigger_notify_done(iio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +

> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +		 int xfer_burst_break_thr, bool sw_reset)
> +{
...

> +
> +	/*
> +	 * The stock FW version contains a bug (see comment at the beginning of
> +	 * this file) that causes the anglvel scale to be changed depending on
> +	 * the chip range setting. We workaround this, but we don't know what
> +	 * other FW versions might do.
> +	 */
> +	if (ver != 0x3 || rev != 0x11)
> +		dev_warn(dev, "Untested firmware version. Anglvel scale may not work as expected\n");
> +
> +	ret = regmap_bulk_read(priv->regmap, BNO055_UID_LOWER_REG,
> +			       priv->uid, BNO055_UID_LEN);
> +	if (ret)
> +		return ret;
> +
> +	/* Sensor calibration data */
> +	fw_name_buf = kasprintf(GFP_KERNEL,
> +				BNO055_FW_UID_FMT,
> +				BNO055_UID_LEN, priv->uid);

No need to break this into so many lines.  Can get it on two without
passing 80 chars.
