Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBD4FF95E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiDMOvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiDMOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:51:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC443644DF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:48:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso6471329pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfqzshiMxPgqo91bqRrogKECfyK/4BP/Cl7KQelj6Dg=;
        b=yKhiAYWaSOYJQwBNVwtujizWquYP4rI6ZlWZ1+KiSkaey8GNgzlk7/TSAQbLtl65q4
         k0IUUazxHJMIdN3CJ/ARThnVKC1EdJUA8kR16DeUTkejbuH5jXQ10dSsciIzfDeeLad6
         imdw0nic9VVQdddcq7k1pvPAP8ytBSdWAePW1rmKZUqnsDOzJEo4cz1i1L7ChnejwQAK
         4fTQuEz4UgoboV1lUUtJkndrq7ssp/8DvFy/umR9lzeiffegqFV/wyLDDpcX0x9Ev5kD
         xoxy59LZX+TOoDoT4sQz1CK2pXdhVzNMZcuxupQZWhrkMX8aZOvAbGXxQGg4AxXyExKu
         oMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfqzshiMxPgqo91bqRrogKECfyK/4BP/Cl7KQelj6Dg=;
        b=REh+JxbaO742x4QT5mEeOz1vu16RGfn/nGS8PzOXdECGbA/LmA1bzrB8RjKVVZgpCq
         IpMcSarBwN6YdtB8cRvP88klzV5DafmX/zvVIgFJw+/VnXEiiIW2ipJhbPKIMK+bM3q1
         MsM+JFSK7nEk++Gyz7ehKlyIrATB3uqx61w4XVw6SwhUOhbl3UhHDDpoElx3sw3GvlGS
         fc1K4MDVrmqQg7rGt6t2PBcD6+AMqNAPp4jUkxGRU39YqShahHc4ONlCjEHK5gHTB9eL
         y6FTcmhjNYybSJW/ZtBPWbq9okj9GKldZ19+rGt6ExkZS1Bb3Q2iLMZGndJZVNiT3ezH
         8Sew==
X-Gm-Message-State: AOAM532c0mbojJJXJS2lAJeDjHppTZ+PusShfCEIPC0fP0nv7SnnNdQx
        Zh66mSVU/xm5DPQTjHJ8SVxp1A==
X-Google-Smtp-Source: ABdhPJw9+0J/Pv1eSXmSk5scRsk+PgJb9qJVP7Gb0TeMWiDl/M3OE9EtQ9tF40Ia+6ctpIzKdiHd1Q==
X-Received: by 2002:a17:90b:3b8c:b0:1c6:ed78:67e2 with SMTP id pc12-20020a17090b3b8c00b001c6ed7867e2mr11221387pjb.163.1649861326236;
        Wed, 13 Apr 2022 07:48:46 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm47817257pfh.58.2022.04.13.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:48:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 3/4] mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
Date:   Wed, 13 Apr 2022 22:47:47 +0800
Message-Id: <20220413144748.84106-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220413144748.84106-1-songmuchun@bytedance.com>
References: <20220413144748.84106-1-songmuchun@bytedance.com>
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

