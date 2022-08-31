Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127155A76C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiHaGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiHaGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:39:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90792BD77D;
        Tue, 30 Aug 2022 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661927939; x=1693463939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3h6fHhHRDNQcqkMpD+T/7yDsiWITob0fje7mD5mrhvw=;
  b=uRibIK28PaDk+k+CCHmwmWLQ3Sz2KSUCXid5mvE6P85noSXpog9cxZs1
   f//toMjPOOoZk12ssewIT11htpACXp/30ua6YX+ae9mLK9ZsVCVOagFSk
   02olafo364y4sNg2PW45UonT6Cha7nJrzHy0DbFsRSmB7+5Btb/caas3O
   lOuWsm9e1ktV+2GiQmpApU/IrwI47+9NIPbrNvyY7S4/EKDVCKOB5XtUM
   88xa9kcOEswXW/jha+DqV2A7o+hwPKnVWyyEibevSHjJd47cKapy77cZ5
   hTdCmRU+xlV3mIkB7Zp+XH80hxhOhBDH+1r9/ETaTe13SR7rI2pzezQk9
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="188777660"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 23:38:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 23:38:59 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 23:38:57 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v3 0/2] nvmem: lan9662-otpc: add support
Date:   Wed, 31 Aug 2022 08:42:36 +0200
Message-ID: <20220831064238.102267-1-horatiu.vultur@microchip.com>
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
 drivers/nvmem/lan9662-otpc.c                  | 223 ++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
 create mode 100644 drivers/nvmem/lan9662-otpc.c

-- 
2.33.0

