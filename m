Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320DF4FF525
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiDMKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiDMKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:54:00 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5959398;
        Wed, 13 Apr 2022 03:51:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23DApIgL053012;
        Wed, 13 Apr 2022 05:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649847078;
        bh=o9EW8fv01SjjG6H5HGgDKh8/HaooB31ZANXlp5IN+Yg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HyT25Yf84RH4pl5CHtsDDZXRby4paE8TQ/EeqHD67Dzm4PhcP140N+E0q1A96f9Ns
         I+heNPAmCOdDB9CZF938MsQufck/WsblFJXf6T6okNsKm9YO3rXIdGuMePQKG7BdXU
         Y2yWMiUyrQfoQb9SfZIxsOmJ9Z4+TqRQHHD3hoIc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23DApI6q039687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 05:51:18 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 05:51:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 05:51:17 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23DApDVx034324;
        Wed, 13 Apr 2022 05:51:14 -0500
Message-ID: <48cf5e66-e9ec-07fa-a971-dcf02d35fc2a@ti.com>
Date:   Wed, 13 Apr 2022 16:21:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC] usb: typec: tipd: Add support for polling interrupts
 status when interrupt line is not connected
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220412145059.4717-1-a-govindraju@ti.com>
 <YlaZIual4Fa/a81I@kuha.fi.intel.com>
 <5672af5d-d4a9-08ab-0594-7da57cd0972b@ti.com>
 <c41e011b-16de-d49f-21d4-0abd81841324@kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <c41e011b-16de-d49f-21d4-0abd81841324@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 13/04/22 16:08, Roger Quadros wrote:
> Hi Aswath,
> 
> On 13/04/2022 13:02, Aswath Govindraju wrote:
>> Hi Heikki,
>>
>> On 13/04/22 15:04, Heikki Krogerus wrote:
>>> Hi Aswath,
>>>
>>> On Tue, Apr 12, 2022 at 08:20:58PM +0530, Aswath Govindraju wrote:
>>>> In some cases the interrupt line from the pd controller may not be
>>>> connected. In these cases, poll the status of various events.
>>>
>>> Well, if the alert/interrupt line is not connected anywhere, then
>>> polling is the only way to go. I'm fine with that, but the driver
>>> really should be told that there is no interrupt. Using polling
>>> whenever request_threaded_irq() returns -EINVAL is wrong. We really
>>> should not even attempt to request the interrupt if there is no
>>> interrupt for the device.
>>>
>>> Isn't there any way you can get that information from DT? Or how is
>>> the device enumerated in your case?
>>>
>>
>> Would checking if (client->irq) field is populated, to decide between
>> polling and interrupts be a good approach?
> 
> 'interrupt' and 'interrupt-names' are required properties in DT binding doc
> Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> 
> You will need to add a new property to indicate that polling mode must be used
> and then interrupt properties become optional.
> 

Doesn't adding polling support mean that we are making interrupts
optional? So, can't we directly make the properties optional in the
bindings?


>>
>> I am sorry but I did not understand what you meant by device getting
>> enumerated. The device is on an I2C bus and gets enumerated based on the
>> I2C address provided. The device does not have I2C_IRQ line connected,
>> in my case.
> 
> I think he meant whether you are using device tree or something else.
> 

ohh okay, Thank you.

Regards,
Aswath

>>
>> Thanks,
>> Aswath
>>
>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> ---
>>>>  drivers/usb/typec/tipd/core.c | 90 ++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 83 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>>>> index 16b4560216ba..fa52d2067d6d 100644
>>>> --- a/drivers/usb/typec/tipd/core.c
>>>> +++ b/drivers/usb/typec/tipd/core.c
>>>> @@ -15,6 +15,8 @@
>>>>  #include <linux/interrupt.h>
>>>>  #include <linux/usb/typec.h>
>>>>  #include <linux/usb/role.h>
>>>> +#include <linux/workqueue.h>
>>>> +#include <linux/devm-helpers.h>
>>>>  
>>>>  #include "tps6598x.h"
>>>>  #include "trace.h"
>>>> @@ -93,6 +95,8 @@ struct tps6598x {
>>>>  	struct power_supply *psy;
>>>>  	struct power_supply_desc psy_desc;
>>>>  	enum power_supply_usb_type usb_type;
>>>> +
>>>> +	struct delayed_work wq_poll;
>>>>  };
>>>>  
>>>>  static enum power_supply_property tps6598x_psy_props[] = {
>>>> @@ -473,9 +477,8 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>>>>  	}
>>>>  }
>>>>  
>>>> -static irqreturn_t cd321x_interrupt(int irq, void *data)
>>>> +static int cd321x_handle_interrupt_status(struct tps6598x *tps)
>>>>  {
>>>> -	struct tps6598x *tps = data;
>>>>  	u64 event;
>>>>  	u32 status;
>>>>  	int ret;
>>>> @@ -513,14 +516,45 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>>>>  err_unlock:
>>>>  	mutex_unlock(&tps->lock);
>>>>  
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>>  	if (event)
>>>> -		return IRQ_HANDLED;
>>>> -	return IRQ_NONE;
>>>> +		return 0;
>>>> +	return 1;
>>>>  }
>>>>  
>>>> -static irqreturn_t tps6598x_interrupt(int irq, void *data)
>>>> +static irqreturn_t cd321x_interrupt(int irq, void *data)
>>>>  {
>>>>  	struct tps6598x *tps = data;
>>>> +	int ret;
>>>> +
>>>> +	ret = cd321x_handle_interrupt_status(tps);
>>>> +	if (ret)
>>>> +		return IRQ_NONE;
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +/* Time interval for Polling */
>>>> +#define POLL_INTERVAL   500 /* msecs */
>>>> +static void cd321x_poll_work(struct work_struct *work)
>>>> +{
>>>> +	struct tps6598x *tps = container_of(to_delayed_work(work),
>>>> +					    struct tps6598x, wq_poll);
>>>> +	int ret;
>>>> +
>>>> +	ret = cd321x_handle_interrupt_status(tps);
>>>> +	/*
>>>> +	 * If there is an error while reading the interrupt registers
>>>> +	 * then stop polling else, schedule another poll work item
>>>> +	 */
>>>> +	if (!(ret < 0))
>>>> +		queue_delayed_work(system_power_efficient_wq,
>>>> +				   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>>>> +}
>>>> +
>>>> +static int tps6598x_handle_interrupt_status(struct tps6598x *tps)
>>>> +{
>>>>  	u64 event1;
>>>>  	u64 event2;
>>>>  	u32 status;
>>>> @@ -561,9 +595,39 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>>>>  err_unlock:
>>>>  	mutex_unlock(&tps->lock);
>>>>  
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>>  	if (event1 | event2)
>>>> -		return IRQ_HANDLED;
>>>> -	return IRQ_NONE;
>>>> +		return 0;
>>>> +	return 1;
>>>> +}
>>>> +
>>>> +static irqreturn_t tps6598x_interrupt(int irq, void *data)
>>>> +{
>>>> +	struct tps6598x *tps = data;
>>>> +	int ret;
>>>> +
>>>> +	ret = tps6598x_handle_interrupt_status(tps);
>>>> +	if (ret)
>>>> +		return IRQ_NONE;
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static void tps6598x_poll_work(struct work_struct *work)
>>>> +{
>>>> +	struct tps6598x *tps = container_of(to_delayed_work(work),
>>>> +					    struct tps6598x, wq_poll);
>>>> +	int ret;
>>>> +
>>>> +	ret = tps6598x_handle_interrupt_status(tps);
>>>> +	/*
>>>> +	 * If there is an error while reading the interrupt registers
>>>> +	 * then stop polling else, schedule another poll work item
>>>> +	 */
>>>> +	if (!(ret < 0))
>>>> +		queue_delayed_work(system_power_efficient_wq,
>>>> +				   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>>>>  }
>>>>  
>>>>  static int tps6598x_check_mode(struct tps6598x *tps)
>>>> @@ -704,6 +768,7 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
>>>>  static int tps6598x_probe(struct i2c_client *client)
>>>>  {
>>>>  	irq_handler_t irq_handler = tps6598x_interrupt;
>>>> +	work_func_t work_poll_handler = tps6598x_poll_work;
>>>>  	struct device_node *np = client->dev.of_node;
>>>>  	struct typec_capability typec_cap = { };
>>>>  	struct tps6598x *tps;
>>>> @@ -748,6 +813,7 @@ static int tps6598x_probe(struct i2c_client *client)
>>>>  			APPLE_CD_REG_INT_PLUG_EVENT;
>>>>  
>>>>  		irq_handler = cd321x_interrupt;
>>>> +		work_poll_handler = cd321x_poll_work;
>>>>  	} else {
>>>>  		/* Enable power status, data status and plug event interrupts */
>>>>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
>>>> @@ -846,6 +912,16 @@ static int tps6598x_probe(struct i2c_client *client)
>>>>  					irq_handler,
>>>>  					IRQF_SHARED | IRQF_ONESHOT,
>>>>  					dev_name(&client->dev), tps);
>>>> +	if (ret == -EINVAL) {
>>>> +		dev_warn(&client->dev, "Unable to find the interrupt, switching to polling\n");
>>>> +		ret = devm_delayed_work_autocancel(tps->dev, &tps->wq_poll, work_poll_handler);
>>>> +		if (ret)
>>>> +			dev_err(&client->dev, "error while initializing workqueue\n");
>>>> +		else
>>>> +			queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
>>>> +					   msecs_to_jiffies(POLL_INTERVAL));
>>>> +	}
>>>> +
>>>>  	if (ret) {
>>>>  		tps6598x_disconnect(tps, 0);
>>>>  		typec_unregister_port(tps->port);
>>>
>>> thanks,
>>>
>>
>>
> 
> --
> cheers,
> -roger


-- 
Thanks,
Aswath
