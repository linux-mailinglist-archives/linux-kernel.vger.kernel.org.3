Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A504B68F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiBOKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:15:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiBOKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:15:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52B10E078;
        Tue, 15 Feb 2022 02:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644920103; x=1676456103;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P3O9RVEmyjwfNMnRlSoLb01VrE7EGKUuzO6cSHuVtJE=;
  b=M/50bWFkG5CwAEPbzEquDRTp8izqMmSZ5BiGaBVTJ7ptYTb5XEXRJGdG
   3PbtMbSlZelO8X+GIj5BrI//Pgz35hLhTiTC8S54FV5VavmBvhZLI9VO5
   70Z/eX3oDu9cm5x8gtfyCN6YC6Y5Uog31qqjb3jNE6YrQpAOqv0Mh+zPC
   wHsDiCLexdTD/BLFeKtxXTm9Vy3uqwXSGeW+v9Gk+oxtplAF9Jy6MAxft
   GemhWKZafCosLS7T0YK/cjAdqtqsfyOh/HbAzQC1YOhztyhtpoy65jwxu
   1Pw2ZOl6Fqpy0sLMz6WGW84LdbmE0vPAYo+kz2YMR8dSTJvPo3gI6xWGD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237723232"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="237723232"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="570751654"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2022 02:14:35 -0800
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com, Jung Daehwan <dh10.jung@samsung.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
Date:   Tue, 15 Feb 2022 12:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.2.2022 15.53, Pavan Kondeti wrote:
> Hi Mathias,
> 
> On Mon, Feb 14, 2022 at 02:51:54PM +0200, Mathias Nyman wrote:
>> On 14.2.2022 14.20, Pavankumar Kondeti wrote:
>>> From: Daehwan Jung <dh10.jung@samsung.com>
>>>
>>> xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
>>> controller reset and controller ready operations can be fatal to the
>>> system when controller is timed out. Reduce the timeout to 1 second
>>> and print a error message when the time out happens.
>>>
>>> Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
>>
>>
>> The commit 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
>> intentionally increased the timeout to 10 seconds as that host might take 9
>> seconds to complete reset. This was done almost 10 years ago so I don't know
>> if it really is an issue anymore.
>>
>> Anyways, your patch might break Renesas 72021 instead of fixing it.
> 
> Unfortunately, yes :-( . We have this reduced timeout patch in our previous
> commercialized products so thought this would be a good time to fix this
> once for all. Since this patch has been 10 years long, not sure if any other
> controllers also need 10 sec timeout. It would probably better
> 
>>
>> I agree that busylooping up to 10 seconds with interrupts disabled doesn't make sense.
>>
>> Lets see if there is another solution for your case.
>>
>> - Does a "guard interval" after writing the reset help?
>>   For example Intel xHCI needs 1ms before touching xHC after writing the reset bit
> 
> I will ask this question to our hardware team. Setting that one quirk from
> DWC3 host might require other changes like this [1].
>>
>> - Is it the CNR bit or the RESET bit that fails? could be just stuck CNR bit? 
> 
> The RESET bit never gets cleared from USBCMD register.
> 
>>  
>> - we only disable local interrupts when xhci_reset() is called from xhci_stop(),
>>   and sometimes from xhci_shutdown() and xhci_resume() if some conditions are met.
>>   Have you identified which one is the problematic case?
> 
> The crash reports I have seen are pointing to
> 
> usb_remove_hcd()->xhci_stop()->xhci_reset()

Ok, so xhci_stop() and xhci_shutdown() both may call xhci_reset() with interrupts
disabled and spinlock held. In both these cases we're not that interested in the
outcome of xhci_reset().

But during probe we call xhci_reset() with interrupts enabled without spinlock,
and here we really care about it succeeding.
I'm also guessing reset could take a longer time during probe due to possible recent
BIOS handover, or firmware loading etc.

So how about passing a timeout value to xhci_reset()?
Give it 10 seconds during probe, and 250ms in the other cases.

Then dig into the reason why xhci_stop(), xhci_resume() and xhci_shutdown() call
xhci_reset() witch spin_lock_irq() held.

-Mathias
