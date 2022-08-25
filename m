Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1826B5A0D63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiHYJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiHYJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:54:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2468ACA11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:52:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07CB31FB0B;
        Thu, 25 Aug 2022 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661421130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6vFISPJN3U6nScOiLDA2IhWeXOoQm4ccfrelohfpXs=;
        b=pbDJSVXlyKdEGh36m+cnk5iqpJEsmDB3R+cx4aNbCfjV+058Z0x64m3vYJ739nYXroPGcg
        GVLhqwUqlHmxESlVNtyS2EndoUQnqC25ljNRgJQ6pCPkh1Uk/FFnMjm68mBRAnm0NG9L/+
        a95eLekDWoioMa6e33sFLmkJDxYbtSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661421130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6vFISPJN3U6nScOiLDA2IhWeXOoQm4ccfrelohfpXs=;
        b=I5DrCQqkgcn62snMSlJVS5ah4CueLwPA1qyy+F9mr7yiHTGCBHht4b6fXxzwKxMTD4CnhP
        vJJ4M4i9yjkV3JCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8DB813A8E;
        Thu, 25 Aug 2022 09:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VfAcNElGB2MKUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 09:52:09 +0000
Message-ID: <a461479d-a5cd-dc86-013a-d8827d7d321a@suse.cz>
Date:   Thu, 25 Aug 2022 11:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <YwScVmVofIZkopkF@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YwScVmVofIZkopkF@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 11:22, Michal Hocko wrote:
> All but node0 are really completely irrelevant for this allocation
> because they do not have ZONE_DMA yet it swamps the log and makes it
> harder to visually inspect.
> 
> Address this by providing gfp_maks parameter to show_mem and filter the
> output to only those zones/nodes which are relevant for the allocation.
> That means nodes which have at least one managed zone which is usable
> for the allocation (zone_idx(zone) <= gfp_zone(gfp_mask)).
> The resulting output for the same failure would become:

Looks good to me.

> [...]
> [   14.017605][    T1] Mem-Info:

Maybe print the gfp_mask (or just max zone) here again, to make it more
obvious in case somebody sents a report without the top header?

> [   14.017956][    T1] active_anon:0 inactive_anon:0 isolated_anon:0
> [   14.017956][    T1]  active_file:0 inactive_file:0 isolated_file:0
> [   14.017956][    T1]  unevictable:0 dirty:0 writeback:0
> [   14.017956][    T1]  slab_reclaimable:876 slab_unreclaimable:30300
> [   14.017956][    T1]  mapped:0 shmem:0 pagetables:12 bounce:0
> [   14.017956][    T1]  free:3170151735 free_pcp:6868 free_cma:0
> [   14.017962][    T1] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7200kB pagetables:4kB all_unreclaimable? no
> [   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
> [   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
> [   14.018480][    T1] 0 total pagecache pages
> [   14.018483][    T1] 0 pages in swap cache
> [   14.018484][    T1] Swap cache stats: add 0, delete 0, find 0/0
> [   14.018486][    T1] Free swap  = 0kB
> [   14.018487][    T1] Total swap = 0kB
> [   14.018488][    T1] 3221164600 pages RAM
> [   14.018489][    T1] 0 pages HighMem/MovableOnly
> [   14.018490][    T1] 50531051 pages reserved
> [   14.018491][    T1] 0 pages cma reserved
> [   14.018492][    T1] 0 pages hwpoisoned
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

