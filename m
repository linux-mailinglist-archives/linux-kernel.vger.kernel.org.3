Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7748AC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiAKLNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:13:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36632 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiAKLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:13:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DF761596;
        Tue, 11 Jan 2022 11:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CA4C36AE3;
        Tue, 11 Jan 2022 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641899613;
        bh=RusBdLJOhe3F0aFWMDF9tfb7pW5/3dAGW6uBUol0si8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szf2W6SMe/VUssn1AMG+38/z7ptbdg494uvhrrAMsLUEZILBmeX2qddyYtS8b5NJ6
         yWMpzhwHbHEF4FCHJ2CRDYfUB/O1og1sfjwH3thRAwPTKEKQu5l/EVgSEQVjZqGg5B
         bzZtZHybNRrtri/gjLIXi2vp+m9+/NKvbuCrzjVE=
Date:   Tue, 11 Jan 2022 12:13:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: remove not used variables
Message-ID: <Yd1mWgwk/PKJkZSo@kroah.com>
References: <20220111085934.44844-1-pawell@gli-login.cadence.com>
 <Yd1KBiRB/ByZ2Kx1@kroah.com>
 <BYAPR07MB53811E109250D3D9C6447847DD519@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB53811E109250D3D9C6447847DD519@BYAPR07MB5381.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:38:53AM +0000, Pawel Laszczak wrote:
> >
> >On Tue, Jan 11, 2022 at 09:59:34AM +0100, Pawel Laszczak wrote:
> >> From: Pawel Laszczak <pawell@cadence.com>
> >>
> >> Patch removes not used variables:
> >>  - ret from cdnsp_decode_trb function
> >>  - temp_64 from cdnsp_run function
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  drivers/usb/cdns3/cdnsp-debug.h  | 287 +++++++++++++++----------------
> >>  drivers/usb/cdns3/cdnsp-gadget.c |   3 -
> >>  2 files changed, 138 insertions(+), 152 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
> >> index a8776df2d4e0..29f3cf7ddbaa 100644
> >> --- a/drivers/usb/cdns3/cdnsp-debug.h
> >> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> >> @@ -182,206 +182,195 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
> >>  	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
> >>  	int type = TRB_FIELD_TO_TYPE(field3);
> >>  	unsigned int ep_num;
> >> -	int ret = 0;
> >
> >Please fix this function to properly handle the ret value, as I think it
> >should be checked, right?
> 
> I think that it is not needed. Function is used only in one place in trace point in TP_printk. The buffer is
> big enough (500 bytes) to accommodate whole string.  In this form function can be directly used in
> TP_printk. If we will use ret instead of string as return type, then driver will need to format this string before
> calling trace point function and pass this ass parameter.  This solution will have impact for code size and
> performance even if we disable tracing

You should check somehow that you do not overflow the buffer, right?  To
not do so is a bit odd.

> >> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> >> @@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
> >>  		     enum usb_device_speed speed)
> >>  {
> >>  	u32 fs_speed = 0;
> >> -	u64 temp_64;
> >>  	u32 temp;
> >>  	int ret;
> >>
> >> -	temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> >> -	temp_64 &= ~ERST_PTR_MASK;
> >>  	temp = readl(&pdev->ir_set->irq_control);
> >>  	temp &= ~IMOD_INTERVAL_MASK;
> >>  	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
> >> --
> >> 2.25.1
> >>
> >
> >A separate patch for this.
> >
> >Also, are you SURE this is ok to do?  Did you check it on the hardware
> >that a read is not needed here for it to work properly?
> >
> >This type of "warning" is horrible for dealing with hardware devices,
> >always treat it as incorrect unless you can prove otherwise.
> >
> 
> Yes, I've tested it. I think that it was used in some printk and by mistake has not been removed. 
> 
> The warning was reported by Intel kernel test robot and fix are very simple. Patch is little bigger
> because some code had to be reformatted.  
> 
> Do I really need to send this as two separate patches

Yes, you are doing two different things here.

thanks,

greg k-h
