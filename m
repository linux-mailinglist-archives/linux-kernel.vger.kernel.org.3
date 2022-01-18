Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9324922D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbiARJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:36:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:22223 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240673AbiARJgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642498578; x=1674034578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KOITIXo9rTTKwEPZruFQPM233i/+GJkiKbootFZI4Yk=;
  b=dCnX/rjWjXqd+Oq7IjcTE/TuNFmeA7fkbzVF4Lm0pfCzp7mvh1te/2Yz
   4WrmvKcqrBvWvlKzYbNfGtJ1WbDLTKgJxX7xtw0YB1ZC6b9/gqKP8zbLc
   wg6Xi4hFiO1b5EyfckInLFTnnmWxPePm94FxRO/DX8HxLoibQ4uSSW7us
   Llmew3Yt7FGhRYqAuX8gg8xYvo3/fcG/xv7uJ83FWhiHGXlwLLizitjIc
   IL248D2JrCi8Uu0nQH+CmrVINVz359+h4KYMVqb3kYZa9JcZKXCDSCZpc
   WSglrx1tdcrktHjrFP27PcDzV8FDZBcPtM7kaeDZWG9KmFNo6/qXh062q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244572557"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="244572557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 01:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="671790221"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2022 01:36:15 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] usb: typec: Only attempt to link USB ports if there is fwnode
Date:   Tue, 18 Jan 2022 12:36:27 +0300
Message-Id: <20220118093627.74098-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that creates the links to the USB ports attached to
a connector inside the system assumed that the ACPI nodes
(fwnodes) always exist for the connectors, but it can not do
that.

There is no guarantee that every USB Type-C connector has
ACPI device node representing it in the ACPI tables, and
even if there are the nodes in the ACPI tables, the _STA
method in those nodes may still return 0 (which means the
device does not exist from ACPI PoW).

This fixes NULL pointer dereference that happens if the
nodes are missing.

Reported-and-tested-by: Robert Święcki <robert@swiecki.net>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Fixes: 730b49aac426 ("usb: typec: port-mapper: Convert to the component framework")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi guys,

Mikhail, I got confirmation from Robert that the patch fixes the
issue.

thanks,
---
 drivers/usb/typec/port-mapper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index 07d307418b470..b6e0c6acc628c 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -56,6 +56,9 @@ int typec_link_ports(struct typec_port *con)
 {
 	struct each_port_arg arg = { .port = con, .match = NULL };
 
+	if (!has_acpi_companion(&con->dev))
+		return 0;
+
 	bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);
 
 	/*
@@ -74,5 +77,6 @@ int typec_link_ports(struct typec_port *con)
 
 void typec_unlink_ports(struct typec_port *con)
 {
-	component_master_del(&con->dev, &typec_aggregate_ops);
+	if (has_acpi_companion(&con->dev))
+		component_master_del(&con->dev, &typec_aggregate_ops);
 }
-- 
2.34.1

