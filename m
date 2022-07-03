Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAE564603
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiGCIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiGCIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:50:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC5B1F4;
        Sun,  3 Jul 2022 01:49:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n8so8114487eda.0;
        Sun, 03 Jul 2022 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kEykWSiCHta0qNNdWN78VgO+eJrJwNGF5ZUgJ22G7I=;
        b=IpvdwkvSjPMrsFJztZyTt0MYtqdx4hmOYVJh02aTXuJzV0tESDbcjbmS0qT/zbpI8P
         wVQ2bZIa7/FnmKLhjbcZV3qu1zFgOPqFBQwhUxggAsOa/wWV59im4yncrzCyxcwMCxL7
         7IPrdvgtPEhVZJit+PAyOXRM0NXVvoaFzFi5s/HUybHiS5VeOJAJcZ0fiux2OZfJOkcP
         ncotds7BzBtxi04t0WNkY3X2NiUhk74WKJuD8adaaqvWPntJwKwlI5NeUAFiFI41/eaA
         1U2kZIONyQEoGTzEzd1gSEDeMMmFtC+1avNRwWT/V23Vf9PHlP2av2b6IFvqP27arDBD
         G4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kEykWSiCHta0qNNdWN78VgO+eJrJwNGF5ZUgJ22G7I=;
        b=pTmB0SLqza57OU1CqKDHOpH9uP8wAZEK6h1InLqMBRCUYsuAKOLmeSpz4qcGUI34xS
         ip+tmQ5EGQtwTKuCdVzjmF8vBq8NBBCs2GjUJlznC/Z6xrHl8U3x3OBDBkc27PF/oadT
         1sf+ZvVipaiuCzjPccABXMUogbjckE4rCMB1L+LoN31GDjFtP9Vfh8QX453ppVjd+i0t
         rrOpRWrsRe+WuJhDW7cSD/FqUufNgAxCqSjEaG53D1hJbiUsZ7KifTr3UifLempRVcf7
         //KNRb2UrbfzKOLEjrLUasnjL1BhDNwtepwur8RRs3K4I1xYTL26RK0bsgeMASWtSPlT
         pECg==
X-Gm-Message-State: AJIora+PhtHP6b/47DQwFi3rQpfltsNLrzIXcWapDWnhGdqJiGsQdnK5
        HRlDkTXE2zAd9hW0Grw4GkY=
X-Google-Smtp-Source: AGRyM1t144Dv7MFp5yajrHrEBeB+KMtvqrNDra8fyoj4iz51OCTEq/rkb2IrBCCiQhR0EwIeh0gydw==
X-Received: by 2002:a05:6402:2682:b0:437:657f:216f with SMTP id w2-20020a056402268200b00437657f216fmr31142154edd.92.1656838189987;
        Sun, 03 Jul 2022 01:49:49 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m18-20020a170906235200b006fee16142b9sm12666994eja.110.2022.07.03.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 01:49:49 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: nvmem: u-boot,env: add basic NVMEM cells
Date:   Sun,  3 Jul 2022 10:48:43 +0200
Message-Id: <20220703084843.21922-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot doesn't have cells at hardcoded addresses. They are stored in
internal format. It's still important to define relevant cells in DT so
NVMEM consumers can reference them.

Update binding to allow including basic cells as NVMEM device subnodes.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index e70b2a60cb9a..e96bca99f2d9 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -24,6 +24,8 @@ description: |
   Right now only flash partition case is covered but it may be extended to e.g.
   UBI volumes in the future.
 
+  Variables can be defined as NVMEM device subnodes.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
@@ -40,6 +42,14 @@ properties:
   reg:
     maxItems: 1
 
+  bootcmd:
+    type: object
+    description: Command to use for automatic booting
+
+  ethaddr:
+    type: object
+    description: Ethernet interface's MAC address
+
 additionalProperties: false
 
 examples:
@@ -58,5 +68,8 @@ examples:
         env: partition@40000 {
             compatible = "u-boot,env";
             reg = <0x40000 0x10000>;
+
+            mac: ethaddr {
+            };
         };
     };
-- 
2.34.1

