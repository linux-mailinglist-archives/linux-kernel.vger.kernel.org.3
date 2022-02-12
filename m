Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498C4B33EC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiBLImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:42:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiBLImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:42:00 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840A82657B;
        Sat, 12 Feb 2022 00:41:50 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B90FE92009D; Sat, 12 Feb 2022 09:41:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B50CD92009C;
        Sat, 12 Feb 2022 08:41:48 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:48 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Cc-ing the general contact point at EndRun for 1/2 of this series in case 
the original submitters of the affected code are not there anymore after 
those 7 years.

 Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.  
As the change for the default FIFO rx trigger level has been already 
merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels 
for OxSemi 950 devices") only one patch of the original series remains.  

 However in the course of preparing v3 of that change I have noticed that 
the EndRun device is actually also an OxSemi 952 device in disguise (note 
that the OxSemi chips have fully customer-programmable PCI vendor:device 
ID values).  Therefore it requires a similar fix to the base baud rate as 
with commit 6cbe45d8ac93 ("serial: 8250: Correct the clock for OxSemi 
PCIe devices"), and also duplicate code can be removed.

 I have therefore added a fix for the EndRun device as 1/2 in this version 
and the original outstanding change is now 2/2, updated accordingly, also 
for a change in the handling of the MCR made with commit b4a29b94804c 
("serial: 8250: Move Alpha-specific quirk out of the core").

 As noted in the course of v2 review I don't believe the Linux kernel has 
a policy for any of its subsystems to require rewriting parts of existing 
code to fix bugs or internal API deficiencies as a prerequisite for bug 
fix (or even functional improvement) acceptance.  Therefore I consider 
this v3 of the series final and I am not going to continue pursuing this 
submission any further unless there is an actual technical defect (a bug, 
a coding style issue, etc.) within this series itself.

 Please apply.

  Maciej
