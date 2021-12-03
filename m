Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA4E467A57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381813AbhLCPgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:36:54 -0500
Received: from mxout1-ec2-va.apache.org ([3.227.148.255]:54624 "EHLO
        mxout1-ec2-va.apache.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381772AbhLCPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:36:50 -0500
Received: from mail.apache.org (mailroute1-lw-us.apache.org [207.244.88.153])
        by mxout1-ec2-va.apache.org (ASF Mail Server at mxout1-ec2-va.apache.org) with SMTP id 4488C3F2FB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:33:25 +0000 (UTC)
Received: (qmail 95748 invoked by uid 99); 3 Dec 2021 15:33:25 -0000
Received: from ec2-52-204-25-47.compute-1.amazonaws.com (HELO mailrelay1-ec2-va.apache.org) (52.204.25.47)
    by apache.org (qpsmtpd/0.29) with ESMTP; Fri, 03 Dec 2021 15:33:25 +0000
Received: from [10.23.2.106] (unknown [51.154.28.112])
        by mailrelay1-ec2-va.apache.org (ASF Mail Server at mailrelay1-ec2-va.apache.org) with ESMTPSA id 4B3E23E977;
        Fri,  3 Dec 2021 15:33:24 +0000 (UTC)
Message-ID: <d9fb7e699dd0d8528a3dcfd83ad33614bde4373e.camel@apache.org>
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
From:   Robert Munteanu <rombert@apache.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, tiwai@suse.com,
        regressions@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Dec 2021 16:33:23 +0100
In-Reply-To: <YajjhwMDkX2CyrQD@kroah.com>
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
         <YajjhwMDkX2CyrQD@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-02 at 16:17 +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 02, 2021 at 03:55:44PM +0100, Robert Munteanu wrote:
> > Hi,
> > 
> > After updating from kernel 5.14.11 to 5.14.14 I am seeing the
> > following
> > problem:
> 
> Can you run 'git bisect' between those kernel versions to get the
> offending commit located?  It shouldn't take that long as there's not a
> lot of changes there.

A full bisect run, as suspected in other messages, results in

e54abefe703ab7c4e5983e889babd1447738ca42 is the first bad commit
commit e54abefe703ab7c4e5983e889babd1447738ca42
Author: Pavankumar Kondeti <pkondeti@codeaurora.org>
Date:   Fri Oct 8 12:25:46 2021 +0300

    xhci: Fix command ring pointer corruption while aborting a command
    
    commit ff0e50d3564f33b7f4b35cadeabd951d66cfc570 upstream.
    
    The command ring pointer is located at [6:63] bits of the command
    ring control register (CRCR). All the control bits like command
stop,
    abort are located at [0:3] bits. While aborting a command, we read
the
    CRCR and set the abort bit and write to the CRCR. The read will
always
    give command ring pointer as all zeros. So we essentially write
only
    the control bits. Since we split the 64 bit write into two 32 bit
writes,
    there is a possibility of xHC command ring stopped before the upper
    dword (all zeros) is written. If that happens, xHC updates the
upper
    dword of its internal command ring pointer with all zeros. Next
time,
    when the command ring is restarted, we see xHC memory access
failures.
    Fix this issue by only writing to the lower dword of CRCR where all
    control bits are located.
    
    Cc: stable@vger.kernel.org
    Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
    Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
    Link:
https://lore.kernel.org/r/20211008092547.3996295-5-mathias.nyman@linux.intel.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/usb/host/xhci-ring.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

I will try the patch linked by Matias as soon as the openSUSE kernel
build is complete.

Thanks,
Robert
