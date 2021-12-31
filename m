Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0E482328
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhLaKIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLaKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:08:45 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 02:08:42 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 131so24800174qkk.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 02:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsDwqT0a3hNUqKU4v2jYJjLM/HyV4fz8C5Jr5vH1eWo=;
        b=WJqufZUIJMz/Ry44a5f4Vh2iqhbRm/tjNVoVB3JqvyZqgcEFRSPUaU3pSY41xYZ9p+
         H2v6mKUUJX4H3k/al0FByWFFUjLX/uz+l93KdsQlpLvYrcgbzE2Gj3+ZoyCV17nN2qq3
         YBhqiW1MOTmz/VgAYS9GIJoan5gH4nn2spUdSA0YDD3w1p6dXLN1Wlvd3YDePKdvk8PD
         CPK3PscZropAbdWapioydQR/RZCSopeh+7PqyjjJ60JDXtZpOSV7insKfCuREGQ0Eiqt
         FfPFNme/UsL6vIWcv6/6AX7pjRbc/H/YVb6nkVx1LJ5geqZZHEHV5Nx0M/p0U//cOL3J
         DfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsDwqT0a3hNUqKU4v2jYJjLM/HyV4fz8C5Jr5vH1eWo=;
        b=OXxa/ja/b9sMwVy6ctARSv6O6j+KnPSdDupj/83uVF6XS4Zkju13apcDgG9gK1l0eU
         7sjqBOfgUy/XcKUcyi+sYelS81qvsbvjis6mH5qBYDoD3V+8ZuMCykqEraM0Qg28Vk/8
         izsyPzdNjbng13rLQZrbL/HGCPV788HsbvY0HU3bbSZT4KNmx1bBQA4ZSB8sZHlZZTTd
         ud8vSgiLVCyFT+qRj8zE9RthMMwfPHRIunMOK+yQXROXF7O6o8pABC8Svh/X77Wfe8rh
         JiygSQSQyaThgf3lLJn25ZGSjYnxGooiOt2tTI+Gbgq0JpOX6ZN8+NfNFmwxxkUzez7z
         Fprg==
X-Gm-Message-State: AOAM533KWY+5McB5KCQE7UwaJ5nmdHzsMnDvnSSXm9bEy0Pw8FYkZq7K
        T36pcCjGESkaS8fvwEqynP4=
X-Google-Smtp-Source: ABdhPJwqwBpqbNnDAckOs9aKDylSND0AV7nkWJTx0l3kxiwOckUL6CQ2uGdgLEMgLLxNkRSWgQqObg==
X-Received: by 2002:ae9:efd6:: with SMTP id d205mr21576547qkg.380.1640945321058;
        Fri, 31 Dec 2021 02:08:41 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b2sm20457789qtq.95.2021.12.31.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 02:08:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     nathan@kernel.org, ndesaulniers@google.com, keescook@chromium.org
Cc:     wang.yong12@zte.com.cn, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools: compiler-gcc.h::Keep compatible with non-clang compilers.
Date:   Fri, 31 Dec 2021 10:08:33 +0000
Message-Id: <20211231100833.590691-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When HOSTC = gcc (GCC) 4.8.5, there is an error occurring as follows:
error: Undefined __has_attribute.

This problem is introduced by commit d0ee23f9d78be ("tools:
compiler-gcc.h: Guard error attribute use with __has_attribute").

To solve it, this patch is given to keep the comatibility.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Co-developed-by: wangyong <wang.yong12@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 tools/include/linux/compiler-gcc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 8816f06fc6c7..7da593d3cb91 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -16,6 +16,11 @@
 # define __fallthrough __attribute__ ((fallthrough))
 #endif
 
+
+#ifndef __has_attribute
+# define __has_attribute(x) 0  /* Compatibility with non-clang compilers. */
+#endif
+
 #if __has_attribute(__error__)
 # define __compiletime_error(message) __attribute__((error(message)))
 #endif
-- 
2.25.1

