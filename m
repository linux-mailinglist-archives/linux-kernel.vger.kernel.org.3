Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC8505BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbiDRPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbiDRPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:40 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD6D8B0A;
        Mon, 18 Apr 2022 08:27:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 35A2D92009E; Mon, 18 Apr 2022 17:27:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2E95F92009C;
        Mon, 18 Apr 2022 16:27:16 +0100 (BST)
Date:   Mon, 18 Apr 2022 16:27:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] serial: 8250: Correct the clock for EndRun PTP/1588
 PCIe device
In-Reply-To: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204181515270.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EndRun PTP/1588 dual serial port device is based on the Oxford 
Semiconductor OXPCIe952 UART device with the PCI vendor:device ID set 
for EndRun Technologies and is therefore driven by a fixed 62.5MHz clock 
input derived from the 100MHz PCI Express clock.  The clock rate is 
divided by the oversampling rate of 16 as it is supplied to the baud 
rate generator, yielding the baud base of 3906250.

Replace the incorrect baud base of 4000000 with the right value of 
3906250 then, complementing commit 6cbe45d8ac93 ("serial: 8250: Correct 
the clock for OxSemi PCIe devices").

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 1bc8cde46a159 ("8250_pci: Added driver for Endrun Technologies PTP PCIe card.")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes from v4:

- Reorder as 2/5 (from 1/5).

New change in v4, factored out from 2/5.
---
 drivers/tty/serial/8250/8250_pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

linux-serial-8250-endrun-pcie-clock.diff
Index: linux-macro/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-macro/drivers/tty/serial/8250/8250_pci.c
@@ -2667,7 +2667,7 @@ enum pci_board_num_t {
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_plx_romulus,
-	pbn_endrun_2_4000000,
+	pbn_endrun_2_3906250,
 	pbn_oxsemi,
 	pbn_oxsemi_1_3906250,
 	pbn_oxsemi_2_3906250,
@@ -3195,10 +3195,10 @@ static struct pciserial_board pci_boards
 	* signal now many ports are available
 	* 2 port 952 Uart support
 	*/
-	[pbn_endrun_2_4000000] = {
+	[pbn_endrun_2_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 2,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
@@ -4128,7 +4128,7 @@ static const struct pci_device_id serial
 	*/
 	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_endrun_2_4000000 },
+		pbn_endrun_2_3906250 },
 	/*
 	 * Quatech cards. These actually have configurable clocks but for
 	 * now we just use the default.
