Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C609850A0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384716AbiDUNbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiDUNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:31:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C66377FF;
        Thu, 21 Apr 2022 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650547719; x=1682083719;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u3ZREto5jKT6/WQWOkWb6z67+FOypMCBIGjhbDlYPdQ=;
  b=Uj9rQDPM1BkYfZjAIWtoUTAMc0ICOy4w2AQb602H0eqV65lrDI5JM6LJ
   i2R2xZAK7w9Ids9YX5HpXDDECk977Nw6Fm0WK/QfNQggRFJyTdemXOPz/
   Chuzf2LEO713Vw3QjXp6b2reIechzcq1b1DVeloz6k2VgFT6/hW/LICAC
   kHPAhvRrur3sbYbKZR1fFYKQXIbom/fq5HdzsKetVNauwx4gDwcmTk8uo
   9vpjjtpWGMlGKZ8lVuH31JTbcFMkFmvBhXV2mu8m72e6fpse4a5WlKGIS
   xO6SVuG5GI6qhhRlmP+qthPtVhKXTGGbx+iKOOfqOKvaqybqsn9JVkHEz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246246854"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246246854"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="866142964"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2022 06:28:36 -0700
To:     Fu Zixuan <r33s3n6@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
References: <20220421094236.1052170-1-r33s3n6@gmail.com>
 <YmEs6BqcyM7fgLXg@kroah.com>
 <CAMvdLANp4jHnySOmpjXZdFwruLdvN9qR-B_Ew9_zeCiKYiLZSA@mail.gmail.com>
 <YmFIqPeGQYKl33vh@kroah.com>
 <CAMvdLANGW35m0-mg_00wM2FPivmk-wVfqE379iNjE=gFL3u-5A@mail.gmail.com>
 <fb656254-bfc5-5930-3e7c-be84382d88f8@linux.intel.com>
 <CAMvdLANbXbiFfiPnwKEr+arNYMoRk0Lv7fngvCngz-mRv8vVZw@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] drivers: usb: host: fix NULL pointer dereferences
 triggered by unhandled errors in xhci_create_rhub_port_array()
Message-ID: <726884c3-4bc4-7907-1deb-acff2346a47d@linux.intel.com>
Date:   Thu, 21 Apr 2022 16:30:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMvdLANbXbiFfiPnwKEr+arNYMoRk0Lv7fngvCngz-mRv8vVZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.4.2022 16.11, Fu Zixuan wrote:
> On Thu, Apr 21, 2022 at 8:50 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 21.4.2022 15.21, Fu Zixuan wrote:
>>> On Thu, 21 Apr 2022 at 20:06, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Thu, Apr 21, 2022 at 07:55:28PM +0800, Fu Zixuan wrote:
>>>>> On Thu, 21 Apr 2022 at 18:07, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On Thu, Apr 21, 2022 at 05:42:36PM +0800, Zixuan Fu wrote:
>>>>>>> In xhci_create_rhub_port_array(), when rhub->num_ports is zero,
>>>>>>> rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
>>>>>>> would be set to NULL. In these two cases, xhci_create_rhub_port_array()
>>>>>>> just returns void, and thus its callers are unaware of the error.
>>>>>>>
>>>>>>> Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or
>>>>>>> xhci_usb2_hub_descriptor().

minor nit: rhub->ports dereference shouldn't happen in those functions if
rhub->num_ports is zero. 
The dereference is only an issue if kcalloc_node() fails.

>>>>>>>
>>>>>>> To fix the bug, xhci_setup_port_arrays() should return an integer to
>>>>>>> indicate a possible error, and its callers should handle the error.
>>>>>>>
>>>>>>> Here is the log when this bug occurred in our fault-injection testing:
>>>>>>>
>>>>>>> [   24.001309] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>>>> ...
>>>>>>> [   24.003992] RIP: 0010:xhci_hub_control+0x3f5/0x60d0 [xhci_hcd]
>>>>>>> ...
>>>>>>> [   24.009803] Call Trace:
>>>>>>> [   24.010014]  <TASK>
>>>>>>> [   24.011310]  usb_hcd_submit_urb+0x1233/0x1fd0
>>>>>>> [   24.017071]  usb_start_wait_urb+0x115/0x310
>>>>>>> [   24.017641]  usb_control_msg+0x28a/0x450
>>>>>>> [   24.019046]  hub_probe+0xb16/0x2320
>>>>>>> [   24.019757]  usb_probe_interface+0x4f1/0x930
>>>>>>> [   24.019765]  really_probe+0x33d/0x970
>>>>>>> [   24.019768]  __driver_probe_device+0x157/0x210
>>>>>>> [   24.019772]  driver_probe_device+0x4f/0x340
>>>>>>> [   24.019775]  __device_attach_driver+0x2ee/0x3a0
>>>>>>> ...
>>>>>>>
>>>>>>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>>>>>>> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/usb/host/xhci-mem.c | 17 ++++++++++++-----
>>>>>>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>>>>>>> index bbb27ee2c6a3..024515346c39 100644
>>>>>>> --- a/drivers/usb/host/xhci-mem.c
>>>>>>> +++ b/drivers/usb/host/xhci-mem.c
>>>>>>> @@ -2235,7 +2235,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
>>>>>>>       /* FIXME: Should we disable ports not in the Extended Capabilities? */
>>>>>>>  }
>>>>>>>
>>>>>>> -static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>>>>>>> +static int xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>>>>>>>                                       struct xhci_hub *rhub, gfp_t flags)
>>>>>>>  {
>>>>>>>       int port_index = 0;
>>>>>>> @@ -2243,11 +2243,11 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>>>>>>>       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>>>>>>>
>>>>>>>       if (!rhub->num_ports)
>>>>>>> -             return;
>>>>>>> +             return -EINVAL;
>>>>>>>       rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
>>>>>>>                       flags, dev_to_node(dev));
>>>>>>>       if (!rhub->ports)
>>>>>>> -             return;
>>>>>>> +             return -ENOMEM;
>>>>>>>
>>>>>>>       for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
>>>>>>>               if (xhci->hw_ports[i].rhub != rhub ||
>>>>>>> @@ -2259,6 +2259,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>>>>>>>               if (port_index == rhub->num_ports)
>>>>>>>                       break;
>>>>>>>       }
>>>>>>> +     return 0;
>>>>>>>  }
>>>>>>>
>>>>>>>  /*
>>>>>>> @@ -2277,6 +2278,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
>>>>>>>       int cap_count = 0;
>>>>>>>       u32 cap_start;
>>>>>>>       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>>>>>>> +     int ret;
>>>>>>>
>>>>>>>       num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
>>>>>>>       xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
>>>>>>> @@ -2367,8 +2369,13 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
>>>>>>>        * Not sure how the USB core will handle a hub with no ports...
>>>>>>>        */
>>>>>>>
>>>>>>> -     xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
>>>>>>> -     xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
>>>>>>> +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>> +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>
>>>>>> What about the memory allocated by the first call to
>>>>>> xhci_create_rhub_port_array()?  Is that now lost?  Same for everything
>>>>>> else allocated before these calls, how is that cleaned up properly?
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> Thanks for your swift reply. We understand your concern. In fact, we have
>>>>> checked the related code carefully and found that xhci_create_rhub_port_array()
>>>>> is only used in xhci_setup_port_arrays(). Moreover, only xhci_mem_init() calls
>>>>> xhci_setup_port_arrays() and does all cleanup work when it fails. Specifically,
>>>>> xhci_mem_init() calls xhci_mem_cleanup(), which eventually called
>>>>> kfree(xhci->usb2_rhub.ports) and kfree(xhci->usb3_rhub.ports).
>>>>
>>>> Great, can you mention this in the changelog text to show that you have
>>>> thought this through and it can be documented as such?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Thanks for your reply! We will do that and submit the patch v2 soon.
>>>
>>
>> Good to get this fixed, but there's a series by Heiner Kallweit that adds support
>> for xHC controllers with just one roothub [1].
>> It will conflict with this.
>>
>> We might need to change this a bit so that this can go to stable alone, but still
>> being being able to somewhat neatly apply that new series on top of this.
>>
>> 1. https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=for-usb-next
>>
>> Thanks
>> -Mathias
> 
> No problem! We will submit our patch on that branch.

No need after all, took a second look at that series. 
We can easily rebase it on top of your patch with just a small adjustment.

This way your fix can go to 5.18 and stable kernels, and the "one roothub" 
feature can go on top of it to 5.19.

So just add the comment Greg Suggested.

Sorry about the confusion.

Thanks
-Mathias
