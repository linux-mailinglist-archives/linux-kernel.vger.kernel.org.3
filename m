Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3C5AD62D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiIEPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbiIEPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:18:38 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 21B961FCF0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:18:30 -0700 (PDT)
Received: (qmail 356045 invoked by uid 1000); 5 Sep 2022 11:18:29 -0400
Date:   Mon, 5 Sep 2022 11:18:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ray Chi <raychi@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        mathias.nyman@linux.intel.com,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] usb: core: stop USB enumeration if too many retries
Message-ID: <YxYTRSSeNqooy7lz@rowland.harvard.edu>
References: <20220902091535.3572333-1-raychi@google.com>
 <YxIX+jqWFfwAWYot@rowland.harvard.edu>
 <CAPBYUsApTYex027qBe-=EyUxDHb8MMQscX+2jqZ98zXxN-0tHA@mail.gmail.com>
 <YxI4ZViLkZOjN/Bh@rowland.harvard.edu>
 <CAPBYUsCEjMSJ8P8ZM1_W+S1DOWFTOM0wJwi2fTukfxSGucYhnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsCEjMSJ8P8ZM1_W+S1DOWFTOM0wJwi2fTukfxSGucYhnQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:36:16PM +0800, Ray Chi wrote:
> On Sat, Sep 3, 2022 at 1:07 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > I don't understand.  If you don't know whether the accessory is broken,
> > how do you know whether to set the quirk?
> >
> > On the other hand, if you always set the quirk even before you know
> > whether the accessory is broken, why make it a quirk at all?  Why not
> > make it the normal behavior of the driver?
> >
> 
> Since our device has a watchdog mechanism, when the device connects to
> a broken accessory, the kernel panic will happen. This problem didn't happen
> in all USB Hosts, so I want to use the quirk to fix this problem for those hosts
> with a watchdog mechanism.

Okay.  So this shouldn't be a quirk; it should apply all the time to any 
hub where the host controller has this watchdog mechanism.

> > Why not set CONFIG_USB_FEW_INIT_RETRIES instead?
> >
> 
> https://source.android.com/docs/core/architecture/kernel/android-common
> According to Android Common Kernel, I can't only add this config to one project.
> In addition, it can't stop enumeration so that the timeout problem
> still happens.

This is the first time you have mentioned either the watchdog mechanism 
or the fact that this is intended for Android.  It would have been a lot 
better if both of these facts were included in the initial patch 
description.  You can't expect people to evaluate a new patch properly 
if they don't have a clear picture of what it was meant for.

> > might describe in detail a situation where the quirk is needed,
> > explaining what sort of behavior of the system would lead you to set the
> > quirk, and why.
> >
> 
> There is a kernel panic when the device connects to the broken accessory.
> I tried to modify the initial_descriptor_timeout. When the accessory is not
> working, the total time is 6.5s (get descriptor retry) + 5*2 seconds
> (set address of xhci timeout).
> The time is so long to cause kernel panic for the device. This is why I want to
> stop enumeration instead reducing the retries or timeout.

It sounds like what you need is a "quick initialization" option that 
will limit the timeout lengths and the numbers of retries, and will 
cause the system to ignore connections on a port once an initialization 
has failed.  There should also be a way to make the system stop ignoring 
a port, perhaps by writing to a sysfs file.

In addition, there should be an automatic algorithm to determine which 
hub ports this option will apply to.  I don't think you want it to be 
based on a quirk, because you shouldn't need to wait for a kernel panic 
before realizing that the quirk is needed -- that's why the algorithm 
has to be automatic.

Can you write a new patch that works more like this?

Alan Stern
