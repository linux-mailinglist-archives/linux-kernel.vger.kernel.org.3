Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCECA49E342
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbiA0NWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiA0NWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF66C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o12so5232313lfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35RmHaXHeK6m669VGWye938TGxDNkaZqMu9rSBAQF5s=;
        b=YUcoE76+4sjVcbnKqrHIRVuvrkgseo+HMN6QisGZ1lJTQYR/7eyxgZ+HuTT/jDU6W6
         RzXDKU5hXpi8CMeV2p/b7YwenLHUel2xK9gTf5LL8Yx7gbiJVjQuWoYgGtZ9xExLgECB
         00teM8r52fpGevmEPEo6rjvmFosQrztHzHLVHzB8mah8QBWnD4A6iFfcTHumfVMJLSxN
         oiE4+svngvELyB8dNHCWXiCnDvHAO+tr2sOrag3gN9M2nWoZnCqvCtz7HKu5DdHj05W7
         PBlR8viV1s66E1L2TmgbrNi5G+FXNBGkSOlTNfO1UmCbrX9T2QhVkOAv5q067eAiQq2G
         E0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35RmHaXHeK6m669VGWye938TGxDNkaZqMu9rSBAQF5s=;
        b=WILUKEKDYk3/8+gnmeCZnz1/8tGJF6i6u91I4SYO2DIN2dGKiJ++vBBVS9KBGQ5hI+
         vZjtgF/xvjwMSs9bQifPpj2OMlaf24m676ijsuQHRnpXP+g0uuxtMI0582nbI8rnebaG
         vyRHaWBflSmAkRpcZssjKl5OEmrlgGEPsle19nVe2Cwl2Nh6vYiszp87Ba2Z2boyeqs8
         QtzKD69kcLO5bRjfNeAiskfgSwJKAIA3lFenMtBDPWfQwsAEM98EziI1ScN5Y1B/cuk9
         +MmqZOXGU9zaXUBAlf4WHijlOaiy/fpNPtg5xY2UWR7+LV+4iqB3406zExoATP98F4EA
         BUJA==
X-Gm-Message-State: AOAM5304Jo0rP5SBR9AYMwdHI+ADSBETXJ2xYZ/2M2Vt8JDDync4+KjK
        Kb5sUOZI/m9VtCUNjS3dCLs=
X-Google-Smtp-Source: ABdhPJxGXS3Ydevkg8USVm6RAv96Sx5DoiZwm7Oitp+enfsZwD5opc4AidIKoa6LRYzdGYv7EB3/EQ==
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr2881216lfs.470.1643289761830;
        Thu, 27 Jan 2022 05:22:41 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:41 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 05/16] tools/include: Add mm.h file
Date:   Thu, 27 Jan 2022 14:21:23 +0100
Message-Id: <09f20db2ce4fa1dde0c397b0b6f8f8887af1078b.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
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

