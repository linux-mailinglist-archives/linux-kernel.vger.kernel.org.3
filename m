Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F75A9A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiIAOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiIAOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:41:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CA80B51
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:41:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A05DC21A58;
        Thu,  1 Sep 2022 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662043270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4N85gBIGjjkFJw1wkwc5ynL7FFJex63BJvLcg0HCeA=;
        b=CJmILTtzWNnIHcZbFdvtuaob6Tl/IccFBow9lu5myxXMyqCFbxZkSWIhix8zjKuaMlVpvB
        qY+KrMMfTOdjmuinwaybfCD0QtNMRMoWA50VtutsryB4hr6Uu5LcP64wYuVhs8bUHPDI30
        SU+staKJSRquCRcBzfSx5FYKxh2qJCM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82DBE13A79;
        Thu,  1 Sep 2022 14:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ntKrHYbEEGNwYwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 14:41:10 +0000
Date:   Thu, 1 Sep 2022 16:41:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/8] mm/vmstat: Use preempt_[dis|en]able_nested()
Message-ID: <YxDEhV0QAnil3h7e@dhcp22.suse.cz>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
 <20220825164131.402717-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164131.402717-4-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-08-22 18:41:26, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the open coded CONFIG_PREEMPT_RT conditional
> preempt_enable/disable() pairs with the new helper functions which hide
> the underlying implementation details.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmstat.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 373d2730fcf21..d514fe7f90af0 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -355,8 +355,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>  	 * CPU migrations and preemption potentially corrupts a counter so
>  	 * disable preemption.
>  	 */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> +	preempt_disable_nested();
>  
>  	x = delta + __this_cpu_read(*p);
>  
> @@ -368,8 +367,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>  	}
>  	__this_cpu_write(*p, x);
>  
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> +	preempt_enable_nested();
>  }
>  EXPORT_SYMBOL(__mod_zone_page_state);
>  
> @@ -393,8 +391,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>  	}
>  
>  	/* See __mod_node_page_state */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> +	preempt_disable_nested();
>  
>  	x = delta + __this_cpu_read(*p);
>  
> @@ -406,8 +403,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>  	}
>  	__this_cpu_write(*p, x);
>  
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> +	preempt_enable_nested();
>  }
>  EXPORT_SYMBOL(__mod_node_page_state);
>  
> @@ -441,8 +437,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
>  	s8 v, t;
>  
>  	/* See __mod_node_page_state */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> +	preempt_disable_nested();
>  
>  	v = __this_cpu_inc_return(*p);
>  	t = __this_cpu_read(pcp->stat_threshold);
> @@ -453,8 +448,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
>  		__this_cpu_write(*p, -overstep);
>  	}
>  
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> +	preempt_enable_nested();
>  }
>  
>  void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
> @@ -466,8 +460,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>  	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
>  
>  	/* See __mod_node_page_state */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> +	preempt_disable_nested();
>  
>  	v = __this_cpu_inc_return(*p);
>  	t = __this_cpu_read(pcp->stat_threshold);
> @@ -478,8 +471,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>  		__this_cpu_write(*p, -overstep);
>  	}
>  
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> +	preempt_enable_nested();
>  }
>  
>  void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
> @@ -501,8 +493,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
>  	s8 v, t;
>  
>  	/* See __mod_node_page_state */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> +	preempt_disable_nested();
>  
>  	v = __this_cpu_dec_return(*p);
>  	t = __this_cpu_read(pcp->stat_threshold);
> @@ -513,8 +504,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
>  		__this_cpu_write(*p, overstep);
>  	}
>  
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> +	preempt_enable_nested();
>  }
>  
>  void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
> @@ -526,8 +516,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>  	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
>  
>  	/* See __mod_node_page_state */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> +	preempt_disable_nested();
>  
>  	v = __this_cpu_dec_return(*p);
>  	t = __this_cpu_read(pcp->stat_threshold);
> @@ -538,8 +527,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>  		__this_cpu_write(*p, overstep);
>  	}
>  
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> +	preempt_enable_nested();
>  }
>  
>  void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
> -- 
> 2.37.2

-- 
Michal Hocko
SUSE Labs
