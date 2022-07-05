Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6845662D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiGEFhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGEFhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:37:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93012D2C;
        Mon,  4 Jul 2022 22:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqkfItIc/UnnX7KIDhssIb/j3zAY+lqHNCTHpAHmxmDnkYT+kKt+DdG6rWJSqI2Murqe2dcfvQ9+SkMU7ULk3I9/Cl8MaMuOy0J2gh0LDQNOHaJ+M2rZO9haSsw0hMl3PFk2KDZTxD5gV3xxKMlWkOP2xnf7heU9MkPJMSXqrOB9lY+uOMt8HAErBkg8Nz19j/bypfcmI84CN8sO1+9qeEapwONBdifTiRrbYTqW8pzxqE6WPhoCUBC9aJTKtj4rfTHwOhNqJw2qoueLy2F5uk5+lwQ8Njuwi5ObRcBHHrhc+zUT3i4xE4e92KWaZOtPKGGkAfMG4vUnBkiBRYRo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGfzsoXJkyPafAfFD9ICTdIP4sAg+iiYn910Rf8B5o8=;
 b=eUd1echb9B0wht20Zz4b3Jt30Rodo6wLh2jweRe6FeZqKG03Ms4k6nVNFYKnRzx1Z14eOV2HVliu3ZhoDnwdrUkviCI/8t/4Vc0pALK1tum6d0oCTauXipT0owNMKzsTFyuxKVr2pGhaJZELpYTELWWl0BM/dNUq/Ybw27+SRv2BCEDyXb8KWFqtcEqFMysPtdKj9XKERrY8L25agLvdl3SGyi8l8pcWDPj0DqCdzrS+qmW7iDluGTDOneq+MmdFxdO+nkhMTPCPfCpdGTRtFY/08tS7oMbRXzo41smrTdK9zbeV13twqduyNtUEJdUrAsbf7JWAvCZM752VTcq1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGfzsoXJkyPafAfFD9ICTdIP4sAg+iiYn910Rf8B5o8=;
 b=KZtYtAXXYhaiDw/hf2Sg4NoHhITrR8L+jJfc4DkDb8+l1kfw5qUf5ZjrHl4RzVeKsD496A6c06Ofv8O8/pbU4FTe1+sYOYxZNJwI84/1p3Zq0k4ucmdIYdC1rkXhAPGFbpD1RYft7qyVrgTR4dLg1GIYV4s8DTWuKy8f4B0Ud50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB0651.namprd04.prod.outlook.com (2603:10b6:3:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Tue, 5 Jul
 2022 05:37:13 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 05:37:12 +0000
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
Subject: [PATCH v13 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Tue,  5 Jul 2022 13:36:54 +0800
Message-Id: <20220705053657.2340274-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:404:42::24) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27b98b18-9820-4bfa-bd35-08da5e486962
X-MS-TrafficTypeDiagnostic: DM5PR04MB0651:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gRQUEvINoDOSAZnLm5n5PCRNoCoXevlDD5nSEJWntjDXUF8mhQ6B3gZKc2S/c1EUkxTX7btqf2I9EJc0WCbmb76SvAeCHzgL8Zz3Hq0i/47TFdrrd8R7GE6AJqUjp5gEn6OM6vVfDEzYp4aJCkGt3Xp5lpSwmi/NMLLYlnsYTcQ9lM71gZHaHl5HgV2IKw+hiYrBRmNsx9mKX+oHq3sqQjRnulUggL2spfxHV9vL1lO8/FuO15BIPHNKJjdSkqCM3+mRd3cNNSsOIAAWq0PnShZGQcWK66PWwhsgpfsGYpGaCgym1ww3Ri65wyuZoJED9wnfHHqpGyODePiPsbp72glN07YS2JLeUQJ9vkWUJkSIVurK3qfTc33Nafn9FDLzSKRpQc0ek1lUzbAKBwdXwCKAQ3a8xU31icst1tFZ7UWP912+ELbJnLi/IoFoL46c3J2SUcwkWEJxOR2JbhG94S8pmrD+pNkmOIXWKtcLyBECUwZTICIiUd4SFGkmPAm3r14AKkTIPB7LrQFQnkjD+vxh7+JKqh37GsRm8scgB4pXFvFrIX5ZJNHU4kjI2Me3x9jn+JHiO4dYqoKCrFgRhMIA+OXYABcbxzIlmJQA3UAVZ7sgETl1rekR2fvCzwpy/TrHbV67vryulh7J9MReNT0R3S7caTs6Jl0hn0OmjuLk3WOnqmnf5Tpf1DpCSyMErPiNQILVIRv10DIcG/5ni+vnQv9V65fZlGvO7aNJfxzcqqBnDmAXkO4x/6BsOm02uLmY4k8Bq3qEM019ZojiByC8wAVJqgItYaUyddGBcdOixN2RqxyTxzzdxvHcIZw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(366004)(346002)(39840400004)(6666004)(41300700001)(2616005)(1076003)(6512007)(38100700002)(38350700002)(110136005)(36756003)(316002)(52116002)(55236004)(6506007)(2906002)(8936002)(66946007)(66556008)(66476007)(8676002)(86362001)(478600001)(4326008)(186003)(83380400001)(26005)(6486002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09ZReE8HjnproFbGfOEOiTJAZ9FiZ87DCQhJl92CyVM2jhAyLD+VISPpCvbg?=
 =?us-ascii?Q?rzDoBaE90baRk0ALYPv3lGXmD9nOpGmCDKiPuw0Ri5NjtKf67UEC9cdcC9gW?=
 =?us-ascii?Q?VQNVHT58UnfssDSDHNx3j99LNa+hTiSTWVlcwLr9NA0idVQyUGCkllX43IAx?=
 =?us-ascii?Q?0nbfYUH9u1r4eo6duzj5lcdPJJ5pXxhIE0IOSmk50S6Yg8mZwe638sUzl0U/?=
 =?us-ascii?Q?v/uClhPbv6TiYpiomSnKLpmIkGGXWhgbGLYMgawcA2IST54feE7AaDmOxQiX?=
 =?us-ascii?Q?RyeN0n4Mr8hOelPYZXUtHH8Wb+k3wkMsF+FqPxi6VGFIn3zxOqd02ITuFpuc?=
 =?us-ascii?Q?snEk65vH2Ok4U/fuZxKR9V7PZZ5/Jo9EdY+E21t+jZJrk3CPIGV9r8p8V2Ko?=
 =?us-ascii?Q?+d9zynD3TbMnLm0OQdaQrEHFvSZej6aWSBdTzcW0spHEU3mQfwOIguN0Dgtx?=
 =?us-ascii?Q?2pNU9frSeBgN/MiT7/ofGO01TXcUsHBjEFCO39rzJBy7Syd8vWuf3vnvmF/R?=
 =?us-ascii?Q?EVy5GdKcyrVxD8I23VZpCDB1nPcag9jY1721rqRoBfQHxcAI2Phxig/99PaC?=
 =?us-ascii?Q?f7+5DDF2tijhpitMtBIF2FoWXPV29xKtcChsPDrJNmWr+AC6j7cltqUwREP5?=
 =?us-ascii?Q?SLncJ5QwA4aehxg02y//IEeb7ltAwiKUVeiQ0atrn9uSkoph0LuXZxbu43hY?=
 =?us-ascii?Q?yt1iMsdFWcYvZGF7SmKT1Usnq4vPKI7s3F3/w3IZDZEv+76An8RieaJjzfr7?=
 =?us-ascii?Q?l+ufT3LkXYXLt8xCabFn75a3td6QO+SbZ6UUDywjn31RDYHwkEVSqlM1+C3g?=
 =?us-ascii?Q?rCn4PRGWdlG68pE1FI7Iq7gk3n45dQe32zlvEmp8KvPlHzpiCHdJ1O/fuqHi?=
 =?us-ascii?Q?O5IKoeL9UXBaGZ+NxtoMKmrstTRUuoWCyUw3uI1QTigU7f7JxVqzf4ndfYyS?=
 =?us-ascii?Q?890QIWOH58PHzcsAzHN0/itb0MbXsd7J4siIDc/454uzcrddBnWm/h0wN848?=
 =?us-ascii?Q?xzbkzEqQNkvgSy7PuKtSOdgkqeTk5Q+VBMOHl1oK4UIKArjwIvRCvYoxe/yw?=
 =?us-ascii?Q?9oqF8/sUfRYcWHk/2gKa+6rLGwRlTMjQkXN2oUSlYHZ71ZPmdW5bVf2PF6P4?=
 =?us-ascii?Q?Z1amJA1bFMJ40HhqfWdeSe2VAULWVePVgx4rflIrY/HBQHSl1QaUj0+6Vc8C?=
 =?us-ascii?Q?sxWr4CBGY6C7pjcl4BcKd6ad/VjrpYvHST+t8YtQmHvKl4Rx9qL9hnBt9+d5?=
 =?us-ascii?Q?+nQM85QuCE5NY7i1CAuMq3lzZKaMfn0eHwJS+TA/So24s+zbsntFjnSuyjjA?=
 =?us-ascii?Q?nikAhbCTHUf7CCxYC+nybatOb3LEUvyGRldfoFHJN7TLufdzZeYtpjG2+TMn?=
 =?us-ascii?Q?RS6Kx5CnhjOyYIq0tVhyc8PgJ1bLYjfuIKScp21EvorpcBn+EeTKAvP3XO3N?=
 =?us-ascii?Q?F/bzFrbydEnXnf3YBo7++16008ExXdSE6an1wvvqheo1+vFPNvwOEEfl3hX6?=
 =?us-ascii?Q?OJ4W/vAF4Djc+6A6gtcValIB3ahdEdC4PCMjUI+ac2WK/1evFolCNL/CAk+l?=
 =?us-ascii?Q?bDWyBEwVZfXf8MBtMy9IbaMbe+qrSs9iXq0Wxw4a?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b98b18-9820-4bfa-bd35-08da5e486962
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 05:37:12.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH2mu87I/MkvIh7SezLiUwG+GB3tvAjYCQD1NT4VB2I0g/AmKu1zDkIwPoYEMEQQTASBSW9J4E7c8gHDY4fCUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0651
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

