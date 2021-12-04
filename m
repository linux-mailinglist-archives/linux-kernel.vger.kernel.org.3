Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4246868D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378449AbhLDRg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:36:26 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:39206 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345154AbhLDRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:36:25 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Dec 2021 12:36:25 EST
IronPort-SDR: cdjzRu4O0aDPaKIznXfkZ1gg4qmAR8pP7oznVce+ZOKuTy6R55m2EVQscLSWXJ+BqOJNVvo7Ni
 uF0y5IwpuhJFlKD5b0egl1/7RVFQFc0qPmL9xj50raIpWwgNAmt9cc2bSPiDTEPL68URlNmrdq
 AYmpOYVIQS1oIWGavOrcyBShxRJU2gxGar689Hq11lDMRTeE1KIEadSrFdAgNKRYvcbhYkWAjp
 GYvh+1CPmkBrkyYu1KYImFMO0gdHxeNU+jsEHz8Tz3eDxzlQ7KYYyKdoFAXl2YVThOCxne4RfU
 Tl7dZraN3+RP8GqkUPFkII2o
X-IronPort-AV: E=Sophos;i="5.87,287,1631606400"; 
   d="scan'208";a="69277906"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 04 Dec 2021 09:25:51 -0800
IronPort-SDR: Lk58CnbOOdJuy3uU+QVenspLk63/eMP1Sc3jjRQ3Lyx9mCE022czQbYZ3sTL0ld57XgRfTjMkm
 GcBECKZfP+8TCwDh1zDOM1wA5gvb6O0ErRFtpGv+iXg5C2VlmDX78kruRlZYN0JmBaLhz5HkWe
 u6JG/CYd8LQgFasIqcNt6GsZ1pmYovIy2M8p0qrotOu2lCWUuqd4pF4qOzmUFTJzFwVyOg82oM
 k6CrriQXYjoL063AIEs3ilJyEz3NrMxVw+SQKXaavC31CNvauqqfwKIw6b2D16Sg/rSltSTiN3
 BEA=
Subject: Re: [PATCH 1/2] rtc: max31343: Add a driver for Maxim MAX31343
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <a.zummo@towertech.it>, <robh+dt@kernel.org>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
References: <20211016192118.255624-1-alexey_firago@mentor.com>
 <20211016192118.255624-2-alexey_firago@mentor.com>
 <YaamZW1nyOGDXfyw@piout.net>
From:   afirago <alexey_firago@mentor.com>
Message-ID: <37ef2ad4-d044-5183-892c-e1fd6ded1b69@mentor.com>
Date:   Sat, 4 Dec 2021 20:25:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaamZW1nyOGDXfyw@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-15.mgc.mentorg.com (139.181.222.15) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your review.

On 01.12.2021 01:32, Alexandre Belloni wrote:
> Hello,
> 
> On 16/10/2021 22:21:17+0300, Alexey Firago wrote:
>> +#define MAX31343_REG_TIMER_CFG	(0x05)
>> +#define  TIMER_CFG_TFS		GENMASK(1, 0) /* Timer frequency */
>> +#define  TIMER_CFG_TRPT		BIT(2) /* Timer repeat mode */
>> +#define  TIMER_CFG_TPAUSE	BIT(3) /* Timer Pause */
>> +#define  TIMER_CFG_TE		BIT(4) /* Timer enable */
>> +
>> +/* RTC section */
>> +#define MAX31343_REG_SEC	(0x06)
>> +#define  SEC10_MASK	GENMASK(6, 4) /* RTC seconds in multiples of 10 */
>> +#define  SEC_MASK	GENMASK(3, 0) /* RTC seconds value */
> 
> I'm not convinced having separate masks is useful here, was that
> automatically generated?

I've just exported those definitions from the table in the datasheet 
prior to creating the driver.

>> +static int max31343_rtc_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct max31343_rtc_data *max31343 = dev_get_drvdata(dev);
>> +	u8 date[7];
>> +	int ret;
>> +
>> +	dev_dbg(dev, "RTC set time %04d-%02d-%02d %02d/%02d/%02d\n",
>> +		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
>> +		tm->tm_hour, tm->tm_min, tm->tm_sec);
>> +
> 
> This could use %ptR

Will change it (or probably completely remove it) after hwmon review.

>> +	date[0] = bin2bcd(tm->tm_sec);
>> +	date[1] = bin2bcd(tm->tm_min);
>> +	date[2] = bin2bcd(tm->tm_hour);
>> +	date[3] = tm->tm_wday;
>> +	date[4] = bin2bcd(tm->tm_mday);
>> +	date[5] = bin2bcd(tm->tm_mon + 1);
>> +
>> +	if (tm->tm_year >= 200)
>> +		date[5] |= CENTURY;
>> +	date[6] = bin2bcd(tm->tm_year % 100);
>> +
>> +	ret = regmap_bulk_write(max31343->regmap, MAX31343_REG_SEC, date,
>> +				sizeof(date));
>> +	return ret;
>> +}
>> +
> 
> [...]
> 
>> +static int
>> +max31343_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> +{
>> +	struct max31343_rtc_data *max31343 = NULL;
>> +	int ret, status;
>> +	struct nvmem_config nvmem_cfg = {
>> +		.name = "max31343_nvram",
>> +		.word_size = 1,
>> +		.stride = 1,
>> +		.size = MAX31343_RAM_SIZE,
>> +		.type = NVMEM_TYPE_BATTERY_BACKED,
>> +		.reg_read = max31343_nvram_read,
>> +		.reg_write = max31343_nvram_write,
>> +	};
>> +
>> +	max31343 = devm_kzalloc(&client->dev, sizeof(struct max31343_rtc_data),
>> +				GFP_KERNEL);
>> +	if (!max31343)
>> +		return -ENOMEM;
>> +
>> +	max31343->regmap = devm_regmap_init_i2c(client, &max31343_regmap_config);
>> +	if (IS_ERR(max31343->regmap))
>> +		return PTR_ERR(max31343->regmap);
>> +
>> +	i2c_set_clientdata(client, max31343);
>> +
>> +	ret = regmap_read(max31343->regmap, MAX31343_REG_STATUS, &status);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	max31343->rtc = devm_rtc_allocate_device(&client->dev);
>> +	if (IS_ERR(max31343->rtc))
>> +		return PTR_ERR(max31343->rtc);
>> +
>> +	max31343->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
>> +	max31343->rtc->range_max = RTC_TIMESTAMP_END_2199;
> 
> For my information, did you check the time continuity in this interval?

Yes, I've checked setting of out-of-range values, checked edge values 
and checked 2099 -> 2100 -> 2101 transitions.

> 
>> +	max31343->rtc->ops = &max31343_rtc_ops;
>> +	ret = devm_rtc_register_device(max31343->rtc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	nvmem_cfg.priv = max31343->regmap;
>> +	devm_rtc_nvmem_register(max31343->rtc, &nvmem_cfg);
>> +	max31343_hwmon_register(&client->dev);
> 
> The whole driver seems ok, I'd like to get a review from the hwmon
> maintainers on the hwmon part as it is quite large.

Ok.

Thanks,
Alexey

