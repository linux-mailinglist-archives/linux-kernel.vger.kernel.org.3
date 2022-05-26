Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBFA534945
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiEZDQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiEZDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:16:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE04EE3C;
        Wed, 25 May 2022 20:16:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c14so650202pfn.2;
        Wed, 25 May 2022 20:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJkpAY5J5OYSDURsc529cHvymHUqP4kRqRfmka6ZmsE=;
        b=Jk45dUi05epNEnQ36gijQX1NTzUXD12rkoFLcqm8oqmaTFnvBHCdCZQAy96Z4Npq46
         VMh8/2W+NmJGoOdR93zVjJIt+Gz7u4CIaB1V1vt2/Vh9Q8BrZa1eINivIkxRaiWCxYJO
         pGC3vPyFzs5ynmUKlCRC9AziQLPA/A3T4t1gjD50EIw8jOjMBYlQGrgDkpmhpNkyzlZm
         pOQeHmTtiYZCIWi0N8EQVWLKlut/jMETw/Rf13/zJTpEbZUc6YzhhnJ4wYVrviup8E9G
         Qd6EiTalyqlocZCiiHk6Y23sjKQ8rAW/P+ImhKqmvBrmMhxiAS086hmv0rtsER8+VQnF
         cP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gJkpAY5J5OYSDURsc529cHvymHUqP4kRqRfmka6ZmsE=;
        b=NUQArnDgSyt61lFKwv6razIjyvWP+SMThIP7DTG/XJFOciesFZ8DAGcwL7m/AROSml
         8XM0ryr8okkeQhM36K9dmv8OuYbM85G+WQN9kRq2cOr+HT9KA38DxWXaOaa+TBlYNrwU
         5Fyra5Qmp97E75bLuvSDw0jEA5aPGqcFrl3yNg1oxgnxsDn5+yaHLFdwwIpKTX42F+wJ
         oQk5aPlPXN6QULNDHdvKucIQ38k1NGTJhHaVYyGHVSuEIBOXg2lb0v16aZBo16Idc25H
         mqRSQaSFV215qclvC4KADsUueg+dipsFEwDSvjL6euVdHxwF1iXKbS3irsbBz5ctI44r
         n7Zg==
X-Gm-Message-State: AOAM532QdAeAN37dZDyCHYeab063gftvU0DcI8HR0T3flULjD6tXVnmL
        O/oNI84PEDGyk/csoSahOnXHvyw+eLEKNg==
X-Google-Smtp-Source: ABdhPJwX32UAU3Bp3W9+y/lNWbYLb1ZL1Eord0ZY0yd4gzpVlC3AhrFJI1Wn7OP4oyRPTLFJD4K8vA==
X-Received: by 2002:a63:28c:0:b0:3c1:6f72:7288 with SMTP id 134-20020a63028c000000b003c16f727288mr30961365pgc.564.1653535007427;
        Wed, 25 May 2022 20:16:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:6b12:f420:101e:bfc0:b57c])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b0050dc7628181sm152964pfq.91.2022.05.25.20.16.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 20:16:47 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property for ocp level selection
Date:   Thu, 26 May 2022 11:16:34 +0800
Message-Id: <1653534995-30794-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the new property for ocp level selection.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 ++++++++
 include/dt-bindings/leds/rt4831-backlight.h                       | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
index e0ac686..c1c59de 100644
--- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -47,6 +47,14 @@ properties:
     minimum: 0
     maximum: 3
 
+  richtek,bled-ocp-sel:
+    description: |
+      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/1.8A
+    $ref: /schemas/types.yaml#/definitions/uint8
+    default: 1
+    minimum: 0
+    maximum: 3
+
   richtek,channel-use:
     description: |
       Backlight LED channel to be used.
diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
index 125c635..e8b8609 100644
--- a/include/dt-bindings/leds/rt4831-backlight.h
+++ b/include/dt-bindings/leds/rt4831-backlight.h
@@ -14,6 +14,11 @@
 #define RT4831_BLOVPLVL_25V	2
 #define RT4831_BLOVPLVL_29V	3
 
+#define RT4831_BLOCPLVL_0P9A	0
+#define RT4831_BLOCPLVL_1P2A	1
+#define RT4831_BLOCPLVL_1P5A	2
+#define RT4831_BLOCPLVL_1P8A	3
+
 #define RT4831_BLED_CH1EN	(1 << 0)
 #define RT4831_BLED_CH2EN	(1 << 1)
 #define RT4831_BLED_CH3EN	(1 << 2)
-- 
2.7.4

