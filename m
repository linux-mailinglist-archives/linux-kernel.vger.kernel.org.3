Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE34514908
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358994AbiD2MWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359003AbiD2MWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:22:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3AEAAE3C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:18:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so6990126plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjSe9ss2+05m7bNnHnq06g/24z1s/6oiiRPfk3T645g=;
        b=V4zTolFkDRy+bEhCxQOBfvMydHiQ3SDhwpCdYR9LSjJYAgp4qwzEPoZTrrY1r+QnIR
         5poY1Y5Q+CRau1IQNkm6BtRRdKx4KIxTNJmSyi/EcQhsHxzmoF94quYhEKljm34++Aio
         R92KIYGjemhsxaueyDuUq8u71R/hQL5lkSg0TB+CDKAFOkjRTE5M2grrgQgULjQcC/2F
         nH13a8tMufrBC96PWlBzBLLxuOJMRSco17kYWrm683IVcJs8VLct/BumiZWjOkn83+yz
         5e49ckj0+KdIpb8CYtz1LTPXUd0rqFdymS2P1gDYe5ErW1f5PUyG68iP4l028mIezWJS
         9Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjSe9ss2+05m7bNnHnq06g/24z1s/6oiiRPfk3T645g=;
        b=6nR78svxRDt4BFnyFl8q9+IvdJOJWPR7O4iSheTmqvv36zvLHYAPnrp1kgCuvQpPNm
         Co7joUG5TGpf63NUKUs5a1QxPPJFENvtGkMb/UDlYYa5uK5/fqvi/qrHegIQcuZ56ouA
         sMpKopG1yBRQLaOLjT64d1ULpYWh6oR9NavOcXl9j60Y97RAeoXdlyxULEQP6S3P8h09
         T72XGvJQ1KRX0NdFdhMeNTGiEkf1DbLczlu+wIIXsCtiYzbc/tzZ2lyBxeH2nnoHsP7m
         MDNjcPpFvhNMHb7LNJy4eIotZSbhRm28UxZsItGiWCcUfWZ9eai436Uw1VaPaB4FjBsp
         ymkQ==
X-Gm-Message-State: AOAM533GSDrgQ0v3t41dSSxRaOb7F34QwYpunPwwtkJgyLNw+yb0WRas
        A99nQ/yc8NtvGd5G8VEuMCubdg==
X-Google-Smtp-Source: ABdhPJx1iBA5oFoann5/gl9fGdgcEAPAYUM965dVZhzsaPjPjJkZI/6OtjdgqxpK9Cr3f72bhF+Rfw==
X-Received: by 2002:a17:903:2352:b0:15e:5aad:af5c with SMTP id c18-20020a170903235200b0015e5aadaf5cmr9612588plh.116.1651234728764;
        Fri, 29 Apr 2022 05:18:48 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm3101421pfc.190.2022.04.29.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:18:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 3/4] mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
Date:   Fri, 29 Apr 2022 20:18:15 +0800
Message-Id: <20220429121816.37541-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220429121816.37541-1-songmuchun@bytedance.com>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

