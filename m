Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE557D574
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiGUVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiGUVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49390D8B;
        Thu, 21 Jul 2022 14:02:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m17so3673283wrw.7;
        Thu, 21 Jul 2022 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u10tCeHxgugC+7t5c4hTzmt45MJlA8VbgBQ6EKUnR90=;
        b=eQQJOhmUeA3aBjl8m25IUooxJXf223IIbslwbkpaJF6Fa5fhjR4ePkJN6isSvHgtz7
         eGYmDa+xIjQ/P44h0vTxk6t/B6xyHI4lfBwIKencgc1g0Z4dLkmNG2fC7j2uYDJiLHBu
         3y/G82+Kt67x0FAD2+HFVk9p0yduqZKN3q/m8zNN0F5JhlmChqFD++pInwjXR5+xFupq
         wUlT1RijfuXHLR/ef8gVXx3UXRtpyNRLhkPUasREwBuksgUO9xWlZ3mbZZWNslT8vCio
         SaQoZJaai389QOLKJGjZUqeorHw2u/Ds+q5wA5JWPjfgaQqzmEgtlbsm45YkAKQ8bK22
         laJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u10tCeHxgugC+7t5c4hTzmt45MJlA8VbgBQ6EKUnR90=;
        b=bce1OH2wn04teiAHA+ZscJ87Uh/0QmSQmtS3VPS86NukbAClluLofvPJyVl2VT4ZNJ
         uI3ZmZZA3gdpyTRkvSpmJnbZjpN8Hn9DIikiEhvrAcZ46DywUH97buTG1Cz0TfHrC2DU
         x4Uh4wjvtpHCfb8550/iWp1+4bjWyJmqaToQchkJd/vW6aOvoFkB5Uvl0HnzVbulD/Iz
         gCecaw0HKb2JgUzRQ2aMRwgSRBu8ANADJYKrc0UqZvMNlunTEOVMRoQFw10dxvFeuNBz
         eMo+L1DzaYeyhg5EVR7WUQfxaV0nD8FYvROL3t5HgiatIyJWe1IpFJO/iskmpekVdEPU
         hLQw==
X-Gm-Message-State: AJIora92sXYXz9CjAwyM8Ic/773bd4sTEMM5rcWuFHA+M6Z4UYUEpw3U
        W8rZNshsN4+cSZWhn1QF4F0=
X-Google-Smtp-Source: AGRyM1s1hVyhBwwGLVuNtYrm5Qeoc6vYhpoL6RjksqTuhA5nHSBW4K9cUn6wI9YoCkXl9KLkd7M29g==
X-Received: by 2002:adf:9d90:0:b0:21e:4cd3:b966 with SMTP id p16-20020adf9d90000000b0021e4cd3b966mr169351wre.665.1658437350730;
        Thu, 21 Jul 2022 14:02:30 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:29 -0700 (PDT)
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
Subject: [PATCH 6/7] highmem: Delete a sentence from kmap_local_page() kdocs
Date:   Thu, 21 Jul 2022 23:02:05 +0200
Message-Id: <20220721210206.13774-7-fmdefrancesco@gmail.com>
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

kmap_local_page() should always be preferred in place of kmap() and
kmap_atomic(). "Only use when really necessary." is not consistent with
the Documentation/mm/highmem.rst and these kdocs it embeds.

Therefore, delete the above-mentioned sentence from kdocs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0ba031ad29c2..63f25dfc6317 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -86,8 +86,7 @@ static inline void kmap_flush_unused(void);
  * temporarily mapped.
  *
  * While it is significantly faster than kmap() for the higmem case it
- * comes with restrictions about the pointer validity. Only use when really
- * necessary.
+ * comes with restrictions about the pointer validity.
  *
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
  * disabling migration in order to keep the virtual address stable across
-- 
2.37.1

