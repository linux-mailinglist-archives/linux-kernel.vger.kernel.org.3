Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614F500B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiDNKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbiDNKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:34:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B986542D;
        Thu, 14 Apr 2022 03:32:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23EAWGiU118299;
        Thu, 14 Apr 2022 05:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649932336;
        bh=ddddJ7TATIJxXslnlLmWzV1vziFazwEocG5NL9EQV8w=;
        h=From:To:CC:Subject:Date;
        b=u+5BGrV0RJ0I4Nq7AtT0at+I6eVFcsc2qPSfWGj3sfe/fsu0jb177oD5c2LlmMMLi
         ys3Evv1PgJo2fmtKHyB+pbsS1s+FurjWflz/KME0bLxFLjJo0Z1Lj6jvI9n9SU5nWY
         U6isoXamIMgGfMiVRNpNbLQqhEO+BG81lyxS230w=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23EAWGOY011608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Apr 2022 05:32:16 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Apr 2022 05:32:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Apr 2022 05:32:16 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23EAWC6W097041;
        Thu, 14 Apr 2022 05:32:13 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] AM62: Add support for AM62 USB wrapper driver
Date:   Thu, 14 Apr 2022 16:02:07 +0530
Message-ID: <20220414103211.16202-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for AM62 USB wrapper driver
and its corresponding bindings.

changes since v3:
- Removed the VBUS_VALID interrupt servicing as mode valid bit
  need not be switched based on the connect/disconnect event.
  The mode valid bit is being set during probe and cleared
  during remove
- As VBUS_VALID interrupt is not being used, removed the interrupts
  property from the bindings. As there is change in the dt-bindings
  I did not pick the reviewed-by tags from the earlier version of
  the series.

changes since v2:
- Removed the implementation of detecting the role from the wrapper
  driver and moved the implementation to using linux,extcon-usb-gpio
  driver for role detection.
- Updated the binding documentation and example to reflect the same.

changes since v1:
- Fixed the error with dev_pm_ops uninitialization, in patch 2.
  This was reported by kernel test bot
- In patch 1, made correction in grammer of clocks property description
  and added maxItems in the interrupts property based on comments
  received from Roger
- In patch 1, corrected the title, fixed the description of
  ti,syscon-phy-pll-refclk, added pattern properties and child node
  in the example based on the comments from Krzysztof. 

Aswath Govindraju (2):
  dt-bindings: usb: Add documentation for AM62 USB Wrapper module
  drivers: usb: dwc3: Add AM62 USB wrapper driver

 .../devicetree/bindings/usb/ti,am62-usb.yaml  | 103 ++++++
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-am62.c                  | 332 ++++++++++++++++++
 4 files changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

-- 
2.17.1

