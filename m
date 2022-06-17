Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2624854F823
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382446AbiFQNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381190AbiFQNHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:07:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0E710FC9;
        Fri, 17 Jun 2022 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655471269; x=1687007269;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iQ6uwTLDbNgDEjYbGxxIcJvfaqOsqhzEEw1djk0kZik=;
  b=v+O6sl8CnGpGWT0/3JawNVvzOm5yc7T0vJjrskXeKE4qoXW4bCRmq/t6
   LT1C0u/dFeg1bbYvqUttmOWF5toC0FAdBReq9ulrejll+mN8iJ6g5nzRL
   LwC23jLmkobPvYL/s2eyv+xxckrDVbmsbQ/23sm3rUtFBuKxLJhsXS33q
   xmvZtmrl+B9p0Ilqs0X3xFIsF0A5+gECLasUvMSTrjtSewBBNB+S96061
   Z2qw3814he+XaKTVNONEj/k/sCOLk99HU26TJWCgu/wn9WwH2X2E1rf6p
   85YwfeiB7j4qN5zd3wnAm62G/u/BBhryiOY7sFN8uc+7Qw0WvAWcYS4f3
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="168546428"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 06:07:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 06:07:47 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Jun 2022 06:07:44 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Fri, 17 Jun 2022 18:37:26 +0530
Message-ID: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts atmel-flexcom bindings into json-schema format.
Adds support for lan966x flexcom chip-select configurations and its
DT bindings.

v3 -> v4:
 - Fix dtschema errors.
 - Add a condition to flexcom chip-selects configuration as chip-select
   lines are optional.

v2 -> v3:
 - changed IRQ flag in dt-bindings example.
 - added reg property specific to lan66x which is missed in v2.
 - used goto label for clk_disable in error cases.

v1 -> v2:
 - minor fix in title of dt-bindings.
 - Modified new dt properties usage in atmel,flexcom.yaml.
 - Used GENMASK and macros for maximum allowed values.
 - Use u32 values for flexcom chipselects instead of strings.
 - disable clock in case of errors.

Kavyasree Kotagiri (3):
  dt-bindings: mfd: atmel,flexcom: Convert to json-schema
  dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
  mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
    configuration

 .../bindings/mfd/atmel,flexcom.yaml           | 182 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 ------
 drivers/mfd/atmel-flexcom.c                   |  94 ++++++++-
 3 files changed, 275 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.17.1

