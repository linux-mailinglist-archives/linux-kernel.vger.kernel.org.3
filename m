Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCE4F6E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiDFXjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiDFXjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790C1FCD27
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z128so3508278pgz.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t9+gL+y5i/QNCIpTjrcXEFiRInISCquyFyxbsO8XL7I=;
        b=lQrv/P4hn6LlciweT4SqZd0iOxn/16y7L9KiKpSME26a0sh0Lx3lmpQx8Bux/PeMie
         6oESrbi1ZDk+AeB4gmp9ssD+tBtvnO/2e6lbfSO6V3ASIzy5nDRSQk9jvhj2SIRwyzOk
         4oCixuJcyRhb8Yi+pvL9vzv6O6fWGV3JixIG9gnQBbV48WcrzdWiyuRfUPDF5oVq4vaB
         OCzAzCbGVDlvE+xdjAgkkAZBUyFO3TpVStor6GDEcMP/4mNfEaILG/BR6y0kl5l9lQXK
         hA8tLndD13GXUQQcW1sY9MazzEHiVaJ6Hx+fO6hn8cr5F5kTGVjIgZo18icnwnNq7Rus
         VnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t9+gL+y5i/QNCIpTjrcXEFiRInISCquyFyxbsO8XL7I=;
        b=hpPwomJjYnWjSBwAau6az+hi12CXYSJ4OJkGCi/Tmy4EW1HfEgY7WR2bUgurzlXPoX
         Tq0pitEGuCWTky2npU6PAv/EMmql8umyapnsXJmlHjJBwwCay2cVhA6icl7GT3hDUnOD
         V1fW2Jx2yio5r9mgqZpsbM/26AGPgvOhcI+ezZ6JFRVcFk35cxgepqiU4+n2azn9gHxy
         Eh8fL2AaJb6uAikzY0+5nWLhrj0kZi6oLn0axZq3tnhSaI1rLYDBwTTJPbbajoedC9qq
         eMy/2JPlHfN957sDHSC+el3WKgSkGEpm2w6Kfx5jvSIa+KS8Rvk3IP8SUAdD0ZuVOTES
         z+2w==
X-Gm-Message-State: AOAM532eExIR1bmFJUhVupIlLCJlxL8+2JcDSSc/2fM8lW4zrTGAjfkn
        W97vNmplFnqE+ttFFynMIMWkaA==
X-Google-Smtp-Source: ABdhPJyoPs4NfFhETcRlRVHyTU1R8ztOjFcl2xaEAaNRVRkgtvbj80h35dMSkXq9sZjkkjDMfvNPiw==
X-Received: by 2002:a05:6a00:815:b0:4fb:e46:511c with SMTP id m21-20020a056a00081500b004fb0e46511cmr11195728pfk.54.1649288222881;
        Wed, 06 Apr 2022 16:37:02 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:02 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Date:   Wed,  6 Apr 2022 16:36:38 -0700
Message-Id: <20220406233648.21644-2-brad@pensando.io>
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

Document the compatible for Pensando Elba SoC boards.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Add description and board compatible

 .../bindings/arm/pensando,elba.yaml           | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml

diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
new file mode 100644
index 000000000000..61225f2d6ce5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/pensando,elba.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pensando Elba SoC Platforms Device Tree Bindings
+
+maintainers:
+  - Brad Larson  <brad@pensando.io>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Elba SoC
+        items:
+          - enum:
+              - pensando,elba-ortano
+          - const: pensando,elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

