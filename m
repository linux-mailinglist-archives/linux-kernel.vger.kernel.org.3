Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B155C8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbiF1L23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiF1L2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A16552;
        Tue, 28 Jun 2022 04:28:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pk21so25146688ejb.2;
        Tue, 28 Jun 2022 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7hxbvOysOVU/UTQ861hxTJENidUKbCv/fSaMWTU3aI=;
        b=Kb3GrCLoxkYt2/yVGmqqO4w8RxBfyYZ6rRu+LEu9FAzsG2xDTJNzh8tf9/B84y/aDR
         bOwn5BfibkkSmxciqncxsdkBGyewMT8FU18aKZ/SvMGZ+tTRZFGB9r1VdT/0TFZbe7M6
         LmMDTXWIeqrViuKl8dNo1OB8sHS1F4rT47JUY8ZaDQb0B8Bu5YS+mYbsvPLD/w9MH1Vb
         fF/AvomeNtZA4qcdckaJjf8slVctIuc8khfDjCv078OE3FYj/ILVVt70Bh8RiwchL59/
         LpchdbicFwJOTHOxjYYgkgXM4e3K8mwD95s+2mjFj7x0kuZl96pU8gCLnWNElYRi/xJk
         VTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7hxbvOysOVU/UTQ861hxTJENidUKbCv/fSaMWTU3aI=;
        b=o459icN/okSIUqPfGYCJMfPFxdlhJfYSvjq9eOQHy3ft2hsj+2hJQWo0jwrY6SQn2r
         PkxqqL+M6MHrPTNmDpDsXC6rbBqXbMqIEJFb1e/7PPLOJXsChy79+F74INuleNVsVTmB
         M0iY/35Ilgx44xGtAJjsmhExLIFT317sVMrvdjdzZSySGrswQJR/36YQtLSb5SYQYCrA
         +LD47M++euVmfVV5+/TTAwDt1qclkxRxw6pbmqoSSXOhL4Cd3ue4akruUdX9SFgj5ub4
         dDrF8omBacFqvBP+Ydu8feTkZoCFyYKL0bqP110uz9yQivPsoLBIxNFZMjc+/KKC/7wZ
         xyYQ==
X-Gm-Message-State: AJIora/AAHgWWCVwq0x2hYihJyR9y9Ljb2JBHRI9y0l0sCzQ17zx5s3B
        9iqHqdlTCMyWfb2O1Y6EfNg=
X-Google-Smtp-Source: AGRyM1slseCRLwPgpXyPajn0dpOI3hl7Jgl4zNknGOXyGIQeIUZzYiCPMBFWkQQsyhJE0Hu+dqVM1Q==
X-Received: by 2002:a17:907:7f1d:b0:71d:ea75:e533 with SMTP id qf29-20020a1709077f1d00b0071dea75e533mr17799271ejc.78.1656415691749;
        Tue, 28 Jun 2022 04:28:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 2/8] dt-bindings: mtd: intel: lgm-nand: Fix maximum chip select value
Date:   Tue, 28 Jun 2022 13:27:25 +0200
Message-Id: <20220628112731.2041976-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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

The Intel LGM NAND IP only supports two chip selects: There's only two
CS and ADDR_SEL register sets. Fix the maximum allowed chip select value
according to the dt-bindings.

Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
index 763ee3e1faf3..04f26196c4c1 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
@@ -51,7 +51,7 @@ patternProperties:
     properties:
       reg:
         minimum: 0
-        maximum: 7
+        maximum: 1
 
       nand-ecc-mode: true
 
-- 
2.36.1

