Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912D57716C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiGPUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:44:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32591BC91
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 13:44:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so11553390wrq.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yK1G4X/A5odloNuiZOHLngDtJZQ5c2A6ZaYNU/C2hR0=;
        b=V0JT/eaxewbfHHLgVRnRvqjHG/0Jhd9UK23+WyY55aNpmpkRomZzigCB2jW9Y5pPm0
         NSHiLVaqlcl3apPuWJz8Sxsza0g2BvPbqSqfEocQBglOIw5hdZl3ZysfsWyNxxFY+fL/
         rrCuy8YzdrxPynCf1ZiYm/GQiGPQuGS6B4S0KAKLsm0Na25Tr5timfI9h/aNYKzNWDc7
         ERSFvOjcLM3hNoijcCdeksTzLGrTLDmpwzob54dxVQiK29FKJGAlSRmtRb76vXcgXwmM
         qOoDOrNJIOU+Sh+eoXBhilo9bXZbfBRt3WnVlQsOASAt4TeFmcvas/VCnG6xR+JGQBYA
         7d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yK1G4X/A5odloNuiZOHLngDtJZQ5c2A6ZaYNU/C2hR0=;
        b=FqnqkYYfcdTqYPfgxrQs9UrmT9NYMoEIUylHYsNFX4zqLsSMW67G7KMS74bcri5kb1
         cwPQfV71+Fke1rZYqssTBOWlepsJxY1x+v57PL1sSn1qmXUAjf9hXCjR/nyBPO9hjnr5
         p3hPuHPfXONmICcofYDpBU03YzksUhhuuu6dwVh4BCZWtPj6/e5ZHUxeWBpSQDrsqkuf
         vY+irlNbhgzuUMU7lHlJm0w5SD5WgQ33uRWJ3POyzYQsdaffiloRPkbHYcJ8Buw1lhIF
         /d84ej2qfI7qBpunBkJQiaJuynHr/KoyqTabb1LMtiBuYvUu/u7E9zVExhXb9dDs9Agf
         uKBg==
X-Gm-Message-State: AJIora/5ytFECQVsgB3DW0BCM2dpuVJLO4DbzpxlW4d/xb+xvcpmN9jp
        8rz1pGlcEGW0if8K/YmpBGQ=
X-Google-Smtp-Source: AGRyM1tNvpDcRGh2ootpNNaGLi3aUImui+nJAiMJmpLILuIpDzQxpHGYbeNPZAxmj18z1Jgm0HMO5w==
X-Received: by 2002:a5d:6d09:0:b0:21d:9846:259c with SMTP id e9-20020a5d6d09000000b0021d9846259cmr17776250wrq.212.1658004239648;
        Sat, 16 Jul 2022 13:43:59 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600c150400b003a03185231bsm9238252wmg.31.2022.07.16.13.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 13:43:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] f2fs: Use memcpy_page() in f2fs_copy_page()
Date:   Sat, 16 Jul 2022 22:43:53 +0200
Message-Id: <20220716204353.22049-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page().

Two main problems with kmap(): (1) It comes with an overhead as mapping
space is restricted and protected by a global lock for synchronization and
(2) it also requires global TLB invalidation when the kmap’s pool wraps
and it might block when the mapping space is fully utilized until a slot
becomes available.

Therefore, replace kmap() with kmap_local_page() in f2fs_copy_page() and
use memcpy_page() instead of open coding kmap_local_page() + memcpy().

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/f2fs/f2fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..f04e760bb1c1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2698,12 +2698,8 @@ static inline struct page *f2fs_pagecache_get_page(
 
 static inline void f2fs_copy_page(struct page *src, struct page *dst)
 {
-	char *src_kaddr = kmap(src);
-	char *dst_kaddr = kmap(dst);
 
-	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
-	kunmap(dst);
-	kunmap(src);
+	memcpy_page(dst, 0, src, 0, PAGE_SIZE);
 }
 
 static inline void f2fs_put_page(struct page *page, int unlock)
-- 
2.37.1

