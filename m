Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A59521136
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiEJJqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEJJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:46:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA06272;
        Tue, 10 May 2022 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652175755; x=1683711755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3SQU+ux0v40mWiICOuSb3MrGZXvqywlzRt9MhD618Eo=;
  b=jFvKYZRTJE6xAo+A5HiWKg3y0vrK1n5vOW2Ui4N02Tcqvs2ks/jFUdkB
   w0gS4xT3y5LwyIBXyLgn+15/PFAuGUoTiMMqEgJlvEjuQgxqOaKrmhDua
   fgtlkSBxDypDSnbfOpTJHndq4OGiVCFXxFnBfBfS4Kafflw27Q6XINdBX
   D3faATeC6qk3nz2ElU9/fyjB42gFWud4r/sR03aB1zXD1DMfANhv9k/Ud
   m2CP5RFBapqZo056uFc7nd5tCIlCcSxs7qDDT8FUAHFYWsLrKZiJo7zWe
   eVg1Q80RlI0/kENv6t7izXojOO9GVQIscvJPaC85ZKFQLyDucXAj+o7z2
   w==;
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="95155285"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2022 02:42:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 10 May 2022 02:42:33 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 10 May 2022 02:42:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] nvmem: add Microchip OTP controller
Date:   Tue, 10 May 2022 12:44:55 +0300
Message-ID: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Microchip OTP controller available on
SAMA7G5. The driver gives access to a non-volatile memory which
keeps (at the moment) information like booting media and temperature
calibration data used for thermal measurements.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  dt-bindings: microchip-otpc: document Microchip OTPC
  nvmem: microchip-otpc: add support

 .../bindings/nvmem/microchip-otpc.yaml        |  55 ++++
 MAINTAINERS                                   |   8 +
 drivers/nvmem/Kconfig                         |   7 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/microchip-otpc.c                | 288 ++++++++++++++++++
 include/dt-bindings/nvmem/microchip,otpc.h    |  18 ++
 6 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml
 create mode 100644 drivers/nvmem/microchip-otpc.c
 create mode 040000 include/dt-bindings/nvmem
 create mode 100644 include/dt-bindings/nvmem/microchip,otpc.h

-- 
2.34.1

