Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1FB5281E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbiEPKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbiEPKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:23:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C5CE0F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ev18so3388724pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8MT2hpyVq6RWkeIwFsjJwgP64ytBP9yS8NMgw6YICA=;
        b=DKzSkynxZeLrta+Y2p0gffzxOvDJHI6t71Uy+/CZImu1BPgayQiPvNudLg0SLSTZkt
         Iz3qrv0fn288Qp21h6fbFOz8USa18tIo14smiheLi0oCVsNIHFk+tJa2ZKSa0md5EZCA
         0nNfAbv6x1RYJeT+AV3KT70HHMy+yge+s//u83DSm0wixBgz3c2xSlyD7pugDiOCHEWE
         XNfpWYPPjjLLFuH7Qlkq5rfxrOtMyd78/tMd1E9Iqr+NZsrcAn+Z67mFnouHnpcieUwi
         LQXcgkYH+L+SUToJfKGzYoULwqtHtBziNZcsFbRv1ALDNkyJmfUFRvcnaSzyINGw2UI4
         G2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8MT2hpyVq6RWkeIwFsjJwgP64ytBP9yS8NMgw6YICA=;
        b=2MpiLdhJi/TaH3oIQzRYUDQ51YYhdgeE+7cE0dKwK8ndBGaeA+shhgMMPgcACPCFkH
         B0fTTVM7A3a13okQ03KwLUBKIf60W1YKaVKtWx9JAoFNyqPwJT1BM+7L2g45rAqP/qwt
         t8rMErhpJ31f8aFkoiXSXwVkBDbR4k8PtVBx2C2lw04ciRgUNMPD6YNWJF61im/7DsVt
         9nSGGZOusFwA7Kij9ozOAnWOL18bnf1YobFkwOA1R7+kVSlm/ghUy5e+fMJkhc+V8kZx
         L0Wls8zXpxjFuHYwc+gwrBIxDVw1LmBA7GiFwIjlLnLn6pUZW+bXXVsOpHVRvsPOxIuX
         zV6g==
X-Gm-Message-State: AOAM531K6hKdDT/wpqJvxt6vNQANGtrP65wirmg3RyNJA9P30wL9SXzF
        RlWvDTWkAUCiUZXK3Uo8E4vr1Q==
X-Google-Smtp-Source: ABdhPJw8tB9MAEiv0ASMkUFc6CnGi+nHHhMKptiG8ntp7nzRoMhc0imKrJfdtQmE9hPZnzGG0TQICA==
X-Received: by 2002:a17:90b:4d11:b0:1dc:ec4f:a19c with SMTP id mw17-20020a17090b4d1100b001dcec4fa19cmr29767454pjb.117.1652696594183;
        Mon, 16 May 2022 03:23:14 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0050dc76281e4sm6472731pfa.190.2022.05.16.03.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:23:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 2/7] mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
Date:   Mon, 16 May 2022 18:22:06 +0800
Message-Id: <20220516102211.41557-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220516102211.41557-1-songmuchun@bytedance.com>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb_vmemmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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

