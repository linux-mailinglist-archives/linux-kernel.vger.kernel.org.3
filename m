Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB78349E351
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiA0NXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbiA0NXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:23:06 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b9so5290993lfq.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsGfx9/8KzrBT+1sl0kUz+F3kyiF2mtw3RnNVnjQqWU=;
        b=pBfr0ZdgfwSQlmVaKdWWDCyJf7WHwwj4gjom2y9UVzOH0uZsh7NoaiX0bEMbblnVMl
         gr94plKxbtAXvDdOA9rkxkrRetv50PzGmXOkD5vRZCGk5Nqbb8llb85Nki3tg0S1Li6e
         8vIeYW2c+foSRgcTU/m6YlQN2ni/y7sYwKmIyboMFbAKzNoaPPo1N+Bq1IUgFmU5ilMs
         zURht+DOAqdnVeFHgLw9kqMRLFWkdy06QR8dSs/Imu21u5RSz8XDftKSEepQ4P876Ihk
         tvc52IkkrOcPqJUEvf8FCSCDcY1y4J3CJhjqwT9SzIzYyme/ClvYcCKlyb5mFHtCbo8n
         k/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsGfx9/8KzrBT+1sl0kUz+F3kyiF2mtw3RnNVnjQqWU=;
        b=rIsyxE30LQnCiWBfkhz26avxDarOrFresw+/2k4fJ/uZNmBj397TgPsRTknnUG1soa
         2cL/phuZjT37tnsR38oQhzH8mtUn8QeiRhNVcNAJwfrOXPOQQKWrs9edmi8xc29hVZpw
         Pn8CWfyxik8dAS6UcMb79yGOX90n1JAyAZ+86EKFkN0lfTtmWWoop293U+XzbSe0Ud2s
         1Tp074h+OB1bOt4ymkUlLQnAc1svfZKl5eC5OiG1NGPteCqv/2grBxrS8dLzu2xNh6eK
         djRkuywI2pQfA3C5LQpSzMbJK0u2++mvJV3sNeN9vYS5AsRn9UoAau/06A17TRwseBTB
         RsMg==
X-Gm-Message-State: AOAM5325M0zYoQCUrnx7N90adawEE5jJokU2jXGp55jGu6pFtXXzSioX
        Z4gkkNu445QOi7p+Bj5Mf5Q=
X-Google-Smtp-Source: ABdhPJwa2MmtZ0Byc/fh4qu/MTl/En4nmMDVSl4RidluFDaPogFkFEtcbN4TnKkuYismkKC3orMn7Q==
X-Received: by 2002:a05:6512:1502:: with SMTP id bq2mr2720757lfb.551.1643289784104;
        Thu, 27 Jan 2022 05:23:04 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:23:03 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 15/16] memblock tests: Add memblock_add_node test
Date:   Thu, 27 Jan 2022 14:21:33 +0100
Message-Id: <d1f86fdb7b1eb4cc4daef09e35fc8a1795657f89.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
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

