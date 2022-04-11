Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4854FBC46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiDKMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbiDKMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802DE26545
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649680761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nA3CtNRCA0UufTEt113jych7eO+TCXjgMtNbeSmlQMk=;
        b=hyhp7GRJXc0owse+lQGhN3w4Zk2V8+KNJhhByrNH2JJ0lZ8XSNKhibUlFhwGvUL7dmGtJ3
        rE8oq2cYCA5EEwnHo4r+c+JZW2EgYDP0CtJvTFO2BEKdb1tlUZjS3AlC08I0bOdGpPV3a3
        xvm7cmbKaLG+kkmSBZMyGcwfo8hxwkw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-pmv8miCnN8K-ekzvvyOtHw-1; Mon, 11 Apr 2022 08:39:20 -0400
X-MC-Unique: pmv8miCnN8K-ekzvvyOtHw-1
Received: by mail-ej1-f72.google.com with SMTP id qk32-20020a1709077fa000b006e7b83dc82fso6980601ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nA3CtNRCA0UufTEt113jych7eO+TCXjgMtNbeSmlQMk=;
        b=JU4RGhQyLy1MbGOh2oiUqS7Z9FLNtqZQ1cnK9MykjTdFqRGr7mpUOEIGZMWxCrrCj7
         JroiTps185/5BzXRxrdMKJsPo3Z1DCQ2vtA9oRJldc2oBCbjZUaJpv6DDTMSnPctAh97
         ce1V4nnpvtygZ3lK4YhkY6gG/MCI/9USknHMGXfd3ra35rupKRGm6TZb5ePqHcGeJcBS
         79JAvmC75phYyUgTsmU+KwMYeIlpm/dO+Twm5lGHKJeFRNAOs3jtL6QxFVu8MJLQCgef
         bzusO+YGw+dbcZ3aBVCchKCOZQDGxc9H6MJStpN826hrX28wyBUwxg3i75DX0hWYfUIs
         TIHw==
X-Gm-Message-State: AOAM53206RqUyGkW0hjU2eT1lt7+8wQWgCX3j+DcWitD/gUyHxCq/dHW
        W+9ceiNgqvfVUTP85RxbNze8tw9k1BT94zuN+E3PRVIyyPuLDQc5zDKPdK/JaLDYEgC9Rt5pl07
        p2br3dgMNntXYC80HY9Dzlx6h
X-Received: by 2002:a05:6402:d62:b0:41d:79e6:1617 with SMTP id ec34-20020a0564020d6200b0041d79e61617mr5824343edb.378.1649680758857;
        Mon, 11 Apr 2022 05:39:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUjRFzwg8G2sDhHFiZJd6i9tKywIZzxI02eAWGeefUREJ3DQmQJ9t/0FLMxLAtpRrHX4pUmw==
X-Received: by 2002:a05:6402:d62:b0:41d:79e6:1617 with SMTP id ec34-20020a0564020d6200b0041d79e61617mr5824321edb.378.1649680758654;
        Mon, 11 Apr 2022 05:39:18 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm14987722edu.11.2022.04.11.05.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 05:39:18 -0700 (PDT)
Message-ID: <f9ab29c1-24f2-66d7-8b13-222c0d110a92@redhat.com>
Date:   Mon, 11 Apr 2022 14:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] winmate-fm07-keys: Winmate FM07/FM07P buttons
Content-Language: en-US
To:     Daniel Beer <daniel.beer@tirotech.co.nz>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <623a110a.1c69fb81.64f39.0118@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <623a110a.1c69fb81.64f39.0118@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/21/22 04:16, Daniel Beer wrote:
> Winmate FM07 and FM07P in-vehicle computers have a row of five buttons
> below the display. This module adds an input device that delivers key
> events when these buttons are pressed.
> 
> Signed-off-by: Daniel Beer <daniel.beer@tirotech.co.nz>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> Changes in v2:
>   - Ratelimit message on poll timeout.
>   - Explain polling rate.
>   - Fix fm07keys_dmi_table and add missing macro.
>   - Fix check of platform_device_register_simple return value.
> 
>  drivers/platform/x86/Kconfig             |   8 +
>  drivers/platform/x86/Makefile            |   3 +
>  drivers/platform/x86/winmate-fm07-keys.c | 189 +++++++++++++++++++++++
>  3 files changed, 200 insertions(+)
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
> index 000000000000..8c03a4d171b8
> --- /dev/null
> +++ b/drivers/platform/x86/winmate-fm07-keys.c
> @@ -0,0 +1,189 @@
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
> +
> +timeout:
> +	dev_warn_ratelimited(&input->dev, "timeout polling IO memory\n");
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
> +	/* These are silicone buttons. They can't be pressed in rapid
> +	 * succession too quickly, and 50 Hz seems to be an adequate
> +	 * sampling rate without missing any events when tested.
> +	 */
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
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(dmi, fm07keys_dmi_table);
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
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		pr_err("fm07keys: failed to allocate device, err = %d\n", ret);
> +		goto fail_register;
> +	}
> +
> +	return 0;
> +
> +fail_register:
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

