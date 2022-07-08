Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD856BCAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiGHOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiGHOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:54:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9D18E13
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:54:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3400C21FE0;
        Fri,  8 Jul 2022 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657292088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7Aw7CUlH7hnP8Qg6TBNYPcNryVs2jtH5tretlprBAE=;
        b=ecouykwpcGwwihI2S1zbFptGgJiA2LHezwWP2/VlZH3l/NXsKxjCfE5nXyaW4xJVTiRlmG
        mb0go9GQLRRhHFp0C7RwF9/GK03quAByTPran4XRBLF15sItKFpC7hC82VZUCb7vsAKOuh
        LAxTT6QCbC3C3ktulb0h6fm8gWDONWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657292088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7Aw7CUlH7hnP8Qg6TBNYPcNryVs2jtH5tretlprBAE=;
        b=108E4Ct+4NeOjPX3bV02xPwutJ+TucYy9lQchqrTiBLy9q2HKhTvn9TqcWEITsO3QLq7xb
        Ns+Pb93b6kJakcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B45A13A80;
        Fri,  8 Jul 2022 14:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /9DUAThFyGJyZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 08 Jul 2022 14:54:48 +0000
Message-ID: <a78f95e9-298a-bc97-9776-14e0f02f62b9@suse.cz>
Date:   Fri, 8 Jul 2022 16:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/page_alloc: replace local_lock with normal spinlock
 -fix -fix
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220708144406.GJ27531@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220708144406.GJ27531@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 16:44, Mel Gorman wrote:
> pcpu_spin_unlock and pcpu_spin_unlock_irqrestore both unlock
> pcp->lock and then enable preemption. This lacks symmetry against
> both the pcpu_spin helpers and differs from how local_unlock_* is
> implemented. While this is harmless, it's unnecessary and it's generally
> better to unwind locks and preemption state in the reverse order as
> they were acquired.

Hm I'm confused, it seems it's done in reverse order (which I agree with)
before this -fix-fix, but not after it?

before, pcpu_spin_lock() (and variants) do pcpu_task_pin() and then
spin_lock() (or variant), and pcpu_spin_unlock() does spin_unlock() and then
pcpu_task_unpin(). That seems symmetrical, i.e. reverse order to me? And
seems to match what local_lock family does too.

> This is a fix on top of the mm-unstable patch
> mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 934d1b5a5449..d0141e51e613 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -192,14 +192,14 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  
>  #define pcpu_spin_unlock(member, ptr)					\
>  ({									\
> -	spin_unlock(&ptr->member);					\
>  	pcpu_task_unpin();						\
> +	spin_unlock(&ptr->member);					\
>  })
>  
>  #define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
>  ({									\
> -	spin_unlock_irqrestore(&ptr->member, flags);			\
>  	pcpu_task_unpin();						\
> +	spin_unlock_irqrestore(&ptr->member, flags);			\
>  })
>  
>  /* struct per_cpu_pages specific helpers. */

