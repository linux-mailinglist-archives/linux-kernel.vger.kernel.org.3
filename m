Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C74DAFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355860AbiCPMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346786AbiCPMo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:44:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE32D1CA;
        Wed, 16 Mar 2022 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647434625; x=1678970625;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jhBBYw4CP4Lcvzt3g4Q7+TNz8lbElcc2WGmCX6PEuRY=;
  b=MAGNOD2Eo8I88gUe/k1QPTTVciWPIijxPUT6+XgHRmNFGv5KSGaP5+7X
   vrorsK14CZFaDNQBoUmzHGCB2c9FuVdEGO4xg1l0ejTZnYx0I0JuOwsj4
   1t9n03USWHw+p1lmhWAMHh+M8VG/ZSXu7MfFiQCEoeJxTmEIUHvNcWclm
   VK04pSYTub1F6tL8nZuGy8qQDA0gxjLfE2mBL02tsOdqizoX2kajCCjvY
   lcQ84mIyxMmrqfQWCJnOIBLOy9QKqLNtKSQQFt7fR6RRysIeoAiusMSid
   /XG6Q1G1o7ddIYhwLpqQm6d44Avf9vq24xFHTUuH1IQQKV3TTaGBNTvQQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256298221"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256298221"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646631800"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 05:43:41 -0700
To:     Peter Chen <hzpeterchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        mathias.nyman@intel.com, Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
 <Yi7xJy70XZCA8RyN@kroah.com>
 <CAL411-o_2PSndEVXfa+ciLukSr5u5w8G9T63d2MpSm2Fpn5QTQ@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
Message-ID: <d95ca5f6-221b-1a22-abbe-10621e2fb219@linux.intel.com>
Date:   Wed, 16 Mar 2022 14:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL411-o_2PSndEVXfa+ciLukSr5u5w8G9T63d2MpSm2Fpn5QTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.3.2022 13.57, Peter Chen wrote:
> On Mon, Mar 14, 2022 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Mar 14, 2022 at 03:25:23PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>>> On some situations, software handles TRB events slower than adding TRBs,
>>> xhci_irq will not exit until all events are handled. If xhci_irq just
>>> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records
>>> in xhci irq is equal to driver current dequeue pointer. It will cause driver
>>> not update ERDP and software dequeue pointer lost sync with ERDP. On the
>>> next xhci_irq, the event ring is full but driver will not update ERDP as
>>> software dequeue pointer is equal to ERDP.
> 
> At the current driver, the ERDP is updated at most 128 TRBs, how is
> the above condition
> triggered?
> 
> Peter
> 

Before, and during _one_ interrupt handling xHC hardware writes exactly 256 events
to event ring. ring buffer size is 256 so buffer position 0 and 256 point
to the same place.

Interrupt handler stores software dequeue in a local variable "event_ring_deq".
Handler start handling events, it updates software dequeue, but not local variable.
After 128 events handler updates hardware ERDP.

So at event 128 we got:
Hardware ERDP = 128
software dequeue = 128
event_ring_deq = 0

Handler continue handling events, at event 256 try to update HW ERDP again, but fail due
to this condition in update_erst_dequeue():
      if (event_ring_deq != xhci->event_ring->dequeue)

This fails because event_ring_deq is still 0, and software deq is 256,
pointing to the same place in the event ring.

So at the end of the interrupt handler we have:
HW ERDP = 128
software dequeue = 256 (same as 0)

So in this specific case we fail to update ERDP correctly

-Mathias
