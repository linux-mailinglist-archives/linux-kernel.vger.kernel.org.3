Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFC4E3B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiCVJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiCVJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:20:13 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89211164;
        Tue, 22 Mar 2022 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647940724; x=1679476724;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Rly8mZJAFHEF+4EMimHKbhSMe6go9DJs07iIKO9zYS8=;
  b=D4cELLvNzg7DUnWmDG1afPqz+myOpjW5fZZEirKWmSxfg7NT447yTy57
   uhznJD2InsO0TSlRwKGlcnD3SXn1PXlENyOXSappnCJgZSs5+Tq5lkq63
   YR1P8d+AVy+/ZZHZdJHGXxiYqpDHLPJweWzbPSU9J+vjR+fIbd6mNzK5y
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Mar 2022 02:18:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 02:18:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 02:18:41 -0700
Received: from [10.216.35.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 22 Mar
 2022 02:18:36 -0700
Subject: Re: [PATCH v11 5/5] usb: dwc3: qcom: Keep power domain on to retain
 controller status
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-6-git-send-email-quic_c_sanm@quicinc.com>
 <20220322083738.GM23316@hu-pkondeti-hyd.qualcomm.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <982fdf9c-58a9-9a67-15e9-ff47b6ff1c93@quicinc.com>
Date:   Tue, 22 Mar 2022 14:48:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20220322083738.GM23316@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 3/22/2022 2:07 PM, Pavan Kondeti wrote:
> Hi Sandeep,
>
> On Tue, Mar 22, 2022 at 12:37:56PM +0530, Sandeep Maheswaram wrote:
>> Keep the power domain on in order to retail controller status and
>> to support wakeup from devices.
>>
> %s/retail/retain
>
> retain the controller status so that remote wakeup / device connect /
> device disconnect events can be detected during suspend.
Will correct in next version.
>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 9804a19..35087cf 100644
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
>>   
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
>> @@ -839,6 +843,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto interconnect_exit;
>>   
>> +	genpd->flags |= GENPD_FLAG_ALWAYS_ON;
>> +
>>   	device_init_wakeup(&pdev->dev, 1);
>>   	qcom->is_suspended = false;
>>   	pm_runtime_set_active(dev);
>> -- 
>> 2.7.4
>>
> Thanks,
> Pavan
