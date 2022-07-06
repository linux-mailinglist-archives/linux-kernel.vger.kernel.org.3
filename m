Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDE5681B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiGFIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiGFIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:34:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2133.outbound.protection.outlook.com [40.107.100.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81F248CB;
        Wed,  6 Jul 2022 01:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYJBvZiHF845CN+rT+INF5GBIvTkw+CiI09o3pSg7JknTuV+MZgGX0OaqrBdmT2TUEPZ1VZh7hnULw+ySc6WDQaqNg2ufJyde2vtyFgWO83/EqVwxZa2IjW+HalXaR9/VsuHYMirYTzI5wlbhVx4Jg1PEbUpUuJmZUndVLyJ5jd4R2J7cixwxyH8ScgZA394NSDeUTAtFg3NZi3GkMJBm4Y8dsMDqrcM/NW6P0AjD0ZaxJcXhcpBqtFtskU1UDSg0ZYYkLCTTvO9Da/v/x7swy7KNp+c+NQsupZHksJbCaA5rL32qCkmp5oGgFchDrB9ujKx3m2R3p74pvWPXYkHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGfzsoXJkyPafAfFD9ICTdIP4sAg+iiYn910Rf8B5o8=;
 b=WcuPRhKf1r+H5GSMfyKNywVyrdcWn7nMFJe5zeL6j7ImD/gI4lVLqsJ02bK/9r3Fm6zO9KgjcpBvfet9vuwSK2KTIMfQ2ipw0mY+Qfi/2T9hKFzJiChyVJ+Q0ynnke5B66uQvZEMgnrE9wtEtkGALnPweJo/PkPxzONncGW478/T+x9nYDm9dHCsJePxcOB10pFU4lmiZwwVv+YhAMllR1nIQ2PAK5o4T73OCrHIAEks+hnMy4c4ns+8T31+qu+9tJg3yAaAxm20b4mEdRqNrOrwrkOBbDFaM+S0Yh+c254WWVJl7sVo5HKw7Yt6ijVsvENSJAiHaloxAdy9TVwP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGfzsoXJkyPafAfFD9ICTdIP4sAg+iiYn910Rf8B5o8=;
 b=JcO7J4yavZGEMKZxOGTfjzKMtD3iaod3GgLxyknnuzTtP06fPaA/E/79H6pp/acs3gRXCKvCkn1bJRLHjhooawOXQRIShPnVcK3V4urdbXkJvTzvmZWcmbsrPsdtW0oHZwKVNSBY+9HN5hFRZSZtuad1DOKzpFLV3LHoOYKycwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
 by CO6PR04MB7827.namprd04.prod.outlook.com (2603:10b6:303:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 08:34:53 +0000
Received: from CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc]) by CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 08:34:53 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v14 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Wed,  6 Jul 2022 16:34:31 +0800
Message-Id: <20220706083433.2415524-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To CH2PR04MB6741.namprd04.prod.outlook.com
 (2603:10b6:610:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82740bf-04b8-47bf-6811-08da5f2a6611
X-MS-TrafficTypeDiagnostic: CO6PR04MB7827:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFs0KD0tdnqAAl5+Q7sCdCBb7YYanpDGYRRHAbM8TUNcnDx5twAxQ5vXE+jQb7h0b9OTnaeEnvvOgf8q0b59FRtWLUchvapdqei7e2XFz0q9m+eMUFqsQ1Sr270moKjihoUiLVaj6E441LI+TbHjGSWhjwI4sq8CDFpP3ST4mhYm7W+fj241b9Ti5hgzVZfaJh5bz4D7fNRMkeZgFPRhBEmWvNreILXWV7f454IFAzDsLrLwqGc9492o1A/F/AANmg1mBcyCKcpr0A7Kwxu7WbzHHglALyD/qXNCds3NR02e29oZKfVttxhoMATSNxpRhgvDhb0nqkTkxM/9DXBY/ddFjpWKuaPLnzKvSK0kwA0osWW2LRCpOoRVR0MttG2mLc8jDAwbJ9ZdTvKtcYYhx/NvkM8mBzvGWl8iXTJwhqJBdWNl7k0BKr5cswsHj6ENlQkdS3V7gVsIJEaKXZgK1GBkUoC91kg4P4pjh9q4NG0Kv4ZjYNWt9spVaEn0iROYrS+VBIDlvddJglKzkwe7nh7d7zyNREbHew1Df9btSDaGSEb+KHe83148umIKS7oWL86vikCblB3ZViZLtjwN7G8zlBSgGtGaPnukmEd5pgmI/dBVPoItd5MGd/wXhZ+mj/SlVX2Vrx8yDGd/nsQhfo5ZnYV5p2TQoDBNIZ0G3Hq3PiNsASFQY67iFbJxEMelHCQqExKvWOipA/pKOMgRENF9+4nY0q4ofooXuslvrFWEoEGRL8y+NeFNScPP8AmlryP5nNkcX6C1tRA8KC4X26NBPk9JkLWAfG+cpiPg5piDnjwT7+NZKb2ubUZq+hhv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6741.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39840400004)(376002)(136003)(346002)(41300700001)(6666004)(316002)(6512007)(1076003)(26005)(186003)(2616005)(110136005)(55236004)(52116002)(6506007)(83380400001)(86362001)(38100700002)(38350700002)(5660300002)(2906002)(6486002)(8936002)(478600001)(8676002)(4326008)(66556008)(66476007)(66946007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMRtLH3gxTFOgpFJh8EHPto8mfswmzGPjeE011UhGtfYr4P/EpYPdXY++TJ6?=
 =?us-ascii?Q?q6fO8bZazWdZQs/4YLVI+FNito7N4Vahru70LIJeaZJWPA3Rz5WdUk85BBea?=
 =?us-ascii?Q?rtk+IB8cVjK6A2wMoOQzQ7a42BXqfsXNK6ozfe43w/FYrbwGtP6W7hrJG5PB?=
 =?us-ascii?Q?poUSza1WZ6vQPjwFp04SfGJiBOOCthZiV2Iuco2JTEj6FTEZSF3ufXpnOIQL?=
 =?us-ascii?Q?q4uf0d3yG/HGtcoK7aHCRl7OHbaN6Rr5lAlU5UaoQYKxHiWVNOzs8S4jDBF+?=
 =?us-ascii?Q?gejGRU0UDmCFHx+eGrQkJCvesu6tcG9g1+Z1QjDe6Ihmr6mT1oKgX9QJX0EB?=
 =?us-ascii?Q?l/YTNnvJxBatPC04MjGljIfC4h9MmjaAX4tKffhxAtBZHpy9TthrY9f9lj/i?=
 =?us-ascii?Q?WTyYfgPx6szDVBP/aZfyR1eFqBLfuhXA9LvbDjUwnsyPhCj7dcq1a2z6RcWp?=
 =?us-ascii?Q?Aq6+pFK6COEveysYR+WGiqJEarMlXIVoMj6QCOvWE72c34Py+MawbomkgqRg?=
 =?us-ascii?Q?c+WsjQ/1tkI6jLh8fPMK1tXqJMLm9ORsQyWH+HBh8VKkMeP3B9hMHjq8JOfq?=
 =?us-ascii?Q?iiYQURP6YocR8Y/EizPo8dtQ4FHH/re27uKTNfuk6FcUzQkG998GbtTT7JT5?=
 =?us-ascii?Q?+WIzWvnxOVJTrlC0Og3c/JqfrvXrHR+n0Gid0D+0xo+HLAuCldYWMBwpf8AK?=
 =?us-ascii?Q?tPnsDZDlgqlYwDudcxh9ORAaWU//1AipLtAom4/0+EdBUzQkhTpccZtjtrzm?=
 =?us-ascii?Q?Fu0dRgIizdZ6ZZT6LQZTrk+rJazuomXXF4c53IyJHgKFB5tpLTHuS0GliPRC?=
 =?us-ascii?Q?jLCWotHT0htTD79TBYkPPR3TLiUHfxt6f3k3ZBFlEsaNRB0OEJC+nJo0q6fD?=
 =?us-ascii?Q?Wy2R5nf2PISYdd6T0ESV/4Q9w0XfXp6x0gpbMVJCDhN8LTbFKVyNHz7fBTl1?=
 =?us-ascii?Q?Y2cP8Va3nxbLKwvpGczxAaiZJHyQkRozB9LcXWQYxKwpd7wSWkPQo3emOVYF?=
 =?us-ascii?Q?sU9damDf4xNBxlAz/z5DtOb2soJRa6I6ClhCu5eXSFpRw5p1xAzO8BnXk55l?=
 =?us-ascii?Q?FxkQmG5pyaKslmy+jXgy1Yt/gCR2F/nYR6YNuMTaY7IzJhDb9OiqV/nSINfB?=
 =?us-ascii?Q?uSQrC1IybPNvEjAxAVwCJ/wb6ktpazGMuWtxoydrF7eQtsesuwaNThrF+1tz?=
 =?us-ascii?Q?a8T6g+YJV1OBX0/aNYwI99d3r5ForxQ6EFWF2Mlep/xxPUEM8ySSQmwILs1A?=
 =?us-ascii?Q?kj1uvf2AMHB3YF+2nJ2uFcOWksolWnir+csIIt9m+Irt4r9esnhjj7ZZlkOt?=
 =?us-ascii?Q?ByWBwEYXFUqWXz3/NwusWcBBqOguAkJpGO8vDRetchVHbcyXqtFBxhsgt21+?=
 =?us-ascii?Q?OKE39KLueBrZHjiFNJJpUUAib0OjscvMaV8f010XNNFOJbtYfawNVfyddcdI?=
 =?us-ascii?Q?/Cz/RIW2Ss1T1k6hQiEXuycEIuTkGj2o+0VZyL0WiIwbFVF+Syf0YQVBKe7Q?=
 =?us-ascii?Q?LMRNidCyibexqc/KUY5hjVDH/yzp9sSofEqeXaUmBacmdeph8H5fqw4J/xnI?=
 =?us-ascii?Q?hPlzdRcD58agpTWgz/nTaRgOpmsvZXPf5ZjTD+6K?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82740bf-04b8-47bf-6811-08da5f2a6611
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6741.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 08:34:53.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD8rqm+L2bSSzUSpD+lQL8fo3P5abQYL0sDB1n7fV2wiMTU2/pA9Uf+saqoZrthDUKkRWx6Lu196x77x6B8PnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB PD controllers which consisting of a microcontroller (acting as the TCPM)
and a port controller (TCPC) - may require that the driver for the PD
controller accesses directly also the on-chip port controller in some cases.

Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Xin Ji <xji@analogixsemi.com>

---
V9 -> V10: Rebase on the latest code
V8 -> V9 : Add more commit message
V7 -> V8 : Fix Guanter's comment, remove unnecessary explain

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
 drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
 drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
 {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
 5 files changed, 5 insertions(+), 7 deletions(-)
 rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f33e08eb7670..812784702d53 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -13,11 +13,10 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define	PD_RETRY_COUNT_DEFAULT			3
 #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
 #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index df2505570f07..4b6705f3d7b7 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -11,11 +11,10 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define PD_ACTIVITY_TIMEOUT_MS				10000
 
 #define TCPC_VENDOR_ALERT				0x80
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 8a952eaf9016..1b7c31278ebb 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -11,10 +11,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 
-#include "tcpci.h"
-
 #define MT6360_REG_PHYCTRL1	0x80
 #define MT6360_REG_PHYCTRL3	0x82
 #define MT6360_REG_PHYCTRL7	0x86
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..3291ca4948da 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -10,9 +10,9 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
-#include "tcpci.h"
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
similarity index 99%
rename from drivers/usb/typec/tcpm/tcpci.h
rename to include/linux/usb/tcpci.h
index b2edd45f13c6..20c0bedb8ec8 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -9,6 +9,7 @@
 #define __LINUX_USB_TCPCI_H
 
 #include <linux/usb/typec.h>
+#include <linux/usb/tcpm.h>
 
 #define TCPC_VENDOR_ID			0x0
 #define TCPC_PRODUCT_ID			0x2
-- 
2.25.1

