Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFC4E3190
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353247AbiCUUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353280AbiCUUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:56 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6877120189
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:13:24 -0700 (PDT)
Date:   Mon, 21 Mar 2022 20:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1647893598;
        bh=IGdEUXBvbEIJrqnow0PzBrVLGZNr2+cSLg3JMi09D3g=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=OEkCQYJYkzF1lwsT3sy0otNm7t7RygZ4XU0ijQ9tnc2x//hYlBflepzwZ9WNUNKbD
         opIIeVwS4ExSrodW2IhmdQUS+yUX/0VUSvqvC9FeLNBAeGk+kYIHL0uTdHR6BBU6kU
         5WK2Z6JI0igHQREvjldFxLJ1iDDuCGt+PeJDbpVvwRyOFvSHZY/hkOtOhvLV5LnjfS
         hOi7tneqkv+mHbOI+6xRnETdk6JZv9NFGH4W/doysmuQaDewQFuoRSKwRSS+WEA6Uh
         9Vq2141nEH+YUAJYmxsDxvkUHi+Pp1GBeLX9mE11zJdN4P29TxLgfjsyHpqK1mZsHt
         QHFrPx3fWOH5Q==
To:     Daniel Beer <daniel.beer@tirotech.co.nz>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] winmate-fm07-keys: Winmate FM07/FM07P buttons
Message-ID: <XgTKv1bHGoFONS2zlwhJAM-CvIm8ZgwA0Nf2UTl0_P38ubTg9hPzJOEP14Kddal_Lxk91kvQuHhi4P0gOAht_c_P847QCqMPeN81xv6mEhY=@protonmail.com>
In-Reply-To: <6237f057.1c69fb81.1689.fec7@mx.google.com>
References: <6237f057.1c69fb81.1689.fec7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. m=C3=A1rcius 21., h=C3=A9tf=C5=91 4:16 keltez=C3=A9ssel, Daniel Beer =
=C3=ADrta:
> Winmate FM07 and FM07P in-vehicle computers have a row of five buttons
> below the display. This module adds an input device that delivers key
> events when these buttons are pressed.
>
> Signed-off-by: Daniel Beer <daniel.beer@tirotech.co.nz>
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
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called simatic-ipc.
>
> +config WINMATE_FM07_KEYS
> +=09tristate "Winmate FM07/FM07P front-panel keys driver"
> +=09depends on INPUT
> +=09help
> +=09  Winmate FM07 and FM07P in-vehicle computers have a row of five
> +=09  buttons below the display. This module adds an input device
> +=09  that delivers key events when these buttons are pressed.
> +
>  endif # X86_PLATFORM_DEVICES
>
>  config PMC_ATOM
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index c12a9b044fd8..04e7c995b838 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -129,3 +129,6 @@ obj-$(CONFIG_PMC_ATOM)=09=09=09+=3D pmc_atom.o
>
>  # Siemens Simatic Industrial PCs
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)=09+=3D simatic-ipc.o
> +
> +# Winmate
> +obj-$(CONFIG_WINMATE_FM07_KEYS)=09=09+=3D winmate-fm07-keys.o
> diff --git a/drivers/platform/x86/winmate-fm07-keys.c b/drivers/platform/=
x86/winmate-fm07-keys.c
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
> +#define DRV_NAME=09"winmate-fm07keys"
> +
> +#define PORT_CMD=090x6c
> +#define PORT_DATA=090x68
> +
> +#define EC_ADDR_KEYS=090x3b
> +#define EC_CMD_READ=090x80

It seems you are reading from the embedded controller, have you checked if =
the
ACPI EC driver works? Then you could probably just use the `ec_{read,write}=
()` functions.


> +
> +#define BASE_KEY=09KEY_F13
> +#define NUM_KEYS=095
> +
> +/* Typically we're done in fewer than 10 iterations */
> +#define LOOP_TIMEOUT=091000
> +
> +static void fm07keys_poll(struct input_dev *input)
> +{
> +=09uint8_t k;
> +=09int i;
> +
> +=09/* Flush output buffer */
> +=09i =3D 0;
> +=09while (inb(PORT_CMD) & 0x01) {
> +=09=09if (++i >=3D LOOP_TIMEOUT)
> +=09=09=09goto timeout;
> +=09=09inb(PORT_DATA);
> +=09}
> +
> +=09/* Send request and wait for write completion */
> +=09outb(EC_CMD_READ, PORT_CMD);
> +=09i =3D 0;
> +=09while (inb(PORT_CMD) & 0x02)
> +=09=09if (++i >=3D LOOP_TIMEOUT)
> +=09=09=09goto timeout;
> +
> +=09outb(EC_ADDR_KEYS, PORT_DATA);
> +=09i =3D 0;
> +=09while (inb(PORT_CMD) & 0x02)
> +=09=09if (++i >=3D LOOP_TIMEOUT)
> +=09=09=09goto timeout;
> +
> +=09/* Wait for data ready */
> +=09i =3D 0;
> +=09while (!(inb(PORT_CMD) & 0x01))
> +=09=09if (++i >=3D LOOP_TIMEOUT)
> +=09=09=09goto timeout;
> +=09k =3D inb(PORT_DATA);
> +
> +=09/* Notify of new key states */
> +=09for (i =3D 0; i < NUM_KEYS; i++) {
> +=09=09input_report_key(input, BASE_KEY + i, (~k) & 1);
> +=09=09k >>=3D 1;
> +=09}
> +
> +=09input_sync(input);
> +=09return;
> +timeout:
> +=09dev_err(&input->dev, "timeout polling IO memory\n");

I think it may be better to use `dev_warn_{ratelimited,once}()` here.


> +}
> +
> +static int fm07keys_probe(struct platform_device *pdev)
> +{
> +=09struct device *dev =3D &pdev->dev;
> +=09struct input_dev *input;
> +=09int ret;
> +=09int i;
> +
> +=09input =3D devm_input_allocate_device(dev);
> +=09if (!input) {
> +=09=09dev_err(dev, "no memory for input device\n");
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09if (!devm_request_region(dev, PORT_CMD, 1, "Winmate FM07 EC"))
> +=09=09return -EBUSY;
> +=09if (!devm_request_region(dev, PORT_DATA, 1, "Winmate FM07 EC"))
> +=09=09return -EBUSY;
> +
> +=09input->name =3D "Winmate FM07 front-panel keys";
> +=09input->phys =3D DRV_NAME "/input0";
> +
> +=09input->id.bustype =3D BUS_HOST;
> +=09input->id.vendor =3D 0x0001;
> +=09input->id.product =3D 0x0001;
> +=09input->id.version =3D 0x0100;
> +
> +=09__set_bit(EV_KEY, input->evbit);
> +
> +=09for (i =3D 0; i < NUM_KEYS; i++)
> +=09=09__set_bit(BASE_KEY + i, input->keybit);
> +
> +=09ret =3D input_setup_polling(input, fm07keys_poll);
> +=09if (ret) {
> +=09=09dev_err(dev, "unable to set up polling, err=3D%d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09input_set_poll_interval(input, 20);

Can you please elaborate how you have arrived at this number?


> +
> +=09ret =3D input_register_device(input);
> +=09if (ret) {
> +=09=09dev_err(dev, "unable to register polled device, err=3D%d\n",
> +=09=09=09ret);
> +=09=09return ret;
> +=09}
> +
> +=09input_sync(input);
> +=09return 0;
> +}
> +
> +static struct platform_driver fm07keys_driver =3D {
> +=09.probe=09=09=3D fm07keys_probe,
> +=09.driver=09=09=3D {
> +=09=09.name=09=3D DRV_NAME
> +=09},
> +};
> +
> +/***********************************************************************=
*
> + * Device instance for the FM07
> + */
> +
> +static struct platform_device *dev;
> +
> +static const struct dmi_system_id fm07keys_dmi_table[] __initconst =3D {
> +=09{
> +=09=09/* FM07 and FM07P */
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Winmate Inc."),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "IP30"),
> +=09=09},
> +=09},
> +};

You should probably add:

  MODULE_DEVICE_TABLE(dmi, fm07keys_dmi_table);


> +
> +static int __init fm07keys_init(void)
> +{
> +=09int ret;
> +
> +=09if (!dmi_check_system(fm07keys_dmi_table))
> +=09=09return -ENODEV;
> +
> +=09ret =3D platform_driver_register(&fm07keys_driver);
> +=09if (ret) {
> +=09=09pr_err("fm07keys: failed to register driver, err=3D%d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09dev =3D platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +=09if (!dev) {

`platform_device_register_simple()` returns an ERR_PTR(), so this should be=
:

  if (IS_ERR(dev)) {
    ret =3D PTR_ERR(dev);
    ...
  }


> +=09=09pr_err("fm07keys: failed to allocate device\n");
> +=09=09ret =3D -ENOMEM;
> +=09=09goto fail_alloc;
> +=09}
> +
> +=09return 0;
> +fail_alloc:
> +=09platform_driver_unregister(&fm07keys_driver);
> +=09return ret;
> +}
> +
> +static void __exit fm07keys_exit(void)
> +{
> +=09platform_driver_unregister(&fm07keys_driver);
> +=09platform_device_unregister(dev);
> +}
> +
> +module_init(fm07keys_init);
> +module_exit(fm07keys_exit);
> +
> +MODULE_AUTHOR("Daniel Beer <daniel.beer@tirotech.co.nz>");
> +MODULE_DESCRIPTION("Winmate FM07 front-panel keys driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.30.2


Regards,
Barnab=C3=A1s P=C5=91cze
