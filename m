Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15394E243D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346288AbiCUKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbiCUKYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C4C2A6E02
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647858164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPQzv37dAhef7bdDSgkOfAjjIg4+DPr87Bx3nKJPacc=;
        b=QdKLB/HVs2QCAxfOGslQGZLZlGGlvq8CuXsdb5GvZ31gUvUF4ZRTiItuxE/3iJxqLLYmV1
        2F79dxOkYw7kAoHnBHOUoSy9kEQQkz3JWqv25KDsCuz6I362ClEfqPHieNGsOOG/i8Xwu5
        hTf2Z4Fvj9IlQ059zKQ2x+/lvmIkM5U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-oMz7mrr0PweyFqo3K5_ycQ-1; Mon, 21 Mar 2022 06:22:43 -0400
X-MC-Unique: oMz7mrr0PweyFqo3K5_ycQ-1
Received: by mail-ed1-f69.google.com with SMTP id m21-20020a50d7d5000000b00418c7e4c2bbso8372021edj.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GPQzv37dAhef7bdDSgkOfAjjIg4+DPr87Bx3nKJPacc=;
        b=pbjqA6Djm7tgSXldyb+a02hQlXuFT2GJWGfSivpIcQCraTXveSC6m4DaldHBW8CT40
         ktWHDbAXE9JRWyrv3f5nlFHfSOPH7hjd/7zAUuMdJIlwz9div33tmbr6y53+bxT2m3gR
         IcwTHS39SnzpWbNVJvDN7/Q7VlWBIr6pdvweGdveA0TinXWu5QFmfyaWRkdECp1m8LkM
         uMxi8ivzhaoRaj/DCYf8LXf9FH0ZUnAiUDU9A2vUhUvqzUD1zLVzz9cDdkQlgFmEffIi
         OgHgRC9zvumW9aJgdfCUg7hWmXvvFD2x4KUoFaCtBtVdSG3zCD2AUMISfgf1p5e3W0/w
         W1Jw==
X-Gm-Message-State: AOAM532vO6JPOQt3atyPFcnzYiyvChB0rEg9Dw3WW4ErEqpguXskAkLQ
        lcbgQcOgA0dxDJSdm4Rr1Yrjlbb6dQfCsZIPmA8oA+rGPYaWC+D+Xlt6XF5mIDJt3o5r9DswXc8
        r8FViwIVh5gxcAIlUzunKzhAn
X-Received: by 2002:a17:907:7fa2:b0:6d8:2397:42 with SMTP id qk34-20020a1709077fa200b006d823970042mr19971346ejc.218.1647858161933;
        Mon, 21 Mar 2022 03:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze4rxpBzkKnbz8jgrINCyHaGWjCABbtCeMM2cXLikzEb0/ptGMWNAtYF+T6AALQ4pxdlPl6A==
X-Received: by 2002:a17:907:7fa2:b0:6d8:2397:42 with SMTP id qk34-20020a1709077fa200b006d823970042mr19971329ejc.218.1647858161669;
        Mon, 21 Mar 2022 03:22:41 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm7655745edm.90.2022.03.21.03.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 03:22:41 -0700 (PDT)
Message-ID: <2cf4e8b2-dfaa-dd7d-9c00-c7d58eeb367b@redhat.com>
Date:   Mon, 21 Mar 2022 11:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] winmate-fm07-keys: Winmate FM07/FM07P buttons
Content-Language: en-US
To:     Daniel Beer <daniel.beer@tirotech.co.nz>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6237f057.1c69fb81.1689.fec7@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6237f057.1c69fb81.1689.fec7@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 3/21/22 04:16, Daniel Beer wrote:
> Winmate FM07 and FM07P in-vehicle computers have a row of five buttons
> below the display. This module adds an input device that delivers key
> events when these buttons are pressed.
> 
> Signed-off-by: Daniel Beer <daniel.beer@tirotech.co.nz>

Do you have control of the firmware on this device?

If yes then IMHO it would be better to implement this in ACPI
using the intel-hid fw API for this, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/intel/hid.c

Basically you create an ACPI device with one of the HIDs from
the driver. Then on button presses you do an ACPI notify on
that device with a value of 0xc0 then the driver will call 
the device's _DSM (device specific ACPI) method with a GUID
of eeec56b3-4442-408f-a792-4edd4d758054 and an argument value
of INTEL_HID_DSM_HDEM_FN and then you return the event-code
for the button.

You can remap the event-codes to different KEY_FOO values using
/lib/udev/hwdb.d/60-keyboard.hwdb

Regards,

Hans




> ---
>  drivers/platform/x86/Kconfig             |   8 +
>  drivers/platform/x86/Makefile            |   3 +
>  drivers/platform/x86/winmate-fm07-keys.c | 184 +++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 drivers/platform/x86/winmate-fm07-keys.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 24deeeb29af2..62a5754d6ac9 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1138,6 +1138,14 @@ config SIEMENS_SIMATIC_IPC
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called simatic-ipc.
>  
> +config WINMATE_FM07_KEYS
> +	tristate "Winmate FM07/FM07P front-panel keys driver"
> +	depends on INPUT
> +	help
> +	  Winmate FM07 and FM07P in-vehicle computers have a row of five
> +	  buttons below the display. This module adds an input device
> +	  that delivers key events when these buttons are pressed.
> +
>  endif # X86_PLATFORM_DEVICES
>  
>  config PMC_ATOM
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c12a9b044fd8..04e7c995b838 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -129,3 +129,6 @@ obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
>  
>  # Siemens Simatic Industrial PCs
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
> +
> +# Winmate
> +obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
> diff --git a/drivers/platform/x86/winmate-fm07-keys.c b/drivers/platform/x86/winmate-fm07-keys.c
> new file mode 100644
> index 000000000000..3e75adb15444
> --- /dev/null
> +++ b/drivers/platform/x86/winmate-fm07-keys.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Driver for the Winmate FM07 front-panel keys
> +//
> +// Author: Daniel Beer <daniel.beer@tirotech.co.nz>
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +#include <linux/dmi.h>
> +#include <linux/io.h>
> +
> +#define DRV_NAME	"winmate-fm07keys"
> +
> +#define PORT_CMD	0x6c
> +#define PORT_DATA	0x68
> +
> +#define EC_ADDR_KEYS	0x3b
> +#define EC_CMD_READ	0x80
> +
> +#define BASE_KEY	KEY_F13
> +#define NUM_KEYS	5
> +
> +/* Typically we're done in fewer than 10 iterations */
> +#define LOOP_TIMEOUT	1000
> +
> +static void fm07keys_poll(struct input_dev *input)
> +{
> +	uint8_t k;
> +	int i;
> +
> +	/* Flush output buffer */
> +	i = 0;
> +	while (inb(PORT_CMD) & 0x01) {
> +		if (++i >= LOOP_TIMEOUT)
> +			goto timeout;
> +		inb(PORT_DATA);
> +	}
> +
> +	/* Send request and wait for write completion */
> +	outb(EC_CMD_READ, PORT_CMD);
> +	i = 0;
> +	while (inb(PORT_CMD) & 0x02)
> +		if (++i >= LOOP_TIMEOUT)
> +			goto timeout;
> +
> +	outb(EC_ADDR_KEYS, PORT_DATA);
> +	i = 0;
> +	while (inb(PORT_CMD) & 0x02)
> +		if (++i >= LOOP_TIMEOUT)
> +			goto timeout;
> +
> +	/* Wait for data ready */
> +	i = 0;
> +	while (!(inb(PORT_CMD) & 0x01))
> +		if (++i >= LOOP_TIMEOUT)
> +			goto timeout;
> +	k = inb(PORT_DATA);
> +
> +	/* Notify of new key states */
> +	for (i = 0; i < NUM_KEYS; i++) {
> +		input_report_key(input, BASE_KEY + i, (~k) & 1);
> +		k >>= 1;
> +	}
> +
> +	input_sync(input);
> +	return;
> +timeout:
> +	dev_err(&input->dev, "timeout polling IO memory\n");
> +}
> +
> +static int fm07keys_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input;
> +	int ret;
> +	int i;
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input) {
> +		dev_err(dev, "no memory for input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (!devm_request_region(dev, PORT_CMD, 1, "Winmate FM07 EC"))
> +		return -EBUSY;
> +	if (!devm_request_region(dev, PORT_DATA, 1, "Winmate FM07 EC"))
> +		return -EBUSY;
> +
> +	input->name = "Winmate FM07 front-panel keys";
> +	input->phys = DRV_NAME "/input0";
> +
> +	input->id.bustype = BUS_HOST;
> +	input->id.vendor = 0x0001;
> +	input->id.product = 0x0001;
> +	input->id.version = 0x0100;
> +
> +	__set_bit(EV_KEY, input->evbit);
> +
> +	for (i = 0; i < NUM_KEYS; i++)
> +		__set_bit(BASE_KEY + i, input->keybit);
> +
> +	ret = input_setup_polling(input, fm07keys_poll);
> +	if (ret) {
> +		dev_err(dev, "unable to set up polling, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	input_set_poll_interval(input, 20);
> +
> +	ret = input_register_device(input);
> +	if (ret) {
> +		dev_err(dev, "unable to register polled device, err=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	input_sync(input);
> +	return 0;
> +}
> +
> +static struct platform_driver fm07keys_driver = {
> +	.probe		= fm07keys_probe,
> +	.driver		= {
> +		.name	= DRV_NAME
> +	},
> +};
> +
> +/************************************************************************
> + * Device instance for the FM07
> + */
> +
> +static struct platform_device *dev;
> +
> +static const struct dmi_system_id fm07keys_dmi_table[] __initconst = {
> +	{
> +		/* FM07 and FM07P */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Winmate Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "IP30"),
> +		},
> +	},
> +};
> +
> +static int __init fm07keys_init(void)
> +{
> +	int ret;
> +
> +	if (!dmi_check_system(fm07keys_dmi_table))
> +		return -ENODEV;
> +
> +	ret = platform_driver_register(&fm07keys_driver);
> +	if (ret) {
> +		pr_err("fm07keys: failed to register driver, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	dev = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +	if (!dev) {
> +		pr_err("fm07keys: failed to allocate device\n");
> +		ret = -ENOMEM;
> +		goto fail_alloc;
> +	}
> +
> +	return 0;
> +fail_alloc:
> +	platform_driver_unregister(&fm07keys_driver);
> +	return ret;
> +}
> +
> +static void __exit fm07keys_exit(void)
> +{
> +	platform_driver_unregister(&fm07keys_driver);
> +	platform_device_unregister(dev);
> +}
> +
> +module_init(fm07keys_init);
> +module_exit(fm07keys_exit);
> +
> +MODULE_AUTHOR("Daniel Beer <daniel.beer@tirotech.co.nz>");
> +MODULE_DESCRIPTION("Winmate FM07 front-panel keys driver");
> +MODULE_LICENSE("GPL v2");

