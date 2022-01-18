Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC64923E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbiARKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:40:54 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230274AbiARKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:40:53 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I7fugc023855;
        Tue, 18 Jan 2022 11:40:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=R6yADMWkGnmfWZMh+iGP3k6JFWg14mCBCHvlHpxq0KU=;
 b=Z5C+Oi43Bt/d5AjD5nfHnuvfBoeFRh4wyGMVDAbeTiTsHd/WD+VBcNsMdlfYQw74pVrG
 Km3p2TC+Ylpg6Nk6HIXV7AyUrRYtKYI3B8N7xzCEfci3RwZBjmBAV5X6eF5cnTgtgFw3
 PlXHCrlWrLSWuHqxkjmmvVf5LK6hVDJ6C37zGHmtgOmGldM6e9PaiMqXDT4sDtojjgua
 qvB9c9o7jILeRNpValsH6si80TIRsVdZIUMzMolIKsXUaakTCU2j+zj/qSoMeSJNVmeF
 XpI4DAgNoGzZBjjElZYOZhaCGz0D/mLQt8OZUGtuNkn4hyyyn2C0g4BMclMTnPl5sMjl AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dnsd0908v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 11:40:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F3BC10002A;
        Tue, 18 Jan 2022 11:40:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83CC4212300;
        Tue, 18 Jan 2022 11:40:49 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.46) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 18 Jan
 2022 11:40:48 +0100
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
 <39694435-d44b-64f8-9614-6082f9c22443@synopsys.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <1f8db483-0965-e87d-20b0-4f2bccd9a3dd@foss.st.com>
Date:   Tue, 18 Jan 2022 11:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <39694435-d44b-64f8-9614-6082f9c22443@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_02,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Kind reminder about this patch.

Thanks,
Amelie

On 12/16/21 11:20 AM, Minas Harutyunyan wrote:
> On 12/7/2021 5:01 PM, Amelie Delaunay wrote:
>> Calling dwc2_hsotg_ep_disable on ep0 (in/out) will lead to the following
>> logs before returning -EINVAL:
>> dwc2 49000000.usb-otg: dwc2_hsotg_ep_disable: called for ep0
>> dwc2 49000000.usb-otg: dwc2_hsotg_ep_disable: called for ep0
>>
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
> 
> Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> 
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
