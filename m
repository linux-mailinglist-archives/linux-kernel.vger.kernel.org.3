Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7104C25EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiBXIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiBXIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:25:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3899D26F4ED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:24:45 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i21so1188774pfd.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0ebp+02MdtNr1qZxZumdRZ3cbQAZn0ZqRcOn5l7rUo=;
        b=b84C6meeF3jXg2k09uni6Q4FEkFaaorhJnzMqQGBFPYbuHIt5ACH4+7oP5o16cjDtI
         GN4FY/5eMoLgphElJe/5CnXPYrWxxyF0ZDg2ertp52XcuwjI65f+Cc0ZJ0OfXWwso3fT
         XGjtB6BwwfyAYARP1kNgI171VgQoHze41PAAXoVqQadP8JeKi6l3FcUWnJSEWpkPa2Gk
         2xW67/0zIovbMRDSWWJ0bvTYxd3bswc3tZM3IHCn3Y9cTIxbFaPFDUKKwyTRAn7Ke1fF
         wRY2dMeydk1jwbWmYsGtwTtlxhd5ms1oMwweTbkLhrsSyVOVBH58rFTkR++fAsQluH6E
         rc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0ebp+02MdtNr1qZxZumdRZ3cbQAZn0ZqRcOn5l7rUo=;
        b=Ax9XqhVIeO3clVOIE0/BaFJwpWjehRyh5jTVANsnyHP/ibSOQFZ7OczMGmSj9YwY77
         U0+h2/ArcJlXJub8KZMCW/+Zp9h0FIr6/GwTUzJ05I52VKMQHrLao9k6KFz0cBCE6Ini
         sZX5j1/tV7+T2xwhE7D7oIxURYz2xF4bpsoRLq1xo+ZQQCBR5Dt00ym/V1vnUdpqsYXM
         u+PaXtIyTMUjUlk81pY26PXJ1QIzXXiZmkp7Va2DkmMe3PPgjiyogfrKPAmUZcWX8PZ3
         D1iO0QMzpnP/GeHJnSGq998Gpvvv4hKBCIJYWFjHdsmCVdeksrcFzGT6kY2hrZJv7pKw
         DEPg==
X-Gm-Message-State: AOAM531O5G5HIkVXOte/mnD5eSfT/+9B4uT37pBkLdxrSl4Vt7ezuVFW
        9jL8BeskilR7tuslpAAXSlo=
X-Google-Smtp-Source: ABdhPJxkAQJFLh9JQh4FtgF9SJ5zQNnSxlMdeoQ6TVNT0MCOE13wlL0VkK+zx4LYSvzB0eE/gPA58g==
X-Received: by 2002:a65:4348:0:b0:375:9840:b064 with SMTP id k8-20020a654348000000b003759840b064mr179872pgq.270.1645691084699;
        Thu, 24 Feb 2022 00:24:44 -0800 (PST)
Received: from localhost ([117.136.66.135])
        by smtp.gmail.com with ESMTPSA id v20sm1896295pju.9.2022.02.24.00.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:24:44 -0800 (PST)
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
Date:   Thu, 24 Feb 2022 16:24:38 +0800
Message-Id: <20220224082438.580191-1-hhusjrsjr@gmail.com>
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

