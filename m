Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A6351EF30
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358174AbiEHTLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiEHTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12832DFA4
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so7168614wmn.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfRYAmvDSOfkn9xCnjz0sEuzUzffI51ibzudBubF+DM=;
        b=JbtmNvF8ZkRrmp0ZVDodTU7WGYDq/nJm5K36IhG0xquVIIW4xufQWZm7uzfcVk27MZ
         lirnIjLT4sWIjLTkJSy6Ba9N3kz4F4f8oTL7JiC85NXLlCCmFD1OJEg7C7Qi+VzC6SGU
         CL/ff6uZYMgNmZJ++ZtPmceDlgFhTBOUleq3ooznPJNWslMiiXR9u+6JUAIpeUrZQ6L6
         vqCaans+gc7FQxTlqKsCgfAFE16dnqOs7nP3AwPdbU1p7hEdCX9OXPT3jfixxHcwzcoZ
         ck4mAdzN127Vw/XTLuAwVAVz8qTWF4kulGqzP0DvMo/aqLZ3IPfyhWrTGrxgm8RTb0dc
         QwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfRYAmvDSOfkn9xCnjz0sEuzUzffI51ibzudBubF+DM=;
        b=PMqvn/P4ql3x5siwOkGzGW3P6sQACZQ4i4A9IlhT85NzmwB0cYC1qW57FUptiCS9AI
         QzsX4qCoXaWi6JmSA4RMMym4UCdpCidSWKxGqA1KzJAH8LuHL5iv9n0K7o/DV/M3cMk+
         x3DcXrL2Qjs0Mhd+nPA9qIWo4H1jQjvHq1HT5txyJsPrqPv4UB1K9u5FQ2akjkF+waqX
         1xoYxshXrAc8g8oYz1OqIficSo7F0+c27w9DSbydLgg7bm+4iBY89SbbIqGg4GctUv+v
         8onVdECjzZDXNWEk+BiXZMgwK5w2r8umAYINz/9lJFiKlXkM9H/536Hdxdgp/HXr+BL0
         /FqA==
X-Gm-Message-State: AOAM530LBYsjK1wREvwDyyxOSkJCQXz4LJVtO3/rzXL4hKegwGlZn8ky
        Z1zFLkY6R5GG7VNqZ6CRfCF4YQ==
X-Google-Smtp-Source: ABdhPJyyKOdVyYhTCQquA5X3hW0+KtTAcADNYPmxezkDmayc+tb1Atxs9r1zLvCxNR9rBZ2DltO3Sg==
X-Received: by 2002:a05:600c:3388:b0:393:ed53:4ee6 with SMTP id o8-20020a05600c338800b00393ed534ee6mr18991538wmp.1.1652036421657;
        Sun, 08 May 2022 12:00:21 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:21 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 16/33] crypto: rockchip: add myself as maintainer
Date:   Sun,  8 May 2022 18:59:40 +0000
Message-Id: <20220508185957.3629088-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

Nobody is set as maintainer of rockchip crypto, I propose to do it as I
have already reworked lot of this code.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4d4aa20fd08..d673e7ae3872 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17026,6 +17026,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CRYPTO DRIVERS
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+F:	drivers/crypto/rockchip/
+
 ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
-- 
2.35.1

