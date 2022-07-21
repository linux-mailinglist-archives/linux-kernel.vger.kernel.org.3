Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797957D56B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiGUVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F9904F0;
        Thu, 21 Jul 2022 14:02:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d8so3935162wrp.6;
        Thu, 21 Jul 2022 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Wa6yLMGc2WRkmaEKpyRFxQSUgk0ChF0sgc7hNeYrTc=;
        b=FQKt/UIgTZ8Mch9n4Dh2bjtUdG/NT2Vdmagpsj+j5I/ekpOhL5Wn31K9uLxuZnVuJP
         1QTpIyeIIN3mFG89ZVqIWGlO4EMSss3Ewcf0tpCq2gI49dbPVxO57VDoipBcctctvcEM
         95WxxUvGsD8Usb5qFThKBywL6hIg3FrhsFgakwK7xcP9/r3itdOYFXVRoRSjEiav1xxO
         rWjb1unrYcW2s13yUiFX6w/853b86XzWqR620N/UJ6tvdkk1+gFFO8Nin+TElVlzuZUO
         FZMYDfQJJo0M2E6ex+Sd/hHOKLvB+mNBDBTA/sZYxTuXshdVSa1XMJ7gqgi7LzjXmIXo
         XCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Wa6yLMGc2WRkmaEKpyRFxQSUgk0ChF0sgc7hNeYrTc=;
        b=ABJzWqTDtsK/aEHSmIUd2vEtV8JWtjfpZ/SnQBQGpEwU3XND3SVQBmrVnqcxO3h9IJ
         cLW5R/KWqmUpO5gqILR4WMJf1OVUxB54EPAICkD2ZGYtQzRQ4cwHQDeZkSMOVbTS5O/K
         RzhE4/qBItpqgVx4+cj54ZrYwqTNxBHy5CfvwLdK8ULU8wqZuEx8Wd6YyQJc/YSM6zpG
         URPAbpNrqqla4X9+jL9B9Pmj3cGAAY8wGncos5SB54+bHuMa07hA95/Q12sDlCuvObBs
         9yZNHuErmg5D1YggeajlOWqcVzCycpVXVIetge5uCXsKEf+PP0TrmtiQhoN5r6A+vw3z
         OktQ==
X-Gm-Message-State: AJIora/6cU4kZvlRiOa0fjqOoxoeAZaXZR55dvyleC9F6N+Cmu0ytMQ7
        eQvERLy/+mXytQf3Bwn0IDk=
X-Google-Smtp-Source: AGRyM1t1cquMTmXGJCiGKVk2AVCoqIlo3jE/eV8/EBvYZj+4IXVDpTEb2RolTI2cV4t/8c2xxA5X7w==
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id x1-20020adfffc1000000b0021d66a1c3eemr199763wrs.364.1658437340126;
        Thu, 21 Jul 2022 14:02:20 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:18 -0700 (PDT)
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
Subject: [PATCH 2/7] highmem: Specify that kmap_local_page() is callable from interrupts
Date:   Thu, 21 Jul 2022 23:02:01 +0200
Message-Id: <20220721210206.13774-3-fmdefrancesco@gmail.com>
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

In a recent thread about converting kmap() to kmap_local_page(), the
safety of calling kmap_local_page() was questioned.[1]

"any context" should probably be enough detail for users who want to
know whether or not kmap_local_page() can be called from interrupts.
However, Linux still has kmap_atomic() which might make users think they
must use the latter in interrupts.

Add "including interrupts" for better clarity.

[1] https://lore.kernel.org/lkml/3187836.aeNJFYEL58@opensuse/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index accd286a6af5..0ba031ad29c2 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -64,7 +64,7 @@ static inline void kmap_flush_unused(void);
  *
  * Returns: The virtual address of the mapping
  *
- * Can be invoked from any context.
+ * Can be invoked from any context, including interrupts.
  *
  * Requires careful handling when nesting multiple mappings because the map
  * management is stack based. The unmap has to be in the reverse order of
-- 
2.37.1

