Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256150A7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391143AbiDUSFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391115AbiDUSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E784A914;
        Thu, 21 Apr 2022 11:02:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y10so11585406ejw.8;
        Thu, 21 Apr 2022 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmA3/73h+5LBB10zHGxV017fuflOUeGcPLWTr+e8zPI=;
        b=JxFESrRIt2UUIpYO6BpQfEJYWlNMou98BAoenYcLTFq13O/N0HaMuWE+53AANrJ25l
         LMMa2E3ZxlxPBTKAfe+XpPseTVvRPRdjFVHhnW/nH0D9hx67ybP4rvw+XlibU2dQWbFZ
         ayNEFeXq6fHAMPA3QMg69+E2zXekkq9IEr30pEYCXzzsixokcuZ6HYQmZSmDH6W/S/Qt
         vEeqwPYsNebnjtzu4hNBhLcSf4WOyNooXZbKRuDX6Ay6Xgf9RTgqpARssMLY1gZkyiWc
         zsjBqoZ9Hb6bb728U6ak+GmynyJ/os/7ElTN04K0x50f3qc02Piu5U4giQXd7FAr1O3S
         T0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmA3/73h+5LBB10zHGxV017fuflOUeGcPLWTr+e8zPI=;
        b=mv0KN0b8EeBOXD1mjpdyxpRSu22llAtkJT7zTMf5BMa2p/QAt7CbgZ5vBAE32mTYs0
         gWzJaAQ664pCO8YYx8lT0jpwmTpA1B2D4poU5+6rhIBzHhTLJnQV0r03PxqxPYKgPtBP
         I4a/W27vNUjutOWkaUkAWhfyXpC2WMcLnmX3bNcaRerb7mU18K0+flC/7+qlr5Ya3mXC
         Ubiy5Pbso0oSWfeG9qHovmKM/RYFyxm6hzPKVHlFTxiJ8teIVcXoec50omepIpsBZNUX
         OZ1o8Ly5BbzxJJtFjB2naENczEsIEKBNxKdgCqcVjDmnuQBxSllw1YFRXTvgdH0Bs4gc
         QmpQ==
X-Gm-Message-State: AOAM532+Su2vBYwgGUI6u/ixkJ7VX8XvFg6sMa/kurNrnKbxuDuOKo24
        5sbDdtACq7FmBXcuNFh9xpE=
X-Google-Smtp-Source: ABdhPJyq9h4yAAyEQ3sVOf5aNXfL6p5Uwg640htvov7CuE7VFCMkHwZOIAe5oGdZuEAGRac218rGag==
X-Received: by 2002:a17:907:3da8:b0:6ef:f3e8:2989 with SMTP id he40-20020a1709073da800b006eff3e82989mr637575ejc.29.1650564136966;
        Thu, 21 Apr 2022 11:02:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm11836204eda.46.2022.04.21.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:02:15 -0700 (PDT)
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
Subject: [PATCH 3/4] Documentation/vm: Remove "Using kmap-atomic" from highmem.rst.
Date:   Thu, 21 Apr 2022 20:01:59 +0200
Message-Id: <20220421180200.16901-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220421180200.16901-1-fmdefrancesco@gmail.com>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
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

The use of kmap_atomic() is deprecated in favor of kmap_local_page(). For
this reason the "Using kmap_atomic" section in highmem.rst is obsolete and
unnecessary.

Therefore, just remove it.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 35 -----------------------------------
 1 file changed, 35 deletions(-)

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
 
-- 
2.34.1

