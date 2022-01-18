Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA5492DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348451AbiARSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348444AbiARSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:54:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06827C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:54:00 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d7so3873185plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPKAqa/Yie4EjghZwtk9ckw9e3jN+xr2r/YDq6C8TvY=;
        b=on6V4hjBVDuWhH4VB6UgYcuhkCcJqCr99ziHlKCxL2t87PV7NLEWtA2fnOonJv7bS5
         I1Tybi1o8qrOz5irlU3xjkO5kVou8vFxUoEWUR2+tjRgPRnGoXjb8l7Gry63Wzdjekx1
         pJYLanLDoQF7Bhip98Q4W0To+u96wHtFJeVbaypQ+9UTQmn4RWttdLddbcnjp2eKndvi
         +tC/K6Oyc+3FwUsghA3qG91oi6POwFZTY1lsOi0SPM8irsADjmLHsgHwkwFgEy8CNEaD
         ObCjkEWtfnsZu2hLZ4rfwVK3JpaUeOULrve9lh0wMFbkkGUJ7etqgolkrSHBwv0uKhDm
         T06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPKAqa/Yie4EjghZwtk9ckw9e3jN+xr2r/YDq6C8TvY=;
        b=lxC9MEV6oLmz/7IksAyJUYJYNT0iKx5hQCt+iHQuuadJm2xjkN9Z3aVmyMe16L4wzy
         7t7zHbfVhdoHL/eBdMRQGLNAo8IiY+pQwcJdHdJ/4J3rqTNKctXs/0HbOjKJ2C3BZPdg
         oipp9Dxqi39mIpe2RjuC+fjVwN388COJEnu+/rTRpFmgbswk9i/HDut/zcplQgO3OuSJ
         ev11jDDKZXME+WzPrr5UqbxywocT3dz5BwjoO8lwwODMTdETc5UOcTRz0UNTbwm6G3nj
         OIY6694jaglg2pQiE8M8KyP7cfbQ+SNOeR0IxtcC4sBJIEOs/V5lDhS2ivAMwum4C4zz
         iWHA==
X-Gm-Message-State: AOAM5314oaqZvkTeeH9x5mceLmqk5D65RvxBYTDeboTntPB/CTZL8vxz
        wFwRpFNBJ5+JzIXBNiuwELI=
X-Google-Smtp-Source: ABdhPJyVHwdrjVqcP4OCoFFTUiP+ukPRMSGf89wPp+23eFVMBzv6npJ5NwS0gC1cdR4jQ7ntY3uSvg==
X-Received: by 2002:a17:902:6841:b0:149:6791:5a4f with SMTP id f1-20020a170902684100b0014967915a4fmr28650293pln.123.1642532039454;
        Tue, 18 Jan 2022 10:53:59 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id oc11sm4076333pjb.5.2022.01.18.10.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:53:59 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [RFC PATCH] arm64: don't vmap() invalid page
Date:   Tue, 18 Jan 2022 10:53:54 -0800
Message-Id: <20220118185354.464517-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap() takes struct page *pages as one of arguments, and user may provide
an invalid pointer, which would lead to DABT at address translation later.
Currently, kernel checks the pages against NULL. In my case, however, the
address was not NULL, and was big enough so that the hardware generated
Address Size Abort.

Interestingly, this abort happens even if copy_from_kernel_nofault() is used,
which is quite inconvenient for debugging purposes. 

This patch adds an arch_vmap_page_valid() helper into vmap() path, so that
architectures may add arch-specific checks of the pointer passed into vmap.

For arm64, if the page passed to vmap() corresponds to a physical address
greater than maximum possible value as described in TCR_EL1.IPS register, the
following table walk would generate Address Size Abort. Instead of creating
the invalid mapping, kernel will return ERANGE in such situation.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arm64/include/asm/vmalloc.h | 41 ++++++++++++++++++++++++++++++++
 include/linux/vmalloc.h          |  7 ++++++
 mm/vmalloc.c                     |  8 +++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index b9185503feae..e9d43ee019ad 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -4,6 +4,47 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
+static inline u64 pa_size(u64 ips)
+{
+	switch (ips) {
+	case 0b000:
+		return 1UL << 32;
+	case 0b001:
+		return 1UL << 36;
+	case 0b010:
+		return 1UL << 40;
+	case 0b011:
+		return 1UL << 42;
+	case 0b100:
+		return 1UL << 44;
+	case 0b101:
+		return 1UL << 48;
+	case 0b110:
+		return 1UL << 52;
+	/* All other values */
+	default:
+		return 1UL << 52;
+	}
+}
+
+#define arch_vmap_page_valid arch_vmap_page_valid
+static inline int arch_vmap_page_valid(struct page *page)
+{
+	u64 tcr, ips, paddr_size;
+
+	if (!page)
+		return -ENOMEM;
+
+	tcr = read_sysreg_s(SYS_TCR_EL1);
+	ips = (tcr & TCR_IPS_MASK) >> TCR_IPS_SHIFT;
+
+	paddr_size = pa_size(ips);
+	if (page_to_phys(page) >= paddr_size)
+		return -ERANGE;
+
+	return 0;
+}
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
 #define arch_vmap_pud_supported arch_vmap_pud_supported
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 6e022cc712e6..08b567d8bafc 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -119,6 +119,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
 }
 #endif
 
+#ifndef arch_vmap_page_valid
+static inline int arch_vmap_page_valid(struct page *page)
+{
+	return page ? 0 : -ENOMEM;
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..ee0384405cdd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -472,11 +472,15 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		struct page *page = pages[*nr];
+		int ret;
 
 		if (WARN_ON(!pte_none(*pte)))
 			return -EBUSY;
-		if (WARN_ON(!page))
-			return -ENOMEM;
+
+		ret = arch_vmap_page_valid(page);
+		if (WARN_ON(ret))
+			return ret;
+
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-- 
2.30.2

