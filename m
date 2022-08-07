Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7990458BBA5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiHGPou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 11:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiHGPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:44:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28736546
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 08:44:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 17so6536950plj.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc;
        bh=sEWroSP5zB4LvyUigg1CpthwDBkI2FfyMg4MRduTBcc=;
        b=ArNhfPo2gtrRcFzbgbUUN6hfCSVMaHdjl49JJ0ChYL55kMWBh9Dc29zrpVi2f5FCEc
         UXdtVHu1SCP/6qIoCsCci5OsWtXVCQ2bDSl9ca1sPVfdabmsF1M8yesQ6vDGwTGWCGDf
         JxylR/jzxfgRNaUhu2oahDfkqWAxa/ThxGw7qRIyixWIDrGZpPo+BaYAp5wvM8GhOarJ
         6gvlknkk9cJDqdcNEFKrc0fnu0vkGuCO0jzKBx3ERWYS9ebjMurK2SrGLRlwOdufHrbh
         9bbdYasJHI5Cr1/6lEzFE4WM/B7rF6yrn1QKHM4igtRl5/d23++epcORpephEFBZs88B
         nH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc;
        bh=sEWroSP5zB4LvyUigg1CpthwDBkI2FfyMg4MRduTBcc=;
        b=xasAdsDSB755Ea4SoNxHLv40WWdTSSMa66TCJ+2wM6OrLDgPZiLBww9X/cS9o/hN9w
         agBIPfS418Z9+nzre1Eiy99aFzhnPgAwXxHw0hvmtHJBPFaaVijphLxroSiUskLmidAN
         1xsADLtBujzwbTDBfZNpo2U0whkZ2oXyIz1/fU3OxoKTFSpi2YROnZ0k6cX19SX/16yP
         4oESME2UcGB0P+wrWEzq0/2j1WZGsiYNiZBh51xKWDBHBX/WQ9rmnRTnurbuWcZ57dGL
         08dPhXPL0Xm3He8xG3U+oj7IppZKk41mQD57zPLBKzmwRruijy8BdllxQypqjbIP8pib
         hJ2w==
X-Gm-Message-State: ACgBeo1ZAhfTVZ4dumFvbWqWQe824ALOULVpc3owKiyfQ2I7Hj+lB9/p
        0X071v/fMvsFOLG1Z/ZN0JQmpOYiB0U4vQ==
X-Google-Smtp-Source: AA6agR41ofA7h5HbCueofia2RsCDqXdYTNJIs2PIBro9kl6Wq0wsFr4zBZMmKLm8U48qbDc6in47Uw==
X-Received: by 2002:a17:902:ce09:b0:16b:ec52:760b with SMTP id k9-20020a170902ce0900b0016bec52760bmr15031094plg.155.1659887086157;
        Sun, 07 Aug 2022 08:44:46 -0700 (PDT)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a470200b001f319e9b9e5sm8873860pjg.16.2022.08.07.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 08:44:45 -0700 (PDT)
Date:   Sun, 7 Aug 2022 15:44:42 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, yang.shi@linux.alibaba.com, hannes@cmpxchg.org,
        haolee.swjtu@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] mm: add DEVICE_ZONE to FOR_ALL_ZONES
Message-ID: <20220807154442.GA18167@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOR_ALL_ZONES should be consistent with enum zone_type. Otherwise,
__count_zid_vm_events have the potential to add count to wrong
item when zid is ZONE_DEVICE.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/vm_event_item.h | 15 +++++++++++----
 mm/vmstat.c                   |  9 ++++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 404024486fa5..f3fc36cd2276 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -20,12 +20,19 @@
 #define HIGHMEM_ZONE(xx)
 #endif
 
-#define FOR_ALL_ZONES(xx) DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, HIGHMEM_ZONE(xx) xx##_MOVABLE
+#ifdef CONFIG_ZONE_DEVICE
+#define DEVICE_ZONE(xx) xx##_DEVICE,
+#else
+#define DEVICE_ZONE(xx)
+#endif
+
+#define FOR_ALL_ZONES(xx) DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
+	HIGHMEM_ZONE(xx) xx##_MOVABLE, DEVICE_ZONE(xx)
 
 enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
-		FOR_ALL_ZONES(PGALLOC),
-		FOR_ALL_ZONES(ALLOCSTALL),
-		FOR_ALL_ZONES(PGSCAN_SKIP),
+		FOR_ALL_ZONES(PGALLOC)
+		FOR_ALL_ZONES(ALLOCSTALL)
+		FOR_ALL_ZONES(PGSCAN_SKIP)
 		PGFREE, PGACTIVATE, PGDEACTIVATE, PGLAZYFREE,
 		PGFAULT, PGMAJFAULT,
 		PGLAZYFREED,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..90af9a8572f5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1168,8 +1168,15 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 #define TEXT_FOR_HIGHMEM(xx)
 #endif
 
+#ifdef CONFIG_ZONE_DEVICE
+#define TEXT_FOR_DEVICE(xx) xx "_device",
+#else
+#define TEXT_FOR_DEVICE(xx)
+#endif
+
 #define TEXTS_FOR_ZONES(xx) TEXT_FOR_DMA(xx) TEXT_FOR_DMA32(xx) xx "_normal", \
-					TEXT_FOR_HIGHMEM(xx) xx "_movable",
+					TEXT_FOR_HIGHMEM(xx) xx "_movable", \
+					TEXT_FOR_DEVICE(xx)
 
 const char * const vmstat_text[] = {
 	/* enum zone_stat_item counters */
-- 
2.18.2

