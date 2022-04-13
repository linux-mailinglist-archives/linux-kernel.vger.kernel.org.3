Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8B4FF6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiDMMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiDMMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:31:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978863C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:29:37 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k14so1692573pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7RNiZg/8gOIIES7OOcwf04Do6rZvxL0SbEAQMOefrA=;
        b=ol1Cr0DK4iBnjeMMAZ0tbtH8YzJRU++cW96aYH/4gd+XbhPNsev+CBDM2Br7CKQ1iL
         Wigc/enFmo7ZRqfwiBOOsYSAMpsj1/vVswGtX5PkeWUHkV+r/DDgE6lg8UCJhJuyStR4
         DzG03G4TEfhG8RPFm3MbkTG7woMA1/F19Ty+t3UpxkO2WT5McQdMNJUc8RxEXSa9EN8p
         w+BhXGur0FNoDB9myvJsKqNjd/lzLXD5AwlpHG2HKnzA6s2bT24y1EA+Bu3cXQhg/Xqp
         E6G7naSVOBWZScMOJIc8P/7HahJm8dLj+vrW3SGmZQRryYeCKMMiL03DW+eS2+EyKCy6
         TLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7RNiZg/8gOIIES7OOcwf04Do6rZvxL0SbEAQMOefrA=;
        b=Ku5N0UhnjBTT65MPxd86++cTqKBF9WbMuKrXB1/GwZsj1iuK0vNy4fzEh2wCZjZQIs
         xr0qxr7Mr0v8aHI3b/zFid9pchJdh4HMqiwzLo1/eo2kzczBGHAbYpOy6AgnrmROfkq/
         LMq8zCPibW8FvpzQHk5rUeIR6nehpwan6pVWpyyyCQo9z1j5XyS/+8lLg1bMvKKHf4aW
         II6EhfNtQzd5+hQ+8xTpZGEGaEWdToV6HR/ZGpwBYDsdxxZhA/HaUJ2p8pg2puv/fh/Q
         9mMUldHa74d1hxap785dq/bWHUO/CsKCFtKWPuAR1y3wDIw4hlTtYIZS4SPlnNWlC3aV
         KdsQ==
X-Gm-Message-State: AOAM532yA3j4fO8cixIz4bH2iX4Np60ekr8C/gLeGxO1bElCoX5lp+6+
        BG+V8Rb67EFoZ06GTSysXGE=
X-Google-Smtp-Source: ABdhPJzAcODm/tZUkV37d3UPMuBYgn6AcKkV/ksm7+BT14CAeCE47JigBvPp1zMkgLchZFLCYrt08w==
X-Received: by 2002:a65:4503:0:b0:382:aad5:ad7d with SMTP id n3-20020a654503000000b00382aad5ad7dmr35057977pgq.488.1649852976951;
        Wed, 13 Apr 2022 05:29:36 -0700 (PDT)
Received: from localhost.localdomain ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id t31-20020a056a00139f00b00505b8a8ac08sm12403372pfg.160.2022.04.13.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:29:36 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patrick.wang.shcn@gmail.com
Subject: [PATCH] mm: kmemleak: take a full lowmem check in kmemleak_*_phys()
Date:   Wed, 13 Apr 2022 20:29:25 +0800
Message-Id: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmemleak_*_phys() apis do not check the address for lowmem's min
boundary, while the caller may pass an address below lowmem, which
will trigger an oops:

# echo scan > /sys/kernel/debug/kmemleak
[   54.888353] Unable to handle kernel paging request at virtual address ff5fffffffe00000
[   54.888932] Oops [#1]
[   54.889102] Modules linked in:
[   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-next-20220407 #33
[   54.889620] Hardware name: riscv-virtio,qemu (DT)
[   54.889901] epc : scan_block+0x74/0x15c
[   54.890215]  ra : scan_block+0x72/0x15c
[   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp : ff200000104abc30
[   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 : 0000000000000200
[   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 : ff200000104abc90
[   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 : ff5fffffffe01000
[   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 : 0000000000000001
[   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 : 0000000000000005
[   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 : ffffffff815d0e90
[   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 : ffffffff815d0eb0
[   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10: ff5fffffffe01000
[   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 : 000000000000000f
[   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
[   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000 cause: 000000000000000d
[   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
[   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
[   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
[   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
[   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
[   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
[   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
[   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2
[   54.894183] ---[ end trace 0000000000000000 ]---

So check the address for lowmem's min boundary.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index acd7cbb82..a182f5dda 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1132,7 +1132,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_alloc(__va(phys), size, min_count, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
@@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_free_part(__va(phys), size);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
@@ -1158,7 +1158,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_not_leak_phys(phys_addr_t phys)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_not_leak(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_not_leak_phys);
@@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_ignore(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
-- 
2.25.1

