Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA19E51219F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiD0Swq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiD0SwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:52:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BE3C7601;
        Wed, 27 Apr 2022 11:38:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so5137132ejb.6;
        Wed, 27 Apr 2022 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Og01PFU5EZe5B0bBCu0F7erpiwis4vadvQ4RVspA5Fo=;
        b=SntM5HDOwIGePMHzM/EfZTAhbrz7ckZ4p9NyGG4x3OSE/dbxyn70Q3EhHR3ygKzW5I
         kcW88k/EYG4S4Y3mmysxcGIpqI71WboengmOm95wO05I0S2E4E/FEx1JP5+l0E9x9wUv
         vcXil4U7biijyBk1Jm85LLyjEdhgroQlCphFFLda5167dYmB/EDh7ghlCmlnieJY8xg0
         fvN2hmw458gg5trRdsn3dFe8ytLIWo3Tr+0LrQdoqgOleP/j5bO2/+P5kV3pG5BtBL/B
         uEJXUEEUxJiE22KQNChwj7jyiGkWZqygQlDWDBeluT0PjfPSt04Ie3jfBhN7N1UHoehq
         Byjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Og01PFU5EZe5B0bBCu0F7erpiwis4vadvQ4RVspA5Fo=;
        b=CQzEm6ohserID1EkNohwMDiYkpgNffoi4AtMINlsnT3bwf70kYixreaGSCYQTxQdbu
         8UiTEgn7EkpreaKQ+erUHxZuObixTXH+zS4Ja4+wbHfXWLr3hbIRtf96+wEULy2H/BaL
         W83tuicHUKRJ1zWy6zibuGb6USpL07u1rXz2J3nbX0MyHektvSZ6MLunhsV+P2tuvR+Y
         w58ib2m3MBseiGz87TkF10k4G920Cm3gzBntTmqlsnuJC1ncGHes50Rgtidc/QhXlx/d
         cPp+bcScYCyBbEoiIrfk7c4996xOBIqgRiLIA+VD6DyvO5U9mrPV4uR3wWD0Q0BVLC/z
         4m/Q==
X-Gm-Message-State: AOAM530jFnfr3uOAkGTrgau7ZpMlIYYXtJGVxPGVhqOv24QH4uaXicOx
        b7oQTMya38HSg0e4rQ7E190=
X-Google-Smtp-Source: ABdhPJxSqgxF0sunXBvQPcd7EMxD0GNBqflpYY2ga2IkDu1yXDb35IfTimGHpeVMmtZs0AC1cq/pgA==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr24302043ejc.207.1651084713819;
        Wed, 27 Apr 2022 11:38:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b006f38f2e9ebesm4691667ejc.64.2022.04.27.11.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:38:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 3/4] Documentation/vm: Move "Using kmap-atomic" to highmem.h
Date:   Wed, 27 Apr 2022 20:38:20 +0200
Message-Id: <20220427183821.1979-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427183821.1979-1-fmdefrancesco@gmail.com>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com>
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
index 3623319a659d..d1f9b298415e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -143,6 +143,37 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * configurations).
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

