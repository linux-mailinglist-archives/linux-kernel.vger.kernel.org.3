Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113254B4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiFNPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiFNPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:30:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDA3584E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:30:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d128so6632543qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JhfKtFfiAGo/gAbCmokDRZ06JTnmfd4HUXshARByGug=;
        b=M8nZEG46t1hnT/izWr93Tj0je2+YgGFfSnaCWsCuN/VMruWBpydUtKCsIkwhO8/oAr
         44yX9Vqwii20g0XYTVOzdVl8NCLMvpWMAbETpa+XiEBP71tA71Y/ZLozyiCOj7sX3cKB
         S70P/xmQHvcX+TNdd/rk2nT4ljAnkHDWw6uWGuu2P8FG/17JmddgzE+l1/GPKswOUOqO
         5cyxDEhfrBTusSZDDWvVvmcZfTKVkaRpR0xWNDKjserTNJFunblQQHySYHI0vbHQaNfx
         WkGhYNAresMrJ5E+A3PHSCBxZZEDwdGKPHmi7Y8yTqG4AAJecHixiE5COJvyFppHXGK6
         PjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JhfKtFfiAGo/gAbCmokDRZ06JTnmfd4HUXshARByGug=;
        b=4CLvfqwwz1p5xxQSTtEmHhlTF06aJcBWfVZS9BO2pSZTwRci9A997cAdjZS5DbGfbK
         zs6ZLib7mxUEGkEfYtfrKwMKdasZl8PHdrS5rz6iWCSQQTJ/xQfn7Q2bF6T1OERyLmxQ
         mmbPEwhdZ/5IqmJuAvm5X9bofOhXE4DMwLwK00LcHUOGtH0vOTvlOh0UkXgWoWf267Xe
         HOpYGPkx3mowUaNa6YIInmZzyOqhOdnVuQRbAI56kyHjyFES+hp0VDPbEr+qBRKxECEr
         UkT1kgQ2Ou6FKzOMti2AQNHosbAIzBYQ3O11TxVTFxC2y/2vLAnwgpZ/J/WljbQQAB/f
         gBiA==
X-Gm-Message-State: AOAM530bFIXUx5U9vRDeNg32IcywA6SxCI0V/Gr0GzzMWZ0OfkktCa5Q
        STSdGHD5QcglKS78Z+91SwJsHA==
X-Google-Smtp-Source: ABdhPJy4ML+jkJj2AP96ShcZxmI4jgipOk1Aa/fgD3oSjTGB5nbFWpp2Rooz/AFJECQwfZeA0NL0fg==
X-Received: by 2002:a37:8701:0:b0:6a5:ff4f:b2bc with SMTP id j1-20020a378701000000b006a5ff4fb2bcmr4507594qkd.584.1655220650781;
        Tue, 14 Jun 2022 08:30:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2c45])
        by smtp.gmail.com with ESMTPSA id i23-20020a05620a151700b006a6f6cdfd94sm9111789qkk.117.2022.06.14.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:30:50 -0700 (PDT)
Date:   Tue, 14 Jun 2022 11:30:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V3 0/3] memory tiering: hot page selection
Message-ID: <YqipqdGwNqQDxb/6@cmpxchg.org>
References: <20220614081635.194014-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614081635.194014-1-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

Have you had a chance to look at our hot page detection patch that
Hasan has sent out some time ago? [1]

It hooks into page reclaim to determine what is and isn't hot. Reclaim
is an existing, well-tested mechanism to do just that. It's just 13
lines of code: set active bit on the first hint fault; promote on the
second one if the active bit is still set. This promotes only pages
hot enough that they can compete with toptier access frequencies.

It's not just convenient, it's also essential to link tier promotion
rate to page aging. Tiered NUMA balancing is about establishing a
global LRU order across two (or more) nodes. LRU promotions *within* a
node require multiple LRU cycles with references. LRU promotions
*between* nodes must follow the same rules, and be subject to the same
aging pressure, or you can get much colder pages promoted into a very
hot workingset and wreak havoc.

We've hammered this patch quite extensively with several Meta
production workloads and it's been working reliably at keeping
reasonable promotion rates.

@@ -4202,6 +4202,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
+
+	/* Only migrate pages that are active on non-toptier node */
+	if (numa_promotion_tiered_enabled &&
+		!node_is_toptier(page_nid) &&
+		!PageActive(page)) {
+		count_vm_numa_event(NUMA_HINT_FAULTS);
+		if (page_nid == numa_node_id())
+			count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
+		mark_page_accessed(page);
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto out;
+	}
+
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);

[1] https://lore.kernel.org/all/20211130003634.35468-1-hasanalmaruf@fb.com/t/#m85b95624622f175ca17a00cc8cc0fc9cc4eeb6d2
