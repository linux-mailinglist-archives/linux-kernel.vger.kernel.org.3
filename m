Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD13746307E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhK3KFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:05:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43002 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbhK3KFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:05:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCC9B817EB;
        Tue, 30 Nov 2021 10:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A1C53FC1;
        Tue, 30 Nov 2021 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638266545;
        bh=uvfhP3wDsqp2sLZLzqwLmrkaZ/VK2MfBZFqJU936Qv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mh2hfS6Gw67B48wTiqhi0UiqGeJhIoaRNt8K7v9Mg7lhHotZ2KWMk+gJhD389rOfp
         Ire0MgGCbIGSiOl3vEKEEti/fEvbOypcINfAQarVEEdFXOyG5FuhAgAnKLCIxM+i4X
         WcUxEHKSYNx7ZGuFMFzwfveaUpcO2hYxUV6LrpLx6JXgDSQ4ipzILen6pPizHD6VrR
         EGMW1nGS03CDjDqtqCSEKY8leolcZsEFkUWsOxl3kDPFEKk/80mJkfZIzKmiGttKLL
         TZ8UrxP/G6t4dVv9RMBuA5F7WbavuGvXzQFtCXYIem7VByocKeWRSOWYVUhPMA2CXM
         s1Qn2jP41qcRw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mrzxZ-0006Mo-9O; Tue, 30 Nov 2021 11:02:02 +0100
Date:   Tue, 30 Nov 2021 11:02:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCHv4 0/7] Serial port generic PM to fix 8250 PM
Message-ID: <YaX2mbUv9Yv3icl4@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:41:56AM +0200, Tony Lindgren wrote:
> Hi,
> 
> Here are v4 patches for serial port generic PM. The scope has now expanded
> a bit from the earlier attempts to get rid of pm_runtime_irq_safe() for
> the 8250_omap driver. I've now picked up three patches from Andy's earlier
> generic serial port PM series.

So this looks like another step in the right direction but there are
still some missing pieces.

First, you need to provide an overview of the design decisions made here
in cover letter. It's currently spread out over several patches and
those commit messages still do not hold all the details.

Specifically, it looks like tx can still stall indefinitely if the
autosuspend timer fires. This can happen at low baud rates and also when
using flow control.

It also looks like the expected calls to update the last busy timestamp
might be missing from the interrupt handlers or related helpers.

Please also describe how this interacts with the console. Is a console
port now never suspended? Where is that enforced? The final patch
appears to rely on this when it drops PM calls from for example some
console poll callbacks.

> Changes since v3:
> - Pick three patches from Andy's earlier serial port PM series to handle
>   issues pointed out by Johan

Please also be more specific here when sending an updated series. I
can't really tell what has changed from just this one sentence.

Johan
