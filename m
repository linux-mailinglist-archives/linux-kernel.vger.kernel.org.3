Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3A4B7394
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiBOPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:46:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiBOPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:45:55 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0984CEA1E;
        Tue, 15 Feb 2022 07:42:51 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FBXjgK004249;
        Tue, 15 Feb 2022 16:42:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1NItCu9SWalObc1QZs2qiIgpnRXaojBJO4YO8ejOjmI=;
 b=L/4Yqbzg9bqm2rYdZJhrMvEDpSO4BWfHIpp3kxOHSFnzFubcPJhOtpOex5wIP8Zany8S
 wcanTfGQOYdFT9w/B2DnG1yW+5PheFRifbEIuyLEIvhxB16lIgsFIs/XtDOaSxc+VL/h
 7+EWDesYKSYnCRxRhR062ixSLLek4gPeSJth5ue06Oq+yIwaIlj7zXPS9SsSqfKaPjFE
 soccpTzGukTC+W1PJzIP84iR5PQQQRIm4ZioR6s6Q2qor1A1ZYQX48MpWlT3QldOsEEz
 zsKpOOZB6ndnHFDaYgMK7lzwogi1YC/PmMj+h41wyNX2RxAftSX2vxm5+X+nbC4UF29r XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e87me31fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 16:42:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5312D10002A;
        Tue, 15 Feb 2022 16:42:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46AA222D161;
        Tue, 15 Feb 2022 16:42:47 +0100 (CET)
Received: from [10.48.1.238] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 16:42:46 +0100
Subject: Re: [PATCH v2] usb: dwc2: drd: fix soft connect when gadget is
 unconfigured
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <hminas@synopsys.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <1644923059-3619-1-git-send-email-fabrice.gasnier@foss.st.com>
 <Yguy5OMW477VmMuv@kroah.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <dab7c8fe-0cf5-66a6-bf84-25fe84b4a221@foss.st.com>
Date:   Tue, 15 Feb 2022 16:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yguy5OMW477VmMuv@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 3:04 PM, Greg KH wrote:
> On Tue, Feb 15, 2022 at 12:04:19PM +0100, Fabrice Gasnier wrote:
>> When the gadget driver hasn't been (yet) configured, and the cable is
>> connected to a HOST, the SFTDISCON gets cleared unconditionally, so the
>> HOST tries to enumerate it.
>> At the host side, this can result in a stuck USB port or worse. When
>> getting lucky, some dmesg can be observed at the host side:
>>  new high-speed USB device number ...
>>  device descriptor read/64, error -110
>>
>> Fix it in drd, by checking the enabled flag before calling
>> dwc2_hsotg_core_connect(). It will be called later, once configured,
>> by the normal flow:
>> - udc_bind_to_driver
>>  - usb_gadget_connect
>>    - dwc2_hsotg_pullup
>>      - dwc2_hsotg_core_connect
>>
>> Fixes: 17f934024e84 ("usb: dwc2: override PHY input signals with usb role switch support")
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> Changes in v2:
>> - Fix build error: 'struct dwc2_hsotg' has no member named 'enabled';
>>   as reported by the kernel test robot.
>>   https://lore.kernel.org/all/202202112236.AwoOTtHO-lkp@intel.com/
>>   Add dwc2_is_device_enabled() macro to handle this.
>> ---
>>  drivers/usb/dwc2/core.h | 2 ++
>>  drivers/usb/dwc2/drd.c  | 6 ++++--
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
>> index 8a63da3..8a7751b 100644
>> --- a/drivers/usb/dwc2/core.h
>> +++ b/drivers/usb/dwc2/core.h
>> @@ -1418,6 +1418,7 @@ void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg);
>>  void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2);
>>  int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode);
>>  #define dwc2_is_device_connected(hsotg) (hsotg->connected)
>> +#define dwc2_is_device_enabled(hsotg) ((hsotg)->enabled)
> 
> Why the extra ()?  dwc2_is_device_connected does not have it, so this
> one probably should not either, right?

Hi Greg,

I was wondering the same, checkpatch complains without it:

CHECK: Macro argument 'hsotg' may be better as '(hsotg)' to avoid
precedence issues

I can remove the extra () in a v3 if you wish ?

Thanks for reviewing,
Best Regards,
Fabrice

> 
> thanks,
> 
> greg k-h
> 
