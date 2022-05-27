Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E35363A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352878AbiE0N7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiE0N7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:59:15 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C7167CD;
        Fri, 27 May 2022 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653659954; x=1685195954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1aS94pv7M+2mpNrbIuhOKOs56VtcAuqv2W2MQSEudGw=;
  b=GmOpTbUzPz+oBh7f4j0b+BN0i735TPOn7DlHonLgtuVbf7nL4WtMTpgR
   Nd+KPi2+lkg9eGNopM01ntifyGFq78kiPCJperPiq7rNzaRMxqGFoZUKq
   GMlAcsAleCkVEcbzYF9xDYiReA00qZqmtC/K6Ytnx/kMxk+WVhXQnOAhF
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 May 2022 06:59:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 06:59:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 06:59:12 -0700
Received: from [10.216.26.43] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 06:59:06 -0700
Message-ID: <0ebf352c-1613-aea5-16d9-40ba57d7765f@quicinc.com>
Date:   Fri, 27 May 2022 19:29:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V7 0/4] mmc: add error statistics for eMMC and SD card
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <p.zabel@pengutronix.de>, <chris@printf.net>,
        <venkatg@codeaurora.org>, <gdjakov@mm-sol.com>,
        <quic_asutoshd@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>
References: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <3c56166a-772a-4fbc-8e3a-5ec669fd8b5d@intel.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <3c56166a-772a-4fbc-8e3a-5ec669fd8b5d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 5/27/2022 3:15 PM, Adrian Hunter wrote:
> On 25/05/22 15:28, Shaik Sajida Bhanu wrote:
>> Changes since V6:
>> 	- Rebased on Ulf's(Ulf Hansson) next branch as suggested by
>> 	  Adrain Hunter.
> I think maybe you re-based on the "master" branch not the "next" branch, please check
Sure got it Thank you.. will re-base on next branch and post
>
>> 	- Replaced debugfs_create_file() with debugfs_create_file_unsafe()
>> 	  as suggested by Adrain Hunter.
>> 	- "[V6,5/5] mmc: cqhci: Capture eMMC and SD card errors" not included
>> 	  in this Patch series as we don't have cqhci changes on Ulf's(Ulf Hansson)
>> 	  next branch.
> cqhci is in the "next" branch, please check
Sure Thank you
>
>> Changes since V5:
>> 	- Considered all error stats enums to set error state.
>> 	- Added missed tuning error related code changes which was
>> 	  missed in patch set V5 as Adrain Hunter pointed.
>> 	- Replaced DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
>> 	  as suggested by Adrain Hunter.
>> 	
>> Changes since V4:
>> 	- Defined new macro to increment err_stats members when error occurred
>> 	  as suggested by Adrain Hunter.
>> 	- Called err_stats members increment function after printing the error
>> 	  as suggested by Adrain Hunter.
>> 	- Considered INDEX and END_BIT errors same as CRC errors as suggested
>> 	  by Adrain Hunter.
>> 	- Removed Null check for host in debug fs functions and Reordered
>> 	  err_stats declarationas suggested by Adrain Hunter.
>> 	- Removed err_state variable stuff and updated err_state debug fs entry
>> 	  based on the err_stats members state as suggested by Adrain Hunter.
>>
>> Changes since V3:
>> 	- Dropped error stats feature flag as suggested by Adrain Hunter.
>> 	- Separated error state related changes in separate patches as
>> 	  suggested by Adrain Hunter.
>> 	  [PATCH V4 4/7] : error state debug fs
>> 	  [PATCH V4 5/7] : error state enable function
>> 	  [PATCH V4 6/7] : error state enable in error case
>> 	- Note: we are enabling error state before calling sdhci_dumpregs
>> 	  we couldn't add the err state in error stats array as err state
>> 	  is not error type.
>> 	- Corrected Signed-off-by order as suggested by Bjron Andersson.
>> 	- Moved error state enable code from sdhci_dumpregs to error
>> 	  conditions as suggested by Adrain Hunter
>>
>> Changes since V2:
>> 	- Removed userspace error stats clear debug fs entry as suggested
>> 	  by Adrain Hunter.
>> 	- Split patch into 4 patches
>> 	  [PATCH V3 1/4] : sdhci driver
>> 	  [PATCH V3 2/4] : debug fs entries
>> 	  [PATCH V3 3/4] : core driver
>> 	  [PATCH V3 4/4] : cqhci driver
>> 	- Used for loop to print error messages instead of using printf
>> 	  statements for all error messages as suggested by Adrain Hunter.
>> 	- Introduced one flag to enable error stats feature, if any other
>> 	  client wants to use this feature, they need to enable that flag.
>> 	- Moved reset command timeout error statement to card init flow
>> 	  as suggested by Adrain Hunter.
>>
>> Changes since V1:
>> 	- Removed sysfs entry for eMMC and SD card error statistics and added
>> 	  debugfs entry as suggested by Adrian Hunter and Ulf Hansson.
>>
>> Shaik Sajida Bhanu (4):
>>    mmc: core: Capture eMMC and SD card errors
>>    mmc: sdhci: Capture eMMC and SD card errors
>>    mmc: debugfs: Add debug fs entry for mmc driver
>>    mmc: debugfs: Add debug fs error state entry for mmc driver
>>
>>   drivers/mmc/core/core.c    | 11 +++++--
>>   drivers/mmc/core/debugfs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/mmc/host/sdhci.c   | 33 +++++++++++++++----
>>   drivers/mmc/host/sdhci.h   |  3 ++
>>   include/linux/mmc/host.h   | 26 +++++++++++++++
>>   include/linux/mmc/mmc.h    |  6 ++++
>>   6 files changed, 151 insertions(+), 9 deletions(-)
>>
