Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB448F076
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiANT3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:29:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:63106 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232351AbiANT3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642188593; x=1673724593;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XOj6k0Xo4PFVlZlfpTezZimtakW+VvnjEotmeHkYF34=;
  b=eByvmOD7dtOhjTfn3nwH4WQ6IOsLjKo8K8r4N9TOEEDpLmxe0indOW9Q
   Ay+1enGrS9fNSAA1Car6Ra/4U1Fzhoix0GZmQz2jeupEcdbybFO2rQ5tU
   p+HXg8LDorXdNOt66VBriiU8WZaipRPSXNyZx0R/QNty+jzfof8tzEpbI
   zi/hxDSQA7iZrctJX1ZzOYem5Op77R92rn36q86UobjIfxbP7k3eotCwN
   tIX0jVzn60oJmZ0dDuolUz+tEoqRZL8rFBDl/15X/9q2kq6LzkPR3oEHC
   e0VvwCa75YhBpi4IIIvH+wejpP0lFj2RrbZIr+uROQoEaNd0/8wYAFx3+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305044543"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="305044543"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 11:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="624454211"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 11:29:50 -0800
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
Date:   Fri, 14 Jan 2022 21:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.1.2022 10.47, Peter Zijlstra wrote:
> On Tue, Dec 21, 2021 at 10:40:50AM +0100, Peter Zijlstra wrote:
>> On Fri, Dec 17, 2021 at 02:55:07PM +0100, Peter Zijlstra wrote:
>>> On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
>>>> I can reproduce this.
>>>> Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
>>>>
>>>> 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
>>>
>>> I can confirm, reverting that solves the boot hang, things aren't quite
>>> working for me though.
>>
>> I've been poking at this a little, find debug patch and full dmesg
>> below. The TL;DR version of the dmesg seems to be:
>>
>> [    4.984148] xhci_dbc:xdbc_start: waiting for connection timed out
>> [    4.984149] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
>>
>> Initially I thought this was due to delay not being set up properly, but
>> I 'fixed' that, and I've ran out of ideas. I really don't know anything
>> about USB :/
> 
> Any thoughts on this? I'd really like to be able to use this machine but
> can't due to lack of console.
> 

Tried to reproduce this with another cable that should have all pins connected,
but it still workes for me.

It looks like the connection is not even detected in your case.

What does the host say? If the cable is connected before CTRL_DBC_ENABLED bit is
written on the target side, then the link should go to a inactive "error" state.
Host should try to recover the inactive link with a warm reset.

On host side dynamic debug for usb core and xhci can be added with:

echo -n 'module xhci_hcd =p' > /sys/kernel/debug/dynamic_debug/control
echo -n 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control

xHCI documentation also states that Debug capability enable bit (CTRL_DBC_ENABLE)
could be toggled to retry failed enumeration. 

The non-early dbc that works for you does clear the control register before enabling
the debug capability, and it also skips port reset.
Something like the below could be worth trying out:

8<---

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 4502108069cd..8969c88e8c24 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -419,7 +419,9 @@ static int xdbc_start(void)
 {
        u32 ctrl, status;
        int ret;
+       bool first_try = true;
 
+retry:
        ctrl = readl(&xdbc.xdbc_reg->control);
        writel(ctrl | CTRL_DBC_ENABLE | CTRL_PORT_ENABLE, &xdbc.xdbc_reg->control);
        ret = handshake(&xdbc.xdbc_reg->control, CTRL_DBC_ENABLE, CTRL_DBC_ENABLE, 100000, 100);
@@ -429,13 +431,21 @@ static int xdbc_start(void)
        }
 
        /* Reset port to avoid bus hang: */
-       if (xdbc.vendor == PCI_VENDOR_ID_INTEL)
+       if (xdbc.vendor == PCI_VENDOR_ID_INTEL && first_try)
                xdbc_reset_debug_port();
 
        /* Wait for port connection: */
        ret = handshake(&xdbc.xdbc_reg->portsc, PORTSC_CONN_STATUS, PORTSC_CONN_STATUS, 5000000, 100);
        if (ret) {
-               xdbc_trace("waiting for connection timed out\n");
+               xdbc_trace("waiting for connection timed out, DCPORTSC:0x%x\n",
+                          readl(&xdbc.xdbc_reg->portsc));
+               if (first_try) {
+                       first_try = false;
+                       /* Toggle DCE and retry without port reset */
+                       writel(0, &xdbc.xdbc_reg->control);
+                       handshake(&xdbc.xdbc_reg->control, CTRL_DBC_ENABLE, 0, 100000, 10);
+                       goto retry;
+               }
                return ret;
        }
