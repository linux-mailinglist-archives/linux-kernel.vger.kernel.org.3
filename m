Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4013F46691E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhLBReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhLBReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFAAC06174A;
        Thu,  2 Dec 2021 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sEWHIxjOWFg80SWER+urzfc9OekftWsOORvg2PEkR3Q=; b=QQGolphIZAwJ+ihBIQIIC1DMsz
        8QQwZB0gHnsamiiaIhTdRmUs9Q5u4i9eJG4hYrL5Swz/id2UKHfcBprDMjrrvy6OoPTOJK8Ko4ece
        Oq8zMlyoduL3KEGkk0MkvhXgQOQWqvGkX8fqy7WrE9kd1LHNb+Nf4H+XXLGIJmuoWcwBYrhdK7hxw
        l95GWNNN9wL4ntvCQlPVRhQgnwfKCIcYOYJWTifhMz/juMaehJKNAY7wqlY4lZeZifIszmBlL15nm
        pY5z9B5lYmiu7ftOV6v79WDiRj0OOQHExlBRGugq2vUnlR2D4CXz72219omHuatEA1NXRIiHvFqCA
        SAapKL0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mspuv-001qkT-UQ; Thu, 02 Dec 2021 17:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D061300728;
        Thu,  2 Dec 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1537D200C72E7; Thu,  2 Dec 2021 16:22:55 +0100 (CET)
Date:   Thu, 2 Dec 2021 16:22:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     baolu.lu@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Subject: earlyprintk=xdbc seems broken
Message-ID: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

I was unfortunate enough to need xdbc and can't get my machine to boot
with earlyprintk=xdbc on the cmdline.

When I boot the target without the earlyprintk=xdbc, but have the cable
attached, it won't boot because boot gets stuck like:

Dec  2 15:08:10 tigerlake kernel: [   42.043137] usb usb4-port3: Cannot enable. Maybe the USB cable is bad?
Dec  2 15:08:10 tigerlake kernel: [   42.043227] usb usb4-port3: config error

However, when I boot without earlyprintk=xdbc, without the cable
attached, then I can attach the cable and:

$ echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc

will actually work, and it shows up on my host system:

[1023855.419430] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[1023855.419455] usb usb2-port3: config error
[1023859.491476] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[1023859.491487] usb usb2-port3: config error
[1023861.335436] usb usb2-port3: config error
[1023861.607476] usb 2-3: new SuperSpeed USB device number 7 using xhci_hcd
[1023861.627614] usb 2-3: LPM exit latency is zeroed, disabling LPM.
[1023861.627853] usb 2-3: New USB device found, idVendor=1d6b, idProduct=0010, bcdDevice= 0.10
[1023861.627855] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[1023861.627856] usb 2-3: Product: Linux USB Debug Target
[1023861.627857] usb 2-3: Manufacturer: Linux Foundation
[1023861.627858] usb 2-3: SerialNumber: 0001
[1023861.629344] usb_debug 2-3:1.0: xhci_dbc converter detected
[1023861.629532] usb 2-3: xhci_dbc converter now attached to ttyUSB0


Can you please see if you can repro and fix this?

This all was with current 5.16-rc3 on a tigerlake nuc.

Also, perhaps you can update the guide on what sort of setup/cables
etc.. you need when either the host or the client is a usb3.1 usb-c only
device.
