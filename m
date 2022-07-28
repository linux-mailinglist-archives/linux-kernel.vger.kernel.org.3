Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037BB58437F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiG1PtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiG1Psz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:48:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF26AA34;
        Thu, 28 Jul 2022 08:48:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf4so3874994ejc.3;
        Thu, 28 Jul 2022 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Wa6yLMGc2WRkmaEKpyRFxQSUgk0ChF0sgc7hNeYrTc=;
        b=Wi2kogBx1v57y4wibVUnI6G/UgvL1LHvS4d/uPEyg9ZX9fKQ1HixwGecaT2wTR3WV4
         Dk4KY/WLb461sl13k+D+nVbhKGeAYYvetQYWCrU0jlW5YL4RcYzYP4U1BLZXEifXoOaQ
         kxRJS5ngbLWb7qh60YcmDyhJpFMTFBH7tlScHZJemIWQyIGLWw9XBFgsg3YPvmAsYHRE
         FMUPtHKsn01CUhwf0eWZBqe+tLAxyFw7bOBRB4azCgIdOW6//eiMdB6Q/t9gDeCXEFc7
         g3JyLg01hSDloqrmG9HkWhTj7IqgFECvFcDBeE3QSv3tFb+FdJL18Ucy+ZB/aTWA6026
         SDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Wa6yLMGc2WRkmaEKpyRFxQSUgk0ChF0sgc7hNeYrTc=;
        b=LNAogRaPrEJ5K++CgBrO1qzRgBGH3xJ15HRP15OSpexNoMLnfoXLoXZmj1OkUkwrUv
         tLEl80GMZ7MtvIeRvDGYxC72F27Yvr6UgMPZj70S9Zjk/kMCVO2XNo6jGtfSKRs6TlPy
         lce9u20JQNoap3Wim18ncHGuDu3jBgD4hKy8YQ+gSqPjZRSZnoB+nXc5IQ8PkKLXQcij
         WJpcSWi1LEEiAqq9u8lGuXq+h6ePEH1yh5+bEEknGmBuTTALNeLLeWe0tNQmsjQj19mD
         d8kk7EqzKS5BdN2VCs6+SzgrRrih3OV3JTp1p/4ZJqauJhENrhJNR45WlP7mMguluxMX
         DTtQ==
X-Gm-Message-State: AJIora/7ApYcsSDc9nefM5AibxBXadK5DeTOuCoc0MZHfju5GHnLUjh/
        nHpWNH11PrVO7gIOB1lRdNs=
X-Google-Smtp-Source: AGRyM1tD875+kA8zgArLguhNqKdpsnvyBlPd2vCrNHJpX9PLxH1r635BTw2y/NVAwK3twnyTbFh+FQ==
X-Received: by 2002:a17:907:6e0f:b0:72e:d066:dfe5 with SMTP id sd15-20020a1709076e0f00b0072ed066dfe5mr21796786ejc.558.1659023333982;
        Thu, 28 Jul 2022 08:48:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:48:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/7] highmem: Specify that kmap_local_page() is callable from interrupts
Date:   Thu, 28 Jul 2022 17:48:39 +0200
Message-Id: <20220728154844.10874-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728154844.10874-1-fmdefrancesco@gmail.com>
References: <20220728154844.10874-1-fmdefrancesco@gmail.com>
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

