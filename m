Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133D5B222A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIHP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIHPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:24 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8F82F90;
        Thu,  8 Sep 2022 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650724; x=1694186724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g4pwWf8NVAnMTVuQQpLeybb/sfn8btgi5B2EDS6U7ho=;
  b=IfMjQtXqYZ1uKpPLhRtSykgsL+6B8PZ0/vqcV0R/oCqukMW6JRPx1WUi
   1XWOYGlJydTcEGC1oD2BwJ4ApWsU2RRzLh+GzlZD1qxLPPRKlBwb6aBjb
   m7kq5/SphQda2BMQVU2Yfknh/xmU/INP/xI8qWObgD/oBHKEews4lQyhe
   o=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="239041919"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id E12232015A5;
        Thu,  8 Sep 2022 15:25:08 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:51 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:51 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:50 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 766CC4D8A; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 00/21] Variety of fixes and new features for mr75203 driver
Date:   Thu, 8 Sep 2022 15:24:28 +0000
Message-ID: <20220908152449.35457-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List of fixes:
 - Fix "intel,vm-map" property to be optional.
 - Fix VM sensor allocation when "intel,vm-map" not defined.
 - Fix multi-channel voltage reading.
 - Fix voltage equation for negative source input.
 - Modify the temperature equation according to series 5 datasheet.
 - Fix coding style issue.

List of new features:
 - Modify "reset" property to be optional.
 - Add optional "moortec,vm-active-channels" property to define the number
   of active channels per VM.
 - Add support for mr76006 pre-scaler to multiply the voltage result by 2.
 - Add support for series 6 temperature equation.
 - Add coefficient properties to fine tune the temperature equation.
 - Add debugfs to read and write temperature coefficients

---------

Changes between v4 and v5:
- 0004: Add detailed comment in code explaining the cast and the div instead of
  right shift or use of BIT().
- 0011: Fix typo in description (nou --> not).
- 0020: Return j coefficient to use debugfs_create_file() instead of
  debugfs_create_u32() because j is signed.
- 0021: Move the coding style patch to be last in the series (it does not fix
  the code), and remove the "Fixes:" tag.

Changes between v3 and v4:
*) Provide a Fixes tag for all fixes in the series.
*) Start series with fixes.
*) New patch to add description in moortec,mr75203.yaml.
*) New patch to add moortec to vendor-prefixes.
*) Fix moortec,mr75203.yaml checker errors.
*) Remove validation of device-tree parameters.
*) Fix per patch specific comments (detailed in each patch).

Changes between v2 and v3:
*) Add "moortec" prefix to all new device-tree properties.
*) Change order of patches.
*) Add explanations to better understand the changes.
*) Change "reset" property to be optional and remove the
  "reset-control-skip" property.
*) Split the patch for "fix multi-channel voltage reading" to two
   patches.
*) Change pre-scaler property format and fix typo (scalar --> scaler).
*) Fix voltage equation to support negative values instead of limiting
   value to zero.
*) Temperature equation - protect from overflow and add clamping.
*) Add new "moortec,ts-series" property to select between temperature
   equation of series 5 or series 6.

Changes between v1 and v2:
 *) Fix compilation error for patch 08/16:
    "warning: ISO C90 forbids variable length array"

---------

Eliav Farber (21):
  dt-bindings: hwmon: (mr75203) fix "intel,vm-map" property to be
    optional
  hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not
    defined
  hwmon: (mr75203) update pvt->v_num and vm_num to the actual number of
    used sensors
  hwmon: (mr75203) fix voltage equation for negative source input
  hwmon: (mr75203) fix multi-channel voltage reading
  hwmon: (mr75203) enable polling for all VM channels
  dt-bindings: hwmon: (mr75203) add description for Moortec's PVT
    controller
  dt-bindings: hwmon: (mr75203) change "resets" property to be optional
  hwmon: (mr75203) skip reset-control deassert for SOCs that don't
    support it
  dt-bindings: vendor-prefixes: add vendor prefix for Moortec
  dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels"
    property
  hwmon: (mr75203) add VM active channel support
  dt-bindings: hwmon: (mr75203) add "moortec,vm-pre-scaler-x2" property
  hwmon: (mr75203) add VM pre-scaler x2 support
  hwmon: (mr75203) modify the temperature equation according to series 5
    datasheet
  dt-bindings: hwmon: (mr75203) add "moortec,ts-series" property
  hwmon: (mr75203) add support for series 6 temperature equation
  dt-bindings: hwmon: (mr75203) add coefficient properties for the
    thermal equation
  hwmon: (mr75203) parse temperature coefficients from device-tree
  hwmon: (mr75203) add debugfs to read and write temperature
    coefficients
  hwmon: (mr75203) fix coding style space errors

 .../bindings/hwmon/moortec,mr75203.yaml       |  97 +++-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/hwmon/mr75203.c                       | 433 +++++++++++++++---
 3 files changed, 466 insertions(+), 66 deletions(-)

-- 
2.37.1

