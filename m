Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E27647B0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhLTPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhLTPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:51:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E8C061574;
        Mon, 20 Dec 2021 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p6oI7t6a2sP+y+8OnSAo1gKUw6uZD1Gb+30mWCzcviM=; b=TbrO5EIrYsdS1CZXyeUMFR1ZGj
        igJHlz87ytOr2HT8Scqbk1ZenaFxBIoXwSi/zvAsHkk2d+ZJQ3j0GMVjUdHheawHIz0wKzkFoHyiG
        T9ZHq9vF1RZ88SgZGZTR8mq0EeULOXJ71RFoWcYTDG4oaBS0c6lOkXXiM3aNnhTAOJ58QlcfngYnQ
        Ea2XeVCuz89bpJIiroPXhTK2X+LOL1fEazLkOK/y6+b8DXbmPHOum4l5JQIWZP62lH/zC10eCMSP0
        2J5tqVGEwSetWQTvxHD3/yoqJAKxMFPvuFyZphCUbyDzbwXL51E8KmL9GfZmTaSwL/12WQvi24R9n
        OzAToDKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzKww-002X19-7X; Mon, 20 Dec 2021 15:51:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F38530003C;
        Mon, 20 Dec 2021 16:51:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB011200E706A; Mon, 20 Dec 2021 16:51:40 +0100 (CET)
Date:   Mon, 20 Dec 2021 16:51:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YcCmjP8GCD+2qQH0@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <3281618b-64df-711e-4360-c74e6165d7ed@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3281618b-64df-711e-4360-c74e6165d7ed@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:34:13PM +0200, Mathias Nyman wrote:
> On 17.12.2021 15.55, Peter Zijlstra wrote:
> > On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> >> I can reproduce this.
> >> Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> >>
> >> 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> > 
> > I can confirm, reverting that solves the boot hang, things aren't quite
> > working for me though.
> > 
> >> Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
> >> Maybe  it's too early for ktime.
> > 
> > It certainly is, using ktime for delay loops sounds daft to me anyhow.
> > 
> >> After reverting that patch it works again for me.
> > 
> > [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
> > ...
> > [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
> > ...
> > [    3.161367] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
> 
> Ok, this is some other issue. I got the boot messages over USB
> (running minicom at the other end, listening to ttyUSB0)

I have a regular A->A USB3 cable, not the special one with a wire
missing. Given the dbc thing works, I feel this ought to work too.

> > The machine does boot.. but I *am* getting tons of:
> > 
> > [  485.546898] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
> > [  485.546963] usb usb4-port4: config error
> 
> This is expected when xhci driver takes over after the early dbc driver,
> xhci driver resets xHC controller, and all ports turn to normal host ports again.
> 
> Because of the special cable you now have two hosts connected to each other,
> both trying to enumerate a device.
> 
> This whole transition from earlyprintk xdbc to normal xhci driver is 
> not very userfriendly.

Uhhmm... but but that shouldn't be. What if I want to keep using xdbc as
console after that point? specifically, I'll probably end up having:

 earlyprintk=xdbc,keep

once all this starts working. The whole point of early consoles is that
they're more reliable than regular consoles, not that they're 'early'.

> > However, when I do:
> > 
> > $ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc
> > 
> 
> Yes, this works as it turns on the DbC feature on in xHC hardware,
> which turns the first USB port into a usb device.

But if this works, why isn't earlyprintk working for me?
