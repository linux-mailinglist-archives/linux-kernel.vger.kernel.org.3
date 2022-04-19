Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237FD5076CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356046AbiDSRwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356061AbiDSRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:51:58 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5D1BE11A1A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:49:15 -0700 (PDT)
Received: (qmail 600832 invoked by uid 1000); 19 Apr 2022 13:49:14 -0400
Date:   Tue, 19 Apr 2022 13:49:14 -0400
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
Message-ID: <Yl72GjATzVoJpSlA@rowland.harvard.edu>
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <9f2752b5-8717-8ea3-1462-69bcfe42bb0e@suse.com>
 <Yl7Iz/lGk3fITzMK@rowland.harvard.edu>
 <8321b2c6-5bdb-2853-6812-50cd4e4d1bc7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8321b2c6-5bdb-2853-6812-50cd4e4d1bc7@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 05:51:38PM +0200, Oliver Neukum wrote:
> 
> 
> On 19.04.22 16:35, Alan Stern wrote:
> > On Tue, Apr 19, 2022 at 09:05:53AM +0200, Oliver Neukum wrote:
> >
> >
> > We have a set of quirky devices that need HID_QUIRK_ALWAYS_POLL.
> > They have the nasty firmware bug that, if you suspend them without
> > remote wakeup, they will crash or reset themselves.
> > I am afraid that has an obvious relevance to your cool patches.
> > I am not completely sure how to deal with this. It seems to me that the
> > quirk will need to be shifted from HID to core USB and thaw() needs to
> > be translated into usb_device_reset() + reset_resume() for them,
> > but I am not really sure about the optimal mechanism.
> > We may not need to do anything.  This patch specifically addresses 
> > hibernation, not system suspend or runtime suspend.  A device crashing 
> > or resetting during hibernation is not at all unusual; we should be able 
> > to handle such cases properly.
> >
> > The THAW part of suspend-to-hibernation is used only for writing the 
> > memory image to permanent storage.  I doubt that a malfunctioning HID 
> > device would interfere with this process.
> >
> True, if and only if all goes well. At the time thaw() has run writing
> the image to disk can still fail. In that case the devices will still
> be needed.

Consider adding a mechanism to usbcore which would allow an interface 
driver to request that the next time its device is resumed, the core 
should perform a reset-resume.  Would that help?

Alan Stern
