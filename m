Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A651BD07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiEEKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355315AbiEEKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:19:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E419351E68
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:16:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g8so3288123pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOAcDGlSWe2Jb33NzDcQaYtU804KKEt7OooYW1HA4U4=;
        b=Fgh9cX+m5xcyqwOOpw5Jxn2Co881HgTaFW8hqLvN6T9iFRp6wJxkdwOH9WMnlguJ2B
         STHoH/FFDYncrqxYbclQyprPLjc4cEQOxZC/21bpPmLblsfF4kHHuIHYd1Y9jDeEnmt2
         r+Ygl25+//nu/1sfxpYdaCRv8oqzDVlqqyfdGxynS5IhwTbpbGsKiP6h7D38TakshvkX
         J8xjRUmfLNowcTQsdX2YJt2leWTJHgOitQuFqz765cEPcMZmXFN2Y1D79t4ykHQCc+/I
         Fg/e3eDPuu6H18cDUoOKpp4UZpOLEhnEpSJPlEu7BsbdHe0sJ/1MwSv1Ggz10GWgn7Lm
         etzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOAcDGlSWe2Jb33NzDcQaYtU804KKEt7OooYW1HA4U4=;
        b=7kQ2MXs8Mb+FVgTxJtTcigQTeL1uKmlqtL9KImQPCOQKNqoO0iljDEW+wajPMEVlLn
         S8CWIwDY3QmHTH1+zx8VKd9X2IOpOIOyjmvP1bDWh+iPrh/gH5UmNmpMdWLFTCAM8iEl
         6Oq4A1fXLSTsdQvtqu3Fqo607B9G6xLsG/+IKXR7RqY/y3aUD/h78getW+euw/kNgfZg
         2MSmbn8hE15a80KNyILfbjcb9NloecsIdZ8G1ev1ktVknjkrJ26tkfbDxYOJaGDpTsKf
         Qt+fLUCkHxGiff9evZe+tl/kP2yXy5z2OT6s/1ayS3vYpQR8qF0G6hVawlc/gCtmG9wz
         8OoQ==
X-Gm-Message-State: AOAM5305yBiKHS8jurht9SZZw/BmN87yC3VPxnqnilNQdXGdmi7iELYM
        yeUVa+1W1vos3lFtggsssLc=
X-Google-Smtp-Source: ABdhPJzAKyeTBDuXcObkzQ4OmbkPGoejP7DzUn+3oqUTtVUamjS34DmwH7xv77k3N2gwPy2YJ9S1aA==
X-Received: by 2002:a63:682:0:b0:3c1:5bb1:85ee with SMTP id 124-20020a630682000000b003c15bb185eemr21776271pgg.146.1651745760387;
        Thu, 05 May 2022 03:16:00 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b0050dc76281a7sm970648pfo.129.2022.05.05.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:15:59 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v3] mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool
Date:   Thu,  5 May 2022 19:13:37 +0900
Message-Id: <20220505101337.1997819-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
References: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
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
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---

v2 -> v3:
	- Add Reviewed-by: tags from Marco and Muchun. Thanks!
	- Initialize folio where it is defined.

 mm/kfence/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index a203747ad2c0..b7d3a9667f00 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -642,6 +642,14 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
+	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
+		struct folio *folio = virt_to_folio(p);
+
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

