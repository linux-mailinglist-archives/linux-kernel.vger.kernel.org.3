Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C129347B155
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhLTQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:39:52 -0500
Received: from out1.migadu.com ([91.121.223.63]:40421 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhLTQjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:39:51 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640018388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DlacqxZJQgYqXIpFXX6uZOVHwn8FgcGRJKw5vj65G5A=;
        b=Vz6WWZWbN6G6kMF3FUg1gDf6hmK7U/Nx/WK2MFD6v6kPB4HH0NO0fbXMQqbkULUzuX0yaK
        RtGzO/sv7/h/dIbf9T4kwDkJAKxaGvJrM1xqYVnXoE//YUJ8tolI5XbMx7qpx4SFmM2pv9
        JiYjQixVg+nDVgv92ACPBLP8eBPUaqk=
From:   andrey.konovalov@linux.dev
To:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] lib/test_meminit: destroy cache in kmem_cache_alloc_bulk() test
Date:   Mon, 20 Dec 2021 17:39:43 +0100
Message-Id: <aced20a94bf04159a139f0846e41d38a1537debb.1640018297.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Make do_kmem_cache_size_bulk() destroy the cache it creates.

Fixes: 03a9349ac0e0 ("lib/test_meminit: add a kmem_cache_alloc_bulk() test")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_meminit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index e4f706a404b3..3ca717f11397 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -337,6 +337,7 @@ static int __init do_kmem_cache_size_bulk(int size, int *total_failures)
 		if (num)
 			kmem_cache_free_bulk(c, num, objects);
 	}
+	kmem_cache_destroy(c);
 	*total_failures += fail;
 	return 1;
 }
-- 
2.25.1

