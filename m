Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2E47470F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhLNQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:02:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:22975 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhLNQCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:02:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226285125"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="226285125"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 08:02:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="614327874"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 08:02:40 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id F0AE820462;
        Tue, 14 Dec 2021 18:02:38 +0200 (EET)
Date:   Tue, 14 Dec 2021 18:02:38 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        shawnx.tu@intel.com, tian.shu.qiu@intel.com,
        chiranjeevi.rapolu@intel.com, hyungwoo.yang@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
Subject: Re: [PATCH 6/6] media: hi556: Support device probe in non-zero ACPI
 D state
Message-ID: <YbjAHhDFJOSxFI+v@paasikivi.fi.intel.com>
References: <1636447715-15526-1-git-send-email-bingbu.cao@intel.com>
 <1636447715-15526-7-git-send-email-bingbu.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636447715-15526-7-git-send-email-bingbu.cao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bingbu,

On Tue, Nov 09, 2021 at 04:48:35PM +0800, Bingbu Cao wrote:
> Tell ACPI device PM code that the driver supports the device being in
> non-zero ACPI D state when the driver's probe function is entered.
> 
> Also do identification on the first access of the device, whether in probe
> or when starting streaming.
> 
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> Signed-off-by: Kao, Arec <arec.kao@intel.com>
> ---
>  drivers/media/i2c/hi556.c | 67 +++++++++++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/i2c/hi556.c b/drivers/media/i2c/hi556.c
> index 8db1cbedc1fd..c8011467d1a4 100644
> --- a/drivers/media/i2c/hi556.c
> +++ b/drivers/media/i2c/hi556.c
> @@ -495,6 +495,9 @@ struct hi556 {
>  
>  	/* Streaming on/off */
>  	bool streaming;
> +
> +	/* True if the device has been identified */
> +	bool identified;
>  };
>  
>  static u64 to_pixel_rate(u32 f_index)
> @@ -757,12 +760,38 @@ static void hi556_assign_pad_format(const struct hi556_mode *mode,
>  	fmt->field = V4L2_FIELD_NONE;
>  }
>  
> +static int hi556_identify_module(struct hi556 *hi556)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(&hi556->sd);
> +	int ret;
> +	u32 val;

If the sensor's already identified, you can return 0 here.

> +
> +	ret = hi556_read_reg(hi556, HI556_REG_CHIP_ID,
> +			     HI556_REG_VALUE_16BIT, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != HI556_CHIP_ID) {
> +		dev_err(&client->dev, "chip id mismatch: %x!=%x",
> +			HI556_CHIP_ID, val);
> +		return -ENXIO;
> +	}
> +
> +	hi556->identified = true;
> +
> +	return 0;
> +}

-- 
Sakari Ailus
