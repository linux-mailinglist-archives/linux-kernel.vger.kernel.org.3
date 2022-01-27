Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF449E9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbiA0SLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:11:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54622 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244950AbiA0SKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:10:45 -0500
Received: from callcc.thunk.org (static-74-43-95-34.fnd.frontiernet.net [74.43.95.34])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20RIAF2r014158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 13:10:17 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 64CBB420385; Thu, 27 Jan 2022 13:10:15 -0500 (EST)
Date:   Thu, 27 Jan 2022 13:10:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Costa <wcosta@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Message-ID: <YfLgB/WsQcePTXlQ@mit.edu>
References: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
 <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com>
 <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
 <YfELyq5AmxiZxjme@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfELyq5AmxiZxjme@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:52:26AM +0100, Greg Kroah-Hartman wrote:
> 
> Let me revert this for now.  And no new config options please, this
> should "just work".

I'm not sure the commit is actually worth the extra complexity, to be
honest.  The reason for the FIFO is to improve interrupt latency, and
in the console write path, we're busy looping.  There is something
seriously wrong serial port of the HP Proliant DL380 Gen 9.  Per the
commit description for 5021d709b31b: ("tty: serial: Use fifo in 8250
console driver"), on the "fast machine" (read: the one with a
propertly working serial port), we were getting over 10 KB/s without
the patch.  And on the "slow machine" it was getting only 2.5 KB/s,
and with the patch it only improved things by 25% (so only 3.1 KB/s).

I assume what must be going on is this machine is emulating the UART
and is extremely slow to set the Trasmitter Holding Register Empty
(THRE) bit after the UART is finished sending the byte out the serial
port.

So we're adding a lot of complexity for what is obviously broken
hardware, and we risk breaking the serial console for other machines
with a properly implemented serial port.  How common are UART's which
are broken in this way?  Is it unique to the HP Proliant DL380 Gen 9?
Or is a common misimplementation which is unfortunately quite common?
If it's the former, maybe the FIFO hack should only be done via a
quirk?

If it's really the case that the HP Proliant's nasty performance is
due to a badly implemented emulation layer, is there any way to do
better, perhaps via a more direct path to the serial port?  Or is the
problem that the serial port on this motherboard is connected via some
super-slow internal path and it would be faster if you could talk to
it directly via a UEFI call, or some other mechanism?  Whether it's
2.5 KB/s or 3.1 KB/s, it's really quite pathetic....

     	      	     	   	       - Ted
