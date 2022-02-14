Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A864B4ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbiBNLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352245AbiBNLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:36:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B3039B96
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g5akv3nbPgs/7/FgbFvp4oXy0T6K5tdSHxdmHcgTDTo=; b=PXroaKnTAUSaaEQXALHpNWhIoJ
        cm6I9a1g3giSTpLznstu9vPQA5d/yIkoFwgAd5658vBxEdtJ0zpNPBmP289NZ8+3gyyGWyWGkFgoD
        f2l54ujuEXVCfMkTiRnCgR0XYzf0yafn7F4IF81JgNeZ++8z+euV+1QESIeuDkgeksU3hOBO/sODg
        0nnyDjZ4OZhcUU76ZxM7tFNQ9v1/Pzdlw716TVB/6jOoEdDOfH6OMBk5St+3eVKtdanGxiLRtbKMA
        SxG/pve5UwUntvDNSQNgpGgf6TMcpmlaV6nHt+BR9Ogpw0FouwCKSLlmggy4r60OYJaVrdJYzKdXf
        PNc8w9yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJZTq-00CqWA-9s; Mon, 14 Feb 2022 11:25:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB0F83002C5;
        Mon, 14 Feb 2022 12:25:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D37F2025FC40; Mon, 14 Feb 2022 12:25:16 +0100 (CET)
Date:   Mon, 14 Feb 2022 12:25:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking/lockdep: Cleanup reinit_class()
Message-ID: <Ygo8HNXGNq6X4Jov@hirez.programming.kicks-ass.net>
References: <20220211035526.1329503-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211035526.1329503-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:55:25PM -0500, Waiman Long wrote:
> Replace the duplicated WARN_ON_ONCE() tests in reinit_class() with
> BUILD_BUG_ON().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/lockdep_types.h | 4 ++++
>  kernel/locking/lockdep.c      | 6 +++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index d22430840b53..446d981ae3a2 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -108,6 +108,10 @@ struct lock_class {
>  	 */
>  	struct list_head		locks_after, locks_before;
>  
> +	/*
> +	 * All the fields that require re-initialization after being zapped
> +	 * must be put after "key".
> +	 */
>  	const struct lockdep_subclass_key *key;
>  	unsigned int			subclass;
>  	unsigned int			dep_gen_id;
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index d4252b5c9863..77bbe557d48b 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6015,10 +6015,10 @@ static void reinit_class(struct lock_class *class)
>  	WARN_ON_ONCE(!class->lock_entry.next);
>  	WARN_ON_ONCE(!list_empty(&class->locks_after));
>  	WARN_ON_ONCE(!list_empty(&class->locks_before));
> +	BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
> +	BUILD_BUG_ON(offsetof(struct lock_class, locks_after) > offset);
> +	BUILD_BUG_ON(offsetof(struct lock_class, locks_before) > offset);
>  	memset(p + offset, 0, sizeof(*class) - offset);
> -	WARN_ON_ONCE(!class->lock_entry.next);
> -	WARN_ON_ONCE(!list_empty(&class->locks_after));
> -	WARN_ON_ONCE(!list_empty(&class->locks_before));
>  }
>  
>  static inline int within(const void *addr, void *start, unsigned long size)
> -- 
> 2.27.0
> 

Yeah, except that this doesn't build because it conflicts with a
previous patch you actually Acked:

 https://lore.kernel.org/all/20211213132618.105737-1-xiujianfeng@huawei.com/T/#m0e9474a9204ec29fb2135135ce3134640a3f27b5
