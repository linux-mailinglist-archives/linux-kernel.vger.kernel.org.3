Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA80F4FD612
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388343AbiDLJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377937AbiDLHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:54:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B456215;
        Tue, 12 Apr 2022 00:32:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23C7W0sa012289;
        Tue, 12 Apr 2022 02:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649748720;
        bh=eW8lzeaakM005YYC3nGUxibHVtMvgv2QH/HoZA6ps4E=;
        h=From:To:CC:Subject:Date;
        b=oF19xDgtVjIvwawiV9/9oOl8Z6RHs+gMb4E+lAbens7ksRIfxlDSWugU4rMAqCP+P
         jljOSKtihdAP76ebpxpNkAGBgkypGW71rMpnqZD/MldHVP3QmF6apqnWx614A99GTN
         EnqkDnr00Lk5kqxrqPkEmnoBbxPfxfSbHLd9m21c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23C7W0SZ031891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 02:32:00 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 02:31:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 02:31:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23C7Vd4X112001;
        Tue, 12 Apr 2022 02:31:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] rtc: Introduce rtc-ti-k3
Date:   Tue, 12 Apr 2022 02:31:36 -0500
Message-ID: <20220412073138.25027-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Testing log can be found here (20220411 + additional patch to get mmc
root fs): https://gist.github.com/nmenon/88c56d63c2e163e7ba1e06f30eee52cc

Nishanth Menon (2):
  dt-bindings: rtc: Add TI K3 RTC devicetree bindings documentation
  rtc: Introduce ti-k3-rtc

 .../devicetree/bindings/rtc/ti,k3-rtc.yaml    |  87 +++
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ti-k3.c                       | 687 ++++++++++++++++++
 4 files changed, 785 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ti-k3.c

-- 
2.31.1

