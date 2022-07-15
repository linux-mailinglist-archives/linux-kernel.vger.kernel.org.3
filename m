Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C6575B63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiGOGLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGOGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F64E856
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o135-20020a25738d000000b0066f58989d75so3316367ybc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SVXMXCA9EUcm/U2NL9bFju/llGCppObF5hU8u8qx8a0=;
        b=KmS2wN930EG2IxdxCnUBJhmowSVq6hfGSEB+wly2itZQ8X0cteyEWcAfiVvdqRbU42
         yYenX7Dwez5VU+bNvMLNDm0ctaQ8BCMSiSb//Vn6c9oX9+SeTSiSZ36Uppd4JnBxxR78
         znl5dMF7OcbOnChFRV8zbNqv7wgOjwrgyxDU7Zpy0l4ynJg4HhJ/jccQUGXF4i2S8cNB
         pmV7nKb0B8X7Ula4KBpHNLEaM8aGRY3TVfgMp+m21+vceYD9GUOqJg6gPXDD2fptehJA
         kKrsWzYrZSbpOf11gT0kv72fBfdnYXt/tvhluVpxYNQ4o6shoPvFr2NEyL983QhMwnAC
         Jx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SVXMXCA9EUcm/U2NL9bFju/llGCppObF5hU8u8qx8a0=;
        b=4/+wK4mkk0pTf77hksjgVczV+fy2MSSHKuwlX+F+TWlWiU6qqJu7RYwgSGKoDV0pEv
         R4lQ1r20Jox7lDh6Mv1CczoFi6nD/kuu7Kw8GnX5gT5IFXwulrpOLCLLbARAac0MgUaj
         MKGBgTmID8QFIhvbe+exmxq/IOH7huDqbzbzUVx5qR3Kz6HaWv5y72mg1D6RIx5+wl4u
         wtuGSsbI7jh98DRP0Lpmxi9t/bwfy5p15SKGNQwrGiM8UXGyPs535zF4Q7aRqwqzsNmy
         y7tvpJ+BcoJwBoFi1uOmYYHVyaSUegZnotSzxb8KIESInEWRoLwldlpPTu6LtASxtZpI
         bbYw==
X-Gm-Message-State: AJIora8hcJlOBfFubVVIKApQJ1jjd4xwkBH3YzZ/3o8M1BmsqcAr5NBI
        75r5g4pnVcuve8hL/GrZJnFBHGZmJujMaj9vfQ==
X-Google-Smtp-Source: AGRyM1s7bBaJTn0X9XWOnvyD6RIVfSqUuJ1lmnLuGoAg+cY+w4t8dDFpOLAfqJACW8rVgQZNFvvWoSacW1dpR4y6cQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:6fc3:0:b0:31c:8c75:3eb8 with SMTP
 id k186-20020a816fc3000000b0031c8c753eb8mr14112217ywc.225.1657865476241; Thu,
 14 Jul 2022 23:11:16 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:15 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 06/18] arm64: stacktrace: Add description of stacktrace/common.h
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        kaleshsingh@google.com, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, andreyknvl@gmail.com,
        russell.king@oracle.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brief description on how to use stacktrace/common.h to implement
a stack unwinder.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/common.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index f86efe71479d..b362086f4c70 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -2,6 +2,14 @@
 /*
  * Common arm64 stack unwinder code.
  *
+ * To implement a new arm64 stack unwinder:
+ *     1) Include this header
+ *
+ *     2) Provide implementations for the following functions:
+ *            - on_overflow_stack()
+ *            - on_accessible_stack()
+ *            - unwind_next()
+ *
  * Copyright (C) 2012 ARM Ltd.
  */
 #ifndef __ASM_STACKTRACE_COMMON_H
-- 
2.37.0.170.g444d1eabd0-goog

