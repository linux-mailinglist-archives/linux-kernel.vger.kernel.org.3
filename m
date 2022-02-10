Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2354B13D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbiBJREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:04:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiBJREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:04:36 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587DCBB9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:04:37 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q22so8924759ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4gynQwZ2aOFOkL2mJGrgQ76cXvriSmeacKOwCF00j4=;
        b=NnXXQHS4IyJp7wjISdscHjCDoCJs5ea5fK/lPqH5jM18bDtb3kRQBarjI2AYf/foB/
         Pw45oLy0EvJOrq8Z646kWtpMV8LlIf5SXAJZbkfM4I8XIc3gJjOp1xjt0QXtxVVHgfW3
         4zqekXjieLyn5qwPr7CfR2HgQBY+HFR0vW2KuMAFvcjUMzmsYoc5yor6fxWE4xS6iMLa
         XOZrwTatzagueoQi0oN2YbrtkFZ4AHOmk83BUUGOh4D6iBPkC5QvNLd98YjhmLDKYQ1R
         odOMu/frTObAUhN8rSRkd9zEsj2rOyFCWJuDadfNbN+iwhliBvJUh9v1GcfpZZtm9VzU
         7kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4gynQwZ2aOFOkL2mJGrgQ76cXvriSmeacKOwCF00j4=;
        b=uoHYU7yKLYx3aD8kpQbGX91/xeKS5pGyg/XIuO9/VcG05WDpT8eSI1QWN10+i0EVHe
         P8HLN8bVgOfR8Zh05+ysOE1zmouXdXLV4ZqQrY2SsViOIrxgvR+8ctdt/yxsIZSO6v4+
         TnLyR3aef0kj7untngPOdqF/JbgG9NokCvO+7jjOqxJx1PX5Nx/lqK0yRLCAqwRJzpOg
         X1fEIqUpGufVUEhcnkPIf5X9QoUYeuQvDesCetGww88rS7g7v5ee1fZYDkUS07fPSUcY
         oEEmPNsUlCR659pqkcm/YEegp1p020KKkreQxfiKFmJ0cyXByJFf+wpXWeMPEtR5BiVK
         YkHg==
X-Gm-Message-State: AOAM530jVuIPt47f1sGRjm2+It5kaCPdFAaXzPBgKW7RYpTbkMxICjZA
        VGx+M5B5XnOMSiXr8N2ivW+X2iHTNF+PvA==
X-Google-Smtp-Source: ABdhPJzxmnhvbVmYTXnWvdf6SbuSlMaBCw1amDz781bK6AEzL5B0KpkDD2qMamVx+d3msnO+Imw2IA==
X-Received: by 2002:a2e:9e44:: with SMTP id g4mr5617387ljk.51.1644512675218;
        Thu, 10 Feb 2022 09:04:35 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r3sm2951020ljh.24.2022.02.10.09.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:04:34 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] container_of.h: make container_of const-aware
Date:   Thu, 10 Feb 2022 20:04:34 +0300
Message-Id: <20220210170434.3924169-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of() macro has one major drawback. It does not check whether
the passed ptr has a const pointer, the result will always be a
non-const pointer. Use a _Generic() construct (supported since gcc 4.9
and Clang 3.0) to teach container_of that if converting a const pointer,
the returned pointer should also have the const modifier.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/linux/container_of.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f4944b791b8..269f64e27b09 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -19,7 +19,11 @@
 	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
-	((type *)(__mptr - offsetof(type, member))); })
+	_Generic((ptr),							\
+		const typeof(((type *)0)->member)*:			\
+			((const type *)(__mptr - offsetof(type, member))), \
+		default: ((type *)(__mptr - offsetof(type, member)))	\
+	); })
 
 /**
  * container_of_safe - cast a member of a structure out to the containing structure
@@ -35,6 +39,10 @@
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of_safe()");	\
 	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
-		((type *)(__mptr - offsetof(type, member))); })
+	_Generic((ptr),							\
+		const typeof(((type *)0)->member)*:			\
+			((const type *)(__mptr - offsetof(type, member))), \
+		default: ((type *)(__mptr - offsetof(type, member)))	\
+	); })
 
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.34.1

