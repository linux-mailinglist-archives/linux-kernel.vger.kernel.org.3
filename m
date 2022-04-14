Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6179C5006D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiDNH3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiDNH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:29:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780021D30C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:27:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bg24so4365901pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvguC1MMEnFDh7Qcp5M1R+G1HkoQuUEH5rfx9xpUsnA=;
        b=jaLoiaYDZ4Z+d3A6bDm17qHMa77+2u7gO7myzhmWgH9KPUtRezWlSrTx3xSO75h6mp
         g522m5lYP+sbvbO/5i+pf39WI3w84AKwuZDDtWacAvYcjK1/t8405cGYHNkD93IyQ1sr
         xkqQCvBKxRzFduASufsfU0pf9ZE8Y7Kekwcnhpd4r2pecj9aaELXap50gwrZ/FIiBKTV
         axTGUy2UyJezhv1PvArIGA2cD/eXxTqSg0AYeVAoZrE+HiELtmfmoiyoLN/6P6V6eTTp
         flomRUq9GW/WQc66iEMzsRLyby3ySobEp4hJwLZMDnU9bneW7VTijI8kp4+R1EOKv8bH
         OgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvguC1MMEnFDh7Qcp5M1R+G1HkoQuUEH5rfx9xpUsnA=;
        b=TEYNiq6HYiEEu+w6sL3V22l9u7IKWe99h3YLyPBndr/g824pQXtowYdxhXQksnQtER
         P3mzLzAdES9+OQyZUT4HyoktdWZ9Sx3Q06vynvp8l7BawyGj6ssWsokUehfzxxiT4tXy
         fZ5suEELnpdBN87EEW0NyqQ9rFjwohsXk33x6Ecjsi5AhEG4qTLkMPRa2OQxL2pLV29v
         aupoBJOhUzRMLNsh147G7afMfAJOENeJyfTDrDgPGimx0rjshj/mZinzQXRksYWxh4q8
         SFd3MyqRcv6hiaNpPiTHPRvQz53cEvORcW2DvLeTzUCdiDoMX8E5SXh9R6gaVQmUIm7K
         QQCA==
X-Gm-Message-State: AOAM530yH1zVVYHwfJ6XYJDv7UC1OedUWe4CEhd92Y1JG+akpw8jaJ4u
        zuLauc24zljAmQM0r+++UKCdow==
X-Google-Smtp-Source: ABdhPJwb1EhQqtu5NSfeDtyR05g+YYJkKBUDHTScmG8s4MiDd912H4KhZb2gkcPWDOd1UjqETQrmLg==
X-Received: by 2002:a17:90b:38d1:b0:1c9:ba10:353b with SMTP id nn17-20020a17090b38d100b001c9ba10353bmr2894180pjb.9.1649921234962;
        Thu, 14 Apr 2022 00:27:14 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id k25-20020aa790d9000000b00508232aecedsm1174002pfk.67.2022.04.14.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 00:27:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] arm64: mm: hugetlb: restructure the code comment inside flush_dcache_page()
Date:   Thu, 14 Apr 2022 15:26:46 +0800
Message-Id: <20220414072646.21910-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restructure the code comment inside flush_dcache_page() to make it more
clear.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---

This is based on next-20220407.

Hi Andrew,

Would you mind help me squash this patch into "arm64: mm: hugetlb: Enable
HUGETLB_PAGE_FREE_VMEMMAP for arm64"?  Because there is some conflicts
with the patchset of hugetlb_vmemmap releated cleanup when you merge
if I resend the original patch.

 arch/arm64/mm/flush.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 9e39598bbc21..fc4f710e9820 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -81,9 +81,10 @@ void flush_dcache_page(struct page *page)
 	 * read-only when CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled (more
 	 * details can refer to vmemmap_remap_pte()).  Although
 	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
-	 * page struct, some tail page structs still can be seen the flag is
-	 * set since the head vmemmap page frame is reused (more details can
-	 * refer to the comments above page_fixed_fake_head()).
+	 * page struct, there is more than one page struct with PG_dcache_clean
+	 * associated with the HugeTLB page since the head vmemmap page frame
+	 * is reused (more details can refer to the comments above
+	 * page_fixed_fake_head()).
 	 */
 	if (hugetlb_optimize_vmemmap_enabled() && PageHuge(page))
 		page = compound_head(page);
-- 
2.11.0

