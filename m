Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4A4C0D59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiBWHez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiBWHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:34:53 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B970CD0;
        Tue, 22 Feb 2022 23:34:26 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21N7YM5Q002893;
        Wed, 23 Feb 2022 01:34:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645601662;
        bh=KmBWwGPqmoJGkq/QnEJwIuI5M/v2TuCCfT5yA2AkKZA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EkAIBUOi4TYlV8+uxWlN3Kcz14lxgL1E31P0v8/Bw4763mgJcOP6PD/DwZ6xH+9zz
         2ade5zxxkgOtQP5+GOrMWf1u8ilU8HvtLcti0TAegHinP5AhSbvMrWVeKT8NQdQSIV
         lya22YzRng1jDao5pL0zWqYkO8xoSAjt4HRLU7XE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21N7YMKZ130341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 01:34:22 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 01:34:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 01:34:21 -0600
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21N7YInK104532;
        Wed, 23 Feb 2022 01:34:19 -0600
Subject: Re: [PATCH] usb: dwc3: drd: Add support for extcon drd notifier even
 with usb role switch config enabled
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20220218093348.1098-1-a-govindraju@ti.com>
 <273c9e6d-4fa3-52d9-e978-8f2be81dd6f6@synopsys.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <3792f301-1d94-0c72-87ff-c0683870bea1@ti.com>
Date:   Wed, 23 Feb 2022 13:04:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <273c9e6d-4fa3-52d9-e978-8f2be81dd6f6@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 23/02/22 6:33 am, Thinh Nguyen wrote:
> Hi,
> 
> Aswath Govindraju wrote:
>> In AM62x SoC, the USB controller supports USB role switching by using the
>> extcon drd notifiers. The current implementation does not accommodate this.
>> If usb role switching is enabled then drd notifiers are not added. If usb
>> role switching is not enabled then the dr_mode is forced to peripheral
>> (dwc3_get_dr_mode) and role switching will not be possible(dwc3_set_mode).
>>
>> Therefore, rearrange the "if else" logic such that extcon drd notifiers can
>> be added even with usb role switching enabled.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/usb/dwc3/drd.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index b919ea3d87f2..0e86b1d8b50c 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -583,12 +583,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
>>  	if (IS_ERR(dwc->edev))
>>  		return PTR_ERR(dwc->edev);
>>  
>> -	if (ROLE_SWITCH &&
>> -	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
>> -		ret = dwc3_setup_role_switch(dwc);
>> -		if (ret < 0)
>> -			return ret;
>> -	} else if (dwc->edev) {
>> +	if (dwc->edev) {
>>  		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>>  		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>>  					       &dwc->edev_nb);
>> @@ -598,7 +593,14 @@ int dwc3_drd_init(struct dwc3 *dwc)
>>  		}
>>  
>>  		dwc3_drd_update(dwc);
>> -	} else {
>> +	}
>> +
>> +	if (ROLE_SWITCH &&
>> +	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
>> +		ret = dwc3_setup_role_switch(dwc);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else if (!dwc->edev) {
>>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
>>  
>>  		/* use OTG block to get ID event */
> 
> 
> Please check the patch by Andrey Smirnov and see if it works for you:
> https://lore.kernel.org/linux-usb/20220221192020.346622-1-andrew.smirnov@gmail.com/
> 

Thank you for pointing me this patch. I does solve my issue.


Regards,
Aswath

> Thanks,
> Thinh
> 



