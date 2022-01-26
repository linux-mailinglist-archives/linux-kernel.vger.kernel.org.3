Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80A449D607
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiAZXNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:13:45 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43775 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiAZXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:13:44 -0500
Received: by mail-ot1-f47.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so802335ota.10;
        Wed, 26 Jan 2022 15:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PocWco8jmUNkxajp5UA6aiOh/XxeK9EU1mlFDUSEVNU=;
        b=UyFeRgm2y4BzRCGROahgtBEpJzhYHqDx+/X4pzymwIjAPyLsKhpkCrHBpC0KJcbzdp
         P7UeYnrCN25DXcnhM8V+E+kBUIWYE97vOuYoYyo507Xzpcl9UFk7M2DsrX7N/dgQYv0N
         qSvIdCOLWRcjxZQVP60smr+3bNOEwcXRUFh8PUOTdhaEoR7UKFGGhI4OKZToTQfNnZVN
         6/IJz8Z3qJo9Ilh2wpG97Z/TDEZ5Reh6LBtotYMOPFJXKwvzLvFb7TyOjg5wVEYUqWdU
         zCg1UKgu5uOy7MG1Cs7ClaUKBHVZH380dExHhhpsKoAj1MkkiiUMQ7HtYbVYcdz375Ym
         vIWg==
X-Gm-Message-State: AOAM532U+WW89hNktNRj9M2O1q32zNoNVqzcrUze5dtRREU1aOVqhEIC
        QHkLJzv9eymrwMdukRqhbA==
X-Google-Smtp-Source: ABdhPJwT4xJtOyBFR53bI7toZJYAzu4RAdlCKSNNB+Rlo7ZDIh3sUIBjts1pX1SYQ+8xtqgOGQ/MlA==
X-Received: by 2002:a9d:7dd0:: with SMTP id k16mr651244otn.369.1643238823637;
        Wed, 26 Jan 2022 15:13:43 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id u3sm2282058oie.30.2022.01.26.15.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:13:43 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Fix 'reg' child node schema
Date:   Wed, 26 Jan 2022 17:13:26 -0600
Message-Id: <20220126231326.1636199-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schema for SPI child nodes' 'reg' property is not complete. 'reg' is
a matrix of cells. The schema needs to define both the number of 'reg'
entries and constraints on each entry.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..3ec2d7b83775 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -23,8 +23,9 @@ properties:
     minItems: 1
     maxItems: 256
     items:
-      minimum: 0
-      maximum: 256
+      items:
+        - minimum: 0
+          maximum: 256
     description:
       Chip select used by the device.
 
-- 
2.32.0

