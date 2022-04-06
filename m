Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9040F4F6EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiDFXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiDFXjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22151FE54B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso7308028pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbl0tI5xWg5AbixL0vHnmPtEGDrnQab/dcpQD6r+8gY=;
        b=lz4NLZqcbFnGC7NhpX3Lae6m6aNJN8k/gEoTYdschgXlHu6O6EOfvqWnLyJ2cCIfdQ
         zg3Pevrwe8qeihORSIEva+g+tiakkbGcenhQKaqJarxzZ1vz0Fi/Ej7yv5Z9Rt2Dvgib
         t1Yzo7LVZHrxMmmRU7+IvC6AkrEPgAxurGHO7sA1h9aYOK2d0IagsOxHfbjlSFnFo9Lb
         XLUISq3b+lJe8Rl4YOem0xLXPK7wZXEr+fyruSKRzReiwFr837+08CQqzymNJU8zxluH
         a1x+w0KoazDUm7ueKBF72kCKsxrpKEnShQhYA5EJ9kdrPmSjida07C6DhJcXnEENKv3a
         hJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbl0tI5xWg5AbixL0vHnmPtEGDrnQab/dcpQD6r+8gY=;
        b=twfJB69W5LzBALYKX17vkJ2WJpXH7R2Jt5VJcq3R2SHySGuJIdnw2zDuxxqJrnhsom
         NcnUp3niDB/fyMXeUMNlKcR+gO5g4MmgBd9BK/nM60AKqO8nOF71Rl/oqhJn+09hEm/F
         2Roer9BC8MCYfujkvkRnTm8FcbE39QCndlBaeYxqQ9PoWA6IXK9kXSf1HRxQW3BnNzDq
         Maal7/Qu8IYJeLImMOI0ysttPOBgvEJJDIWIhbJ2MUrRUe1l3fFlYkQbh+x2A/cQvrt2
         y/VFnJX3WgJESU4LLj/hxnVl73ay8zXZeq2FaRsXEtu7m9iRJ/IFk3asPoFrUZFjivlg
         uLSg==
X-Gm-Message-State: AOAM530kIbmlBcUMFTyYmd+88g/HvwyZR34ve+HVkhn1JP1izcdTt1Of
        2rKT848aZc2Vdg0RVXBMA1Fdiw==
X-Google-Smtp-Source: ABdhPJzNbeu9YbyTYgQk5M1AHgqT1izjhc3Ykg1Y14Qdk9e6F6VJyciuXGztQIPXioXWLdqBuiLAXw==
X-Received: by 2002:a17:90a:4897:b0:1c7:5fce:cbcd with SMTP id b23-20020a17090a489700b001c75fcecbcdmr12753579pjh.45.1649288231948;
        Wed, 06 Apr 2022 16:37:11 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:11 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
Date:   Wed,  6 Apr 2022 16:36:41 -0700
Message-Id: <20220406233648.21644-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the cadence qspi controller compatible for Pensando Elba SoC
boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0a537fa3a641..bc298e413842 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -30,6 +30,7 @@ properties:
               - intel,lgm-qspi
               - xlnx,versal-ospi-1.0
               - intel,socfpga-qspi
+              - pensando,elba-qspi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
@@ -48,7 +49,7 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: "/schemas/types.yaml#/definitions/uint32"
-    enum: [ 128, 256 ]
+    enum: [ 128, 256, 1024 ]
     default: 128
 
   cdns,fifo-width:
-- 
2.17.1

