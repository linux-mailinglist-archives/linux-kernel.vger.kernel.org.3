Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2947C6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbhLUScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241355AbhLUScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640111540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzLGzA/s4gESUXzjrwcgOea7WQnAN8B5/Kq2WuuS1rM=;
        b=PVVQaDMsh78vxYnyn+BeX6E9ooH+uLDEExuQ1KWpZFlpPNvL8+JqY+MicFXaOokFpyV6Mr
        xABplPE0+dHmbHQmXHRmAbkFuzuo4pqKtco2XQWRevcP3R4UgPDjuA/j+ewU5lnlCXiiTf
        t407+RDRw2R6oCB6LhPngymfONWT1YI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-AhhEsWYvPmS_0LEHCem6-Q-1; Tue, 21 Dec 2021 13:32:19 -0500
X-MC-Unique: AhhEsWYvPmS_0LEHCem6-Q-1
Received: by mail-ed1-f71.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so6199349edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TzLGzA/s4gESUXzjrwcgOea7WQnAN8B5/Kq2WuuS1rM=;
        b=VTwplijjzAYRJCdMq/yUTKmmBEw09DbVwnQfAAllLsePSy3DDbcW6vFZPH44fFgwm9
         Xj/cZI/RyTL8tDpvPrbTUKgttXN3PwWwqtuBz2YB1xQGG+0Xy8t6+7Ea0UbwG/yWr8or
         LJcWr4EK/IrD4wyqK7cQ7Nljv1smRGn7qdGyTpya0FdHzG6o+HINzETwAkhGb7im6ykD
         GdQ0XZ3XBnRMbVkfAWMm4Sz0LiBoPUphAFmLLTUQ0nizPsw+Xtk/CfDNKd13H3QyncmS
         KL1XSeI8HyFl7hoNTWuEVDOU+sGBkHZT+wBLhArxExFW7lnjt1n6Q03AGFRpnGM1/hjv
         McNQ==
X-Gm-Message-State: AOAM531ZP1QVzrJLrm/SLZw3IPZ7Nx8mSgwUkkUt4vV7PGcKA8ix1TT9
        8SXTj+ZGuyXSaf+elF0ONJ78SoD18/dxZsMBe/Ud0PoiP/HldXejrwsqmN/5j3AHJA46IYaiy9W
        MINFuDFOUWL+ECcPqvYOqvcbi
X-Received: by 2002:a17:906:4f8c:: with SMTP id o12mr3787004eju.16.1640111537916;
        Tue, 21 Dec 2021 10:32:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNY8SDCUa5hgnG9DVizhm2hRNTSduSiEoGtP2f6chTIJ4rzs3WsHTDL0uRx8o56/8DjRMuvQ==
X-Received: by 2002:a17:906:4f8c:: with SMTP id o12mr3786982eju.16.1640111537465;
        Tue, 21 Dec 2021 10:32:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id m16sm8497757edd.61.2021.12.21.10.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:32:17 -0800 (PST)
Message-ID: <c311642f-38ab-4914-cf92-852e6a20cfc9@redhat.com>
Date:   Tue, 21 Dec 2021 19:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 6/6] ACPI: bus-multi-instantiate: Add SPI support
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
 <20211210154050.3713-7-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211210154050.3713-7-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/10/21 16:40, Stefan Binding wrote:
> Add support for spi bus in bus-multi-instantiate driver
> 
> Some peripherals can have either a I2C or a SPI connection
> to the host (but not both) but use the same HID for both
> types. So it is not possible to use the HID to determine
> whether it is I2C or SPI. The driver must check the node
> to see if it contains I2cSerialBus or SpiSerialBus entries.
> 
> For backwards-compatibility with the existing nodes I2C is
> checked first and if such entries are found ONLY I2C devices
> are created. Since some existing nodes that were already
> handled by this driver could also contain unrelated
> SpiSerialBus nodes that were previously ignored, and this
> preserves that behavior. If there is ever a need to handle
> a node where both I2C and SPI devices must be instantiated
> this can be added in future.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/acpi/Kconfig                 |  10 +-
>  drivers/acpi/bus-multi-instantiate.c | 345 ++++++++++++++++++++++++---
>  drivers/acpi/scan.c                  |  13 +-
>  3 files changed, 327 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 6ba47dd39eb4..948f39d55595 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -296,12 +296,12 @@ config ACPI_PROCESSOR
>  	  the module will be called processor.
>  
>  config ACPI_BUS_MULTI_INST
> -	tristate "I2C multi instantiate pseudo device driver"
> -	depends on I2C
> +	tristate "I2C and SPI multi instantiate pseudo device driver"
> +	depends on I2C && SPI
>  	help
> -	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
> -	  firmware-node. This driver will instantiate separate i2c-clients
> -	  for each device in the firmware-node.
> +	  Some ACPI-based systems list multiple i2c/spi devices in a
> +	  single ACPI firmware-node. This driver will instantiate separate
> +	  i2c-clients or spi-devices for each device in the firmware-node.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called bus-multi-instantiate.
> diff --git a/drivers/acpi/bus-multi-instantiate.c b/drivers/acpi/bus-multi-instantiate.c
> index 50f1540762e9..c1306a0ee13c 100644
> --- a/drivers/acpi/bus-multi-instantiate.c
> +++ b/drivers/acpi/bus-multi-instantiate.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Bus multi-instantiate driver, pseudo driver to instantiate multiple
> - * i2c-clients from a single fwnode.
> + * i2c-clients or spi-devices from a single fwnode.
>   *
>   * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
>   */
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/spi/spi.h>
>  #include <linux/types.h>
>  
>  #define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
> @@ -21,15 +22,38 @@
>  #define IRQ_RESOURCE_GPIO	1
>  #define IRQ_RESOURCE_APIC	2
>  
> +enum bmi_bus_type {
> +	BMI_I2C,
> +	BMI_SPI,
> +	BMI_AUTO_DETEC,

you are missing the T of detec_t_ here.

> +};
> +
> +struct bmi_spi_acpi {
> +	char *resource_source;
> +	struct acpi_resource_spi_serialbus sb;
> +};
> +
> +struct bmi_spi_sb_acpi {
> +	int count;
> +	struct bmi_spi_acpi acpi_data[];
> +};
> +
>  struct bmi_instance {
>  	const char *type;
>  	unsigned int flags;
>  	int irq_idx;
>  };
>  
> +struct bmi_node {
> +	enum bmi_bus_type bus_type;
> +	struct bmi_instance instances[];
> +};
> +
>  struct bmi {
>  	int i2c_num;
> +	int spi_num;
>  	struct i2c_client **i2c_devs;
> +	struct spi_device **spi_devs;
>  };
>  
>  static int bmi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
> @@ -60,6 +84,230 @@ static void bmi_devs_unregister(struct bmi *bmi)
>  {
>  	while (bmi->i2c_num > 0)
>  		i2c_unregister_device(bmi->i2c_devs[--bmi->i2c_num]);
> +
> +	while (bmi->spi_num > 0)
> +		spi_unregister_device(bmi->spi_devs[--bmi->spi_num]);
> +}
> +
> +static int bmi_spi_count(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_spi_serialbus *sb;
> +	int *count = data;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.spi_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
> +		return 1;
> +
> +	*count = *count + 1;
> +
> +	return 1;
> +}
> +
> +static int bmi_spi_count_resources(struct acpi_device *adev)
> +{
> +	LIST_HEAD(r);
> +	int count = 0;
> +	int ret;
> +
> +	ret = acpi_dev_get_resources(adev, &r, bmi_spi_count, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&r);
> +
> +	return count;
> +}
> +
> +static int bmi_spi_save_res(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_spi_serialbus *sb;
> +	struct bmi_spi_sb_acpi *resources = data;
> +	struct bmi_spi_acpi *acpi_data;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.spi_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
> +		return 1;
> +
> +	acpi_data = &resources->acpi_data[resources->count];
> +	memcpy(&acpi_data->sb, sb, sizeof(*sb));
> +	acpi_data->resource_source = kstrndup(sb->resource_source.string_ptr,
> +					      sb->resource_source.string_length, GFP_KERNEL);
> +	if (!acpi_data->resource_source)
> +		return 1;
> +	resources->count++;
> +
> +	return 1;
> +}
> +
> +static void bmi_spi_res_free(struct bmi_spi_sb_acpi *resources)
> +{
> +	if (!resources)
> +		return;
> +
> +	while (resources->count)
> +		kfree(resources->acpi_data[--resources->count].resource_source);
> +	kfree(resources);
> +}

This save + free dance here seems over complicated, see below for more on this ...

> +
> +static struct bmi_spi_sb_acpi *bmi_spi_get_resources(struct device *dev,
> +						     struct acpi_device *adev, int count)
> +{
> +	struct bmi_spi_sb_acpi *resources;
> +	LIST_HEAD(r);
> +	int ret;
> +
> +	resources = kmalloc(struct_size(resources, acpi_data, count), GFP_KERNEL);
> +	if (!resources)
> +		return NULL;
> +
> +	ret = acpi_dev_get_resources(adev, &r, bmi_spi_save_res, resources);
> +	if (ret < 0)
> +		goto error;
> +
> +	acpi_dev_free_resource_list(&r);
> +
> +	return resources;
> +
> +error:
> +	bmi_spi_res_free(resources);
> +	return NULL;
> +}
> +
> +static struct spi_controller *bmi_find_spi_controller(char *path)
> +{
> +	acpi_handle parent_handle;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	status = acpi_get_handle(NULL, path, &parent_handle);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +
> +	if (acpi_bus_get_device(parent_handle, &adev))
> +		return NULL;
> +
> +	return acpi_spi_find_controller_by_adev(adev);
> +}
> +
> +/**
> + * bmi_spi_probe - Instantiate multiple SPI devices from inst array
> + * @pdev:	Platform device
> + * @adev:	ACPI device
> + * @bmi:	Internal struct for Bus multi instantiate driver
> + * @inst:	Array of instances to probe
> + *
> + * Returns the number of SPI devices instantiate, Zero if none is found or a negative error code.
> + */
> +static int bmi_spi_probe(struct platform_device *pdev, struct acpi_device *adev, struct bmi *bmi,
> +			 const struct bmi_instance *inst_array)
> +{
> +	struct bmi_spi_sb_acpi *acpi_data;
> +	struct device *dev = &pdev->dev;
> +	struct spi_controller *ctlr;
> +	struct spi_device *spi_dev;
> +	char name[50];
> +	int i, ret, count;
> +



> +	ret = bmi_spi_count_resources(adev);
> +	if (ret <= 0)
> +		return ret;
> +	count = ret;

Ok, so why not do the following here instead (and drop a whole bunch of
functions above):

	ret = acpi_dev_get_resources(adev, &r, bmi_spi_count, &count);
	if (ret < 0)
		return ret;

	if (count <= 0) {
		acpi_dev_free_resource_list(&r);
		return count;
	}

	/* Note we are not freeing the resource list yet here !!! */
	
> +
> +	bmi->spi_devs = devm_kcalloc(dev, count, sizeof(*bmi->spi_devs), GFP_KERNEL);
> +	if (!bmi->spi_devs)
> +		return -ENOMEM;
> +
> +	acpi_data = bmi_spi_get_resources(dev, adev, count);
> +	if (!acpi_data)
> +		return -ENOMEM;

Remove the bmi_spi_get_resources() call here.

> +
> +	for (i = 0; i < count && inst_array[i].type; i++) {

Write a new:

int bmi_get_spi_resource_by_index(list_head *resource_list, struct acpi_resource_spi_serialbus *sb_ret, int index)
{}

Helper which walks the list and fills in *sb_ret with the Nth (matching index) SpiSerialBus resource found in the
list.

And then do:

		ret = bmi_get_spi_resource_by_index(&r, &sb, i);
		if (ret)
			return ret;

		ctrl = bmi_find_spi_controller(sb.resource_source.string_ptr);


> +		ctlr = bmi_find_spi_controller(acpi_data->acpi_data[i].resource_source);
> +		if (!ctlr) {
> +			ret = -EPROBE_DEFER;
> +			goto error;
> +		}
> +
> +		spi_dev = spi_alloc_device(ctlr);
> +		if (!spi_dev) {
> +			dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
> +				dev_name(&adev->dev));
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +
> +		strscpy(spi_dev->modalias, inst_array[i].type, sizeof(spi_dev->modalias));
> +

And replace all the "acpi_data->acpi_data[i].sb." reference below with simple "sb.".


> +		if (ctlr->fw_translate_cs) {
> +			ret = ctlr->fw_translate_cs(ctlr,
> +						    acpi_data->acpi_data[i].sb.device_selection);
> +			if (ret < 0) {
> +				spi_dev_put(spi_dev);
> +				goto error;
> +			}
> +			spi_dev->chip_select = ret;
> +		} else {
> +			spi_dev->chip_select = acpi_data->acpi_data[i].sb.device_selection;
> +		}
> +
> +		spi_dev->max_speed_hz = acpi_data->acpi_data[i].sb.connection_speed;
> +		spi_dev->bits_per_word = acpi_data->acpi_data[i].sb.data_bit_length;
> +
> +		if (acpi_data->acpi_data[i].sb.clock_phase == ACPI_SPI_SECOND_PHASE)
> +			spi_dev->mode |= SPI_CPHA;
> +		if (acpi_data->acpi_data[i].sb.clock_polarity == ACPI_SPI_START_HIGH)
> +			spi_dev->mode |= SPI_CPOL;
> +		if (acpi_data->acpi_data[i].sb.device_polarity == ACPI_SPI_ACTIVE_HIGH)
> +			spi_dev->mode |= SPI_CS_HIGH;
> +
> +		ret = bmi_get_irq(pdev, adev, &inst_array[i]);
> +		if (ret < 0) {
> +			spi_dev_put(spi_dev);
> +			goto error;
> +		}
> +		spi_dev->irq = ret;
> +
> +		snprintf(name, sizeof(name), "%s-%s-%s.%d", dev_name(&ctlr->dev), dev_name(dev),
> +			 inst_array[i].type, i);
> +		spi_dev->dev.init_name = name;
> +
> +		ret = spi_add_device(spi_dev);
> +		if (ret) {
> +			dev_err(&ctlr->dev, "failed to add SPI device %s from ACPI: %d\n",
> +				dev_name(&adev->dev), ret);
> +			spi_dev_put(spi_dev);
> +			goto error;
> +		}
> +
> +		dev_dbg(dev, "SPI device %s using chip select %u", name, spi_dev->chip_select);
> +
> +		bmi->spi_devs[i] = spi_dev;
> +		bmi->spi_num++;
> +	}
> +
> +	if (bmi->spi_num < count) {
> +		dev_err(dev, "Error finding driver, idx %d\n", i);
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +
> +	dev_info(dev, "Instantiate %d SPI devices.\n", bmi->spi_num);

And here replace the bmi_spi_res_free(acpi_data); call in both exit paths with:
acpi_dev_free_resource_list(&r); .

To me this way, simply using the already allocated resources from the list,
rather then making a temp copy of them and throwing that away seems like
a simpler solution ?

If you go this route, please also remove the struct bmi_spi_acpi and
struct bmi_spi_sb_acpi data types which you now no longer need.

> +	bmi_spi_res_free(acpi_data);
> +
> +	return bmi->spi_num;
> +error:
> +	bmi_spi_res_free(acpi_data);
> +	bmi_devs_unregister(bmi);
> +	dev_err_probe(dev, ret, "SPI error %d\n", ret);
> +
> +	return ret;
> +
>  }
>  
>  /**
> @@ -125,14 +373,14 @@ static int bmi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
>  
>  static int bmi_probe(struct platform_device *pdev)
>  {
> -	const struct bmi_instance *inst_array;
>  	struct device *dev = &pdev->dev;
> +	const struct bmi_node *node;
>  	struct acpi_device *adev;
>  	struct bmi *bmi;
> -	int ret;
> +	int i2c_ret = 0, spi_ret = 0;
>  
> -	inst_array = device_get_match_data(dev);
> -	if (!inst_array) {
> +	node = device_get_match_data(dev);
> +	if (!node) {
>  		dev_err(dev, "Error ACPI match data is missing\n");
>  		return -ENODEV;
>  	}
> @@ -147,13 +395,44 @@ static int bmi_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, bmi);
>  
> -	ret = bmi_i2c_probe(pdev, adev, bmi, inst_array);
> -	if (ret > 0)
> +	/* Each time this driver probes only one type of bus will be chosen.
> +	 * And I2C has preference, which means that if find a I2cSerialBus it assumes
> +	 * that all following devices will also be I2C.
> +	 * In case there are zero I2C devices, it assumes that all following devices are SPI.
> +	 */
> +	if (node->bus_type != BMI_SPI) {
> +		i2c_ret = bmi_i2c_probe(pdev, adev, bmi, node->instances);
> +		if (i2c_ret > 0)
> +			return 0;
> +		else if (i2c_ret == -EPROBE_DEFER)
> +			return i2c_ret;
> +		if (node->bus_type == BMI_I2C) {
> +			if (i2c_ret == 0)
> +				return -ENODEV;
> +			else
> +				return i2c_ret;
> +		}
> +	}
> +	/* BMI_SPI or BMI_AUTO_DETEC */

auto-detec_t_

> +	spi_ret = bmi_spi_probe(pdev, adev, bmi, node->instances);
> +	if (spi_ret > 0)
>  		return 0;
> -	if (ret == 0)
> -		ret = -ENODEV;
> +	else if (spi_ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (node->bus_type == BMI_SPI) {
> +		if (spi_ret == 0)
> +			return -ENODEV;
> +		else
> +			return spi_ret;
> +	}
>  
> -	return ret;
> +	/* The only way to get here is BMI_AUTO_DETEC and i2c_ret <= 0 and spi_ret <= 0 */
> +	if (i2c_ret == 0 && spi_ret == 0)
> +		return -ENODEV;
> +	else if (i2c_ret == 0 && spi_ret)
> +		return spi_ret;
> +
> +	return i2c_ret;
>  }
>  
>  static int bmi_remove(struct platform_device *pdev)
> @@ -165,27 +444,33 @@ static int bmi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct bmi_instance bsg1160_data[]  = {
> -	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
> -	{ "bmc150_magn" },
> -	{ "bmg160" },
> -	{}
> +static const struct bmi_node bsg1160_data = {

Please explicitly set ".type = BMI_I2C" here and for all the
other already existing  bmi_node structs.

> +	.instances = {
> +		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
> +		{ "bmc150_magn" },
> +		{ "bmg160" },
> +		{}
> +	},
>  };
>  
> -static const struct bmi_instance bsg2150_data[]  = {
> -	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
> -	{ "bmc150_magn" },
> -	/* The resources describe a 3th client, but it is not really there. */
> -	{ "bsg2150_dummy_dev" },
> -	{}
> +static const struct bmi_node bsg2150_data = {
> +	.instances = {
> +		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
> +		{ "bmc150_magn" },
> +		/* The resources describe a 3th client, but it is not really there. */
> +		{ "bsg2150_dummy_dev" },
> +		{}
> +	},
>  };
>  
> -static const struct bmi_instance int3515_data[]  = {
> -	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
> -	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
> -	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
> -	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
> -	{}
> +static const struct bmi_node int3515_data = {
> +	.instances = {
> +		{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
> +		{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
> +		{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
> +		{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
> +		{}
> +	},
>  };
>  
>  /*
> @@ -193,9 +478,9 @@ static const struct bmi_instance int3515_data[]  = {
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>   */
>  static const struct acpi_device_id bmi_acpi_ids[] = {
> -	{ "BSG1160", (unsigned long)bsg1160_data },
> -	{ "BSG2150", (unsigned long)bsg2150_data },
> -	{ "INT3515", (unsigned long)int3515_data },
> +	{ "BSG1160", (unsigned long)&bsg1160_data },
> +	{ "BSG2150", (unsigned long)&bsg2150_data },
> +	{ "INT3515", (unsigned long)&int3515_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi_acpi_ids);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 969d8138d019..8b937fc20d23 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1696,12 +1696,13 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	struct list_head resource_list;
>  	bool is_serial_bus_slave = false;
>  	/*
> -	 * These devices have multiple I2cSerialBus resources and an i2c-client
> -	 * must be instantiated for each, each with its own i2c_device_id.
> -	 * Normally we only instantiate an i2c-client for the first resource,
> -	 * using the ACPI HID as id. These special cases are handled by the
> -	 * drivers/acpi/bus-multi-instantiate.c driver, which knows
> -	 * which i2c_device_id to use for each resource.
> +	 * These devices have multiple I2cSerialBus/SpiSerialBus resources
> +	 * and an (i2c/spi)-client must be instantiated for each, each with
> +	 * its own i2c_device_id/spi_device_id.
> +	 * Normally we only instantiate an (i2c/spi)-client for the first
> +	 * resource, using the ACPI HID as id. These special cases are handled
> +	 * by the drivers/acpi/bus-multi-instantiate.c driver, which
> +	 * knows which i2c_device_id or spi_device_id to use for each resource.
>  	 */
>  	static const struct acpi_device_id bus_multi_instantiate_ids[] = {
>  		{"BSG1160", },
> 


Regards,

Hans

