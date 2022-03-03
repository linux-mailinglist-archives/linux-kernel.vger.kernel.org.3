Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969F24CB495
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiCCBvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiCCBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:51:35 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1C330
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:50:51 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so4180132ooa.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=WLZHWiYfsav+TK/RC6MOIHPotleUyTDNef71iAWH83s=;
        b=haqBoSpzcULkCdwm3OY68wDxPssQDwkueKAhc8ywZtwo3AhtURCVS+X++VAyk8hNqu
         sGajtVStNdtWeXBWvyOalU2UExs8g2CKWZpsmgEBz+zZdw+PqtIjrn9NidHOc6XombMc
         zad9VSRcqqIG+JdRSbe5IQdsbXS6VVN/iznaAhq9kg/0aQif2FIwEI48H9trq5H8A1Vt
         lyvfoSjgjXqgNBl+G3j3utaAh5NcfELXn/xv+Jl3Vqu6+p9AfB6CUyj1Wqx3nrbFiPBH
         jIvAX5p2ZYHhOopRNaazWRdy7d9HGmA4ETv5+TMtkl70tNAcCXqj3e/clPNkgniwAyiz
         P6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=WLZHWiYfsav+TK/RC6MOIHPotleUyTDNef71iAWH83s=;
        b=D8aXkAtmANTwrdW38PFEBrpeKbEjv4vO/1IxQvBtBu5YcKtX/ktiX+hw9vWHMDLeEu
         kpbqmsglgQPA3TYUfYOGHklg+PFmQrjFnVCMZjhljliNLU2q5T+waBsrIDCkPlDEGV5b
         HCd5tGmdSPbbS3odAuP8Ydxmx1BGBQF88P5EXPl8pwOHDhQm8ViJnKeNgG5qTLwKa7HP
         GaWYpcgNxm/73CFsOqul/L+6wvf43fUiYCbnKt3Ih3oXri6S40KwM6IJGzwp6r9kSMG6
         FOvcPo03aUiM+gfL1ShV3TP1BNMDt40IDmAgy1c9WPWGDmg4u9sDsXTndbDvyeWh5817
         jRPg==
X-Gm-Message-State: AOAM532rbcZ0omeiczJNHwmwWBjlXEP4pcp2otiqQ1EbakmrsPqs1n/8
        lTCM+fGAdGFvWvYuutoEH5DKcg==
X-Google-Smtp-Source: ABdhPJwxxfUl0pGVTd8mU4wHLFPUcsOH6iKB7NBPXgjbZmJiEex6cQS96okXwy+xSlqqmdQ3yZr9Dw==
X-Received: by 2002:a05:6870:2054:b0:d7:2a0:8b97 with SMTP id l20-20020a056870205400b000d702a08b97mr2324000oad.56.1646272250164;
        Wed, 02 Mar 2022 17:50:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l10-20020a9d708a000000b005af3e65ce95sm287765otj.70.2022.03.02.17.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:50:49 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:50:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm/thp: ClearPageDoubleMap in first
 page_add_file_rmap()
Message-ID: <61c5cf99-a962-9a25-597a-53ab1bd8fbc0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageDoubleMap is maintained differently for anon and for shmem+file:
the shmem+file one was never cleared, because a safe place to do so
could not be found; so it would blight future use of the cached
hugepage until evicted.

See https://lore.kernel.org/lkml/1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com/

But page_add_file_rmap() does provide a safe place to do so (though
later than one might wish): allowing testing to return to an initial
state without a damaging drop_caches.

Fixes: 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/rmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1251,6 +1251,17 @@ void page_add_file_rmap(struct page *page,
 		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
+
+		/*
+		 * It is racy to ClearPageDoubleMap in page_remove_file_rmap();
+		 * but page lock is held by all page_add_file_rmap() compound
+		 * callers, and SetPageDoubleMap below warns if !PageLocked:
+		 * so here is a place that DoubleMap can be safely cleared.
+		 */
+		VM_WARN_ON_ONCE(!PageLocked(page));
+		if (nr == nr_pages && PageDoubleMap(page))
+			ClearPageDoubleMap(page);
+
 		if (PageSwapBacked(page))
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						nr_pages);
