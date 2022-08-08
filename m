Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649B858C432
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiHHHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiHHHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:36:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA46399;
        Mon,  8 Aug 2022 00:36:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv3so9860041wrb.5;
        Mon, 08 Aug 2022 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QsRY2tIfY7UBaIPWAap3Z+BS4Vv0ACy8asMUJ+/ScDY=;
        b=XgzOZi5pw9a1fvi3NQY8A12+/3RvsZuN5DIGfqmf/DCMA+97OVp6Zg16H1Am3pArr9
         uA6LAr+VGVvp6gsf8tu+7eUcVKX1bVijpRByZnAhoPcv2AE2P0f9cMeAUEKRm0OJaONx
         R3OaIK3y0EIHIHSSxwwlOSb9G+2O3MH4DU4fJLx905DsTQ7JBdk5urHrRgLasEXVS0rj
         h6k167OuZhwbzHjTh7zhbQg/Kz/ntjmZ4ChJWxhnmJ0jGXpmbYXjVLvowTgoxBECPXWE
         Z/Mk1dMrrmCe5Gryk0TIUc8VA/av1l24VHNgvz/ur+K2hti+Di04v1xg+D3yJ2x/7kn0
         uZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QsRY2tIfY7UBaIPWAap3Z+BS4Vv0ACy8asMUJ+/ScDY=;
        b=P34ouv3/xTpIfw3PjBTWcve5Spwf/qN2TrZCgItNOvQhKV9p6DaGGjOHj1q6bj+2Fv
         ouITydqz3ngszZ6mDgEtmjmjFzqIXPxs4eN5+J5jwudb5pdYCAuQqNN9wZjiI4G6cHEt
         AeMIF607eAiA8NhZVnTQ3w4rANdLpvbEWxzGOKr+Ied7PZkst3x1b6x2IXZyXCZ1EKF4
         tkT1d9TyKZP2ZZsg3TVeVP4jxjJuD6n1nWPI4MYdP9rzL96uadqv57gQMF/tG89gr2Bl
         WJCQQDtkd4KAKH1xcGHCcPJZ8uPckSrLmvDiv3O1EixwTIesry/hrCXkCU+ZTVyomCMd
         q1pA==
X-Gm-Message-State: ACgBeo0llco5zW8pGJLS6m7GBqGTq8unqfv7ZZZXzYsFepItr3qS0h0/
        6n432VXJj6ExivLApb8013I=
X-Google-Smtp-Source: AA6agR4C4h1vuChPCTUTM1XFVC3A7CRiZQ66XHdQts8YNONqwWPqgype9vgNWCH/BW8lQbgFRBuIBw==
X-Received: by 2002:a05:6000:888:b0:21f:bc6:cc12 with SMTP id ca8-20020a056000088800b0021f0bc6cc12mr10815745wrb.90.1659944205774;
        Mon, 08 Aug 2022 00:36:45 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:36:45 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] util_macros.h: Add macro to find closest smaller value in array
Date:   Mon,  8 Aug 2022 08:34:58 +0100
Message-Id: <20220808073459.396278-8-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808073459.396278-1-y.oudjana@protonmail.com>
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a macro to find the value closest to but smaller than a given
value in an array.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 include/linux/util_macros.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 72299f261b25..ad0020e7932b 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -38,4 +38,26 @@
  */
 #define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
 
+/**
+ * find_closest_smaller - locate the closest smaller element in a sorted array
+ * @x: The reference value.
+ * @a: The array in which to look for the closest smaller element. Must be
+ *  sorted in ascending order.
+ * @as: Size of 'a'.
+ *
+ * Returns the index of the element closest to and smaller than 'x', or -1
+ * if no element smaller than 'x' exists in the array.
+ */
+#define find_closest_smaller(x, a, as)					\
+({									\
+	typeof(as) __fcs_i;						\
+	typeof(x) __fcs_x = (x);					\
+	typeof(*a) const *__fcs_a = (a);				\
+	for (__fcs_i = 0; __fcs_i < (as); __fcs_i++) {			\
+		if (__fcs_x < __fcs_a[__fcs_i])				\
+			break;						\
+	}								\
+	(__fcs_i - 1);							\
+})
+
 #endif
-- 
2.37.1

