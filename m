Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D151542E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380204AbiD2TFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355618AbiD2TFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:05:20 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333F40E5E;
        Fri, 29 Apr 2022 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651258919; x=1682794919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JxXH6qZNpKStuvxqb0XVzzN+BiIbkVYJf0lQRQMSs0s=;
  b=dIkI8vffiQk0ijycrtrzCu08LwSUXgA/oL+Vmwn4A9BCswHE9qPC//Er
   rqYGwuiG89t2MfTuXJxex2pxZD8ASfjq0kfPv4chrHydhO1XTFq0ADvup
   DwIUGrvJYC8SB2YNXFLLPWndj0x970b1jXywF2gzclFFT+1SNh+avvSVI
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2022 12:01:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:01:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 12:01:58 -0700
Received: from [10.110.49.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Apr
 2022 12:01:57 -0700
Message-ID: <d7baf8d8-5643-fb90-8a14-f25a24317516@quicinc.com>
Date:   Fri, 29 Apr 2022 12:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <peter.chen@kernel.org>, <balbi@kernel.org>,
        <stern@rowland.harvard.edu>, <chunfeng.yun@mediatek.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
 <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
 <06d5e94f-1c3b-9ab1-b4ff-79007026585a@linux.intel.com>
From:   Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <06d5e94f-1c3b-9ab1-b4ff-79007026585a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/2022 3:13 AM, Mathias Nyman wrote:
> On 29.4.2022 12.49, Mathias Nyman wrote:
>> On 28.4.2022 22.04, Mayank Rana wrote:
>>> ring_doorbell_for_active_rings() API is being called from
>>> multiple context. This specific API tries to get virt_dev
>>> based endpoint using passed slot_id and ep_index. Some caller
>>> API is having check against slot_id and ep_index using
>>> xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
>>> only check ep_index against -1 value but not upper bound i.e.
>>> EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
>>> based endpoint which checks both slot_id and ep_index to get
>>> valid endpoint.
>> ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
>> and ep_index = fls(u32 value)  - 1 - 1;
>>
>> We can change to use xhci_get_virt_ep(), but this would be more useful
>> earlier in xhci_handle_cmd_config_ep() where we touch the ep before
>> calling ring_doorbell_for_active_rings()
>>
> After a second look I would appreciate if you could clean up
> ep_index checking in xhci_handle_cmd_config_ep()
>
> It currenty does some horrible typecasting.
> ep_index is an unsigned int, so the fls() -1 operation might wrap it around.
> Checking this was solved by typecasting a -1 to an unsigned int.
>
> if (ep_index != (unsigned int) -1)
>
> Thanks
> Mathias

Thanks Mathias for review and suggestion here.
let me try to clean up xhci_handle_cmd_config_ep() API based ep_index 
usage.

