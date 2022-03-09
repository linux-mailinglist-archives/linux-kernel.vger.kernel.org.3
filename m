Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0834D3790
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiCIRUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiCIRUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:20:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E4D1989;
        Wed,  9 Mar 2022 09:18:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z16so2901499pfh.3;
        Wed, 09 Mar 2022 09:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/EHiQ5RK0tydATcXcFAZtxqI0UCJ2812+lItUeQolzs=;
        b=pVXNn5vPtFs79c5r/sZZmwnZEmqaMNVksMoDyN4FpUXlD4u3j9DQvLRatq2vl1Aou5
         60pAgGMG/pczWIXlJ8pxt5jrK8ZcF3nCrq+7fIYQ7cv7FGY4lANStJL2oQz2ebVboWIB
         ufB7dgig/4Tle6jYUtOOyRUSPlwMY2c3ySt6TbkrXk6IbCNUqOsUJ7u5KeijKa92eIbJ
         RZkfMqv8iZMxiD3V4K8GsY/xC3wiLBV1B/d5kUCtxWoy5ZLKtSAVYuAeKzRp6DevWWZ9
         u3K9s/PhoiiqXQfaJmPqpPAcYzDX1thPlAKLf9q7A/v5Jb2JZpSRcxlljPTqCpe2Ofa7
         QEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/EHiQ5RK0tydATcXcFAZtxqI0UCJ2812+lItUeQolzs=;
        b=3QAC7hhtXN96xXTxw7htrQbv2RDHtTgxNNrVxkR54t0J2aomwPs5YX/xKu+sVGq1ds
         MZOc+eq3tfIbW6jRWtcg0tsO6vIGQv++zLD9WGtVLpckjjpZrynO/1Z89lPdK/0un5BR
         kcFpvRtUlQy16fDI99WB4O1Zk68vqGZYXXrYomf3QUoJsQUvSxtgce48PetwBIkjJhyY
         W1vym7dRRyM1t52iRPeUAnzGDs8GYmxc0YXeautPEGVY5d7vDI91Rq4QO18CQbHBgtFI
         2N5VghPDV3xNDLN4nijAUZoKM8KvMpeR3u6pE5X1aXenbFAlfB2B6YoW6ojih9kzU4nq
         IGQA==
X-Gm-Message-State: AOAM533VQQBac258AUH2lQYfAHVc2kmK8MAtka0/Skdy3yUtRW3SxjWB
        u9jtWt5sQ+34lnKWAolzUf8=
X-Google-Smtp-Source: ABdhPJwfs6H5I4GdOStkd+gj3PUGN8nkvoPHoPXpJzByV9t6/ZMtKBDDfi4l+sV2kEf/I5ScvaffnA==
X-Received: by 2002:a05:6a00:1806:b0:4f6:f3e8:b3a0 with SMTP id y6-20020a056a00180600b004f6f3e8b3a0mr732392pfa.43.1646846333867;
        Wed, 09 Mar 2022 09:18:53 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id o5-20020a655bc5000000b00372f7ecfcecsm2879429pgr.37.2022.03.09.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:18:53 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] spi: Update clock-names property for arm pl022
Date:   Wed,  9 Mar 2022 22:48:47 +0530
Message-Id: <20220309171847.5345-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

PL022 has two input clocks named sspclk and apb_pclk. Current schema
refers to two notations of sspclk which are indeed same and thus one can
be dropped. Update clock-names property to reflect the same.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v3:
- Drop SSPCLK
- New patch, and drop last 2 patches

v2:
- Keep actual warning and remove path to file
- Reword commit message a bit

 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 6d633728fc2b..bda45ff3d294 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -38,9 +38,7 @@ properties:
 
   clock-names:
     items:
-      - enum:
-          - SSPCLK
-          - sspclk
+      - const: sspclk
       - const: apb_pclk
 
   pl022,autosuspend-delay:
-- 
2.25.1

