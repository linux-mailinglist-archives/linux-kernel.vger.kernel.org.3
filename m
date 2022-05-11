Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5067152286D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiEKA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiEKA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:26:24 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D25C86A;
        Tue, 10 May 2022 17:26:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24B0Q2oF088303;
        Tue, 10 May 2022 19:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652228762;
        bh=r+u+xNyw/SIOrcRn/x4HsI3UIutpES3API0Xd2YG4N0=;
        h=From:To:CC:Subject:Date;
        b=qju2WNU5uyOIWzk4jWq4qJpImFpaNa2FUwp3sTg252GTX1KMLbLlPS2QWDdXBbQ8J
         2iayAPKXHjilADVd66s7XZTgLst77J0NdOHrJftgzkmfJ0+vPTLauvjKWZpVolMSVx
         7LtEpk8W2JPW920wnViEfy/eBFOD6rjpxuYWMv0E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24B0Q2FP016478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 May 2022 19:26:02 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 10
 May 2022 19:26:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 10 May 2022 19:26:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24B0Q1uI028296;
        Tue, 10 May 2022 19:26:01 -0500
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
Subject: [PATCH V2 0/2] rtc: Introduce rtc-ti-k3
Date:   Tue, 10 May 2022 19:25:57 -0500
Message-ID: <20220511002600.27964-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for TI K3 RTC as instantiated on TI's AM625
SoC.

Documentation in the current early release version of Technical
Reference Manual is incomplete at the moment, but due to be updated
later this year.
https://www.ti.com/lit/pdf/spruiv7

Testing log can be found here (next-20220509 + additional node for dts):
	https://gist.github.com/nmenon/df536a01c3c14cf8b6c809aec8972339


Changes since V1:
* bindings updated for review comments
* driver modified to move to regmap fields and review comments
  incorporated.

V1: https://lore.kernel.org/all/20220412073138.25027-1-nm@ti.com/

Nishanth Menon (2):
  dt-bindings: rtc: Add TI K3 RTC description
  rtc: Introduce ti-k3-rtc

 .../devicetree/bindings/rtc/ti,k3-rtc.yaml    |  61 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ti-k3.c                       | 688 ++++++++++++++++++
 4 files changed, 761 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ti-k3.c

-- 
2.31.1

