Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2B548402
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiFMKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiFMKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:00:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D701CFD9;
        Mon, 13 Jun 2022 03:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSkFzALmiY5irzFDAvJff6VTrP5RC2N+3Ooft0MTRoNyC3MoQrFo858azFQLsdqqmKl+RpDauEwbmO0/1gZQ78k+zJWs/HtFpedrnrKaTNwC/AWozsM8Da3yrIiBSk49whSts0342Pum5QWQCxMjXucZdaHLIY7ectxIpPMyG4Ts0eVuJZdA9wUxizZS3HyPKs8H9A3kTGp1l6RqxuPcieTD/mwIETcRBWIPHkDHFBqrd8GsLDF8qH5Fk6ew8J+IeSQ5aZ9YIcT4wUV4o4y5L8Y3Qoql/zadEP0td0dw7lYiE9IoXevcdmUooHYxKi4Sqdp6Y7+H0CLDIsT+SwcOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNx1TNd02XU5nWbvCJwS79wPQDHEkqOQKTYwqrHRfuY=;
 b=gRou4IIXjO101fls1peIoxCmv372xFAff7VX8TnyPUo7hMCSbjmik8Pbb7DkMdGlRyUcmE4/MR0kjtPdeyqfxR5q6VIHeWrAI/3nsKxr5wS1mdMeFG546pVVFjir0bNrw+riFezslhw9j0S7lJNRHFyt3P3kxgOX96aDM/zNk4h64+VkY1dEw5CppC634Eof9JbM1H3phmk/QJGvhql8YyoSfCBG+oGRIa6Uq2CERQLwgZ+14zDIj/XOV8oz8+pmANAecWkl5p/aQhQcylzeA9AApjL2xDtWa+pM2+MxjHFQvLgqRd0U5qYfoJxqF5lj/RGCF0hDlChElwo05JmNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNx1TNd02XU5nWbvCJwS79wPQDHEkqOQKTYwqrHRfuY=;
 b=B9Yov0X8A0MRCVP57moVuQftyFM4gF06YBFMpH7gk6ZLdePYWrSSB8TfmfXp4ikQa38s6+W8BnXrAW/QmzRC4KaE7WFgCfdd3kp34EGWTPKideBKyBjyzHLShJ90k2VX3KLo4jlCHs1XU6UTAUHjDIQJqVOQlHmR1JhU0L5+4cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SJ0PR04MB7229.namprd04.prod.outlook.com (2603:10b6:a03:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 10:00:24 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 10:00:24 +0000
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
Subject: [PATCH v10 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Mon, 13 Jun 2022 17:59:54 +0800
Message-Id: <20220613095957.1669829-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:404:14::31) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb17ac3-bd35-4bc8-0190-08da4d2388e4
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7229:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7229DB91B73AF0E73E3D80F4C7AB9@SJ0PR04MB7229.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ts+Xckk0hd3MYWa8X+zCCRnO1FB7s8hopKI9mzJ3pal6bSNFiWOBmB9N+OLFl/+zGuIDoINxGJ6nFOM6cHoNiVuKUKc1oMOx8KEXsC985uxWJ9vfGHO0a0a5cJTPOUNHBvYaHkE7iCIDEb/FRz19LG5Nk9YN0r5ybdMz4kvBsuOgl7/lJm9/6ZmdGFhNPPHJa9h1y6cOxNieZc0RtqQgZecm/v0VeQEoOIRLxVFnNkrdFjZG+I9IT/yF8R5VmViimewMXy2m39yMIC1hsdoryov3V0zebLKjqbsemYWNpwTmWKlFNLYGVEYakQHlZdnnk1qqN3Ot51X114ZtTn3gDNjvNvNb2Kq0Cdwwp19woJol5+XkGlNEc6y4ouapHVsBUzZc00D1DFLz8XeDsFkn3yg9nQIz/sF418mj34ssjkVo/PeWvsDQHoyHw+j5ZWF8czEHvekTH+sPxdaRZXb0mIhXYqMaScRhTDkPNz/ZIfZtO3m8BEOxwoKmyHhFrgwK0t2oUZYkpQ53LMKc8yAJXFs5zOhcfGNg77QgsGcyLs/dzzXAhz7oLIRs3/TnMH6FQlHtqxA2QwTMucp9UTQofdPfLaNBNvuUAKN4zM0FqSkhG/hZX5tzvGWsMlajaYzJYWtX1E7t2oKl0KkJC0gteSAvXn7JlJuRa513JVN/l7J93cmDtWBdxD9Ht7GF7iS9NLJHjexddYIzzgV3hqNcKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(110136005)(316002)(36756003)(83380400001)(186003)(2616005)(1076003)(8936002)(508600001)(5660300002)(6486002)(4326008)(66946007)(8676002)(66476007)(6666004)(66556008)(2906002)(55236004)(38350700002)(52116002)(38100700002)(26005)(6506007)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlBEOGTPFyCNm6tmJZm5+tdc87672IE7mPffgg2WzTz6eNNN6qxvxdKHU7Rx?=
 =?us-ascii?Q?sv496EuLdQZX6Nieuk/ycIUbaGCj4Gs2DN443BEuFPMvwAMzONrJPxNiDaqO?=
 =?us-ascii?Q?i90NYhQTtVaqtVoFS3iIOwdncN4y3ZNcN16Bysu+3ZzGxcy2RGxLpIPS20ng?=
 =?us-ascii?Q?Ar04Zlca+Bc1dfyhwhH1veeRUI1q4ejRmLAWClzZ+hVRXI/iYDWVXxpe6atd?=
 =?us-ascii?Q?BlLVQtv1vHKAtGX1k+67T5aZJQlMiyFvgd2mLc01NKFY/JJb8ARaQdD7kUWI?=
 =?us-ascii?Q?ppSzn9QFgB4TTbXxt0D1Tf8IcR8D0pghO969RQ0vLDSlQSaCcHs3FKYrrWAq?=
 =?us-ascii?Q?WXd67nUBjpHNfviCJ18hKKxhc8c1mek3yzGpQAM5LWb38ua/8UbVpwtEtP3S?=
 =?us-ascii?Q?fbks+oIw3Ve0mf+/0XN9tEamRTVXaTLd8ntH2hNKRd/AKS86r3ysptzxyApI?=
 =?us-ascii?Q?IKV+R8EGmMEI3vl8II1WyVH01Z7q8nQLrVnYddqKI9IAkG7rCTpKflqcHasa?=
 =?us-ascii?Q?rEgKkQqm5csylsoxoWOPwbwAGIrwTgoUidADUtosFtTiOOi288VvAl+Tmbqw?=
 =?us-ascii?Q?M0JEtNksqLtlLjz6oev6hQqXAjusOlyXtToyYmp8zxfWuXcZmmk3fsqU96ny?=
 =?us-ascii?Q?/lET9ysAUbVHQoQPWiVJdys++wy9N1xd8gjx+lcvWimV/4CZXwSKDOW1Wf/G?=
 =?us-ascii?Q?kjh8rVrAR0hBw140ixy5IZe11nNdm0jOPGSD3ZUy0zAxx7LxU0wtiTDdgcUi?=
 =?us-ascii?Q?8yy+muyrLHpRXUBIme/d8AohDMFcQAVqbUkTwq+zrJGp1ojFvkosq/q/fUeN?=
 =?us-ascii?Q?opFys24d7a5JS5a0Hej5jNohSxX17gp/HUVPUtrYGqwULRMvrRPIi+fsWT2v?=
 =?us-ascii?Q?aRKPed1BdiBkiIfV9n0/2zgUORew0rX8tJYHFdx6Da1UrrJQZsWrcLDjFm1q?=
 =?us-ascii?Q?Hw3VavVDCMCeyKaayHayOfHvHHvuZoyO4SUIVebG0h5F8DV2VjAe1gsEQbit?=
 =?us-ascii?Q?oU2MOIzzixtOCHyi0ANaA5IWrHU7iJ1EH4qcO8WlEfijoHj8wA9+Ao/c/F6y?=
 =?us-ascii?Q?k/S+YCpGoQGXFRtUyujZrwQX60m0qLZJtSPTMeiYgP3XwFwouw4p/ibX7fQR?=
 =?us-ascii?Q?+GyK83to+nzaLXPdg8s0OOe+POzyGyUnUllOerG+ouIubFvFC2LC9tF89Vs1?=
 =?us-ascii?Q?bpeLSSRiU/5wt+SgWMoRYVmlX6oLyt9VDrwvI4+nRYtFs97zxuDva0h2+G1G?=
 =?us-ascii?Q?UyEJo6qqCcSZUj34bpIbEFgNL3TUBNntJR9kstjnoR22Kp9FMbs/1EP9iQ7w?=
 =?us-ascii?Q?3waIlsYr53RJl8kWYssa5zvLrsZ9Glo76osggbwQIWjCVUlCYLh+N8Mm5hdL?=
 =?us-ascii?Q?gyjLbS2h066CEvz14AtDoQZEfbkjGo4zU7sgrOOeoRSifPC+Dzm3/V0GbER6?=
 =?us-ascii?Q?eNWOdbi2SiUJD8eFCVsDtCQmghnB+6dN07RVt2BUl0qHL2fL0cJn6ebjzDs4?=
 =?us-ascii?Q?HuzHd14gthThdfZSkkV8dTwxVjPrNaW5OHA4xxN1+bepLPs7eKBta9DrCPzU?=
 =?us-ascii?Q?PC/5cdIG9JOlssakN2zTUAnSH+LSM3oom+9SEKrSlgvMNrBYv/Lprg8UZOA3?=
 =?us-ascii?Q?L0Zb3q/jbwtQ6T+k6r66GcXKp6ADW9DGSfpSNPbDbahqo7kQx54MXrmDCxeI?=
 =?us-ascii?Q?cfCRxDA7PMuz+mG18i6byvtVD8Q0bVktX1mm0JTmYIz2m/ClB+LHiHR75DA3?=
 =?us-ascii?Q?8Ln/Tc9CcQ=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb17ac3-bd35-4bc8-0190-08da4d2388e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 10:00:24.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CzJtO4prZm99cBwj2a8CHAWXtl+KYsqDGaHO/4seWlNDNY0EyY8dDDzD018NmP9dfY42E0D97satRXxeQyYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7229
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

