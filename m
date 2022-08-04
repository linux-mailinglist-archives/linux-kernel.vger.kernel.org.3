Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863858A2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiHDVm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiHDVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:42:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938864AD5B;
        Thu,  4 Aug 2022 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659649343; x=1691185343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DycE60ZHFlHY7IZxTQKn3nmGZVc4sC/DqRr2Ek6ZW1k=;
  b=UgL2QPbRwii1dO69CWFeRI5fmDTt+Csg7kL6SSjnUNMTPl9pRkjIKtfp
   aEnwlEWuF+EYniJDu+4bk6cgwwHIKi3wxfCnPpjSZe7gh0/nD/Oa2BIHe
   YwbSjHIcanAnhL4PoN6tamNnh19ahJmU3DJ49W+Kv5HhTtRIou++Vr3MD
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 04 Aug 2022 14:42:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:42:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 4 Aug 2022 14:42:22 -0700
Received: from [10.111.167.208] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 4 Aug 2022
 14:42:20 -0700
Message-ID: <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
Date:   Thu, 4 Aug 2022 14:42:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2022 4:51 PM, Thinh Nguyen wrote:
> On 8/2/2022, Elson Roy Serrao wrote:
>> An interface which is in function suspend state has to send a function
>> wakeup notification to the host in case it needs to initate any data
>> transfer. One notable difference between this and the existing remote
>> wakeup mechanism is that this can be called per-interface, and a UDC
>> would need to know the particular interface number to convey in its
>> Device Notification transaction packet.  Hence, we need to introduce
>> a new callback in the gadget_ops structure that UDC device drivers
>> can implement.  Similarly add a convenience function in the composite
>> driver which function drivers can call. Add support to handle such
>> requests in the composite layer and invoke the gadget op.
> 
> Sending the function wake notification should be done in the controller
> driver. The controller driver knows when is the proper link state
> (U0/ON) the device is in and would notify the host then.
> 
> What we need to add in the usb_gadget is whether the device is remote
> wakeup capable. Something like a flag usb_gadget->rw_capable.
> 
> We would also need some functions like usb_gadget_enable_remote_wakeup()
> and usb_gadget_disable_remote_wakeup() for the gadget driver to notify
> the controller driver when it checks against USB_CONFIG_ATT_WAKEUP in
> the bmAttributes configuration.
> 
> BR,
> Thinh


If we handle this in controller driver, then it would fail to get the 
right interface id when multiple functions have to send function wake 
notification. As per USB3.0 spec (below snippets) a function can be 
independently placed into function suspend state within a composite 
device and each function in function suspend state has to send a 
function wake notification to exit.

USB 3.0 Spec Section 9.2.5.3
"A function may be placed into Function Suspend independently of other 
functions within a composite device"

USB 3.0 Spec Section 9.2.5.4
"A function may signal that it wants to exit from Function Suspend by 
sending a Function Wake Notification to the host if it is enabled for 
function remote wakeup. This applies to single function devices as well 
as multiple function ( i.e., composite) devices. If the link is in
a non-U0 state, then the device must transition the link to U0 prior to 
sending the remote wake message. If a remote wake event occurs in 
multiple functions, each function shall send a Function Wake Notification"

Best Regards,
Elson

> 
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>    drivers/usb/gadget/composite.c | 32 ++++++++++++++++++++++++++++++++
>>    drivers/usb/gadget/udc/core.c  |  9 +++++++++
>>    include/linux/usb/composite.h  |  1 +
>>    include/linux/usb/gadget.h     |  2 ++
>>    4 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index 403563c..6bdce23 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -490,6 +490,38 @@ int usb_interface_id(struct usb_configuration *config,
>>    }
>>    EXPORT_SYMBOL_GPL(usb_interface_id);
>>    
>> +int usb_func_wakeup(struct usb_function *func)
>> +{
>> +	int ret, id;
>> +	unsigned long flags;
>> +
>> +	if (!func || !func->config || !func->config->cdev ||
>> +	    !func->config->cdev->gadget)
>> +		return -EINVAL;
>> +
>> +	DBG(func->config->cdev, "%s function wakeup\n", func->name);
>> +
>> +	spin_lock_irqsave(&func->config->cdev->lock, flags);
>> +
>> +	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
>> +		if (func->config->interface[id] == func)
>> +			break;
>> +
>> +	if (id == MAX_CONFIG_INTERFACES) {
>> +		ERROR(func->config->cdev, "Invalid function id:%d\n", id);
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	ret = usb_gadget_func_wakeup(func->config->cdev->gadget, id);
>> +
>> +err:
>> +	spin_unlock_irqrestore(&func->config->cdev->lock, flags);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(usb_func_wakeup);
>> +
>>    static u8 encode_bMaxPower(enum usb_device_speed speed,
>>    		struct usb_configuration *c)
>>    {
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index 7886497..fe5c504 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -816,6 +816,15 @@ int usb_gadget_activate(struct usb_gadget *gadget)
>>    }
>>    EXPORT_SYMBOL_GPL(usb_gadget_activate);
>>    
>> +int usb_gadget_func_wakeup(struct usb_gadget *gadget, int interface_id)
>> +{
>> +	if (gadget->speed < USB_SPEED_SUPER || !gadget->ops->func_wakeup)
>> +		return -EOPNOTSUPP;
>> +
>> +	return gadget->ops->func_wakeup(gadget, interface_id);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_gadget_func_wakeup);
>> +
>>    /* ------------------------------------------------------------------------- */
>>    
>>    #ifdef	CONFIG_HAS_DMA
>> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
>> index 9d27622..31b35d7 100644
>> --- a/include/linux/usb/composite.h
>> +++ b/include/linux/usb/composite.h
>> @@ -254,6 +254,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
>>    
>>    int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
>>    			struct usb_ep *_ep);
>> +int usb_func_wakeup(struct usb_function *func);
>>    
>>    #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
>>    
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index 3ad58b7..76f9de4 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -311,6 +311,7 @@ struct usb_udc;
>>    struct usb_gadget_ops {
>>    	int	(*get_frame)(struct usb_gadget *);
>>    	int	(*wakeup)(struct usb_gadget *);
>> +	int	(*func_wakeup)(struct usb_gadget *gadget, int interface_id);
>>    	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
>>    	int	(*vbus_session) (struct usb_gadget *, int is_active);
>>    	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
>> @@ -612,6 +613,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget);
>>    int usb_gadget_deactivate(struct usb_gadget *gadget);
>>    int usb_gadget_activate(struct usb_gadget *gadget);
>>    int usb_gadget_check_config(struct usb_gadget *gadget);
>> +int usb_gadget_func_wakeup(struct usb_gadget *gadget, int interface_id);
>>    #else
>>    static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
>>    { return 0; }
> 
