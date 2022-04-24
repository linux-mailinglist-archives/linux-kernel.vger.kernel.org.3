Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424CE50CE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiDXCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiDXCMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:12:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50ED1AAB70;
        Sat, 23 Apr 2022 19:09:05 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KmBKZ15BgzCs1t;
        Sun, 24 Apr 2022 10:04:34 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 10:09:03 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5] PCI: Make sure the bus bridge powered on when scanning bus
Date:   Sun, 24 Apr 2022 10:07:10 +0800
Message-ID: <20220424020710.17589-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the bus bridge is runtime suspended, we'll fail to rescan
the devices through sysfs as we cannot access the configuration
space correctly when the bridge is in D3hot.
It can be reproduced like:

$ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
$ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan

0000:80:00.0 is a Root Port and it is runtime-suspended, so
0000:81:00.1 is unreachable after a rescan.

Power up the bridge when scanning the child bus and allow it to
suspend again by adding pm_runtime_get_sync()/pm_runtime_put()
in pci_scan_child_bus_extend().

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Change since v4:
- rephrase the commit suggested by Rafael
Link: https://lore.kernel.org/lkml/20220422080404.27724-1-yangyicong@hisilicon.com/

Change since v3:
- retain the pm_runtime_*() calls in pci_scan_bridge_extend() as Rafael points
  out that it's necessary when the brigde is in D3cold
Link: https://lore.kernel.org/linux-pci/20220414123736.34150-1-yangyicong@hisilicon.com/

Change since v2:
- just rebase it on v5.18-rc2
Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/

Change since v1:
- use an intermediate variable *bridge as suggested
- remove the pm_runtime_*() calls in pci_scan_bridge_extend()
Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/

 drivers/pci/probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..b108e72b6586 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
 	unsigned int devfn, fn, cmax, max = start;
+	struct pci_dev *bridge = bus->self;
 	struct pci_dev *dev;
 	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
+	/*
+	 * Make sure the bus bridge is powered on, otherwise we may not be
+	 * able to scan the devices as we may fail to access the configuration
+	 * space of subordinates.
+	 */
+	if (bridge)
+		pm_runtime_get_sync(&bridge->dev);
+
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 256; devfn += 8) {
 		nr_devs = pci_scan_slot(bus, devfn);
@@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		}
 	}
 
+	if (bridge)
+		pm_runtime_put(&bridge->dev);
+
 	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
-- 
2.24.0

