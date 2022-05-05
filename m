Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6442A51B953
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbiEEHoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbiEEHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:44:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8218388
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:40:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d25so3014887pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5+cU6rju5q4PixcXKa5q0u5g3HxteJZ5Y7imLW6zec=;
        b=aC1SKi4r1y8gQCHUieTZ02NfjxR/NT7PnVvgPER49hsL0t10jaJr0/EOvqWfXWWZbi
         hui3ac+un3NS7SeDvijuxGNLKCFTPZ0nIGSJrX8WOBSC8RKLxx10nTmR9wmBMwkk0Ahi
         pDRstdJIC4m7UfS73Z3CESXtKP116DxrNOTFNDtnRkZZFDe4HQ0KlWyN2ahpRwj75ZMp
         0jjvUstov+9usyDNkTkyoFTMlL4VUEM4V5LMW5VkaaYQIQxeDOD60kh00nGp2sxg1MfB
         pADNqPC4D2W/tHZfunItlxaXoJKfBQ0PFVRHV7WR01soQBeOpeQG4nQXd6srhyskD7Kw
         1trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5+cU6rju5q4PixcXKa5q0u5g3HxteJZ5Y7imLW6zec=;
        b=UDGulMN6RF1nrmJKItnSf3t7fb0z4FaML6sjoHdLpguzaq3OmPgj77v1JXmIVZHaft
         skoJBIVIMUSHaYtDZmzWiSnLDCvhnjzLCn2pXPUeSRdQUHIAG1noH52eZ67svPRl6g9H
         b2Dhls2+3NA+TCoNkzaLMRITjA1yZG8zU6M80hUDoeSL6aKTw333u2ir141eInpRE/2k
         ZzTkRTKZi4SfR1NMypDqquEtfB4fiWYlwWWWNTM5h0Qp8DYuSGv857zCQ/Yjz3ScXoMw
         lenqDsD6hYWAIPPimvwM3Lb4ly83rpfpVunlgyDEFNl/PjvKNAfCaPT8dJWuYi9IJq/K
         xsyQ==
X-Gm-Message-State: AOAM532hfu/ZHWZBHOIF8tN1wX1tAjV6tyKXvNIc5lEuSwXAWVn3q/1C
        rCci3y1KiS4MFn+szpTs+r4=
X-Google-Smtp-Source: ABdhPJw20k22tZv728rddyr0QfZY9ymgsPLiRKtRYR7lT+jEnb5pM2AP2kMYj3hTQiSrMXTAZIqQlQ==
X-Received: by 2002:a63:1d26:0:b0:3c1:eb3f:9daf with SMTP id d38-20020a631d26000000b003c1eb3f9dafmr18535970pgd.284.1651736438698;
        Thu, 05 May 2022 00:40:38 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b0050dc76281dcsm655084pfb.182.2022.05.05.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 00:40:38 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v2] mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool
Date:   Thu,  5 May 2022 16:39:20 +0900
Message-Id: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
References: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kfence fails to initialize kfence pool, it frees the pool.
But it does not reset PG_slab flag and memcg_data of struct page.

Below is a BUG because of this. Let's fix it by resetting PG_slab
and memcg_data before free.

[    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
[    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
[    0.089150] memcg:ffffffff94a475d1
[    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
[    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
[    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
[    0.089152] page dumped because: page still charged to cgroup
[    0.089153] Modules linked in:
[    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
[    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.089154] Call Trace:
[    0.089155]  <TASK>
[    0.089155]  dump_stack_lvl+0x49/0x5f
[    0.089157]  dump_stack+0x10/0x12
[    0.089158]  bad_page.cold+0x63/0x94
[    0.089159]  check_free_page_bad+0x66/0x70
[    0.089160]  __free_pages_ok+0x423/0x530
[    0.089161]  __free_pages_core+0x8e/0xa0
[    0.089162]  memblock_free_pages+0x10/0x12
[    0.089164]  memblock_free_late+0x8f/0xb9
[    0.089165]  kfence_init+0x68/0x92
[    0.089166]  start_kernel+0x789/0x992
[    0.089167]  x86_64_start_reservations+0x24/0x26
[    0.089168]  x86_64_start_kernel+0xa9/0xaf
[    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
[    0.089171]  </TASK>

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

v1 -> v2:
	- Use folio instead of page
	- Add Fixes: tags
	- Wrap #ifdef ~ #endif around folio->memcg_data = 0;

 mm/kfence/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index a203747ad2c0..bb1c6c489d0a 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -642,6 +642,15 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
+	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
+		struct folio *folio;
+
+		folio = virt_to_folio(p);
+		__folio_clear_slab(folio);
+#ifdef CONFIG_MEMCG
+		folio->memcg_data = 0;
+#endif
+	}
 	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
 	__kfence_pool = NULL;
 	return false;
-- 
2.32.0

