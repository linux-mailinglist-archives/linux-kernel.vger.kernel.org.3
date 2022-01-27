Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9E49E354
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiA0NXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbiA0NWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEAC061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a28so5283217lfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AfNznDv6b7CrorpQrureC1eis+2zp1+WJpTDBcjrg8=;
        b=Tpzav9Qcow8f/pxSrd/1LhlA99lKNKxHITJN5mLMqV4a6/cCMgMQgzoRqzmYo0UA8s
         TEU5fIwe6djDHfsxziS2Z+MkiXuajna1PLxMA8cOYqFYsyuHpYNU7RX1BJgBEMSb89FA
         C+S5TTgbtxf/YyiJxJ+eRyBhC4A80K88oQ+reovHR1Ne8AKZDtcMw46xu1BnHkIAHlpM
         xS/Vj7bn/28RZlUyjTrpsztedS9tYivODL517FtuQLPCksXMOSb4R9axghrgtyyBz/xj
         5vbbsY/o2cn/HLIBDFm8Kl+WdiJ8zp/kok17dRR3Zz/a1LJENuJkICdeqL1tX1RSZKu+
         IEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AfNznDv6b7CrorpQrureC1eis+2zp1+WJpTDBcjrg8=;
        b=LHZx2MgsWxx1CgvPi0UAplOZCvezHMbS7whe1RQ8d+L002tRj3kR1dyKg3s07G3SvB
         1AAWosthYht9rZlFDkjkJDWWqamsOzwjmhyLpEQaahMLGXJH94h8sZRmP33kYLp+kQ+N
         TvPQwPSMhYQ3I657f/bwe9JGcbZNIpOVfG3cne58lkkXrBiDaAnJputijnqe56bupOpG
         eiTTrVXcssW5wVhwHx1Ngef4+3rQXHKoYK59lj3uhxH/xPBjdCfzRAZicASOfMT35ndU
         vtfoWFw54t9q4utDYBtxjnhO2uxNaACAdEidrhIaORTaPwbGi4RVxALDXb1ejrVdzxel
         WVNQ==
X-Gm-Message-State: AOAM531tQbbbpyGKVdjTIniGNvm0kPFp9OxMP5OTde8F0i6IZOkQ9WaE
        UNvcJVNiYyGoKWDqw7jzKUM=
X-Google-Smtp-Source: ABdhPJyoeNuos9aqWTGAoXTpIpIZkPB0VXonEll0U9lZ8AVvbT5A+Shj4Tw++CheTL1P3HCnwpvKCA==
X-Received: by 2002:a05:6512:128c:: with SMTP id u12mr2810354lfs.441.1643289758153;
        Thu, 27 Jan 2022 05:22:38 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:37 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 03/16] tools/include: Add _RET_IP_ and math definitions to kernel.h
Date:   Thu, 27 Jan 2022 14:21:21 +0100
Message-Id: <5baa036aadb6436c7c36589ce591baaf827aec0b.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add max_t, min_t and clamp functions, together with _RET_IP_
definition, so they can be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 9701e8307db0..4b0673bf52c2 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -15,6 +15,8 @@
 #define UINT_MAX	(~0U)
 #endif
 
+#define _RET_IP_		((unsigned long)__builtin_return_address(0))
+
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
 #define __PERF_ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
 
@@ -51,6 +53,10 @@
 	_min1 < _min2 ? _min1 : _min2; })
 #endif
 
+#define max_t(type, x, y)	max((type)x, (type)y)
+#define min_t(type, x, y)	min((type)x, (type)y)
+#define clamp(val, lo, hi)	min((typeof(val))max(val, lo), hi)
+
 #ifndef BUG_ON
 #ifdef NDEBUG
 #define BUG_ON(cond) do { if (cond) {} } while (0)
-- 
2.30.2

