Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF250A539
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiDUQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiDUQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08682B241;
        Thu, 21 Apr 2022 09:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64EBFB8272D;
        Thu, 21 Apr 2022 16:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369BC385AA;
        Thu, 21 Apr 2022 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650557503;
        bh=0JZ8f5SuXJ/CklPHPrBpcIh6GJ/eB2k4giZBAKjN4wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1kq33rOex4y1oHLsbmshJ2D6M+8KNZQhsRDXKK7+sSLl0AMXrsR+wlZzUifBl/Jk
         ZXZRzNXQSjAZzmiGeDrjmrZIhcNFEGhI37q0L5xd7qz1PiUZcEuRr9rEIPBv1vZ4k/
         1MPi0jfzeJ/zoifBfcXa4/tIM9IAuf/5Q34gdCW4=
Date:   Thu, 21 Apr 2022 18:11:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Fu Zixuan <r33s3n6@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] drivers: usb: host: fix NULL pointer dereferences
 triggered by unhandled errors in xhci_create_rhub_port_array()
Message-ID: <YmGCO0Km/pqPVgGK@kroah.com>
References: <20220421094236.1052170-1-r33s3n6@gmail.com>
 <YmEs6BqcyM7fgLXg@kroah.com>
 <CAMvdLANp4jHnySOmpjXZdFwruLdvN9qR-B_Ew9_zeCiKYiLZSA@mail.gmail.com>
 <YmFIqPeGQYKl33vh@kroah.com>
 <CAMvdLANGW35m0-mg_00wM2FPivmk-wVfqE379iNjE=gFL3u-5A@mail.gmail.com>
 <fb656254-bfc5-5930-3e7c-be84382d88f8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb656254-bfc5-5930-3e7c-be84382d88f8@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:52:40PM +0300, Mathias Nyman wrote:
> On 21.4.2022 15.21, Fu Zixuan wrote:
> > On Thu, 21 Apr 2022 at 20:06, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Apr 21, 2022 at 07:55:28PM +0800, Fu Zixuan wrote:
> >>> On Thu, 21 Apr 2022 at 18:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> On Thu, Apr 21, 2022 at 05:42:36PM +0800, Zixuan Fu wrote:
> >>>>> In xhci_create_rhub_port_array(), when rhub->num_ports is zero,
> >>>>> rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
> >>>>> would be set to NULL. In these two cases, xhci_create_rhub_port_array()
> >>>>> just returns void, and thus its callers are unaware of the error.
> >>>>>
> >>>>> Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or
> >>>>> xhci_usb2_hub_descriptor().
> >>>>>
> >>>>> To fix the bug, xhci_setup_port_arrays() should return an integer to
> >>>>> indicate a possible error, and its callers should handle the error.
> >>>>>
> >>>>> Here is the log when this bug occurred in our fault-injection testing:
> >>>>>
> >>>>> [   24.001309] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>>>> ...
> >>>>> [   24.003992] RIP: 0010:xhci_hub_control+0x3f5/0x60d0 [xhci_hcd]
> >>>>> ...
> >>>>> [   24.009803] Call Trace:
> >>>>> [   24.010014]  <TASK>
> >>>>> [   24.011310]  usb_hcd_submit_urb+0x1233/0x1fd0
> >>>>> [   24.017071]  usb_start_wait_urb+0x115/0x310
> >>>>> [   24.017641]  usb_control_msg+0x28a/0x450
> >>>>> [   24.019046]  hub_probe+0xb16/0x2320
> >>>>> [   24.019757]  usb_probe_interface+0x4f1/0x930
> >>>>> [   24.019765]  really_probe+0x33d/0x970
> >>>>> [   24.019768]  __driver_probe_device+0x157/0x210
> >>>>> [   24.019772]  driver_probe_device+0x4f/0x340
> >>>>> [   24.019775]  __device_attach_driver+0x2ee/0x3a0
> >>>>> ...
> >>>>>
> >>>>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> >>>>> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
> >>>>> ---
> >>>>>  drivers/usb/host/xhci-mem.c | 17 ++++++++++++-----
> >>>>>  1 file changed, 12 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> >>>>> index bbb27ee2c6a3..024515346c39 100644
> >>>>> --- a/drivers/usb/host/xhci-mem.c
> >>>>> +++ b/drivers/usb/host/xhci-mem.c
> >>>>> @@ -2235,7 +2235,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
> >>>>>       /* FIXME: Should we disable ports not in the Extended Capabilities? */
> >>>>>  }
> >>>>>
> >>>>> -static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >>>>> +static int xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >>>>>                                       struct xhci_hub *rhub, gfp_t flags)
> >>>>>  {
> >>>>>       int port_index = 0;
> >>>>> @@ -2243,11 +2243,11 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >>>>>       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> >>>>>
> >>>>>       if (!rhub->num_ports)
> >>>>> -             return;
> >>>>> +             return -EINVAL;
> >>>>>       rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
> >>>>>                       flags, dev_to_node(dev));
> >>>>>       if (!rhub->ports)
> >>>>> -             return;
> >>>>> +             return -ENOMEM;
> >>>>>
> >>>>>       for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
> >>>>>               if (xhci->hw_ports[i].rhub != rhub ||
> >>>>> @@ -2259,6 +2259,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> >>>>>               if (port_index == rhub->num_ports)
> >>>>>                       break;
> >>>>>       }
> >>>>> +     return 0;
> >>>>>  }
> >>>>>
> >>>>>  /*
> >>>>> @@ -2277,6 +2278,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> >>>>>       int cap_count = 0;
> >>>>>       u32 cap_start;
> >>>>>       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> >>>>> +     int ret;
> >>>>>
> >>>>>       num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> >>>>>       xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
> >>>>> @@ -2367,8 +2369,13 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> >>>>>        * Not sure how the USB core will handle a hub with no ports...
> >>>>>        */
> >>>>>
> >>>>> -     xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> >>>>> -     xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> >>>>> +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     ret = xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>
> >>>> What about the memory allocated by the first call to
> >>>> xhci_create_rhub_port_array()?  Is that now lost?  Same for everything
> >>>> else allocated before these calls, how is that cleaned up properly?
> >>>>
> >>>> thanks,
> >>>>
> >>>> greg k-h
> >>>
> >>> Thanks for your swift reply. We understand your concern. In fact, we have
> >>> checked the related code carefully and found that xhci_create_rhub_port_array()
> >>> is only used in xhci_setup_port_arrays(). Moreover, only xhci_mem_init() calls
> >>> xhci_setup_port_arrays() and does all cleanup work when it fails. Specifically,
> >>> xhci_mem_init() calls xhci_mem_cleanup(), which eventually called
> >>> kfree(xhci->usb2_rhub.ports) and kfree(xhci->usb3_rhub.ports).
> >>
> >> Great, can you mention this in the changelog text to show that you have
> >> thought this through and it can be documented as such?
> >>
> >> thanks,
> >>
> >> greg k-h
> > 
> > Thanks for your reply! We will do that and submit the patch v2 soon.
> > 
> 
> Good to get this fixed, but there's a series by Heiner Kallweit that adds support
> for xHC controllers with just one roothub [1].
> It will conflict with this.  
> 
> We might need to change this a bit so that this can go to stable alone, but still
> being being able to somewhat neatly apply that new series on top of this.

As this is not anything a normal user will ever hit, it should be redone
on top of your xhci changes as it's not needed in any stable tree.

thanks,

greg k-h
