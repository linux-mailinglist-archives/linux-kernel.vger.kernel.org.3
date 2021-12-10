Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF04702A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbhLJOYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:24:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:62032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhLJOYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:24:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="219039683"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="219039683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 06:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="659588424"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2021 06:20:38 -0800
Subject: Re: [PATCH] xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI
 from runtime suspending
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211119092628.677935-1-kai.heng.feng@canonical.com>
 <CAAd53p4CpEQR0Y5XDN5E7xZ-iw2GG=gGMSm2Vd=V_M1LLEuuCA@mail.gmail.com>
 <b7595524-1041-8b8b-dc61-9ee0acbc8307@linux.intel.com>
 <CAAd53p4OOyrLJYbhYVqJSJ2NukmhM26GEf7rM7cV0=6_djhpxw@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <9e2f77e9-952c-de4d-6efc-3f5c75a6285b@linux.intel.com>
Date:   Fri, 10 Dec 2021 16:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p4OOyrLJYbhYVqJSJ2NukmhM26GEf7rM7cV0=6_djhpxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.12.2021 8.42, Kai-Heng Feng wrote:
> On Wed, Dec 1, 2021 at 5:00 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 1.12.2021 2.19, Kai-Heng Feng wrote:
>>> On Fri, Nov 19, 2021 at 5:27 PM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>>
>>>> When the xHCI is quirked with XHCI_RESET_ON_RESUME, runtime resume
>>>> routine also resets the controller.
>>>>
>>>> This is bad for USB drivers without reset_resume callback, because
>>>> there's no subsequent call of usb_dev_complete() ->
>>>> usb_resume_complete() to force rebinding the driver to the device. For
>>>> instance, btusb device stops working after xHCI controller is runtime
>>>> resumed, if the controlled is quirked with XHCI_RESET_ON_RESUME.
>>>>
>>>> So always take XHCI_RESET_ON_RESUME into account to solve the issue.
>>>>
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>
>>> A gentle ping...
>>
>> Thanks
>> Adding to queue
> 
> I haven't found this patch in your repo. Can you please push it so I
> can backport it to downstream kernel?

Patch got shuffled around a bit.
It's now in my for-usb-linus branch, and sent to Greg

Thanks
-Mathias

