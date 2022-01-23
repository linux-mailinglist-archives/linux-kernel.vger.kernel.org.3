Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA19A4975DA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 22:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiAWV5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 16:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAWV5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 16:57:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF1C06173B;
        Sun, 23 Jan 2022 13:57:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso14600020pjm.4;
        Sun, 23 Jan 2022 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AvnCHDaaduenYEuy1qGCp5mLSZh/yvD7LLM94hNmZ18=;
        b=IGk8VVj3dT3JoYUaw766mGy+8dTjrFJB98aoRKIs/JJLi2Lkx8UJhgaosfQ1h14RSv
         OtWGhLRykTU+bts7XgqYZVzlQjcMkswzQ5W2psEH0P7pOcRZys7t4mmHGMJpZ0QTIzWZ
         EIQqPN+aKqZF0mFYI0xag6qKVNhy1GwWmDnbDXtGI0INuKr71BQld/PZFyTfK+2EYhen
         ZnopLg+vOJFCRM6+lL/wtG3V6dIPE/cVRymKqSasBZSqYw9XnO+wQdY/7AgBfGNCWFGa
         m7Qgzl+OeEJ36/FwvKaayem4ufs2TMM5DJwTU0HJfMJ0ccAy6684OkMX1OiS99cqPFi8
         MOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvnCHDaaduenYEuy1qGCp5mLSZh/yvD7LLM94hNmZ18=;
        b=khsAWMODZCLBPON81g55fWbQ+t1CCBaaHfSSUO4uINYlyHaHPe0ZEK7tmoohRQxnrE
         KZJCEjfw2TTbGapqDfv/xXapqm0KMURYIefz/MGRZmSfNyfiIIEOShMqcdK8km/p8SVU
         h/2KwASQMKRD4eb/YB6ddygqMH2ggsiWLToLssW8kQap2S3dl78ge39D0GWIAfehG4ys
         p9PwmjvzoHFT8eXGYtZvoEcr0CuKcngNevuOyEkZiKwD+9A6bg4pSgyxGA8VHb16B2GB
         E9c9jbjDkA5mc2ghXmzT2m/uU7Gv3UxRPmlj1ZKROYvIThZHqmDPqy+Sz3vR9LkOnf1h
         ycCw==
X-Gm-Message-State: AOAM530g6lGv4StGW5scjW0nuNAi7M0vxZMJIGPHw3Rj+8pEv6p6t1WW
        8S0sSCGqQmb0FDZsR+Ib8KY=
X-Google-Smtp-Source: ABdhPJxZQbnG53Ljk6ArfVaiRh2mtTcrfBhPAZM0TbzsNp9vfTiB9JMNAnYkfQS7uoHDmsCDSg4pKQ==
X-Received: by 2002:a17:902:7681:b0:149:bb15:c53f with SMTP id m1-20020a170902768100b00149bb15c53fmr12152447pll.159.1642975027464;
        Sun, 23 Jan 2022 13:57:07 -0800 (PST)
Received: from google.com ([2620:15c:202:201:37b1:d24a:55b5:a2fa])
        by smtp.gmail.com with ESMTPSA id v17sm6396286pfm.10.2022.01.23.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 13:57:06 -0800 (PST)
Date:   Sun, 23 Jan 2022 13:57:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: PCHG: Use MKBP for device event handling
Message-ID: <Ye3PL2LRY/RfNx+g@google.com>
References: <20220123194317.481022-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123194317.481022-1-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daisuke,

On Sun, Jan 23, 2022 at 11:43:13AM -0800, Daisuke Nojiri wrote:
> Currently, the peripheral device charger driver receives PCHG
> events as device events (EC_HOST_EVENT_DEVICE=10) except ones
> related to firmware updates. This is delivered via the Chrome OS
> host event protocol.
> 
> On X86 systems, the Chrome OS host event protocol is implemented on
> ACPI and a ACPI handler for EC_HOST_EVENT_DEVICE (a.k.a. _Q0A)
> doesn't exist.
> 
> Instead of adding a device event ACPI handler, this patch makes the
> PCHG driver receive a device event through the MKBP protocol.
> 
> The MKBP protocol is already used for firmware update for PCHG
> devices.  So, this allows us to unite all PCHG event handling via
> MKBP on both x86 and ARM platforms.

I wonder if we could simply say that we have switched EC to deliver all
peripheral change communication/events to MKBP protocol so that the
handling is unified. We can simply drop the EC_CMD_DEVICE_EVENT handling
because we have not shipped any devices using this mechanism (correct?).

> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
> 
>  .../power/supply/cros_peripheral_charger.c    | 35 ++--------
>  .../linux/platform_data/cros_ec_commands.h    | 64 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
> index 305f10dfc06d1b..d1c45af2c50638 100644
> --- a/drivers/power/supply/cros_peripheral_charger.c
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/stringify.h>
>  #include <linux/types.h>
> +#include <asm/unaligned.h>
>  
>  #define DRV_NAME		"cros-ec-pchg"
>  #define PCHG_DIR_PREFIX		"peripheral"
> @@ -237,46 +238,22 @@ static int cros_pchg_event(const struct charger_data *charger,
>  	return NOTIFY_OK;
>  }
>  
> -static u32 cros_get_device_event(const struct charger_data *charger)
> -{
> -	struct ec_params_device_event req;
> -	struct ec_response_device_event rsp;
> -	struct device *dev = charger->dev;
> -	int ret;
> -
> -	req.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
> -	ret = cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> -				   &req, sizeof(req), &rsp, sizeof(rsp));
> -	if (ret < 0) {
> -		dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
> -		return 0;
> -	}
> -
> -	return rsp.event_mask;
> -}
> -
>  static int cros_ec_notify(struct notifier_block *nb,
>  			  unsigned long queued_during_suspend,
>  			  void *data)
>  {
>  	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> -	u32 host_event = cros_ec_get_host_event(ec_dev);
>  	struct charger_data *charger =
>  			container_of(nb, struct charger_data, notifier);
> -	u32 device_event_mask;
> +	u32 host_event;
>  
> -	if (!host_event)
> +	if (ec_dev->event_size != sizeof(host_event))
>  		return NOTIFY_DONE;
>  
> -	if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> -		return NOTIFY_DONE;
> +	host_event = get_unaligned_le32(&ec_dev->event_data.data.host_event);
>  
> -	/*
> -	 * todo: Retrieve device event mask in common place
> -	 * (e.g. cros_ec_proto.c).
> -	 */
> -	device_event_mask = cros_get_device_event(charger);
> -	if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
> +	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG

Bikeshedding: I'd check this condition as the very first thing in the
driver, then checked the size as we are doing now, fetched the
host_event data and then checked event against EC_MKBP_PCHG_DEVICE_EVENT
mask.

> +			|| !(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
>  		return NOTIFY_DONE;
>  
>  	return cros_pchg_event(charger, host_event);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 271bd87bff0a25..c784bed3388865 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3386,6 +3386,9 @@ enum ec_mkbp_event {
>  	/* Send an incoming CEC message to the AP */
>  	EC_MKBP_EVENT_CEC_MESSAGE = 9,
>  
> +	/* Peripheral device charger event */
> +	EC_MKBP_EVENT_PCHG = 12,
> +
>  	/* Number of MKBP events */
>  	EC_MKBP_EVENT_COUNT,
>  };
> @@ -5527,6 +5530,67 @@ enum pchg_state {
>  	[PCHG_STATE_CONNECTED] = "CONNECTED", \
>  	}
>  
> +/**
> + * Update firmware of peripheral chip
> + */
> +#define EC_CMD_PCHG_UPDATE 0x0136
> +
> +/* Port number is encoded in bit[28:31]. */
> +#define EC_MKBP_PCHG_PORT_SHIFT		28
> +/* Utility macro for converting MKBP event to port number. */
> +#define EC_MKBP_PCHG_EVENT_TO_PORT(e)	(((e) >> EC_MKBP_PCHG_PORT_SHIFT) & 0xf)
> +/* Utility macro for extracting event bits. */
> +#define EC_MKBP_PCHG_EVENT_MASK(e)	((e) \
> +					& GENMASK(EC_MKBP_PCHG_PORT_SHIFT-1, 0))
> +
> +#define EC_MKBP_PCHG_UPDATE_OPENED	BIT(0)
> +#define EC_MKBP_PCHG_WRITE_COMPLETE	BIT(1)
> +#define EC_MKBP_PCHG_UPDATE_CLOSED	BIT(2)
> +#define EC_MKBP_PCHG_UPDATE_ERROR	BIT(3)
> +#define EC_MKBP_PCHG_DEVICE_EVENT	BIT(4)
> +
> +enum ec_pchg_update_cmd {
> +	/* Reset chip to normal mode. */
> +	EC_PCHG_UPDATE_CMD_RESET_TO_NORMAL = 0,
> +	/* Reset and put a chip in update (a.k.a. download) mode. */
> +	EC_PCHG_UPDATE_CMD_OPEN,
> +	/* Write a block of data containing FW image. */
> +	EC_PCHG_UPDATE_CMD_WRITE,
> +	/* Close update session. */
> +	EC_PCHG_UPDATE_CMD_CLOSE,
> +	/* End of commands */
> +	EC_PCHG_UPDATE_CMD_COUNT,
> +};
> +
> +struct ec_params_pchg_update {
> +	/* PCHG port number */
> +	uint8_t port;
> +	/* enum ec_pchg_update_cmd */
> +	uint8_t cmd;
> +	/* Padding */
> +	uint8_t reserved0;
> +	uint8_t reserved1;
> +	/* Version of new firmware */
> +	uint32_t version;
> +	/* CRC32 of new firmware */
> +	uint32_t crc32;
> +	/* Address in chip memory where <data> is written to */
> +	uint32_t addr;
> +	/* Size of <data> */
> +	uint32_t size;
> +	/* Partial data of new firmware */
> +	uint8_t data[];
> +} __ec_align4;
> +
> +BUILD_ASSERT(EC_PCHG_UPDATE_CMD_COUNT
> +	     < BIT(sizeof(((struct ec_params_pchg_update *)0)->cmd)*8));
> +
> +struct ec_response_pchg_update {
> +	/* Block size */
> +	uint32_t block_size;
> +} __ec_align4;
> +
> +
>  /*****************************************************************************/
>  /* Voltage regulator controls */
>  
> -- 
> 2.31.0
> 

Thanks.

-- 
Dmitry
