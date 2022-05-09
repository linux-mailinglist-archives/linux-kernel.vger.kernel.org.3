Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271651F4B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiEIGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiEIGdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:33:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DED18A6BB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:29:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so11967133pjf.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyzkOphQ+s3WVfI9qZfbl6Rk93jtvh1L9Nek6U2DnhA=;
        b=MAi1RD94OdpjwH1pi8YbdqfTnkUKhdIKyjN/91Iiop2H2NF4JDF3N5PanHUWjP88F1
         fUcAqUykTqgJo80i3V/4pawA8SeixCYIwVsOt+YS97K7cBVFe6m8Bt6eovF7+rmv3Sh1
         I70dZyLpAuCmziwAXdrz8QrbyLP79Fb7laHzZ8WE3bN2ooDGxsBQ4XCvj1YAVJjcTVz1
         sZWHPm1Treje0k0lQSyJ5RKtLLtaTs+wEKfjknWRbarWvd0zVZljThZWlCdPDV+7j4mQ
         GaBv2VEhB6F6AdWxIM3Vqe2XkbD8Ias/esGjM9ITPdVc2SZFTXoFrmeSAQvLe8X1mSd6
         yX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyzkOphQ+s3WVfI9qZfbl6Rk93jtvh1L9Nek6U2DnhA=;
        b=lrQ+8Sr0W/YzAfwNUevV444wAtYhM+/GG9+aU22njL0U/eMOHqjpTOyDtkcYwBmWws
         fwD86i/XoYGg/Xb1vzUrhVAbe/y359pOIs+ZBQzorx/B0pTh3mTUhL/ZbJRFa6dJ6gOQ
         dRBK6BhsbGbcdN+YHMRaaONpNfrIIx12faDQ4unUBLd7lVCvj9DbIX+Y/qtHX5c0LPkX
         i+bI2taobAlK0i4AOAJvAuEycUJSzt2lfxTyd39zR/a0RbhO/LYhhe2ciefRFwMtJHwD
         cTAdN3cn9t3Q3C8JCkIKwc7hgU/pQkNFVlJI9McLsk5Rf1jxTjO20cp5wdm+SGg1FR1p
         4v0g==
X-Gm-Message-State: AOAM531LGK/N0bgKAbcNfdk2ocrKw85KdRZ3MPvk8tfMoI9s4kaw/MsS
        MJRvE0u9tXjt+MyOb+0v4ijctbfj42cb7g==
X-Google-Smtp-Source: ABdhPJyUeNp5lyUBRQZydy9WfLbxkuPhlCBdpMAI02q3YSVfY3kMmne5Gx42MkLs4yh2Hehx52YfiA==
X-Received: by 2002:a17:903:31d1:b0:159:804:e852 with SMTP id v17-20020a17090331d100b001590804e852mr15083698ple.19.1652077773702;
        Sun, 08 May 2022 23:29:33 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ba9100b0015e8d4eb2c2sm6162001pls.268.2022.05.08.23.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:29:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v10 3/4] mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
Date:   Mon,  9 May 2022 14:27:02 +0800
Message-Id: <20220509062703.64249-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220509062703.64249-1-songmuchun@bytedance.com>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

