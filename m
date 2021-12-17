Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CFD47912F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhLQQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbhLQQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:15:57 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA59C061751
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:15:57 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l7so4183640lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15f+Ze6FNJittgFADDHtUgTTcR8503nXs41Ek9JpvtE=;
        b=VbD2B0rwV8JxtTK9S3if64JlLCTU1+5bDRJEaKt2+UYbSqd1c/OxESWU/3Y9zpMOIp
         xORL74GWvGiHXlztq+1LW0UCfy+igFf9w1Jdu7K3HqLiFVk+l5pE5abZt8W5xNDMysQb
         qPfKGAXBnFTmeWw3njr5rer6bTHUcqXan0QYVjZTeHDdgGM8xHoTxbyClEO85YlrWxVL
         T/Q/1PNSV8AGTPboOBoUiOT+wNhZlWG3fwTttJlM1H2dHtlW5EE0XME16ajRXWYowCPq
         jNcnGhYz4Nb8taN4UIiBpVAlZVBLvacuRf/tQrV1Ztk4GPPl1KZvLewAFzHGNR9kqZ16
         IrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15f+Ze6FNJittgFADDHtUgTTcR8503nXs41Ek9JpvtE=;
        b=qcx4IGYBvzEnIs+MO/Gx0LDFp925mm2GS6bSXpZvnBVgplPlteofT9LCklawRL946m
         YKW9DHbVb4LV/OHTPKkK/1bVFSOfAnonvvXWWbK+uFR7KF02kytCniDQwT9w3jqoL7ff
         67gH2f44MQn0f4VC3rgGFxNh1Don9G0/sT++IlNZ4CIiQcAEe1NQkkLh2ybZJIdPM2dS
         LTm4vNps3TqCfOnQ+GyLCkepbEyq0Nd6d4xDIBwVH2S91n9ca8Ocl5GhsbpsBG+zXat2
         DTDDPv86g7Que3pAzF1Hsc7wFzhtM6bOaD+Ux/7LOPHX/BtTGLgsH9Ckk1yXQgTDqeZ0
         SV6g==
X-Gm-Message-State: AOAM530FiytQh5biL5LSc5yls5ybVertc53SBVhTYh48qL3f0y+3ATQQ
        uSjgnQiht0kq8QWQEQrjeoHSsw==
X-Google-Smtp-Source: ABdhPJw+UbN8zwav66L+P3QZG0al+Rw25j2hqujD+XhCzFJatRciH4W39QillkSQFhbPjp34jDPPzA==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3348752ljg.329.1639757755453;
        Fri, 17 Dec 2021 08:15:55 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i18sm1453775lfu.67.2021.12.17.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:15:55 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 3/7] dt-bindings: Add vendor prefix for WinLink
Date:   Fri, 17 Dec 2021 18:15:45 +0200
Message-Id: <20211217161549.24836-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217161549.24836-1-semen.protsenko@linaro.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WinLink Co., Ltd is a hardware design and manufacturing company based in
South Korea. Official web-site: [1].

[1] http://win-link.net/

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added Ack tag by Rob Herring

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 4698213611db..25f94c723cbc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1328,6 +1328,8 @@ patternProperties:
     description: Wiligear, Ltd.
   "^winbond,.*":
     description: Winbond Electronics corp.
+  "^winlink,.*":
+    description: WinLink Co., Ltd
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wits,.*":
-- 
2.30.2

