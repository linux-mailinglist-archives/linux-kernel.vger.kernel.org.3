Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3A4742FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhLNMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:53:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229807AbhLNMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:53:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEBATlS010386;
        Tue, 14 Dec 2021 13:53:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=T8Jcu6wd8lh9q27ClOVg9B6XcchEPMvYgTCpRDM1f1Y=;
 b=A1uV+mgMPOfIqsCQD2tu5fLxQyCBk+vLukOexqoMu3kJACmbMOBM09e105MzUholRucQ
 YXKaWPA2ETPKznmCPKH8nagQ1YsyoqnT5/SP42werPXFtyxDuyt/3UKSI+Xm+UbFI6Sh
 X362Lab5PQj78U7XIGBy3dnKAbaYjU5unw8k0n/jfvenoETXZMTUKecDkRkiFR3NhHal
 d3audN5DSOyNCASuP25+Cnx1f+aJ0xsuEbPZgMjjgghl9lmnNqW1fUHPLAf3+GjP6/m5
 GnZg2fILgWqBJt37SzW/cRf4sXuY3vgl2AOh/3BowQTN46TvsCJJAPknACjRBkJUirTW AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxnqb2trc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 13:53:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A72DA10002A;
        Tue, 14 Dec 2021 13:53:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 969AB23EF35;
        Tue, 14 Dec 2021 13:53:44 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 14 Dec
 2021 13:53:42 +0100
Subject: Re: [PATCH 1/1] usb: dwc2: gadget: don't try to disable ep0 in
 dwc2_hsotg_suspend
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20211207130101.270314-1-amelie.delaunay@foss.st.com>
 <46125d28-b065-b882-8a62-9d494b271755@synopsys.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <7bef0e3b-3430-1ad1-127d-7093511b6493@foss.st.com>
Date:   Tue, 14 Dec 2021 13:53:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <46125d28-b065-b882-8a62-9d494b271755@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_06,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 12/14/21 7:22 AM, Minas Harutyunyan wrote:
> Hi Amelie,
> 
> On 12/7/2021 5:01 PM, Amelie Delaunay wrote:
>> Calling dwc2_hsotg_ep_disable on ep0 (in/out) will lead to the following
>> logs before returning -EINVAL:
>> dwc2 49000000.usb-otg: dwc2_hsotg_ep_disable: called for ep0
>> dwc2 49000000.usb-otg: dwc2_hsotg_ep_disable: called for ep0
>>
> 
> This messages printed for EP0 OUT which can't be disabled, but EP0 IN
> can and should be disabled. Your patch exclude EP0 IN from disabling flow.


Thanks for the review. I wonder why then in dwc2_hsotg_udc_stop and 
dwc2_hsotg_core_init_disconnected EP0 IN is not disabled (loop starts 
from EP1) ?

Due to:
	/* Same dwc2_hsotg_ep is used in both directions for ep0 */
	hsotg->eps_out[0] = hsotg->eps_in[0];

the condition in dwc2_hsotg_ep_disable to display the error is always 
true for EP0, whatever the direction, so the log appears for EP0 IN & OUT:
	if (ep == &hsotg->eps_out[0]->ep) {
		dev_err(hsotg->dev, "%s: called for ep0\n", __func__);
		return -EINVAL;
	}

Should all loops need to be fixed to start loop from EP0 but exclude EP0 
OUT from being disabled, so that EP0 IN can be disabled ? e.g. for 
dwc2_hsotg_suspend:
	

$ git diff drivers/usb/dwc2/gadget.c
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 11d85a6e0b0d..0c12219bfbf4 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4231,7 +4231,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)

         dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);

-       if (ep == &hsotg->eps_out[0]->ep) {
+       if (ep == &hsotg->eps_out[0]->ep && !dir_in) {
                 dev_err(hsotg->dev, "%s: called for ep0\n", __func__);
                 return -EINVAL;
         }
@@ -5077,7 +5077,7 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
                 for (ep = 0; ep < hsotg->num_of_eps; ep++) {
                         if (hsotg->eps_in[ep])
 
dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
-                       if (hsotg->eps_out[ep])
+                       if (ep > 0 && hsotg->eps_out[ep])
 
dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
                 }
         }

Regards,
Amelie

> 
> Thanks,
> Minas
> 
>> To avoid these two logs while suspending, start disabling the endpoint
>> from the index 1, as done in dwc2_hsotg_udc_stop:
>>
>> 	/* all endpoints should be shutdown */
>> 	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
>> 		if (hsotg->eps_in[ep])
>> 			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
>> 		if (hsotg->eps_out[ep])
>> 			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
>> 	}
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>    drivers/usb/dwc2/gadget.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
>> index b884a83b26a6..ee31f9a328da 100644
>> --- a/drivers/usb/dwc2/gadget.c
>> +++ b/drivers/usb/dwc2/gadget.c
>> @@ -5086,7 +5086,7 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
>>    		hsotg->gadget.speed = USB_SPEED_UNKNOWN;
>>    		spin_unlock_irqrestore(&hsotg->lock, flags);
>>    
>> -		for (ep = 0; ep < hsotg->num_of_eps; ep++) {
>> +		for (ep = 1; ep < hsotg->num_of_eps; ep++) {
>>    			if (hsotg->eps_in[ep])
>>    				dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
>>    			if (hsotg->eps_out[ep])
> 
