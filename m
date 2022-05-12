Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE45243F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbiELEMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346343AbiELEMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:12:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C281E6544
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:12:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so3747026plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyzkOphQ+s3WVfI9qZfbl6Rk93jtvh1L9Nek6U2DnhA=;
        b=p+ZQF3x6iL5RSb1SbGzvsDvcyOzZfgs8FP1VuBOzR3GQ2Bp2cHmaV0567sCajNEuUx
         YxPYubvCgJDElXCvfVkHCk2SwDdWBOJkDTprhtIn2l9fgF2zKsm5m/YvIZFBeNFBSk5U
         +f7WLIcOlXVmHcCtj00VV+jYYq/vWXbOFY1Q4BlrfOp61CKzZm7yHHnUVTkmVigBuJKs
         NUrdzNWcuxKACJ7kUGPYDFOu1sdGbL92heFH6oclrObrYbNezdyR7JHHgbZ8I0NkLgbG
         l4LgjRw6qyiDIBW7hyxyvhiJ9fiEMfsmxLaJSPqOZNSlzfEOvtTaQnDe7sBKnkPAsfCb
         qhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyzkOphQ+s3WVfI9qZfbl6Rk93jtvh1L9Nek6U2DnhA=;
        b=jmgh0lDSOmlaCptqbvye59hREQZhDcfX3BTKQKOqYKekPiyuPV0mGAtfiPt5/++XPN
         NB+qzhbrdii+eriGAmM2OniCsEWFGNBCM/+c+/3WUNcVAWP1akdK0oFynWT20wLX8uxu
         vaXlrpt8RQ0WsnI2pNEa4z7gbz+4goKRocIC56buwRlqn1nVa6wo4RTl2tWM+PY6dW0x
         1qMDfRhNtcDIGbzkp5yvS5YK/56Q0oHqHSoIoCfrXgZKWC5UBzZPnOTOI38UoJA+Vb4j
         AyD1U8ZYyp01bSokzv5FCRJc4E4ghfzyGmWnWjnJQK0fqPiznndSJn/i7Mr+93je+YAJ
         q3nQ==
X-Gm-Message-State: AOAM532llzAX0rHRU4Dt7UZ52uFy947XCph9wKo4w5LlZ+Vcy39rsnD2
        asL509nXh9aud+kWSb/6qF4y+Q==
X-Google-Smtp-Source: ABdhPJy2Os6T1eLduAVpNMHAOgfy3Gk48ySBgNZN3RV1s17QOFvQ51tM1HZts0r1JfRgeSgRie8Y0g==
X-Received: by 2002:a17:903:32c9:b0:15e:a1b8:c1ef with SMTP id i9-20020a17090332c900b0015ea1b8c1efmr28715136plr.173.1652328746333;
        Wed, 11 May 2022 21:12:26 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902edcd00b0015e8d4eb2dcsm2695161plk.294.2022.05.11.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:12:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v11 3/4] mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
Date:   Thu, 12 May 2022 12:11:41 +0800
Message-Id: <20220512041142.39501-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220512041142.39501-1-songmuchun@bytedance.com>
References: <20220512041142.39501-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kstrtobool rather than open coding "on" and "off" parsing in
mm/hugetlb_vmemmap.c,  which is more powerful to handle all kinds
of parameters like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++---
 mm/hugetlb_vmemmap.c                            | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 308da668bbb1..43b8385073ad 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1703,10 +1703,10 @@
 			enabled.
 			Allows heavy hugetlb users to free up some more
 			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
-			Format: { on | off (default) }
+			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }
 
-			on:  enable the feature
-			off: disable the feature
+			[oO][Nn]/Y/y/1: enable the feature
+			[oO][Ff]/N/n/0: disable the feature
 
 			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
 			the default is on.
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6254bb2d4ae5..cc4ec752ec16 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -28,15 +28,15 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
 static int __init hugetlb_vmemmap_early_param(char *buf)
 {
-	if (!buf)
+	bool enable;
+
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
-	if (!strcmp(buf, "on"))
+	if (enable)
 		static_branch_enable(&hugetlb_optimize_vmemmap_key);
-	else if (!strcmp(buf, "off"))
-		static_branch_disable(&hugetlb_optimize_vmemmap_key);
 	else
-		return -EINVAL;
+		static_branch_disable(&hugetlb_optimize_vmemmap_key);
 
 	return 0;
 }
-- 
2.11.0

