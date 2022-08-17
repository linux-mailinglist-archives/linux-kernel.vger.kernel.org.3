Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2C5968D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiHQFnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiHQFni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:43:38 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C87963D;
        Tue, 16 Aug 2022 22:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715016; x=1692251016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O9MNlAbB6jtYY3c/7i6TVBc+bK/0znyL7Wsnaq4cVg8=;
  b=EmBEtty/x5xx/bzMtEfwD4X3+cTh7FJboXiJrXARCa8+CaI1RSul46kb
   x7+/BzMaJEZ9OPiV18cGqIzNVPBkoB8te6hDDa7svU69/9CDwFloo9G5I
   Jw4QueDlnUR12JFzVws52n8VF96q5Q4XGjDtUNj9rf0FcsiQWr97Q2K8e
   0=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="1045102087"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com (Postfix) with ESMTPS id C0FA0449E4;
        Wed, 17 Aug 2022 05:43:22 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:21 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:21
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 695774C47; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 00/16] Variety of fixes and new features for mr75203 driver
Date:   Wed, 17 Aug 2022 05:43:05 +0000
Message-ID: <20220817054321.6519-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List of fixes:
 - Fix for VM sensor allocation
 - Fix multi-channel voltage reading
 - Protect from negative voltage value
 - Fix temperature equation and coefficients

List of new features:
 - Add option to skip reset controller
 - Add VM active channel support
 - Add VM pre-scalar support
 - Add parsing of thermal coefficients from device-tree
 - Add debugfs to updater temperature coefficients on the fly

Changes between v1 and v2:
 *) Fix compilation error for patch 08/16:
    "warning: ISO C90 forbids variable length array"

Eliav Farber (16):
  hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not
    defined
  hwmon: (mr75203) update pvt->v_num to the actual number of used
    sensors
  hwmon: (mr75203) update Moortec PVT controller intel,vm-map property
  hwmon: (mr75203) add Moortec PVT controller reset-control-skip
    property
  hwmon: (mr75203) add option to skip reset controller
  hwmon: (mr75203) fix multi-channel voltage reading
  hwmon: (mr75203) add VM active channels property for Moortec PVT
    controller
  hwmon: (mr75203) add VM active channel support
  hwmon: (mr75203) add VM pre-scalar property for Moortec PVT controller
  hwmon: (mr75203) add VM pre-scalar support
  hwmon: (mr75203) add protection for negative voltage value
  hwmon: (mr75203) modify the temperature equation
  hwmon: (mr75203) add thermal coefficient properties for Moortec PVT
    controller
  hwmon: (mr75203) parse thermal coefficients from device-tree
  hwmon: (mr75203) fix coding style space errors
  hwmon: (mr75203) add debugfs to read and write temperature
    coefficients

 .../bindings/hwmon/moortec,mr75203.yaml       |  60 ++-
 drivers/hwmon/mr75203.c                       | 467 +++++++++++++++---
 2 files changed, 461 insertions(+), 66 deletions(-)

-- 
2.37.1

