Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27004BAA96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbiBQUFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiBQUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:05:53 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B354F8F;
        Thu, 17 Feb 2022 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645128338; x=1676664338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gRwYcgDf0FkAgVyCC1jtCDQ895GxuL/QpmPf+mg7MhE=;
  b=xNLwIigiuzvRHJr3rGoddDII4m/TIoEai+EMB0AVK0bLB076GA5rNEku
   n3LwP5zNxFgEaiUv8Rrh44QXbG/hxHJcAtFHwDox6sYvjb9smDCmNAcsp
   Ja8szTkROBhCL1WrOMw5f18J1skmBlVGUuM7Zjdyj+kZkOgxB4iSCEx7p
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Feb 2022 12:05:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 12:05:38 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 12:05:37 -0800
Received: from [10.110.4.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 17 Feb
 2022 12:05:37 -0800
Message-ID: <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
Date:   Thu, 17 Feb 2022 12:05:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jung Daehwan <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/15/2022 9:14 AM, Thinh Nguyen wrote:
> Jung Daehwan wrote:
>> Hi Thinh,
>>
>> On Mon, Feb 14, 2022 at 06:44:33PM +0000, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> Daehwan Jung wrote:
>>>> It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
>>>> even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
>>>
>>> How does it fail? Timed out?
>>
>> Yes, timed out.
>>>
>>>> skipping clear stall commmand or giveback from dequeue. We fix to set it
>>>> only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
>>>> for next trb to start transfer not update transfer.
>>>
>>> We shouldn't do this. Things will be out of sync. It may work for 1
>>> scenario, but it won't work for others.
>>>
>>> Please help me understand a few things:
>>>
>>> 1) What is the scenario that triggers this? Is it random?
>>>
>> ep cmd timeout occurs on dequeue request from user side. End Transfer command
>> would be sent in dwc3_stop_active transfer.
> 
> At the high level, what's triggering the request dequeue? Is it from a
> disconnect, change of interface, or simply function driver protocol that
> changes it.
> 
> What application was used to trigger this?
> 
Sorry for jumping in here, but looks like Daehwan is running into a
similar issue I am seeing as well.

At least in my scenario, the dequeue is coming from a function driver
which exposes a device to userspace.  Once that device is closed, it
will issue a dequeue on all pending/submitted requests.

>>
>>> 2) Are there other traffics pending while issuing the End Transfer
>>> command? If so, what transfer type(s)?
>>>
>> I haven't checked it yet. 
> 
> Can you check?
> 
For the cases where we've collected a crash log, we can see that during
the END transfer timeouts there was always a pending EP0 transaction.
We had reached out to our internal HW folks to get some inputs on what
could be causing this kind of issue, and we were able to get some
recommendations from their Synopsis POCs.

It was mentioned that if there was an active EP0 transfer, an end
transfer command on a non-control EP can fail w/ timed out.

>>
>>> 3) Have you tried increasing the timeout?
>>>
>> No, I haven't.
> 
> Can you try up to 10 seconds (just for experiment)
> 
I've tried this too, and it did not help.

>>> BR,
>>> Thinh
>>>
>>
>> This issue occurs very rarely on customer. I only have restricted
>> information. That's why I've been trying to reproduce it.
> 
> How did you test your fix if you can't reproduce it?
> 
>>
>> Wesley may have run into same issue and you can see this issue in detail.
>> https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d&q=1&e=20b4d9f5-2599-4f57-8b6a-7c4ec167d228&u=https*3A*2F*2Flore.kernel.org*2Flinux-usb*2F20220203080017.27339-1-quic_wcheng*40quicinc.com*2F__;JSUlJSUlJQ!!A4F2R9G_pg!JWPzNLoO3BFX_IZCVzmHPtxq6frr_VFbSNNaxSQylunt1Y4EauTOefth2LCIcVEuTx8E$ 
>>
> 
> I can take a look, but please provide the tracepoints of the failure if
> you can reproduce it.
> 
Let me see if I have any previous traces I can share.  If not, I have a
pretty reliable repro set up I can collect a trace for you.  For now, I
will focus on just getting the endxfer timeout seen during ep dequeue.
As mentioned on my patchset, this can happen during device-initiated
disconnect as well.

Thanks
Wesley Cheng

