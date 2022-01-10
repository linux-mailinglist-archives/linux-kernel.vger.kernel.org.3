Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5D489EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiAJSB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:01:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53788 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiAJSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:01:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7F661138;
        Mon, 10 Jan 2022 18:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F1AC36AE3;
        Mon, 10 Jan 2022 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641837686;
        bh=DoTf+6WY2kq8d+zpjxO2hPSikwhqOtZwZjBC82nH388=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FZEY6x8zqS7v0vB51A2XHPRLnEgw5WFHYE/h6K/Ps85eJz0w4AZt6O1As5AxyFeTs
         wVuLKWpHVCU0yPycU4BLhEdRGK/bnHsZV9oTtzbwLbs0diL414j5YvAcC+JWToHJiR
         hk7f/goo93DFtlkrzWjjezrlGwa/87/B2W4PHptcfF/jBNLpxBWPAnA6wWWymPKif0
         AWwOqOTC6DPbclnwWsDXjQRE3mKC5LcnVwJ2STwg/FPm8jzmEMbrNBEO/L5JkUqMaa
         /tGTjCYUHJtynrMpbzfY1zMQ9i+50YR2IBp9Y/YpUigIYjfKWe4zturx9VDRpywhMf
         TPe7UNLGbJKFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5EDF45C16E0; Mon, 10 Jan 2022 10:01:26 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:01:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     tglx@linutronix.de, mark.rutland@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, peterz@infradead.org, mtosatti@redhat.com,
        frederic@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v4 2/2] Documentation: core-api: entry: Add comments
 about nesting
Message-ID: <20220110180126.GF947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220110105044.94423-1-nsaenzju@redhat.com>
 <20220110105044.94423-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110105044.94423-2-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:50:44AM +0100, Nicolas Saenz Julienne wrote:
> The topic of nesting and reentrancy in the context of early entry code
> hasn't been addressed so far. So do it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> Changes since v3:
>  - Introduce Paul's rewording suggestions
> 
>  Documentation/core-api/entry.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
> index c6f8e22c88fe..e12f22ab33c7 100644
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -105,6 +105,8 @@ has to do extra work between the various steps. In such cases it has to
>  ensure that enter_from_user_mode() is called first on entry and
>  exit_to_user_mode() is called last on exit.
>  
> +Do not nest syscalls. Nested systcalls will cause RCU and/or context tracking
> +to print a warning.
>  
>  KVM
>  ---
> @@ -121,6 +123,8 @@ Task work handling is done separately for guest at the boundary of the
>  vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
>  the work handled on return to user space.
>  
> +Do not nest KVM entry/exit transitions because doing so is nonsensical.
> +
>  Interrupts and regular exceptions
>  ---------------------------------
>  
> @@ -180,6 +184,16 @@ before it handles soft interrupts, whose handlers must run in BH context rather
>  than irq-disabled context. In addition, irqentry_exit() might schedule, which
>  also requires that HARDIRQ_OFFSET has been removed from the preemption count.
>  
> +Even though interrupt handlers are expected to run with local interrupts
> +disabled, interrupt nesting is common from an entry/exit perspective. For
> +example, softirq handling happens within an irqentry_{enter,exit}() block with
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
> @@ -259,3 +273,7 @@ and for e.g. a debug exception it can look like this:
>  
>  There is no combined irqentry_nmi_if_kernel() function available as the
>  above cannot be handled in an exception-agnostic way.
> +
> +NMIs can happen in any context. For example, an NMI-like exception triggered
> +while handling an NMI. So NMI entry code has to be reentrant and state updates
> +need to handle nesting.
> -- 
> 2.34.1
> 
