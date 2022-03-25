Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648AC4E7371
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359119AbiCYM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359612AbiCYM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:28:29 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B509D4C1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:26:07 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id q20so4368213wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QkFXQKht3FsROuZXBPuumuUjobkvoKdYm8rz90N3ok=;
        b=G8pGikCU+68iQU8yVzzLsdr902Q5LEleXFwfix2G2Sj3QjG7SrCX4N15TiRiZa6IL5
         RrkKXiUSqVNC8JrVuBst6GbE6Ga6+srQynlj2cbdaLhRoCYnRlX7jr/yiFZBnQ+1Vy9s
         1dDoplRGigJrsIdl06oGHELC3SejFHitEP/Wo3JiuGlE4KKlJV/oteIiStHPg1PwC+XF
         ESmFwEbTa727MDjqAlheu4385IyjyBa0ZOoS31zf008gURTzgLqIZ+JIRVWCb6QRljtA
         tuHgo8f4UKNBtnL0yUOAeir/p8DrdUxiqs04K4GwyuAeJot/Q8GH1WZs+L/YOERRel/Q
         J8wA==
X-Gm-Message-State: AOAM533kyQ5W+ej+ziAJWhThH7zjcjOrS+hEEXIcnOWiBdsDBlhTbqF5
        uFJ8X8ajFVzwBb03XFbF568=
X-Google-Smtp-Source: ABdhPJzgSrNJcQ+W0QQNOfhrYb/yJ43f8QLDA4VwiZaTLDCilx0z7IlKEDuAoEHkt0ihv3hde2bFYQ==
X-Received: by 2002:a7b:c048:0:b0:38a:12dc:4694 with SMTP id u8-20020a7bc048000000b0038a12dc4694mr9792566wmc.80.1648211165381;
        Fri, 25 Mar 2022 05:26:05 -0700 (PDT)
Received: from tiehlicka.suse.cz (nat1.prg.suse.com. [195.250.132.148])
        by smtp.gmail.com with ESMTPSA id h188-20020a1c21c5000000b0038c6c37efc3sm4504278wmh.12.2022.03.25.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 05:26:04 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Baoquan He <bhe@redhat.com>
Cc:     John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Date:   Fri, 25 Mar 2022 13:25:59 +0100
Message-Id: <20220325122559.14251-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

we have a system complainging about order-5 allocation for the DMA pool.
This is something that a674e48c5443 ("dma/pool: create dma atomic pool
only if dma zone has managed pages") has already tried to achieve but I
do not think it went all the way to have it covered completely. In this
particular case has_managed_dma() will not work because:
[    0.678539][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000027dffffff]
[    0.686316][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.687093][    T0] On node 0, zone DMA32: 36704 pages in unavailable ranges
[    0.694278][    T0] On node 0, zone Normal: 53252 pages in unavailable ranges
[    0.701257][    T0] On node 0, zone Normal: 8192 pages in unavailable ranges

The allocation failure on the DMA zone shouldn't be really critical for
the system operation so just silence the warning instead.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 4d40dcce7604..1bf6de398986 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -205,7 +205,7 @@ static int __init dma_atomic_pool_init(void)
 		ret = -ENOMEM;
 	if (has_managed_dma()) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
+						GFP_KERNEL | GFP_DMA | __GFP_NOWARN);
 		if (!atomic_pool_dma)
 			ret = -ENOMEM;
 	}
-- 
2.30.2

