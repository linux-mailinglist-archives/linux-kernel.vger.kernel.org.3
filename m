Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E708B46AAE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355715AbhLFVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:50:47 -0500
Received: from out2.migadu.com ([188.165.223.204]:65110 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355412AbhLFVuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:50:40 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhe5kEMNFRSnWjEMXar5wkGHtuo9NDKTQhUT0l8T7fU=;
        b=jRv2K2Ltk3F5wz4BzV2fccJSdYyc31RJmDOteBv/6VztOq/T+Cdioxa94cDFBW6Ax15zwl
        dVVKoIobsAYHqwIlB1Dmjg/h38gXHcZ0QytRMSJhPsqglzRtdH8RcYcuutAAQvS41BUqyy
        ndBkslAgLs45ddwWu5tiYcbgf/8lzzY=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 32/34] arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
Date:   Mon,  6 Dec 2021 22:44:09 +0100
Message-Id: <4f56dd2bfaf945032a226f90141bb4f8e73959b7.1638825394.git.andreyknvl@google.com>
In-Reply-To: <cover.1638825394.git.andreyknvl@google.com>
References: <cover.1638825394.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Generic KASAN already selects KASAN_VMALLOC to allow VMAP_STACK to be
selected unconditionally, see commit acc3042d62cb9 ("arm64: Kconfig:
select KASAN_VMALLOC if KANSAN_GENERIC is enabled").

The same change is needed for SW_TAGS KASAN.

HW_TAGS KASAN does not require enabling KASAN_VMALLOC for VMAP_STACK,
they already work together as is. Still, selecting KASAN_VMALLOC still
makes sense to make vmalloc() always protected. In case any bugs in
KASAN's vmalloc() support are discovered, the command line kasan.vmalloc
flag can be used to disable vmalloc() checking.

This patch selects KASAN_VMALLOC for all KASAN modes for arm64.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Split out this patch.
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..f0aa434e3b7a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -205,7 +205,7 @@ config ARM64
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
-	select KASAN_VMALLOC if KASAN_GENERIC
+	select KASAN_VMALLOC if KASAN
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
-- 
2.25.1

