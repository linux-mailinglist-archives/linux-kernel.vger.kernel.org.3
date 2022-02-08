Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C904AE508
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiBHWyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiBHWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:54 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF151C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:53:52 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z35so1060587pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWuBBZh2D0kGph/0EnqhwxL8jJUMLsx8wV62pCVDmZE=;
        b=apbBiBy9AWrHOggMW6R6axGZST2zCbKuMgkkIFWgOz1oK1oeUG7PU7xS7o589NzOV3
         RzF7qe8Robis5oERDph8tC7pEzzx2NlFoKkQhabOccpW5meN/tvRDgoVtLtIys4+uLY5
         bjJREQeIcvwoO+pYP9YFDse/JAViTZDXGrJ0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWuBBZh2D0kGph/0EnqhwxL8jJUMLsx8wV62pCVDmZE=;
        b=j5YamnBA+462IE06DSXgQrbvTI4/DvuvttHAUEH+HzxrVcKMwYzpXwZBe4VBFbBpG9
         ZL8leZhigBN3TvcXD7CfYDAnq6D9SOcka0e3OaDc3cADliwJsB8XrGg1AehQxrhhsaRz
         QshKyuqSMK9MXjPb7E50PUT+75kCeTvWeWe4Oi8sbL5oQ/+lGxorekFMA3OIyuhS8V+Y
         jGhuTR55AdQSjZqjxCorJB6HkQVpAbOz4a6x3LWX+PkTnqRvFkjN9MrlwUsqkWwgWWcP
         4fYgXgIMl2SRmzmZIwVJtR8j0fnbcNOqdwcSDDweRFuAM/C4QsK0CnqUUhInG0qcMqg0
         4qEg==
X-Gm-Message-State: AOAM531tWPoVYwCBPpR3l8+M0xOYk3uguc53PsXZZyobe7GrRYCcv4zJ
        fV1TcPb8PGz67InIKIWZCTPnZQ==
X-Google-Smtp-Source: ABdhPJw7GxdGnGnxj0CXoo0e4z0hTO5tiNDoxcc7fyV8/xo2mDlhD8VTmkYAYRThYS8osOiqzc1Rlg==
X-Received: by 2002:a65:550a:: with SMTP id f10mr5434181pgr.204.1644360832227;
        Tue, 08 Feb 2022 14:53:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi18sm3304156pjb.35.2022.02.08.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v7 3/8] Compiler Attributes: Add __overloadable for Clang
Date:   Tue,  8 Feb 2022 14:53:45 -0800
Message-Id: <20220208225350.1331628-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; h=from:subject; bh=l6UvTPRMJNYF2xW3l9gjpmVi+gZHmJuispURJkerkUk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR87AAruZSfd0UK+qa8UyR7X8DXxThgrvDYYjhi UiOBgTCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fAAKCRCJcvTf3G3AJv7SD/ 4t4f9fnUWdK7alIRT5SUzIciYjfn64rlJbPePJi0xAA9ZbdmMJ9N7LPhJlAlxmyzW28hRCAiq3F9qp +MeE+w2Yyt8H028YaykeiK2hF8uy3Fa+XKpv78mU3QXIUzE+LzxjJd9Nvn1+GQZSc/jF86/6+rFLWp 617XKJtg5voAQh6UtSfV46zS2nWsHiEibmhNPhsQjOeEY7++txe6layB5kNUrx6X+W4zyPWfXIe4DQ fkcd2KKnVM75QwqxPSVC2gdw3kNWuY69BCt1sGa6S0oTEgH0aEpu2xaoXh3xDuPGh1/p3nOr/SLT4t bLy4UC/7RV3hwll9c7Ma6AMuUECCb3NmuZUf2Dker0MpvnE4Eq0NSvzBmZQIbhjTnh3zpgJ62zCc5X UFKninZk83cYgp92mWtl1Su+7hKMxPObVCgQWQyefFi0KQ2Vn1f1d9z0fzMmoCQ6Vcknk/A9Nchr7P CQLNHYj78rncFbrJIFaJQbUArBFBmuDvJcr2vlhGQi0jhaZGmztnDr3DuPivCgOBaFI2CBjrDvK1/q O7LrJhMwaO4orNU+ojHaKIcF+ZqQP4nhPUyaDxIs2wVwCnB2uyJ5FvrhU3gBXkuhQVMF/08rMDLV7P 8gjpkaFaYAjg4bfX2lNmF8hfmYGoIdwC9kGpH72kxS4edDknkgk1+ZjuMPBA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for FORTIFY_SOURCE to use __pass_object_size on an "extern
inline" function, as all the fortified string functions are, the functions
must be marked as being overloadable (i.e. different prototypes due
to the implicitly injected object size arguments). This allows the
__pass_object_size versions to take precedence.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index d0c503772061..dcaf55f5d1ae 100644
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

