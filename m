Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C24FE63A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357828AbiDLQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357903AbiDLQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:47:53 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07AA49930;
        Tue, 12 Apr 2022 09:45:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09321077|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0642605-0.00489878-0.930841;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NPL4wXj_1649781929;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NPL4wXj_1649781929)
          by smtp.aliyun-inc.com(33.37.67.126);
          Wed, 13 Apr 2022 00:45:30 +0800
Subject: Re: [PATCH 2/2] USB: dwc2: Add OTG support for Ingenic SoCs.
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, hminas@synopsys.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com,
        =?UTF-8?Q?Dragan_=c4=8ce=c4=8davac?= <dragancecavac@yahoo.com>
References: <1627116521-124612-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1627116521-124612-3-git-send-email-zhouyanjie@wanyeetech.com>
 <IQWQWQ.9EAMZ76IPL892@crapouillou.net>
 <e4f7897a-6b70-d936-a968-e66556382851@wanyeetech.com>
 <8735s37slq.fsf@kernel.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <021ece97-5e62-c07f-bb6d-b69c93d73b31@wanyeetech.com>
Date:   Wed, 13 Apr 2022 00:45:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8735s37slq.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 2021/7/24 下午9:24, Felipe Balbi wrote:
> Hi Zhou,
>
> Zhou Yanjie writes:
>>>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
>>>> index 67c5eb1..a7a1b50 100644
>>>> --- a/drivers/usb/dwc2/params.c
>>>> +++ b/drivers/usb/dwc2/params.c
>>>> @@ -71,6 +71,47 @@ static void dwc2_set_his_params(struct
>>>> dwc2_hsotg *hsotg)
>>>>       p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
>>>>   }
>>>>
>>>> +static void dwc2_set_jz4775_params(struct dwc2_hsotg *hsotg)
>>>> +{
>>>> +    struct dwc2_core_params *p = &hsotg->params;
>>>> +
>>>> +    p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
>>>> +    p->speed = DWC2_SPEED_PARAM_HIGH;
>>>> +    p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
>>>> +    p->phy_utmi_width = 16;
>>>> +    p->deactivate_ingenic_overcurrent_detection =
>>>> +        device_property_read_bool(hsotg->dev, "disable-over-current");
>>> That device property was not documented in the previous patch. Also
>>> this probably should be "ingenic,disable-over-current".
>>>
>> This device property already exists (it has been used in the
>> "dwc2_get_device_properties()" function below).
>>
>> Under normal circumstances, after using this device attribute, it
>> should be possible to turn off the overcurrent
>>
>> detection, but on the Ingenic processors, somehow it did not take
>> effect normally, and we must operate the
>>
>> "VBVALOEN" bit and "VBVALOVAL" bit of "GOTGCTL" register to make it normal.
> I believe what Paul is suggesting is that this property lacks
> documentation under Documentation/devicetree/bindings/. If that's the
> case, you could take the opportunity to document the property and,
> perhaps, add the missing prefix.


Sorry for the long time delay.

Looks like Krzysztof has done the job, I will send v2 soon.


Thanks and best regards!


