Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7557E6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiGVSlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiGVSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:41:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D4B868B9;
        Fri, 22 Jul 2022 11:41:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h132so5080777pgc.10;
        Fri, 22 Jul 2022 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWeiGUgbB/Te5E2qxCGo+QOl86zPGhX0rSetu8yADHI=;
        b=ZgJsZRfHCKAcdhkh1nRJ/gRPa+ODGJbXV19X7SQMWsIy5aZlZIO8o7lRaTmAqRNd/H
         ynQvPqTrmy5OH2o5CllLCogBC+uetlDnWSMepUSLcZSAy0oCVK3Pj5nJOAgItmWm+5Ln
         Iu1435Zl4LVbaBpqPXbp5BYb9YwSZhP6FwmqAnglm+LJAVfp0RP1N1cBimomxCDnUZsq
         ACTUkXE4V6EKU/w410rVeimKdzU/smiN0S9k93RMrhrjE4qqbnlnRkHeKKIlsfJCmEHp
         l1DKIMlKWw7aBOIVHlsmZjsxz04M9WqiHz9VIzjwCaPGvvwndupw+r8wz9RZWLMBKhrp
         3aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWeiGUgbB/Te5E2qxCGo+QOl86zPGhX0rSetu8yADHI=;
        b=BgATWEW9fi+1aZCiqzzfqiBJYXj2Vg54t0r07IBq8qWMNx5E8c5l17tKsY8jeoB1mr
         ig+5TNvU5J1H4/n0KQcFQx0ZhXpt8BSPNblrwWe8+Sds0YNLUwktda5Z84HPDg1c7Rcu
         Sn9KaI6jNjjNatgZ1DJ7LF1WTRXBzSLCkBUWJIJa/WfhHnNV46ZJAqstpFOW1YDbxc5H
         tlD5rHLCTuZZjgllus5wRP9wvvD+l346avRQDwG7COirvvLc6sLV0Slq2PM7OVS783AB
         5KxDx7/AE8nLTPp5fZXYGJd8yuPeueaRQsmC1c9qZkrAGDvKb6FOVap6vywPLy4geNd1
         Vf1w==
X-Gm-Message-State: AJIora+x4WYYX+9Ytwlb84wPe4wDLahEUn/QTIwNUJupfQkyYY3LCfjd
        Agl8A9ZNVucdIX+8HJrZxqZoyIdy/bI=
X-Google-Smtp-Source: AGRyM1tsRj7NU0R3Gg8FAWTv4tcbIF9zMtEt5/TuC5YEXy2+0L6rcIKH6FqvfzaNRKxPf3XCfM1pCQ==
X-Received: by 2002:a05:6a00:e8f:b0:528:a1c7:3d00 with SMTP id bo15-20020a056a000e8f00b00528a1c73d00mr1245280pfb.25.1658515304515;
        Fri, 22 Jul 2022 11:41:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016c9e5f291bsm675976plg.111.2022.07.22.11.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:41:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 2/3] dt-bindings: arm: bcm: Refer to the YAML binding for MEMC
Date:   Fri, 22 Jul 2022 11:41:37 -0700
Message-Id: <20220722184138.2666241-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722184138.2666241-1-f.fainelli@gmail.com>
References: <20220722184138.2666241-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the list of existing compatible strings and prefer to use the
YAML binding which more complete and up to date.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt      | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 104cc9b41df4..4db7209d5be3 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -187,15 +187,8 @@ Required properties:
 Sequencer DRAM parameters and control registers. Used for Self-Refresh
 Power-Down (SRPD), among other things.
 
-Required properties:
-- compatible     : should contain one of these
-	"brcm,brcmstb-memc-ddr-rev-b.2.1"
-	"brcm,brcmstb-memc-ddr-rev-b.2.2"
-	"brcm,brcmstb-memc-ddr-rev-b.2.3"
-	"brcm,brcmstb-memc-ddr-rev-b.3.0"
-	"brcm,brcmstb-memc-ddr-rev-b.3.1"
-	"brcm,brcmstb-memc-ddr"
-- reg            : the MEMC DDR register range
+See Documentation/devicetree/bindings/memory-controller/brcm,memc.yaml for
+a full list of supported compatible strings.
 
 Example:
 
-- 
2.25.1

