Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF274DC56F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiCQMET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiCQMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:04:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE892DA6E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:02:57 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B887D3F1AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518575;
        bh=es7Vl2OJTx5xz9ZVFD+rlfT7kmoz9R9sawZJAjgkoT8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Tuvp1ZwPbURw1y54YPXB0kqir8RE6YtX7SbVzBHBbAsuwkk341QHCwPO4UzhmC6M6
         lfIk3hSALkO5EGou8mBvsAL1O8K3GBncnQU24SNrmRDg6Ww2FMKuGp9ciffUvQRnEm
         hYG6BA5RdKCv1JM5fQHaCOeU+lhv8qvgrHojQq87AbHFztsjklttGYDI4WbHbSxsDc
         f5a1mJN8dnWCQBasVw8S1C7RIcTKZr3EU3L9hei3SdQItFJIMtcQtJMgSI9Uf6S5AS
         HCF4zYB7opziVp4JJLwpTtBeIk2DTEYhy9coTKDzi3OjThE6ZCDTYZIzsZQS/llAiJ
         PzSe936uP8INw==
Received: by mail-wr1-f72.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so1485582wri.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=es7Vl2OJTx5xz9ZVFD+rlfT7kmoz9R9sawZJAjgkoT8=;
        b=Knm+dz7iwr0bfVxHW709iT+AxwnGKm1xuLxG4WyQUUqXy/vVkuEgn2Zbqo2+OVf2Md
         foQh97piHFUNw8zOyHCTQIRZz3leGI2BCjkmbVRqcQv5YkBqCDSD7E/XW1VReqzDp6B1
         lrbnBkSmjT6wgHj7xYzBkWKNysrSY8++OTJiVGln0lfhfwqP15laxCQy14a1RIzqwRig
         yoArdCVNLqa+0K/E6XGRK/7FtAHUdT8AlBhEMi9Sd0Pc1Pm5vm+jdu/lmdGOMKzF5iGw
         v1l7RoaDvNoJvUkVoEFpi7ud/AQp2do4/DER/Dq56iqkPTUXkJa08xYXR/IHJzrV6VSV
         ed9g==
X-Gm-Message-State: AOAM531/8C/ipxG5/TtcWeRFjKUKRt5gwvHlwPa/Wwh0WATvOhd5p6qm
        oZB7L3GAFsJqVTbMKtFgre8Ol0QYrhdIK781/Q7MaLRc9Zb3qK4d8BGjhM+jpYXF5TdP8eKPxdU
        R3xP8s1e596fWDFVV8yBqSzPZT4oYVCUcKNxGI0OFDw==
X-Received: by 2002:a05:600c:3846:b0:38c:7e65:c9e1 with SMTP id s6-20020a05600c384600b0038c7e65c9e1mr1570096wmr.157.1647518575338;
        Thu, 17 Mar 2022 05:02:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2q6MYw/Al/VlClNguK/5gmUljghVGhJck2jjKvYm+01nFaRD/SpC5HhCnJCmy/cHp8HVvhA==
X-Received: by 2002:a05:600c:3846:b0:38c:7e65:c9e1 with SMTP id s6-20020a05600c384600b0038c7e65c9e1mr1570086wmr.157.1647518575150;
        Thu, 17 Mar 2022 05:02:55 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020adfe40a000000b00203eb3551f0sm1745689wrm.117.2022.03.17.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:02:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: irqchip: mrvl,intc: refresh maintainers
Date:   Thu, 17 Mar 2022 13:02:52 +0100
Message-Id: <20220317120252.451669-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason's email bounces and his address was dropped from maintainers in
commit 509920aee72a ("MAINTAINERS: Move Jason Cooper to CREDITS"), so
drop him here too.  Switch other maintainers from IRQCHIP subsystem
maintainers to Marvell Orion platform maintainers because its a bigger
chance they know the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/interrupt-controller/mrvl,intc.yaml           | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
index 75d49c9e956f..6a9c0d279d9b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
@@ -7,10 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Marvell MMP/Orion Interrupt controller bindings
 
 maintainers:
-  - Thomas Gleixner <tglx@linutronix.de>
-  - Jason Cooper <jason@lakedaemon.net>
-  - Marc Zyngier <maz@kernel.org>
-  - Rob Herring <robh+dt@kernel.org>
+  - Andrew Lunn <andrew@lunn.ch>
+  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+  - Gregory Clement <gregory.clement@bootlin.com>
 
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
-- 
2.32.0

