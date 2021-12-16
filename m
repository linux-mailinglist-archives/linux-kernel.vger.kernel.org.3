Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D998477C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbhLPTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240961AbhLPTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:23:13 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:23:13 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 8so275595qtx.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAQwT03q8c+l0eyOEhJV/8Xp6eHvuAVKGl9g48A9iCY=;
        b=gKWKpH+nxPg8FTF0yqETilAi8Ksx0wnwAAicnObD4Pkvy2oaxvFb4IqcJOs++fPSvy
         ESACwjxDnKF4klXUQa9pot4ULKZ7qfFaJrdnmCe4wHAcvlJSo2o/LiaK3foHmgsmxSwc
         Pp4WrVOEAqlW511Hmu7PS9WsE/mCjk21L9MkZI74o068gHiy0zThEMzCWgPdVPEqRBwl
         mbtj4eSoqMrnTPQ+d2AJU9+DiRuzojq4qZ4AS5TwKWcmHW/35MN943q5OiDcEa1Yva9l
         kE6ljMxbqRNRo1v2c4Eh+890xn2/iS7B3aCZeBuW0uv1l5xBjNUjocHIZ/4jDM0FuJua
         9LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAQwT03q8c+l0eyOEhJV/8Xp6eHvuAVKGl9g48A9iCY=;
        b=6/N9n/VlUaKQKLVMwkExaEFqGqBnTWIy+Jk3Q0ObzFa4cg1ZGug7x0swfIVr/nvBST
         +ZntEjpykKwUK2RNdqgwlCRhrG0N/Fq66hVz4OGD+iWVsY4b+RWIcM9E7pcp0r2LgHft
         46PUwapS2Wgl/vUWhcC2zk2+99ZdU8vPz1CASkHAjJVYcSiMsHCsVDK8PIfJxxDgOr+Y
         L4j2j70yC+4r7j6bLOxERTYsDMyw0VWd/OzLgldRn/xMooRI1kXoStQ0/PeHM4CaAXnl
         8d3+urs8LQe/j+efVzpJJBTwWvxFVA9/GG/c9H0F8HmO7a0QXWWlqMkHWmqQ9A5Gd9EJ
         RmCg==
X-Gm-Message-State: AOAM5323V5kUgkEAJF8JtkQlIks/GC1HnccOp7ThOdSmwNNoWQoakrua
        0At7cowl2l9y69Al3kGupjewKA3sHJ9uS+jV9f7cKChCa27Ib/O8XA911in+ihcvzF3WQBBcEi9
        c9k1J0AIqFe+kbG7HUjklbBMDouTuRhCmj1TM4OgSslnJXL0k8csVLeA/B9Jn0yCRyVprMBybUx
        QmWsHpEoEl7Z5f30z6
X-Google-Smtp-Source: ABdhPJx/lt3729LoAXghiXnOSrEZVnKnhl8bkBsoYgbu9DkA3M5pwTUuUT8dD+zKtEwH4Y5GZeCRAA==
X-Received: by 2002:ac8:5855:: with SMTP id h21mr18050821qth.8.1639682592147;
        Thu, 16 Dec 2021 11:23:12 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id j16sm4962737qtx.92.2021.12.16.11.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:23:11 -0800 (PST)
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
Subject: [PATCH v4 2/5] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Thu, 16 Dec 2021 16:22:19 -0300
Message-Id: <20211216192222.127908-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
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

