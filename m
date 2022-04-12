Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95CC4FDFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353172AbiDLMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354547AbiDLMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:14:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D285977
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s10so8969750plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfqzshiMxPgqo91bqRrogKECfyK/4BP/Cl7KQelj6Dg=;
        b=bPeubF5u9edpfnmGs04xInTA5275jlp30BzDSTI+ieNDlG4u7/tJ7Rz5RTrhAeA0DD
         xb3XM6ti+GrjarPym0NKYWxAGrxIlYSSVfiGUr/dIS0YAfsAa/cWKAEtZ14ZadQw81uF
         LUS8d+iv9X73VtIOegsMfQm/be60nBbUDvuoouSr3+xA55Dq6i6d0JF+5DrQD+VsGKca
         gfiglXT5A5ClCVJrA0q6LCJhwh1zeAiWiZ6yptsEyZShruJBkFXplBrDQLtEX9sL3YMz
         /ydrd5vHe6tt3lhL/kJ/qf7IMVRHgzErt1mIGmZMgxdZtI2MWBEHsAu/Ypq3AsqyPbJ+
         cBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfqzshiMxPgqo91bqRrogKECfyK/4BP/Cl7KQelj6Dg=;
        b=2rj1KeR838NOYmpnbwQblSq+SLXt456cAG5h2OQfai5KdSMOd1Ce06ZnGKyITGH/9N
         waPa/Q+RurAEQqxsrF+WfZjZ0jiKpG5w/RRqVasTA3/f2oNBIo7Dj1PIQxbSb5DQwHhn
         rYe5yGpHk9gAM0xF2Ynta88an9J2Rw3iBolAs2wBCRbw2uVIt0OFlf56GO1Xp9k1uAN9
         iKn8XgIzCuFTobFvelFxjcUL0vsO3LDnwU8ES2XYmQJuyhl6/sHXlYhHHR2pIp7a1xDV
         8KxV+IZ31ighSrcBpn6ZeAmDArBy9NeJqS3dD3iMovqVvvUNhaAsvW6J7Qwo7gKjDiRj
         MUnw==
X-Gm-Message-State: AOAM533joEeB2cVs0wD3OsB9Y/SiqHdB6fY1TtOw41XoQK7Y1b5IcWEl
        bfTo0YMnKRnwRBtNbFbX4OC9vA==
X-Google-Smtp-Source: ABdhPJxzz1f3N9EC3y+nmsxylhXN2TisCoqArOTZmzLYhAtuo5R69JHBs9+2JAq88yjyDr3N5O/qwA==
X-Received: by 2002:a17:90b:3b86:b0:1cb:c243:aed3 with SMTP id pc6-20020a17090b3b8600b001cbc243aed3mr3678637pjb.202.1649762116200;
        Tue, 12 Apr 2022 04:15:16 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id l25-20020a635719000000b0039da6cdf82dsm402507pgb.83.2022.04.12.04.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:15:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 3/4] mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
Date:   Tue, 12 Apr 2022 19:14:33 +0800
Message-Id: <20220412111434.96498-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220412111434.96498-1-songmuchun@bytedance.com>
References: <20220412111434.96498-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++---
 mm/hugetlb_vmemmap.c                            | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f3cf9f21f6eb..6ea428023d51 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1669,10 +1669,10 @@
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
index be73782cc1cf..4b6a5cf16f11 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -195,15 +195,15 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
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

