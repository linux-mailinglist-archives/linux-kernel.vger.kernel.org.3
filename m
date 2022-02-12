Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC844B33E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiBLIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:41:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiBLIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:41:35 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF8226553;
        Sat, 12 Feb 2022 00:41:32 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B31B992009E; Sat, 12 Feb 2022 09:41:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AF85E92009B;
        Sat, 12 Feb 2022 08:41:30 +0000 (GMT)
Date:   Sat, 12 Feb 2022 08:41:30 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250: Correct basic issues with the PCI
 blacklist
Message-ID: <alpine.DEB.2.21.2202052214360.34636@angie.orcam.me.uk>
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
