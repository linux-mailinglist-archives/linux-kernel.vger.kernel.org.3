Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F29461AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbhK2PaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhK2P2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:28:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC465C052902
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:38:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b11so12183772pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Om9Vpj2eEDIjSh+H6i8e/yMs6hn/L468LtrHAmEffB0=;
        b=jDZCMFKxnuuk3GbLiU/mafDUmAiCkJu3nLr240MUixztB5sOK3xLLox60J98qEl08p
         LPIfBMedoK1zZQfOyEcdBYs3aY/wNZzbmsqju8NdeulC7Fjp6Av2Y0fPttqjIwcZ+hEy
         x717Nx4/NiMjYxOjTo8YMz0qe38KT4rQZgT0osaa3R8d1Zf3vRw9NVDkB4qG5cV7ubRl
         4U6gLodXrtGpUijGKcKTSqFwl8aJbSmVLlH4JJ2luQMO4h0YOEoKqNQQNuKKp0K9G6Eo
         jMEkwzBjPzYsdzPfzEwKnxRoISVga9aLWe1Cmeuuu437ipDogqxiQZ6UavDOmZZ51g4V
         VUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Om9Vpj2eEDIjSh+H6i8e/yMs6hn/L468LtrHAmEffB0=;
        b=H94nvi3FWSezMAqx2DtKUe2wNfHq6v5HLDlOvuKPVnxvCQSrQavXhtQi/iTiwAsKEf
         YQ/pxsqhnTKVXHoTEx1CohbMZT6JhKfDGZkw3ErEduG+4MgNoLojJDXMKjynVm+eeLJ6
         wSP4ybk9cuDAqmIamjRUXlV+VvEmHTzMfuJ8i3cGmVIBQ46fQnWVFfxMzqq71PKayP8F
         8wPqPBHvv30NP5kDfyB9ygzqBorRLmvHFTcmwMMzKLT+9jN/kdKGn8BFfGU2V8jIUoVx
         YBsDnI3EKaU1h5/k8XxSOlOgvJndu7MJYBXybVkpK/2H3Zt2mKjPVLMgLkLeMlTQ2vIh
         eLew==
X-Gm-Message-State: AOAM5316knc9PbEyBzmiMm32+eyx+bsvHb3Rxd0bi7nuAoM3XtgKZIGi
        s02Q3DYYBULHq4Q9e1rB8wY=
X-Google-Smtp-Source: ABdhPJz8ZKps2ykdBomBRYp2Z+j7tQvVNxekRN/0reBY0mYFPV+t/vkFAvNVUki3x1Ib5yGHyhKB3w==
X-Received: by 2002:a17:902:ced0:b0:142:189a:4284 with SMTP id d16-20020a170902ced000b00142189a4284mr61088465plg.79.1638193094398;
        Mon, 29 Nov 2021 05:38:14 -0800 (PST)
Received: from localhost.localdomain (5e.8a.38a9.ip4.static.sl-reverse.com. [169.56.138.94])
        by smtp.gmail.com with ESMTPSA id co4sm18913249pjb.2.2021.11.29.05.38.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 05:38:14 -0800 (PST)
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mlevitsk@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Zhenguo Yao <yaozhenguo1@gmail.com>
Subject: [BUG] hugetlbfs: Fix issue of preallocation of gigantic pages can't work
Date:   Mon, 29 Nov 2021 21:38:03 +0800
Message-Id: <20211129133803.15653-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preallocation of gigantic pages can't work bacause of commit:b5389086ad7b
(hugetlbfs: extend the definition of hugepages parameter to support node
allocation). When nid is NUMA_NO_NODE(-1), alloc_bootmem_huge_page will
always return without doing allocation. Fix this by adding more check.

Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 60f9b6a9582e..6d1603387914 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2876,7 +2876,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
 	int nr_nodes, node;
 
-	if (nid >= nr_online_nodes)
+	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
 		return 0;
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
-- 
2.27.0

