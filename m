Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87524E3165
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353151AbiCUUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353019AbiCUUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40620CE0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v22so8308534wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ucjurjOvrnrrbawIJXLKDlqa8V8uccBbyHnKi4+U0E=;
        b=3wuPfy2RH+Ymxx/9SwcWmTDsnnJEKwy/r9XF6UO5MnE+O8LuVg6+0EzZnQfixXVAvP
         VkH9TpOf6SHabA+zBwjbo9v6wt2HrypvzA8FG1hHvBBUd/y0l6gmEINU6AFVQGXxI5En
         U5Ds7xy1uYkiUXBTx6dWcGWll13LPaVrTUjryrVyc76cpC20WVohsCJCxrKyYfnEFk7Q
         QrSW4FIDI1Zed5rtVxgw3TIdefmHnrJ3mgrjvzhNajq1rSgODe5zPj6NXxjVTZJ0mbFu
         nRTGEYf06+zIg+kq5vvn84dExn3QrgSxwZ866mnMpBAx5VPMjy9l57uWiwiGlGYRvui2
         W2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ucjurjOvrnrrbawIJXLKDlqa8V8uccBbyHnKi4+U0E=;
        b=UjaR9bmPpfZhCfZ/pGC+pGjuQyBUWLVmPh6BBeo2CkJjaXuk1edbGlqP2VBeWxgaF7
         C19zPCN6Z/5IMKCcJVMSHvwCnEWhyU+hh3u/xqcrWG8nDI8xthxpcOYWts09NP/+3868
         TvFeJ0EA/2Uk1aMyRje6jxAcHDpQUU8ktKdWMY1svbdfG34F7PTlWelSJkJmGrGBo8D6
         5EMmS6spx71keobVPmZyymZjvmaCrMRBrYIEZQIs+uERh0e+HD7ORuJ0Ov9GU63P/0es
         FmNW/LH4+MrivStmqL97aOGEiYGzfj+Vckos/sj9kwqDvEvK6JIOepzszrqWNzSYAUYQ
         jAhA==
X-Gm-Message-State: AOAM530WpZ5xmWpTefsieDtuiYB26bvwEluC6HXTmhQQ5AXdYGKyyhur
        XeZZtUZyd2IA+hkqraQw0W/XwQ==
X-Google-Smtp-Source: ABdhPJyE/LR3AyjH3tqnMFFD+/rjJUMIzhATha74RVKWFJS8fgaKQKdvfFPfuNT01HSFlOARgkVZOw==
X-Received: by 2002:a5d:5255:0:b0:203:ec9c:6d5e with SMTP id k21-20020a5d5255000000b00203ec9c6d5emr17807215wrc.70.1647893282761;
        Mon, 21 Mar 2022 13:08:02 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:08:02 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 17/26] clk: rk3399: use proper crypto0 name
Date:   Mon, 21 Mar 2022 20:07:30 +0000
Message-Id: <20220321200739.3572792-18-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321200739.3572792-1-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3399 has 2 crypto instance, reset for crypto1 is correctly named, but
crypto0 not.
Add a 0 to be consistent.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/dt-bindings/clock/rk3399-cru.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 44e0a319f077..39169d94a44e 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -547,8 +547,8 @@
 #define SRST_H_PERILP0			171
 #define SRST_H_PERILP0_NOC		172
 #define SRST_ROM			173
-#define SRST_CRYPTO_S			174
-#define SRST_CRYPTO_M			175
+#define SRST_CRYPTO0_S			174
+#define SRST_CRYPTO0_M			175
 
 /* cru_softrst_con11 */
 #define SRST_P_DCF			176
@@ -556,7 +556,7 @@
 #define SRST_CM0S			178
 #define SRST_CM0S_DBG			179
 #define SRST_CM0S_PO			180
-#define SRST_CRYPTO			181
+#define SRST_CRYPTO0			181
 #define SRST_P_PERILP1_SGRF		182
 #define SRST_P_PERILP1_GRF		183
 #define SRST_CRYPTO1_S			184
-- 
2.34.1

