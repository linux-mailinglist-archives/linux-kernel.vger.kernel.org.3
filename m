Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A58E526AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383910AbiEMTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbiEMTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:45:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18095047D;
        Fri, 13 May 2022 12:45:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24DJiwx4111958;
        Fri, 13 May 2022 14:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652471098;
        bh=7zqVF9gee06v9UNFxBmER3A1z4bsxkTiqQMCrtf4vA8=;
        h=From:To:CC:Subject:Date;
        b=i7yZ4CQAG+1p12YSx86mkqzScBeve/ZNND5u8TjtA88D2jcies3Xw6cQ/974HlVaK
         xp3ko11y482haz+ajfYJml80xxk28jOgRUBnws8IPIxGk3LLArpTdfRJDOQwYtJsum
         VqIGtIKmo0ILWtRxEAO/UUhxPwgx3NEfFWVPH2Nw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24DJiwiG037671
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 May 2022 14:44:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 13
 May 2022 14:44:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 13 May 2022 14:44:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24DJiws4019326;
        Fri, 13 May 2022 14:44:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 0/2] rtc: Introduce rtc-ti-k3
Date:   Fri, 13 May 2022 14:44:55 -0500
Message-ID: <20220513194457.25942-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Hopefully third time is a charm ;).

This series adds support for TI K3 RTC as instantiated on TI's AM625
SoC.

Documentation in the current early release version of Technical
Reference Manual is incomplete at the moment, but due to be updated
later this year.
https://www.ti.com/lit/pdf/spruiv7

Testing log can be found here (next-20220509 + additional node for dts):
https://gist.github.com/nmenon/2139c57212605bb38a4624ad0523416f

Changes since V2:
* bindings updated for review comments
* Driver updated with fixes for issues caught during system level tests in
  5.10 backport testing.
* Picked up Andrew's Acked-by

V2: https://lore.kernel.org/all/20220511002600.27964-1-nm@ti.com/
V1: https://lore.kernel.org/all/20220412073138.25027-1-nm@ti.com/

Nishanth Menon (2):
  dt-bindings: rtc: Add TI K3 RTC description
  rtc: Introduce ti-k3-rtc

 .../devicetree/bindings/rtc/ti,k3-rtc.yaml    |  62 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ti-k3.c                       | 695 ++++++++++++++++++
 4 files changed, 769 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ti-k3.c

-- 
2.31.1

