Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D66467E22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382843AbhLCT0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382853AbhLCT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:26:27 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325DFC061354
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 11:23:03 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id m192so4541566qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAQwT03q8c+l0eyOEhJV/8Xp6eHvuAVKGl9g48A9iCY=;
        b=clFzSf9e3VT0Aifw8+wLenzhgUYBx9WPOIolV7/p5j9CmQALr33loOrBWvrnbgX5kw
         gYQAroelKHXjXVPxXLwVjXSpY8Xb70qAMvtSKow0C+C6fV08Uhon15VCTdXILVf2vZ4D
         NVwx6dK93jK25ZHTJ05OOAsvJOz7CJxY8Fs8A6xxjK1nESWJv+Ut7kjjVks1NigrRwK1
         0s5yqUteIX8yqLWbfye0UTqaoyUsnMxKH65lBEDC0MoPPTlweWvW8vVZhN6UYrAU9+LN
         oH9rrGT20g5jswEzfFky+6I8sXvGhTtJ6N7KNSURQl/uv+ItgdGPQPCmWAM8h7otPH+6
         jESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAQwT03q8c+l0eyOEhJV/8Xp6eHvuAVKGl9g48A9iCY=;
        b=ICTPxLKwVFl0583s9IL1OKmk3SgULfsGS8VEAgMsWBMkK+DFGODFUySxklxFeTcoTe
         j/jEgHLvRtHN0cphjW3ik9aJfMcxRIaK63UPV7i/UyCbU+3MCws3BmFklAGvL7C4K7bk
         ssSRRUb5eivOzZcBEOk5IXQg5qn9+QlzSqrl28xJwKtiaqH1hLeppIYCvuSNDuSjWF64
         b31y5BdRj8z6trybKZOMhtYEJf1g+DUG5xAx1vK/SCu6IbYkPJmbBkaHHwwNyK/Tc4vj
         oa8INztY0vhddGxjjs/rD5MWPKb17ldcUPSERAF6IkYuLJzPCA6XqAX8OnYN9+/gQK0Y
         PE3w==
X-Gm-Message-State: AOAM530QLh5AhbYiFfqjobhUO/XGrxCH57QCDK6n1zuE8pxGNdiJoEsw
        DL5H+7GApBMASY5w2YHwGsucS+mODZA7A3OdSxPNwakld+4ek0Llh8Og/YwdQgz04vkU+AYIgX/
        lXYHlMh3y5VqFzoVJvFupdgHgh3tzTDIw7L5xwU4ONDrQVHt9nLz1kqzk/YWPV48crlC0gX/0j8
        ZduFQfNUz6p9FdXl2Xxh0=
X-Google-Smtp-Source: ABdhPJySs0z8IxWpEZ5hyhMpFmb4t34bvvvcqFTLmUzenxDHobzGf8Am899FFne1ypwydPqvXoOcjg==
X-Received: by 2002:a05:620a:2808:: with SMTP id f8mr19389014qkp.214.1638559382126;
        Fri, 03 Dec 2021 11:23:02 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id d11sm2729269qtj.4.2021.12.03.11.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 11:23:01 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v3 2/5] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Fri,  3 Dec 2021 16:21:45 -0300
Message-Id: <20211203192148.585399-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new member in the pg_data_t struct tell whether the node
corresponding to that pg_data_t is able to do hardware memory encryption.

This will be read from sysfs.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/mmzone.h | 3 +++
 mm/page_alloc.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..1e4f76a19c62 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -870,6 +870,9 @@ typedef struct pglist_data {
 	struct task_struct *kcompactd;
 	bool proactive_compact_trigger;
 #endif
+
+	bool crypto_capable;
+
 	/*
 	 * This is a per-node reserve of pages that are not available
 	 * to userspace allocations.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..8bcbd6fa0089 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,6 +7592,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
+	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
 
 	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
 		(u64)start_pfn << PAGE_SHIFT,
-- 
2.30.2

