Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1814D4C45CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiBYNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbiBYNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:18:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345B1BD9B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so7373837edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dO8HMA/5Eh/PQhBGunCbdVuLS3TIlJbSFBfnd4KP1ZA=;
        b=t1h7EEni6r2llc8EEkysxjmDiPxl6J4C5lhfxag6JC9O9e7PAOVfpkv6BJgZconjrr
         Xru0HXOojShRdG81rPj8eO138b4c+CfrCb7nGFZ5PEDiEtxmMwgmJ4zai1HmbSdER89W
         asOsByb1VrR24v6pG5x1UUSnl/NxbvII5cy+RGwJoiK38FK2OtlBrzVi+GugWxwlqCuC
         WAVNctrEa7Dt0EobWgoPUL1qwuqIIXEsZsRQD4476ZjLOy8l1AjjbkZlhReGf8V5n/Tq
         3VdTJKrwiZ0F0gUrrbi0DSQ47xz0Z4aq/Vb4xDYSJUPDhc6oI7sGtRLHPI2xC/droCn7
         3MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dO8HMA/5Eh/PQhBGunCbdVuLS3TIlJbSFBfnd4KP1ZA=;
        b=OVkNbrvGX7nuwqQzm622tA3la2WNX5trDHdbny/7t7JzDKGcWZKDazuPUuATQB3d1h
         jDmUQPEZ17tyw5Q/iXscUL1xCFyWriFkUmMf+maDqy+Y7Tp3NwYm7l29sEJ8ekw4AW/G
         JXgQp2igj70g5knRYc3nq1cmRuiNBUbMJTVLnU2nyqn+VzqxJOMYM/Jk4uvu5BCwuJ0N
         YIz814hRJMfeXgUD5EfHCKruMa+GaFM1MvMtllFyy2n1qO2zQD2YvRzX/um9y5rkFSD1
         Yinon076enkWomrA6hlLwnwK+rNycyZ97P5qXlbsq4aZg8T96KPo568D+/5LPRHZk2tV
         wuuA==
X-Gm-Message-State: AOAM530yaPYZcXyES8V6bY4GMAgnqkJWtmF/V8ayYj/hXKjphZ+TmLS7
        9duOT6V2POmlLpatThQSFJSflbWMW5IkSw==
X-Google-Smtp-Source: ABdhPJxlF6V2OfbhO1lMwKSPZnxGj4kQY7uZeCZnsoHBQacIW0G3+ZuzweuRwehYY93PosvzfmtyuA==
X-Received: by 2002:a50:934b:0:b0:410:befb:cfd0 with SMTP id n11-20020a50934b000000b00410befbcfd0mr6957827eda.27.1645795057612;
        Fri, 25 Feb 2022 05:17:37 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170906ae4400b006d5b6de1803sm587621ejb.104.2022.02.25.05.17.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:17:36 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/2] microblaze: Add support for reserved memory defined by DT
Date:   Fri, 25 Feb 2022 14:17:31 +0100
Message-Id: <da4395776bf0de7207767abcc8a5df05bf411816.1645795048.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645795048.git.michal.simek@xilinx.com>
References: <cover.1645795048.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In DT reserved memory nodes can be added as is described by
Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
but Microblaze didn't have a support for it. The similar change was done
for ARC by commit 1b10cb21d888 ("ARC: add support for reserved memory
defined by device tree"). It is pretty much enough to call
early_init_fdt_scan_reserved_mem().
Microblaze is not using initial_boot_params that's why there is no need to
call early_init_fdt_reserve_self().

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index de0d8b03af21..f4e503461d24 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h> /* mem_init */
 #include <linux/initrd.h>
+#include <linux/of_fdt.h>
 #include <linux/pagemap.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
@@ -261,6 +262,8 @@ asmlinkage void __init mmu_init(void)
 
 	parse_early_param();
 
+	early_init_fdt_scan_reserved_mem();
+
 	/* CMA initialization */
 	dma_contiguous_reserve(memory_start + lowmem_size - 1);
 
-- 
2.35.1

