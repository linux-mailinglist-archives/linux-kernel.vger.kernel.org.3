Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4B4BADD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiBQX7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:59:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBQX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:59:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64131907;
        Thu, 17 Feb 2022 15:58:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso7351283wmq.4;
        Thu, 17 Feb 2022 15:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RF2SupLnblRY3PGRxJOT5rLVt7yv2WyDPqmkS+jmfa4=;
        b=Y9Dx1di7yXLg8EBhZ5x+IxrKiVc1XivXfid/HaNES5wbitlhCA1POMl7BB1zCw/B9S
         fw5j2Oc1NcZz6m9Ryp69ciPyKOaN4VBwlVF6P94/jMhknGJ69KGAUsVvKL7VqTdoYGr/
         d2HZjv+BmwW+M6RCiMMntSrofRy0UG6XKOPVkyA2Q5a5NsXxe5JUakPXms2v8EH+RoM+
         ltzPaqWhFVQ0O775Zi0yFu0jgWTq2uIr5sswHhFap/yIHfTWOZscT5AA8YAICOISj6u+
         RA/9O3GUQc8ObriPlUHVXPuAAtVEOhgAJob73vXnZRSVR4eQjK6Cm1XeQCIA/v0f0kkb
         JJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RF2SupLnblRY3PGRxJOT5rLVt7yv2WyDPqmkS+jmfa4=;
        b=mQNjnRUhn9dVF7xodD6PL20O2K+Cm6h8zUL2jQaX4hLAZgtFy+C/OVb8htWX8cTMyf
         kOTY8yJ0RuLtXytkHn/FJ49YNxq8x0v0ugzGqoFDEddFJXOwZ3Ea5E0l4krFtlXvx6Zi
         qgUIxlVI60bgf91zjrICD2hmH5x6TZBKMJGA2BhWTriGbcHE7ExtBVyguxPceSAUaENy
         eHg9eq8DNGmfBtZo1yhyoUb9fkx9KreAVjtYOuy4SQPi4jEVLfRDlkIqR8KwACp+qW8f
         RoxmDLChHfQNdVp687OzQc/HbTWYYquF13r9mYWd3Bx+jrcZgijHQW8WigrbUW/2eshb
         RnpQ==
X-Gm-Message-State: AOAM530uJyA5QJ8iVmCca86+NSF+6eucN77suI3B9tygUJ8YHjeUurBJ
        ULbmtK/xN4tsPHp8VGfSR0k=
X-Google-Smtp-Source: ABdhPJw/9g43AeaBTkk+EuqymDN/lAV4tsvforF4CCWF5AKAlAefszVtMvjUfRWMU7jYwPTm6Pg3Yw==
X-Received: by 2002:a05:600c:4e12:b0:37b:ebf6:3d17 with SMTP id b18-20020a05600c4e1200b0037bebf63d17mr4702866wmq.44.1645142236336;
        Thu, 17 Feb 2022 15:57:16 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:15 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/16] dt-bindings: clock: add ipq8064 ce5 clk define
Date:   Fri, 18 Feb 2022 00:56:59 +0100
Message-Id: <20220217235703.26641-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
index 7deec14a6dee..02262d2ac899 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
@@ -240,7 +240,7 @@
 #define PLL14					232
 #define PLL14_VOTE				233
 #define PLL18					234
-#define CE5_SRC					235
+#define CE5_A_CLK				235
 #define CE5_H_CLK				236
 #define CE5_CORE_CLK				237
 #define CE3_SLEEP_CLK				238
@@ -283,5 +283,8 @@
 #define EBI2_AON_CLK				281
 #define NSSTCM_CLK_SRC				282
 #define NSSTCM_CLK				283
+#define CE5_A_CLK_SRC				285
+#define CE5_H_CLK_SRC				286
+#define CE5_CORE_CLK_SRC			287
 
 #endif
-- 
2.34.1

