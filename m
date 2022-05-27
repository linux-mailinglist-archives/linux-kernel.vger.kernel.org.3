Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7C535B59
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348942AbiE0IUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349284AbiE0IUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:20:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF77102771
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:20:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c65so3186105pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1Aq17dHELJ872l+t8fXkD03dN9Wq38KxjIxdkA2X6s=;
        b=uEnODR0keCyU9dqcQdNE62D84XuwSxmZfz1vsz4MRUBXf8TYXzJc9D+ZOj4mikUGqn
         58dpLjjrv6LfusGiQslMj3pLvzW6F+86n9BafXIEu4OqEj8VstNSI61ovuvpYSEZ1Qea
         4dEAohjprmCxAwHtIuHdaapmh364Y8EFuTDRB128YVVsObUxJoiyIZk5bTjDpUcdKAvt
         O8p0H5474Dk7iHftFZEirHMO6aztQecenOUpMrhA862vBILtQ8d5zx8Da9nFEsFUGPtL
         7QJ5GFkarhFfZu+bYytYx/67rJ//Ef4Wh5C4qn4qD4ysRt1vDQ/TzZthTRGl0AHY9GSB
         rDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1Aq17dHELJ872l+t8fXkD03dN9Wq38KxjIxdkA2X6s=;
        b=vTsC3HYjifke8pcB/+kCLunsJZYlbut0USyLz953zsKTQtTha2YDsNEUm5liMjYKYd
         7fCz6tLc/6oaWn6UxGjEBpb5voWBBSe03Zsu/VXpXHF7Zf1XZEkZP6mxnAfpYwFfurl8
         siyV/X+fhRW5zHY4ixhvCBQhgzLGTWBwq2xcS3ZQNtLNhzZA3O+116wAn/baDf0CJS4u
         CJDYLY/z/F1WXrWbrPGnCbguGRReEdCbZdBeugUenZ80OmtRpZXpl5OtUSugObAlPNQ3
         L76c7b+nVLbxdC/D382ANXi1mxKOzp055pi6q3DRpYNneBz67ABCl3lKwlzEeOM8njwH
         eAkQ==
X-Gm-Message-State: AOAM531pIUQPWdup2ILOVnXvNhc2ogsPFXlyckRKVG+x4zM9llhjQs0D
        MdPFRpxYNFrSbGuS/G9kBx0iiA==
X-Google-Smtp-Source: ABdhPJymr23LhnSRkNCgCaPC3sfshR0/m7N9PN1di24h5o0dp7yfwDHsnZuZXkYKMrMzQqnjeVwcgA==
X-Received: by 2002:a63:5fcf:0:b0:3f6:298d:e2ea with SMTP id t198-20020a635fcf000000b003f6298de2eamr37127841pgb.561.1653639606843;
        Fri, 27 May 2022 01:20:06 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id y139-20020a626491000000b0051844a64d3dsm2865931pfb.25.2022.05.27.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:20:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm: hugetlb_vmemmap: fix CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
Date:   Fri, 27 May 2022 16:19:48 +0800
Message-Id: <20220527081948.68832-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

The following:

  commit 47010c040dec ("mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*")

forgot to update CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON used in
vmemmap_optimize_mode to CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON.
The result is we cannot enable hugetlb_optimize_vmemmap at boot time
when we configure CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON. Fix
it.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: 47010c040dec ("mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fcd9f7872064..1089ea8a9c98 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -33,7 +33,7 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
 static enum vmemmap_optimize_mode vmemmap_optimize_mode =
-	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
+	IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 
 static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
 {
-- 
2.11.0

