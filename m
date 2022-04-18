Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B1505B73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbiDRPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345767AbiDRPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:43:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1F34663;
        Mon, 18 Apr 2022 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650294527; x=1681830527;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IbCWLEa3c/MgKJEED8myAOpu4UjIwrLOhgkBGKhMgus=;
  b=MuhRWp+7WY2idpniXS/Oe30Tg+hPK70MucWgBW3hBGQa7IdT01gKUQRg
   82cI6GW8KPYl7nbN67+GD5T0Lh5iNpb8iWFcbeFWo3/nioXcSPiS6HRW3
   P7xTEM+KJrH7crEXtIqU75v079YxgMVjM9GoDZX8ZbfvOUrUuQ7Aujeu7
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Apr 2022 08:08:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:08:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 08:08:42 -0700
Received: from [10.216.11.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 08:08:37 -0700
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V10 5/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-6-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n531GVMuuR6HM2ezjOPJCg7S-rD3eaEKWzrYsnM-jwQHKw@mail.gmail.com>
Message-ID: <9d8543e1-4aa8-f430-322a-83d110586152@quicinc.com>
Date:   Mon, 18 Apr 2022 20:38:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n531GVMuuR6HM2ezjOPJCg7S-rD3eaEKWzrYsnM-jwQHKw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2022 5:51 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-14 05:30:14)
>> Use i2c_new_dummy_device() to register clients along with
>> the main mfd device.
> Why?


As discussed on V9 of this series, I've done these changes.

By using this API we can register other clients at different address 
space without having separate DT node.

This avoids calling the probe twice for the same chip, once for each 
address space 0x8 and 0x9. I'll add this description in commit text.


>> Signed-off-by: Satya Priya<quic_c_skakit@quicinc.com>
>> ---
>> Changes in V10:
>>   - Implement i2c_new_dummy_device to register extra clients.
>>
>>   drivers/mfd/qcom-pm8008.c       | 54 +++++++++++++++++++++++++++++++++--------
>>   include/linux/mfd/qcom_pm8008.h | 13 ++++++++++
>>   2 files changed, 57 insertions(+), 10 deletions(-)
>>   create mode 100644 include/linux/mfd/qcom_pm8008.h
>>
>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>> index 97a72da..ca5240d 100644
>> --- a/drivers/mfd/qcom-pm8008.c
>> +++ b/drivers/mfd/qcom-pm8008.c
>> @@ -56,8 +57,10 @@ enum {
>>   #define PM8008_PERIPH_OFFSET(paddr)    (paddr - PM8008_PERIPH_0_BASE)
>>
>>   struct pm8008_data {
>> +       bool ready;
>>          struct device *dev;
>> -       struct regmap *regmap;
>> +       struct i2c_client *clients[PM8008_NUM_CLIENTS];
>> +       struct regmap *regmap[PM8008_NUM_CLIENTS];
>>          struct gpio_desc *reset_gpio;
>>          int irq;
>>          struct regmap_irq_chip_data *irq_data;
>> @@ -152,9 +155,20 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>>          .max_register   = 0xFFFF,
>>   };
>>
>> +struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid)
>> +{
>> +       if (!chip || !chip->ready) {
> Is it even possible?


I think no, I'll remove it.


>> +               pr_err("pm8008 chip not initialized\n");
>> +               return NULL;
>> +       }
>> +
>> +       return chip->regmap[sid];
>> +}
>> +
>>   static int pm8008_init(struct pm8008_data *chip)
>>   {
>>          int rc;
>> +       struct regmap *regmap = pm8008_get_regmap(chip, PM8008_INFRA_SID);
>>
>>          /*
>>           * Set TEMP_ALARM peripheral's TYPE so that the regmap-irq framework
>> @@ -162,19 +176,19 @@ static int pm8008_init(struct pm8008_data *chip)
>>           * This is required to enable the writing of TYPE registers in
>>           * regmap_irq_sync_unlock().
>>           */
>> -       rc = regmap_write(chip->regmap,
>> +       rc = regmap_write(regmap,
>>                           (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET),
>>                           BIT(0));
>>          if (rc)
>>                  return rc;
>>
>>          /* Do the same for GPIO1 and GPIO2 peripherals */
>> -       rc = regmap_write(chip->regmap,
>> +       rc = regmap_write(regmap,
>>                           (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
>>          if (rc)
>>                  return rc;
>>
>> -       rc = regmap_write(chip->regmap,
>> +       rc = regmap_write(regmap,
>>                           (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
>>
>>          return rc;
>> @@ -186,6 +200,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>>          int rc, i;
>>          struct regmap_irq_type *type;
>>          struct regmap_irq_chip_data *irq_data;
>> +       struct regmap *regmap = pm8008_get_regmap(chip, PM8008_INFRA_SID);
> Instead of calling pm8008_get_regmap() many times why not pass the
> regmap through from pm8008_probe_irq_peripherals() called in probe? At
> that point we could remove the regmap pointer from struct pm8008_data?


Okay.


>>          rc = pm8008_init(chip);
>>          if (rc) {
>> @@ -209,7 +224,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>>                                  IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
>>          }
>>
>> -       rc = devm_regmap_add_irq_chip(chip->dev, chip->regmap, client_irq,
>> +       rc = devm_regmap_add_irq_chip(chip->dev, regmap, client_irq,
>>                          IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
>>          if (rc) {
>>                  dev_err(chip->dev, "Failed to add IRQ chip: %d\n", rc);
>> @@ -221,19 +236,38 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>>
>>   static int pm8008_probe(struct i2c_client *client)
>>   {
>> -       int rc;
>> +       int rc, i;
>>          struct pm8008_data *chip;
>> +       struct device_node *node = client->dev.of_node;
>>
>>          chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>>          if (!chip)
>>                  return -ENOMEM;
>>
>>          chip->dev = &client->dev;
>> -       chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
>> -       if (!chip->regmap)
>> -               return -ENODEV;
>>
>> -       i2c_set_clientdata(client, chip);
>> +       for (i = 0; i < PM8008_NUM_CLIENTS; i++) {
> This is 2. Why do we have a loop? Just register the i2c client for
> pm8008_infra first and then make a dummy for the second address without
> the loop and the indentation. Are there going to be more i2c clients?


There wont be more than 2 clients, I can remove the loop, but then we 
will have repetitive code.. something like below

      chip->dev = &client->dev;
      i2c_set_clientdata(client, chip);

      regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg[0]);
      if (!regmap)
          return -ENODEV;


      pm8008_client = i2c_new_dummy_device(client->adapter,
                              client->addr + 1);
      if (IS_ERR(pm8008_client)) {
          dev_err(&pm8008_client->dev, "can't attach client\n");
          return PTR_ERR(pm8008_client);
      }
      pm8008_client->dev.of_node = of_node_get(client->dev.of_node);
      i2c_set_clientdata(pm8008_client, chip);

      regulators_regmap = devm_regmap_init_i2c(pm8008_client, 
&qcom_mfd_regmap_cfg[1]);
      if (!regmap)
          return -ENODEV;

>> +               if (i == 0) {
>> +                       chip->clients[i] = client;
>> +               } else {
>> +                       chip->clients[i] = i2c_new_dummy_device(client->adapter,
>> +                                                               client->addr + i);
>> +                       if (IS_ERR(chip->clients[i])) {
>> +                               dev_err(&client->dev, "can't attach client %d\n", i);
>> +                               return PTR_ERR(chip->clients[i]);
>> +                       }
>> +                       chip->clients[i]->dev.of_node = of_node_get(node);
>> +               }
>> +
>> +               chip->regmap[i] = devm_regmap_init_i2c(chip->clients[i],
>> +                                                       &qcom_mfd_regmap_cfg);
>> +               if (!chip->regmap[i])
>> +                       return -ENODEV;
>> +
>> +               i2c_set_clientdata(chip->clients[i], chip);
>> +       }
>> +
>> +       chip->ready = true;
>>
>>          if (of_property_read_bool(chip->dev->of_node, "interrupt-controller")) {
>>                  rc = pm8008_probe_irq_peripherals(chip, client->irq);
>> diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
>> new file mode 100644
>> index 0000000..bc64f01
>> --- /dev/null
>> +++ b/include/linux/mfd/qcom_pm8008.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __QCOM_PM8008_H__
>> +#define __QCOM_PM8008_H__
>> +
>> +#define PM8008_INFRA_SID       0
>> +#define PM8008_REGULATORS_SID  1
>> +
>> +#define PM8008_NUM_CLIENTS     2
>> +
>> +struct pm8008_data;
>> +struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid);
> Could this be avoided if the regulator driver used
> dev_get_regmap(&pdev->dev.parent, "regulator") to find the regmap named
> "regulator" of the parent device, i.e. pm8008-infra.

I gave it a try, it didn't work. I could not get the regmap for 
regulators using pm8008-infra i.e., 0x8 device pointer.

I checked the other drivers using i2c_new_dummy_device(), they are 
either getting the regmap by accessing the mfd struct through global 
variables or using headers.


