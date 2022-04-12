Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EC64FCE46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbiDLEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiDLEwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:52:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1015A11;
        Mon, 11 Apr 2022 21:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649739034; x=1681275034;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cvvlGJHIgqc3+fbL7qQdlg2PazmrkEqWAevnY47vQx4=;
  b=nkUp0sevtXktbqjwyDC/3hjZ4DggT4Jqj53vSULScSu7IapGDGV5pfga
   xk6hhGcWYhDEOpuoFG+PpZHcR52DhMI5syot+AOQAROjoFowihvDwQ4se
   ySM+EF1Cl8g+OTTp4sFPPWwBfeMo8jAYslmWS9+2DJiu+vL4uJRrbK565
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Apr 2022 21:50:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 21:50:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 21:50:33 -0700
Received: from [10.216.54.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 21:50:27 -0700
Subject: Re: [PATCH v13 5/6] usb: dwc3: qcom: Keep power domain on to retain
 controller status
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-6-git-send-email-quic_c_sanm@quicinc.com>
 <YlSZ8uk8MjygY7uf@google.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <8ab040bb-0328-1f7a-cf1b-7497fe4b69a0@quicinc.com>
Date:   Tue, 12 Apr 2022 10:20:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <YlSZ8uk8MjygY7uf@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/12/2022 2:43 AM, Matthias Kaehlcke wrote:
> On Tue, Apr 12, 2022 at 12:46:53AM +0530, Sandeep Maheswaram wrote:
>> Keep the power domain always on during runtime suspend or if the
>> controller supports wakeup in order to retain controller status
>> and to support wakeup from devices.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 9804a19..9747be6 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/phy.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/usb/of.h>
>>   #include <linux/reset.h>
>>   #include <linux/iopoll.h>
>> @@ -724,6 +725,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	struct resource		*res, *parent_res = NULL;
>>   	int			ret, i;
>>   	bool			ignore_pipe_clk;
>> +	struct generic_pm_domain *genpd;
> nit: I'm not really a fan of gazillions of whitespaces between the type
> and the variable name, but if they are kept all variable names above
> should move a tab to the right. In any case the style in this file isn't
> consistent, so an alternative would be to just get rid of the alignment
> completely.
Okay. Will do it in next version.
>
>>   	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>>   	if (!qcom)
>> @@ -732,6 +734,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, qcom);
>>   	qcom->dev = &pdev->dev;
>>   
>> +	genpd = pd_to_genpd(qcom->dev->pm_domain);
>> +
>>   	if (has_acpi_companion(dev)) {
>>   		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>>   		if (!qcom->acpi_pdata) {
>> @@ -839,7 +843,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto interconnect_exit;
>>   
>> -	device_init_wakeup(&pdev->dev, 1);
>> +	genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>> +
>> +	if (device_may_wakeup(&qcom->dwc3->dev))
>> +		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> In v12 only GENPD_FLAG_ALWAYS_ON was set, not GENPD_FLAG_RPM_ALWAYS_ON.
> I asked a few times for a change log, in this instance it would be
> useful to explain why GENPD_FLAG_RPM_ALWAYS_ON is now set.
Okay. Will add it in next version.
>
>> +
>> +	device_init_wakeup(&pdev->dev, device_may_wakeup(&qcom->dwc3->dev));
> device_may_wakeup() isn't an expensive operation, but it's still not nice to
> call it twice in three lines of code. Instead you could do this:
>
> 	if (device_may_wakeup(&qcom->dwc3->dev)) {
> 		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> 		device_init_wakeup(&pdev->dev, true);
> 	}
Okay. Will do it in next version.
