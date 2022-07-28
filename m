Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA1583BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiG1KFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbiG1KFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:05:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1405247A;
        Thu, 28 Jul 2022 03:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 577CFB82398;
        Thu, 28 Jul 2022 10:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB8FC433B5;
        Thu, 28 Jul 2022 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659002726;
        bh=bHkAUUJ8s9fL6+SCkEHpALg68TWhAv30Y5oWcfi3Dyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr0udpQzvizSkLpGfOnZu9Jg/2C1UycmicxD2MmCsRua5PnQSkwyD08NzFdVUqOUD
         8HfDlwWGck0JNcu4CQbKOg0mnDvt2aAKP3b1mO3pu8pHCZJFcFqnMLYYItVrOdZBxm
         mw+37B/L9RAnpDjLIPusQlDxTbTW0eyVGIDwhouc=
Date:   Thu, 28 Jul 2022 12:05:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, elder@linaro.org,
        f.fainelli@gmail.com, linus.walleij@linaro.org,
        Michael.Srba@seznam.cz, jeffrey.l.hugo@gmail.com,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH RFC v1 1/2] bus: add Wiegand write-only GPIO driver
Message-ID: <YuJfY1sfYQgKVQa7@kroah.com>
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220728091712.13395-1-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:17:11AM +0200, Martin Zaťovič wrote:
> +static dev_t base_devno;
> +static int max_devices = 1;
> +static struct class *wiegand_gpio_cl;

No need for your own class and stuff, just use the misc_device interface
and dynamically create a device node that way.  It will make your code
much simaller and simpler overall.


> +static unsigned int wiegand_gpio_get_payload_size(
> +						unsigned long payload_len_bits,
> +						enum wiegand_format fmt)
> +{
> +	unsigned int ret;
> +
> +	if (fmt == WIEGAND_CUSTOM)
> +		ret = wiegand_gpio_calc_bytes(payload_len_bits);
> +	else
> +		/* add 2 for parity bits */
> +		ret = wiegand_gpio_calc_bytes(payload_len_bits + 2);
> +
> +	return ret;
> +}
> +
> +static int wiegand_gpio_calc_parity8(uint8_t v)

Note, "unit8_t" is not a real kernel type, please just use u8 for this
(and all other variable types you have here.)  The "_t" types are for
userspace code only, doesn't really belong in the kernel.

And yes, I know, there are lots of in-kernel users, but no need to make
more when you don't have to.

> +{
> +	v = (v >> 4) ^ (v & ((1 << 4)-1));
> +	v = (v >> 2) ^ (v & ((1 << 2)-1));
> +	v = (v >> 1) ^ (v & ((1 << 1)-1));
> +	return v;
> +}
> +
> +static void wiegand_gpio_add_parity_to_data(unsigned char *tmp, uint8_t *data,
> +						enum wiegand_format fmt)
> +{
> +	switch (fmt) {
> +	case WIEGAND_V26:
> +		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
> +						tmp[0] ^ (tmp[1] & 0xf0)) << 7);
> +		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
> +		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
> +		data[3] = (tmp[2] << 7) | (!wiegand_gpio_calc_parity8(
> +						(tmp[1] & 0x0f) ^ tmp[2]) << 6);
> +
> +#ifdef DEBUG
> +		printk(KERN_DEBUG
> +			"%s: d[%02x,%02x,%02x] -> w[%02x,%02x,%02x,%02x]\n",
> +			__func__,
> +			tmp[0], tmp[1], tmp[2],
> +			data[0], data[1],
> +			data[2], data[3]);
> +#endif

dev_dbg() is your friend, no need for any #ifdef comments.  As you have
a real device everywhere, always use dev_*() calls, never a raw printk()
or pr_*() call.

Also with dev_dbg(), no need for the addition of __func__ as it's added
automatically by the kernel if you ask for it.

> +static int wiegand_gpio_open(struct inode *ino, struct file *filp)
> +{
> +	struct wiegand_gpio_device *wiegand_gpio;
> +	struct wiegand_gpio_instance *info;
> +	int rc;
> +
> +	wiegand_gpio = container_of(ino->i_cdev,
> +			struct wiegand_gpio_device, cdev);
> +
> +	mutex_lock(&wiegand_gpio->mutex);
> +
> +	/* Only one device instance allowed */
> +	if (wiegand_gpio->flags) {

This check really will not work, sorry.  Don't worry about userspace
trying to open the device node multiple times, you can't prevent this,
and any kernel code that tries to is wrong (think about duplicating a
file handle and passing it to other processes...)

So just don't care, if userspace wants to do something foolish like
this, let it, it will have to deal with the pieces when things fall
apart :)


> +static ssize_t store_ulong(unsigned long *val, const char *buf,
> +				size_t size, unsigned long max)
> +{
> +	int ret;
> +	unsigned long new;
> +
> +	ret = kstrtoul(buf, 0, &new);
> +	if (ret)
> +		return ret;
> +	if (max != 0 && new > max)
> +		return -EINVAL;
> +
> +	*val = new;
> +	return size;
> +}

We have this function in the kernel already, right?

> +
> +/* sysfs functions */
> +static ssize_t show_ulong(unsigned long val, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%lu\n", val);

sysfs_emit() please.

Also, you have sysfs files in this driver, but no Documentation/ABI
entries, which is always needed.

> +}
> +
> +ssize_t pulse_len_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
> +
> +	if (!device)
> +		return -ENODEV;
> +
> +	return show_ulong(device->setup.pulse_len, buf);

Just do a sysfs_emit(), no need for the show_ulong() call.

> +static int wiegand_gpio_dev_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct wiegand_gpio_device *wiegand_gpio;
> +	struct wiegand_gpio_platform_data *pdata = pdev->dev.platform_data;
> +
> +	if (!pdata) {
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +	}
> +
> +	wiegand_gpio = kzalloc(sizeof(struct wiegand_gpio_device), GFP_KERNEL);
> +	if (!wiegand_gpio)
> +		return -ENOMEM;
> +
> +	wiegand_gpio->dev = &pdev->dev;
> +
> +	/* Initialize character device */
> +	cdev_init(&wiegand_gpio->cdev, &wiegand_gpio_fops);
> +	wiegand_gpio->cdev.owner = THIS_MODULE;
> +
> +	rc = cdev_add(&wiegand_gpio->cdev, MKDEV(MAJOR(base_devno),
> +				pdev->id == -1 ? 0 : pdev->id), 1);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "Failed to allocate cdev: %d\n", rc);
> +		kfree(wiegand_gpio);
> +		return rc;
> +	}
> +
> +	wiegand_gpio->dev->devt = wiegand_gpio->cdev.dev;
> +	mutex_init(&wiegand_gpio->mutex);
> +
> +	/* Get GPIO lines using device tree bindings. */
> +	wiegand_gpio->gpio_data_lo = devm_gpiod_get(wiegand_gpio->dev,
> +			"wiegand-data-lo", GPIOD_OUT_HIGH);
> +	if (IS_ERR(wiegand_gpio->gpio_data_lo)) {
> +		dev_info(wiegand_gpio->dev,
> +			"Failed to get wiegand-data-lo pin.\n");

dev_err()?

> +		return PTR_ERR(wiegand_gpio->gpio_data_lo);

You also just leaked memory :(

> +	}
> +	wiegand_gpio->gpio_data_hi = devm_gpiod_get(wiegand_gpio->dev,
> +			"wiegand-data-hi", GPIOD_OUT_HIGH);
> +	if (IS_ERR(wiegand_gpio->gpio_data_hi)) {
> +		dev_info(wiegand_gpio->dev,
> +			"Failed to get wiegand-data-hi pin.\n");

dev_err()?

> +		return PTR_ERR(wiegand_gpio->gpio_data_hi);

memory leak :(

> +	}
> +
> +	memcpy(&wiegand_gpio->setup, &WIEGAND_SETUP,
> +			sizeof(struct wiegand_setup));
> +
> +	platform_set_drvdata(pdev, wiegand_gpio);
> +
> +	dev_info(&pdev->dev, "devno=%d:%d\n",
> +		 MAJOR(wiegand_gpio->dev->devt),
> +		 MINOR(wiegand_gpio->dev->devt));

When drivers work properly, they are quiet, no need for this.  Make it
dev_dbg() if you really want it.

> +
> +	rc = device_create_file(wiegand_gpio->dev, &dev_attr_pulse_len);
> +	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_interval_len);
> +	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_frame_gap);
> +	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_format);
> +	rc |= device_create_file(wiegand_gpio->dev,
> +				&dev_attr_payload_len);
> +	if (rc != 0)
> +		dev_warn(&pdev->dev,
> +				"Failed to register attribute files(%d)\n", rc);

Use an attribute group please.

Also, you just raced with userspace and lost, never create/remove your
own sysfs files.  Have the driver core do it automatically for you in a
safe way (also less code for you to write.)  Use the default_groups
attribute of the platform device please.

> +static int __init wiegand_gpio_init(void)
> +{
> +	int rc;
> +	struct device *wiegand_device;
> +	struct class *cl;
> +
> +	rc = alloc_chrdev_region(&base_devno, 0, max_devices, "wiegand-gpio");
> +	if (rc < 0) {
> +		pr_err("%s: Failed to allocate chardev region: %d\n",
> +			__func__, rc);
> +		return rc;
> +	}
> +
> +	cl = class_create(THIS_MODULE, "chardrv");

Very generic name for a specific driver :)

Anyway, as mentioned above, this is not needed at all, just use the misc
device layer instead.  Much simpler code overall.


> +	if (IS_ERR(cl)) {
> +		pr_err("Failed to create a class for character device");
> +		unregister_chrdev_region(base_devno, max_devices);
> +		return PTR_ERR(cl);
> +	}
> +	wiegand_gpio_cl = cl;
> +
> +	wiegand_device = device_create(cl, NULL, base_devno, NULL,
> +			"wiegand-gpio");
> +	if (IS_ERR(wiegand_device)) {
> +		class_destroy(cl);
> +		unregister_chrdev_region(base_devno, max_devices);
> +		return PTR_ERR(wiegand_device);
> +	}
> +
> +	rc = platform_driver_register(&wiegand_gpio_driver);
> +	if (rc < 0) {
> +		pr_err("Error %d while registering wiegand-gpio driver\n", rc);
> +		unregister_chrdev_region(base_devno, max_devices);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit wiegand_gpio_exit(void)
> +{
> +	platform_driver_unregister(&wiegand_gpio_driver);
> +	unregister_chrdev_region(base_devno, max_devices);
> +	device_destroy(wiegand_gpio_cl, base_devno);
> +	class_destroy(wiegand_gpio_cl);
> +}
> +
> +module_init(wiegand_gpio_init);
> +module_exit(wiegand_gpio_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
> +MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
> diff --git a/drivers/bus/wiegand-gpio.h b/drivers/bus/wiegand-gpio.h
> new file mode 100644
> index 000000000000..f0f389d5bfec
> --- /dev/null
> +++ b/drivers/bus/wiegand-gpio.h

No need for a .h file for only a single .c file.  Put this all in the
driver file itself.

thanks,

greg k-h
