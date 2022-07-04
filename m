Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598155658D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGDOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiGDOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:40:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DC11478
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2908E20272;
        Mon,  4 Jul 2022 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656945598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAxWQ9NhdZjwnh3NBb4lAHsXOxATS56cntUW47YLCw4=;
        b=XlNRsO3JE0e31wuW7i0y+kyLIl3aF4F8Hw0mMlFekSq5j8mG5sh26unraX71Gu7gO+cyZd
        3ETbCuXfMMSQrMbmPRjeoZJyCzm9NGynAnjPSJOVudI6kdvomGcNCZjOSkHMj82TtPrTEH
        85gCTQrdyv63BXe4kBYa9YmUkK8+CYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656945598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAxWQ9NhdZjwnh3NBb4lAHsXOxATS56cntUW47YLCw4=;
        b=x8DzM+Crawj0He+ND5c4l9U5IZ+8hUWLjghX/JLrYwk08izvbBOyb1wxHTsIX7FB2MhPEy
        kkyO+zVdzCwUweCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 033C613451;
        Mon,  4 Jul 2022 14:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +2IDAL77wmJ0ZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Jul 2022 14:39:57 +0000
Message-ID: <ae15b692-bf68-51a8-1796-7ba15e156d2d@suse.cz>
Date:   Mon, 4 Jul 2022 16:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
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
References: <20220624125423.6126-1-mgorman@techsingularity.net>
 <20220624125423.6126-8-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220624125423.6126-8-mgorman@techsingularity.net>
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

On 6/24/22 14:54, Mel Gorman wrote:
> struct per_cpu_pages is no longer strictly local as PCP lists can be
> drained remotely using a lock for protection. While the use of local_lock
> works, it goes against the intent of local_lock which is for "pure
> CPU local concurrency control mechanisms and not suited for inter-CPU
> concurrency control" (Documentation/locking/locktypes.rst)
> 
> local_lock protects against migration between when the percpu pointer is
> accessed and the pcp->lock acquired. The lock acquisition is a preemption
> point so in the worst case, a task could migrate to another NUMA node
> and accidentally allocate remote memory. The main requirement is to pin
> the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
> 
> Replace local_lock with helpers that pin a task to a CPU, lookup the
> per-cpu structure and acquire the embedded lock. It's similar to local_lock
> without breaking the intent behind the API. It is not a complete API
> as only the parts needed for PCP-alloc are implemented but in theory,
> the generic helpers could be promoted to a general API if there was
> demand for an embedded lock within a per-cpu struct with a guarantee
> that the per-cpu structure locked matches the running CPU and cannot use
> get_cpu_var due to RT concerns. PCP requires these semantics to avoid
> accidentally allocating remote memory.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

-fix looks OK too
