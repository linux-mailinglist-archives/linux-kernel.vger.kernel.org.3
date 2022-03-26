Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE034E8185
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiCZOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiCZOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1320DB03;
        Sat, 26 Mar 2022 07:43:32 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id b18so8774086qtk.13;
        Sat, 26 Mar 2022 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmLBkFtOQNYFsQqgaT0OsU4d7HAXSeRK+3UTbj0UQ+g=;
        b=Vk0RY86Uw20Ui/DYS1CJQYujvCA8Y3/bjHpbp//pLk8hGomVqjmTPPMug55BGSY4tq
         3mDFZinOfIiDL7C/volTzcPUoUZovWkUa3rE6vbq3YcMRKu6HLCKYbkNw6ekWKKp8TM9
         DvKOG3hwvEu1IwkdzVDXRCAMp9d4Vx94ojsEpslTR3/EvAc8oPA+mBTSSI79uO+onx70
         89Yo4noFGXgtJJBGb0uoe3fwpfFf+wZI/LaVYX2/z6JlC+WNMaAIIs4SKggrZWnmOoyv
         Xr/BbEdu50QojuJEhShUNYS2OLyxajM3qwq1tSHAIULD2tC7eXVYpqLW7h7jUaLJc5+X
         JpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmLBkFtOQNYFsQqgaT0OsU4d7HAXSeRK+3UTbj0UQ+g=;
        b=EeBHoFx/sIzu+LBPD0yrJZEXEE15h3NfQNAYQrYe7My4hhRs+D6dVXNGNFQOtt9sUS
         sxxDF3pipJVQgFtG02jGWJG5QkyuDUC6HVfncE/UfvT9bm7rGRb4FG8oRdH9AZkjupQz
         IVJTJTLPZ1WGWAvyS4hwlKQFjgm2aEwb+631nV02hct/P+2n1IPjVtX8SdAqie+P2OY8
         8QEtZpsiAa+LJE2mHcF2JxP7/ngVRftQ8cFyE3ZEYjaw8+zRMz8GjRKjOTu3z+nP6Vcq
         44aqF85IphGhx47CEUqI99qOhdZDMCtyUzmGRddLJXZGDm2wvLaDK9CkfysLu0G4Crnx
         j10A==
X-Gm-Message-State: AOAM532U6loHib2X9k5RPJYwgY9MempDPhfY7Go3VBL+ghzYXknK4xO9
        sxZIimcqbdS9+Jt3ULOfWKM=
X-Google-Smtp-Source: ABdhPJxTo5Qjtqd7mtZlFM47w+EbLUr32pGi96O0b53IGfCfHhBIsqe8H1D2Xa2xX6I1wwfQiMh2Qw==
X-Received: by 2002:a05:622a:58e:b0:2e1:cdf1:d428 with SMTP id c14-20020a05622a058e00b002e1cdf1d428mr13820115qtb.254.1648305811084;
        Sat, 26 Mar 2022 07:43:31 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:29 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v1 04/12] dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
Date:   Sat, 26 Mar 2022 10:43:05 -0400
Message-Id: <20220326144313.673549-5-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
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

Add DT binding documentation for i.MXRT1170 clock driver.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 .../bindings/clock/imxrt1170-clock.yaml       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml
new file mode 100644
index 000000000000..ca0f9ba8b3da
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imxrt1170-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MXRT
+
+maintainers:
+  - Giulio Benetti <giulio.benetti@benettiengineering.com>
+  - Jesse Taube <Mr.Bossman075@gmail.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imxrt*-clock.h
+  for the full list of i.MXRT clock IDs.
+
+properties:
+  compatible:
+    const: fsl,imxrt1170-ccm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: 32M ext osc
+      - description: 16M int rcosc
+      - description: 32k osc
+
+  clock-names:
+    items:
+      - const: osc
+      - const: rcosc16M
+      - const: osc32k
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imxrt1170-clock.h>
+
+    clks: clock-controller@40cc0000 {
+        compatible = "fsl,imxrt1170-ccm";
+        reg = <0x40cc0000 0x4000>;
+        clocks = <&osc>, <&rcosc16M>, <&osc32k>;
+        clock-names = "osc", "rcosc16M", "osc32k";
+        #clock-cells = <1>;
+    };
-- 
2.34.1

