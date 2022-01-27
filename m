Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4949EAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbiA0SzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiA0SzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:55:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:55:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d18so3330692plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/MCKCRermQ8vi6MOXf6MR66Z5FkR3u2o5119ZS5a6Q=;
        b=e3YUdOr+jqqCxNmoUBJo2597dKZ6YdbXbjobvAnHXqW2rRxOqXdmpJlnXZqtwi0amM
         Iv1CTOP7QOZnnrLwakSmmLOkP6tEUXPSXOJfXqobJwZFXejpwspoODOOnkTOZ4djkuFo
         KVXYiVnHimpRVkh/QR0t/72xZjb2sA6NmschE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/MCKCRermQ8vi6MOXf6MR66Z5FkR3u2o5119ZS5a6Q=;
        b=mzZuUU3B/WrMeNGe2jNW9TiqDsKpOWhkNzTKW1TVvjT7vZgX5THrMWx6/H6028wdDg
         unndIZxROL6qM+jS/C8QobKfAPMCj92Wz0dSGLblB/7+M0j19YwJs8okEXRurt/nu6YA
         id1bcVXgv4BS+RX2Djs/yhDM/hiEo0ODLIO+ff76mH5NY8AcAgOqg+Ddb0bzE94DqMQr
         ZUQJ7xW6Qik/6piFRBuI5DlazDQz7ZsxqSRCJUZqNwb9Oo8OvmaplEkVMUxnAxt2IkIs
         2uUKlP9f5uEF1LIb4wngmBscB8Rs9uL+DTxRMpTJWL0sL/nEx6y1PdWntN/IUwzaWBin
         yfgQ==
X-Gm-Message-State: AOAM5319Ev3gMoNDvqES6dyV+NBRTzcrwQB0JmyjDmPNS7zS367eeUST
        zNfd66vjIq2LnDHZnXWxq1KCkbjsFXR7pA==
X-Google-Smtp-Source: ABdhPJw0/czNKbXQkjF1ey1tmATcqujbpsvEFZ3zbgsiN3pfXuyd7QGrDLMxka9URrsGMR24jL6luA==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr2717338plo.69.1643309719779;
        Thu, 27 Jan 2022 10:55:19 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id pi1sm85014pjb.10.2022.01.27.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 10:55:19 -0800 (PST)
Date:   Thu, 27 Jan 2022 18:55:18 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC
 LPC I/O ports first
Message-ID: <YfLqloFQpF7bURGi@chromium.org>
References: <20220126180020.15873-1-dustin@howett.net>
 <20220126180020.15873-3-dustin@howett.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126180020.15873-3-dustin@howett.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dustin,

On Jan 26 12:00, Dustin L. Howett wrote:
> Some ChromeOS EC devices (such as the Framework Laptop) only map I/O
> ports 0x800-0x807. Making the larger reservation required by the non-MEC
> LPC (the 0xFF ports for the memory map, and the 0xFF ports for the
> parameter region) is non-viable on these devices.
> 
> Since we probe the MEC EC first, we can get away with a smaller
> reservation that covers the MEC EC ports. If we fall back to classic
> LPC, we can grow the reservation to cover the memory map and the
> parameter region.
> 
> This patch also fixes an issue where we would interact with I/O ports
> 0x800-0x807 without first making a reservation.
> 
> Signed-off-by: Dustin L. Howett <dustin@howett.net>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c         | 39 ++++++++++++-------
>  .../linux/platform_data/cros_ec_commands.h    |  4 ++
>  2 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 458eb59db2ff..06fdfe365710 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -341,9 +341,14 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  	u8 buf[2];
>  	int irq, ret;
>  
> -	if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> -				 dev_name(dev))) {
> -		dev_err(dev, "couldn't reserve memmap region\n");
> +	/*
> +	 * The Framework Laptop (and possibly other non-ChromeOS devices)
> +	 * only exposes the eight I/O ports that are required for the Microchip EC.
> +	 * Requesting a larger reservation will fail.
> +	 */
> +	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> +				 EC_HOST_CMD_MEC_REGION_SIZE, dev_name(dev))) {
> +		dev_err(dev, "couldn't reserve MEC region\n");
>  		return -EBUSY;
>  	}
>  
> @@ -357,6 +362,12 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  	cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
>  	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
>  	if (buf[0] != 'E' || buf[1] != 'C') {
> +		if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> +					 dev_name(dev))) {
> +			dev_err(dev, "couldn't reserve memmap region\n");
> +			return -EBUSY;
> +		}
> +
>  		/* Re-assign read/write operations for the non MEC variant */
>  		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
>  		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
> @@ -366,17 +377,19 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  			dev_err(dev, "EC ID not detected\n");
>  			return -ENODEV;
>  		}
> -	}
>  
> -	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> -				 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> -		dev_err(dev, "couldn't reserve region0\n");
> -		return -EBUSY;
> -	}
> -	if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> -				 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> -		dev_err(dev, "couldn't reserve region1\n");
> -		return -EBUSY;
> +		/* Reserve the remaining I/O ports required by the non-MEC protocol. */
> +		if (!devm_request_region(dev, EC_HOST_CMD_REGION0 + EC_HOST_CMD_MEC_REGION_SIZE,
> +					 EC_HOST_CMD_REGION_SIZE - EC_HOST_CMD_MEC_REGION_SIZE,
> +					 dev_name(dev))) {
> +			dev_err(dev, "couldn't reserve remainder of region0\n");
> +			return -EBUSY;
> +		}
> +		if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> +					 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> +			dev_err(dev, "couldn't reserve region1\n");
> +			return -EBUSY;
> +		}
>  	}
>  
>  	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 271bd87bff0a..a85b1176e6c0 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -55,6 +55,10 @@
>  #define EC_HOST_CMD_REGION0    0x800
>  #define EC_HOST_CMD_REGION1    0x880
>  #define EC_HOST_CMD_REGION_SIZE 0x80
> +/*
> + * Other machines report only the region spanned by the Microchip MEC EC.
> + */
> +#define EC_HOST_CMD_MEC_REGION_SIZE 0x08
I can't find this update in the EC code base [1]. Is there any reason
you are not adding this, or is the change in flight (or in some other
location)?

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

Thanks,

-Prashant
