Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C051D9AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441932AbiEFOAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiEFOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:00:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195765DA60;
        Fri,  6 May 2022 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651845401; x=1683381401;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=M7oWMgWlnUdtMWPOQBtCnCYF2RFN1Z8I0Purc4HX6gs=;
  b=GubD3nN0JxlEfNmHKXx/AomqKR8g3Wsaw406YMZLrVIfFvdZ+LMjU5BD
   mOKG58glfmjazGveU47LhlgrQ2i0LjdPqWYUxy2+FQKTT+Po8fj9hwZRV
   QVMQn8FvQiRUB98a5zF2r2ut6Qe6aCz8JdNqChfyNB+JqsjJwF1+v9joP
   qx641YUEFz9n+05Arkd8Obw4WZ4bbzitHJmLfd1XWo2obvnPK2EEpzfhA
   0OjFcFVDfhfGZdt/BJs962vA3gvuKf1bDtnV7fALUiAfAjaYyffJoCzCc
   87qJ8cQJUWlAbUVebn/XMa9H0B9W/GUcc0wZpsstp1kQL7pOOcZpsXWPE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="250472409"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250472409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 06:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="891845574"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2022 06:56:38 -0700
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
To:     Mayank Rana <quic_mrana@quicinc.com>, peter.chen@kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
 <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
 <06d5e94f-1c3b-9ab1-b4ff-79007026585a@linux.intel.com>
 <d7baf8d8-5643-fb90-8a14-f25a24317516@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <8e186a1d-23f9-dec8-234e-9599b65a65c2@linux.intel.com>
Date:   Fri, 6 May 2022 16:58:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d7baf8d8-5643-fb90-8a14-f25a24317516@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.4.2022 22.01, Mayank Rana wrote:
> On 4/29/2022 3:13 AM, Mathias Nyman wrote:
>> On 29.4.2022 12.49, Mathias Nyman wrote:
>>> On 28.4.2022 22.04, Mayank Rana wrote:
>>>> ring_doorbell_for_active_rings() API is being called from
>>>> multiple context. This specific API tries to get virt_dev
>>>> based endpoint using passed slot_id and ep_index. Some caller
>>>> API is having check against slot_id and ep_index using
>>>> xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
>>>> only check ep_index against -1 value but not upper bound i.e.
>>>> EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
>>>> based endpoint which checks both slot_id and ep_index to get
>>>> valid endpoint.
>>> ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
>>> and ep_index = fls(u32 value)  - 1 - 1;
>>>
>>> We can change to use xhci_get_virt_ep(), but this would be more useful
>>> earlier in xhci_handle_cmd_config_ep() where we touch the ep before
>>> calling ring_doorbell_for_active_rings()
>>>
>> After a second look I would appreciate if you could clean up
>> ep_index checking in xhci_handle_cmd_config_ep()
>>
>> It currenty does some horrible typecasting.
>> ep_index is an unsigned int, so the fls() -1 operation might wrap it around.
>> Checking this was solved by typecasting a -1 to an unsigned int.
>>
>> if (ep_index != (unsigned int) -1)
>>
>> Thanks
>> Mathias
> 
> Thanks Mathias for review and suggestion here.
> let me try to clean up xhci_handle_cmd_config_ep() API based ep_index usage.
> 

Please don't spend too much time on this,
I'm going to remove this code as Greg suggested.

Should have replied earlier, sorry about the delay

Thanks
-Mathias 
 
