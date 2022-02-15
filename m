Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856134B67DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiBOJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:41:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiBOJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:41:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA4E373D;
        Tue, 15 Feb 2022 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644918069; x=1676454069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7jFBmRsokxLTHy5wctRuheDhtuL9EHujzt5OiFap7wI=;
  b=AoBbRyQHq/hanCOHcD7oX/W0hHSoGVtrkJDhZhk5ARbG4buV0jzFK7t5
   6YFEKIOy6/JmDwMsKfBkqfpSTJdC+5rLDK+W4HmQ6LV5lHm0SzPiJzHLe
   eDubsxmahsA9IbLcIGIa9lDPdsY5MTYIqSX1ZzLal6X3CvuFKjP3aDPrD
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 01:41:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 01:41:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 01:41:07 -0800
Received: from [10.216.25.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 01:41:02 -0800
Message-ID: <0e006cc0-2760-195a-35b9-0a2f6e8452c5@quicinc.com>
Date:   Tue, 15 Feb 2022 15:10:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <20220118095255.GB11385@hu-pkondeti-hyd.qualcomm.com>
 <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
 <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
 <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
In-Reply-To: <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Steev,

On 1/28/2022 2:06 PM, Steev Klimaszewski wrote:
> Hi Sandeep,
>
> On 1/25/22 3:17 AM, Sandeep Maheswaram wrote:
>> Hi Steev,
>>
>>> I didn't face any such issue with devices connected.
>>>
>>> I think this is because I used IRQ_TYPE_EDGE_BOTH in device tree and 
>>> Steev has IRQ_TYPE_LEVEL_HIGH in his device tree.
>>>
>>> When i changed to IRQ_TYPE_LEVEL_HIGH I also observed a storm of 
>>> interrupts in my device though it booted .
>>>
>>> Regards
>>>
>>> Sandeep
>>>
>> Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if 
>> you are getting the issue.
>>
>> Regards
>>
>> Sandeep
>>
> I just tested here, changing both of the IRQ_TYPE_LEVEL_HIGH in the 
> yoga's dts to EDGE_BOTH and I still do not get a booting system.
>
> -- Steev
>
Please let us know what devices are connected to your setup and share 
the device tree file you are using.

Please share the failure logs also,

Regards

Sandeep

