Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E3562A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiGAE36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiGAE3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:29:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2C58FFC;
        Thu, 30 Jun 2022 21:29:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2614TOGa015919;
        Thu, 30 Jun 2022 23:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656649764;
        bh=JYBVx3JdKuz1QT+7Di8b8mVJ2UBqNYpKk5ZP6ZOIYsg=;
        h=From:To:CC:Subject:Date;
        b=DXeEQ5mZEfQ0z1qNYPVr/NBDomH6WfGWbTwfaK4iP/UIQ51hhzBdThTdqnQG6L/4c
         8xOetdNW67Z/lXnsOM2ctqIS6g6Z1Ln4JOVVU6h0AnRl8Y+kJzAU5FLJ58OqlryB5c
         iN59u4vddiUhBMt3DFkr+6ZgpuGcoh2Y0vycev/g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2614TOOB104506
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jun 2022 23:29:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 30
 Jun 2022 23:29:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 30 Jun 2022 23:29:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2614TOhm015244;
        Thu, 30 Jun 2022 23:29:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Florian Eckert <fe@dev.tdt.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ti-adc128s052: Add support for adc102s021 and family
Date:   Thu, 30 Jun 2022 23:29:17 -0500
Message-ID: <20220701042919.18180-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is probably a continuation of [1] and has a dependency on [2].

Inspiration for this series is drivers/hwmon/adcxx.c though constrained
to the family that I had access to test with.

As stated in drivers/hwmon/adcxx.c, the family of devices are easier to
support since they all (no matter the resolution) seem to respond in 12
bits with the LSBs set to 0 for the reduced resolution devices.

Note: This series does'nt attempt to cleanup the sparse and extended
build warnings existing in the driver.

Series based on [2] and next-20220630

Nishanth Menon (2):
  dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
  iio: adc: ti-adc128s052: Add lower resolution devices support

 .../bindings/iio/adc/ti,adc128s052.yaml       |  6 +++++
 drivers/iio/adc/ti-adc128s052.c               | 26 +++++++++++++++++++
 2 files changed, 32 insertions(+)

[1] https://patchwork.kernel.org/project/linux-hwmon/patch/20181115135013.30723-2-fe@dev.tdt.de/
[2] https://lore.kernel.org/linux-iio/20220630230107.13438-1-nm@ti.com/
-- 
2.31.1

