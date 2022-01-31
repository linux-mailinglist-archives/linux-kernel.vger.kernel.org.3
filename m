Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924F54A4B36
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380035AbiAaQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380022AbiAaQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AFAC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so14329326pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cll0HiNGaOM9yDWI60AkgZZ8Vcgf+tRA3oZc4UBL7nk=;
        b=kqcwDry5uO65hxuBb6yCzUOH/a1vV6vXhHnghWYmZE0wFwKVg4sDSVN/IFdkti1vxa
         gH7qY1qLoeC+cKiFHLrznIF/YZZj/5AhGagvceyAcyEcWWJMLsMqThARBDdu+bmGE+PX
         x6nXbH2i4BHnV1zU3rPxoNPPkey5wfOwbpO2l++PZiNesvMkQiFad2sph+apeltel7aQ
         Ls1SJTkFiJ4YqR9pdlN4r7l0tC31BgRrY8AyIlvoJPiUU/g7awJtPbivAom+ouD7h5rh
         4fLe2DLqgbdp4M3crNsgRcakjECmczJ67k4TbCKpIhxWYZao52P3BXYCUZuUbN4s2YZS
         rVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cll0HiNGaOM9yDWI60AkgZZ8Vcgf+tRA3oZc4UBL7nk=;
        b=fezs+C/vgRqwUAku6nRDBAmYFsbng5TxQz5PuaWDPYO2JSswCN4498K5j1pSKy9ei8
         SUkAE/ghsKMBL2UcnfcF6iF2CqbUYeSRK+R8K5L1RYdJjFSIqeC42QNPsFEFZK+gzYJG
         DE1ra8Plt4qgIqWaE6/bvihjd5so8qBSUPz7DK3uDCEP+TQo395zFmOOP7BJrmsEO2Jx
         8jMPL5PqTFohIoBJ2ld5KOhcKAqkAXg7rXpFv5WM3mG/f+H8TTC06CZP44wc2m4SrToc
         pI713wBgmj3K5LktJt2LxFzCy5TL/4IebyOGYQLJYzIMydgTcBZ4kdfkHJuX7nEmRo0R
         QQgw==
X-Gm-Message-State: AOAM533+A4vnwfGGTPzXl9aGBvl9KoHXnPP4TeP0rn7XcfKfgV5AH9Pg
        7/SIj3lCQPqxoTah5Cc4xhwtIw==
X-Google-Smtp-Source: ABdhPJxZJ+tEgViLwu3F1PuG3ikPoO/2NiO4jJZJUhCFbhH2t+GN/XLwxc/o0L5yrU9nizfHfRLOTw==
X-Received: by 2002:a17:902:e788:: with SMTP id cp8mr21004336plb.172.1643645055966;
        Mon, 31 Jan 2022 08:04:15 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n42sm17940716pfv.29.2022.01.31.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:04:15 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/5] mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
Date:   Tue,  1 Feb 2022 00:02:52 +0800
Message-Id: <20220131160254.43211-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220131160254.43211-1-songmuchun@bytedance.com>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userfaultfd calls copy_huge_page_from_user() which does not do
any cache flushing for the target page.  Then the target page will
be mapped to the user space with a different address (user address),
which might have an alias issue with the kernel address used to copy
the data from the user to.  Fix this issue by flushing dcache in
copy_huge_page_from_user().

Fixes: fa4d75c1de13 ("userfaultfd: hugetlbfs: add copy_huge_page_from_user for hugetlb userfaultfd support")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e8ce066be5f2..eb027da68aa7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5405,6 +5405,8 @@ long copy_huge_page_from_user(struct page *dst_page,
 		if (rc)
 			break;
 
+		flush_dcache_page(subpage);
+
 		cond_resched();
 	}
 	return ret_val;
-- 
2.11.0

