Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA95A1A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbiHYUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiHYUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:36:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA47B72BA;
        Thu, 25 Aug 2022 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661459814; x=1692995814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ybLFVysoZYwExgdwK5f6S7RoZ7nBfaDq2wxphccHM7o=;
  b=A7OMeERLWa1zKR6Km6uo7SIZM8MJLi77Xr297Scn+U0gJbfCu46jznAy
   mxH8fkwfrYpuBhWyPHIaluHtr09EOOSve64WalUSSTWLZxvfzqT44quM/
   g8JhYmSr/6jvqGZqZXjUt/9gy1NqbQ0IfkqfDaFPOTbNgh/Bs1ju95iLE
   FXwwyG11PzUVCeusBDLcUUOm9jqZKJH6jDum5EWKTWTNiprXoTH7gZiJU
   aB6+pvZ6PCiDIwjELpNpXgLypfvAKVCGQ7BAFnhS0E/6pwuaDcoyxMmNy
   wCIZTedRDXrOtRJdRGJpQwLKtgllTiemqp5U//QYvmwWARyMZaWXMpFRb
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="110790084"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 13:36:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 13:36:50 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 25 Aug 2022 13:36:49 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/2] nvmem: lan9662-otpc: add support
Date:   Thu, 25 Aug 2022 22:40:39 +0200
Message-ID: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for lan9662 OTP controller that is available on lan9662.
The driver gives access to non-volatile memory. It allows both write
and read access to it.

v1->V2:
- remove unneed quotes for $ref: nvmem.yaml#
- rename lan966x to lan9662 as not to have any wildcards
- remove compatible string syscon

Horatiu Vultur (2):
  dt-bindings: lan9662-otpc: document Lan9662 OTPC
  nvmem: lan9662-otp: add support.

 .../nvmem/microchip,lan9662-otpc.yaml         |  42 +++
 drivers/nvmem/Kconfig                         |   8 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/lan9662-otpc.c                  | 249 ++++++++++++++++++
 4 files changed, 301 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
 create mode 100644 drivers/nvmem/lan9662-otpc.c

-- 
2.33.0

