Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181F34D1CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbiCHQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiCHQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:06:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEAB5004F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:05:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D561210ED;
        Tue,  8 Mar 2022 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646755545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lx7YZSPD/NWaBAYAIlDv0jZWjoT8LAg8HptCJpJ5yU=;
        b=EFBWMFI2Rxsm8YrOdrTofZYz3kbV2C9ZaQV9WLdMaepQJGkahneDLnuGjvsjEHf07rA/hX
        idDOvjF25TjPm0UhnRzsPk2EM902Fe307zW/fqaLG7PMnOCdsu481MaHVTg2PRJedCfJ70
        xuPLzQxJMi3Efrtr8YFGLW5Nd8vKFlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646755545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lx7YZSPD/NWaBAYAIlDv0jZWjoT8LAg8HptCJpJ5yU=;
        b=t19XOfxAmOcK+iiTB+A3WjupVbi99h23HgjvKnRFQGRPCPIamvh20JWzx2DtCGhh43nVGn
        u34yE96BIhEtUcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D29713CCE;
        Tue,  8 Mar 2022 16:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id seaVBtl+J2JqaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Mar 2022 16:05:45 +0000
Message-ID: <eaa5ef7f-4a39-167e-cac4-c7bf1977d857@suse.cz>
Date:   Tue, 8 Mar 2022 17:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Content-Language: en-US
To:     wangjianxing <wangjianxing@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220302013825.2290315-1-wangjianxing@loongson.cn>
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

On 3/2/22 02:38, wangjianxing wrote:
> free a large list of pages maybe cause rcu_sched starved on
> non-preemptible kernels
> 
> rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
> [...]
> Call Trace:
>   free_unref_page_list+0x19c/0x270
>   release_pages+0x3cc/0x498
>   tlb_flush_mmu_free+0x44/0x70
>   zap_pte_range+0x450/0x738
>   unmap_page_range+0x108/0x240
>   unmap_vmas+0x74/0xf0
>   unmap_region+0xb0/0x120
>   do_munmap+0x264/0x438
>   vm_munmap+0x58/0xa0
>   sys_munmap+0x10/0x20
>   syscall_common+0x24/0x38
> 
> Signed-off-by: wangjianxing <wangjianxing@loongson.cn>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6..1b96421c8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3479,6 +3479,9 @@ void free_unref_page_list(struct list_head *list)
>  		 */
>  		if (++batch_count == SWAP_CLUSTER_MAX) {
>  			local_unlock_irqrestore(&pagesets.lock, flags);
> +
> +			cond_resched();
> +
>  			batch_count = 0;
>  			local_lock_irqsave(&pagesets.lock, flags);
>  		}

