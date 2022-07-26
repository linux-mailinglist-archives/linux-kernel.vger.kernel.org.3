Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50AE581A61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiGZTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGZTlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:41:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753AF18E04;
        Tue, 26 Jul 2022 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658864477; x=1690400477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QM1qI4jvZ4MmCTihomGrSnf3ybTgIby/ouZeQYS93l0=;
  b=Vb2Q1qJtZBpdqGCdCR4zJSg6LBDYNKhmX/tXkVljKpyMwAtVmeqaaZGQ
   aZXZMUSxL/F7NYJYG1qDBRNK2rjAqTDM70ofzV1uwH9GoruqYRZeP6+bn
   y76Do58ITwqZdB77c7KrmTjnL3C9G800/kJ2u8iekzoEVXDKsQ3XKV6lX
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jul 2022 12:41:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 12:41:17 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 12:41:16 -0700
Received: from [10.110.103.19] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 12:41:16 -0700
Message-ID: <b9e2474a-4323-daa4-a421-1d897726f7f9@quicinc.com>
Date:   Tue, 26 Jul 2022 12:41:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid duplicate requests to enable
 Run/Stop
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_mrana@quicinc.com>, <Thinh.Nguyen@synopsys.com>
References: <20220725201136.7989-1-quic_wcheng@quicinc.com>
 <YuALjN8o/XNS7RE2@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <YuALjN8o/XNS7RE2@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 7/26/2022 8:43 AM, Greg KH wrote:
> On Mon, Jul 25, 2022 at 01:11:36PM -0700, Wesley Cheng wrote:
>> Relocate the pullups_connected check until after it is ensured that there
>> are no runtime PM transitions.  If another context triggered the DWC3
>> core's runtime resume, it may have already enabled the Run/Stop.  Do not
>> re-run the entire pullup sequence again, as it may issue a core soft
>> reset while Run/Stop is already set.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> What commit does this fix?
> 
> How far back should it go to stable kernels?
> 
Let met add a fixes tag and resubmit.  Thanks!

Thanks
Wesley Cheng
