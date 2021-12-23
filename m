Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEE47E896
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbhLWUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:00:53 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43989 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235944AbhLWUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:00:49 -0500
Received: (qmail 983630 invoked by uid 1000); 23 Dec 2021 15:00:47 -0500
Date:   Thu, 23 Dec 2021 15:00:47 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] notifier: Return an error when a callback has
 already been registered
Message-ID: <YcTVb4thNW4RmEHn@rowland.harvard.edu>
References: <20211202133601.23527-1-bp@alien8.de>
 <YcSWNdUBS8A2ZB3s@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcSWNdUBS8A2ZB3s@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 04:31:01PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Return -EEXIST when a notifier callback has already been registered on a
> notifier chain.
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

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  kernel/notifier.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index b8251dc0bc0f..ba005ebf4730 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -20,12 +20,13 @@ BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
>   */
>  
>  static int notifier_chain_register(struct notifier_block **nl,
> -		struct notifier_block *n)
> +				   struct notifier_block *n)
>  {
>  	while ((*nl) != NULL) {
>  		if (unlikely((*nl) == n)) {
> -			WARN(1, "double register detected");
> -			return 0;
> +			WARN(1, "notifier callback %ps already registered",
> +			     n->notifier_call);
> +			return -EEXIST;
>  		}
>  		if (n->priority > (*nl)->priority)
>  			break;
> @@ -134,7 +135,7 @@ static int notifier_call_chain_robust(struct notifier_block **nl,
>   *
>   *	Adds a notifier to an atomic notifier chain.
>   *
> - *	Currently always returns zero.
> + *	Returns 0 on success, %-EEXIST on error.
>   */
>  int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
>  		struct notifier_block *n)
> @@ -216,7 +217,7 @@ NOKPROBE_SYMBOL(atomic_notifier_call_chain);
>   *	Adds a notifier to a blocking notifier chain.
>   *	Must be called in process context.
>   *
> - *	Currently always returns zero.
> + *	Returns 0 on success, %-EEXIST on error.
>   */
>  int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
>  		struct notifier_block *n)
> @@ -335,7 +336,7 @@ EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
>   *	Adds a notifier to a raw notifier chain.
>   *	All locking must be provided by the caller.
>   *
> - *	Currently always returns zero.
> + *	Returns 0 on success, %-EEXIST on error.
>   */
>  int raw_notifier_chain_register(struct raw_notifier_head *nh,
>  		struct notifier_block *n)
> @@ -406,7 +407,7 @@ EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
>   *	Adds a notifier to an SRCU notifier chain.
>   *	Must be called in process context.
>   *
> - *	Currently always returns zero.
> + *	Returns 0 on success, %-EEXIST on error.
>   */
>  int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
>  		struct notifier_block *n)
> -- 
> 2.29.2
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
