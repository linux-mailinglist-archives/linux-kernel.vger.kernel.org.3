Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A76E4666EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347952AbhLBPpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:45:20 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59735 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232833AbhLBPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:45:18 -0500
Received: (qmail 391459 invoked by uid 1000); 2 Dec 2021 10:41:55 -0500
Date:   Thu, 2 Dec 2021 10:41:55 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notifier: Return an error when a callback has already
 been registered
Message-ID: <YajpQ/dA7h3QnkCR@rowland.harvard.edu>
References: <20211202133601.23527-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202133601.23527-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:36:01PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Add another indirection to the notifiers callback registration path
> which does only the error checking and propagates the proper error value
> to the callers instead of returning only 0.
> 
> This should avoid any homegrown registration tracking at the callsite
> like
> 
>   https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com
> 
> for example.
> 
> This version is an alternative of
> 
>   https://lore.kernel.org/r/20211108101157.15189-1-bp@alien8.de
> 
> which needed to touch every caller not checking the registration
> routine's return value.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  kernel/notifier.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index b8251dc0bc0f..0820a156ce83 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -19,14 +19,12 @@ BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
>   *	are layered on top of these, with appropriate locking added.
>   */
>  
> -static int notifier_chain_register(struct notifier_block **nl,
> -		struct notifier_block *n)
> +static int __notifier_chain_register(struct notifier_block **nl,
> +				     struct notifier_block *n)
>  {
>  	while ((*nl) != NULL) {
> -		if (unlikely((*nl) == n)) {
> -			WARN(1, "double register detected");
> -			return 0;
> -		}
> +		if (unlikely((*nl) == n))
> +			return -EEXIST;
>  		if (n->priority > (*nl)->priority)
>  			break;
>  		nl = &((*nl)->next);
> @@ -36,6 +34,18 @@ static int notifier_chain_register(struct notifier_block **nl,
>  	return 0;
>  }
>  
> +static int notifier_chain_register(struct notifier_block **nl,
> +				   struct notifier_block *n)
> +{
> +	int ret = __notifier_chain_register(nl, n);
> +
> +	if (ret == -EEXIST)
> +		WARN(1, "notifier callback %ps already registered",
> +			n->notifier_call);
> +
> +	return ret;
> +}

How about doing this instead?

@@ -24,8 +24,9 @@ BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 {
 	while ((*nl) != NULL) {
 		if (unlikely((*nl) == n)) {
> -			WARN(1, "double register detected");
> -			return 0;
> +			WARN(1, "notifier callback %ps already registered",
> +					n->notifier_call);
> +			return -EEXIST;
 		}
 		if (n->priority > (*nl)->priority)
 			break;

A patch that adds three new lines of code has got to be simpler than and 
preferable to a patch that adds about eleven lines (including a whole new 
function), right?

Alan Stern
