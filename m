Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA458A602
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiHEGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiHEGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:44:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561A72EF3;
        Thu,  4 Aug 2022 23:44:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2756i746089741;
        Fri, 5 Aug 2022 01:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659681847;
        bh=NbN5ZatZ9hEF4yiwVQsDazWp0tE/VwWe3Ve57SMPHRE=;
        h=From:To:CC:Subject:Date;
        b=p1G0WHr0J/3pRMeJ/Wyznmsm2sPNGKUY3hPcQXKLuJzN28VUudAfHEdjHlaBHYMrh
         JW4n1oIbV/K2BdXJlfR95XuGR/nhz3iG/IOt5NZetNVhORPwY4xcQwxlzyS+ynYsZz
         7T0FuEKKlVScc2Jvg2FrKbn2NU60+YjNyiAMqDDc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2756i7k8021649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Aug 2022 01:44:07 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 5
 Aug 2022 01:44:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 5 Aug 2022 01:44:06 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2756hvND086657;
        Fri, 5 Aug 2022 01:44:00 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <lee@kernel.org>, <nm@ti.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 0/4] mfd: add tps6594x support for j7200 platform
Date:   Thu, 4 Aug 2022 23:43:48 -0700
Message-ID: <20220805064352.793918-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset series adds support for the TPS6594x PMIC along with
initial support for its RTC, and poweroff sequence.

Additionally, add usage of the PMIC for the J7200 platform's device tree.

Keerthy (3):
  MFD: TPS6594x: Add new mfd device for TPS6594x PMIC
  rtc: rtc-tps6594x: Add support for TPS6594X PMIC RTC
  arm64: dts: ti: k3-j7200-common-proc-board: Add TPS6594x PMIC node

Matt Ranostay (1):
  Documentation: tps6594x: Add DT bindings for the TPS6594x PMIC

 .../devicetree/bindings/mfd/ti,tps6594x.yaml  |  53 +++++
 .../dts/ti/k3-j7200-common-proc-board.dts     |  16 ++
 drivers/mfd/Kconfig                           |  14 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/tps6594x.c                        | 106 ++++++++++
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-tps6594x.c                    | 181 ++++++++++++++++++
 include/linux/mfd/tps6594x.h                  |  66 +++++++
 9 files changed, 448 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
 create mode 100644 drivers/mfd/tps6594x.c
 create mode 100644 drivers/rtc/rtc-tps6594x.c
 create mode 100644 include/linux/mfd/tps6594x.h

-- 
2.36.1

