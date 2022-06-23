Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA858557BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiFWMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiFWMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:55:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27F49CA9;
        Thu, 23 Jun 2022 05:55:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NCtYi1088600;
        Thu, 23 Jun 2022 07:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655988934;
        bh=N+XOku6f1FtWw79fGrMPt6rgknsDGWjAzdTjOZYpKhg=;
        h=From:To:CC:Subject:Date;
        b=U6mLQzN6soIsoaNwHh4u32iCiKDG42Zo1gkDSTkuazGo11jBwdmbushN1cBUIzzbn
         D+A2C13+Vd927Qdn0c1BLlORysuEmxhwcPhLZXHkzNXS2Jhz/WoyuWfdM3Z0dUFwcR
         /StFAZHZWD9i4+uA4Js0TM20J+kWPVn4PsN8Id0s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NCtY2A032180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 07:55:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 07:55:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 07:55:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NCtW4H008068;
        Thu, 23 Jun 2022 07:55:33 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <linux-phy@lists.infradead.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.yadav@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 0/3] Add support for dphy tx on j721e
Date:   Thu, 23 Jun 2022 18:24:30 +0530
Message-ID: <20220623125433.18467-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
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

Following series of patches adds support for dphy tx on ti's j721e
soc. new compatible is added and required cdns dphy ops are implemented.
the series also adds band ctrl configuration required for dphy tx

v4:
-Remove the additional Kconfig for DPHY_TX_J721E support
-Add comments wherever absolute values are used in the code
-Accumulated the acks

v3:
-Fixed the header files order
-Store bands as array of unsigned int, since min[n] = max[n-1]
-Remove unreachable code warning

v2:
-fix a build error reported by kernel test robot <lkp@intel.com>
 which uses clang compiler. did not get the error with gnu toolchain
 9.2-2019.12

Rahul T R (3):
  phy: dt-bindings: cdns,dphy: Add compatible for dphy on j721e
  phy: cdns-dphy: Add band config for dphy tx
  phy: cdns-dphy: Add support for DPHY TX on J721e

 .../devicetree/bindings/phy/cdns,dphy.yaml    |   5 +-
 drivers/phy/cadence/cdns-dphy.c               | 101 +++++++++++++++++-
 2 files changed, 103 insertions(+), 3 deletions(-)

-- 
2.36.1

