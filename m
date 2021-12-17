Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B57479332
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhLQR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhLQR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:56:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04BFC061574;
        Fri, 17 Dec 2021 09:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18DC1CE2607;
        Fri, 17 Dec 2021 17:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36499C36AE7;
        Fri, 17 Dec 2021 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763805;
        bh=KCW1lWZbjvReZP/7JHwJgi2VLsdq6dNTG2h9PueIXys=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lBl8FVniEwJfkBmgdSXJFmxAheEHcfrVw/KdDB+ms3HfMEGVNQ7Udc0tHWXOJ+0Dz
         7Kjc/ixxEYm6+B7KlAnFE72+CxHqlA7clgt/Yg7kIGzJFKOdtHT4eTob82aGJgjxSn
         GTIpnE1tSX70kd8XAOWJtnZk/2V0xZ+bIoJgKGSSiBteTVJ9NUmYhU36dHeyTIw5S6
         V3UlJPhGlxRuE+WueVoPLbsqryiW6MwHOOJsmqvZUygA7JYIBvY+GOb60l76rCDWXH
         n+3EJ0meGUWqznHNexIqX969cErMbsPErb376bShbzm6DVvZoy+IKPJmUOl5FGpd+K
         WotDMYD4jYgnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 000EE5C0610; Fri, 17 Dec 2021 09:56:44 -0800 (PST)
Date:   Fri, 17 Dec 2021 09:56:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     tglx@linutronix.de, mark.rutland@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, peterz@infradead.org, mtosatti@redhat.com,
        frederic@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 2/2] Documentation: core-api: entry: Add comments
 about nesting
Message-ID: <20211217175644.GZ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211217105753.892855-1-nsaenzju@redhat.com>
 <20211217105753.892855-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217105753.892855-2-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:57:53AM +0100, Nicolas Saenz Julienne wrote:
> The topic of nesting and reentrancy in the context of early entry code
> hasn't been addressed so far. So do it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Looks good!  Just a few small suggestions below.

							Thanx, Paul

> ---
> 
> NOTE: I moved this into a separate patch to simplify the review.
> 
>  Documentation/core-api/entry.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
> index 3f80537f2826..f665f201ead0 100644
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -105,6 +105,8 @@ has to do extra work between the various steps. In such cases it has to
>  ensure that enter_from_user_mode() is called first on entry and
>  exit_to_user_mode() is called last on exit.
>  
> +Syscalls shouldn't nest. If it were to happen, RCU / context tracking will
> +catch the misbehavior and print out a warning.

How about like this?

Do not nest syscalls.  Nested systcalls will cause RCU and/or context
tracking to print a warning.

>  KVM
>  ---
> @@ -121,6 +123,9 @@ Task work handling is done separately for guest at the boundary of the
>  vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
>  the work handled on return to user space.
>  
> +Nesting doesn't make sense in the context of KVM entry/exit transitions, it
> +shouldn't happen.

Like this?

Do not nest KVM entry/exit transitions because doing so is nonsensical.

>  Interrupts and regular exceptions
>  ---------------------------------
>  
> @@ -180,6 +185,16 @@ before it handles soft interrupts, whose handlers must run in BH context rather
>  than irq-disabled context. In addition, irqentry_exit() might schedule, which
>  also requires that HARDIRQ_OFFSET has been removed from the preemption count.
>  
> +Even though interrupt handlers are expected to run with local interrupts
> +disabled, interrupt nesting is common from an entry/exit perspective. For
> +example, softirq handling happens within an irqentry_{enter,exit}() block, with

The last comma on the above line needs to be removed, so just a space
character between "block" and "with".

> +local interrupts enabled. Also, although uncommon, nothing prevents an
> +interrupt handler from re-enabling interrupts.
> +
> +Interrupt entry/exit code doesn't strictly need to handle reentrancy, since it
> +runs with local interrupts disabled. But NMIs can happen anytime, and a lot of
> +the entry code is shared between the two.
> +
>  NMI and NMI-like exceptions
>  ---------------------------
>  
> @@ -259,3 +274,7 @@ and for e.g. a debug exception it can look like this:
>  
>  There is no combined irqentry_nmi_if_kernel() function available as the
>  above cannot be handled in an exception-agnostic way.
> +
> +NMIs can happen in any context. For example, an NMI-like exception triggered
> +while handling an NMI. So NMI entry code has to be reentrant and state updates
> +need to handle nesting.
> -- 
> 2.33.1
> 
