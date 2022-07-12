Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F28571255
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiGLGla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:41:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC04528A5;
        Mon, 11 Jul 2022 23:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPjovSZpcyqoh7Kql6qTrLWS753Om8Ye7CJ6VQWFlgBg5prVCp143S2tOQDn6owfkOtciSbhyO+3w1LDiInXMZP7sQPR0QPzRT06nEK5lkceVfpK8H46lUi5UmZW/1D+yjhXv6tWD3LokA+MagODXFwlQOkSkn5a3jc/upJfGwyeNyr5lRCBQIF0GzF/3Ft6NoinRVtBrTX79OGf402O09/WjN5tgA6OCT4Hn8I1CeYx4wzpC87HLlQS55q7BJaBLdJE2swivc6QGTFXgFxD/49sosp+IEAJkFKhZUjVcHNR1NNeHgxzFVFenUx5tJJkHHx/G6hUSL18Oh29yoITkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OrNlacPEv/vCIDmcNrp3k4RuoYFPiHnnnIw4QQW+2U=;
 b=Qu8Nqfesxh7ESkgW3qIG2jgJReyr6Dg3N4nRBBciLUE4ylFcvs0AFAKMu2F47b87O5JvzXSBS0Q7hIttaphFst1pRP6mdKVJVV372oPs34h+Fr/Ui/MQDPL6y7XC24v5S/N916NZnZ+BnpCBsfSMt6c97Oa7JnanlR2cRhVewXTDh5Ztt8pU74lzIhBHId2goDQf6goLjghrwUvNuCzf9y0bBE3We4JF0uDepNI5qi/QP+dqOTUoWPek7VjQARrv1ahr9bBmRM390LlhA4J1UK/quguD6AsMhBiC3kQEUXqBkQGgo0MENeBqXJz1LDazsmlm8YclLgPWXVFkNCaZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OrNlacPEv/vCIDmcNrp3k4RuoYFPiHnnnIw4QQW+2U=;
 b=2wVosbO9Ntcd+quU9mq6LWkxuejzVp+04mGnH0CvkA8rKy408oR/MjIGrfPuNAshGoa1ymy08POEZ+yL+Zg4Xn6vUgd5lhkKu49MgobJ/fVMdLc2hWxeLi+3sR1BU8X5AQ+gvBN2trwaC31bDlBIyDBzm2RhNEZjTdb7wYZaEPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CH2PR04MB7095.namprd04.prod.outlook.com (2603:10b6:610:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:41:23 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:41:23 +0000
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
Subject: [PATCH v15 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Tue, 12 Jul 2022 14:41:09 +0800
Message-Id: <20220712064111.2782861-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::9) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d2509b-e1c2-41e7-d200-08da63d1897d
X-MS-TrafficTypeDiagnostic: CH2PR04MB7095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoeXBhfgnHqBf1vaPW5wTxJPJuVw+gceCZFByD70R8kPr1L5/Tg5kbKjHbDKKET3VnhCOlqOA+pvqdxy5KM3yZdliEsjPP129nYFC0SXzJVHv+2ylDPTz80DIZyA4oG8ZpLH9XT8tzCeqJ3627r3mlrv72rDb+kpt+n60TIv+LNVSX5qXD/dGMU0c1uWUy8BT69zKkJBJmHQD3RE9GEJNks834DqTcSvBqgzB9twvUvT8Nt03RELb3eG0bCnMstd52fgoEBp0XzgNtkgM3ceQQHsuhzPlepyAW/zmWeRtbrw34KbGxgmOSuwaUZd1BvX6af7tVwgJYkYRXHOEY+1/B6yj1yXabrZSb2eFHQnZPv59idG+yoGBxUn4J9+OmMPlMPzeVISIoueL69UaoJC6ujjM3OGahYwxm/NhlKpC1LoTmMLmmHcRZp6ArA+lgAaxuU3A1JFC5BWS9GJp6FIHf9VST1Me049FIB3Vzd9YJKOSf4+gD85to/abOw4D+3hE3U919o0FbpQgYbrgetwmgtEkj2ZzU9OX4zAu7kOSoKJ8Jcwm4AVrxWwsS9tYsb4wRSEQtDWYsLL2tIGHh1sJuZtlRQd9xAE7M3CwhsQwWaA4D/4fYyUdzI0Qe/H6FxAik87zvNQ9eXGvAMsaHdg5JVbDwVnLqMFCr7Zz+Ik7OpYKIadw/7eoAPNutoiJJUYl9/S1Y0I1P+QEqDFSYbdD2XSg7FNqqRoTxwS+hnxGG2mekwORNRjpGeKqZ04OIje/EPN78QLisWTrQzErLetYlynJI/MtJ2Kx07n81RqBw/QTZ/cY5I1CzGX5pUK0dLk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39850400004)(396003)(376002)(136003)(186003)(1076003)(6512007)(52116002)(55236004)(2616005)(83380400001)(2906002)(36756003)(6666004)(38100700002)(38350700002)(6506007)(110136005)(478600001)(8936002)(5660300002)(4326008)(6486002)(8676002)(26005)(66556008)(66946007)(66476007)(41300700001)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSFqrT/uuKGt/3DambHug7TNnjUBKJ00lR0r3hL19e5sjHxSQ9V6ArKQaJIM?=
 =?us-ascii?Q?sukF6EYcSEalA3aunMDkD81IwhDOmu5ZCNwaOQP9AI2WROgVOUm2DVU9akjO?=
 =?us-ascii?Q?tRP7EOP3T4yUZpQOXBLHk1Bpp9TE/AGfFImHEegJW+wO5iYA7L0pmd/xHkKM?=
 =?us-ascii?Q?BHrqWUG//mY/Ck2i4qcSPoIyFDYqKg2UpbWKGOzwyv2tvRYGg+4aG4ZMtxyE?=
 =?us-ascii?Q?HhgNxSGn1IaqWQ8zhIQQd/oG1cubNSvrbMrkjU6fbTH/TffeKjWByASUzWC5?=
 =?us-ascii?Q?ZpnlJTRRwKfge+mesWV2oIbyH3yBujFGJ2QUCl9hdaCy4WHNdq21g3lqpvwY?=
 =?us-ascii?Q?gMuTAucdxRQcON1FJz45MngtitcIPdyAukDxA7X8xRo947FMM4KK1DB3O3mc?=
 =?us-ascii?Q?d7qw5dLL3tE+jIGwwYNPYVOsUV10dpgKV1FG1TqHGJJP/Zjra7BeRcZsNF2S?=
 =?us-ascii?Q?t+c9YHSJ5RGsHv5BhL3gwKVsu5GGEGTmVWjQviKo/YhK5XBn/aR1n6Ihd4hW?=
 =?us-ascii?Q?3FdppO8qGHJ0jK03Ysor67IIk+dSMX0rLPKWaBuXwtaLuVdrgcmBmj4fjmGc?=
 =?us-ascii?Q?CWXoJW/5Eb1SWALHJMDAHJZVA1d5Kpokz3SH6aiuO8zMGgeS4XaySRZonvLD?=
 =?us-ascii?Q?45+iTzMnYc4bBLtAbEkApHXt0md1AASbvtNdm28AU5oFhrm2MPHPktPVATyz?=
 =?us-ascii?Q?nD7502zyBLHxXswu1vTyZ+tS3EHVhvrC5aAlExTuzK0OHqrs/QGXnm/QVIo/?=
 =?us-ascii?Q?rwUjpMcOCHzZ9BijBP4sEYxY0Z5Ud7dgI8zvlL2u9ZNov12nT8s+5OM/P1s/?=
 =?us-ascii?Q?0608l11LFxfiHVQDVVKw4aeRvZ1HeI2wRPKSG0h9KBeeafwXQ2wLht1gXGZm?=
 =?us-ascii?Q?2jn7kVQWj7UmRanxTGpYV99/H7Ip6b+oJmzeDy7p8T+nlXZDZwOptyJsdoXc?=
 =?us-ascii?Q?HopykeaEjKUy/+bE1D+0St7Qxq00gC2YfX5++PX1l98SIj17SvsS5Lisovgm?=
 =?us-ascii?Q?JHtKmxXnctwW0OSTQ9sruq77rZyhHoVPDkzRrI1vOgVnR7hfJfeapvJLh9YH?=
 =?us-ascii?Q?gnXUmKAP9p2p5FDY9GL7CIB8SAR4Mem/oPZXY28Kf8hREb30Y+6onbE68vuj?=
 =?us-ascii?Q?mt7u5nsZAHoT1CzTyzpGUlnJXVpigJLa4geTyNwSE8xtQoeOrROTSjps+4hn?=
 =?us-ascii?Q?1WWbRfKt3UtgDXPGsSqXSn33642rrr1/tU+t73rI51W1Zln3vsWZGIxjj+4z?=
 =?us-ascii?Q?kpeoPkv/I9JwnPOG/6tsEUhhUOh+wKC84mKT+ZPY5cQ+TgwINgpj80pH6a/E?=
 =?us-ascii?Q?1bBvaDdvYynj8hw88Hu8rK7p3o32So4XYyKuDHcfnQpqohHlDIxMEQNk9hjP?=
 =?us-ascii?Q?k/Vcew/LRy9WnjWEmDQSiWEqXabjFsXoEKb989EBTcRPkmtFpjzcFEJpUfBx?=
 =?us-ascii?Q?bR8tsU8horzHFR3Oe5J9tLrl11wvFW/qRz5yuxxph2BRQuPG7jFRtdVMVJFF?=
 =?us-ascii?Q?WKyn7fV53ReKFgXZNh+niwHXeAMNtmhNhbltHwy+Amz8SXg9WJjK3UafM+7S?=
 =?us-ascii?Q?qA0nU9hjxr5eU7m5CtVUn0uQK4putnx7Eu+8Zz1B?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d2509b-e1c2-41e7-d200-08da63d1897d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:41:23.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct3KtlVpKsmh6qNuT/42Datrznf+wJuagSFe8PVjq1xtYn1eVX5mWkFY+426VaKOvvX5n/MkX1xKDLnF43rFdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7095
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Xin Ji <xji@analogixsemi.com>

---
V9 -> V10: Rebase on the latest code
V8 -> V9 : Add more commit message
V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
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

