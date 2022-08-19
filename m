Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0488A599BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348971AbiHSM2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348952AbiHSM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:28:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26DC45063;
        Fri, 19 Aug 2022 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660912102; x=1692448102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUtbXHH8kiRaqk1zOS5U2LUqUUmJtpAwGyEnqH6QJxI=;
  b=ZqjkwrltXse2QUPWLY2WWUAUAg0UCsd5JE0KR3zO4g5NnxJfXqIAPNL2
   jF1AMld0gnOn52cdJYLG76R1ZdahQH/yQ1P5AgAsaRH/FznKdPMISeb7A
   mVcUiCx7zKtbkcc7MB7pROzRV7iPs51qhnlZO0d96zY5XZXMtnWziwpLh
   EA3xWjbKhnzKGUEWlIiYwa08vs17a2meXUU2DtUdXHgI2c2V5czjEQHck
   INVmK0RxbF/CmeHZe77RqI162kj5zIpVWSWlkCi93ktqiBGiPCtsz7Jq9
   nX3AYiuDyV26h4sUwAO8vdn73xI/UFR2hr4qOxtbxQwxafEqcUGvzcVf1
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="109780591"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 05:28:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 05:28:19 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 05:28:17 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 5/6] dt-bindings: riscv: microchip: document icicle reference design
Date:   Fri, 19 Aug 2022 13:22:59 +0100
Message-ID: <20220819122259.183600-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819122259.183600-1-conor.dooley@microchip.com>
References: <20220819122259.183600-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for the icicle kit reference design's 22.09
release, which made some changes to the memory map - including adding
the ability to read the CCCs via the system controller bus. Technically
that was always possible, but the specific CC chosen could vary per
run of the synthesis tool. Hopefully this is the last reference design
version impacting the memory map.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 1aa7336a9672..928ce4d4e087 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - microchip,mpfs-icicle-kit
           - microchip,mpfs-icicle-reference-rtlv2203
+          - microchip,mpfs-icicle-reference-rtlv2209
           - sundance,polarberry
       - const: microchip,mpfs
 
-- 
2.36.1

