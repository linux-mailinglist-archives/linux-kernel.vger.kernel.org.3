Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE764A6940
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiBBAao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243352AbiBBAag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:30:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109BBC061749
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:30:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b15so16818267plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bebo5VtQ+fBGReGGI7tcyPsOFW4PGB+odxeVjPqXpcE=;
        b=TyrTR/b+cZDYjKhYpjOptxXGYc5aM6WnQWw5RNUNO6D0RLZ/BxLdeCuea7PAr02Lsm
         rE9WBgDtTo4EEQfHKZqWpbfruZW4RKTYGA4vl+gwLcTwm7RfM1uLJXfq1C3tM/xOCic2
         gOnc5ugpiu1aSgNY0nZV0dRDWXGjEzZZbnn3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bebo5VtQ+fBGReGGI7tcyPsOFW4PGB+odxeVjPqXpcE=;
        b=cSU8kU4r66MfGce80ZTFJJFQ0hYWfdctliVEBuRPWnVJYs6ZSyQX68tw8ls1lFhNjH
         Fr2gCTVKYMVBdWVQl7lunk9CzxvEON8CTI1WEemt2EB8UZgDq/5eUiIL91JUqesf07K2
         azN80hRNvwHmlzpw0dapytpm0xJgHJpRUaeONF2N0GkbTdgVctDlAETfaP9ytBEp1ZoF
         kQ8aMZLyRPD68PZyjYkdmM9dueb3FdOV5qJJvWDUXoPhBI98UUsBsDfA1phNNuWo+Y4E
         TAD3hGuAJr0gwdUucfFPNoGbGuonxZT31IPgK2h7ePSV0h7FFNHNxI93I3bAFcQu2zRU
         9vNQ==
X-Gm-Message-State: AOAM531cD6NIaXmnQY6iMFQZ2kH1bUDR1P7hzz0WYNsKzHtKl+vdi59L
        jI8rIKnBV27QY+JK5wuAjDgdmg==
X-Google-Smtp-Source: ABdhPJxGEf8Hi1nqHyOPmLF51OkWLjdfrfUdnvtD357ppDinjvMOloNg8yKcdCKks505YcVAQojr4Q==
X-Received: by 2002:a17:902:da92:: with SMTP id j18mr28237959plx.127.1643761835524;
        Tue, 01 Feb 2022 16:30:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm32210500pgq.62.2022.02.01.16.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:30:34 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/4] Compiler Attributes: Add __overloadable
Date:   Tue,  1 Feb 2022 16:30:31 -0800
Message-Id: <20220202003033.704951-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202003033.704951-1-keescook@chromium.org>
References: <20220202003033.704951-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; h=from:subject; bh=kPhaiMRcRcpe1F0B+vNrSNLRWFcSehODtiMdmi/QMtI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+dCoVkMB/8+aU6DxpDuQAyvQOXwOty/i33WS1w9L GmB4MquJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfnQqAAKCRCJcvTf3G3AJlxVD/ 0R4klSKDS5K9GW522csvbV4mzUi4w8/kRpEsomBw+LukBZcXh1nDTrWutvawH9QQhZSDDEqPTt3jss QxCdMQwEXg6imUgnDLVDxC2lOZde2FG5VH1LLMPlPRKUa66kg3unwFDn3tXGKgknX+Az/mcyGADJGk w9gc7pQMS3KpxNJXYQ4acQrYkEvWJ7hztQyYrxgghEDMoFqyxe3q0jf2e4SDKzLL0J5iByXng93YXO KJ2Ul5UMv4vyA4OrEnrM7nnvM4CRyolRK2aJQli74CvghDNLe1D8wQ/XT8yGZ4jLxSvKdenneNpDvm kGEQvdYaTjV6AwUf29bFjAOgT0nynF6GhK7/ovHS5JYiBpCc0BVgbYO8W74IaL1kUZg5ItcfZ/Lk2u ncAcW8ZDqg/0Q4NXZMOOtpFp9YHy0RSElxNs7CO+esY+Aau3u4SASvMcQ/MY8+WL0FJWH1JypgnLS6 IpcH7s4RR5WACyYKb5LDFTSg0h97WWyYS+FNkuKDIVFw+MlDThzh2+U29sK0zAq0ie5ehUsrj1Ktma OzFV4fzB8xeGqogcGpVHh5BVQRTX0/LzggFoBP1cuAspjAIBCr0qnrqr+YWHLyADbg4xS6GZSA8AzH qWuXmAGO7jNzyJJleoSO3aZwo+O9ezs/5p2ur6xSbH4V6DSl//IitFElhHnQ==
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
 include/linux/compiler_attributes.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index cc751e0770f5..51e063347fd6 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -257,6 +257,15 @@
  */
 #define __noreturn                      __attribute__((__noreturn__))
 
+/*
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

