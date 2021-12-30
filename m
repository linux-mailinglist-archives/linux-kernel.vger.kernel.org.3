Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99824481C89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbhL3Nak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:30:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:20878 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239720AbhL3Nae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640871034; x=1672407034;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CaykkQeZGgUd3oJK9j6eM6u/Kxn85gXCb8YO2ymI5Yg=;
  b=isGGsVSx1lhfJ7ZiGCMfCHZoTnbqQ8UC0xwbHFiw7joTul/o9QIqQ117
   hmVy3N1VR+BUrpPX0Af8RhhWsgxPFff65KgAWXCgT3kdyo9YB8h5YNOXn
   21bWv0wpkkG5Kw3drrQ0uA2Bl6/6cSCbd3yhPXY9zPzCDHWVzIg2NfDa7
   kEp70neLNozve6NIsFTBqEHNvk96yZUh49NADmwqOdMaYUupRRMxtvk+j
   e5xdVJeQ9oYZ3nTPR1itodB8lJV7NnNUbvGGnUJtX6pduZCWzAuSViGsQ
   f1KGJKDCSOuV0XuCBo7aanvpg6ta3BkwgU4akaAKn/SF2pL2l9/IAsJyH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="239212545"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="239212545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 05:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="619368353"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 30 Dec 2021 05:30:31 -0800
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cgel.zte@gmail.com
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211230064010.586496-1-luo.penghao@zte.com.cn>
 <Yc1ZaOsmoZHoWyxt@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH linux] usb: xhci-ring: Add return if ret is less than 0
Message-ID: <a740545a-b2cc-d829-8d63-6f0dc5ef6f8f@linux.intel.com>
Date:   Thu, 30 Dec 2021 15:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yc1ZaOsmoZHoWyxt@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.2021 9.02, Greg Kroah-Hartman wrote:
> On Thu, Dec 30, 2021 at 06:40:10AM +0000, cgel.zte@gmail.com wrote:
>> From: luo penghao <luo.penghao@zte.com.cn>
>>
>> For the robustness of the code, judgment and return should be added here
> 
> I do not understand this changelog text at all.  Please explain the
> problem and why you are making this change much better.
> 

Agree, this doesn't explain at all what is going on.

So looking at the code it checks if a zero-length transfer after a bulk transfer is
properly prepared before queuing the TRB to hardware.

Nothing wrong with that. We do check that the main part of the bulk transfer
is properly prepared before this, so it's very unlikely to fail, but not impossible. 

>>
>> The clang_analyzer complains as follows:
>>
>> drivers/usb/host/xhci-ring.c:
>>
>> Value stored to 'ret' is never read
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
>> ---
>>  drivers/usb/host/xhci-ring.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index d0b6806..c4eefe2 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -3721,6 +3721,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
>>  		ret = prepare_transfer(xhci, xhci->devs[slot_id],
>>  				       ep_index, urb->stream_id,
>>  				       1, urb, 1, mem_flags);
>> +		if (unlikely(ret < 0))
>> +			return ret;

We can't just return if it fails. 
We already queued the main part of the bulk transfer to the ring, but haven't given
those TRBs to hardware yet. This is done in giveback_first_trb() a few lines later.

As this case probably won't happen, we could just add a small debug message here,
and skip the zero-length packet. 
Queue the main part of the bulk transfer and give it to hardware anyway.
It will probably time out later.

>>  		urb_priv->td[1].last_trb = ring->enqueue;
>>  		urb_priv->td[1].last_trb_seg = ring->enq_seg;
>>  		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
>> -- 
>> 2.15.2
>>
>>
> 
> How did you test this change?

Wondering the same.

Suggestion:
Add a hack to detect a zero-length transfer in prepare_transfer(), and intentionally 
fail (return error) in places prepare_transfer() could normally fail.

And then check that the system behaves better with your patch than without.

-Mathias
