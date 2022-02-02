Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2944A6F80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiBBLEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiBBLER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D4C06175B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p27so39906631lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsGfx9/8KzrBT+1sl0kUz+F3kyiF2mtw3RnNVnjQqWU=;
        b=YtfjlK0ztjIEEsuUCSKM4bqNMMcawSyHhzHcumOe5w0nKvqvl3X2dT+dB/mAD/O5NM
         ktkNBQwpJoPe2ArBLbGtI/blHvexqhgJwLxHwMAg7UdlCqBFrLcKAy5at+mTljTooYk1
         b7/Psa3+kdM7uOd0xhZXSO09mEdV9PKRG0SBxaZdM1AQSO9xIIJw5VxQ4/BMULz42MRD
         5zlrfUI6CuxKignTE4EXO5EKT+v3jXIkw6R87gVjlwzBogCk6I00RbNVL7C30pztQrta
         KSfCnUIgatFvvmReZHEq+2/1KOBDDrpFgz08EJgdan9pDm9sF+RDVYey9N0Eh1eMhpoJ
         SZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsGfx9/8KzrBT+1sl0kUz+F3kyiF2mtw3RnNVnjQqWU=;
        b=Wfb6Au+r359myaqQ2pElCf4v83I1xFl8Xe6bSUwvKs7UPtnGJ2jXmXJ+a7mTGwm9kO
         /t32YosEfYMzwKm/NDYGmNzOIS5UcguvEn8BVIZ3VR7pSySBMW+VPEf8XlxKSjJszoxV
         CgYJb5hWSHQJkr03MAVPwY3iXnw6V9ftNCXxkF+VuvSw5U9GWP5+xNXRaaMs3OI9idKi
         /YCmk2f8HtSql5Y7R65NUW2v0TQ+Cn5FBnCy/c7OGTeAPpD6W2gS8WtFDYrQprUlwcqu
         N0rGriv6BedaEEzMCNKUwcZ33FAPxi0jgHf+O6ZcHUCwe02j+rkCQmdSYUTm9SKWLaRy
         hA8A==
X-Gm-Message-State: AOAM531+moRufziNMLGIEuH/mIJ0YMbBBRQdH3sd3gGEJt6aMU1MH2Om
        +ZPAlfFvywpwGimUcG04qZU=
X-Google-Smtp-Source: ABdhPJzVT8cd94vbPxGc0nxIGNlrqOnQ6oDaCVeqJHB9EtPpJj6BOJCsOi8IyP049cXXGOw+y1HUVA==
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr14815847lfg.268.1643799848868;
        Wed, 02 Feb 2022 03:04:08 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:08 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 15/16] memblock tests: Add memblock_add_node test
Date:   Wed,  2 Feb 2022 12:03:14 +0100
Message-Id: <e2d0e6dd264c8c169242b556f7c5b12153f3dee5.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple test for NUMA-aware variant of memblock_add function.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 96af80bf9df9..02eb88358a58 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -55,6 +55,39 @@ static int memblock_add_simple_check(void)
 	return 0;
 }
 
+/*
+ * A simple test that adds a memory block of a specified base address, size
+ * NUMA node and memory flags to the collection of available memory regions.
+ * It checks if the new entry, region counter and total memory size have
+ * expected values.
+ */
+static int memblock_add_node_simple_check(void)
+{
+	struct memblock_region *rgn;
+
+	rgn = &memblock.memory.regions[0];
+
+	struct region r = {
+		.base = SZ_1M,
+		.size = SZ_16M
+	};
+
+	reset_memblock();
+	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
+
+	assert(rgn->base == r.base);
+	assert(rgn->size == r.size);
+#ifdef CONFIG_NUMA
+	assert(rgn->nid == 1);
+#endif
+	assert(rgn->flags == MEMBLOCK_HOTPLUG);
+
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.total_size == r.size);
+
+	return 0;
+}
+
 /*
  * A test that tries to add two memory blocks that don't overlap with one another.
  * It checks if two correctly initialized entries were added to the collection
@@ -230,6 +263,7 @@ static int memblock_add_twice_check(void)
 static int memblock_add_checks(void)
 {
 	memblock_add_simple_check();
+	memblock_add_node_simple_check();
 	memblock_add_disjoint_check();
 	memblock_add_overlap_top_check();
 	memblock_add_overlap_bottom_check();
-- 
2.30.2

