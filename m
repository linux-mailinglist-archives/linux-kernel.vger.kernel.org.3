Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A457D56F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiGUVCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiGUVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E105904FB;
        Thu, 21 Jul 2022 14:02:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m17so3672860wrw.7;
        Thu, 21 Jul 2022 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGH8iGVkQVr4d3CxxIU6taEk8nP/KLAdOHtdDle5izA=;
        b=Lqi+vYv5emo6R5/SLxe3DMM7ewKKPkhYCzm9oWrm+MdoUNRWLSKmtaFQeBse/n0oAU
         cZix/lgg6tCQRNaBTutgQQBz6Z++bXLhPYmIDgqkabQxD/bqYPOOXwsncFcRKc0r+tmu
         2We0rJz3VRTULAuxZ5f2MywrMjkUP15vJOFsPpKcxynSE34HhWaHpHLqUZzHstda9J9C
         KA2XdBkL3HM3zITndsmGbuqR4XoxKtrqHC+PPFWyGzvLz2XySZi8VnrKeJ2DA1ZOMn63
         G8IfVOV6s3tOTw5zAYZ2h2PQdqWaKwG4WxNl4lCDtn0XD+4O1VKGT/eWJpukCswnACnF
         SOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGH8iGVkQVr4d3CxxIU6taEk8nP/KLAdOHtdDle5izA=;
        b=bDlDDNobwlI3cgQFe9VLIIhamrSwR3w1Mx/NugXT5coSukbIuuUw7gnm7jEwheeaW4
         d28YsK+s9AmwIt8mY9ta0uI7pRU9ioTS6zdR9ocULWYW+Gmd2t++duURJputZKZ3Qd5B
         lMIkJM+yDuOOBbbM1tdn9XRG5vdbbxn1BbhwNAlg+w6kQiEjPn+UpaGYoFCHoCmlSXgy
         kEd486JVg9Bx2oN3lN93xl+mBiedZRYIZThUj/acJE8YpuKjwTWHkO3qPQy5vRB2peHR
         UtvXjdNJTc/TVZloSAk3xygfKoxu/yA0w+1U135krNu3AnUs1PpJyXMbbemZ9DH2f+mj
         CIAw==
X-Gm-Message-State: AJIora8kG6cqLpVysCHaGEhJ04e6gtnFSwwSQanqOzdpnW4cg+qgugAr
        0Z6YA0waVYk3T0QSZ2d4ZAs=
X-Google-Smtp-Source: AGRyM1uaYG8/IthKEG670yeghS29v1XZ0Cm99Y+vHnPaob7HrGzij/dVBXXy//c6vX6/KwH/ki5uRA==
X-Received: by 2002:a5d:5951:0:b0:21e:5abd:8e52 with SMTP id e17-20020a5d5951000000b0021e5abd8e52mr185655wri.528.1658437342770;
        Thu, 21 Jul 2022 14:02:22 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/7] Documentation/mm: Don't kmap*() pages which can't come from HIGHMEM
Date:   Thu, 21 Jul 2022 23:02:02 +0200
Message-Id: <20220721210206.13774-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721210206.13774-1-fmdefrancesco@gmail.com>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com>
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

There is no need to kmap*() pages which are guaranteed to come from
ZONE_NORMAL (or lower). Linux has currently several call sites of
kmap{,_atomic,_local_page}() on pages allocated, for instance, with
alloc_page(GFP_NOFS) and other similar allocations.

Therefore, add a paragraph to highmem.rst, to explain better that a
plain page_address() should be used for getting the address of pages
which cannot come from ZONE_HIGHMEM.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index c9887f241c6c..f266354c82ab 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -71,6 +71,12 @@ list shows them in order of preference of use.
   kmap_local_page() always returns a valid virtual address and it is assumed
   that kunmap_local() will never fail.
 
+  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+  virtual address of the direct mapping. Only real highmem pages are
+  temporarily mapped. Therefore, users should instead call a plain
+  page_address() for getting the address of memory pages which, depending
+  on the GFP_* flags, cannot come from ZONE_HIGHMEM.
+
   Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
   extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
   because the map implementation is stack based. See kmap_local_page() kdocs
-- 
2.37.1

