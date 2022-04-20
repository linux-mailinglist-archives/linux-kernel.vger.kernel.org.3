Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030C508A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379651AbiDTOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359299AbiDTOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:15:59 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5833A46B0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:09:06 -0700 (PDT)
Received: (qmail 631132 invoked by uid 1000); 20 Apr 2022 10:09:05 -0400
Date:   Wed, 20 Apr 2022 10:09:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] USB: Quiesce interrupts across pm freeze
Message-ID: <YmAUAVzveDE0oiTt@rowland.harvard.edu>
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <9f2752b5-8717-8ea3-1462-69bcfe42bb0e@suse.com>
 <Yl7Iz/lGk3fITzMK@rowland.harvard.edu>
 <8321b2c6-5bdb-2853-6812-50cd4e4d1bc7@suse.com>
 <Yl72GjATzVoJpSlA@rowland.harvard.edu>
 <95e1bd39-b159-f7a1-f51e-115dd0e60500@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e1bd39-b159-f7a1-f51e-115dd0e60500@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:47:27AM +0200, Oliver Neukum wrote:
> 
> 
> On 19.04.22 19:49, Alan Stern wrote:
> > On Tue, Apr 19, 2022 at 05:51:38PM +0200, Oliver Neukum wrote:
> >>
> >> On 19.04.22 16:35, Alan Stern wrote:
> >>> On Tue, Apr 19, 2022 at 09:05:53AM +0200, Oliver Neukum wrote:
> >>>
> >>>
> >>> The THAW part of suspend-to-hibernation is used only for writing the 
> >>> memory image to permanent storage.  I doubt that a malfunctioning HID 
> >>> device would interfere with this process.
> >>>
> >> True, if and only if all goes well. At the time thaw() has run writing
> >> the image to disk can still fail. In that case the devices will still
> >> be needed.
> > Consider adding a mechanism to usbcore which would allow an interface 
> > driver to request that the next time its device is resumed, the core 
> > should perform a reset-resume.  Would that help?
> >
> >
> 
> Strictly speaking no. We already have that in form of the RESET_RESUME
> quirk. The broken devices we are talking about here can do runtime PM
> perfectly fine, if and only if remote wakeup is requested.
> So we need that flag to translate only in freeze()/thaw() resulting in that
> behavior, as opposed to every pair of suspend()/resume()

That was my point.  The HID driver can check at suspend time whether or 
not remote wakeup will be enabled.  If yes, well and good, no changes 
are needed.  If not, the driver can then request that the following 
resume be a runtime-resume.

Another possibility is, as you mentioned before, adding a USB quirk for 
devices which require reset-resume whenever they are resumed with wakeup 
disabled.

Alan Stern
