Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BA4B524A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354658AbiBNN41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:56:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354641AbiBNN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:56:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAAD65A2;
        Mon, 14 Feb 2022 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644846976; x=1676382976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WhgHwToS3AP40rPUHhKv2AxIWSk3spmDUHvAqgB73q8=;
  b=YXMH/b0sfayS38Rzkx1N0LIqlvnt0+Qbz2G3Ivf8Zhy/b/0aDomCSHMW
   +x+l8EjaJaaF5TAvyo24rJXc38oPcRPUD2+ag3Jco90acSsQegzZMx8sK
   QK2fUKe2YIU52yzyzjjdUNYGKpNwiygFL/9ixxaW4wH4s+tx9DxDoy4eW
   j/sf6cBuJZh+orznrrzhptEfgY7uIRSWvHKlRYwhyekTEe45NY/lcHt7I
   g85veMxhy+9RTyFi4qeEKe35Un/qJc0GK6/0kPPhGLH17/80JdmrVv0Hp
   Z4LnVi4oR8Qdy4Kl+be6OQMBklanuA8v+FfAnSHNJ+Ag+tLKJ8CzjbxxS
   Q==;
IronPort-SDR: WfFUMexxhgNR55aNGdLqx16PC4bvZgMP416j7+VwUXR+eL6ohzkCwAWZAfF9o9QQ1F9u2Rj6DC
 NZ7n/tphc2d2s1rhvsm83KAyIFaLXrzr/Yy+exHCDzhDuNCp/yMa7t25RQnddr/lneOLewJTHT
 104GXHqtt2NBbCv5c5dN+IiBGpOMRy6L8DanS91VP4LLSdoJwNwxfmMHssxez6A/Op3F00Ejma
 8MQZbAaDxe/hL/pLtLx5IotMZOpkRy/+cNwQVVWbGhnEtSVTMk21nmkEjoBgV6iAkUwvii+seB
 uNeRPS3ekK8qTph9iSyR1n0Q
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="153506330"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 06:56:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 06:56:15 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 06:56:10 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>
Subject: [PATCH v7 02/11] dt-bindings: soc/microchip: add info about services to mpfs sysctrl
Date:   Mon, 14 Feb 2022 13:58:32 +0000
Message-ID: <20220214135840.168236-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214135840.168236-1-conor.dooley@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The services actually provided by the system controller are not
documented so add some words about what the system controller can
actually do. Add a link to the oneline documentation with the specific
details of each individual service.
Also, drop the unneeded label from the example.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../soc/microchip/microchip,mpfs-sys-controller.yaml  | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
index f699772fedf3..b0dae51e1d42 100644
--- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
@@ -10,9 +10,14 @@ maintainers:
   - Conor Dooley <conor.dooley@microchip.com>
 
 description: |
-  The PolarFire SoC system controller is communicated with via a mailbox.
-  This document describes the bindings for the client portion of that mailbox.
+  PolarFire SoC devices include a microcontroller acting as the system controller,
+  which provides "services" to the main processor and to the FPGA fabric. These
+  services include hardware rng, reprogramming of the FPGA and verfification of the
+  eNVM contents etc. More information on these services can be found online, at
+  https://onlinedocs.microchip.com/pr/GUID-1409CF11-8EF9-4C24-A94E-70979A688632-en-US-1/index.html
 
+  Communication with the system controller is done via a mailbox, of which the client
+  portion is documented here.
 
 properties:
   mboxes:
@@ -29,7 +34,7 @@ additionalProperties: false
 
 examples:
   - |
-    syscontroller: syscontroller {
+    syscontroller {
       compatible = "microchip,mpfs-sys-controller";
       mboxes = <&mbox 0>;
     };
-- 
2.35.1

