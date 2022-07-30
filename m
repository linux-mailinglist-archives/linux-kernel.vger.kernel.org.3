Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E8585904
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiG3HzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3HzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:55:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478603DF2D;
        Sat, 30 Jul 2022 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659167700; x=1690703700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Shwt+Sz680BwEw6tvfx5LXYNZ3fuh1Or7vfVOJvxiU=;
  b=DrnOx5CkwaHdq/P887ad3ktO1N/S7xpteCrkYxLbDaXw2QB2t8R6nwL0
   Gy9kXWdLz57asjrqh91+SbDj2woSHS5b/jhQaIZhu8rvJtqf24tV4ZOKT
   bTyIz3Trm5ywbpZzffF1XGj+AM17tRqHgYWU//xs2l/F122LJojWB24Pr
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Jul 2022 00:55:00 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 00:54:59 -0700
Received: from [10.242.58.28] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sat, 30 Jul
 2022 00:54:58 -0700
Message-ID: <d620614b-6c20-d7ed-af19-ca0accb427d6@quicinc.com>
Date:   Sat, 30 Jul 2022 13:24:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH V3] scsi: ufs: Get boot device storage type from command
 line
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <jejb@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <1659034814-3473-1-git-send-email-quic_cchinnad@quicinc.com>
 <77330f3a-5f73-e10f-7e85-f3df304aa4d7@acm.org>
 <f1cf652a-4a36-fe60-5a98-14b9d97c9a41@quicinc.com>
 <d473f4b3-9aba-fe39-d88c-b762d9d779b0@acm.org>
From:   "Chetan Chinnadagudihundi Ravindranath (Consultant) (QUIC)" 
        <quic_cchinnad@quicinc.com>
In-Reply-To: <d473f4b3-9aba-fe39-d88c-b762d9d779b0@acm.org>
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

 > why a change is being made:
There are 2 variants of the android bootdev device. One is EMMC and 
other is UFS. We would be not knowing the android boot storage type at 
build time. So, we need to know the storage type at run time(bootup 
time) by reading the  "androidboot.bootdevice=". We need to distinguish 
between EMMC and UFS at bootup time and take appropriate action.

 > Information about why support is being added for the 
androidboot.bootdevice parameter in the Qualcomm UFS host controller driver:

We will get the "androidboot.bootdevice=" by reading cmdline
case 1: if the boot image header version is 3
         We get the bootdevice info by reading /proc/cmdline ( 
__setup("androidboot.bootdevice=", get_android_boot_dev_v3);

Case 2: if the boot image header version is 4
         We get the bootdevice info by reading /proc/bootconfig 
(android_boot_dev_v4 = xbc_find_value("androidboot.bootdevice", &vnode))

Qualcomm UFS modules(ufs-qcom.c) calls this 
get_storage_boot_device()(ufs-cmdline.c)   and get the bootdevice info 
and take appropriate action. This code is yet to be upstreamed. Please 
let me know if this info convincing.

Thanks,

Chetan

On 7/30/2022 1:36 AM, Bart Van Assche wrote:
> On 7/29/22 05:54, Chetan Chinnadagudihundi Ravindranath (Consultant) 
> (QUIC) wrote:
>> Please suggest any efficient way of making ufs-cmdline part of vmlinux.
>
> A patch description should not only explain what has been changed but 
> also why a change is being made. Information about why support is 
> being added for the androidboot.bootdevice parameter in the Qualcomm 
> UFS host controller driver is missing from the patch description.
>
> Please also address Christoph's comment about this new command-line 
> parameter not being used anywhere in the upstream kernel tree.
>
> Thanks,
>
> Bart.
