Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6180C49F50F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbiA1IYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:24:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35908 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiA1IYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:24:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AD23A21709;
        Fri, 28 Jan 2022 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643358272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBfvXy3ZkvZC+Pjz9NX1kzPf99ePmDeDzhvOPegq7WU=;
        b=rGQCk77r/B67R+UZRE1gIbXtbwNWnnWnKh+X43anlGSQ+5npFgsNVP1u2+A9UnSt3dlSoP
        WEfcsjcesj77YLW0qehRUSowxstkRqest3cTkhmkys8prh6rhn3Mt/Le1VMsq2LConRgIC
        P+s2kwkl1Rhlo/odqiLY2rxxx/igFx0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55F74A3B8D;
        Fri, 28 Jan 2022 08:24:32 +0000 (UTC)
Date:   Fri, 28 Jan 2022 09:24:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] panic: Add panic_in_progress helper
Message-ID: <YfOoPbLGfrhYipqG@alley>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-2-stephen.s.brennan@oracle.com>
 <YfKtZUiLWkrUIkwn@alley>
 <2fa9246d-eddf-dd4e-17c6-8d6565237afa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa9246d-eddf-dd4e-17c6-8d6565237afa@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 08:02:19, Stephen Brennan wrote:
> On 1/27/22 06:34, Petr Mladek wrote:
> > On Wed 2022-01-26 15:02:33, Stephen Brennan wrote:
> > > This helper will be used in printk code to avoid deadlocks during
> > > panic().
> > > 
> > > Suggested-by: Petr Mladek <pmladek@suse.com>
> > > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > Best Regards,
> > Petr
> 
> Hi Petr,
> 
> Thanks for the review, however over the night I received two kernel test
> robot emails. One indicating a new build error caused by this change on m68k
> arch, and the other adding a new warning on riscv. From what I can tell, the
> issues are circular dependencies in #includes. So it may be better to either
> return to the macro, or move this static inline down to
> kernel/printk/printk.c. I think moving it into kernel/printk/printk.c makes
> most sense given that the macro requires the correct #includes anyway.

Yes, I prefer moving the inline down to printk.c. It looks a bit
cleaner than the macro that would not work without another include.

Please, explain this in the commit message.

Best Regards,
Petr
