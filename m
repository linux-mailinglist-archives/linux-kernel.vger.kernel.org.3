Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5077751B85D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiEEHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244920AbiEEHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:04:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E67747561
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:01:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x52so2937802pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2zyKE+PVmtj7g0356+Wr3B8/m6MZ/HU48TwGSTdFsA=;
        b=Qa9+6KsCJCAs7+O/kPuceAYf4+lLRyZhxQwr4acyqao8irXOV5wnhSOmFIkRQXcIxv
         3evAUwN4BXH/0OZxsmgFFEcRTU2LqSaRc0/ATm6rVZm5yEnU2TMHgdjhveVgfvMxdFRY
         CiwD2yd781xhHXTd4eUzXcwQJoC+rNjD9N42bEj/caGWVLfd1TiURjxPbYMXHLfbqPAK
         iEx5prEM8T2vcB0NANHRqzC47IHcUILQDw8H+NnLJFGRUe1LhbjScjPYg7MsUKKnbgug
         R6TXr1tWDectWAyCg15kdGMwHQPzv55xqVu88fQ6kVYaaEMBX4Mi6pz3Tdt4/FcG/I3P
         XyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2zyKE+PVmtj7g0356+Wr3B8/m6MZ/HU48TwGSTdFsA=;
        b=WCWUDhw0F3NluGrirMp5mNMweRfI7VU8anipXacwM4P4BRF1oE2iKWnDWMPIkh52oz
         3wRL0jRDw1Hbg52mmabL0PZWRA5o0AuYuQmVQwov/oFowONaeJAkxA9ojE/096zdHyz1
         ISvrKMkl3EaDYzBbsc/AAfyLIsU2jyAKoqP31YOvWHgbX2sR4O5YafhlzPC/jUObREDk
         OX9jcUBsHV5lrCxrNRTA/vS6YuwlYb5LLLG/j7XozHadi0i/dgfA6KuTUQp4Yn0l8N/1
         wJIMIXHauRJbZq595hXVPwa3LBB//FATNckD785rQGCbKoAIfYanTp5JzW0WihOKZ9s/
         Ecfw==
X-Gm-Message-State: AOAM533fo6KHuOS1o90tRMxYrQ+IE59w4k424Cu3l095wCVkA+fZ2Fff
        w7dxOaTlp+g+OssD0YXhuF0=
X-Google-Smtp-Source: ABdhPJyQIdHw26kVDMEddyLAMnmpw7It68/iLkLMKqGsmJ6sFRN2DxbTdfgt+Xam5aKAWUAQ+U5UAw==
X-Received: by 2002:a62:5ec6:0:b0:50d:a467:3cb7 with SMTP id s189-20020a625ec6000000b0050da4673cb7mr24431354pfb.85.1651734075331;
        Thu, 05 May 2022 00:01:15 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id a7-20020aa795a7000000b0050dc76281e6sm566385pfk.192.2022.05.05.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 00:01:14 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool
Date:   Thu,  5 May 2022 16:01:05 +0900
Message-Id: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/kfence/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index a203747ad2c0..2ab3d473321e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -642,6 +642,13 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
+	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
+		struct page *page;
+
+		page = virt_to_page(p);
+		page->memcg_data = 0;
+		__ClearPageSlab(page);
+	}
 	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
 	__kfence_pool = NULL;
 	return false;
-- 
2.32.0

