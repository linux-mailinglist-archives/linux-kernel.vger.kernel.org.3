Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD98D5A8E67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiIAGlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiIAGlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:41:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E793D21827;
        Wed, 31 Aug 2022 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662014400; x=1693550400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A18zjfcyW8GPtl0EGrwN8v55tiGG3CXdTX4icvAJJPQ=;
  b=pG4S92o7+2MulRyFqpAcwnnyZDfnk0MavNTQ2HBg/0C0ljtao8HScFdt
   D9NFmSi1DLaGlHceTpIKBdPmFRQC6lkCa7kFDJcKmf5f+BA5rA+vqrFUV
   8Nmvi8PKPNUEqpPeAsjzwdb0qJ1gEwa1D0mlRSfGNopFZUzRV4t4+xT6H
   9uwsYrjxpiUBwCpn3CISVu9X4hb6Vi4LlW2kN16dqBD40jjRF9f1ZlV4a
   9mTLA1Sv/cU6RriMh6/NpHGAByHEaHlD32rQsb0d5/kfy+EIiyaHCOb1F
   nKB/8FJEirZjcoT8mw9qxgAED06egxq+scYOE26R7PpbmD7O2+AambaOZ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="175134799"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 23:39:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 23:39:58 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 23:39:56 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v4 0/2] nvmem: lan9662-otpc: add support
Date:   Thu, 1 Sep 2022 08:44:03 +0200
Message-ID: <20220901064405.149611-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
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

Add support for lan9662 OTP controller that is available on lan9662.
The driver gives access to non-volatile memory. It allows both write
and read access to it.

v3->v4:
- remove lan9668 compatible string from driver
- fix the bindings by changing the order of entries under items for
  compatible property

v2->v3:
- fix dt-bindings, make sure that make dt_binding_check passes
- remove lan9662_writel/readl/clrbits/setbits and use writel/readl
- remove WARN_ON(offset >= OTP_MEM_SIZE) as it can't happen

v1->v2:
- remove unneed quotes for $ref: nvmem.yaml#
- rename lan966x to lan9662 as not to have any wildcards
- remove compatible string syscon

Horatiu Vultur (2):
  dt-bindings: lan9662-otpc: document Lan9662 OTPC
  nvmem: lan9662-otp: add support.

 .../nvmem/microchip,lan9662-otpc.yaml         |  45 ++++
 drivers/nvmem/Kconfig                         |   8 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/lan9662-otpc.c                  | 222 ++++++++++++++++++
 4 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
 create mode 100644 drivers/nvmem/lan9662-otpc.c

-- 
2.33.0

