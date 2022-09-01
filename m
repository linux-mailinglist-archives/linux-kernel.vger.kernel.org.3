Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4B5A9AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiIAOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiIAOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:42:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021E2CDCC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:42:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C281021A58;
        Thu,  1 Sep 2022 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662043319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QrSvIq+kMZL8ZVB3bc4dE7hfMkUNEf2GZlOwWQRLNMg=;
        b=tK4OC23lz34I+UBj+52pNeXDN9zw3iVeO0Rnj+zYKdqSUoGfERYQ8svV0rbF9JyP2peWw7
        d6mTP/gNtWuksEUvKtJFsJYQbQXRPFfBpkkGEcjTRttWMjjA5BQLke5WLeljzmC/GZdYka
        VOK9Lq3WK6VISl+meb3ja9b10RJcNl4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6ED413A79;
        Thu,  1 Sep 2022 14:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wg2EJrfEEGO/YwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 14:41:59 +0000
Date:   Thu, 1 Sep 2022 16:41:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/8] mm/debug: Provide VM_WARN_ON_IRQS_ENABLED()
Message-ID: <YxDEt4JbcgQzEpjj@dhcp22.suse.cz>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
 <20220825164131.402717-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164131.402717-5-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-08-22 18:41:27, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Some places in the VM code expect interrupts disabled, which is a valid
> expectation on non-PREEMPT_RT kernels, but does not hold on RT kernels in
> some places because the RT spinlock substitution does not disable
> interrupts.
> 
> To avoid sprinkling CONFIG_PREEMPT_RT conditionals into those places,
> provide VM_WARN_ON_IRQS_ENABLED() which is only enabled when VM_DEBUG=y and
> PREEMPT_RT=n.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/mmdebug.h | 6 ++++++
>  lib/Kconfig.debug       | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 15ae78cd28536..b8728d11c9490 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -94,6 +94,12 @@ void dump_mm(const struct mm_struct *mm);
>  #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #endif
>  
> +#ifdef CONFIG_DEBUG_VM_IRQSOFF
> +#define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
> +#else
> +#define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
> +#endif
> +
>  #ifdef CONFIG_DEBUG_VIRTUAL
>  #define VIRTUAL_BUG_ON(cond) BUG_ON(cond)
>  #else
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 072e4b289c13e..c96fc6820544c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -803,6 +803,9 @@ config ARCH_HAS_DEBUG_VM_PGTABLE
>  	  An architecture should select this when it can successfully
>  	  build and run DEBUG_VM_PGTABLE.
>  
> +config DEBUG_VM_IRQSOFF
> +	def_bool DEBUG_VM && !PREEMPT_RT
> +
>  config DEBUG_VM
>  	bool "Debug VM"
>  	depends on DEBUG_KERNEL
> -- 
> 2.37.2

-- 
Michal Hocko
SUSE Labs
