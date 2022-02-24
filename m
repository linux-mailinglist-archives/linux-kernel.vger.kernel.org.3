Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5274A4C25E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiBXIZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiBXIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:25:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530A26F4E2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:24:33 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so1382056pjw.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0ebp+02MdtNr1qZxZumdRZ3cbQAZn0ZqRcOn5l7rUo=;
        b=m/iB6Qjt0rPNBaCjrtmyerUYnQZ0A0Dt7osQ70h9Wtjfi4EzqIaCb+sLeyXCs7T7W/
         gIfeYZQYPZ2eZYZIi6PNc/xwGmhWtq/gsRSWKQ/tLV6MGjv4c/4f3gZ7SNPytz3DMjNr
         VoDptAsYdMbhKKzh2B809FfWNJSRA6qYVfKCls9gY8KzN1V6FUrrGLe36BFjekN2782c
         ZE4b607g+JFHvo44IMlDDDM0dM05jZ1FF3Z22/KcuK6/i5hkoFZrPvwIlKpePqNa0F2v
         RJpmDhH6860JPRvQL9vVNh25vpxNUH1+lrIK4dVKRq1lWWLXBsM+otrXNOUo67dp7+dr
         lH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0ebp+02MdtNr1qZxZumdRZ3cbQAZn0ZqRcOn5l7rUo=;
        b=ruejG5cLCqNxMYLikWnIbmlykLVkvL8DVVhirBlvOthizHW/wye7zO+6z/7S8RRxxd
         JMQtiyOMqSeqGX+c8duCwbrzY6WbQaA0DjpTp/eOed/vC6SVN0MVGytpQzGq+Wo3PQuS
         w/IHNK8yX8yCCbX+209peftOc1+oycvbORfCgIsaW+mldRzJt8b8igV4UE6jLq6Pefx9
         EGL2xPgvJqF7o0D3uPj5QFH/88LlDt01o/KRlsHoYxIGZQJ2wjct8k5zUGJv2bu0QNIr
         yiSBjxX00NnBy7danwUI4VUznW2ubw9B0mGtakHexJfEx5J5+zHFdGUGqpEkf/oNgJvm
         UhqQ==
X-Gm-Message-State: AOAM533akWSM7tpAZikOIJnZG9r1fzr1l//4OKe7OuOBo82fOIrXYRDA
        y8P7tr3MGDCE6lQ8+55ePvo=
X-Google-Smtp-Source: ABdhPJzWjX9oLImrfNtOEMA9QmwkLXqe3xsyYKxThvYoRYLb8H9AY2O3QXMwS7ueuG/FIcpPRdv1JQ==
X-Received: by 2002:a17:902:9a4b:b0:14f:fe0b:5546 with SMTP id x11-20020a1709029a4b00b0014ffe0b5546mr1494983plv.46.1645691073439;
        Thu, 24 Feb 2022 00:24:33 -0800 (PST)
Received: from localhost ([117.136.66.135])
        by smtp.gmail.com with ESMTPSA id o4sm1882823pgc.39.2022.02.24.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:24:32 -0800 (PST)
From:   Junru Shen <hhusjrsjr@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Junru Shen <hhusjrsjr@gmail.com>
Subject: [PATCH] atomic: Put the fetching of the old value into the loop when doing atomic CAS
Date:   Thu, 24 Feb 2022 16:24:07 +0800
Message-Id: <20220224082407.580121-1-hhusjrsjr@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the acquisition of the expected value inside the loop to prevent an infinite loop when it does not match.

Signed-off-by: Junru Shen <hhusjrsjr@gmail.com>
---
 arch/x86/include/asm/atomic64_64.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 7886d0578..3df04c44c 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -207,9 +207,10 @@ static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 
 static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	s64 val = arch_atomic64_read(v);
+	s64 val;
 
 	do {
+		val = arch_atomic64_read(v);
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 	return val;
 }
@@ -225,9 +226,10 @@ static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 
 static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	s64 val = arch_atomic64_read(v);
+	s64 val;
 
 	do {
+		val = arch_atomic64_read(v);
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 	return val;
 }
@@ -243,9 +245,10 @@ static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 
 static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	s64 val = arch_atomic64_read(v);
+	s64 val;
 
 	do {
+		val = arch_atomic64_read(v);
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 	return val;
 }
-- 
2.30.2

