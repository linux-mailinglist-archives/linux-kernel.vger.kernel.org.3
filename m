Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601655C38A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiF1EtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiF1EtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:49:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB3DF27;
        Mon, 27 Jun 2022 21:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdQVCQS9dh9meecX0FRGNAVQ1K5YE4dVsmA+UtdYkl4uMqpWlJMad013qr/PoJRbjyX0GYRaPuvYjKp8JgcVECotcPWxwl3QR9/HDT93EorTfOeciyL5yf1107+1irCTdTzmlCSiZMAlAE6+ivLwR7CWZcwu4G1CPlt4UfJ5oe0s53F2b27+tBqH5xoT7JzkGwc5Zj046jGmPUNP2SFLzV7PmX0NIIZg6lS/lvUJLwMQ/Hwq5lLasOwKZGfkZQFvFEkYQD5P7uTzzrLTyzXCe/6zika/gyk412LKEUCG2Q3/E+6rHYDNECh7FdygBhd1IyuZdlkGOu0sYsdUrJXlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGfzsoXJkyPafAfFD9ICTdIP4sAg+iiYn910Rf8B5o8=;
 b=WfxrnTLK7z1rHLA2hpc17kLsEybK3D4E/ETVVeXy83zWQue100LdmMfXCiO7Yuuv+NkmsIh+U38sBZyOnZ2keXj/kop+1m4ISYUvGdvcqqsb1URAbU1ShVBLOP758yPbHckyiFq3/gdOScSYfgXJsUL2WNNnR4ZDSqzRtgktGeUvBOFxx4KUPMhQKHbxrbJycwlJeqKt5i6vfJYH+sWk7z4Znj9/KVMzlrdmaxPhq1VIJFLvUzR5dhA3XyekFYlXWywsmoh0eVTf04oEeJrhjJmUidibGDefVqp8yO16jrbVLUZ/EPXOi89vTRBzX1DAYNSFuAtLh2Eh6dGdW9d2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGfzsoXJkyPafAfFD9ICTdIP4sAg+iiYn910Rf8B5o8=;
 b=iV0s9vsMopVnw0oWoWDQh7DhPmO0tG7w79+kDUf/G5L1h9Le9Z6/Bo+vsHbIfeeGAiUdo1StjJ4G7++IQoY7aslbOfcsfrSFEenbGdxtEG1K2Yo//fk3nY6gXlNq3tJOzjBBzwI11SmDqn74DyU4wOCxl48VPeIUEQbSlk6NAS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB5724.namprd04.prod.outlook.com (2603:10b6:5:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 04:48:59 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 04:48:59 +0000
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
Subject: [PATCH v12 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Tue, 28 Jun 2022 12:48:40 +0800
Message-Id: <20220628044843.2257885-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:f6::32) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 298737b4-3037-4f02-cea5-08da58c183c4
X-MS-TrafficTypeDiagnostic: DM6PR04MB5724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhyorkbkDmyUzBQJcFTyEYxEwZCJ8xCWMszFVUFTOQ6Z4zErzRo/iVIeli3H1r+x+gRVbeQ7UMaPN3ruwB0U/Vnz/r1fxvib5QgGpoqoSVM7ZgtizPwAtgwYozUDt1/BUHwfKLO6qePpyKQozFOXAe/a7LQsMCYUk6gL8bAJhy+Lkb1e8kDwANum3ehygSHRENrpUepPNOfQUC7ybzYD+IuwW66dX9UkaSgCKI/XL1IPMzDC2vKGQtbjyPn1qUQu5/fTnvTuTFP2+wuKzu7dPompvJyHoceF4S3ML5J0ghGCtoOrzhCQV+e8ldyJB/2KmU1YwgDP1kWh5uOZaKNkR/kLbabUDdTt0ULo6NPTEjh6/ZzUvFKDNjR0KI/3bLLZcCdUIomBze6mTgab1/c8ULnuhgnpBO0LlsN7RxCLGKPBi/XWewF1xl+sEkYl9tZJnBYNv8qVczTKBhUtXPHIaHr1LTQ2Y+7mfoy3JRiElXcsykZQcZjTehPG4PZ4kQcOrzBFK2MDmo2rSJToemC6AgR8dNy6/jdWlXvloV5Lq+t/X7PavuYb48vgiCmY1iDsg0Qt4ydkocUfeCy3fr8ysU242kfDtd7HPkrG1nJpTlbIsYgKJ0CUbfkUoSngE2pxTbRpxDg90HKVoZHJltzVX0odcH6mEaHlM9EdyJ5u+v9Jx7tRheJxzhlVCtvg/nKBGfNvUE2//omsF96WlVzMTOV2VV+cp5qCX+I7n07CVqx/0xZmLW2LAYe7Ekouj9TUI30VTuzfb/5RUh/Yijzx3AYCz6EDvRR/44EWhEUYerI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39840400004)(376002)(346002)(6512007)(83380400001)(66556008)(52116002)(66946007)(316002)(66476007)(110136005)(8676002)(4326008)(26005)(6486002)(5660300002)(55236004)(38350700002)(8936002)(86362001)(2616005)(6506007)(38100700002)(2906002)(1076003)(6666004)(186003)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Nax4CdBl4ZIBfNe8ApUeplhFROE0MegjU724V06EiVdf6ga9defzWyKpPi1?=
 =?us-ascii?Q?+EvuWii6wssykOEbx/yvHMfAt7UucoqXPhdeuLywieFRI0KQi9D9M7RX2wt7?=
 =?us-ascii?Q?/wL9HGu8IHCuhTm7D+FRgHbkezipZ+7vHn1p71ZZLed0p5/UhQjE5NdPspZT?=
 =?us-ascii?Q?Njab3dNienWJY2wvbz40ez4+TCRwzf2ChdGELTMK0KsTG69vIs/HYxFJmBgw?=
 =?us-ascii?Q?HqcVAGvG6pKctiJK5va++DoYQycm5sbYOzoqv3E1pJ4Vko8O1gSc7xKWySjC?=
 =?us-ascii?Q?wIWgqWdXi6+jzY5nRhiaV1/oH1684+PbkuOc7dKcXDu0borrXcNpAXZjZ/sa?=
 =?us-ascii?Q?CteyPBhEdFnPvGbkFcWVmedhHOnZee0tn/wCWpuTEmaWZSRdYwBEgBnNUUeC?=
 =?us-ascii?Q?R544UojJGa4ENd0u29WyqG/+FWjxLQb7Q/cOrqisnBCChGlEGD3kVbR60fvf?=
 =?us-ascii?Q?BuyGFwosriRDJuYsTep3E6LeROoxq41pMTT4Xvi6OlZkxT564T1eYh5HUL3S?=
 =?us-ascii?Q?qWyJ7SM054nt1vAT0+zZ5PphA0GhTBBErxT2aag3pkvJytt2EjEUgZ/SoaX5?=
 =?us-ascii?Q?mLDJYgK1F7zM6Fgrz1x4w6QM1l26P0IQ7KpXyJRzEFPr/L5lkWENljPxhZYp?=
 =?us-ascii?Q?KgX38L+mrZfGkittJ8lpfstDbvD0DIL9MJ2JSkAJlJwozs1l5U9LR5XwJKLV?=
 =?us-ascii?Q?0K91K+i583ul/gknhurb+M4bHZty4RCxEV4bKY0lxgmbCaxB6gbtVEQeb7/M?=
 =?us-ascii?Q?ID+eIMVazf5sgBvL9BvZjLReUvk3brLzqRPVeRH5HcqPOHKDkQuLrcoBcI+p?=
 =?us-ascii?Q?5HL6aiK97DAJEs9ZdbGuG5HAiGq6nj+nwK1ki7bORvpP+aCd+GH7lrQ03+OO?=
 =?us-ascii?Q?u5HgErxL6vaGPdvdG76iRLI6NMyBtooINrMxtudRWAf9lD60JukQLsOrVQDA?=
 =?us-ascii?Q?zgA72s7A9Tatw6wu2zPl1XNyH+ijts5kZmZUuVi9RjYfGZ5G5RURMi+Hgkg2?=
 =?us-ascii?Q?wVY7xWLjyy6c5CBjIXOrPKtGfuch9nRiliYqgnFzipVWVaStr4SJFj2PbbvE?=
 =?us-ascii?Q?m4BO+Z0zdd95IM8KckRdMRv6WWH0v85iF/XO7oHxUPIlNTyr9LQLRV01RgT4?=
 =?us-ascii?Q?e5duWEn+fgNHs6riTmQ/upK6kDhMdSFm3YE4F9r16Rix4xp8l4tOy7CmICDJ?=
 =?us-ascii?Q?Ierk0lxgKNAaoskjEQIzfULP8c/SlmPrwm+CnfoMxA92MkqwGgv6o2CmxlYz?=
 =?us-ascii?Q?fEXQwR8illTZKC3bCeZfVu2yil7kqwBx/Um19ohhDlgNZlvdLkhr012WL8dh?=
 =?us-ascii?Q?Jg8zq43lFUxsihVKGhOJ9bgRC81//x5a0SuIpIJurFtIqnl3NE3BrQ2792Cj?=
 =?us-ascii?Q?wZ9YUO+AZnYS4BXXDcSwyauOdoAMqk4HWxY7xWMM8plglH9IohwZsE3l1Ynj?=
 =?us-ascii?Q?Cy57M9H530YHdkoMN9hQTHHCXp3IMJG9cLrOn/aDUtKMisMQLc7cHT4ky/wb?=
 =?us-ascii?Q?FzycnYmkiPf4tH225Ct/5rf/OrQYxUJltp0e4XgE8qOqNw7Lg5QIBy8IspbA?=
 =?us-ascii?Q?KzG2sgtnr/lxU2BKVHufBrVuqZ6vIof3pF3dMR7K?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298737b4-3037-4f02-cea5-08da58c183c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 04:48:59.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtdDC1rA/wkfocJKagzU46A199af+hxVC+k7P+72jFnyTzNwnsXZyzdGwrh2/zIfSVDEr99jzawtxcmtn1umhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5724
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

