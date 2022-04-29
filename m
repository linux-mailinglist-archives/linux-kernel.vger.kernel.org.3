Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E565146AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357632AbiD2KZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357675AbiD2KZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:25:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04CC6EF6;
        Fri, 29 Apr 2022 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651227716; x=1682763716;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/6I12exRPBCEyl1bLEsXxbJCnt+3LeKMjXIHt4joiSI=;
  b=EI1JGFcWc6eSFp0l9yAxa9atRxnFGAegTsm9xSdD5n3GtcarOsdGqbIV
   uq7T7eb8zsaDhNLs/cZmrDg6q0IZVFa4ft7MzTK5VHpgHcc5iQIEvlaGv
   2kbKmJQ+oZ7jwyHvFqLEqYyVDjgEDf/TZjUaR5jgiA1VRPxUKFhxsVhCr
   KRlIBNAeTW5QPtDQ3LMMOOphWpEy1bNJGcp87SsoKPjJwLJf7Igf/SYG3
   pS/CMr+8QR3uPWFLMJqKACNU2fwuK5idq2FkqW3zCzRBCL6TesAbjlmSa
   Rf3gwN1Fp1IAapHEIrQy6LAwR6e0RXpp6Q1CzqBqTaGpdtWxNqrLaxngm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="327095812"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="327095812"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 03:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="880700876"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 03:21:52 -0700
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mayank Rana <quic_mrana@quicinc.com>, peter.chen@kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu,
        chunfeng.yun@mediatek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
 <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
 <Ymu3mZyNisr0Bzf7@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <364cb857-71f0-b89d-54fb-5acb129451d2@linux.intel.com>
Date:   Fri, 29 Apr 2022 13:23:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ymu3mZyNisr0Bzf7@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.4.2022 13.02, Greg KH wrote:
> On Fri, Apr 29, 2022 at 12:49:59PM +0300, Mathias Nyman wrote:
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
>>
>> ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
>> and ep_index = fls(u32 value)  - 1 - 1; 
>>
>> We can change to use xhci_get_virt_ep(), but this would be more useful
>> earlier in xhci_handle_cmd_config_ep() where we touch the ep before
>> calling ring_doorbell_for_active_rings()
>>
>> Also note that this codepath is only used for some prototype
>> xHC controller that probably never made it to the market about 10 years ago.
> 
> Can we just delete the codepath entirely then?

Probably.
Commit ac9d8fe7c6a8 USB: xhci: Add quirk for Fresco Logic xHCI hardware.
that added this states:

"This patch is for prototype hardware that will be given to other companies
for evaluation purposes only, and should not reach consumer hands.  Fresco
Logic's next chip rev should have this bug fixed."

Should we print some warning instead if this controller is used?
just in case. 
    
Thanks
Mathias

