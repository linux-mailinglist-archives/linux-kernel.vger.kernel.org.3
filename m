Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81271558498
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiFWRov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiFWRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:38:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE448335;
        Thu, 23 Jun 2022 10:08:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NH8BoX045820;
        Thu, 23 Jun 2022 12:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656004092;
        bh=KGYknbUssqciCQEYk7df+/1K2EWtkgCJ42/xcj1ZM/Y=;
        h=From:To:CC:Subject:Date;
        b=bgHiHtENuAm55Si79s91b0nvq6v7G7T5mIr2UaP5b+4iqaefTc2aRqnQULNK7YmIk
         fY1lHqVIjNtkHzF87az/PtgDNdixLlqrP5K/STbmbyNZThTOCTefGybRg6rt6TEkwS
         KhIu06+IogA5RsMAxJ+TcU8TPnX3B1pg6ojKZn84=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NH8B8G092148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 12:08:11 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 12:08:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 12:08:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NH8BmL001922;
        Thu, 23 Jun 2022 12:08:11 -0500
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
Subject: [PATCH V4 0/2] rtc: Introduce rtc-ti-k3
Date:   Thu, 23 Jun 2022 12:08:06 -0500
Message-ID: <20220623170808.20998-1-nm@ti.com>
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

One more round..

This series adds support for TI K3 RTC as instantiated on TI's AM625
SoC.

Documentation in the current early release version of Technical
Reference Manual is incomplete at the moment, but due to be updated
later this year.
https://www.ti.com/lit/pdf/spruiv7

Testing log can be found here (next-20220623 + additional node for dts):
https://gist.github.com/nmenon/2949ac6227a834dc64ef463dc737c764

Changes since V3:
* Picked up Krzysztof's Reviewed-by
* Review comments from Alexandre

V3: https://lore.kernel.org/all/20220513194457.25942-1-nm@ti.com/
V2: https://lore.kernel.org/all/20220511002600.27964-1-nm@ti.com/
V1: https://lore.kernel.org/all/20220412073138.25027-1-nm@ti.com/

Nishanth Menon (2):
  dt-bindings: rtc: Add TI K3 RTC description
  rtc: Introduce ti-k3-rtc

 .../devicetree/bindings/rtc/ti,k3-rtc.yaml    |  62 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ti-k3.c                       | 680 ++++++++++++++++++
 4 files changed, 754 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ti-k3.c

-- 
2.31.1

Regards,
Nishanth Menon
