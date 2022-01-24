Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA69649A3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2366807AbiAXXxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1846030AbiAXXOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:14:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C0C06F8C2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:22:37 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z131so5495962pgz.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YpyozKQg+308D8DXH4ejjXpy/uQNL1MLMopUiW1gyt0=;
        b=MFN+GeC5TBnxb4Rbr/vO9y3o+Qqi6HhV1KvD9aSoeEA1HlJuA1Kjw0OG+c4ETZAGYT
         7hRMSb7tTErMoJjogvXoPu3LjutHRGDCnIilEnaxZkCnP3i0D3BtuNIhtNKcljxVFJhE
         DfcVteKWTP9tUhro+a5enzsAalT2r70VID5r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YpyozKQg+308D8DXH4ejjXpy/uQNL1MLMopUiW1gyt0=;
        b=14bqyNxabGmx0MGyQrWWKT3y3viHPOx9h2bsnpdg+ge3Zinz3+ccl616EYmK/bHN75
         eLy9ADJXW/t+FSCBBFpS0gt+D6lgaU7E1BBnyM7VjcNpl9dmgGpIPC4ELEEW6E0YmgT/
         pYrV79vp4rerlGr99Fd4gKIrbgm73DNiP1hxvSrxw4+e8jRedHYcZC5ssFhUlSDAAjdp
         Nl22F/9W+mAZTGgYlrOOYPEwXe9NtKspYSpK1gF3JQkWKxeTSef9j9QjlafF4NwxDIqi
         Ggkbz8FjXYKF6aAh7gqiiGiPz+E4yvJtG3QjHYk26s5aw4TYtTgeK49YOR4RmqxBTtvV
         2CVQ==
X-Gm-Message-State: AOAM533iDcKammJcupGkGaOpt3FD9f6H9KTPZzkgyY32M2s/nhd6W0hC
        aimqPKnvVxFKBHWfEMuSXQ2xRw==
X-Google-Smtp-Source: ABdhPJykSEUhExV5uSgDgwcOxuN//4yGOBWt8z3cAjgNQMtDG/WYh2+VEoGlrOBPWPnQX2RCWy5leQ==
X-Received: by 2002:a63:3746:: with SMTP id g6mr12992725pgn.18.1643059357059;
        Mon, 24 Jan 2022 13:22:37 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id bc19sm2901282pgb.66.2022.01.24.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 13:22:36 -0800 (PST)
Date:   Mon, 24 Jan 2022 21:22:35 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: PCHG: Use MKBP for device event
 handling
Message-ID: <Ye8Ym9Ie7UOp0/jY@chromium.org>
References: <20220124010348.681893-1-dnojiri@chromium.org>
 <20220124011143.684348-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124011143.684348-1-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daisuke,

On Jan 23 17:11, Daisuke Nojiri wrote:
> This patch makes the PCHG driver receive device events through
> MKBP protocol since CrOS EC switched to deliver all peripheral
> charge events to the MKBP protocol. This will unify PCHG event
> handling on X86 and ARM.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
> v1 -> v2
> * Make the patch description concise.
> * Change the order of if-conditions in cros_ec_notify.
> ---
>  .../power/supply/cros_peripheral_charger.c    | 35 ++--------
>  .../linux/platform_data/cros_ec_commands.h    | 64 +++++++++++++++++++

In the past, the maintainer here has requested the header update to be
in a separate patch. Perhaps we should follow that format.

>  2 files changed, 70 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
> index 305f10dfc06d1b..cb402f48087ddf 100644
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
> +	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG
> +			|| ec_dev->event_size != sizeof(host_event))
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
> +	if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
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

Do we need to introduce these structs if they are not being used anywhere?
This header isn't auto-generated AFAIK.

If they *are* being used, could you kindly point to where they are being
used?

Thanks,
