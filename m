Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB84B5F91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiBOAws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:52:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiBOAwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:52:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619666614;
        Mon, 14 Feb 2022 16:51:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so970044pjv.5;
        Mon, 14 Feb 2022 16:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InvjJCM43AyEnsSm20Btn5crA4cxrrPZH5k8jOe9Csc=;
        b=S9iuKuifmaAllqFF17ZHDcVIbF1i1HshgJnU58QcAg3DfRnBvym3n7Yz59DL7UcUKk
         fkXUCDxYuK4bfjAc8QfPw4m/gDtcWMtDOwEVJQaXXpMcA2m97TDEHURdWhH5WX/xi2wA
         0AH+cEOWtCQeUg2yXjSBY4CuTbqHBg0MGjJMtuq3rRpHqePB2CkuhEDHCaJHiP3zJGyD
         AxUdC52/6Lzb/NR5VxFOVgDc1WERbIF5OWx4M1aIU8ufinz53WOfpC1lWaMhUjVCG/0y
         34Ni04+OzbLaKp+nebWBnmewPII32cIziyN+s65XS/Jhi7K+Ta4L5Pb7K6KVcTJNqfMA
         7kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InvjJCM43AyEnsSm20Btn5crA4cxrrPZH5k8jOe9Csc=;
        b=Xg04RdwdJ+GartqRhtbr28W+uTGJ5T2WeIjGqi93KH5GrbqjxGRZ/nL6DOH+GFrHzw
         BWcH/COJAlmf1wR5Ag98G3jskZe2b4ykqFBZw2r3JKyBL3P+RlNn9gDSy4BvoVe5x9GB
         mlP1F/Z3Je4xi3FVEfb+sYeA5PGr6w7NdxEliFJtpSR3OoHKJOLvrvq+On9xHvCAHEPj
         o/Z3b+SYcjdJkTMCP25K18rTk7a+Qs8Bp99iFfrcHt11Qp3ImQneBADtdBQPpxNyipCs
         0Pf5LWwxWE/a5x4fFtoJzfTo3O7cVEakd8WC8FWAJ1aTbIDpHDAW7+LWzi8SYoIT3TUD
         sRcw==
X-Gm-Message-State: AOAM5302e9v0bUSzbpqF53E7pEVNAQZjqLEXomjOX+NK3cdE+n4PDEfY
        ZpU1b4w1QCJe1pTs8DhsSP8=
X-Google-Smtp-Source: ABdhPJzCAqZdWoNYP8Z47oIdIif/meAF4RYMLD37/wjioo94oVL+k+6m1CqfuX99g7d5KbKpEEQjrg==
X-Received: by 2002:a17:902:e54a:: with SMTP id n10mr1710999plf.108.1644886276776;
        Mon, 14 Feb 2022 16:51:16 -0800 (PST)
Received: from localhost.localdomain (192.243.120.247.16clouds.com. [192.243.120.247])
        by smtp.gmail.com with ESMTPSA id j12sm600756pgf.63.2022.02.14.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 16:51:15 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     robert.moore@intel.com
Cc:     davidcomponentone@gmail.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ACPICA: use swap() to make code cleaner
Date:   Tue, 15 Feb 2022 08:50:57 +0800
Message-Id: <05530d163bb18634cceaf1f2b0b48409747d18d0.1644838495.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
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

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/acpi/acpica/nsrepair2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 14b71b41e845..ac6a5397660f 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
 				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
+				swap(elements[j - 1], elements[j]);
 			}
 		}
 	}
-- 
2.30.2

