Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B146847400D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhLNKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:03:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:44145 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhLNKDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:03:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299725651"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="299725651"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 02:03:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="661256722"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2021 02:03:49 -0800
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yun-Chien Yu <yun-chien.yu@mediatek.com>
References: <20211209072218.21651-1-chunfeng.yun@mediatek.com>
 <c448da77-f2f3-8b79-fc4b-b9dcff727c6e@linux.intel.com>
 <CAKgpwJXxtLwOjxjg3vFHiqS92j6rx_b1+C-bRwDnp+PBvXCMTg@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: xhci: skip re-check pending port event if hibernated
Message-ID: <e7a6e45e-68ce-54a5-9632-80244dd1e4c7@linux.intel.com>
Date:   Tue, 14 Dec 2021 12:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKgpwJXxtLwOjxjg3vFHiqS92j6rx_b1+C-bRwDnp+PBvXCMTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.2021 10.00, Jun Li wrote:
> Mathias Nyman <mathias.nyman@linux.intel.com> 于2021年12月11日周六 01:56写道：
>>
>> On 9.12.2021 9.22, Chunfeng Yun wrote:
>>> When xHCI controller hibernated, the root hub lost power, if controller
>>> support Port Power Control (PPC), PP is not set at xhci_resume() and
>>> set by hub_reset_resume() later, so no need check pending port event.
>>> If PPC is not supported, device is disconneced, seems do not send out
>>> U3 LFPS wake signal, no need re-check again and drop 120ms delay to
>>> save resume time.
>>>
>>> Reported-by: Yun-Chien Yu <yun-chien.yu@mediatek.com>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>
>> Thanks, adding
> 
> Hi Mathias, Chunfeng
> 
> I have a question on this, if there is no any usb devices connected
> before suspend, do we need this 120ms delay to check again?
> So do we need one more condition to limit this like?
> if (!pending_portevent && !hibernated && xhci_has_child_device())

The 120ms delay was added to make sure we catch the second wake signal
from a device in case host missed the first U3 exit LFPS wakeup signal.

Even if no devices are connected this might be helpful if a device is
connected while host is suspended.
I haven't checked any timing for the link training during enumeration,
but it also uses LFPS signalling, and connected device isn't visible to
driver until link is successfully trained.

So the original 120ms delay patch might as a positive side effect ensure
driver doesn't suspend host mid device enumeration.

Could be looked into more, but I don't think we should this patch by
Chunfeng

Thanks
Mathias
