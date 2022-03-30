Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB704ECD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350697AbiC3TQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350699AbiC3TQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:16:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB73E0C7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:14:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lr4so35043413ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCSDRJRZlCX3e7uOeDLU6kERCIj4I7Er1tKnwqwYKMA=;
        b=Rmu0hvbOX8eaSHKORfu191SNwV2QA2hqAtO5gsCaJUm2esBMjCRaCKSAbSwoaF+Hmw
         dIwzPn0nPjLOzIOUpLTukUBXGqqYHQce7E7kGpF40ySsgsuyyBeZl7YXZSMcV3srcgre
         DdQS2MWjhoUSVeNVricufO8tcpVtetPppOUWOrFscaDwoIhIwc32kknNESIMVGgTA0zs
         tlaaulXQIQLV9Zk9pBCafMqtiuWX6tkumTdij8iejOB90Oed+ZefR5UANsJ7gYzEYwDN
         BVw8Va2tT65rsA9kFZsle+OGfKg2/jbRcBJNatQ5MhNWbiDnH8MktPWpIeU/Fmny39mV
         9LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCSDRJRZlCX3e7uOeDLU6kERCIj4I7Er1tKnwqwYKMA=;
        b=VqL0InZU1mehm4H7vQJoYGVrezLVL9dvGDBuuDbG9/rmIGOh8okFsTv2WZ2tYhnKE5
         i2XHkn4f2HFYF1q9nZa9I5ojyrSsx313tUC56ms/mCwIn6b/BhcmdQQtTD/9xC6KYcWi
         JDb1Zo8Kgh7MPmqEhMU9EaDSLBG2G1G7AjQvlfMDwDT1dtHeY2NZ8I88+5s2BdFkg/bU
         7CH+VHlv+rs0Eo8ggice7yXU2RRXNd2TD13LFYHUB2EVcoxjrsk5/SUwBr59bZ6zI5QQ
         6q27ExSV372gWiDlbyM/458SR3EMczDxzLYjTB6YvG0F/Ctd9RhWAgSjYi6/5zFEVzXx
         0EQg==
X-Gm-Message-State: AOAM530M5+Ooit482CMTNOHlr5P9CZfR82UdqIifNPppDiOmt3Lb74lN
        Kd3g/71QgVT51Iiv4d6EWKA=
X-Google-Smtp-Source: ABdhPJyal9zlxaOI9M9P6dckapoFO3jQ2Nw/aHbPR+kqzTd8nXpGWQZsitAgb+8prWXHo8YAK+krcQ==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr1102572ejc.249.1648667658992;
        Wed, 30 Mar 2022 12:14:18 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id eg6-20020a056402288600b0041919c78082sm10257328edb.87.2022.03.30.12.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:14:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: vc04_services: Convert kmap() to kmap_local_page()
Date:   Wed, 30 Mar 2022 21:14:14 +0200
Message-Id: <20220330191414.23141-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. In file interface/vchiq_arm/vchiq_arm.c,
function free_pagelist() calls kmap() / kunmap() from two places.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore, free_pagelist() is a function where the
use of kmap_local_page() in place of kmap() is correctly suited.

Convert to kmap_local_page() but, instead of open coding it, use the
memcpy_to_page() helper.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f0bfacfdea80..efb1383b5218 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -431,21 +431,18 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 			if (head_bytes > actual)
 				head_bytes = actual;
 
-			memcpy((char *)kmap(pages[0]) +
+			memcpy_to_page(pages[0],
 				pagelist->offset,
 				fragments,
 				head_bytes);
-			kunmap(pages[0]);
 		}
 		if ((actual >= 0) && (head_bytes < actual) &&
-		    (tail_bytes != 0)) {
-			memcpy((char *)kmap(pages[num_pages - 1]) +
-				((pagelist->offset + actual) &
-				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
+		    (tail_bytes != 0))
+			memcpy_to_page(pages[num_pages - 1],
+				(pagelist->offset + actual) &
+				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1),
 				fragments + g_cache_line_size,
 				tail_bytes);
-			kunmap(pages[num_pages - 1]);
-		}
 
 		down(&g_free_fragments_mutex);
 		*(char **)fragments = g_free_fragments;
-- 
2.34.1

