Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E54DE1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiCRTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:14:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D0F1EB0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:13:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k6so551578plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXrcO8k9WHY4LEyS2fhRDME4/GfOMRGHgZg4UE14WTs=;
        b=iebizR8O8be3nBzdLU3hoQPgO8RnJmvjRTgTSwdJEiW6W336peFm1HV1Jr7nla8WAF
         igKypm4cZ8RxRETI7VvpNZxw7VWQv73Rv1sJT7IWa7F9MjuIzfmsxxwdZk3wwlpT35sM
         t8sT7WSKQf8GoicCzPsAD8gFAdcj5VpwpRAtJSDVnPVHjuiTeXLe7D4c7Iczx0WfFLgv
         tRMSQ7R3yAKpW3pd+47LKynEakBQFZJKTyjxfmEa1+mdxiZDFeg6pESGA6sQpUbDTcUB
         34YihZve2/QExHctdZDYFMHbhD623eOzXTHGCxiT3ccMaZadchIJjvz3HYJAKB3iJu/9
         Umjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXrcO8k9WHY4LEyS2fhRDME4/GfOMRGHgZg4UE14WTs=;
        b=jHjjQnOx6iGvb/jNKfH/YO5LPq3I36iAEIG0xXyT+gdCa2Z2oNCdBrkqTHq09vuu/f
         pXFmUFj7yCIZS6VbJtyzP/IR/hNlU+QyntDwJehPcVy5u2jLMOOX8/tNksPQzar6azuE
         SEfBE4LL3l9BFPj8FThWpB6IMI1D+g3Go4hLu93zKX0XrFGY4Fr8mDPbVe+Wfi+VxUGZ
         TdCWamNoCcJt9fjsJpRNaTMHz6HAC0b1GTj4+nL8b5UYZN1OXiaX4XsA799ypcG0Tlwi
         bkZFfHso5XS4P4BjEroBO/ST7igcW8cNv4BhpvV9A/NrdqYOWIaCFkSwwY8s+4XsE936
         E16A==
X-Gm-Message-State: AOAM530iVZvCwc/FD/zEqJ3ogQQSY1qm4OQZ8AyoNk9jfTTIDo9/Lajw
        uEeQW6AJSYCX7VMBA90f+7Bu9SPkzEg=
X-Google-Smtp-Source: ABdhPJyGY9WMAzvWGk/JQ0eDzzUm2lvUtKvFkWC6DgcYE4wSrSoj+6fyzAL7UGXiUPIyOTdbB40Z3A==
X-Received: by 2002:a17:902:ea04:b0:152:7cf:1b85 with SMTP id s4-20020a170902ea0400b0015207cf1b85mr959898plg.80.1647630807714;
        Fri, 18 Mar 2022 12:13:27 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:a64c:198c:4e57:caeb])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a00114d00b004c122b90703sm10325451pfm.27.2022.03.18.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:13:27 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: make gc_urgent and gc_segment_mode sysfs node readable
Date:   Fri, 18 Mar 2022 12:13:23 -0700
Message-Id: <20220318191323.4167565-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Changed a way of showing values of them to use strings.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/sysfs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fe29bcb70f46..fb950a13375f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -41,6 +41,16 @@ enum {
 	ATGC_INFO,	/* struct atgc_management */
 };
 
+static const char *gc_mode_names[MAX_GC_MODE] = {
+	"GC_NORMAL",
+	"GC_IDLE_CB",
+	"GC_IDLE_GREEDY",
+	"GC_IDLE_AT",
+	"GC_URGENT_HIGH",
+	"GC_URGENT_LOW",
+	"GC_URGENT_MID"
+};
+
 struct f2fs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
@@ -316,8 +326,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
+	if (!strcmp(a->attr.name, "gc_urgent"))
+		return sysfs_emit(buf, "%s\n",
+				gc_mode_names[sbi->gc_mode]);
+
 	if (!strcmp(a->attr.name, "gc_segment_mode"))
-		return sysfs_emit(buf, "%u\n", sbi->gc_segment_mode);
+		return sysfs_emit(buf, "%s\n",
+				gc_mode_names[sbi->gc_segment_mode]);
 
 	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
 		return sysfs_emit(buf, "%u\n",
-- 
2.35.1.894.gb6a874cedc-goog

