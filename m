Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0127478CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhLQN4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhLQN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:56:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C022C061574;
        Fri, 17 Dec 2021 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ae8cpPHySj4MeIsuauebRN5hQTqe/wQO8gCu7jDTS48=; b=UbyWErt5wUL9FjVlGl/lqJCWU+
        uexwlh/J+gD4lhMSPZZs5uBqOo0WUspykoVmmUSGqmvFWsNOEXdtTxxGM5X3QS4oNRxV2VUX1U0cC
        oMFsAdBSo4FlOxPdifSBqNfSsg/jF1MSFgNBFfuqok6yu6mUUId/GsLoFQstU5/Qczc3XIA/k04aS
        vU/krnwBn8G+esYTDVUnFiqkVEApawiq9PbkUKXZXEYiYsFGelkf2tqWs+UYx/kQLirX9oM622c7k
        XP1QsctFAX2lvqBEFlOf+b9JjcbVtZL2sL8zOWp66909gpXNQpyxTBhFzdt3yJysVgjgbiufYorVZ
        6hbqiKlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myDhW-001tPq-SX; Fri, 17 Dec 2021 13:55:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 860C73001CD;
        Fri, 17 Dec 2021 14:55:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4058120D11FE1; Fri, 17 Dec 2021 14:55:07 +0100 (CET)
Date:   Fri, 17 Dec 2021 14:55:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> I can reproduce this.
> Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> 
> 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()

I can confirm, reverting that solves the boot hang, things aren't quite
working for me though.

> Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
> Maybe  it's too early for ktime.

It certainly is, using ktime for delay loops sounds daft to me anyhow.

> After reverting that patch it works again for me.

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc3+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc force_early_printk sched_verbose ftrace=nop mitigations=off nokaslr
...
[    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
...
[    3.161367] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host

The machine does boot.. but I *am* getting tons of:

[  485.546898] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
[  485.546963] usb usb4-port4: config error

However, when I do:

$ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc

I get:

[  569.442899] xhci_hcd 0000:00:14.0: DbC connected
[  569.898910] xhci_hcd 0000:00:14.0: DbC configured

And the remote machine gets:

[2318863.729022] usb 2-3: new SuperSpeed USB device number 8 using xhci_hcd
[2318863.749299] usb 2-3: LPM exit latency is zeroed, disabling LPM.
[2318863.749529] usb 2-3: New USB device found, idVendor=1d6b, idProduct=0010, bcdDevice= 0.10
[2318863.749531] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[2318863.749532] usb 2-3: Product: Linux USB Debug Target
[2318863.749533] usb 2-3: Manufacturer: Linux Foundation
[2318863.749534] usb 2-3: SerialNumber: 0001
[2318863.751142] usb_debug 2-3:1.0: xhci_dbc converter detected
[2318863.751268] usb 2-3: xhci_dbc converter now attached to ttyUSB0

and a subsequent:

$ echo ponies > /dev/ttyDBC0

Does show up on the remote machine...


So XDBC 'works' but earlyprintk is still refusing service.


