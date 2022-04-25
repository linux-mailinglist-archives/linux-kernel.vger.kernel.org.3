Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1650E59C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbiDYQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbiDYQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6911F953;
        Mon, 25 Apr 2022 09:24:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p4so3465183edx.0;
        Mon, 25 Apr 2022 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k75/spXS+k5a5+DVquVFeCXg9KobdD3U49dRA56k3UQ=;
        b=o9+2pBqWUis4C6ZmgeEt5DTfRXP576snfeynxz9Ldb7ffqC3x9eTcQ2TP0dl8TEupW
         rHiAmS/ZLdlYuA5KVEiPg0INBIPqtvD1zRVFVfoiBi8Yb9j2bfAyuOmjLUkibHyuCBm1
         phhllpn38RK6N48Gkijl4o0vHsbMNoCyjkA/QXisVu5//F6HOp4ZgIhacDVrvGujNZOr
         yvC/TM2VAJbPILhgMsgI4RwNe+wKp/PDZKY1NLf0s2V3L1FWYjKDCR2SkXJess0xTFku
         uqEsrCEj/nUBe/X4yx0wun5/MqGdMA+dvlxgy/j5cgQv0p62t6UnSe/xMd4pi58THbLs
         6iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k75/spXS+k5a5+DVquVFeCXg9KobdD3U49dRA56k3UQ=;
        b=vJSEKhfmaGYbU4kU0EcIdJoJhL3XvfjC+wVtJBHjheD9BP8UhqFy0zLr8+yvYxMb0v
         8Gm7MpkFxx+tP9LWaVDihKkPLfxKwE1YI/UxfoSTe/5LPUTSXEtssnCFIZ+Fgr+RNqjC
         PaohhGSCmzyp2nq5Y94DC7gsviq8qewbf3W9Y2P7bF3/PZciveuQGZoHzs6R0Rg5+Wk0
         RqexyrSlBGjwgk7xo7zqrJXS1tUpykI9+LFQ8tytZUQieiMqv1rj8cMgtupULnHafDr1
         og9r755Qc1gL3cA/oYvBh/W4dOfrQxjFyKjGNs7Xsndp6+fJThVPRzJlP4bBmmuy9qpW
         bdFw==
X-Gm-Message-State: AOAM53150d6Sd2l0aewKhynOt8gpcFoRZ676HOAX7W02iN9JPQpKudUe
        nRvimtAuCUV1G5cEUyPZkao=
X-Google-Smtp-Source: ABdhPJxsVB07TMND4r1/D1MiuXyvmgzMTJcIRZOlK5oN4b3CUelM/Sd2DPPsgUpZiXdLG0i/3CyNnw==
X-Received: by 2002:a05:6402:51d2:b0:424:536:94dd with SMTP id r18-20020a05640251d200b00424053694ddmr20029040edd.191.1650903849582;
        Mon, 25 Apr 2022 09:24:09 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm3784122eji.94.2022.04.25.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:24:08 -0700 (PDT)
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
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 2/4] Documentation/vm: Include kdocs into highmem.rst
Date:   Mon, 25 Apr 2022 18:23:58 +0200
Message-Id: <20220425162400.11334-3-fmdefrancesco@gmail.com>
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

kernel-docs that are in include/linux/highmem.h and in
include/linux/highmem-internal.h should be included in highmem.rst.

Use kdocs directives to include the above-mentioned comments into
highmem.rst.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 0f69a9fec34d..ccff08a8211d 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -145,3 +145,10 @@ The general recommendation is that you don't use more than 8GiB on a 32-bit
 machine - although more might work for you and your workload, you're pretty
 much on your own - don't expect kernel developers to really care much if things
 come apart.
+
+
+Functions
+=========
+
+.. kernel-doc:: include/linux/highmem.h
+.. kernel-doc:: include/linux/highmem-internal.h
-- 
2.34.1

