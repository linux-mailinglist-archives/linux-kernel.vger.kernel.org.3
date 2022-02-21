Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2F4BE319
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379973AbiBUQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:14:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379972AbiBUQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:14:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02E62715D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:14:11 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7FE840326
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645460048;
        bh=PQyFtNV3tW1qRmwZ8HqaxvUDcyO7BHPqZZLC0geQ1k0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Pw8zIvxw8A6Tu9811T0MQ/EKgt2aY0nsNu+pz29KErjTymjyH3xZuOREbWsZtGj1L
         BU/x6aRF6Sd0KxpS3NfSmIrth+ezrzOwZM3cgPUWzNy4iDv5A9x5dKybHFt7bsMXLm
         NG83fDsWrbvFDtL8hjVAadebzmnvKtR7LIx79MWea08Y68hZuaQYOjp0NfVuXjmUyC
         fqQeJHJbJc9f8MEOW5Kld+Q244pFQLqTRKYpAq9j836uf3g9JvAazwI+gKyD1ndmnx
         JoNM6iBvXS7PTK3wwoUTNZVYUSAsoYR0+atuHFHvRGAJNdvoyp6hSq5H1TMciAeoBp
         MBtvmiDI3o9Dw==
Received: by mail-wm1-f69.google.com with SMTP id r8-20020a7bc088000000b0037bbf779d26so4574637wmh.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQyFtNV3tW1qRmwZ8HqaxvUDcyO7BHPqZZLC0geQ1k0=;
        b=3ow821xtATbkuFzNTH+qkiFvg6MyxIWBzvWqp6Cq/Ulpqut+9QFAPLrXpzpgRzpXn5
         YC+b7m8aqGaq0DXyG0nggAwcO+X16omyj+TzrHubbbCml0ouFI9vmirE2pypjLO9cIsr
         3whAquvejIv/dErJpoUJT4am14cSqKQec//hPXKZLu7YeuXtfzOoo8YfcbDn4jTaE+X4
         IS9wWnfwfzJotSGU4iRQtTbIw5Sz4OWlsnLRgr91m2wuLEVBbMpFQuf8Fm0UWD4MZoM3
         NuM1zyxLpLxYSTKjTzF0Z1/HrpfdRayJF8pTnQQlJribT8a5VadS0J2qqz+Ja2OiN8NJ
         imEw==
X-Gm-Message-State: AOAM532IPjJrTa/cKYG/hDgdRz0l71qGrlz7RvLStC9oHbtqJEGYRKO4
        p3TVLJrhUtySRusbP6qANmTGUNUFRXE5GHwWWM/VuI+bmcMihQPOFg7fypkgYPFWN+8i+Hf6bT7
        oDx+mAkGjtel8lDHQPeiyoM7ZvQp4UJCr/A4w1O5JGg==
X-Received: by 2002:a5d:59ae:0:b0:1dd:66c3:c67b with SMTP id p14-20020a5d59ae000000b001dd66c3c67bmr15950149wrr.400.1645460048037;
        Mon, 21 Feb 2022 08:14:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNwlTRPQUvSp/uTF60wmHJDYNhgiXOGL05nzjrbLdn6G2rJra00RbHGeqsfRNSqcTRx5zKzA==
X-Received: by 2002:a5d:59ae:0:b0:1dd:66c3:c67b with SMTP id p14-20020a5d59ae000000b001dd66c3c67bmr15950135wrr.400.1645460047868;
        Mon, 21 Feb 2022 08:14:07 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id o4sm32504065wrc.52.2022.02.21.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:14:07 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes v2 1/4] riscv: Fix is_linear_mapping with recent move of KASAN region
Date:   Mon, 21 Feb 2022 17:12:29 +0100
Message-Id: <20220221161232.2168364-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
References: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN region was recently moved between the linear mapping and the
kernel mapping, is_linear_mapping used to check the validity of an
address by using the start of the kernel mapping, which is now wrong.

Fix this by using the maximum size of the physical memory.

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/include/asm/page.h    | 2 +-
 arch/riscv/include/asm/pgtable.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 160e3a1e8f8b..004372f8da54 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -119,7 +119,7 @@ extern phys_addr_t phys_ram_base;
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
 
 #define is_linear_mapping(x)	\
-	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < kernel_map.virt_addr))
+	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
 #define kernel_mapping_pa_to_va(y)	({						\
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7e949f25c933..e3549e50de95 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -13,6 +13,7 @@
 
 #ifndef CONFIG_MMU
 #define KERNEL_LINK_ADDR	PAGE_OFFSET
+#define KERN_VIRT_SIZE		(UL(-1))
 #else
 
 #define ADDRESS_SPACE_END	(UL(-1))
-- 
2.32.0

