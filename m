Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B884A54416A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiFICWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiFICWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:22:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC457E1E8;
        Wed,  8 Jun 2022 19:22:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e11so19876426pfj.5;
        Wed, 08 Jun 2022 19:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+CpzL32MJHRZYZDgBzpwQnx86VfK2H69F/qGC0XfI0=;
        b=U0bxjLbFOl10tf8GWT8fIiAYppnmK4xrmmSNHHEf760MXcmV0kCY2V78Ae4maBKj5H
         GpcF03gxnizNDwMshZsC8QdTudjUOr2vWOVN8+mgFHrfI/lf/c3NFVuknm7Fb7zu7bwb
         dZKz+i5301TJ9EWWmS0B9KQf5JNEemrG3Bm5qR3nwBAdUUClvq3aROAfW8qSEMPn9J/s
         +lKc7bze0Ol7qDrCRBOlJmd37/ARrNf/6RuMIh4ZusRWZhOjiCKSCAQpWplu8Er68285
         xTbh2jXiI41+4WvD7vF4PypX+rNH9lRbN5mBR590sgoLa7ElY16YSJ4Iw57UwxZqt1HF
         xZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+CpzL32MJHRZYZDgBzpwQnx86VfK2H69F/qGC0XfI0=;
        b=bfeSB0VIkBULNeXuC8Fmrh1QrVCX/SRvaGCUJZtixNAvnMEvMacp3R9Ws0hQgY3Nmx
         SmX7fovHy31iZ6Z90EZyam1BFNjYMo8xaEWVQ6QAEQT8WWGTWtMz4uSWZkGqlKLQJ02r
         9zLdhcbI5X9rFjc0cvt2WIJH7LZ8VhpV7bapdt7puYqAAISte4IgiM9cNrI5WX/yMXD6
         AE7JwJ8AfwYlObK7aCUHbOPKkfQ/XP7Wv3r3Tf7EL/QM2lEmP6h6VvFAVPNZlyEEnl9E
         y8KmCRYUAw7cDxgABecbxVflqyXtqeK0QThByl4Ekonuk/GFd7CsB3R1sLsTIg8EKJNO
         IGuw==
X-Gm-Message-State: AOAM533WLRDPpZ4F792NsF3atyXIt2HBTdKVxuxlh1FIMhNk+LtdqMM0
        5miCYVnJP6lWHcxsnZIz/JE=
X-Google-Smtp-Source: ABdhPJzXbLLy8MQgfWhrfW3Lanr7tdpKafQO63EjjVGOPJXJ8imC9BhA9caiO6leM26zJoqSXz/oxQ==
X-Received: by 2002:a05:6a00:22d1:b0:51c:15ac:396e with SMTP id f17-20020a056a0022d100b0051c15ac396emr19378533pfj.58.1654741355935;
        Wed, 08 Jun 2022 19:22:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:478:d041:804b:4db9:72:b011])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78056000000b005183f333721sm15748770pfm.87.2022.06.08.19.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 19:22:35 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: backlight: rt4831: Add the new ocp level property
Date:   Thu,  9 Jun 2022 10:22:18 +0800
Message-Id: <1654741339-12756-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654741339-12756-1-git-send-email-u0084500@gmail.com>
References: <1654741339-12756-1-git-send-email-u0084500@gmail.com>
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

Add 'richtek,bled-ocp-microamp' property to make it chooseable.

The wrong backlight ocp level may affect the backlight channel output
current smaller than configured.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v3:
- Refine the description for backlight ocp property.
- Use the enum to list the supported value.

Since v2:
- Change the property name from 'richtek,bled-ocp-sel' to 'richtek,bled-ocp-microamp'.

---
 .../devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
index e0ac686..99e9e13 100644
--- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -47,6 +47,11 @@ properties:
     minimum: 0
     maximum: 3
 
+  richtek,bled-ocp-microamp:
+    description: |
+      Backlight over current protection level.
+    enum: [900000, 1200000, 1500000, 1800000]
+
   richtek,channel-use:
     description: |
       Backlight LED channel to be used.
-- 
2.7.4

