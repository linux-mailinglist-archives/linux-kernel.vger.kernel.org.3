Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D324B36D3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiBLRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:30:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiBLRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:30:53 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26D33240A4;
        Sat, 12 Feb 2022 09:30:49 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 501A592009C; Sat, 12 Feb 2022 18:30:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4616092009B;
        Sat, 12 Feb 2022 17:30:48 +0000 (GMT)
Date:   Sat, 12 Feb 2022 17:30:48 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250: Correct basic issues with the PCI
 blacklist
Message-ID: <alpine.DEB.2.21.2202121646020.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_HDRS_LCASE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 This v2 of the patch series adds missing filler member initialisers for 
blacklist entries using the PCI_DEVICE rather than PCI_VDEVICE macro that 
cause "initializer element is not computable at load time" compilation 
errors in some configurations, which have escaped my verification.

 An upside is I have noticed PARPORT_SERIAL (or indeed PARPORT_PC) is not 
selectable with numerous PCI platforms like RISC-V meaning that PC-style 
PCI parallel port hardware cannot be used with them even though there's no 
reason for that.  The only PCI platforms that actually cannot make use of 
such hardware are those newer PCIe systems that have no support for I/O 
cycles in the host bridge with the only actual specimen known to me being 
the POWER9 PHB4 device, so we ought to enable PARPORT_PC/PARPORT_SERIAL 
support for PCI systems in the general case.  I'll post a fix separately.

 The original cover letter continues.

 In the course of investigating whether support code for OxSemi PCIe UARTs 
could be factored out from the common 8250 PCI UART driver, which has been 
previously requested by Andy (cc-ed), I have noticed that the Kconfig help 
text for several device-specific UART drivers previously factored out is 
incorrect in that it claims that those dedicated drivers are required for 
extra features of the respective devices, while actually the blacklist 
entries within the common driver make them require those dedicated drivers 
even for standard features, as the common driver now refuses to handle 
them.

 Also it may be unclear for the user from a specific PCI device ID of an 
affected PCI UART device which dedicated driver has to be configured in to 
handle it, so make the blacklist entries include that information to be 
printed if a device is encountered that cannot be handled because its 
dedicated driver has been excluded from configuration while the common 
driver refuses to handle it.

 See the respective change descriptions for further details.  Please 
apply.

  Maciej
