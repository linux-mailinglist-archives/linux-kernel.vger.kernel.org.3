Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313B749AEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453657AbiAYIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:55:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:11130 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453029AbiAYIvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643100701; x=1674636701;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=M2IjP5NhFFTYV177dnTaULkwxfpoBSIPm3gj+/hKLuw=;
  b=eRWsJJ/02jzu1BxDXqtOOMmCjUcyBaDOY1PWqMgVQjx++xqVG5o0T8cJ
   7h5/V/8D04vUA9db0Womc8TXjpR/Q35JSL8goYI9OlUFpB5CMPMgphX4V
   64DL/HJVxeuyDygH+z1EIFyuzQ4GkJfo9K4d1talueJzaMXOAGY93k0to
   75hLSVH8bC1Fg1lN23JQlO/PaQDxGLT9JkJt1FlZTPbkbIg01SjUVxPpD
   6Bks7adlUOFo5wymHoEAsvUQVxamhRa1V4JowgD9LxlzsdQPOY/JE56fG
   eTWvezL13nuQ83IjMpkQzPe9rQ34VE3MautxbUp/TAIa43cRJnMHzjHVJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="306972288"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="306972288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 00:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="562969177"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 00:49:30 -0800
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye7WLM+NyVQlEMXN@hirez.programming.kicks-ass.net>
 <Ye7X5I4lm8gtRaBv@hirez.programming.kicks-ass.net>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <6e2700c4-07dd-76ac-cd8f-d9e5b9b24e74@linux.intel.com>
Date:   Tue, 25 Jan 2022 10:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye7X5I4lm8gtRaBv@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.1.2022 18.46, Peter Zijlstra wrote:
> On Mon, Jan 24, 2022 at 05:39:08PM +0100, Peter Zijlstra wrote:
>> On Mon, Jan 24, 2022 at 04:55:22PM +0200, Mathias Nyman wrote:
>>>  
>>>> [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
>>>> [    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
>>>> [    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
>>>> [    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
>>>>
>>>> [   12.818364] xhci_hcd 0000:00:0d.0: xHCI Host Controller
>>>> [   12.818373] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
>>>> [   12.820360] xhci_hcd 0000:00:0d.0: xHCI Host Controller
>>>> [   12.820363] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
>>>> [   12.821036] xhci_hcd 0000:00:14.0: xHCI Host Controller
>>>> [   12.821040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
>>>> [   12.823451] xhci_hcd 0000:00:14.0: xHCI Host Controller
>>>> [   12.823453] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
>>>> [   17.115089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
>>>> [   17.115163] usb usb4-port4: config error
>>>
>>> Ok, I see it now.
>>> Your setup has two xhci controllers, earlypringk=dbc enables dbc on the first xhci
>>> it finds, which would be at 0000:00:0d.0.
>>> Your cable is connected to the second xhci host at 0000:00:14.0
>>>
>>> does using "earlyprintk=xdbc1" work?
>>
>> Very quick testing says it don't work.. but I'll try again later, need
>> to go cook dinner now.
> 
> FYI, I'm thinking early_xdbc_parse_parameter should've now given
> dpgp_num: 1 ?
> 

Yes, it should. 

Looks like there's a parsing issue.
"earlyprintk=xdbc1,keep" fails on our Tigerlake as well.
  
Without the "keep" option it works for me:

[    0.000000] Command line: console=ttyS0,115200n8 buildroot_hostname=tgl04 earlyprintk=xdbc1 dmi_entry_point=0x74374000
[    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 1

-Mathias
