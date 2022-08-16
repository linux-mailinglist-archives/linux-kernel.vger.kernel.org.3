Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6D5956F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiHPJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiHPJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:47:19 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1814137918;
        Tue, 16 Aug 2022 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660638496; x=1692174496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qa2GdofisJzXGHq+6k4uRChibu19E7Wu/JMM8sLS54o=;
  b=FHarqwvgNZxHZv6/PxnHmNevIZqH3otBo64+34X8oSi99LOlRVBr7SKA
   HyV8+ppjsS7xX5C/BS3p6cFKTa9O01AoDONBwbNwwKq/yiUebAZuoz7Jx
   xELPRHQWbYVyZ33/RAsKwEWkBNplHxx1vDgCLuHjnm9OOtYpmK/EdPRAz
   I=;
X-IronPort-AV: E=Sophos;i="5.93,240,1654560000"; 
   d="scan'208";a="1044708625"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-388992e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 08:27:59 +0000
Received: from EX13MTAUEE001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-388992e0.us-west-2.amazon.com (Postfix) with ESMTPS id 551641040FB;
        Tue, 16 Aug 2022 08:27:59 +0000 (UTC)
Received: from EX13D08UEB004.ant.amazon.com (10.43.60.142) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:27:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB004.ant.amazon.com (10.43.60.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:27:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 16 Aug 2022 08:27:58
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 55ADE4C75; Tue, 16 Aug 2022 08:27:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH 00/16] Variety of fixes and new features for mr75203 driver
Date:   Tue, 16 Aug 2022 08:27:41 +0000
Message-ID: <20220816082757.11990-1-farbere@amazon.com>
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
 drivers/hwmon/mr75203.c                       | 465 +++++++++++++++---
 2 files changed, 459 insertions(+), 66 deletions(-)

-- 
2.37.1

