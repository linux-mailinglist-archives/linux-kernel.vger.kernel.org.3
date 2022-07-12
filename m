Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0757154B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGLJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiGLJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:05:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2118.outbound.protection.outlook.com [40.107.92.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F0532B8D;
        Tue, 12 Jul 2022 02:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPY5N8hI9l3yNCvX1KZ7jdz5ZoeimYHwbSBfevqp+jB3dxZqaNzofq3Bib1S2cslLEjXqeXQjIacQvMsCzR8IcnNzHXi3fh1yHkkQLlNAVsDH2HrLsMm1wrUs2smS88pF2dudb16U18gNvVIq8Z2iBB4qVy6CgVoQOh9I2emirRGssWEfXHwA6AH+GKDJPoclo1hC8qBa4qBPB5Zagi82VL4f620/zbmG8dnBf49InIhr4MVkEtP3z7CdP5PyhpOB9GuDviaosGPeRDLIJU7wIdIVtCFMSs+jxoL20QGw/5JOAoqHS/zCu+D6/ZLzFUDwslCpCSL2ajjIEUyNWwMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OrNlacPEv/vCIDmcNrp3k4RuoYFPiHnnnIw4QQW+2U=;
 b=kLUGRRHUt5jaIc8lULn4sPw3yYmEqYw6GdZeeE4ImAujLeBEqx7MOM2j522HkRi9m7I5QR03uodp5JDHZHm7WXvOXXEl/zZCp/EydkQeXEU/gLCrwqMHs7F4UpFdC8+KdQeIuqxgk5QfiZyi5ZW9uMauy3Pw1zkPLoChIczkPJP6gKe1FfhLOT67E1cnSpgjKA9wEwwodFuJYVz+dJhIvGJHmJwp5yGacuSkcn7vnntMoPoEdppVdZo/FS2knYHAcuA7MiyZ2EXyyOqZu1OO2cDLK7H5gAzrQWj4LKiDN+Z1cUNajTlQ2mXVwtkYpeLHr0Mcnke9pBGYkXmryfyQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OrNlacPEv/vCIDmcNrp3k4RuoYFPiHnnnIw4QQW+2U=;
 b=T0iQ+hDnGtpveLE5XQfrxDbgMStAeZ8j0yAi11EP+HQGKIaxXX40mpDX2CPz/ZhexOO9h8E8iNEcQN9AA7wRSh3D33gWKlLH3xCbdw6VPuXWC6HqQHlPor1o5qBJoBpiVH5hAELg1/GNMgxr7hC3cGNMmzX9VGd1Sw02C5iqjL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN6PR04MB0658.namprd04.prod.outlook.com (2603:10b6:404:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 09:05:45 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:05:45 +0000
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
Subject: [PATCH v16 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Tue, 12 Jul 2022 17:05:31 +0800
Message-Id: <20220712090534.2783494-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83f6e4d4-c00e-44b8-944e-08da63e5b462
X-MS-TrafficTypeDiagnostic: BN6PR04MB0658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8YIimGcKWnBuywol47NbMN0Yztj0IkxjwNZx9CpJkS3oJfGBvHU6+9N6F4uuB+1LBVjPwnMKKWhmBSNFckLhqzQQ6y8ZCgRnmhR0YNYPtyRLFVEFhOHkoNM0ZotQS3AUKI+KiSLX5Va9JT6FMkho0QlZ8Ah6+oC36cwknK40PWomOh5Qd/FmQFX0e0ok+n0NXzxWGeICiLD0b+4uOtXLWw9FlzVq8SvE5pfu/qjoyUEQx65sdQblmf8Y4S/XttnwnRMs8gk+IW/GdNKMbZZ1DHBRbHV454kOt8BbWRjzdM57gXsG7FQlkl7z0/fv6ivo8RWsLTgs3WneagOYq3yhSlc3lpT1l8Nw7Yu7v5PuS5f/Gu0azOuvc7iMJVbcBkljBJFk1TIGol4FYLdnLWaRaWHTwPNvX003suXf9/hEgVAB5Sh5HtViQ0wZMTuQ7CAUOstBK6SF38dRacC3MM+/ypWsKHqQgLTkNj4i6NZ6OI0xKuxfOTzZvEjM1k7rGrbcomhMMaWydcOclgc1zcRhw/kAes47fxzuW7c+dLUTNfVW/vglfNASvdjYtDeGtFO6cFv2qSK4kitN+2JzZnCSDq5NA6oYotDoRokB+/tFAA7q0LMPFcQqOgEYvZxpnA3wwyKLv4s1RHWLr3KOifKLxdWmAo90uQ3rLWrMVWC2r8K6hShrfITxvqXvta4Eu7lp+hv5F49Uej4uID3SevmANjX2W6kdkStl5qMtyIkatprHBuADoRZJaB0sQd/zSPQLO6JLz3ajkhk6zGVT/4b5ZBlb8KFN6+ZiszirouSVBzNZm4cTPmzzy0ku5Z5nIwk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39840400004)(376002)(396003)(136003)(366004)(4326008)(66476007)(66556008)(38350700002)(8676002)(6506007)(66946007)(186003)(8936002)(83380400001)(52116002)(6666004)(26005)(41300700001)(6512007)(55236004)(6486002)(38100700002)(316002)(2616005)(1076003)(478600001)(110136005)(2906002)(86362001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OP6XZ2kVhB7EeB7wBDbMmTObkVAFx+1rWBA/8aegjJtEh6PmOD7MGPiy5/lD?=
 =?us-ascii?Q?gO+EE9wYrVvJz6rtBsnHFDAbXpuo+Lm6jmyII8bDuSZ3gqvBRBZhy6me1Rry?=
 =?us-ascii?Q?VGEGFB+TthljRQ6Cdt2zdN+K19W5jPTe841HWgq3uSGnp2y1X8albYDKirdv?=
 =?us-ascii?Q?fzTfqLpZrPN65w2HRC3oQF3YSTN0Lj0FPDDngjOfA11tODiTUU9rfFznucaR?=
 =?us-ascii?Q?NwsCJLmOasyrpNi+vF3cs3F/CpI7kkLOBJLkEOtIlKwC+cHb3QNZVjNfOkNn?=
 =?us-ascii?Q?SaGIrKCzW+918XBnKBsnFE6L78sVHaLAMoovrX8rkVBTihRSitEvp0I1Ozlp?=
 =?us-ascii?Q?NGMwHQ3pqKRN6Ub8anqJuYLE4p5D36nvOd+VSyVJUZpuSpNScfdYos620huv?=
 =?us-ascii?Q?+I+v7lHPYYj4OT76oTF9rmEPDdUI+BYQs4OeMrvBvUkW+9S2At/HISXsisSo?=
 =?us-ascii?Q?XO9Bk9VQgBoPCV4Abjg6wBRfssuxRSPrbRIsQ3lw+1HsCvBnB5yByGl2Yti2?=
 =?us-ascii?Q?ot+vQht1/Imx9NWmiHC7oHRDhTK9OQHAWICPcevga9OMkhyFhW0rPpJZtNBD?=
 =?us-ascii?Q?WZp4pfSxDA1E3fntNdrrGNHA/H30q7xqdC62RN1/0pGM7WES2xgperRNtgXH?=
 =?us-ascii?Q?X2DtMQ47ff2onkPFswy84JdgvKJOJcX+zAQdng8i2qsd9+5WrwfIua+ADV1o?=
 =?us-ascii?Q?eA6pF2CzDQgBAPr++A4GwkcODL/g8jzxPytbvYGwA3wqZjZziFVudF1j3CYB?=
 =?us-ascii?Q?aY6fUSQGgM2kU/TBQTpFU42ZnAAyzoWgMOVO6d5LK9TfIeCR5Q7jW31DHSQ0?=
 =?us-ascii?Q?GsQuGdwG9yv6c6VcZzVGt4bJf4+cOScPv4M5p5pYYJfqPCGw1tINp4kqJggH?=
 =?us-ascii?Q?T3HI2EJVZNcaJumqMhUzJKjnf3vd2ZwXpBtPOmL1NTWGO9WNYTUHy6kHcZyn?=
 =?us-ascii?Q?/U7NJU8p59zzIr5Cj828ipjmPl4sQrCxE+BQ1KWmN4oyr7IYJ4ScycGzP0pp?=
 =?us-ascii?Q?HCjAyUdr+ngenj0sNZTiMHm8KfRvX3NSQgHt8YYbliPo61iw9ngDdjiIa6lo?=
 =?us-ascii?Q?Pj4N4O+yy1J5syJzpmUHA/MlGB2QgxkIE4xveAHSILJqB8dRRPYoifw61ojs?=
 =?us-ascii?Q?w3GBeeSDrHFi+bwn6WI6Zq0Hrz8KtVEp+Nz9mekJZIwaCU7ngJH2XuFpk6nz?=
 =?us-ascii?Q?hikjqLQGf2vT7xx0Hba0TkUbkhGoMpSioajcLHOps+DGEkcnRrM2Qg6dCVJs?=
 =?us-ascii?Q?2ohPTfFxyDW1BkEzpo2fBy4fTDHhvutw2dAR67qj8MX2GzU5GlzrTAxwXNu7?=
 =?us-ascii?Q?uCVuFHTn96iJen/UZ2VatIbs41DV7DyFrY3f5tDnXEY4wgah/t+s7mlEvHAr?=
 =?us-ascii?Q?2JNLMqZHDEwn147pT6PouuZZZWpkCHfftyb0YC+Kf1b771I9Td4l78s89ZVQ?=
 =?us-ascii?Q?lkNfarexEPq/GkiSow+XDAzgyL75XV+QXk3p0Q0E1/BvZy398IN5Q/+AZYBA?=
 =?us-ascii?Q?qBlTVqxKI+8V41s7rz4xdGmeshYGGcp/blI2dWD/CYAzQT97kLYZrUaw6XmZ?=
 =?us-ascii?Q?fs2lXGpSHWkuwdINPkxABQ1vTKkx65MxE7gxUfM+?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f6e4d4-c00e-44b8-944e-08da63e5b462
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:05:45.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHTyhcBRi+OE/iuk2ZZY8C6//SFG28VeQHgcvAZrjkfZehnReqDWmAppsyL/95p3rAA+pBmouD09QoqQ4oiqTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0658
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

