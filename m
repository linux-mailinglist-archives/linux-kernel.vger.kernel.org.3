Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC546E349
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhLIHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:41:02 -0500
Received: from muru.com ([72.249.23.125]:36364 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhLIHlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:41:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A167F80A3;
        Thu,  9 Dec 2021 07:38:08 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:37:25 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCHv4 0/7] Serial port generic PM to fix 8250 PM
Message-ID: <YbGyNW2EQlA/+VIg@atomide.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <YaX2mbUv9Yv3icl4@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaX2mbUv9Yv3icl4@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [211130 10:03]:
> Specifically, it looks like tx can still stall indefinitely if the
> autosuspend timer fires. This can happen at low baud rates and also when
> using flow control.

Yeah the TX part is still problematic. Note that this is purely because
of current Linux serial layers implementation, and not because of any
hardware reasons.

Even after this series we still rely on serial8250_rpm_get_tx() and
serial8250_rpm_put_tx() to decipher if we can idle the port..

If anybody has good ideas where we can add the serial core TX related
paired runtime PM calls please let me know :)

For TX DMA, we should not do runtime PM put until at the DMA callback
function when completed.

Regards,

Tony
