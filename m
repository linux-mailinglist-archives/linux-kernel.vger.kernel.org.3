Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91194A6F79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbiBBLEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343662AbiBBLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:55 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4EBC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c7so27807488ljr.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35RmHaXHeK6m669VGWye938TGxDNkaZqMu9rSBAQF5s=;
        b=iriYzWQQQuIEbwIOBGA7gwki+VWO7WGgX0RWVj4GkjUWR+x9I0WaoUPnrY5Cnuvle/
         sXpOo6Okrj63d6O2su7feqzRGbXcv/jFHnwmUPR8ogS7Tqp2phkfJVslXD9AoM6nEeZR
         un7Omyth80LhWDVTi/fZPbezrRrRIwQn9WmgxL4QhZcQkLJxnHfqhkpblYTb2FsaJ1aC
         vGiomCvAh3ASV7HdCTgDonFWHHXUkxuo5sPKdvCZUcsc1eAaKAGiby4BdNVXz1H3WasR
         Kq9UUk7NxpS1H7RDWF8zWYKoWPUEbjKeYdgH1cWqRDLMRPErEVdq+2ZR3Solup9alXPO
         CvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35RmHaXHeK6m669VGWye938TGxDNkaZqMu9rSBAQF5s=;
        b=lPicT8QrOvf78Efgj1QAHz70n+jz64tOFRwIgr1IfN/+rj/tn83z0cnTAatREz7v0X
         JkWWTBOGvJJMBXby7jef2R0tdbNLNstcnIf71kQMm4m2mlQ932QJX+2zEV/a9bzReTQ5
         j48s+fkn39hyUk4FBXho9kCRMOAGpFPBtFR34sMfk9vO6g1FG8v6xHKvN45FWzzQu53X
         7YIjeAmE3RWMJ3BQPqbQV+v4plsmYXvSffOTH6Wg99bsPXyeqMYoOgzpaj5lPSKz7QVk
         0FOqzCWiGVz0Q+gGRXYaRb4vpj5OhZ6JAcPd3gJrp1/dlvFcz6fQOvd9RE2OWnEPrkf8
         Adkg==
X-Gm-Message-State: AOAM533M+kTnIkTgd/tRrvgGK/A5bnlzPewn4Z4CDAkBfoBD3B7ZQtek
        sQNAOiwOtGs4WjVas/sGxQ7sxpR5LeA=
X-Google-Smtp-Source: ABdhPJzf5EQFzhhhN2QtspLpurN74Ru+mcLyZF07LMqC3jwh3X5/Z3PJtlCYF9CkFA35hYyQXB4ZfQ==
X-Received: by 2002:a2e:502:: with SMTP id 2mr18883481ljf.445.1643799833296;
        Wed, 02 Feb 2022 03:03:53 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:52 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 05/16] tools/include: Add mm.h file
Date:   Wed,  2 Feb 2022 12:03:04 +0100
Message-Id: <e8b83d96fec95f3556e80f001d9d5cbe18b8ad5f.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a stubbed mm.h file with dummy page-related definitions,
memory alignment and physical to virtual address conversions,
so they can be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/mm.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/include/linux/mm.h

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
new file mode 100644
index 000000000000..a03d9bba5151
--- /dev/null
+++ b/tools/include/linux/mm.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_MM_H
+#define _TOOLS_LINUX_MM_H
+
+#include <linux/mmzone.h>
+#include <uapi/linux/const.h>
+
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
+#define PAGE_MASK		(~(PAGE_SIZE - 1))
+
+#define PHYS_ADDR_MAX	(~(phys_addr_t)0)
+
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))
+
+#define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
+
+#define __va(x) ((void *)((unsigned long)(x)))
+#define __pa(x) ((unsigned long)(x))
+
+#define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
+
+#define phys_to_virt phys_to_virt
+static inline void *phys_to_virt(unsigned long address)
+{
+	return __va(address);
+}
+
+void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+
+static inline void totalram_pages_inc(void)
+{
+}
+
+static inline void totalram_pages_add(long count)
+{
+}
+
+#endif
-- 
2.30.2

