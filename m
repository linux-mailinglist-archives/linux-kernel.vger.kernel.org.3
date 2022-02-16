Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548B4B923E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiBPU0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:26:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBPU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:26:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9636A291F92
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:25:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso7518359pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2GyWQW4AOeXhdTVJEek8pjbfg4kgzr4mtzCMym7m5Q=;
        b=Xx+xaslRTNZT2cL484/FfdIM32lc5cm3V2wLElWrqEpzWFQNKLXAszWrEpbjwkx887
         mjCYfMVWyziW5DZwXOzgI9AUW3vQQkvvnm/k7afj3IDOgoM2JQY6CmbNQ8yQvNvj7Sxy
         sA6EGM8FxaQuW9RVoE0zR4oUBp1I0aIT7csUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2GyWQW4AOeXhdTVJEek8pjbfg4kgzr4mtzCMym7m5Q=;
        b=AWbDwVYRWh7gCr6jKpIqQu2bPOgIB5zOgTxC6yWz4yrYMfEZC8ihvYCZw/VRE/eRZf
         Fd56Om7Cr/DgS0F8raJ6fz7h2Blkn1hr7wOqMiT8ZOxAQ1CNwdNZuTCsTThDI6hT8eTU
         nzTVPg19I17WTA8hWXciaPcq4LxdalyVeh42nnasLkzp+/XpsvUw94SvFIlozCGOhQqL
         EAonnEs9+pEqAy4XWEPfN98EPDHofMy8QH+BCKEFLzAYTH7mA6o/5D54FmMugU5zyV2t
         99MnkwO33vMk2mgM32PlQI61Cv7nQlZarl8+xX+8puR4flZOSTu11fdUmOVymIKs5fcT
         ogXA==
X-Gm-Message-State: AOAM532QGDF7XWil5nfpLy4A0gnPyeEHjzyXLo7AtNTunP4HhTJCGEI3
        PwLNqaKUQTVRQTZ9mb+m+/65XA==
X-Google-Smtp-Source: ABdhPJyy73bpp93MjFAfin2TbdNxN3+HF5dy5YBAIV/5uXckYFoCpVuNFdK9I5wIE8qSyfgEmr//mQ==
X-Received: by 2002:a17:902:7c0e:b0:14d:9791:39f8 with SMTP id x14-20020a1709027c0e00b0014d979139f8mr550136pll.23.1645043150126;
        Wed, 16 Feb 2022 12:25:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm20863771pji.40.2022.02.16.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:25:49 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/fortify: Swap memcpy() for strncpy()
Date:   Wed, 16 Feb 2022 12:25:48 -0800
Message-Id: <20220216202548.2093883-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; h=from:subject; bh=VBoqrwU1wAd7bHaTf5jdNyrULfz4TsKwp9/UCuoHwhE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiDV3L9xZz+xsMzoBruc64R5tYCXvKNNJoc5WmDzpZ Rr5Mgp+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYg1dywAKCRCJcvTf3G3AJi46EA Cd3JYom43s1iB6V1P77LW3esSbdRlgOc+k5ypF5quQtPgxfDC3b29qOHeziNqUbjNehogwsoMETzqQ 9Y4vswU80hM2cPk2y53dx8WqpHgDeJ0oDm+hmSW9imD/lwE11Fwo+9d1P3Snz2WxW3YmC151ew0POz FyDdt3geCi1FVHLG4DUKoLcJnk9uWyOUxUnMW6dfn4G6OkZSoLKcpD508v+PHDOlD3oO0lHumu69rU CLw7eWdyqFrG+fr6GNCT2kIMmYvksOwjrRE5I55GzGts7mLcQVQXReh0HyPuptZIN6f9qyMs6Q71Qa +D9GDODr5TJzt2HoVP1DFAUTCm2Bod68v25LlXQwpGidCkKwhXXsM1VcqkInvWSQcNXSLRm2YA29h4 NF0aFq358FNWNoXZOxFXMwIjhxRioyjpePX4s0c4cNTVJDj1Y6XQUKXxC5zWMZcJOPDXda2SNfh4Zw KtE7ASDCWecvrEDjpIXrNVi5PrJ8E964leB/GeU2kylm/+rKP/V7eKjTyjf1Ml4VK1RRe7k5NR217Y Og2tUKSD2dFTtYYueVZR8wtZgIK0tcNpMNCfzSa6jaEtJhbkKqowJ3iwX2KH39EvTmj89wRaWf6iIW 6yPLHqisAuQkSYCFDjocsxNSDi38BV+ZtA075HYvBjpXjAMr5l0VlGt7v3rg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy() runtime defenses are still not landed, so test with
strncpy() for now.

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/fortify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index d06458a4858e..ab33bb5e2e7a 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -44,14 +44,14 @@ void lkdtm_FORTIFIED_SUBOBJECT(void)
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-	pr_info("trying to strcpy past the end of a member of a struct\n");
+	pr_info("trying to strncpy past the end of a member of a struct\n");
 
 	/*
-	 * memcpy(target.a, src, 20); will hit a compile error because the
+	 * strncpy(target.a, src, 20); will hit a compile error because the
 	 * compiler knows at build time that target.a < 20 bytes. Use a
 	 * volatile to force a runtime error.
 	 */
-	memcpy(target.a, src, size);
+	strncpy(target.a, src, size);
 
 	/* Store result to global to prevent the code from being eliminated */
 	fortify_scratch_space = target.a[3];
-- 
2.30.2

