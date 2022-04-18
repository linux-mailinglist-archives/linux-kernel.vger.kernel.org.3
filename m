Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECA505A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344580AbiDRO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbiDRO5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:57:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F3710DB;
        Mon, 18 Apr 2022 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650289544; x=1681825544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H1X3BJlerqrWJy2a4jlLXxCz96pB+HYEXK0sfC2JpLo=;
  b=w1jC6vmk9mtwIuGwBeMMSVZ4AVyE+NPEeIdJMU6RQqTYk+l/SwdQ4hee
   kzhoGTRRO4Y975QCjtbW+VmIZ/71VIr9ZKs6KXLt6IAFrj0gBCqT/cB9G
   i383m4fZr5fATgrYgOrK/g9N0/PvNvW534akU9rIFhZv0Oel8NAl9Z47h
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Apr 2022 06:45:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 06:45:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 06:45:07 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 06:45:06 -0700
Message-ID: <2c776c00-5742-516f-06e3-80db9f572cb4@quicinc.com>
Date:   Mon, 18 Apr 2022 07:45:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bus: mhi: host: Add soc_reset sysfs
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_hemantk@quicinc.com>, <quic_bbhatt@quicinc.com>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649883619-17609-1-git-send-email-quic_jhugo@quicinc.com>
 <20220418054649.GB7431@thinkpad>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220418054649.GB7431@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/2022 11:46 PM, Manivannan Sadhasivam wrote:
> On Wed, Apr 13, 2022 at 03:00:19PM -0600, Jeffrey Hugo wrote:
>> From: Jeffrey Hugo <jhugo@codeaurora.org>
>>
>> The MHI bus supports a standardized hardware reset, which is known as the
>> "SoC Reset".  This reset is similar to the reset sysfs for PCI devices -
>> a hardware mechanism to reset the state back to square one.
>>
>> The MHI SoC Reset is described in the spec as a reset of last resort.  If
>> some unrecoverable error has occurred where other resets have failed, SoC
>> Reset is the "big hammer" that ungracefully resets the device.  This is
>> effectivly the same as yanking the power on the device, and reapplying it.
>> However, depending on the nature of the particular issue, the underlying
>> transport link may remain active and configured.  If the link remains up,
>> the device will flag a MHI system error early in the boot process after
>> the reset is executed, which allows the MHI bus to process a fatal error
>> event, and clean up appropiately.
>>
>> While the SoC Reset is generally intended as a means of recovery when all
>> else has failed, it can be useful in non-error scenarios.  For example,
>> if the device loads firmware from the host filesystem, the device may need
>> to be fully rebooted inorder to pick up the new firmware.  In this
>> scenario, the system administrator may use the soc_reset sysfs to cause
>> the device to pick up the new firmware that the admin placed on the
>> filesystem.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> Do you need double signed-off because of change in domain?
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

That seems to be the convention that I see in the community.  As I 
understand it, the SoB is linked to the Developers Certificate of 
Origin.  This version of the change is coming from 
"quic_jhugo@quicinc.com" and that entity needs to certify they can share 
the code under the Cert of Origin.

In theory, I could have avoided this by sending this version under the 
codeaurora address.  The problem is that the codeaurora domain no longer 
exists, so sending/receiving email from that id is not possible.

If I'm not understanding things correctly, please educate me.
