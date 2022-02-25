Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3504C44BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiBYMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiBYMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:41:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369991E4820
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:40:59 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11CA33FCAC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645792858;
        bh=PQyFtNV3tW1qRmwZ8HqaxvUDcyO7BHPqZZLC0geQ1k0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ae6uwJoC7HFzBfCRFar5n4oo8URjTrhqDLUy+iEc11IBAdnXENDiWBeq0HdQzIx6O
         JKgMxNIz31k2Mew4emurIYzwawPv9ApigXVoU8I02ZEUlflbvFssM0pewq75qziPwK
         Fpvo3VOJkzq4ze0RbML8LpiFue7xYyjWaxrDtxxsixyf7sSZAYUs8ctumU4VXid72e
         eKVNy4VvGF4iT0VMSVkbehNqX7ZljzmzqLh98pr0yQ8XPBM2o+hsMcFBz/yUeAUOun
         G5BdTWqcoKX+Z0rsY6GafwqjatY1bTgQ3CrHg/5M0B8+EYJdlZsSy9Gcse7lMqljJv
         82nOslOOxrEsA==
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b0037bb9f6feeeso1508042wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQyFtNV3tW1qRmwZ8HqaxvUDcyO7BHPqZZLC0geQ1k0=;
        b=t9yoZphzXm4qiJDAq2KDTkzGhW29tOxIMTiXIyfssRYNbN3CY3Ygmg8j4Elwc2HPGt
         uPKygaBYxslS0J8G8+yHEpSu/EB6wWW3mfT6K5INASAn6vW1Lpf4+v6UUEl4CATjDDHv
         lYooiTJqEvpJPyjrZtc5miEjtBOweyv8gjmbVj2bzWNt58lls1gWAnjBRuhrBwoBaZ8x
         KFhcMWKo4Biy3bGDvS1K/CoAsEQCSzpfz9IvrqPK41nMJbm+MD//Iz7YPeT5HI3uFeIR
         qmav9MWMzhp4ZIq/+PDN0y2nniTMQdULtCng3QIwTneqI5ZBXjcKRznp9Atg5TMfNSKP
         L7EQ==
X-Gm-Message-State: AOAM530MKou4eAPSa5zeX46oF2+OSvWy1A9Rq0j4REu3Sh8RjgSSlz3x
        q6NJXafLEO/PTnf86Psy5aAfnW/iY5FQvDkXsS9rAlzlO/yt4KGasYOXGoGqr0r67hU2RMsJblx
        GfDEd/5UE0AJQ8cyI+weXDaUHnWeD3IOhls8tzuhvNA==
X-Received: by 2002:adf:a54c:0:b0:1ed:ab82:d5c with SMTP id j12-20020adfa54c000000b001edab820d5cmr5903436wrb.636.1645792857567;
        Fri, 25 Feb 2022 04:40:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwT+su/PUtxfMPaEWHXQEsOYe5HRBKTe0eLxFb9GXFhSjzcIXlRc3bYFdCjzbmxa8WeOAipFA==
X-Received: by 2002:adf:a54c:0:b0:1ed:ab82:d5c with SMTP id j12-20020adfa54c000000b001edab820d5cmr5903415wrb.636.1645792857391;
        Fri, 25 Feb 2022 04:40:57 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b001e551ce8a64sm3228332wrv.9.2022.02.25.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:40:57 -0800 (PST)
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
Subject: [PATCH -fixes v3 1/6] riscv: Fix is_linear_mapping with recent move of KASAN region
Date:   Fri, 25 Feb 2022 13:39:48 +0100
Message-Id: <20220225123953.3251327-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
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

