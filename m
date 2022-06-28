Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56055EC62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiF1STb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiF1STZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:19:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C520180;
        Tue, 28 Jun 2022 11:19:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fi2so27448159ejb.9;
        Tue, 28 Jun 2022 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZmdSXyK7MtJsa+B/2L5AP7mAzbY702Ape25QJtokg0=;
        b=VsmkR5qJY0evJ3fm7iM52bgRkE8I9EHXpVN8fHRFZwqPDIm+EbxuoYe1h6fAkoC6/F
         fU/Acpk9fzIEvvuGx2pTJUgQZq+Mxdn81e/xNQbLysGJmJyyJhcGnaAYqBw0IFbI/4oW
         ZBXUj0vxAbyUD5vj4V6xcGqVWCtWnNY4g6VHi+6ny5ckCNUNuD6yN44bqWGq+Yhq9ZPj
         Y+mXPudo+13LbYWaityCt5anaCoSLm02ofIneVlO6tklFAt9vuble+ktxS8eo+ymYLs7
         g5JcgvkSUh2OXOwb3y7ykw3tVOp3kTmwgUPWPfCYRzUaNbgd2F4D+CZKkSKe99jDalbx
         uFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZmdSXyK7MtJsa+B/2L5AP7mAzbY702Ape25QJtokg0=;
        b=no+u2SZspJFmdTDjzc0fXaQ5/7DRkSCekC5F1KJfedkkkNPpIv3Eu42PIyb/wG65v7
         U1clUmfyyAPxXiH3IWZ60LFMyHtZTA2gLjIseOw9VDjOZDgg29orjriAriAXgaOEFx7S
         Foxpg8oOeQQaGYGnVs9WEb9XPTswpU94gpi4UU/Com/vvJntuApo50z0PuWAFr80+atN
         wK/3zVyvXYsT/2iHBbrBYOF72P7OhyPyXuOUdIm61V7RnJX9KtW8bxKzKUyB2QZMXis9
         2pi4X1IqCkH1PYuSwL+8CmExbM8FRmoEQrkksWWRFwtow6spzqiKtqSUrB9tw4tw8vD6
         G71A==
X-Gm-Message-State: AJIora/yX3NIur/28j3yZ1qMn8w14s7oRMuTcYhadFG8h0exokUsUmry
        OIcLb3uZ82QalzhFyNUIHeg=
X-Google-Smtp-Source: AGRyM1u6+ZHcJMTYJAMJeLySWF0XNIa0o5fEsh08zyXa+XE/G0OH2joLIthF8b9FEB9yiwxGeMcAYg==
X-Received: by 2002:a17:907:608d:b0:722:ebcc:b108 with SMTP id ht13-20020a170907608d00b00722ebccb108mr18528050ejc.94.1656440363047;
        Tue, 28 Jun 2022 11:19:23 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm6730824ejd.196.2022.06.28.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:19:22 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Kiryanov <nikita@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: display: startek,startek-kd050c: allow bus-format property
Date:   Tue, 28 Jun 2022 20:18:37 +0200
Message-Id: <20220628181838.2031-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220628181838.2031-1-max.oss.09@gmail.com>
References: <20220628181838.2031-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Allow to specify the optional bus-format property newly added to
panel-dpi.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

(no changes since v2)

Changes in v2:
- New commit allowing bus-format property for derived startek yaml

 .../bindings/display/panel/startek,startek-kd050c.yaml           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
index fd668640afd1..05306713044e 100644
--- a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
@@ -19,6 +19,7 @@ properties:
       - {} # panel-dpi, but not listed here to avoid false select
 
   backlight: true
+  bus-format: true
   enable-gpios: true
   height-mm: true
   label: true
-- 
2.20.1

