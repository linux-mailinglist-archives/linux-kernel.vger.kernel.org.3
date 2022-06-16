Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3280654E779
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiFPQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFPQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:41:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAED30571
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:41:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05D3B21D69;
        Thu, 16 Jun 2022 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655397705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1VoBgkGbXg4laL5bH4HWrKR+vWwEu9Z23xckivXmes=;
        b=xqtDQC6j7j+cQrEePhj/pcb7yMcbwTGcnUwC/c/h4hG4E88F2rduqNEi29Ellay8XBooIL
        B9Ec8q2Acn9n/vHbap2YRi0DLOkaxFFbhO8CmftVhMT9wP/RpY99fAizx1F9yPwMoS/LK/
        ClhBjwd8d+7ni5wJ9BlFhTicVax3Xx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655397705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1VoBgkGbXg4laL5bH4HWrKR+vWwEu9Z23xckivXmes=;
        b=Jpyet56oMoTv+WiDy5u1cSLDwAPXED/B20ff7fmHtvM/DYzob2DnUqtbtzdMGGgR0zoLAl
        Nqf25PzOYC+jtQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF8431344E;
        Thu, 16 Jun 2022 16:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Spz3MEhdq2IUXQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Jun 2022 16:41:44 +0000
Message-ID: <4a5d90b3-afe4-7c13-b989-3ece4a797b1f@suse.cz>
Date:   Thu, 16 Jun 2022 18:41:44 +0200
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
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220613125622.18628-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 14:56, Mel Gorman wrote:
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
> Minchan Kim tested this independently and reported;
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
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
