Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38F7475145
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhLODQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:16:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:25937 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhLODQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:16:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="263283420"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="263283420"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 19:16:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682318698"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.188]) ([10.238.232.188])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2021 19:16:08 -0800
Subject: Re: [PATCH 4/6] media: imx208: Support device probe in non-zero ACPI
 D state
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        shawnx.tu@intel.com, tian.shu.qiu@intel.com,
        chiranjeevi.rapolu@intel.com, hyungwoo.yang@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org
References: <1636447715-15526-1-git-send-email-bingbu.cao@intel.com>
 <1636447715-15526-5-git-send-email-bingbu.cao@intel.com>
 <Ybi/b0QYV2BwSbQk@paasikivi.fi.intel.com>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <374d87f4-a3e5-fbaa-b4eb-c1ac1bd983dd@linux.intel.com>
Date:   Wed, 15 Dec 2021 11:13:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ybi/b0QYV2BwSbQk@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 11:59 PM, Sakari Ailus wrote:
> Hi Bingbu,
> 
> On Tue, Nov 09, 2021 at 04:48:33PM +0800, Bingbu Cao wrote:
>> Tell ACPI device PM code that the driver supports the device being in
>> non-zero ACPI D state when the driver's probe function is entered.
>>
>> Also do identification on the first access of the device, whether in probe
>> or when starting streaming.
>>
>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
>> ---
>>  drivers/media/i2c/imx208.c | 77 +++++++++++++++++++++++++++++-----------------
>>  1 file changed, 48 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx208.c b/drivers/media/i2c/imx208.c
>> index 6f3d9c1b5879..b9f6d5f33b58 100644
>> --- a/drivers/media/i2c/imx208.c
>> +++ b/drivers/media/i2c/imx208.c
>> @@ -296,6 +296,9 @@ struct imx208 {
>>  	/* OTP data */
>>  	bool otp_read;
>>  	char otp_data[IMX208_OTP_SIZE];
>> +
>> +	/* True if the device has been identified */
>> +	bool identified;
>>  };
>>  
>>  static inline struct imx208 *to_imx208(struct v4l2_subdev *_sd)
>> @@ -619,6 +622,34 @@ static int imx208_set_pad_format(struct v4l2_subdev *sd,
>>  	return 0;
>>  }
>>  
>> +static int imx208_identify_module(struct imx208 *imx208)
>> +{
>> +	struct i2c_client *client = v4l2_get_subdevdata(&imx208->sd);
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (imx208->identified)
>> +		return 0;
> 
> Otp access requires this as well.

Sakari, thanks for your review.

Yes, OTP read will trigger the LED blink, but I am not sure it makes sense that camera
framework try to read the OTP data without streaming, and it would complain once fail to
access the OTP data.
> 
> How about adding a runtime PM resume callback for this?

For the runtime PM callback, what is the benefit adding a callback here as will call try
pm_runtime_get_sync() each stream on?

> 
> I guess it'd be better for the rest, too. Up to you.
> 
>> +
>> +	ret = imx208_read_reg(imx208, IMX208_REG_CHIP_ID,
>> +			      2, &val);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to read chip id %x\n",
>> +			IMX208_CHIP_ID);
>> +		return ret;
>> +	}
>> +
>> +	if (val != IMX208_CHIP_ID) {
>> +		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
>> +			IMX208_CHIP_ID, val);
>> +		return -EIO;
>> +	}
>> +
>> +	imx208->identified = true;
>> +
>> +	return 0;
>> +}
>> +
>>  /* Start streaming */
>>  static int imx208_start_streaming(struct imx208 *imx208)
>>  {
>> @@ -626,6 +657,10 @@ static int imx208_start_streaming(struct imx208 *imx208)
>>  	const struct imx208_reg_list *reg_list;
>>  	int ret, link_freq_index;
>>  
>> +	ret = imx208_identify_module(imx208);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/* Setup PLL */
>>  	link_freq_index = imx208->cur_mode->link_freq_index;
>>  	reg_list = &link_freq_configs[link_freq_index].reg_list;
>> @@ -752,29 +787,6 @@ static int __maybe_unused imx208_resume(struct device *dev)
>>  }
>>  
>>  /* Verify chip ID */
>> -static int imx208_identify_module(struct imx208 *imx208)
>> -{
>> -	struct i2c_client *client = v4l2_get_subdevdata(&imx208->sd);
>> -	int ret;
>> -	u32 val;
>> -
>> -	ret = imx208_read_reg(imx208, IMX208_REG_CHIP_ID,
>> -			      2, &val);
>> -	if (ret) {
>> -		dev_err(&client->dev, "failed to read chip id %x\n",
>> -			IMX208_CHIP_ID);
>> -		return ret;
>> -	}
>> -
>> -	if (val != IMX208_CHIP_ID) {
>> -		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
>> -			IMX208_CHIP_ID, val);
>> -		return -EIO;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static const struct v4l2_subdev_video_ops imx208_video_ops = {
>>  	.s_stream = imx208_set_stream,
>>  };
>> @@ -961,6 +973,7 @@ static int imx208_probe(struct i2c_client *client)
>>  {
>>  	struct imx208 *imx208;
>>  	int ret;
>> +	bool full_power;
>>  	u32 val = 0;
>>  
>>  	device_property_read_u32(&client->dev, "clock-frequency", &val);
>> @@ -978,11 +991,14 @@ static int imx208_probe(struct i2c_client *client)
>>  	/* Initialize subdev */
>>  	v4l2_i2c_subdev_init(&imx208->sd, client, &imx208_subdev_ops);
>>  
>> -	/* Check module identity */
>> -	ret = imx208_identify_module(imx208);
>> -	if (ret) {
>> -		dev_err(&client->dev, "failed to find sensor: %d", ret);
>> -		goto error_probe;
>> +	full_power = acpi_dev_state_d0(&client->dev);
>> +	if (full_power) {
>> +		/* Check module identity */
>> +		ret = imx208_identify_module(imx208);
>> +		if (ret) {
>> +			dev_err(&client->dev, "failed to find sensor: %d", ret);
>> +			goto error_probe;
>> +		}
>>  	}
>>  
>>  	/* Set default mode to max resolution */
>> @@ -1017,7 +1033,9 @@ static int imx208_probe(struct i2c_client *client)
>>  		goto error_async_subdev;
>>  	}
>>  
>> -	pm_runtime_set_active(&client->dev);
>> +	/* Set the device's state to active if it's in D0 state. */
>> +	if (full_power)
>> +		pm_runtime_set_active(&client->dev);
>>  	pm_runtime_enable(&client->dev);
>>  	pm_runtime_idle(&client->dev);
>>  
>> @@ -1077,6 +1095,7 @@ static struct i2c_driver imx208_i2c_driver = {
>>  	},
>>  	.probe_new = imx208_probe,
>>  	.remove = imx208_remove,
>> +	.flags = I2C_DRV_ACPI_WAIVE_D0_PROBE,
>>  };
>>  
>>  module_i2c_driver(imx208_i2c_driver);
> 

-- 
Best regards,
Bingbu Cao
