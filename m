Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF55510912
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354115AbiDZTfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbiDZTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:35:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB2FE5EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:31:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j8so31137074pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgMaBzrqlCjRGRam/EOt4zCiGdz7YdwH1DVFMVDfBXs=;
        b=4iSQaIpcTJHXcBSlJlEWJJA6caO4iGkaz8udUxWuH377Fy/420RlqSFPr0zuzJTrlI
         ow/Wqnjm31vAQUMgUQy/45uq1nhGdG557XYH+zrIUSAsq6ZwKoy7+8Dg6Tr3fWpFBXQu
         d94vjw7vYnLz14cGh3Uw/0y0V3gM+5QgvwDNsa/auS4Kfb0f67hpPqa7hyiuff2s0SLY
         NZHyaGBtuTCZG0mp2xqJLqyiodo1pzG2i8Q+kabrdjUWz/lLEFng35FBelfQerqeggBC
         To48LL5vy2ZrIfj3vPhQLuZBNt9htOroZJUjkp2dRQb4tmfT1WgwiU+g00VCKRKAwgrH
         /N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgMaBzrqlCjRGRam/EOt4zCiGdz7YdwH1DVFMVDfBXs=;
        b=T5ommX0wdKTRus7TG1nNZ9zBBqRNMib0Tw8WSamgAHV1gdA0Vteg4ghF1FNRj/a10U
         U/XZAuiZ0TsKeqHl6KFW136I/re0TYzgVXuzZ2zKmHtfknDtJTfN/Bzh2We+wXjfgTID
         Rnv6xamnPfBqoJ9n9v6llKjAm97XNEVjY7O/w6v6hDJPf7b3bSWuc5AMQAUz1fhzu2xm
         c7zaxR8jPE/ugFwGDQMtel3YgJNkY3Duc3LtaEzFWp5rJxjU4LNaCqeMTmvTpcDTAQCL
         bYcoaWJJEfN+IyYEBIplctC7Q9JPRmYEy3cPVfNy7zvzT/2w23iv41oEBcDJAzozpnuG
         A8ww==
X-Gm-Message-State: AOAM532XN4ATPntLbzLf/G8Waq3rjpZkIisVsxmmi79xKvX3D2E/uutO
        WuSLLbnELNu/4U0Y/QmS6EEBzg==
X-Google-Smtp-Source: ABdhPJwWdeXDoRl1CnV+EVlepDxiTF9qYHgisD3NZHZGVmtsLKeF4TLs8wickLkRyt+RjPIQdF/iiA==
X-Received: by 2002:a17:903:240f:b0:156:8e81:a0a3 with SMTP id e15-20020a170903240f00b001568e81a0a3mr24572132plo.13.1651001515895;
        Tue, 26 Apr 2022 12:31:55 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b0050759c9a891sm15793410pfm.6.2022.04.26.12.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:31:55 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw property
Date:   Tue, 26 Apr 2022 12:32:52 -0700
Message-Id: <20220426193253.663582-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426193253.663582-1-dfustini@baylibre.com>
References: <20220426193253.663582-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add documentation for ti,scale-data-fw property to enable I2C PMIC
voltage scaling during deep sleep. The property contains the name of a
binary file for the CM3 firmware to load.

Based on previous work by Russ Dill.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
[dfustini: split from driver patch and convert to json-schema]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Changes from v1:
- change 'ti,scale-data-fw' to 'firmware-name'
- add 'firmware-name' property to the examples

 .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
index 88d690de050c..fc8fa6ba8c43 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
@@ -40,6 +40,12 @@ description: |+
   override the pin's existing bias (pull-up/pull-down) and value (high/low) when
   IO isolation is active.
 
+  Support for I2C PMIC Voltage Scaling
+  ====================================
+  It is possible to pass the name of a binary file to load into the CM3 memory.
+  The binary data is the I2C sequences for the CM3 to send out to the PMIC
+  during low power mode entry.
+
 properties:
   compatible:
     enum:
@@ -67,6 +73,10 @@ properties:
       mbox_wkupm3 child node.
     maxItems: 1
 
+  firmware-name:
+    description:
+      Name of binary file with I2C sequences for PMIC voltage scaling
+
   ti,vtt-gpio-pin:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: GPIO pin connected to enable pin on VTT regulator
@@ -117,6 +127,7 @@ examples:
            ti,rproc = <&wkup_m3>;
            mboxes = <&am335x_mailbox &mbox_wkupm3>;
            ti,vtt-gpio-pin = <7>;
+           firmware-name = "am335x-evm-scale-data.bin";
         };
     };
 
@@ -157,6 +168,7 @@ examples:
            ti,rproc = <&wkup_m3>;
            mboxes = <&am437x_mailbox &mbox_wkupm3>;
            ti,set-io-isolation;
+           firmware-name = "am43x-evm-scale-data.bin";
         };
     };
 
-- 
2.32.0

