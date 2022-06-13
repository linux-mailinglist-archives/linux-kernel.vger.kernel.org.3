Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D47547F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiFMGgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiFMGfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC7BE39
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y187so4741719pgd.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3yPX4pLteTBSSt3jyoxQC4mEw/61R+QtZm4AH/eCAw=;
        b=tFpKgo0j+PNLUDk0x391HcyJFSlH7ARGiFiArHFBqwwQvFstQSoTZFlD63itVTgYpc
         kUUVltfZZJyaBSPftr8vB5U60aL3+Bhhc3i9SxGcNDi/qPj+qPLIIzGOrxA0UqjRKOYe
         SJe68LscSGyRfpTbJWWulEAdjHzitTlvSq0Kgup9y7NhhFvjWFNRz49wAFlozK/qxWqV
         siEjOibdp+vbrc5CDd14o6Oxe7QSb5wHX6a2IUr2AzgcEZIY0IFOOHhtonhSWbQeg8bK
         JGZPFSeVlFm7Z22v9a5EJKJ3OIkN90hGOjnWYRJkdY5mztcGZsPWI8fuObj9As7/kq5u
         tDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3yPX4pLteTBSSt3jyoxQC4mEw/61R+QtZm4AH/eCAw=;
        b=c0hOuMlw5Oqm5X1XPlHnq14PJ86vSqqpfQDhySpRldZjiIt6i9N/QvfW1o9QSSMt57
         TVKqzTG9P5xGHKe/zGoOcp5aBJ70XLWjp41nQ143blGjvpr5l/f6LZkPYYIJ0tftWEh/
         H9GQJraeW4ItycKtsmh95vLfXvygmySMnm6eRYmrpK9y0Cb0jKh4WmI+mJ+DNcAPCNWy
         OSrizH8cOZlVXhxpUsTZiiDNZVv04DFta89OnsLOqMfzO4wa3YNEw/LAMPbdKHxcqjp+
         8IgyJQ+uisAiZpceJrWSju2wCLF3kDCFW2hkxaJtoY3/qqO9k1cDFhVgb6yIumE+zmUf
         CM6w==
X-Gm-Message-State: AOAM530Xu8/Rfh48fceBed/oZ/l2+ovNutF5gvsax+ZNm10CzNM7bkWb
        KEkYtved6HY+G+McTwopk8wyRA==
X-Google-Smtp-Source: ABdhPJy28P5B0qqGa3Ke6+SfMWEOc2cytKxdWdyOLSShHZNaM7W3nV99RcCZipyIALw6c+KciZ9G3w==
X-Received: by 2002:a63:cf51:0:b0:408:85f4:fb33 with SMTP id b17-20020a63cf51000000b0040885f4fb33mr1973347pgj.589.1655102147198;
        Sun, 12 Jun 2022 23:35:47 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/6] mm: hugetlb_vmemmap: replace early_param() with core_param()
Date:   Mon, 13 Jun 2022 14:35:11 +0800
Message-Id: <20220613063512.17540-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220613063512.17540-1-songmuchun@bytedance.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
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

After the following commit and previous commit applied.

  78f39084b41d ("mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl")

There is no order requirement between the parameter of "hugetlb_free_vmemmap"
and "hugepages" since we have removed the check of whether HVO is enabled
from hugetlb_vmemmap_init(). Therefore we can safely replace early_param()
with core_param() to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index abdf441215bb..9808d32cdb9e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -415,14 +415,8 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
-static bool vmemmap_optimize_enabled =
-	IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
-
-static int __init hugetlb_vmemmap_early_param(char *buf)
-{
-	return kstrtobool(buf, &vmemmap_optimize_enabled);
-}
-early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_early_param);
+static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
+core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
 /*
  * Previously discarded vmemmap pages will be allocated and remapping
-- 
2.11.0

