Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283D4C842F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiCAGep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiCAGei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:34:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989B70F4C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:33:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D1ACC219A1;
        Tue,  1 Mar 2022 06:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646116434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMtsDk3b0hX8joqj3KjxPGJRR7Yf0hzE7vshS8yyLBI=;
        b=EuQ+dNUmzLWLQ2+RoKuacyeTxk2x3l6+1b1bu6dikA3T1PN3x8RsqQWB6BittnB3bfiJEI
        v4WZzzEz0KpxToE0u0SnVTlSAlA+vtxgKhAmjUH4ERaSZnStXflBL3N3gTT0oxCXvRySLU
        XaHYpbCw8WbpCGRYIyTL9SP3jm5d5tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646116434;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMtsDk3b0hX8joqj3KjxPGJRR7Yf0hzE7vshS8yyLBI=;
        b=TwpNU8F9Btq6zmvCfvsQyXENKFfUzvpq8xt418IIijwb9S0HPu89otXrXnEU/u8dp5FY+J
        2pEzgU1r9JTSdTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3D14139EF;
        Tue,  1 Mar 2022 06:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8uWmMlG+HWJ6GAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 01 Mar 2022 06:33:53 +0000
Date:   Tue, 1 Mar 2022 07:33:52 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V13 3/3] memory tiering: skip to scan fast memory
Message-ID: <Yh2+UI0RoVea1YPf@localhost.localdomain>
References: <20220221084529.1052339-1-ying.huang@intel.com>
 <20220221084529.1052339-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221084529.1052339-4-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:45:29PM +0800, Huang Ying wrote:
> If the NUMA balancing isn't used to optimize the page placement among
> sockets but only among memory types, the hot pages in the fast memory
> node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
> to scan the pages in the fast memory node via changing their PTE/PMD
> mapping to be PROT_NONE.  So that the page faults could be avoided
> too.
> 
> In the test, if only the memory tiering NUMA balancing mode is enabled, the
> number of the NUMA balancing hint faults for the DRAM node is reduced to
> almost 0 with the patch.  While the benchmark score doesn't change
> visibly.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
