Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D707E4A8A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352938AbiBCRd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352884AbiBCRdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:33:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE5C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:33:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h14so2755505plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yw6irJOhAN2vbye3KxjS913II9TZEzxb21xQrAwi3o4=;
        b=mP/6SYnCRJH9tpjoHEfJtObmNSTaNoU503LyosBGp2no0Jy/0I8gdDTScbDK0P+Pj5
         NpSVZevzjhlKTmzlpKub1pEGXI6h/dPGSMX6JG4joMv9IVsVGO/3KKdKT1vHuV71aYkq
         AlgkOo8bpwxTWSGMwZXNOB80pM+oVA+q/YjE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yw6irJOhAN2vbye3KxjS913II9TZEzxb21xQrAwi3o4=;
        b=bZs3MsVzBtILa+YXbkoyoEgpqjaLtw2rkhgUz37JwwuhMdDjAlUUJfWa6FzGEpsDEE
         8W6XtjSlzqeCXXJz5oByvpKHShCIwSkYDkoA8rfNBmsYCWTUpZVLvXh6Tt9umWJbKGdu
         qzDsAZBv/xQtE3ssYA7O0yxLf454CIm2DfopWarXko6MqwSWl5bfbPFEp6hOdKPN+iOK
         PhLGf1tHqrHcQ1UUon7Lve+VWn59b1YUbzGEV2i10N5vPkLEq/QTI0xQVRd1AhdpSPTF
         ItE0s+S+pESwu+kGpWENdQ2ObkWuCh7rVLm3jL0g6RQpipvYTmR4a4Wlq9AfuOC+kh3J
         ZAVg==
X-Gm-Message-State: AOAM53331hRKYAjK41zuP9DwEz0Sn0POfGtX4GCIRCcf9OrPmbC4vBr9
        2kLN7I9fFVPfZHwusNx4DrnmwA==
X-Google-Smtp-Source: ABdhPJz4tqpeFvhVI9ywT579VtsGqHvct54NQZZJbykcuYldQGI3P6+8TsH5i1RCoYEBMA+OGSKagQ==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr14667143pjb.193.1643909589265;
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm16882072pfb.80.2022.02.03.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:33:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v6 3/4] Compiler Attributes: Add __diagnose_as for Clang
Date:   Thu,  3 Feb 2022 09:33:06 -0800
Message-Id: <20220203173307.1033257-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203173307.1033257-1-keescook@chromium.org>
References: <20220203173307.1033257-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; h=from:subject; bh=PFNBq+XBBzqPg0PXB+hOZffkoQePkvVqefaYT0cGhkA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/BHSJikbTtPWOya8ANlt+DjlpP25rfy61MJkv6kC DdbWiWaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfwR0gAKCRCJcvTf3G3AJvnsD/ 94wjTMkiZ67z0/rOtOWAOd9wx3QvMbt0JJpgWptsGyD2zaCist6dx7Tua/1oHZrwwBfRUXaXY2jOi8 0BxCmdTsmhcqBZVphRl/fbqYikyQG1cj2r41y8eV4xEBf5gzqh3y/7rIJVFpe2PWWodErO9i4j9NkY xYc2Ij/9LuVbbXlL1LSDQpsrEWVaQtBBAwb1wqZsx/+Sghwqn0WjCcY0fbvjjELX9mJyC87AY8kzE8 5Q3i+XRakLy5q3p3ZEqZsAXbM4AMqp1cFDKbf1iHsRaZIn/ZnnQbyFuIkrsWMLINQDp+PFstmIBu9m uJqSIHBIVaJHA/64Yx42sutxUybGcVN7waqVE4U9TT38lPyDwztqH8dk/L/eOTTYSFrZBxBhqQyqsD qfDm3N8ZNdFJkJVk2QCxp52S0ox6GSUeUlr7f/yRs54MJqTGdyWc23qkLlWDkK0Q5KlXQE4box4b9N TsG5seV1LmjHTkspOXw29uwuZ3eIMiRmIQO7+pBMF9+D9hRci+rhmyQLI8WzloRJ7VSiSL1xGdN66S 4YyEfH2sxu7PdtWE56FVHASJXsRQQnNAeqRL53MXxUiSc2/Br/RCtcK32wGH37fxdWCLP1DBCTo+jK gDFLaUlT2bOPk5OTNWCCuZLGRPoOX9XXBKx2NJUjD7k8vEtEWo4uMiPQXakQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang will perform various compile-time diagnostics on uses of various
functions (e.g. simple bounds-checking on strcpy(), etc). These
diagnostics can be assigned to other functions (for example, new
implementations of the string functions under CONFIG_FORTIFY_SOURCE)
using the "diagnose_as_builtin" attribute. This allows those functions
to retain their compile-time diagnostic warnings.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index dc3bf2a6e1c9..df9c7e5e8818 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -100,6 +100,19 @@
 # define __copy(symbol)
 #endif
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 14.0
+ * Optional: not supported by icc
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#diagnose_as_builtin
+ */
+#if __has_attribute(__diagnose_as_builtin__)
+# define __diagnose_as(builtin...)	__attribute__((__diagnose_as_builtin__(builtin)))
+#else
+# define __diagnose_as(builtin...)
+#endif
+
 /*
  * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
  * attribute warnings entirely and for good") for more information.
-- 
2.30.2

