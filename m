Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368DD4A693F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbiBBAam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbiBBAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:30:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EAC06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:30:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so5161037pjq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fInRCxHTyu6etxtEUEoIMD7U9glEHrt4elCFOp/5mk=;
        b=KVIt5HZpEeVD5/Y6so7IW5ZdtbtEHOzFNbZCAJCM2/Gq4/FzExrFsOC7OjSSxN+/5I
         LW+7C3qaWu1N1mvQfeeQSiYOuc0sIQXPMM8rIwj5h2+f3aMI/MXonOQD/P191JV/CLhx
         c/92nhGCU4UVBnrUoAkc3RR1TKiHGyNzsshh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fInRCxHTyu6etxtEUEoIMD7U9glEHrt4elCFOp/5mk=;
        b=D2UvvBoG/W9WmVRqtKEA6kbE79lRlAutttYE3FGcD15QbRih7xlOvYBtFX2OiJWhWS
         YUFXrJX00mxbdOFbnb1Mvv1M7MkVgH7MpNQ/ljtXCsIcZenLIHtOe/+xarZ9uqymQ455
         PfkInDyNYvmfcEepRiTYK2IkthPTve2Bvyq/8B90zBRmCw1gkdFItY42dAHXSLH4Ssye
         W5+3TLkqbL63svpaxo3ITpfE5VWgp7oCVLy7PQWkTgiburXFifqh37Iwd1qcqOF46JUP
         gnlPVtxbolER02DBEe8RCoXkObG5e45xy0fxr+DPhBViSb2kWQeq91yQDPJLC5QLa/xG
         b/Aw==
X-Gm-Message-State: AOAM532PTB84DFH6OE2HdWKGAhRyPiRkLciGg4lSVblVSLu+0WGV1CgS
        6sRxkK/8cbCkWQtk/3JYraVQaQ==
X-Google-Smtp-Source: ABdhPJz2sZEZicmGiuJ5cu7scof9QLNxu+YdEKntlFyEcaL7mkXaZfTlZDlxvVfnu/3FH9oPbCtoTQ==
X-Received: by 2002:a17:902:d4ca:: with SMTP id o10mr28009120plg.29.1643761835231;
        Tue, 01 Feb 2022 16:30:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm23550577pfi.111.2022.02.01.16.30.34
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
Subject: [PATCH 1/4] Compiler Attributes: Add Clang's __pass_object_size
Date:   Tue,  1 Feb 2022 16:30:30 -0800
Message-Id: <20220202003033.704951-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202003033.704951-1-keescook@chromium.org>
References: <20220202003033.704951-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; h=from:subject; bh=19F95PyhJpZJNu+jRloPaxSM8AkVKKPr2V5iA4Cbh2I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+dCodDJMeW62Db8IsOYk7kn1DY5ku66emtLiRLb7 iklN8EKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfnQqAAKCRCJcvTf3G3AJiK/D/ 9hn4aKhWIVO239nGcT383ZMMwc72d5AIKe4PEY+RtwiM78keImZbgPc7yBMNWOEzt7H9FMMvj+wM1N zMA/31pZxCYrn1Y0rPtIfEDY3tgTq0LB18HvPS55EQACK42W1PJAHyAn/uccfnnBMP5y9QpCwGCWIE sjD6hm8bJHCzNXaG8lnmhGmKyAPH8HESaBVWryT2UNp17v2NwIhJJBvEMwexw0F3BQcAKJ+1OK6P2o CWaHd+7yRezSD+6uy5ha8uoeQk16uuAZa5h7NUhX8mXaHFdwylAIbBo8ofs3KmsfqyEMtbvt2wFBYb gbIUMad0eNBGP8+2KQLRa+jNsCFwZ9tHXaMWO5POYyKEBH1AEFMR7qipCv4z7QoRRMerySMKRa+RuL /rxxqMx9GUZPG14qbAX+9sTpbP/0roTer9c5ajMzcFCP9QJHBSIena8p93oQNBaRL3Di/+40oH7Xap no+KQiZyy6VNUdc782ntdzPr2abM0jAmvUnwrgBwhGnBhbokfeZIIqilUVW70bar4Rhk7xx84AjcrD laa29AMbyXoPrGUrucjqsZpvFN91ixc+lmMG5aez9mxUee0y6bRy/PUrmc2vudcSdv66VAPE/qQ3sE iBKBHg7arRR2eiw+8Y2vYIdRzwgiAKbBIoL6e/tzwNNidPyYiO+ZHtbqbcyA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to gain greater visibility to type information when using
__builtin_object_size(), Clang has a function attribute "pass_object_size"
that will make size information available for marked arguments in
a function by way of implicit additional function arguments that are
then wired up the __builtin_object_size().

This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
to Clang's __builtin_object_size() having limited visibility[1] into types
across function calls (even inlines).

This has an additional benefit that it can be used even on non-inline
functions to gain argument size information.

[1] https://github.com/llvm/llvm-project/issues/53516

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 37e260020221..cc751e0770f5 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -263,6 +263,17 @@
  */
 #define __packed                        __attribute__((__packed__))
 
+/*
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
+ *
+ * The "type" argument should match the __builtin_object_size(p, type) usage.
+ */
+#if __has_attribute(__pass_object_size__)
+# define __pass_object_size(type)	__attribute__((__pass_object_size__(type)))
+#else
+# define __pass_object_size(type)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
  */
-- 
2.30.2

