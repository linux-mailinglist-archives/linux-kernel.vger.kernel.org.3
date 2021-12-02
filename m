Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB7466673
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358965AbhLBP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:29:00 -0500
Received: from smtp1.axis.com ([195.60.68.17]:64338 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358956AbhLBP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638458735;
  x=1669994735;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bRDJH78iq1dSB+OwO8ajF8+FkyZnsnLkOyEilzbKVBI=;
  b=Jd59Ep+nyxzcaDY9LqlhSnz4LSCeXqbz+43RWgYVSAKVNIweE4CAxoW3
   nTe7PBqPN71K/1rQhJUvB+RxWycOKePAkAtB1LpqSua+TDxZTTlIO11J1
   BoFO3Yt1teSrdT9Zd2gJk4gWH5RcrBVfkV2oIYn22z7cDLc3dPMrLd0Jj
   01dOPE+464CcQyvJM6ekmG8/QeHTXtAvrUvAhVKWRQsD6VznAcP6xF2Q6
   GWPyzb6+XzRsgfrg54gfyKN/akpXIsxyvSRgqpSjl5sOLfVlEnWsZPGeH
   fZ/MO6ssSshsKNzGNXM+A2b8fHBjQmbrI0tDyvAyzWYf0FIDLGorhaBhA
   w==;
Subject: Re: [PATCH] rtc: rs5c372: add offset correction support
From:   Camel Guo <camelg@axis.com>
To:     Camel Guo <Camel.Guo@axis.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     kernel <kernel@axis.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211130095004.22777-1-camel.guo@axis.com>
 <f0e2eb3c-8e50-f6db-4c52-810da9c83b7a@axis.com>
Message-ID: <1de86914-429d-72a2-811e-8b296623c608@axis.com>
Date:   Thu, 2 Dec 2021 16:25:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f0e2eb3c-8e50-f6db-4c52-810da9c83b7a@axis.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail03w.axis.com (10.20.40.9) To se-mail03w.axis.com
 (10.20.40.9)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 3:55 PM, Camel Guo wrote:
> On 11/30/21 10:50 AM, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>
>>
>> This commit adds support of offset correction by configuring the
>> oscillation adjustment register of rs5c372.
>>
>> Signed-off-by: Camel Guo <camelg@axis.com>
>> ---
>>   drivers/rtc/rtc-rs5c372.c | 80 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
>> index 80980414890c..77027498cad5 100644
>> --- a/drivers/rtc/rtc-rs5c372.c
>> +++ b/drivers/rtc/rtc-rs5c372.c
>> @@ -30,6 +30,8 @@
>>   #define RS5C372_REG_TRIM        7
>>   #       define RS5C372_TRIM_XSL         0x80
>>   #       define RS5C372_TRIM_MASK        0x7F
>> +#      define RS5C372_TRIM_DEV         (1 << 7)
>> +#      define RS5C372_TRIM_DECR        (1 << 6)
>>
>>   #define RS5C_REG_ALARM_A_MIN    8                       /* or 
>> ALARM_W */
>>   #define RS5C_REG_ALARM_A_HOURS  9
>> @@ -485,6 +487,82 @@ static int rs5c372_rtc_proc(struct device *dev, 
>> struct seq_file *seq)
>>   #define rs5c372_rtc_proc        NULL
>>   #endif
>>
>> +static int rs5c372_read_offset(struct device *dev, long *offset)
>> +{
>> +       struct rs5c372 *rs5c = i2c_get_clientdata(to_i2c_client(dev));
>> +       int addr = RS5C_ADDR(RS5C372_REG_TRIM);
>> +       unsigned char val = i2c_smbus_read_byte_data(rs5c->client, addr);
>> +       long ppb_per_step = (val & RS5C372_TRIM_DEV) ? 1017 : 3052;
>> +       unsigned char decr = val & RS5C372_TRIM_DECR;
>> +
>> +       /* Only bits[0:5] repsents the time counts */
>> +       val &= 0x3F;
>> +
>> +       /* If bits[1:5] are all 0, it means no increment or decrement */
>> +       if (!(val & 0x3E)) {
>> +               *offset = 0;
>> +       } else {
>> +               if (decr)
>> +                       *offset = -(((~val) & 0x3F) + 1) * ppb_per_step;
>> +               else
>> +                       *offset = (val - 1) * ppb_per_step;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int rs5c372_set_offset(struct device *dev, long offset)
>> +{
>> +       struct rs5c372 *rs5c = i2c_get_clientdata(to_i2c_client(dev));
>> +       int addr = RS5C_ADDR(RS5C372_REG_TRIM);
>> +       unsigned char val = RS5C372_TRIM_DEV;
>> +       long steps = 0;
>> +
>> +       /*
>> +        * Check if it is possible to use high resolution mode 
>> (DEV=1). In this
>> +        * mode, the minimum resolution is 2 / (32768 * 20 * 3), which 
>> is about
>> +        * 1017 ppb
>> +        */
>> +       steps = DIV_ROUND_CLOSEST(offset, 1017);
>> +       if (steps > 0x3E || steps < -0x3E) {
>> +               /*
>> +                * offset is out of the range of high resolution mode. 
>> Try to
>> +                * use low resolution mode (DEV=0). In this mode, the 
>> minimum
>> +                * resolution is 2 / (32768 * 20), which is about 3052 
>> ppb.
>> +                */
>> +               val &= ~RS5C372_TRIM_DEV;
>> +               steps = DIV_ROUND_CLOSEST(offset, 3052);
>> +
>> +               if (steps > 0x3E || steps < -0x3E)
>> +                       return -ERANGE;
>> +       }
>> +
>> +       if (steps > 0) {
>> +               val |= steps + 1;
>> +       } else {
>> +               val |= RS5C372_TRIM_DECR;
>> +               val |= (~(-steps - 1)) & 0x3F;
>> +       }
>> +
>> +       if (!steps || !(val & 0x3E)) {
>> +               /*
>> +                * if offset is too small, set oscillation adjustment 
>> register
>> +                * with the default values, which means no increment or
>> +                * decrement.
>> +                */
>> +               val = 0;
>> +       }
>> +
>> +       dev_dbg(&rs5c->client->dev, "write 0x%x for offset %ld\n", 
>> val, offset);
>> +
>> +       if (i2c_smbus_write_byte_data(rs5c->client, addr, val) < 0) {
>> +               dev_err(&rs5c->client->dev, "failed to write 0x%x to 
>> reg %d\n", val, addr);
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct rtc_class_ops rs5c372_rtc_ops = {
>>           .proc           = rs5c372_rtc_proc,
>>           .read_time      = rs5c372_rtc_read_time,
>> @@ -492,6 +570,8 @@ static const struct rtc_class_ops rs5c372_rtc_ops = {
>>           .read_alarm     = rs5c_read_alarm,
>>           .set_alarm      = rs5c_set_alarm,
>>           .alarm_irq_enable = rs5c_rtc_alarm_irq_enable,
>> +       .read_offset    = rs5c372_read_offset,
>> +       .set_offset     = rs5c372_set_offset,
>>   };
>>
>>   #if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
>> -- 
>> 2.20.1
>>
> 
> Just realize that the oscillation adjustment registers of r2*, rs5c* are 
> not totally same and all of these differences need to be handled in 
> different way. Hence this patch needs to be updated to cover all cases.

Patch V2 has been uploaded. Please review that one instead.
