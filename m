Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD85D4A8A26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352907AbiBCRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbiBCRdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:33:09 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B98C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:33:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so10669912pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zBssxH/WxmaUO1sr/ghPwh4fL8f/bXW9MZNrOKPr/w=;
        b=oHqJMzOtTUhUby05qTiPD+GwE2p690AUteZEv8NOXiqzXdXNe9W7NYPJF7Fdhhy0d6
         HrbpsdReZ8syYLPk1n7PqQX0GrdwxvuhtNFpIWiQQ8VoJYKpVRr/YxdoyGUpZA17rTWO
         x1c2kkxyfTcGDUI6iBxO9lRGNTqe/95y+6LxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zBssxH/WxmaUO1sr/ghPwh4fL8f/bXW9MZNrOKPr/w=;
        b=a3W2DoJpud18iX6yVIvXe5AOELrtRzzsS/G+gjDgsCPfi4kTh08LxPuqkzbYwiBTrM
         Uj7YvhiXyzJxWY8DB1GBZqFTQdcIdmhzHmUzMt5dI9p1M12rGoKyn7wRQLLWU22Ipjsj
         jFiO/5eELofmz8vHqR0MjzdPv1EfLviGBGWjuByM+a1gCD8DH4fyGKBWFrLdf/j8udbd
         4/xXhzaVMBVggpi0Z5SpeduzsGQnDux3OKuA3XcpNw/DlC357L6HpDh/SxNAJQMvDCpK
         cpt//mwCU8KhD3mAWVtdK3CFj4ahKkjHjiMKuM803OOt0NOE9cTpfU/m9ovCMQ91o1IX
         dUXg==
X-Gm-Message-State: AOAM530OgN0ehcEpOpO7ZcURWm62av6bc/fwUo+4ylhvWHBYBbFg+mUg
        e3Rzo8IP0ijhKkjEV3ON+zta6w==
X-Google-Smtp-Source: ABdhPJwZxP5UEfB4voCN4yq/C38B+fyMmytMwS4/oRagiqzmZRs0yri0Cci2rcPZ2J8Oe8mJzENBOQ==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr15030650pjd.8.1643909589126;
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18sm29724557pfk.14.2022.02.03.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:33:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
Date:   Thu,  3 Feb 2022 09:33:05 -0800
Message-Id: <20220203173307.1033257-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203173307.1033257-1-keescook@chromium.org>
References: <20220203173307.1033257-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; h=from:subject; bh=KMIyemBEeogv0prZ4PjXHBrE0psPPqx5j7gZUW7T9OQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/BHSjKRmsjxgw96UF0ULSGoSRDajl4PKbrjZ5H1m qvM6GwuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfwR0gAKCRCJcvTf3G3AJvp+EA CHifGQYlU/vyOgRTFiBUh2o2UcOBRzjmfvCANd+VySak7rvfpyLFYaD2b/KZR+bvpMIwxmKKRMVMgA bcOzv588jJFGqgeabG/ez2ppSc31+DZYscdVT16K5tdTMd56FsbYQWsIauZGy25an5pOe1vdX7qUdU 96CRYKYktuZCj8rLFsN/2ptyObfY0ZDMWx+oY+uT+eQJsk7QICGaycui8n7ZDF+umQ9bXi34Vmm5a0 iq48nXsnOXqWLSFXEfl23DrXjOWRxhf5IMrwX+7pHvxfE1IXC6oTk+t5Y/LqAirc5OqBEUY2kxS94Z 9nblGXGO3EDSh3DAFhTGUqNO/LdU3HuyFeVau3TSCgD2MFV/kePGim0QGn7NTrvbpclEcBDeV+T1cL uqNDvQsvJ2O6c25GtWehSZWPsb3Q5Sn7oW541ZBfAIUZtAz8tT+8AhYQY6rMcJr10BYH7euQgiYSeH j+rdQCt2ux5XL93GfgjCOaeXaEOT2dPN1hm+mcMJksEY1pG2ZoKsDvrZ2Fl+w0tofWJhPpsN6tbmrj 3yojOjQnE0K+C3p0otFZulTm2JsRe9FUxfV/c3Z0FAKDpaea3BE7TjonpuMsJ4HyockIjz+Fv8dJl5 0PPfQL56Ph+nm9i3dFsl0YbJgHJdaKyCmsevhv8YZEyzCZ8lSXCy6HO38Rxg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for FORTIFY_SOURCE to use __pass_object_size on an "inline
extern" function, as all the fortified string functions are, the functions
must be marked as being overloadable (i.e. different prototypes).
This allows the __pass_object_size versions to take precedence.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 4ce370094e3a..dc3bf2a6e1c9 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -257,6 +257,18 @@
  */
 #define __noreturn                      __attribute__((__noreturn__))
 
+/*
+ * Optional: not supported by gcc.
+ * Optional: not supported by icc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#overloadable
+ */
+#if __has_attribute(__overloadable__)
+# define __overloadable			__attribute__((__overloadable__))
+#else
+# define __overloadable
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-packed-type-attribute
  * clang: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-packed-variable-attribute
-- 
2.30.2

