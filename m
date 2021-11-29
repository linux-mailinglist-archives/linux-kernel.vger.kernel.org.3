Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8454611F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhK2KXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:23:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:41774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhK2KV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:21:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="322171887"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="322171887"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 02:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="652957479"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2021 02:18:09 -0800
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>, Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] usb: core: Avoid doing warm reset on disconnect event
Message-ID: <745bd358-c34c-9deb-42e6-6f6a54fd3e2e@linux.intel.com>
Date:   Mon, 29 Nov 2021 12:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.2021 13.56, Kai-Heng Feng wrote:
> Unplugging USB device may cause an incorrect warm reset loop:
> [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
> [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
> [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
> [  143.039096] usb usb2-port3: link state change
> [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> [  143.039101] usb usb2-port3: do warm reset
> [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
> [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
> [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
> [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> 
> The warm reset is due to its PLS is in eSS.Inactive state. However, USB
> 3.2 spec table 10-13 mentions "Ports can be disabled by either a fault
> condition (disconnect event or other fault condition)", xHCI 1.2 spec
> table 5-27 also states that "This flag shall automatically be cleared to
> ‘0’ by a disconnect event or other fault condition." on PED.
> 
> So use CSC = 0 and PED = 0 as indication that device is disconnecting to
> avoid doing warm reset.

My understanding is that PED = 0 in case of disconnect, error (PLS=Inactive), or
during active reset signalling. See xHCI Figure 4-27: USB3 Root Hub Port State Machine.
signal states (0,0,0,0) are PP,CCS,PED,PR.

I'm looking at a similar case where Inactive link is reported at disconnect for a while
before missing terminations are detected and link finally goes to RxDetect.

If the port was reset immediately when Inactive link state was reported the port stays stuck 
in port reset.
This might have been related to the address0 locking issues recently fixed.

Anyway, to avoid the extra reset of a removed USB3 device I started polling the link state of
the Inactive link for some time before resetting it. This gives the link time to detect
missing terminations and go to RxDetect, and driver can skip the reset.

Planning on upstreaming it, patch is here:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=fix_avoid_disconnect_reset&id=72d20c026b7812d096c6b5184a3888894401c829

-Mathias
