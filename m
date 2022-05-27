Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123753591D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbiE0GMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244558AbiE0GMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:12:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6D3BBF3;
        Thu, 26 May 2022 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653631932; x=1685167932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSpQ+IVhEg6RrjYC+4Uz7ini4oT6bm/9mToI7OZcgp4=;
  b=cTo4FLpR2xekCuNVRdzoz76Za7m/rWPRZCIlyZVXoD7rgBYfZs3cd6wU
   OkBcgVV0R1N/3LWaqDvoCdrRN3c0cBZlHtqbI4Rz78Th8/1hiVLPdgjeC
   du+ooDslBFYVeDvJDlbFIUsbGfyPePoa1QbdoZGP+AMCeczfSHmjaaY4Z
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 May 2022 23:12:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:12:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 23:12:10 -0700
Received: from [10.216.49.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 23:12:03 -0700
Message-ID: <ac791978-aa9e-ff0d-be9c-c12db1c1b8bf@quicinc.com>
Date:   Fri, 27 May 2022 11:42:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v18 2/5] usb: dwc3: core: Host wake up support from system
 suspend
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1653502826-24256-1-git-send-email-quic_kriskura@quicinc.com>
 <1653502826-24256-3-git-send-email-quic_kriskura@quicinc.com>
 <20220526024319.GN15121@hu-pkondeti-hyd.qualcomm.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20220526024319.GN15121@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/2022 8:13 AM, Pavan Kondeti wrote:
> On Wed, May 25, 2022 at 11:50:23PM +0530, Krishna Kurapati wrote:
>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>
>> Check wakeup-source property for dwc3 core node to set the
>> wakeup capability. Drop the device_init_wakeup call from
>> runtime suspend and resume.
>>
>> If the dwc3 is wakeup capable, don't power down the USB PHY(s).
>> The glue drivers are expected to take care of configuring the
>> additional wakeup settings if needed based on the dwc3 wakeup
>> capability status. In some SOC designs, powering off the PHY is
>> resulting in higher leakage, so this patch save power on such boards.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>   drivers/usb/dwc3/core.c | 26 ++++++++++++--------------
>>   1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index e027c04..2b1b3f7 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1787,6 +1787,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, dwc);
>>   	dwc3_cache_hwparams(dwc);
>> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>>   
>>   	spin_lock_init(&dwc->lock);
>>   	mutex_init(&dwc->mutex);
>> @@ -1948,11 +1949,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   		dwc3_core_exit(dwc);
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_HOST:
>> -		if (!PMSG_IS_AUTO(msg)) {
>> -			dwc3_core_exit(dwc);
>> -			break;
>> -		}
>> -
>>   		/* Let controller to suspend HSPHY before PHY driver suspends */
>>   		if (dwc->dis_u2_susphy_quirk ||
>>   		    dwc->dis_enblslpm_quirk) {
>> @@ -1967,6 +1963,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   
>>   		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>>   		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>> +
>> +		if (!PMSG_IS_AUTO(msg)) {
>> +			if (!device_can_wakeup(dwc->dev))
>> +				dwc3_core_exit(dwc);
>> +		}
>>   		break;
> Earlier, the dwc3 which does not support wakeup just calls dwc3_core_exit().
> With this patch we are modifying the behavior. Is that intentional? I expect
> it to be something like
>
> @@ -1761,8 +1782,10 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>                  break;
>          case DWC3_GCTL_PRTCAP_HOST:
>                  if (!PMSG_IS_AUTO(msg)) {
> -                       dwc3_core_exit(dwc);
> -                       break;
> +                       if (!device_can_wakeup(dwc->dev)) {
> +                               dwc3_core_exit(dwc);
> +                               break;
> +                       }
>                  }
>
>                  /* Let controller to suspend HSPHY before PHY driver suspends */
>
> Thanks,
> Pavan

Hi Pavan,

Thanks for pointing out that we are changing behavior. Will try to fix 
it in next series.


Thanks,

Krishna,

