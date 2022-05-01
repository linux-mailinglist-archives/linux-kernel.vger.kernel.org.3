Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC38516774
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353901AbiEATaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352986AbiEATaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:30:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AA2DD7C
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:26:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so17186414wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u32JFIRC//emCZL/Ld3yABcbdL+d3UQ5fDlVHIQccNo=;
        b=sxzkX1VFhNqqe8n7RnKrQj+ftX71cZJmrTDXQ3Fe/e4H96I1o3xuYnj8qWRoBQV1U6
         2ckOvz+BoHOIAc2t2GcZCN6fW5ZKcsYS3QEPrUQvgHE+BOZbwka+DMH8hR02QqpU8otn
         YTmEzsG8pSOXfSxTAju3EmnUR3OTJILSBxeyaMu8hBXrQiyuW3ACk04U72OZZOlNCZx6
         hT2JnLM1UJZ7MGw4b6AILGpa2zVlCARq4TjrJGSasPVKcJ/H00yR47yhXoDDFR7HoqVw
         7iEOBooAl/R7y2YXUBrGJvkbHs8W8Fz30Oo6Nhhx0BTKIEcSs4ZEUM8GoYOaKFm8/+Ck
         F7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u32JFIRC//emCZL/Ld3yABcbdL+d3UQ5fDlVHIQccNo=;
        b=D+Nls4UnXFFSlpPJtNrXztegEhh/tcaKW3NIEb0PMX4jaGzo2GUKU6xDA/0gkhdpbp
         ez2f7TjSpHo70e4foEom3Ghaa6NmfxyBwbJaNw7zk5rFuFS1JAnaMvc5VfPMBO0kQTQf
         XkFP8BqumMH73dlaVldjyUm/mxJfCjlxDP4tmtHOPdeHLLduguSOc2/0ER+UNdNSYyPQ
         9kuWBK/t0yjapXpkYtjWR1VL04OxXvcTmtp2vP0RbNkQBsW2FQruqB+UJfqwqx6Etjcz
         bwmdqfZgmYwS8lMiP07+84wPvK6NfK9lt8g7ZQYBQXOGS5Zwn/f0qFKIJ9XAKF3MSKHj
         8/9w==
X-Gm-Message-State: AOAM5333c5vTr34+piiAj+WLHv6FdUXcrgpKRoO0Ua587aWABPDT3SSW
        8kFMLpwuTEkLqun3cOgGiwuwQQ==
X-Google-Smtp-Source: ABdhPJwjsAF2UAJYsS2UgrYDNjZB+5ZRdRryVx25MuVXxb+axzDv/f0S36XNkvu/gzx9XmYDG8JDWQ==
X-Received: by 2002:a05:6000:10cc:b0:20a:de6f:3c48 with SMTP id b12-20020a05600010cc00b0020ade6f3c48mr7011148wrx.650.1651433191975;
        Sun, 01 May 2022 12:26:31 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm6448105wrb.18.2022.05.01.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:26:31 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/8] riscv: dts: microchip: move sysctrlr out of soc bus
Date:   Sun,  1 May 2022 20:25:53 +0100
Message-Id: <20220501192557.2631936-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220501192557.2631936-1-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The MPFS system controller has no registers of its own, so move it out
of the soc node to avoid dtbs_check warnings:
arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dtb: soc: syscontroller: {'compatible': ['microchip,mpfs-sys-controller'], 'mboxes': [[15, 0]], 'status': ['okay']} should not be valid under {'type': 'object'}

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 746c4d4e7686..bf21a2edd180 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -146,6 +146,11 @@ refclk: mssrefclk {
 		#clock-cells = <0>;
 	};
 
+	syscontroller: syscontroller {
+		compatible = "microchip,mpfs-sys-controller";
+		mboxes = <&mbox 0>;
+	};
+
 	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -446,10 +451,5 @@ mbox: mailbox@37020000 {
 			#mbox-cells = <1>;
 			status = "disabled";
 		};
-
-		syscontroller: syscontroller {
-			compatible = "microchip,mpfs-sys-controller";
-			mboxes = <&mbox 0>;
-		};
 	};
 };
-- 
2.36.0

