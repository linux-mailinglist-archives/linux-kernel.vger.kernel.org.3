Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A97472D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhLMNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbhLMNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:24:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618BCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:24:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mwlJx-0008Sf-9N; Mon, 13 Dec 2021 14:24:49 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [BUG] mtd: cfi_cmdset_0002: write regression since v4.17-rc1
To:     linux-mtd@lists.infradead.org, ikegami@allied-telesis.co.jp,
        Joakim.Tjernlund@infinera.com, miquel.raynal@bootlin.com,
        vigneshr@ti.com, richard@nod.at, ikegami.t@gmail.com
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Shaohui.Xie@nxp.com
Message-ID: <b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de>
Date:   Mon, 13 Dec 2021 14:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been investigating a breakage on a PowerPC MPC8313: The SoC is connected
via the "Enhanced Local Bus Controller" to a 8-bit-parallel S29GL064N flash,
which is represented as a memory-mapped cfi-flash.

The regression began in v4.17-rc1 with

  dfeae1073583 ("mtd: cfi_cmdset_0002: Change write buffer to check correct value")

and causes all flash write accesses on the hardware to fail. Example output
after v5.1-rc2[1]:

  root@host:~# mount -t jffs2 /dev/mtdblock0 /mnt
  MTD do_write_buffer_wait(): software timeout, address:0x000c000b.
  jffs2: Write clean marker to block at 0x000c0000 failed: -5

This issue still persists with v5.16-rc. Reverting aforementioned patch fixes
it, but I am still looking for a change that keeps both Tokunori's and my
hardware happy.

What Tokunori's patch did is that it strengthened the success condition
for flash writes:

 - Prior to the patch, DQ polling was done until bits
   stopped toggling. This was taken as an indicator that the write succeeded
   and was reported up the stack. i.e. success condition is chip_ready()

 - After the patch, polling continues until the just written data is
   actually read back, i.e. success condition is chip_good()

This new condition never holds for me, when DQ stabilizes, it reads 0xFF,
never the just written data. The data is still written and can be read back
on subsequent reads, just not at that point of time in the poll loop.

We haven't had write issues for the years predating that patch. As the
regression has been mainline for a while, I am wondering what about my setup
that makes it pop up here, but not elsewhere?

I consulted the data sheet[2] and found Figure 27, which describes DQ polling
during embedded algorithms. DQ switches from status output to "True" (I assume
True == all bits set == 0xFF) until CS# is reasserted. 

I compared with another chip's datasheet, and it (Figure 8.4) doesn't describe
such an intermittent "True" state. In any case, the driver polls a few hundred
times, however, before giving up, so there should be enough CS# toggles.


Locally, I'll revert this patch for now. I think accepting 0xFF as a success
condition may be appropriate, but I don't yet have the rationale to back it up.

I am investigating this some more, probably with a logic trace, but I wanted
to report this in case someone has pointers and in case other people run into
the same issue.


Cheers,
Ahmad

[1] Prior to d9b8a67b3b95 ("mtd: cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer") 
    first included with v5.1-rc2, failing writes just hung indefinitely in kernel space.
    That's fixed, but the writes still fail.

[2]: 001-98525 Rev. *B, https://www.infineon.com/dgdl/Infineon-S29GL064N_S29GL032N_64_Mbit_32_Mbit_3_V_Page_Mode_MirrorBit_Flash-DataSheet-v03_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed556fd548b

[3]: https://www.mouser.com/datasheet/2/268/SST39VF1601C-SST39VF1602C-16-Mbit-x16-Multi-Purpos-709008.pdf
     Note that "true data" means valid data here, not all bits one.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
