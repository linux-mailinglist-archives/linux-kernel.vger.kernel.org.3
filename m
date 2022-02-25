Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C024C44D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiBYMph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBYMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:45:36 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D51C8847
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:45:04 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BCDB840017
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645793102;
        bh=SnSbt9srZ7OcpfO0TO3d0HjnXYX+4WJ6SgK04DiqgE8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bcEi+LRiTemlC7Hj63WfwVaBWrkJ6xI0+QDibvP7bLfF+CmKjYWpu0MIIlYHLDZXU
         zs1bFHorBWqxTimKZlX/U0Va8OvbWkKVF3aeO9i5jQTwi9l1a/QOACSr9rSxqX+Qhx
         m+GARMgijfuxqQVTVF0YcoVAHVjXC/I/TS8YQIjFx2xvBShUoLmiz6WLLvtyqG79pf
         Png5lW6KSjhxNRhnlBErHRotSf0uScw9OWAv6qKIaT6HUaKhhYrJtLf7pqBiZoM0Oz
         viNNFKRvi6DmzuMI2o4N+1r+DH1VfkzJA1EOGlKXMYpm+8uJEmxtso/VmgKjKbbT4J
         d8BTk+vYhecTg==
Received: by mail-wm1-f72.google.com with SMTP id r8-20020a05600c35c800b0038118108e71so1266302wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnSbt9srZ7OcpfO0TO3d0HjnXYX+4WJ6SgK04DiqgE8=;
        b=aNMnUwpbUuF+xQDgHSFCjXOrZfxAUAfNlakJW+w/8e+Kgo2sm7A5aXBFRbxJORPtjz
         KMJgBPkIyod686fPFMP308ENkFI/UfMXKPRErr8wvKzEvCviWZKmLZB1AwtN+VW0OLRc
         kmF1OrQsbSeyqmnqEFtezoF7RcwJPJF94l/ZjXw6KsqYHmgaRh8+vUCfGReKLt4TDhQb
         Y8f9udNM4C0kZLxg1YC0nSSb0nKNUBlSBvOi/GljU66DQc1lwUCcaAUFbgX5cN5Oa9La
         DWX/YieQ7vj4qqegZUdc7H1IqZTXZN6umK+57M0s6CY80O/SN5AFNWzN9jnfwCapRIqO
         CLuQ==
X-Gm-Message-State: AOAM533gAdKOFWBpIJT7i57atSnblFLxQH+ypgvKRrC9htsb+o7uGgi2
        b8bBFCjqMbioYM77MHxwEWce3A5prw6Xbfg88zPFm0iw2TarbDurbt0/w4CAeoXfYwAKJWUW3RJ
        JnBoUS7LjMkkKr1GLuu/tTPzE6LUUMzkOVeTKD5DF0g==
X-Received: by 2002:a5d:6a41:0:b0:1ed:c1da:6c22 with SMTP id t1-20020a5d6a41000000b001edc1da6c22mr5742732wrw.473.1645793102134;
        Fri, 25 Feb 2022 04:45:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQgKrZu6jaYzaCu1NYJXPtNkDwJhWrhUHTE8uagr23ma/j8UbcytWvj2M2yAnW2lyu4uqPTg==
X-Received: by 2002:a5d:6a41:0:b0:1ed:c1da:6c22 with SMTP id t1-20020a5d6a41000000b001edc1da6c22mr5742718wrw.473.1645793101972;
        Fri, 25 Feb 2022 04:45:01 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600002ad00b001ea78a5df11sm2712125wry.1.2022.02.25.04.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:45:01 -0800 (PST)
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
Subject: [PATCH -fixes v3 5/6] riscv: Move high_memory initialization to setup_bootmem
Date:   Fri, 25 Feb 2022 13:39:52 +0100
Message-Id: <20220225123953.3251327-6-alexandre.ghiti@canonical.com>
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

high_memory used to be initialized in mem_init, way after setup_bootmem.
But a call to dma_contiguous_reserve in this function gives rise to the
below warning because high_memory is equal to 0 and is used at the very
beginning at cma_declare_contiguous_nid.

It went unnoticed since the move of the kasan region redefined
KERN_VIRT_SIZE so that it does not encompass -1 anymore.

Fix this by initializing high_memory in setup_bootmem.

------------[ cut here ]------------
virt_to_phys used for non-linear address: ffffffffffffffff (0xffffffffffffffff)
WARNING: CPU: 0 PID: 0 at arch/riscv/mm/physaddr.c:14 __virt_to_phys+0xac/0x1b8
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc1-00007-ga68b89289e26 #27
Hardware name: riscv-virtio,qemu (DT)
epc : __virt_to_phys+0xac/0x1b8
 ra : __virt_to_phys+0xac/0x1b8
epc : ffffffff80014922 ra : ffffffff80014922 sp : ffffffff84a03c30
 gp : ffffffff85866c80 tp : ffffffff84a3f180 t0 : ffffffff86bce657
 t1 : fffffffef09406e8 t2 : 0000000000000000 s0 : ffffffff84a03c70
 s1 : ffffffffffffffff a0 : 000000000000004f a1 : 00000000000f0000
 a2 : 0000000000000002 a3 : ffffffff8011f408 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffff84a03747
 s2 : ffffffd800000000 s3 : ffffffff86ef4000 s4 : ffffffff8467f828
 s5 : fffffff800000000 s6 : 8000000000006800 s7 : 0000000000000000
 s8 : 0000000480000000 s9 : 0000000080038ea0 s10: 0000000000000000
 s11: ffffffffffffffff t3 : ffffffff84a035c0 t4 : fffffffef09406e8
 t5 : fffffffef09406e9 t6 : ffffffff84a03758
status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff8322ef4c>] cma_declare_contiguous_nid+0xf2/0x64a
[<ffffffff83212a58>] dma_contiguous_reserve_area+0x46/0xb4
[<ffffffff83212c3a>] dma_contiguous_reserve+0x174/0x18e
[<ffffffff83208fc2>] paging_init+0x12c/0x35e
[<ffffffff83206bd2>] setup_arch+0x120/0x74e
[<ffffffff83201416>] start_kernel+0xce/0x68c
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<0000000000000000>] 0x0
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c27294128e18..0d588032d6e6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -125,7 +125,6 @@ void __init mem_init(void)
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
 #endif
-	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
 	memblock_free_all();
 
 	print_vm_layout();
@@ -195,6 +194,7 @@ static void __init setup_bootmem(void)
 
 	min_low_pfn = PFN_UP(phys_ram_base);
 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
+	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
 
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 	set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
-- 
2.32.0

