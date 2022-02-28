Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF914C6446
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiB1ICX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiB1ICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:02:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA706928E;
        Mon, 28 Feb 2022 00:01:42 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u2so2447568ple.10;
        Mon, 28 Feb 2022 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0kMd+1+9I4cwW0irNULMJVKX8ou/gm8Lldcho28W65A=;
        b=YVJN3Gyq6Dlkv1BxfX2VusX8qBGNAhHAYp1uYVt3Y2vFGoDI5XHz1sJ2yTT5ClDKCO
         DWyaIcNKRldKSMPgNR03QYx4DMQ7EtTHnzv2RO+OT8gRvo1TV7Rs7rbzbgXYBH040I4E
         YlcfyEaSGRd1gM0LNkeRJ0fr5uq3VVFBDO3zyafYCp/hOLUF6SVjp4xws0yKg04YgdY0
         0y1pl/LegL/8ECMFDV8H3uDJ4aGWbNdKZtj9v1v8EfkRV7BOEwEtqaz0Mz0CS9MPz3XA
         PsMUVdoy7JYvpYX1r0aSw3CyHIAixN6SmJFKpiKsDOE7ItU80ul16t9BXSTlaq2/WrIl
         zwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kMd+1+9I4cwW0irNULMJVKX8ou/gm8Lldcho28W65A=;
        b=1NsLwJ87Z2htna0liLqFragl8lEuAhdg/u8f41RDPhhi52FvShMn3jh48JM9BA/vnm
         M6jcDXfI1WHpqI/bmoDJqBBMnAENTgXFeDoc/AOVV+yG2DogSpUTBdS9kJl2uZPa3mDA
         mW9bym9CDmuQ5wuetXojSzWAn5Lqliolq0cGSBXCPAtYI29bgWfGjFLL/cdMN5XkJy3U
         4ysyYRrIhHy8CrhTCf7pUJbYEnFad25lSMvrHFFgjXksDjSmUDxgqRK/+GA3JlsRxzhm
         rcRZdsKSsMzGIhfLoqMwf3it+5h6CHLXOcS6HgEMiVf7CLxwovZCF18nsjvbpzB9E/1B
         OPzA==
X-Gm-Message-State: AOAM533glFRLEKN85MZPJb10Ft3HN/UVKdmVRsOutmEpyrERGPR10TgQ
        YCObAnLlqsKu85JPBlcoc2M=
X-Google-Smtp-Source: ABdhPJwq4aJ+Z5IbcaznHsI80vw02BrmJPr0pCY2w3MQ3PosRJ69qHQpqpia16LiVPguhk4RCCXCoQ==
X-Received: by 2002:a17:902:b589:b0:14f:3f88:15e2 with SMTP id a9-20020a170902b58900b0014f3f8815e2mr18922156pls.171.1646035301395;
        Mon, 28 Feb 2022 00:01:41 -0800 (PST)
Received: from google.com ([2620:15c:202:201:43a2:93b6:ebd7:94fd])
        by smtp.gmail.com with ESMTPSA id y8-20020a056a00180800b004e156f7191esm11740621pfa.213.2022.02.28.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:01:40 -0800 (PST)
Date:   Mon, 28 Feb 2022 00:01:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Sean O'Brien <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 2/4] HID: Extract vivaldi hid feature mapping for use
 in hid-hammer
Message-ID: <YhyBYl0DbizOwClS@google.com>
References: <20220216195901.1326924-1-swboyd@chromium.org>
 <20220216195901.1326924-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216195901.1326924-3-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:58:59AM -0800, Stephen Boyd wrote:
> We need to support parsing the HID device in both the vivaldi and the
> hammer drivers so that we can properly expose the function row physmap
> to userspace when a hammer device uses a vivaldi keyboard layout for the
> function row keys. Extract the feature mapping logic from the vivaldi
> driver into an hid specific vivaldi library so we can use it from both
> HID drivers.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Tested-by: "Sean O'Brien" <seobrien@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/hid/Kconfig                |  9 +++
>  drivers/hid/Makefile               |  1 +
>  drivers/hid/hid-vivaldi-common.c   | 97 ++++++++++++++++++++++++++++++
>  drivers/hid/hid-vivaldi.c          | 69 +--------------------
>  include/linux/input/vivaldi-fmap.h |  9 +++
>  5 files changed, 118 insertions(+), 67 deletions(-)
>  create mode 100644 drivers/hid/hid-vivaldi-common.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 5569a2029dab..ea8fa71c9e9c 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -403,14 +403,23 @@ config HOLTEK_FF
>  	  Say Y here if you have a Holtek On Line Grip based game controller
>  	  and want to have force feedback support for it.
>  
> +config HID_VIVALDI_COMMON
> +	tristate
> +	help
> +	  ChromeOS Vivaldi HID parsing support library. This is a hidden
> +	  option so that drivers can use common code to parse the HID
> +	  descriptors for vivaldi function row keymap.
> +
>  config HID_GOOGLE_HAMMER
>  	tristate "Google Hammer Keyboard"
> +	select HID_VIVALDI_COMMON

This chunk belongs to the next patch.

>  	depends on USB_HID && LEDS_CLASS && CROS_EC
>  	help
>  	Say Y here if you have a Google Hammer device.
>  
>  config HID_VIVALDI
>  	tristate "Vivaldi Keyboard"
> +	select HID_VIVALDI_COMMON
>  	select INPUT_VIVALDIFMAP
>  	depends on HID
>  	help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 6d3e630e81af..469a6159ebae 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>  obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
>  obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
> +obj-$(CONFIG_HID_VIVALDI_COMMON) += hid-vivaldi-common.o
>  obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
>  obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
>  obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
> diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
> new file mode 100644
> index 000000000000..8a5074fd63b7
> --- /dev/null
> +++ b/drivers/hid/hid-vivaldi-common.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helpers for ChromeOS HID Vivaldi keyboards
> + *
> + * Copyright (C) 2022 Google, Inc
> + */
> +
> +#include <linux/export.h>
> +#include <linux/hid.h>
> +#include <linux/input/vivaldi-fmap.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#define HID_VD_FN_ROW_PHYSMAP 0x00000001
> +#define HID_USAGE_FN_ROW_PHYSMAP (HID_UP_GOOGLEVENDOR | HID_VD_FN_ROW_PHYSMAP)
> +
> +/**
> + * vivaldi_hid_feature_mapping - Fill out vivaldi keymap data exposed via HID
> + * @data: The vivaldi function keymap
> + * @hdev: HID device to parse
> + * @field: HID field to parse
> + * @usage: HID usage to parse
> + */
> +void vivaldi_hid_feature_mapping(struct vivaldi_data *data,
> +				 struct hid_device *hdev,
> +				 struct hid_field *field,
> +				 struct hid_usage *usage)
> +{
> +	struct hid_report *report = field->report;
> +	int fn_key;
> +	int ret;
> +	u32 report_len;
> +	u8 *report_data, *buf;
> +
> +	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
> +	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
> +		return;
> +
> +	fn_key = (usage->hid & HID_USAGE);
> +	if (fn_key < VIVALDI_MIN_FN_ROW_KEY || fn_key > VIVALDI_MAX_FN_ROW_KEY)
> +		return;
> +	if (fn_key > data->num_function_row_keys)
> +		data->num_function_row_keys = fn_key;
> +
> +	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
> +	if (!report_data)
> +		return;
> +
> +	report_len = hid_report_len(report);
> +	if (!report->id) {
> +		/*
> +		 * hid_hw_raw_request() will stuff report ID (which will be 0)
> +		 * into the first byte of the buffer even for unnumbered
> +		 * reports, so we need to account for this to avoid getting
> +		 * -EOVERFLOW in return.
> +		 * Note that hid_alloc_report_buf() adds 7 bytes to the size
> +		 * so we can safely say that we have space for an extra byte.
> +		 */
> +		report_len++;
> +	}
> +
> +	ret = hid_hw_raw_request(hdev, report->id, report_data,
> +				 report_len, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);
> +	if (ret < 0) {
> +		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
> +			 field->report->id);
> +		goto out;
> +	}
> +
> +	if (!report->id) {
> +		/*
> +		 * Undo the damage from hid_hw_raw_request() for unnumbered
> +		 * reports.
> +		 */
> +		report_data++;
> +		report_len--;
> +	}
> +
> +	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
> +				   report_len, 0);
> +	if (ret) {
> +		dev_warn(&hdev->dev, "failed to report feature %d\n",
> +			 field->report->id);
> +		goto out;
> +	}
> +
> +	data->function_row_physmap[fn_key - VIVALDI_MIN_FN_ROW_KEY] =
> +	    field->value[usage->usage_index];
> +
> +out:
> +	kfree(buf);
> +}
> +EXPORT_SYMBOL_GPL(vivaldi_hid_feature_mapping);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
> index adb56b342948..f70cab6a192b 100644
> --- a/drivers/hid/hid-vivaldi.c
> +++ b/drivers/hid/hid-vivaldi.c
> @@ -13,9 +13,6 @@
>  #include <linux/module.h>
>  #include <linux/sysfs.h>
>  
> -#define HID_VD_FN_ROW_PHYSMAP 0x00000001
> -#define HID_USAGE_FN_ROW_PHYSMAP (HID_UP_GOOGLEVENDOR | HID_VD_FN_ROW_PHYSMAP)
> -
>  static ssize_t function_row_physmap_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -60,70 +57,8 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
>  				    struct hid_usage *usage)
>  {
>  	struct vivaldi_data *drvdata = hid_get_drvdata(hdev);
> -	struct hid_report *report = field->report;
> -	int fn_key;
> -	int ret;
> -	u32 report_len;
> -	u8 *report_data, *buf;
> -
> -	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
> -	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
> -		return;
> -
> -	fn_key = (usage->hid & HID_USAGE);
> -	if (fn_key < VIVALDI_MIN_FN_ROW_KEY || fn_key > VIVALDI_MAX_FN_ROW_KEY)
> -		return;
> -	if (fn_key > drvdata->num_function_row_keys)
> -		drvdata->num_function_row_keys = fn_key;
> -
> -	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
> -	if (!report_data)
> -		return;
> -
> -	report_len = hid_report_len(report);
> -	if (!report->id) {
> -		/*
> -		 * hid_hw_raw_request() will stuff report ID (which will be 0)
> -		 * into the first byte of the buffer even for unnumbered
> -		 * reports, so we need to account for this to avoid getting
> -		 * -EOVERFLOW in return.
> -		 * Note that hid_alloc_report_buf() adds 7 bytes to the size
> -		 * so we can safely say that we have space for an extra byte.
> -		 */
> -		report_len++;
> -	}
> -
> -	ret = hid_hw_raw_request(hdev, report->id, report_data,
> -				 report_len, HID_FEATURE_REPORT,
> -				 HID_REQ_GET_REPORT);
> -	if (ret < 0) {
> -		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
> -			 field->report->id);
> -		goto out;
> -	}
> -
> -	if (!report->id) {
> -		/*
> -		 * Undo the damage from hid_hw_raw_request() for unnumbered
> -		 * reports.
> -		 */
> -		report_data++;
> -		report_len--;
> -	}
> -
> -	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
> -				   report_len, 0);
> -	if (ret) {
> -		dev_warn(&hdev->dev, "failed to report feature %d\n",
> -			 field->report->id);
> -		goto out;
> -	}
> -
> -	drvdata->function_row_physmap[fn_key - VIVALDI_MIN_FN_ROW_KEY] =
> -	    field->value[usage->usage_index];
> -
> -out:
> -	kfree(buf);
> +
> +	vivaldi_hid_feature_mapping(drvdata, hdev, field, usage);
>  }
>  
>  static int vivaldi_input_configured(struct hid_device *hdev,
> diff --git a/include/linux/input/vivaldi-fmap.h b/include/linux/input/vivaldi-fmap.h
> index 57563d9da022..c736200b4511 100644
> --- a/include/linux/input/vivaldi-fmap.h
> +++ b/include/linux/input/vivaldi-fmap.h
> @@ -4,6 +4,10 @@
>  
>  #include <linux/types.h>
>  
> +struct hid_device;
> +struct hid_field;
> +struct hid_usage;
> +

This all HID-specific and does not belong here, I created a new
hid-vivaldi-common.h in drivers/hid for it.

>  #define VIVALDI_MIN_FN_ROW_KEY	1
>  #define VIVALDI_MAX_FN_ROW_KEY	24
>  
> @@ -25,4 +29,9 @@ struct vivaldi_data {
>  ssize_t vivaldi_function_row_physmap_show(const struct vivaldi_data *data,
>  					  char *buf);
>  
> +void vivaldi_hid_feature_mapping(struct vivaldi_data *data,
> +				 struct hid_device *hdev,
> +				 struct hid_field *field,
> +				 struct hid_usage *usage);
> +
>  #endif /* _VIVALDI_KEYMAP_H */
> -- 
> https://chromeos.dev
> 

Thanks.

-- 
Dmitry
