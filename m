Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0C47C71E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhLUS5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbhLUS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:57:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531B7C061574;
        Tue, 21 Dec 2021 10:57:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t18so28749840wrg.11;
        Tue, 21 Dec 2021 10:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oz8dk8oTqNlrelETkrVGvji9LdFSHnx5F8oTMuBE0Nc=;
        b=Ah2SHEpnBcBcPua80EJAwv8ExpQj7bnvEAqY5+1i3VJMepgCo37lu2XGYoL9SgHhpf
         irikJh7SUMcFSrv9xQKe5KBkuvwIoakQuzDAyNrG98d5mxmLTaReWm+CAL/zWULByH8P
         8vYOZeDzF7Hf7CE7se2aWDrL4YYWp7/ztHFUSIDrcguACKSWNXfB5ThZPS22GRYIAeKI
         Jl3VyTuJNxfAX2DcWethbVHm7DSPSNW+PMIdWw/XuH20JinREjenCYBDN2O9l4cjix8P
         15T1LQ8xzqBUANi2zcorqDYsNxPHGPg0cviutF2apRtw5gq2fx2rXKdej6t5eg2404dL
         WUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oz8dk8oTqNlrelETkrVGvji9LdFSHnx5F8oTMuBE0Nc=;
        b=edxsTynob4ORLsBoVxTwEwbvkkVhGmcTsaaD7JzDv4j6UfBFW4wEGjV/Wjr7+lsWdc
         ofntkpEoLyI340/sTg4Mxf2AGfDVSeIgkPwxVWxw1uyFNmfb2gl3mjjc+gAmJZkPTIcO
         hh+jwA/rVhNgsU9Ynca+m1t0VBBHKHPvzScYshOVsx77gpBzv7ljxS1aWz50qDaw5BJV
         v6/9Wvu7yz2qpgn5bwl4yaKsXIfVDAX/7n67O/3UPz+p97fp2DYqL4ozt1YnLNVYERhq
         s0P4aopMx05tG6GqYvm1OclU+ukYwN00QYiitjHcdg1Ms6civacVkLs2A8TIWK8v1nOu
         qy1w==
X-Gm-Message-State: AOAM531Rqm29swGN5PPdjbwrPpZ+cJLm6G2ViJyeLPO7ZpXkf0OChWMp
        g5bbz3SlDxnLqeG/cwBGoZTN9fvZnFYP+H3X/ajPeQ==
X-Google-Smtp-Source: ABdhPJy+YcIhCNNhvocsLpYph1fkT/zzszM8QMR80ObfgMxnWPHNZndlLKaGALuTLQn8ophBYwJODw==
X-Received: by 2002:adf:9d82:: with SMTP id p2mr3763540wre.414.1640113051961;
        Tue, 21 Dec 2021 10:57:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y12sm4629445wry.24.2021.12.21.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:57:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/migrate: remove redundant variables used in a for-loop
Date:   Tue, 21 Dec 2021 18:57:29 +0000
Message-Id: <20211221185729.609630-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable addr is being set and incremented in a for-loop
but not actually being used. It is redundant and so addr and
also variable start can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/migrate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c9296d63878d..38d4df747172 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2459,8 +2459,7 @@ static bool migrate_vma_check_page(struct page *page)
 static void migrate_vma_unmap(struct migrate_vma *migrate)
 {
 	const unsigned long npages = migrate->npages;
-	const unsigned long start = migrate->start;
-	unsigned long addr, i, restore = 0;
+	unsigned long i, restore = 0;
 	bool allow_drain = true;
 
 	lru_add_drain();
@@ -2506,7 +2505,7 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
 		}
 	}
 
-	for (addr = start, i = 0; i < npages && restore; addr += PAGE_SIZE, i++) {
+	for (i = 0; i < npages && restore; i++) {
 		struct page *page = migrate_pfn_to_page(migrate->src[i]);
 
 		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
-- 
2.33.1

