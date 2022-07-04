Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842355658A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGDO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiGDO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:28:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9704BE49
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:28:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 544F822602;
        Mon,  4 Jul 2022 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656944931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BR/SioYK/3UlUv+psIKKpEvMM12Z72hpn/Bf8OVfu1A=;
        b=lZmJ++FuDv4OX+l34Cct/u+0+0eLoK3yxRaV75+WwNF0nIXQu7SOQS5hwugeqm3NVySo0J
        xgpcYirdOpNFBQ+n1IpnGRqSAlfhZaGZIO0zXi3hZLPRVBxk91gTsXkvWRHhSRxRu39sUK
        6jgFg4QuDajaJTpjWgyopYY8NshpvPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656944931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BR/SioYK/3UlUv+psIKKpEvMM12Z72hpn/Bf8OVfu1A=;
        b=rx1l78EaJzQbrKD5XpVcvRoDJo+4yg6br433Ny9OR5xV1RNs5WPw3R39DNsMpH8fbHWyi7
        HKD6ea8MC4m8JDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28CE313451;
        Mon,  4 Jul 2022 14:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zhsbCSP5wmLbXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Jul 2022 14:28:51 +0000
Message-ID: <2f9a95b8-d883-d5a3-3714-801bae36eec2@suse.cz>
Date:   Mon, 4 Jul 2022 16:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/7] mm/page_alloc: Remotely drain per-cpu lists
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
 <20220624125423.6126-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220624125423.6126-7-mgorman@techsingularity.net>
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
> From: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> 
> Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
> drain work queued by __drain_all_pages().  So introduce a new mechanism to
> remotely drain the per-cpu lists.  It is made possible by remotely locking
> 'struct per_cpu_pages' new per-cpu spinlocks.  A benefit of this new
> scheme is that drain operations are now migration safe.
> 
> There was no observed performance degradation vs.  the previous scheme.
> Both netperf and hackbench were run in parallel to triggering the
> __drain_all_pages(NULL, true) code path around ~100 times per second.  The
> new scheme performs a bit better (~5%), although the important point here
> is there are no performance regressions vs.  the previous mechanism.
> Per-cpu lists draining happens only in slow paths.
> 
> Minchan Kim tested an earlier version and reported;
> 
> 	My workload is not NOHZ CPUs but run apps under heavy memory
> 	pressure so they goes to direct reclaim and be stuck on
> 	drain_all_pages until work on workqueue run.
> 
> 	unit: nanosecond
> 	max(dur)        avg(dur)                count(dur)
> 	166713013       487511.77786438033      1283
> 
> 	From traces, system encountered the drain_all_pages 1283 times and
> 	worst case was 166ms and avg was 487us.
> 
> 	The other problem was alloc_contig_range in CMA. The PCP draining
> 	takes several hundred millisecond sometimes though there is no
> 	memory pressure or a few of pages to be migrated out but CPU were
> 	fully booked.
> 
> 	Your patch perfectly removed those wasted time.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
