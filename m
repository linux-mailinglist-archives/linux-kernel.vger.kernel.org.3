Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421F64CFF9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiCGNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242757AbiCGNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:09:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648560CD2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:08:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w4so3331540ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qW5FPsjHoeDJhXjcnei9BSeHnfSk9h1jeGzbOieqiTI=;
        b=Mvh1dUO5XlJTKhAQPXB10OJdy5tionKj/pcUVRBSYgQQ2XYHy1Iz09aVnM8gn13pbT
         EfWrBCO54EEaP743f2KxxiJxmO91AS90PxkE59Tm8IdWJ1VeUXxxzDAPZfqa0FVIc5Kt
         E48Otybo5+HsZ+bTexjnn3sjO7EI1uLgscUPFpnxC98gu8EFOrOCo+vHgSG6mim7+FPZ
         6KDalI6lStC0WZ/nnCrs4/DiFH01Lk+MJJU5LBOZuZSZ2VN3VuTONhCzoLfC5gplBR9s
         Q7DcsNwsG2ebV7Fq/XznHUuizt6xizgYcLLBn8LXpctNu2/4P+BUymdiQJIwo5i6zsof
         3D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qW5FPsjHoeDJhXjcnei9BSeHnfSk9h1jeGzbOieqiTI=;
        b=c6j9mtvGEwHA1HKp/rmJH4yZO1QP+8vmIu9drjmN6/Bl3mDEEJTmUiavydZnnI4CaI
         VSP/8sQKKG3G+7wAdCw/QPbe7IcrkCAZsvbSq/wdtQuGGSI8W5ohbKkZTYxUW1k2izOJ
         X5cyC261lmkWI94seRmBO0WnmW7iT3kRvnnzCNAvuwrhSoMRLZayxCJYddCDU8tFqyWb
         V8UlARzM+fQ5+vAVhRJsvgnAUYiQnrlTkPxTMcTO2QNCBmNWh42UN5cGxUSPGO+mhQvv
         CyrBRjIePqnI2Y+X9uPH1/2xblHpcFPRUftzEP9Yk/87i88urBXGIzHTr/vkj9Fzfq/Z
         PBeA==
X-Gm-Message-State: AOAM5338XYDPCezGAfMKol1n12lO2Ozenp+V4okYz2WbJvMs3mBpvZN+
        uiQm1LWT87qgiTZXrJl8KfhiAA==
X-Google-Smtp-Source: ABdhPJyi/s6JrRd7CnoW3N3QL8rs8llPB8YRmzbheDpz2rgM3I7HPPl+hZkDsa92nWf2RiLq/+elKQ==
X-Received: by 2002:a17:902:8bc2:b0:14d:6d13:a389 with SMTP id r2-20020a1709028bc200b0014d6d13a389mr11944727plo.2.1646658521277;
        Mon, 07 Mar 2022 05:08:41 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79409000000b004f704d33ca0sm3258528pfo.136.2022.03.07.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:08:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/4] mm: hugetlb: disable freeing vmemmap pages when struct page crosses page boundaries
Date:   Mon,  7 Mar 2022 21:07:05 +0800
Message-Id: <20220307130708.58771-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220307130708.58771-1-songmuchun@bytedance.com>
References: <20220307130708.58771-1-songmuchun@bytedance.com>
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

If the size of "struct page" is not the power of two and this
feature is enabled, then the vmemmap pages of HugeTLB will be
corrupted after remapping (panic is about to happen in theory).
But this only exists when !CONFIG_MEMCG && !CONFIG_SLUB on
x86_64.  However, it is not a conventional configuration nowadays.
So it is not a real word issue, just the result of a code review.
But we cannot prevent anyone from configuring that combined
configure.  This feature should be disable in this case to fix
this issue.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b3118dba0518..49bc7f845438 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -121,6 +121,18 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	if (!hugetlb_free_vmemmap_enabled())
 		return;
 
+	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON) &&
+	    !is_power_of_2(sizeof(struct page))) {
+		/*
+		 * The hugetlb_free_vmemmap_enabled_key can be enabled when
+		 * CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON. It should
+		 * be disabled if "struct page" crosses page boundaries.
+		 */
+		pr_warn_once("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
+		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
+		return;
+	}
+
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page is not to be freed to buddy allocator, the other tail
-- 
2.11.0

