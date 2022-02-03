Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290A24A880C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351985AbiBCPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:52:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51134 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345506AbiBCPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:52:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF3311F399;
        Thu,  3 Feb 2022 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643903550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwqGB0P7BAikO77P4Cr4FPMD6wz7ALm2SA1ykdiVD4c=;
        b=bRAvo3BLIj3v7SFT0I1ZjFRRPwQzLw6+P1UBcUoGsNmHOHsMvO21nSmKnc8NWP14j8Anm9
        ZObOjKjm2gMw3GimS/gQRHbTCUgDU81+T6n3mXqk6y5JMvqMdNsM6j+qB4Hx+j2RXugh9c
        esP9dGpVMjZ2y+r/17okfHCqiWuVaNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643903550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwqGB0P7BAikO77P4Cr4FPMD6wz7ALm2SA1ykdiVD4c=;
        b=aW0tglSdjAh8AHokGmM2D73KkeNY6L/4FrbYP8mg41JNl6Mlh0gVj5SyJ8sMmnzMH3uZc6
        hf3uL/ArCxfdDXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCEB613C7C;
        Thu,  3 Feb 2022 15:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ssK0MD76+2G2EQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 15:52:30 +0000
Message-ID: <b73d9d54-4311-1fd3-43b1-39ffd5d9c160@suse.cz>
Date:   Thu, 3 Feb 2022 16:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mm/page_owner.c: record task name of process
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
References: <20220203120040.2338-1-caoyixuan2019@email.szu.edu.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220203120040.2338-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 13:00, Yixuan Cao wrote:
> I think in tracing page allocation behavior,
> It is useful to record the task name of the process.
> 
> Although the current Page Owner has recorded the process ID,
> When the process exits,
> It is difficult to distinguish the specific function of this process,
> This brings some inconvenience to debugging memory problems.
> 
> Therefore, add the task name information to the Page Owner,
> So that users can clearly understand the task name of the process.
> At the same time, with this information,
> We can use tools/vm/page_owner_sort.c,
> Provides more output modes for Page Owner.
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>

A patch with the same goal is already part of Waiman's series:
https://lore.kernel.org/all/20220131192308.608837-5-longman@redhat.com/

> ---
>  mm/page_owner.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 99e360df9465..a8d666cd13ac 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -29,6 +29,7 @@ struct page_owner {
>  	u64 ts_nsec;
>  	u64 free_ts_nsec;
>  	pid_t pid;
> +	char task_name[TASK_COMM_LEN];
>  };
>  
>  static bool page_owner_enabled = false;
> @@ -163,6 +164,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>  		page_owner->gfp_mask = gfp_mask;
>  		page_owner->last_migrate_reason = -1;
>  		page_owner->pid = current->pid;
> +		strcpy(page_owner->task_name, current->comm);
>  		page_owner->ts_nsec = local_clock();
>  		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
>  		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
> @@ -229,6 +231,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>  		old_page_owner->last_migrate_reason;
>  	new_page_owner->handle = old_page_owner->handle;
>  	new_page_owner->pid = old_page_owner->pid;
> +	strcpy(new_page_owner->task_name, old_page_owner->task_name);
>  	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
>  	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
>  
> @@ -339,9 +342,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		return -ENOMEM;
>  
>  	ret = snprintf(kbuf, count,
> -			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
> +			"Page allocated via order %u, mask %#x(%pGg), pid %d, task_name [%s], ts %llu ns, free_ts %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
>  			&page_owner->gfp_mask, page_owner->pid,
> +			page_owner->task_name,
>  			page_owner->ts_nsec, page_owner->free_ts_nsec);
>  
>  	if (ret >= count)
> @@ -415,9 +419,10 @@ void __dump_page_owner(const struct page *page)
>  	else
>  		pr_alert("page_owner tracks the page as freed\n");
>  
> -	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu, free_ts %llu\n",
> +	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, task_name [%s], ts %llu, free_ts %llu\n",
>  		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
> -		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
> +		 page_owner->pid, page_owner->task_name,
> +		 page_owner->ts_nsec, page_owner->free_ts_nsec);
>  
>  	handle = READ_ONCE(page_owner->handle);
>  	if (!handle)
> @@ -629,3 +634,4 @@ static int __init pageowner_init(void)
>  	return 0;
>  }
>  late_initcall(pageowner_init)
> +

