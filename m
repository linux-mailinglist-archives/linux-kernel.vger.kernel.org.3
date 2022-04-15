Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E074D503332
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiDOXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiDOXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:22:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE265A6;
        Fri, 15 Apr 2022 16:19:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b24so11348063edu.10;
        Fri, 15 Apr 2022 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxYSIJusvv1F2X2tb5X/5N97/buqqwn1b/mpmqc30I0=;
        b=ddtQL3OFQQXj8wvKhOGcfms57oABnX9kA2Qy81w1VMmTUR8zE6KNq8ZDTnwQEoPiJI
         rV3myVF4YxEcoRlTbEacWSqydm6P5xwWAWCofYcfhLX+TnyGK0gALOKHlucJ3p9D5Pju
         z6uxfa1Z2OqpCJvOuxt66CHNjcZSQq9Bq2pix5BdL6XbKr5ax2DMgAXOfghCeKuFRtvR
         5ghANU/Uf/W6OplZ60G0j+1P1OVjzKq8MzGSljm/NNOwj0tcbWAlvDgS4GqvHqVW0tYW
         JtBGZ/4SyoTgQtsMTkwg8d+UZV6UGFudU+RpBXiQgMQt8zTsZGZ9noLrWppc/zRqpBpO
         7NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxYSIJusvv1F2X2tb5X/5N97/buqqwn1b/mpmqc30I0=;
        b=jkCH9uPbS4B5ufiD6iGxUG7DGr/h7evmIpVdOe54W2BAkQyZ6pF+Tjqu6hDlj2rHtP
         jDZtlNKEiyj70JvOZZ88eoIvAV2POwe5rJ/rMWIEOO3ikOArdfSojFOry6Wxrbvq0LiD
         76jl4wI/m0kYE5zdsHhwjcpPmzVUBU4zZwn9i3fIB6UxA417PbtPqaN7SSIE5GUy8fcb
         gmI2+hDkheC2REl+RF94man8vhB+jNINSbONj2G9HbslFSVFuiypP3qOnqNjdrdI8WNy
         pRIkxJY6a9qW11KmlY90X8IoKf0S5lDH8nWTFVnfoPNFcpYGxTU7r3D6Pr+29JVFw6lx
         T0rw==
X-Gm-Message-State: AOAM532tZNMlt5NuRE9gCCHkHPISu/XHZlu7bbqfh1ORSqhEVmd5fez1
        BI1hVkbAy+M4zsc0SjkoGks=
X-Google-Smtp-Source: ABdhPJybk84Df2haJHZe2URBNZPyeHAPYgkYJQzuipWurrPPEAiLg/7+KNinE2Xp7rACwHfN0rDnyg==
X-Received: by 2002:a05:6402:2309:b0:41f:a5a9:fe13 with SMTP id l9-20020a056402230900b0041fa5a9fe13mr1331840eda.123.1650064769863;
        Fri, 15 Apr 2022 16:19:29 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id o15-20020a50fd8f000000b0041f95b8a90dsm3203394edt.69.2022.04.15.16.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 16:19:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 2/2] Documentation/vm: Include kernel-doc to highmem.rst
Date:   Sat, 16 Apr 2022 01:19:17 +0200
Message-Id: <20220415231917.25962-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220415231917.25962-1-fmdefrancesco@gmail.com>
References: <20220415231917.25962-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include kernel-doc comments to highmem.rst from
include/kernel/highmem.h.

From now on, the "Using kmap_atomic" section is redundant and obsolete,
therefore remove it.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 41 ++++++------------------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 12dcfbee094d..5dcee6233cd5 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -117,41 +117,6 @@ The kernel contains several ways of creating temporary mappings:
   synchronization to unmap.
 
 
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
 
@@ -190,3 +155,9 @@ The general recommendation is that you don't use more than 8GiB on a 32-bit
 machine - although more might work for you and your workload, you're pretty
 much on your own - don't expect kernel developers to really care much if things
 come apart.
+
+
+Functions
+=========
+
+.. kernel-doc:: include/linux/highmem.h
-- 
2.34.1

