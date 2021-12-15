Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06746475111
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhLOCtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:49:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:27544 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhLOCto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:49:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="302510114"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="302510114"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 18:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682312340"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.188]) ([10.238.232.188])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2021 18:49:41 -0800
Subject: Re: [PATCH 6/6] media: hi556: Support device probe in non-zero ACPI D
 state
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        shawnx.tu@intel.com, tian.shu.qiu@intel.com,
        chiranjeevi.rapolu@intel.com, hyungwoo.yang@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org
References: <1636447715-15526-1-git-send-email-bingbu.cao@intel.com>
 <1636447715-15526-7-git-send-email-bingbu.cao@intel.com>
 <YbjAHhDFJOSxFI+v@paasikivi.fi.intel.com>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <7a1db2f4-f132-c700-9406-387977308f97@linux.intel.com>
Date:   Wed, 15 Dec 2021 10:46:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbjAHhDFJOSxFI+v@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 12:02 AM, Sakari Ailus wrote:
> Hi Bingbu,
> 
> On Tue, Nov 09, 2021 at 04:48:35PM +0800, Bingbu Cao wrote:
>> Tell ACPI device PM code that the driver supports the device being in
>> non-zero ACPI D state when the driver's probe function is entered.
>>
>> Also do identification on the first access of the device, whether in probe
>> or when starting streaming.
>>
>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
>> Signed-off-by: Kao, Arec <arec.kao@intel.com>
>> ---
>>  drivers/media/i2c/hi556.c | 67 +++++++++++++++++++++++++++++------------------
>>  1 file changed, 42 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/media/i2c/hi556.c b/drivers/media/i2c/hi556.c
>> index 8db1cbedc1fd..c8011467d1a4 100644
>> --- a/drivers/media/i2c/hi556.c
>> +++ b/drivers/media/i2c/hi556.c
>> @@ -495,6 +495,9 @@ struct hi556 {
>>  
>>  	/* Streaming on/off */
>>  	bool streaming;
>> +
>> +	/* True if the device has been identified */
>> +	bool identified;
>>  };
>>  
>>  static u64 to_pixel_rate(u32 f_index)
>> @@ -757,12 +760,38 @@ static void hi556_assign_pad_format(const struct hi556_mode *mode,
>>  	fmt->field = V4L2_FIELD_NONE;
>>  }
>>  
>> +static int hi556_identify_module(struct hi556 *hi556)
>> +{
>> +	struct i2c_client *client = v4l2_get_subdevdata(&hi556->sd);
>> +	int ret;
>> +	u32 val;
> 
> If the sensor's already identified, you can return 0 here.

Yes, I will add in v2. Thanks!

> 
>> +
>> +	ret = hi556_read_reg(hi556, HI556_REG_CHIP_ID,
>> +			     HI556_REG_VALUE_16BIT, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val != HI556_CHIP_ID) {
>> +		dev_err(&client->dev, "chip id mismatch: %x!=%x",
>> +			HI556_CHIP_ID, val);
>> +		return -ENXIO;
>> +	}
>> +
>> +	hi556->identified = true;
>> +
>> +	return 0;
>> +}
> 

-- 
Best regards,
Bingbu Cao
