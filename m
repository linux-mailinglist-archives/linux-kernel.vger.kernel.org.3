Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63A9463154
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhK3Kps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:45:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36664 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhK3Kpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:45:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1EF4CE0F75;
        Tue, 30 Nov 2021 10:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7D4C53FC7;
        Tue, 30 Nov 2021 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638268943;
        bh=lW7rNqsKnrpPntFaevhbx0JIKxnZ+u2HzbZCCctOQ/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXLyXtdqvEjzfFhmQfya5cH9eJvY7CTV6LI5Z6snZUPmNUPxQoxl6M4scdoRRp41O
         nRYRUNncO84VjIUyOJALIs5KY/b9uuKzSqaTlqtR083BV3EURrbscqygNED5aprBSm
         NGdW/fbQDmz0koToB192wtMmk5qNVvduy0FtF+eZ52UrCYX9DkSVSX72f64jkUj53V
         knmDJwlIZq9Kwl/s0UZfTvDAk2FS8SJpAJwtJRqwjlIU3QKbbJGDiAwlRYKXF3LNRZ
         QuKcYEHx7TvkeYmOmPANdYArClrp8bQKAa1sMm72yuFvImiGE5C5wy8dDA16fyWqkP
         59MUdrFvs0VSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms0aG-0006d9-MN; Tue, 30 Nov 2021 11:42:00 +0100
Date:   Tue, 30 Nov 2021 11:42:00 +0100
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
Subject: Re: [PATCH 6/7] serial: 8250_omap: Drop the use of
 pm_runtime_irq_safe()
Message-ID: <YaX/+CkUM+hjVqjP@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-7-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-7-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:42:02AM +0200, Tony Lindgren wrote:
> We can finally drop the pm_runtime_irq_safe() usage for 8250_omap driver.
> 
> We already have the serial layer RX wake path fixed for power management.
> We no longer allow deeper idle states unless the kernel console has been
> detached, and we require that the RX wakeirq is configured.
> 
> For TX path, we now use the prep_tx() and uart_flush_tx() calls.

Looks like this commit message is outdated. These functions no longer
exist.

> To drop pm_runtime_irq_safe(), we remove all PM runtime calls from the
> interrupt context. If we ever see an interrupt for an idled port, we just
> bail out.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Johan
