Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE59950E5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiDYQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbiDYQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54711F961;
        Mon, 25 Apr 2022 09:24:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y21so12184591edo.2;
        Mon, 25 Apr 2022 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Zl4c5jLaRcNs7un+USLcaMW4MzMPWj/KhoSlyRdffo=;
        b=DM1uNsyJDZ+YgMjVkHr9YjLJab0jghTM741FuQr/9hLhPA6kee/3ke59nLooPT2INj
         0loV0sdVLbwcaGE7MLXtL64v/l5Kxem/2ahz2vGfyBbmDg0i2FYBfRltqm69yVv0qhro
         98UZqEWGfQDVfdREl1TQT9ly6FZ0um5jkzcuI8oflWfmc1aYQt8RGhDLuzre8a4Lmibh
         Ytr6M1z2WQYLWG3Bum+WGjcHeG3XBNAmLVcnvJDo9VyTLghHo0U/wU61dxkqDAPkhqEG
         2TEi0WF2J5pcD2TFal2xICG7VKHp5LwoVcTa7BaZB12sYIMcWvnDJ7sMm+wYrVzOYJsz
         KqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Zl4c5jLaRcNs7un+USLcaMW4MzMPWj/KhoSlyRdffo=;
        b=5rjfUGivumFkBn5UX+s8zhpL6wSO53ISC+8x8D+s8cpIs74HkHpSn0Hvx7lkddb4hG
         +ZpoZJd3yyR4PA7T0HsLzkl8XtyD7v7C/9beDAbxChnq55ajLaxMml1lHu889/8M3ehO
         nkT784VMSbjCllKXSBBKT4XoiY2J0quV3rB6a+EBjq9eL5X4ZEkPdTTgLiPWWnwqbULf
         WdomEtzoz5AurRwpr2kuGBmMj+wV3PVnp6irAUTvNvNhLJsLk6v14zJp34+hRLWJy/d9
         QamCtkqQvTZY/qYFBxfFUw68m1Yj7DkKGPBvT7rRTDjJJgbT10Hsp/6KBMlhFDvKG/Hr
         qi9A==
X-Gm-Message-State: AOAM532Q/I8vyAtScXOgvWBjuzsSKFdKzBuyNxRKBZcaMdYTVgFlJJrV
        oaEtiPx3+RkngPdCVCjbkCE=
X-Google-Smtp-Source: ABdhPJw0kQrnedcs+J68OcUUWPs+98m3RHnEnwndKP9hsiRpV/ZQk/hECQHKL1DmrKownzsXBQ1Ssg==
X-Received: by 2002:a05:6402:3486:b0:425:f2c6:9695 with SMTP id v6-20020a056402348600b00425f2c69695mr2903431edc.2.1650903852053;
        Mon, 25 Apr 2022 09:24:12 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm3784122eji.94.2022.04.25.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:24:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/4] Documentation/vm: Move section from highmem.rst to highmem.h
Date:   Mon, 25 Apr 2022 18:23:59 +0200
Message-Id: <20220425162400.11334-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425162400.11334-1-fmdefrancesco@gmail.com>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap_atomic() is new code is being deprecated in favor of
kmap_local_page(). For this reason the "Using kmap_atomic" section in
highmem.rst is obsolete and unnecessary, but it can still help developers
if it were moved to kdocs in highmem.h.

Therefore, move the relevant parts of this section from highmem.rst and
merge them with the kdocs in highmem.h.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 35 -----------------------------------
 include/linux/highmem.h      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index ccff08a8211d..e05bf5524174 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -72,41 +72,6 @@ The kernel contains several ways of creating temporary mappings:
   It may be assumed that k[un]map_atomic() won't fail.
 
 
-Using kmap_atomic
-=================
-
-When and where to use kmap_atomic() is straightforward.  It is used when code
-wants to access the contents of a page that might be allocated from high memory
-(see __GFP_HIGHMEM), for example a page in the pagecache.  The API has two
-functions, and they can be used in a manner similar to the following::
-
-	/* Find the page of interest. */
-	struct page *page = find_get_page(mapping, offset);
-
-	/* Gain access to the contents of that page. */
-	void *vaddr = kmap_atomic(page);
-
-	/* Do something to the contents of that page. */
-	memset(vaddr, 0, PAGE_SIZE);
-
-	/* Unmap that page. */
-	kunmap_atomic(vaddr);
-
-Note that the kunmap_atomic() call takes the result of the kmap_atomic() call
-not the argument.
-
-If you need to map two pages because you want to copy from one page to
-another you need to keep the kmap_atomic calls strictly nested, like::
-
-	vaddr1 = kmap_atomic(page1);
-	vaddr2 = kmap_atomic(page2);
-
-	memcpy(vaddr1, vaddr2, PAGE_SIZE);
-
-	kunmap_atomic(vaddr2);
-	kunmap_atomic(vaddr1);
-
-
 Cost of Temporary Mappings
 ==========================
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3456dc1d38db..6b2d59e025c5 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -142,6 +142,37 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * and preemption.
  *
  * Do not use in new code. Use kmap_local_page() instead.
+ *
+ * It is used in atomic context when code wants to access the contents of a
+ * page that might be allocated from high memory (see __GFP_HIGHMEM), for
+ * example a page in the pagecache.  The API has two functions, and they
+ * can be used in a manner similar to the following:
+ *
+ * -- Find the page of interest. --
+ * struct page *page = find_get_page(mapping, offset);
+ *
+ * -- Gain access to the contents of that page. --
+ * void *vaddr = kmap_atomic(page);
+ *
+ * -- Do something to the contents of that page. --
+ * memset(vaddr, 0, PAGE_SIZE);
+ *
+ * -- Unmap that page. --
+ * kunmap_atomic(vaddr);
+ *
+ * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
+ * call, not the argument.
+ *
+ * If you need to map two pages because you want to copy from one page to
+ * another you need to keep the kmap_atomic calls strictly nested, like:
+ *
+ * vaddr1 = kmap_atomic(page1);
+ * vaddr2 = kmap_atomic(page2);
+ *
+ * memcpy(vaddr1, vaddr2, PAGE_SIZE);
+ *
+ * kunmap_atomic(vaddr2);
+ * kunmap_atomic(vaddr1);
  */
 static inline void *kmap_atomic(struct page *page);
 
-- 
2.34.1

