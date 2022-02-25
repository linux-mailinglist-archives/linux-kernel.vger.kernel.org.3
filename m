Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC364C4187
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiBYJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiBYJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:35:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9BC1F767A;
        Fri, 25 Feb 2022 01:35:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14FE660B1B;
        Fri, 25 Feb 2022 09:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED5EC340E7;
        Fri, 25 Feb 2022 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645781704;
        bh=abf0Kch29YhEwOBNj51lTk+PAfj/fNdrPzssmkFkqcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cp6DBjCSjkdqWtr+kYaxgG+OSWSYZmiIzWtpNlRwDK6SwIRYroop7daFC6tvAgyUm
         b9LXto5PtMZ9/p6wo967SOrCHF2bnIMIWA7AtJa67EGbf/etTe7JkYH/awSZOiA2/I
         gedfxZfUTPpXVI//iIkPjW/a0fHVZl3QXb+JDQOc=
Date:   Fri, 25 Feb 2022 10:35:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Report which option to enable for
 blacklisted PCI devices
Message-ID: <Yhiixm/iRlnF18B7@kroah.com>
References: <alpine.DEB.2.21.2202121646020.34636@angie.orcam.me.uk>
 <alpine.DEB.2.21.2202121706060.34636@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202121706060.34636@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 05:30:59PM +0000, Maciej W. Rozycki wrote:
> Provide information in the kernel log as to what configuration option to 
> enable for PCI UART devices that have been blacklisted in the generic 
> PCI 8250 UART driver and which have a dedicated driver available to 
> handle that has been disabled.  The rationale is there is no easy way 
> for the user to map a specific PCI vendor:device pair to an individual 
> dedicated driver while the generic driver has this information readily 
> available and it will likely be confusing that the generic driver does 
> not register such a port.
> 
> A message is then printed like:
> 
> serial 0000:04:00.3: ignoring port, enable SERIAL_8250_PERICOM to handle
> 
> when an affected device is encountered and the generic driver rejects it.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

I've applied patch 1 of this series, but this is really an odd one.

We don't do this for any other driver subsystem, so why is it really
needed?  What is so special about this driver that distros can't
just enable all of the drivers and all is good?  What is keeping those
drivers fromb eing enabled?

thanks,

greg k-h
