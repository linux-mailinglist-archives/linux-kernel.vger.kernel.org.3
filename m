Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EC5543E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354695AbiFVHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350126AbiFVHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:53:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39E2EA3B;
        Wed, 22 Jun 2022 00:53:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25M7rjPH111761;
        Wed, 22 Jun 2022 02:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655884425;
        bh=XRLpJuhaa+vyh1FAr3N8/cRnB8Vfl/3G2BsHH7apZ1M=;
        h=From:To:CC:Subject:Date;
        b=wKkdhaJEGmug5aW2A50jvnS+zGxAyZJsiR2OxQ0SWytnqCUhcqElq8HDLU8D5xwO5
         Sf4kZzUaZr11bfflDS1QKtYkHZsRGcNfAFAt6nIZ5PjeOo59EsixviPsfgIprQR8pb
         XODZj4T6m9e+l0ZdeAyyio9wbT+zCrvrvQIh7K18=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25M7rjS1115076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 02:53:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 02:53:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 02:53:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25M7ridD119679;
        Wed, 22 Jun 2022 02:53:44 -0500
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
Subject: [PATCH v2 0/3] Add support for DPHY TX on J721E
Date:   Wed, 22 Jun 2022 13:23:37 +0530
Message-ID: <20220622075340.16915-1-r-ravikumar@ti.com>
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

Following series of patches adds support for DPHY TX on TI's J721E
SoC. New compatible is added and required cdns dphy ops are implemented.
The series also adds band ctrl configuration required for dphy tx

v2:
-Fix a build error reported by kernel test robot <lkp@intel.com>
 which uses clang compiler. Did not get the error with GNU Toolchain
 9.2-2019.12

Rahul T R (3):
  phy: dt-bindings: cdns,dphy: Add compatible for dphy on j721e
  phy: cdns-dphy: Add band config for dphy tx
  phy: cdns-dphy: Add support for DPHY TX on J721e

 .../devicetree/bindings/phy/cdns,dphy.yaml    |   5 +-
 drivers/phy/cadence/Kconfig                   |  10 ++
 drivers/phy/cadence/cdns-dphy.c               | 114 +++++++++++++++++-
 3 files changed, 126 insertions(+), 3 deletions(-)

-- 
2.36.1

