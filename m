Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7304B8D23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiBPQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:00:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiBPQA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:00:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AAD299240;
        Wed, 16 Feb 2022 08:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645027216; x=1676563216;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qGkinCfu/1zyVhrWnUST1dc7y792SgmwO1dBu64ajLQ=;
  b=MPxXf1thg5iDqSQq3cdl+aK1r0GNFVq9JpCnou+tmmZpIQFhh0uqfFRH
   ZgQ5vGBTZrWUXizohJz8mweHgfwK1zv2j9Venv/4Ypmlq5DZAPo4kkcNr
   1gTpWd9Y81ofFD0E0TwFQjJuIjjh2Yizc49yJexPB2wCbUsQ0i8DErKlz
   VVW/D6R5n0UtTU8bxPmpVBi/Uls+bNwQrsqFBAojBQglK/1ocfCOFp4uW
   I7uFdSCFEf3YPrzydue46bikSPFUFkaw5ePZxfLJ9Q76wh7Zx5s/PWDIO
   f44K9zyp0OinIVUB1d6TljD5Wvemc5MM4sTplR55vUd+EPSDvWqjFMnIo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250592553"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250592553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 07:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="571342420"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2022 07:56:38 -0800
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com, Jung Daehwan <dh10.jung@samsung.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
 <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
 <20220215104920.GE31021@hu-pkondeti-hyd.qualcomm.com>
 <20220215170718.GF31021@hu-pkondeti-hyd.qualcomm.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <70ebdb8c-1ea5-1a3e-046e-5e457f54726d@linux.intel.com>
Date:   Wed, 16 Feb 2022 17:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220215170718.GF31021@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.2.2022 19.07, Pavan Kondeti wrote:
>>>>
>>>> The crash reports I have seen are pointing to
>>>>
>>>> usb_remove_hcd()->xhci_stop()->xhci_reset()
>>>
>>> Ok, so xhci_stop() and xhci_shutdown() both may call xhci_reset() with interrupts
>>> disabled and spinlock held. In both these cases we're not that interested in the
>>> outcome of xhci_reset().
>>>
>>> But during probe we call xhci_reset() with interrupts enabled without spinlock,
>>> and here we really care about it succeeding.
>>> I'm also guessing reset could take a longer time during probe due to possible recent
>>> BIOS handover, or firmware loading etc.
>>>
>>> So how about passing a timeout value to xhci_reset()?
>>> Give it 10 seconds during probe, and 250ms in the other cases.
>>>
>>
>> Thanks for this suggestion.
>>
>> This sounds better compared to the quirks approach. xhci_resume() also seems
>> to be calling xhci_reset() in the hibernation path, I believe we should treat
>> this like probe()/startup case and give larger timeout.
>>
> I will test the below patch as per Mathias suggestion.
> 
> Thanks,
> Pavan
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index df3522d..031fe90 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -762,7 +762,7 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
>  	}
>  	pm_runtime_allow(xhci_to_hcd(xhci)->self.controller);
>  	xhci->test_mode = 0;
> -	return xhci_reset(xhci);
> +	return xhci_reset(xhci, false);

Maybe just pass the timeout value directly to xhci_reset().
Looks like readl_poll_timeout_atomic() uses u64 for timeout_us,
makes sense to use the same.

Sergey also pointed out xhci_handshake() incorrectly uses a signed integer for timeouts.
This could be changed to u64 as well.

I'll write a patch that does all above

-Mathias
