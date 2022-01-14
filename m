Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12048EA48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiANNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:05:54 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43804 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231283AbiANNFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:05:53 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20EBvjTm005160;
        Fri, 14 Jan 2022 07:05:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=TzmqeEwb5dZEGYxeNsqWYPBQ8/lTz7W7c/lMNafBkAE=;
 b=NE7uZcgL93dqva6cCkPIprojSDGtV0/+e74HWFAECSMHG6VZ+mpGgRpyBCeVW6CC+ruG
 FiEKy5MmbT+yuFnNeJ8NOyadg89J7RvJZwaCMKdH1VQHXbF1Alw3ffU6lIBNnWR1S7eS
 m4CTtXq4M2pHXx4rWLnEcbGDq8rKaXQ+ifbYycz5xz8yv0APQfo/mhI83JzWQ0SvPshC
 1kUPwRbL/IWHRFhLulIVpZ5Eogk0Hlo/6vUbHiyBsUuYbs/h/JB0iO6TW0WPdyX0sWqR
 szfTctW3FkqV7lHK3ld8hXLlp+MI+9l1D4AtDJKBSFgz1jJ004nydSbSGybYeKzdlosA Tg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3djma118dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jan 2022 07:05:02 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 14 Jan
 2022 13:05:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 14 Jan 2022 13:05:00 +0000
Received: from [198.61.65.50] (unknown [198.61.65.50])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A79F475;
        Fri, 14 Jan 2022 13:05:00 +0000 (UTC)
Message-ID: <360af696-8581-4461-4ea1-d182a98c0441@opensource.cirrus.com>
Date:   Fri, 14 Jan 2022 13:04:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] ALSA: hda: cs35l41: Tidyup code and add default cases
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
 <20220113170728.1953559-4-tanureal@opensource.cirrus.com>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220113170728.1953559-4-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u7kJ9I4rsH9u7bHOMQLyy1_UPqsKPq9-
X-Proofpoint-ORIG-GUID: u7kJ9I4rsH9u7bHOMQLyy1_UPqsKPq9-
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 17:07, Lucas Tanure wrote:
> Clean up the code, plus adding default cases for switch
> and dev_err_probe use.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>   sound/pci/hda/cs35l41_hda.c     | 109 ++++++++++++++++----------------
>   sound/pci/hda/cs35l41_hda.h     |   2 +-
>   sound/pci/hda/cs35l41_hda_i2c.c |   1 -
>   sound/pci/hda/cs35l41_hda_spi.c |   1 -
>   4 files changed, 57 insertions(+), 56 deletions(-)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index c4f25e48dcc0..cb8331587c17 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   //
> -// cs35l41.c -- CS35l41 ALSA HDA audio driver
> +// CS35l41 ALSA HDA audio driver
>   //
>   // Copyright 2021 Cirrus Logic, Inc.
>   //
> @@ -17,19 +17,19 @@
>   #include "cs35l41_hda.h"
>   
>   static const struct reg_sequence cs35l41_hda_config[] = {
> -	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, //3200000Hz, BCLK Input, PLL_REFCLK_EN = 1
> -	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, //GLOBAL_FS = 48 kHz
> -	{ CS35L41_SP_ENABLES,		0x00010000 }, //ASP_RX1_EN = 1
> -	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, //ASP_BCLK_FREQ = 3.072 MHz
> -	{ CS35L41_SP_FORMAT,		0x20200200 }, //24 bits, I2S, BCLK Slave, FSYNC Slave
> -	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, //DACPCM1_SRC = ASPRX1
> -	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, //AMP_VOL_PCM  0.0 dB
> -	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, //AMP_GAIN_PCM 4.5 dB
> -	{ CS35L41_PWR_CTRL2,		0x00000001 }, //AMP_EN = 1
> +	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3200000Hz, BCLK Input, PLL_REFCLK_EN = 1
> +	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, // GLOBAL_FS = 48 kHz
> +	{ CS35L41_SP_ENABLES,		0x00010000 }, // ASP_RX1_EN = 1
> +	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, // ASP_BCLK_FREQ = 3.072 MHz
> +	{ CS35L41_SP_FORMAT,		0x20200200 }, // 24 bits, I2S, BCLK Slave, FSYNC Slave
> +	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, // DACPCM1_SRC = ASPRX1
> +	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
> +	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
> +	{ CS35L41_PWR_CTRL2,		0x00000001 }, // AMP_EN = 1
>   };
>   
>   static const struct reg_sequence cs35l41_hda_start_bst[] = {
> -	{ CS35L41_PWR_CTRL2,		0x00000021 }, //BST_EN = 10, AMP_EN = 1
> +	{ CS35L41_PWR_CTRL2,		0x00000021 }, // BST_EN = 10, AMP_EN = 1
>   	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
>   };
>   
> @@ -60,7 +60,7 @@ static const struct reg_sequence cs35l41_stop_ext_vspk[] = {
>   	{ 0x00000040,			0x00000055 },
>   	{ 0x00000040,			0x000000AA },
>   	{ 0x00007438,			0x00585941 },
> -	{ 0x00002014,			0x00000000, 3000}, //set GLOBAL_EN = 0
> +	{ 0x00002014,			0x00000000, 3000}, // set GLOBAL_EN = 0
>   	{ 0x0000742C,			0x00000009 },
>   	{ 0x00007438,			0x00580941 },
>   	{ 0x00011008,			0x00000001 },
> @@ -78,7 +78,7 @@ static const struct reg_sequence cs35l41_safe_to_active[] = {
>   	{ 0x0000742C,			0x0000000F },
>   	{ 0x0000742C,			0x00000079 },
>   	{ 0x00007438,			0x00585941 },
> -	{ CS35L41_PWR_CTRL1,		0x00000001, 2000 }, //GLOBAL_EN = 1
> +	{ CS35L41_PWR_CTRL1,		0x00000001, 2000 }, // GLOBAL_EN = 1
>   	{ 0x0000742C,			0x000000F9 },
>   	{ 0x00007438,			0x00580941 },
>   	{ 0x00000040,			0x000000CC },
> @@ -89,8 +89,8 @@ static const struct reg_sequence cs35l41_active_to_safe[] = {
>   	{ 0x00000040,			0x00000055 },
>   	{ 0x00000040,			0x000000AA },
>   	{ 0x00007438,			0x00585941 },
> -	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, //AMP_VOL_PCM Mute
> -	{ CS35L41_PWR_CTRL2,		0x00000000 }, //AMP_EN = 0
> +	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
> +	{ CS35L41_PWR_CTRL2,		0x00000000 }, // AMP_EN = 0
>   	{ CS35L41_PWR_CTRL1,		0x00000000 },
>   	{ 0x0000742C,			0x00000009, 2000 },
>   	{ 0x00007438,			0x00580941 },
> @@ -161,11 +161,13 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
>   		if (reg_seq->close)
>   			ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
>   		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
>   	}
>   
>   	if (ret)
>   		dev_warn(cs35l41->dev, "Failed to apply multi reg write: %d\n", ret);
> -
>   }
>   
>   static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsigned int *tx_slot,
> @@ -182,20 +184,19 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
>   	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
>   	struct hda_component *comps = master_data;
>   
> -	if (comps && cs35l41->index >= 0 && cs35l41->index < HDA_MAX_COMPONENTS)
> -		comps = &comps[cs35l41->index];
> -	else
> +	if (!comps || cs35l41->index < 0 || cs35l41->index >= HDA_MAX_COMPONENTS)
>   		return -EINVAL;
>   
> -	if (!comps->dev) {
> -		comps->dev = dev;
> -		strscpy(comps->name, dev_name(dev), sizeof(comps->name));
> -		comps->playback_hook = cs35l41_hda_playback_hook;
> -		comps->set_channel_map = cs35l41_hda_channel_map;
> -		return 0;
> -	}
> +	comps = &comps[cs35l41->index];
> +	if (comps->dev)
> +		return -EBUSY;
> +
> +	comps->dev = dev;
> +	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
> +	comps->playback_hook = cs35l41_hda_playback_hook;
> +	comps->set_channel_map = cs35l41_hda_channel_map;
>   
> -	return -EBUSY;
> +	return 0;
>   }
>   
>   static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *master_data)
> @@ -235,6 +236,8 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41,
>   		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
>   				   CS35L41_GPIO1_CTRL_MASK, 2 << CS35L41_GPIO1_CTRL_SHIFT);
>   		break;
> +	default:
> +		return -EINVAL;
>   	}
>   
>   	switch (hw_cfg->gpio2_func) {
> @@ -242,6 +245,8 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41,
>   		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
>   				   CS35L41_GPIO2_CTRL_MASK, 2 << CS35L41_GPIO2_CTRL_SHIFT);
>   		break;
> +	default:
> +		return -EINVAL;
This default option introduces issues some laptops.
A new version of this series will be sent.

>   	}
>   
>   	if (internal_boost) {
> @@ -256,11 +261,7 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41,
>   		cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
>   	}
>   
> -	ret = cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, (unsigned int *)&hw_cfg->spk_pos);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, (unsigned int *)&hw_cfg->spk_pos);
>   }
>   
>   static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41,
> @@ -269,7 +270,7 @@ static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *c
>   	struct cs35l41_hda_hw_config *hw_cfg;
>   	u32 values[HDA_MAX_COMPONENTS];
>   	struct acpi_device *adev;
> -	struct device *acpi_dev;
> +	struct device *physdev;
>   	char *property;
>   	size_t nval;
>   	int i, ret;
> @@ -280,11 +281,11 @@ static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *c
>   		return ERR_PTR(-ENODEV);
>   	}
>   
> -	acpi_dev = get_device(acpi_get_first_physical_node(adev));
> +	physdev = get_device(acpi_get_first_physical_node(adev));
>   	acpi_dev_put(adev);
>   
>   	property = "cirrus,dev-index";
> -	ret = device_property_count_u32(acpi_dev, property);
> +	ret = device_property_count_u32(physdev, property);
>   	if (ret <= 0)
>   		goto no_acpi_dsd;
>   
> @@ -294,7 +295,7 @@ static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *c
>   	}
>   	nval = ret;
>   
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret)
>   		goto err;
>   
> @@ -311,7 +312,9 @@ static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *c
>   		goto err;
>   	}
>   
> -	/* No devm_ version as CLSA0100, in no_acpi_dsd case, can't use devm version */
> +	/* To use the same release code for all laptop variants we can't use devm_ version of
> +	 * gpiod_get here, as CLSA010* don't have a fully functional bios with an _DSD node
> +	 */
>   	cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", cs35l41->index,
>   						     GPIOD_OUT_LOW, "cs35l41-reset");
>   
> @@ -322,46 +325,46 @@ static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *c
>   	}
>   
>   	property = "cirrus,speaker-position";
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret)
>   		goto err_free;
>   	hw_cfg->spk_pos = values[cs35l41->index];
>   
>   	property = "cirrus,gpio1-func";
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret)
>   		goto err_free;
>   	hw_cfg->gpio1_func = values[cs35l41->index];
>   
>   	property = "cirrus,gpio2-func";
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret)
>   		goto err_free;
>   	hw_cfg->gpio2_func = values[cs35l41->index];
>   
>   	property = "cirrus,boost-peak-milliamp";
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret == 0)
>   		hw_cfg->bst_ipk = values[cs35l41->index];
>   
>   	property = "cirrus,boost-ind-nanohenry";
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret == 0)
>   		hw_cfg->bst_ind = values[cs35l41->index];
>   
>   	property = "cirrus,boost-cap-microfarad";
> -	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +	ret = device_property_read_u32_array(physdev, property, values, nval);
>   	if (ret == 0)
>   		hw_cfg->bst_cap = values[cs35l41->index];
>   
> -	put_device(acpi_dev);
> +	put_device(physdev);
>   
>   	return hw_cfg;
>   
>   err_free:
>   	kfree(hw_cfg);
>   err:
> -	put_device(acpi_dev);
> +	put_device(physdev);
>   	dev_err(cs35l41->dev, "Failed property %s: %d\n", property, ret);
>   
>   	return ERR_PTR(ret);
> @@ -370,18 +373,18 @@ static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *c
>   	/*
>   	 * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
>   	 * And devices created by i2c-multi-instantiate don't have their device struct pointing to
> -	 * the correct fwnode, so acpi_dev must be used here
> +	 * the correct fwnode, so acpi_dev must be used here.
>   	 * And devm functions expect that the device requesting the resource has the correct
> -	 * fwnode
> +	 * fwnode.
>   	 */
>   	if (strncmp(hid, "CLSA0100", 8) != 0)
>   		return ERR_PTR(-EINVAL);
>   
>   	/* check I2C address to assign the index */
>   	cs35l41->index = id == 0x40 ? 0 : 1;
> -	cs35l41->reset_gpio = gpiod_get_index(acpi_dev, NULL, 0, GPIOD_OUT_HIGH);
> +	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
>   	cs35l41->vspk_always_on = true;
> -	put_device(acpi_dev);
> +	put_device(physdev);
>   
>   	return NULL;
>   }
> @@ -416,8 +419,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>   		if (ret == -EBUSY) {
>   			dev_info(cs35l41->dev, "Reset line busy, assuming shared reset\n");
>   		} else {
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(cs35l41->dev, "Failed to get reset GPIO: %d\n", ret);
> +			dev_err_probe(cs35l41->dev, ret, "Failed to get reset GPIO: %d\n", ret);
>   			goto err;
>   		}
>   	}
> @@ -437,7 +439,8 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>   
>   	ret = regmap_read(cs35l41->regmap, CS35L41_IRQ1_STATUS3, &int_sts);
>   	if (ret || (int_sts & CS35L41_OTP_BOOT_ERR)) {
> -		dev_err(cs35l41->dev, "OTP Boot error\n");
> +		dev_err(cs35l41->dev, "OTP Boot status %x error: %d\n",
> +			int_sts & CS35L41_OTP_BOOT_ERR, ret);
>   		ret = -EIO;
>   		goto err;
>   	}
> @@ -489,7 +492,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>   
>   	if (cs35l41->reg_seq->probe) {
>   		ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41->reg_seq->probe,
> -					    cs35l41->reg_seq->num_probe);
> +					     cs35l41->reg_seq->num_probe);
>   		if (ret) {
>   			dev_err(cs35l41->dev, "Fail to apply probe reg patch: %d\n", ret);
>   			goto err;
> diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
> index 76c69a8a22f6..640afc98b686 100644
> --- a/sound/pci/hda/cs35l41_hda.h
> +++ b/sound/pci/hda/cs35l41_hda.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0
>    *
> - * cs35l41_hda.h -- CS35L41 ALSA HDA audio driver
> + * CS35L41 ALSA HDA audio driver
>    *
>    * Copyright 2021 Cirrus Logic, Inc.
>    *
> diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
> index eeb387853ee3..c2397dc53e78 100644
> --- a/sound/pci/hda/cs35l41_hda_i2c.c
> +++ b/sound/pci/hda/cs35l41_hda_i2c.c
> @@ -58,7 +58,6 @@ static struct i2c_driver cs35l41_i2c_driver = {
>   	.probe		= cs35l41_hda_i2c_probe,
>   	.remove		= cs35l41_hda_i2c_remove,
>   };
> -
>   module_i2c_driver(cs35l41_i2c_driver);
>   
>   MODULE_DESCRIPTION("HDA CS35L41 driver");
> diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
> index 15345a72b9d1..36815ab4e461 100644
> --- a/sound/pci/hda/cs35l41_hda_spi.c
> +++ b/sound/pci/hda/cs35l41_hda_spi.c
> @@ -55,7 +55,6 @@ static struct spi_driver cs35l41_spi_driver = {
>   	.probe		= cs35l41_hda_spi_probe,
>   	.remove		= cs35l41_hda_spi_remove,
>   };
> -
>   module_spi_driver(cs35l41_spi_driver);
>   
>   MODULE_DESCRIPTION("HDA CS35L41 driver");

