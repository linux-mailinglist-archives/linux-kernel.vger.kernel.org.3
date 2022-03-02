Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC6B4C9F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiCBIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiCBIaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:30:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9EB82D9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 9so951194pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=cYJLK58sIMtE77DATtQlxH9dtPyPDOawr2Hs9P06tVu2j6KUemAg7S9UEgucud0DdX
         4h/Uh/mP0MROdl00Wa/vvnYHaH6Ya6dm/OxjneqryKBM8Gp6v7zc8BhA27iNEPG1yHH2
         Eojft7GBt8tz5GmBW/hk0eB/lgf+Hbk5vSPzs7SU8EZS8jxOTz8PGvLJ6crgihfH37PS
         nXcScKKh2ZkdzeEMqPdHtVBCvj2or8wIA4avGEhSTLrskKUn6QAREUoUwwRZk01wFFti
         xXOkL2PqQ9YVw97HrnKwed0fGb91eHchAYlq83PZW206GlgUEgKY4mhHqxy1QcA26b4q
         Powg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=gwptEOa2u50f7/s9DA30MffvtiR/hirpPj1RmrZDX/iT+lamfHP3l1cDQ193hp6+h/
         NZP2ldDhtMTTkcmnxJ4mO0+EWpxgu41Ja+JK5DAf4i0W4kXGUwnnpueE1lgJRyg794cI
         PwM29NERC3YyL34JrMYP8qzSXQpRAuoBt1oq/PJ7CR64CAHG5XB0g9HIvxQenLE91D6G
         KZMudamRhcsQuQUAR7wTiaw63gPvVwKNo2+CRdBRXH4xdo+U9VpYxoIik3EU/py75F+m
         K0mzF5p1PSMR9dgbVNANf8PItpZAW9NB9+Z02N8cDWzZDBRf0mxbdK7VgTA8DEJGbQdT
         SFxw==
X-Gm-Message-State: AOAM5323o+JKrFKjWv8wWRqt6Z02BfWOEggtXREHGXbslmBo7d6yh2d4
        3cYRq2bKHTHlnhjyn3HLsCy6aQ==
X-Google-Smtp-Source: ABdhPJzHW21CrBKiP5Br3BMc/q1Bt4vTHDEYHfTZ2tmAwLrCBHaS+KABg8tBrpmlUqjiIhOiEwMJWw==
X-Received: by 2002:a17:90a:550b:b0:1bd:1e3a:a407 with SMTP id b11-20020a17090a550b00b001bd1e3aa407mr19607925pji.112.1646209760828;
        Wed, 02 Mar 2022 00:29:20 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:20 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Wed,  2 Mar 2022 16:27:14 +0800
Message-Id: <20220302082718.32268-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302082718.32268-1-songmuchun@bytedance.com>
References: <20220302082718.32268-1-songmuchun@bytedance.com>
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

The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
However, it does not cover the full pages in a THP except a head page.
Replace it with flush_cache_range() to fix this issue.

Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 67a08a32fccb..a372304c9695 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,7 +845,8 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
 				goto unlock_pmd;
 
-			flush_cache_page(vma, address, pfn);
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
 			pmd = pmdp_invalidate(vma, address, pmdp);
 			pmd = pmd_wrprotect(pmd);
 			pmd = pmd_mkclean(pmd);
-- 
2.11.0

