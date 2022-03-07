Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD94CF44B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiCGJKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiCGJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:10:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6E2180D;
        Mon,  7 Mar 2022 01:09:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYAptrAT3xQszkx8u0Ul7GDXIV23tgi10/SHm13AJxZdWiNpTv2eVEiT6nJA1vTQnAI6Xmn4D+VSGkxSbcXagzIuCj5X9oaEgMIGH26qw80r/Am/4fAxd39GTRsenk4U8XgQQm9EdX0KR7+OvBBe8kS9ttFIlCNr5aPXn2V6G0nwJMoWXGfLyWUg6W3ozHuriqSFYNO5e/hGCCUzjSOZtFoAXepjb94761ctOyrDngl41b0ybxKFDSKBjlXy4GazeORW+UTNmQ3IKLWKX+QDSp6SmMnmUGUy/BZ6OYj8yP8VjYSX5DyrmGuR2RKD8bL8LPevD8EuY8qyt7s/42fBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdcf4eTpe1oL9d/yo3AuI1OmEljX/2vXFNg4Vm3U7Eo=;
 b=XXY2Lhd97TIleKxfEZ8SlmvKNdzOX3hC271L8qLxUi+GpPb7uFRaWFEFkywqjO0wGXPFZUdvxjr7uJxS0sQURAPegbv4nXV9HjnhYi0y/3JmXNfvPPTotdIbicvwLaLRg6gTERK/1l8p8ut7a47DZ4ggnMb1nvajHgQHWn/yt67S/dX1Ydik9YEotS3GWgKxZxsk3Mf58aK7E6wQAixVTMHEqHYmuLG5NW6sjKVRBP97hAe25Xizma14EdkTUYqFthLTs77bYTxVwch0BLCDKiqPXOxfV0mWxDm5YRJVBnhTFefZU/LKEXRIibvPnCN85LJEPfP0mWz0iHlXAqME4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdcf4eTpe1oL9d/yo3AuI1OmEljX/2vXFNg4Vm3U7Eo=;
 b=0zHBBg0JFB41DF+RAqF50u7Js2P36brTJtW/d3Ig6RmkhGUY6i07mPq72JClkxJBRwZnUMAvv80ThA24POWlrNNrUejTPU9Gnikrde/bWXpXRGlSFF4Qt8z7hp3zbGQ5miIHpUD+l/LkS2nKvTYDOMjyz9duzmCWGXGtoh7zZSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB0173.namprd04.prod.outlook.com (2603:10b6:3:75::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 09:09:53 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 09:09:53 +0000
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
Subject: [PATCH v7 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/ directory
Date:   Mon,  7 Mar 2022 17:09:26 +0800
Message-Id: <20220307090929.701137-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368efba6-b5bc-4da2-540e-08da001a3d56
X-MS-TrafficTypeDiagnostic: DM5PR04MB0173:EE_
X-Microsoft-Antispam-PRVS: <DM5PR04MB01730F5DA1D3F2433F19A4B5C7089@DM5PR04MB0173.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TB+4iDWCtWsqwt0xVLE4RhYZrifpkCZljOpn3LmDOjYCvedkjiItv8qlS7Un+E9QW/t9eTo0VIGT7kdaLLsyrtAlbXTpNBqh9AAJYIyj2AqiJMFLYW+m68bq5Xd+m4p1+LfwyV1m+ttsnYfFsqMxgMvC6Ko/Dh/Z0e9sf6z0HW3SGVTgmwtBBy/NBXCycZeEJFOAjA7y90WaJU0czp5gj7DR34o+WLlPbluAWDca4KiAxIG04QKJr5707v85uIh55j9PvHy48HjFQWDxjrHS4B4UgSiacgWcSz6JwDCxfdEN4yJxKFypjfP+dSSNsD04MN4vo1+TDscapWG1YxlfopBcEbU/aW/2lzZI7nD4XsLejca76arcqiNYrlHOcNW6wogvEqA3g4/qeKema+lX07T6bNQhdrz6jsMFZ8epUfXSQmqk2T1Vgs+sxEya0B4yAa62LaxJX0dCHI9dKawT+dXNugmvArSvV/gRl6rWqMrU2GkpIh3MVYQahIafWCnJHn0FHBOuUz2S9lbe+8hQrivNzgCjxUpDeoag5XiZCDWqJB5Be5PRz/PD6kLKJC1pik8Q7NRHtYuOgbKWX2mIaOZKf4IgHps2zosDysN0ZxdWAauTfEbxE9/Q6IKPqGWn1zN+VWHJjM39OL/eZTVorAgdeLDOVrAzc5H69qUYPBmMGkWqfgRG1ltMWLqOaj74kI084BEjUJzh+7GDXXEboQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(110136005)(26005)(6506007)(6512007)(55236004)(52116002)(8936002)(66946007)(6486002)(2616005)(38350700002)(38100700002)(6666004)(83380400001)(86362001)(1076003)(36756003)(498600001)(4326008)(8676002)(5660300002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gd0zzXdA5X92K8G6f7YWeRXNs9N38GhRBRk4evgXP1V3tgAwV16FL5ZSMs+q?=
 =?us-ascii?Q?nj5TEsQ3+g8H0zvFCsSoN9rtfjCt703/sxlznTDwTPrfQm+57sF+hQ2Ra3Dz?=
 =?us-ascii?Q?r+zMQE8OQATOGY0NbC/tRP/30A83EK8sLo4Ffq5EQH1PpyH8lYBPkMJxTbeG?=
 =?us-ascii?Q?msfY1qVY5EDWJIeClIQwERPNpyHoWgBtbVuRvP2IKEVHskHlcpAGJaPYdQLR?=
 =?us-ascii?Q?juOS8T5ZUmfmsGsiWe9A8CDHCP0Ub9ZqCjiI8QpIjHHc/mPk+fcoozQh+HKg?=
 =?us-ascii?Q?OFOGv7UfMVVXVWG11aZ3SVaFr2uHjodT86QTl2HVbbjlLjWWVEINXLuhgO7D?=
 =?us-ascii?Q?gJIwu1B4JRXJ2jhoVNCymLdnzgEH/vCQufTRDf2PW6CXRuPYrnHv4mFNoLup?=
 =?us-ascii?Q?vcUZENgpGHtXy8FU/Z+cUm186CiGPcwljn8KlMfiHyCl+gE4RxVnMwpUivjv?=
 =?us-ascii?Q?iqPe6U3zvWUoO2S1YnMUoG1VLUlMG3H1PiZRumC3IWzwTGG6w/RfmkQtIEeg?=
 =?us-ascii?Q?jjV6gHUA0auFOi7CAoB3c+lOda/DJJZ+nU3HqpZ/0Yim+OVjDxOnlQQ14CZX?=
 =?us-ascii?Q?IjyGGQCK8vOKZUS6+5um3E/uy3XMxj4rNkRDvHnttPn9hbQuGgxy87Cgt1Ag?=
 =?us-ascii?Q?+STu0evvKvxUvhqbhdSWXMq+54q02XKDj9uTcZTkDrLF8J5jJJqkqN8LZAJX?=
 =?us-ascii?Q?4qW19/+HPvKgJuoa5jM8Gikhdy+63G+dTDGiWKpLUdu1Rqc8q2/Z9ePAHrBd?=
 =?us-ascii?Q?P9h0+pQb9ijgquFtST4vgO+kga3pHfR5TlCw5INvkeKS5Mr68Mo2dCtkB7QW?=
 =?us-ascii?Q?fLzuAHs88BWyWtSwQSouEuVbI3SdJHAZ1b0qMhrKM6mjkWwYqfP1Slb8ldgn?=
 =?us-ascii?Q?9KMXeC7EWekHoPfV+a3c5rGJxGQgjaqMz0f6IcMgLFOtNJcqKxfWsxpX3AcS?=
 =?us-ascii?Q?5mFShYKzkNMRJD189BMUZSzTV59rUqspU6h9EwnihEi7OERpMZK8vrjhQcIe?=
 =?us-ascii?Q?hPGsCMSQu5oo93rHZ7WcqEuF2MQNXUHI7U8LTT3HdJwLcRUWLSgQoDAG3fJK?=
 =?us-ascii?Q?enxqCcmhVggGyjQWkSRLRPZODwvkLoTMfgPXs1q6xuGYaHI6XtaFRWlscYou?=
 =?us-ascii?Q?cAThX0d/9A7/CApMlwVbBLn0T/xW69SZqHvP/mvR3S5LEsYVCuemUDvWZAIw?=
 =?us-ascii?Q?NJ+OvRpnCpeGjbBjcb4PZb6x88hX0n7vqfzOoQ5z5Yj/+aVNJshdZbfqHqDr?=
 =?us-ascii?Q?z/DouL9VmAO9KsxgKuYE72yX69w4psMn2MP/xgFFbbPg9EXILMhKNpFwde/R?=
 =?us-ascii?Q?ImtzYbXjYiy7uAnJRaP/i1+9IITWQjhSMoSJU1Z+LtjRIYpdBYSvPsoESZYQ?=
 =?us-ascii?Q?oBr+OYZm5mgGOwsrR96aMXe6219gvaBMAuayDHW6qgvLgIcx6Al8rkU8wWxW?=
 =?us-ascii?Q?qjAXcgmhVMYAFc6wCjb4Cffmz7XaiiG+U/O5EkvQaJQxKiXN++buxv+rcnpr?=
 =?us-ascii?Q?iOgUkHpjuD3wunSHOhayp0FsyABUaeR6/U93GYQcwte6le7DG8ZJcj7qqsHV?=
 =?us-ascii?Q?5eoM0fn5yssCCbKnDFfcfmfokjzehOQUmeKxAEbNYw7XmwK6hle8pbiHsu26?=
 =?us-ascii?Q?lNmj3ClhKG00N80giCfqtxQ=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368efba6-b5bc-4da2-540e-08da001a3d56
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:09:52.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqiD3ZEudjHZSFpkol8T36tSRBKFjV+ikuoSoQM25VrKnhYHPITOYb9W+gdZoX+HqxbPq48Tl6XATun1KLNiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0173
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tcpci.h as a global file, better for other USB Type-C driver
access.

Fix compiling error after moving tcpci.h to include/linux/usb/.

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

