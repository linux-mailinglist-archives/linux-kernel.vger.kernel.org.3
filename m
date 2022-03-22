Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C821B4E3AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiCVIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiCVIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:43:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FD13CF6;
        Tue, 22 Mar 2022 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647938551; x=1679474551;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=S4jlkx7h0dIsw5N/ts81viS5QONVadlkeQXydpcCgk8=;
  b=M+YwWCFt68LOgkE5B8EkvL4g+3E/q2gc+kAForGCwXJhsQoO4IFs9WRu
   9BzZSmd5NKjVwsTDoGLnsFc2dFn63r+22PSQ+MY8xnNyQLEWebNcvVTXv
   ObsTzVJtQ+dTkOxGw8Xd6bG/6rwRZfErpQGYC3QcWUmLfk24mVOpxvqWV
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 01:42:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:42:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:42:30 -0700
Received: from [10.216.35.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 22 Mar
 2022 01:42:26 -0700
Subject: Re: [PATCH v11 1/5] usb: dwc3: core: Add HS phy mode variable and phy
 poweroff flag
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-2-git-send-email-quic_c_sanm@quicinc.com>
 <20220322080937.GI23316@hu-pkondeti-hyd.qualcomm.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <9c0d15d5-c5d1-7233-60e3-de36fa9eb287@quicinc.com>
Date:   Tue, 22 Mar 2022 14:12:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20220322080937.GI23316@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On 3/22/2022 1:39 PM, Pavan Kondeti wrote:
> Hi Sandeep,
>
> On Tue, Mar 22, 2022 at 12:37:52PM +0530, Sandeep Maheswaram wrote:
>> Add variables in dwc3 structure to check HS phy mode which is
>> used to configure interrupts and phy poweroff flag to check
>> the phy status during system resume.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 5c9d467..f11a60c 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1154,6 +1154,9 @@ struct dwc3 {
>>   
>>   	bool			phys_ready;
>>   
>> +	unsigned int            hs_phy_mode;
>> +	bool			phy_power_off;
>> +
>>   	struct ulpi		*ulpi;
>>   	bool			ulpi_ready;
>>   
> Why adding members in a separate patch? This needs to be squashed with
> 2/5 patch in the series where these members are used in taking host
> mode PM decisions. Please fix this.
>
> Thanks,
> Pavan

Sure . Will do in next version.

Regards

Sandeep

