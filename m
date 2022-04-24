Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2050D320
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiDXQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDXQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:09:33 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676AAFB0F;
        Sun, 24 Apr 2022 09:06:32 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e2442907a1so13758587fac.8;
        Sun, 24 Apr 2022 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7RcpU21sr3A5Ii7IS+GL1m3DU+NuQDKU4BJWtyW6BQ=;
        b=Inf2BfhgRtrpcn7sKATwA1wqofAnldBDrvuEIBBxnRxGWClaNx4LeKWi63ulhg+PyS
         36GXunBx4rd5JCw56OL5po0LUG7rOkOUVe+P7AVxW8SBDRzR0wQmow85ZX2+G6lDuThJ
         81AmJE/b6G0xh2suIhszUDW0SFTLEZcyubJjzBSdKLDSRFI3MYnS8hP8qtLACiz+fghr
         esQ+9Pu18sarykkNfIZ0SFk9VHpouknTQqVmTdTBUsj3EPciHxK7mrUX6OnUKhs0hybO
         rHutipAE21irjABtpqSzVAVWlfTx2ifZauIfph7UQ9zKbBrS1syaZTkIgl4uQUydFOmR
         DP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=E7RcpU21sr3A5Ii7IS+GL1m3DU+NuQDKU4BJWtyW6BQ=;
        b=xshmDBoUxNJTDquz/Js8edGPzG5nWTAbY+IU0k7brUJdDAQbuGLlJXWt6Bi2q0qVIi
         Rlj/36kp/0duMrP9kgvwhHNDEOu38o2xAwe8RnJOYox6IosEyCPOahC7VoivYYg8mXMF
         fH2gi7galQDwQGCzwC6MCmnhGmp27Jx62ey15oO6b624HRwWrZycriIPMy3btMTND3WN
         tnp6aKdgam68KzaEgpCjP8fWwCm/3YKK2Eh+K58gzrly93nrATpC7CixErpLGOTWbyXw
         WZTEepEkRVR9G6ovrL/pHv0W2wzgTlA+GejpsPstwGL4IxPh4RsixOYgHHVXrmYCLzPc
         800w==
X-Gm-Message-State: AOAM532x/90ogIgiReLkX/JWSc1rN969Kk603Dt35C5nCROqjhamnkov
        aOwcHbrL/hQo5IbTn2A7pgF5vdbfVAc=
X-Google-Smtp-Source: ABdhPJxpowHhVGu29hb/tVxPU9nUiQ8kQ6wYnTgSiinq4/d3dAjEE2bmFi19bwpWORgx8XbmYNXjjA==
X-Received: by 2002:a05:6870:1607:b0:de:984:496e with SMTP id b7-20020a056870160700b000de0984496emr5653419oae.290.1650816390783;
        Sun, 24 Apr 2022 09:06:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020a4a7642000000b0033a2cdbe62fsm3267444ooe.45.2022.04.24.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:06:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 09:06:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jack Doan <me@jackdoan.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <20220424160628.GA719092@roeck-us.net>
References: <YmTcrq8Gzel0zYYD@jackdesk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmTcrq8Gzel0zYYD@jackdesk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:14:22AM -0500, Jack Doan wrote:
> Extend aquacomputer_d5next driver to expose hardware
> temperature sensors of the Aquacomputer Farbwerk RGB controller, which
> communicates through a proprietary USB HID protocol.
> 
> Four temperature sensors are available. Additionally, serial number and
> firmware version are exposed through debugfs.
> 
> Also, add Jack Doan to MAINTAINERS for this driver.
> 
> Signed-off-by: Jack Doan <me@jackdoan.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
>   - update Kconfig so it applies cleanly
>   - add "select CRC16" to Kconfig
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
>  MAINTAINERS                                 |  1 +
>  drivers/hwmon/Kconfig                       |  5 +--
>  drivers/hwmon/aquacomputer_d5next.c         | 37 ++++++++++++++++++---
>  4 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index e69f718caf5b..717e28226cde 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -6,6 +6,7 @@ Kernel driver aquacomputer-d5next
>  Supported devices:
>  
>  * Aquacomputer D5 Next watercooling pump
> +* Aquacomputer Farbwerk RGB controller
>  * Aquacomputer Farbwerk 360 RGB controller
>  * Aquacomputer Octo fan controller
>  
> @@ -32,7 +33,7 @@ better suited for userspace tools.
>  The Octo exposes four temperature sensors and eight PWM controllable fans, along
>  with their speed (in RPM), power, voltage and current.
>  
> -The Farbwerk 360 exposes four temperature sensors. Depending on the device,
> +The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
>  not all sysfs and debugfs entries will be available.
>  
>  Usage notes
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..c5cd8dd866ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1446,6 +1446,7 @@ F:	drivers/media/i2c/aptina-pll.*
>  
>  AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
>  M:	Aleksa Savic <savicaleksa83@gmail.com>
> +M:	Jack Doan <me@jackdoan.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/hwmon/aquacomputer_d5next.rst
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1f1bb4d858cb..4a6d6c5b9b69 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -256,13 +256,14 @@ config SENSORS_AHT10
>  	  will be called aht10.
>  
>  config SENSORS_AQUACOMPUTER_D5NEXT
> -	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
> +	tristate "Aquacomputer D5 Next, Octo, Farbwerk, and Farbwerk 360"
>  	depends on USB_HID
>  	select CRC16
>  	help
>  	  If you say yes here you get support for sensors and fans of
>  	  the Aquacomputer D5 Next watercooling pump, Octo fan
> -	  controller and Farbwerk 360 RGB controller, where available.
> +	  controller, Farbwerk and Farbwerk 360 RGB controllers, where
> +	  available.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called aquacomputer_d5next.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index a464473bc981..7d2e7279abfb 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,11 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
> + * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values.
>   *
>   * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
> + * Copyright 2022 Jack Doan <me@jackdoan.com>
>   */
>  
>  #include <linux/crc16.h>
> @@ -19,14 +20,16 @@
>  #include <asm/unaligned.h>
>  
>  #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
> +#define USB_PRODUCT_ID_FARBWERK		0xf00a
>  #define USB_PRODUCT_ID_D5NEXT		0xf00e
>  #define USB_PRODUCT_ID_FARBWERK360	0xf010
>  #define USB_PRODUCT_ID_OCTO		0xf011
>  
> -enum kinds { d5next, farbwerk360, octo };
> +enum kinds { d5next, farbwerk, farbwerk360, octo };
>  
>  static const char *const aqc_device_names[] = {
>  	[d5next] = "d5next",
> +	[farbwerk] = "farbwerk",
>  	[farbwerk360] = "farbwerk360",
>  	[octo] = "octo"
>  };
> @@ -69,6 +72,12 @@ static u8 secondary_ctrl_report[] = {
>  #define D5NEXT_PUMP_CURRENT		112
>  #define D5NEXT_FAN_CURRENT		99
>  
> +/* Register offsets for the Farbwerk RGB controller */
> +#define FARBWERK_NUM_SENSORS		4
> +#define FARBWERK_SENSOR_START		0x2f
> +#define FARBWERK_SENSOR_SIZE		0x02
> +#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
> +
>  /* Register offsets for the Farbwerk 360 RGB controller */
>  #define FARBWERK360_NUM_SENSORS		4
>  #define FARBWERK360_SENSOR_START	0x32
> @@ -125,7 +134,7 @@ static const char *const label_d5next_current[] = {
>  	"Fan current"
>  };
>  
> -/* Labels for Farbwerk 360 and Octo temperature sensors */
> +/* Labels for Farbwerk, Farbwerk 360 and Octo temperature sensors */
>  static const char *const label_temp_sensors[] = {
>  	"Sensor 1",
>  	"Sensor 2",
> @@ -319,6 +328,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  			if (channel == 0)
>  				return 0444;
>  			break;
> +		case farbwerk:
>  		case farbwerk360:
>  		case octo:
>  			return 0444;
> @@ -551,8 +561,7 @@ static const struct hwmon_chip_info aqc_chip_info = {
>  	.info = aqc_info,
>  };
>  
> -static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
> -			 int size)
> +static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
>  {
>  	int i, sensor_value;
>  	struct aqc_data *priv;
> @@ -587,6 +596,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
>  		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
>  		break;
> +	case farbwerk:
> +		/* Temperature sensor readings */
> +		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
> +			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
> +							  i * FARBWERK_SENSOR_SIZE);
> +			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
> +				priv->temp_input[i] = -ENODATA;
> +			else
> +				priv->temp_input[i] = sensor_value * 10;
> +		}
> +		break;
>  	case farbwerk360:
>  		/* Temperature sensor readings */
>  		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
> @@ -733,6 +753,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->voltage_label = label_d5next_voltages;
>  		priv->current_label = label_d5next_current;
>  		break;
> +	case USB_PRODUCT_ID_FARBWERK:
> +		priv->kind = farbwerk;
> +
> +		priv->temp_label = label_temp_sensors;
> +		break;
>  	case USB_PRODUCT_ID_FARBWERK360:
>  		priv->kind = farbwerk360;
>  
> @@ -795,6 +820,7 @@ static void aqc_remove(struct hid_device *hdev)
>  
>  static const struct hid_device_id aqc_table[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
>  	{ }
> @@ -826,4 +852,5 @@ module_exit(aqc_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> +MODULE_AUTHOR("Jack Doan <me@jackdoan.com>");
>  MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");
