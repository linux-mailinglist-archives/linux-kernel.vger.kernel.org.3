Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF5583A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiG1If1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiG1IfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:35:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A402AC4D;
        Thu, 28 Jul 2022 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658997324; x=1690533324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mX7tx2ptiK9+LjYYpztHVJd2LwqnLvya+VDbnMoCesA=;
  b=c6rm6T0dRMloTMEyHoQFwz5whepbX29LwFsNQYSVSNhihFlBt0xqDtgz
   ToMOheiFveyyc2klmDFYZZ93Wf6WShdB9x1cskl3m3MJFJ6ml6S/HwFhO
   93zhK01Ump3/bD3WE9CMSzZaD2vuKPFsD60zhv8Hn5OL6P7PrpCdL7QHY
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jul 2022 01:35:24 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 01:35:23 -0700
Received: from [10.242.58.28] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 01:35:22 -0700
Message-ID: <c66ffd91-8649-edb7-86dc-422ae82e1b84@quicinc.com>
Date:   Thu, 28 Jul 2022 14:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH V1] scsi: ufs: Get boot device storage type from command
 line
To:     Bart Van Assche <bvanassche@acm.org>, <jejb@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
References: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
 <a09de6e0-700b-0715-06a8-150ab41e8e7f@acm.org>
Content-Language: en-US
From:   "Chetan Chinnadagudihundi Ravindranath (Consultant) (QUIC)" 
        <quic_cchinnad@quicinc.com>
In-Reply-To: <a09de6e0-700b-0715-06a8-150ab41e8e7f@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brat,

Thanks for you response!

Yes, since SCSI_UFSHCD=y am selecting UFS_QCOM_CMDLINE=y so that it gets 
__setup() declarations. I am able to read the command line arguments and 
get this "androidboot.bootdevice=" info. I had cross checked again.

Thanks,
Chetan C R

On 7/27/2022 11:16 PM, Bart Van Assche wrote:
> On 7/27/22 01:28, Chetan C R wrote:
>> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
>> index 90226f7..9d2f84e 100644
>> --- a/drivers/ufs/Kconfig
>> +++ b/drivers/ufs/Kconfig
>> @@ -9,6 +9,7 @@ menuconfig SCSI_UFSHCD
>>       select PM_DEVFREQ
>>       select DEVFREQ_GOV_SIMPLE_ONDEMAND
>>       select NLS
>> +    select UFS_QCOM_CMDLINE if ARCH_QCOM
>>       help
>>         Enables support for UFS (Universal Flash Storage) host 
>> controllers.
>>         A UFS host controller is an electronic component that is able to
>
> [ ... ]
>
>> +__setup("androidboot.bootdevice=", get_android_boot_dev_v3);
>
> How can this work since __setup() declarations should occur in the 
> core kernel and since the ufshcd driver can be built as a kernel module?
>
> Thanks,
>
> Bart.
