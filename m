Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6C4D1114
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbiCHHgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiCHHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:36:06 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2134.outbound.protection.outlook.com [40.107.101.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D33DA69;
        Mon,  7 Mar 2022 23:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuAMDodXTUadPUW0E03U88bQOthxVBT1WWX8sdW1/ipDs+d6bjTDEizm1MAhl09xTtWM1k3w4mlR80YvEri/7uZChJWGembJ/R87hdaMsyU/kOje5kQMsUWz5UMXsuCVMgUnzLQV8dWBVsWEyC93B2SGTBhgxSRMdJxtJ076NgyWZpGOZ5fw7qWbvFBy0n9uhFLRLBwNJdKp/1SqbC5qr/RGFsehgjKku+y5NZ12xlaJnIhlMVxjsb50wyBY3O2WEw8qG6Oi8E8ysD5HfQ5vM/9xYitL+HaHPZ7qWjq5GlGaS0/UsF7DMm4D9asdJ2h5PvMIkJHcWTJPDczbBprVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWlAhl5oUhm7qEe3EfFCM3od0qBU34dqA0qLEJfF2hU=;
 b=c4RNdR80BSPn/1FMflALdT+qPk0qrCxM8JLaP2+N6b1nMkiS7OfOz22ugB2m2t6c9tILHyHiQDz0f3Q7snqXAzyubQj5YhIwzqrvQCoWH+OmxH8TQiqiuwTm6+PGVQouPKil9PypyIF/u0qYTnxXNNhROMlBEu1+mmXrfCZoHKv6RDG8zjZujvOnqzFijpJNY4J1y3IkEZSzMn5bfgU0C8c2vZxBLUskiGIbsouI1anzeArkt54IpBymBrQqmtxP9bueERVQXwt/oGXTNhCr/FgHBKVErYfyPsdx7nUC8Z9LfbuDFush+VFznCe9RAvn6lQ7nFMGl3TLnehoB6FGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWlAhl5oUhm7qEe3EfFCM3od0qBU34dqA0qLEJfF2hU=;
 b=GswAUuogq+WSY+fO2eVCT8VuLJK4EZlq3PCghbCsJxr1wiJL8pHs3japGdSVcRhc6FFHiXK6fJOqZiE/AiexeglOfSwe8O7E47InqduX+ERbRh/QrLlf/cLSJlPn814jO2yw4ISSBfi/C4V6745almtOB44VZDsy1E1tmBNsrCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB6592.namprd04.prod.outlook.com (2603:10b6:5:1bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:35:07 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:35:07 +0000
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
Subject: [PATCH v8 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/ directory
Date:   Tue,  8 Mar 2022 15:34:28 +0800
Message-Id: <20220308073431.1217890-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a114aa6b-a981-4a86-405b-08da00d62afe
X-MS-TrafficTypeDiagnostic: DM6PR04MB6592:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB65921C641446F1055DDB4485C7099@DM6PR04MB6592.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6IGSBH29VHGhL/APQizSJg7jOZfaNAScOcH92m8OPrkGv0U/MDa2CLsAvI1XXR0KGMqojTpEMJaXXZKK5QA8hCXZwejXaQ/GvwyBSv9lMRnrUKvfNDQxMaPQjjLFcMeTp202FXl8xszXZCM9+GPITtaHeGixq6lwtfznR6FaQRDHDujaV+UTAFh57GuP2XVm/exQXKPvMXQH9cubT71l+kn5iuO3AJcmrIDjS/25PuSFrwcGjoF7iDm4WJrIIt07g/VE/cFEmKAMAtzl9KKXiMPnbAtmS9ph8c9rkdS0f6FGfRD2ZchbE1RHf2MJVEIjY8zZ5eutgQy/To/iRyxPngspl5WU+r/njEBmsGsCei8NGrCsvQGKOwhS4KW/RKUtZnOVUbc+d609mLoV1Ejmrn0XG19NHvONMPQjcm7blWM2kWO810cAtLuZn2As4vAKAghZXQgpkwPHwrkfY0CDMitXm3wAUmYH4+JYsDTtrOrMv3KbhxeREekGz8TTniE5Qii0fN0P1QcIBNnPEwuvYJgjJLPslW17Ym6DvifQzcFF+x6bvuyr62tUieq/QbDOUokPXem+wa1xov1SZdwzaTaa/PppIY6Y1Cu3Hki/BNDzdOnYutHiRrLchaNl8DXeYJ0fUwvhQux84uTlxvu0X8+9fWE3WeqEEieCvxZ2hhHGPEAMSc0VitDtemBMXYxT8PaBC8jMpSnw2/HlIxCqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(38350700002)(8936002)(5660300002)(6486002)(66556008)(4326008)(1076003)(110136005)(2616005)(66476007)(26005)(186003)(498600001)(6666004)(6512007)(55236004)(52116002)(6506007)(2906002)(36756003)(8676002)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQfznDyFmbmEDkwljdbGsfIbVBCzdzYVNQZ1XICIRnStFPkiifDvGo5AmxNv?=
 =?us-ascii?Q?JOyt6qiFTQl4+rE9vDfQXW6Z3/5DqgpK1emEGuWwy84VcLDQNYDcQ2G4n8Cw?=
 =?us-ascii?Q?w3BwuHPocja8xvzv9Gpt9tRcLxVjrqNPBk9sKEQTlqSh+Cv/GX9mV8/H4zk0?=
 =?us-ascii?Q?YCfUnGIaIfu/VJL2rRoZgKNYiRmcofJGhE+jLdCZQR2lGX96mOLXm1Ai9fnw?=
 =?us-ascii?Q?LiB/2K4Dn7hivur9QYlCsW7ghstvlKXtfq1XTJ2hX38A2H/nIA7EDRgZduzB?=
 =?us-ascii?Q?tiWOg6CqPw38MeYdaaah3YynU9s0aKzzS9MK8aTrRJGhL8sxgxFjEFUo5Dub?=
 =?us-ascii?Q?6fKquUUK5/jgx7JzbcMy27ju4XpED2XYcM5OEV7c4SKA6jXDhw5kOd1qCEaO?=
 =?us-ascii?Q?uYbzptt8l7TOeRF+ZqYrYv0vo7BNQoACRtMsMp0DK4pQhr81TyAzKG+XjsGn?=
 =?us-ascii?Q?Bt0ws+Vb8AFqJTcdJ5xBSl0/esmtMZL8l4oSZWea0djOpvKTNolzfwYr/gv1?=
 =?us-ascii?Q?YnqD282qP6XNeRJjmpYRvsCXvwgoFKTwaDnN3DseTigw/ZpESToAjjEoa004?=
 =?us-ascii?Q?oq/lbJ0Qivub/tROQjw0p5OF2KPlWOhgBm2Kk4CGrW8GJBLY/aCPN8DVFzYY?=
 =?us-ascii?Q?l4JFW0caZu2q2uWWCupFkUDYOBGn3w6VLIrlB3Sti+JWRVxP/i1L3g0CKfmC?=
 =?us-ascii?Q?W06teWJBsbc/YnPziGwQxAc7cripPe/E6c2qjGk1IqJSrMg4v6Yb8URZb+Mw?=
 =?us-ascii?Q?551EYVQfpbkDL0C2RbKyiLIM2dF5kn5oVqaUKTGAjrjkim/ahS+qvZ0LoyWK?=
 =?us-ascii?Q?l/PorgroX3WgSpDqcsPpD8/wTrj2WKJ7QnSizebmON5CxF/9iwcNEt43Sd/F?=
 =?us-ascii?Q?Q2gscWRTGu+U6IvlbfdadjvXC2oQUcdTDDq7rdcBuAAkeW7sQnHNJAnAQUb9?=
 =?us-ascii?Q?ZKNQfcWQi0f83EFKDj+YGttWBk95xTRW2JhuVvY2b8YxpAx/avsi0CDvH5o6?=
 =?us-ascii?Q?9DcviWazvCRMMVXhzbKqK2df3FJ08Q48R8ehcr2sRwozE8MumMfAW7MP4SWP?=
 =?us-ascii?Q?sWsEgxm0SrdlUNwtu+5HHTqiLdQWciIdNP0PcqXYKPZwnMYBm+0Y89MzVcs/?=
 =?us-ascii?Q?+P47bR+KMnBpQB9scUYRtg0s3t8xzDzSf8RaMKDMduczMb5I8J6OAVmm6+nl?=
 =?us-ascii?Q?hqe6Qc2Ryg6yGAbmDxVn+LMs38JBO6S0NG5B4yCUniTEuzvPETMtVGtbu80W?=
 =?us-ascii?Q?qXobMjPanp1NIm79DK84ZqGiyH4emrFgdnylByBtBvijurFMYs0b4O9Jujs3?=
 =?us-ascii?Q?QP5JUAZycezWFUd5TdpxMWb/aolLUtCykYrxB0/UC15ybe0d4d4SBcEzipLi?=
 =?us-ascii?Q?2h1nUcPPuEHJL7DcQjrOfFl8iX/JdfjghI0BNldZBT/dn72I325TX1AtHQsA?=
 =?us-ascii?Q?Gc4Gf/MsV5T59awUG2P84M4PiGtOtwGkRrExrbbsYfgPTPFG6ukEhQ/F45sU?=
 =?us-ascii?Q?+WP/b0hc9YGJN8cXJ8QTS08o6am44OMjprDcMeaerTf1yzFT1WpANgAfh9qS?=
 =?us-ascii?Q?oytgXlDmfpA/gg2nc6E0DIyu6awt4/6VK7KAf9wCskqEVS5jlLkjobd58rSb?=
 =?us-ascii?Q?AnY37qDjqzX/FsM4qikxUEo=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a114aa6b-a981-4a86-405b-08da00d62afe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 07:35:07.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGchbgmBlXFyZ3Uhw+ijku65j+6rHrGJ3BthqDkg2xdDUb4+JCELoNsR6mFN/JHiUSSmVew6JBZvFwL8VPkCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6592
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for convenience use TCPCI register definition, move tcpci.h to
include/linux/usb/ directory.

Signed-off-by: Xin Ji <xji@analogixsemi.com>

---
V7 -> V8: Fix Guanter's comment, remove unnecessary explain.
---
 drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
 drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
 drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
 {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
 5 files changed, 5 insertions(+), 7 deletions(-)
 rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index e07d26a3cd8e..9c907296596f 100644
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
index f1bd9e09bc87..9e0338bce7ef 100644
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
 #define MT6360_REG_VCONNCTRL1	0x8C
 #define MT6360_REG_MODECTRL2	0x8F
 #define MT6360_REG_SWRESET	0xA0
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

