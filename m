Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A685175F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiEBRjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiEBRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:39:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE87BE39
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:36:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h12so12978066plf.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGEDLI+EsiblxvuiKqtfo/1MBXAuRayw2ZOB5Dyv3cY=;
        b=ZUBc68JOx6sNfy/Lbsv0RKRvgy3RrwquQ+OwpH5iUFiIJl7p+pMV9MC5ErxsSl0VsV
         AJMqD+LCod5WoxpJ+ujDZq2l3UsEiKSLvyEKQ8Kr7W+umYl+3xzdVx/o2r9frX98iN7l
         nlYWQ7LmDRVcAmdeADpzxYjqdCrp+8lXacUfOLYqglPnEzDXE9CaI5qiC4MCtwe/HpCp
         BwIipjbkbijjFEgYUancAu6pxvtjMnD4tTvYtQK3exaOfyZTV3yJxK+G0Bfgiansa9+J
         bs7/NEPd87n5dGW3aTK9OOIYetUch8tyjG5819bQOGsj+VoAsMZ+DcpAryV7XpFOd/Kv
         gbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JGEDLI+EsiblxvuiKqtfo/1MBXAuRayw2ZOB5Dyv3cY=;
        b=jlWfZZMQRjS1AcGKDKiXhLbnRWf1sCRzblNY0Va8fg31km3/V4lP3ecq0r9NOOcycV
         ZDQr0D0gkzaz5usf3PtA2ctXmLAgqvZDCaRO1clRBVJnftdm64XCyuiaDZe2vgdYNVIR
         sWQxaqF/4b4YzyqmZvk2iGvG0WpQfeO8zP5m3GnCR3mI/nbIET8teQdDxsii07dvqQ87
         jlqp56ZPKqbBSm18lDuHNp67pBAmxSmP/sWGLAgwjOH9wMPhzZ1TNfz6y77Nj/a+CAxj
         F6LuOhMw9ZXNrPbH08KkuDMpAL2+mNkrhOZ+CU0GeqzQsNb7slbSAP3ApzzGzeviODVf
         T66Q==
X-Gm-Message-State: AOAM530C1pym1rMjZ0BICs0c+rCn2Chb2MRxenB8QGUBSvwx7Hsx3LHK
        fW6C08JKMg2Rkkt8Y+4rlJo=
X-Google-Smtp-Source: ABdhPJx0D6QW5/2/1AXKVtzMeCLf9FXSyyn5ZEvQ23RSx5fX2XGLVKVm0xRwBSp1CU5C7ZWzM9guoA==
X-Received: by 2002:a17:902:e746:b0:15e:b4f3:72e7 with SMTP id p6-20020a170902e74600b0015eb4f372e7mr289164plf.8.1651512962066;
        Mon, 02 May 2022 10:36:02 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:4d84:d37e:584f:bdbc])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709027c9000b0015e8d4eb26bsm4926525pll.181.2022.05.02.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:36:01 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: fix is_pinnable_page against on cma page
Date:   Mon,  2 May 2022 10:35:58 -0700
Message-Id: <20220502173558.2510641-1-minchan@kernel.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
so current is_pinnable_page could miss CMA pages which has MIGRATE_
ISOLATE. It ends up putting CMA pages longterm pinning possible on
pin_user_pages APIs so CMA allocation fails.

The CMA allocation path protects the migration type change race
using zone->lock but what GUP path need to know is just whether the
page is on CMA area or not rather than exact type. Thus, we don't
need zone->lock but just checks the migratype in either of
(MIGRATE_ISOLATE and MIGRATE_CMA).

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/mm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..f59bbe3296e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,10 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+	int mt = get_pageblock_migratetype(page);
+
+	return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
+		mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.0.464.gb9c8b46e94-goog

