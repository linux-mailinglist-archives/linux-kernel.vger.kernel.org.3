Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04C449D5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiAZXL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:11:56 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41825 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiAZXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:11:55 -0500
Received: by mail-oi1-f173.google.com with SMTP id q186so2563680oih.8;
        Wed, 26 Jan 2022 15:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Mok2j1GgBP2T1CHyIwzlWU/9+Ay325EMNQEQYyIHqE=;
        b=RIJkqLeynziLzpnM9mRr+IUcVfZDwwRgZo0EOaUQwsZhmpCzmcPCUubT8luZL2F35O
         1hh5zI3uvSDJO3YxG0QVwX0Q3Bv9iAP9QTsm3S2jP2ymMYlBg6LvsvJ0Z9E4XSo7rtca
         Z/nKmOAiYCGF/5DFwsA265sOWe6y+mpf8g/spgqQQmQlZD49UJUtD1QMcEzM7PYkX6f7
         mnZqsVEneQ+aMYsU87l/GQaCG2aWHbZKDf22qK2OmaH/fgV53lvBRIFP/BRSG4Cqx+Iy
         UFMWK74z+se5B/s3dnthkjxZjBVoMVtrowb6NN+jjCIqs65oJncYG5iBF3GPPFfoxODq
         OFMw==
X-Gm-Message-State: AOAM533uy6E0qB12EOx/gTKm8rbmc+IA/TI32Zs4FXq2vy4oDBi0qt5z
        8OB9+mVH5ItswCZLzBeOtoxFNB7OnA==
X-Google-Smtp-Source: ABdhPJy+zS4YjIP8yztQ1CYvvtvlt7fOzn2iIL10zStKwyccn/iQIIFeJtAY4QQ9wTQ05ldibf1f8Q==
X-Received: by 2002:a05:6808:138e:: with SMTP id c14mr5544063oiw.55.1643238714808;
        Wed, 26 Jan 2022 15:11:54 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id d14sm5279329ooh.44.2022.01.26.15.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:11:53 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm,cci-400: Add interrupt controller to example
Date:   Wed, 26 Jan 2022 17:11:46 -0600
Message-Id: <20220126231146.1632819-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to parse the 'interrupts' an interrupt provider node is needed.
That is because the example is a full example (starting with root node)
and on those we don't guess and generate a fake provider.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/arm,cci-400.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,cci-400.yaml b/Documentation/devicetree/bindings/arm/arm,cci-400.yaml
index f8530a50863a..1706134b75a3 100644
--- a/Documentation/devicetree/bindings/arm/arm,cci-400.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,cci-400.yaml
@@ -119,6 +119,11 @@ examples:
           arm,hbi = <0x249>;
           interrupt-parent = <&gic>;
 
+          gic: interrupt-controller {
+              interrupt-controller;
+              #interrupt-cells = <3>;
+          };
+
           /*
            * This CCI node corresponds to a CCI component whose control
            * registers sits at address 0x000000002c090000.
-- 
2.32.0

