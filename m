Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5CD53CD8E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbiFCQyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiFCQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:53:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF442A72F;
        Fri,  3 Jun 2022 09:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFwGInjbV45+agj1jsD/az8F8S8w8bOoFd9y+PQ35aWAOWol8opyJFAwgQiFJ8jaoBCpZCrR76WM9t8Finask7dM+X04rrUcK5kq8CaIQugISsmLpeK9XTO+jpHhW3Y/CcZyXru9xBdtpgInxNRnCX6ifxPp0vKG01I/ob4MwLcIFq0BmKbXkjzM5sDekGDxYB5a5swneRr0/uLNsXsvPdOkHCPKIRkxEBGc6/nwJdFG+avcBYO/a0ohCsTOAEN/3Yxf1tppQcWHJDoP4WUQsRBPSiViGVW0PIwOlTGvXX5gk9ERVRZjjcrGlcfiLygk38rDiYoVxBMGp1IEUbE7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rT2hUXv9W7C6QqkYqTZQ02+QsZTM6ETVUDflmXpSNU=;
 b=QKjYzMjKFFdNh30j2PA3fI0IGW2+18EgLApZ50TwVfLSsmY2UWENA5Nr7UcTWS1minjGKS+tg+IubK0H4YJ4Y0EOyugJi/58947/Sj3EvAE/pZLx+zDwvdVZNIvkaWe6YdccfSTjc8f1LjcjTtli0kFrsYHqzHhDsJGPNg3opUpYEq9seIWU4gVvnM6WJvM4E8b8Crzxkk1AJv2vhigmgMxR/hxUlWYCbW4JRy/aML4s7S8C5QAMxMzyPbpZXdmjMg34BAPhJJZX+EBX/EaUR0pyJ+cZn7pNncq1a1xDK36uH61t/8w7S3JOL3Zuk2yFCjJ0Bzz+w3RaNWY8ZQ9D6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rT2hUXv9W7C6QqkYqTZQ02+QsZTM6ETVUDflmXpSNU=;
 b=uCDguU+YUfqXfUd5JHy8HtkxvNc1jnB17oON+EmtaocZQXsVSjZn7ZvNjy4pcHnK+zHEv1y5KnkQyLsaf9XoEIGhs7bwDLqA9+Pv5eI0sjHvZ18/hMvAew/qBzysMsjkGz1OgCkoIaOYQgNFD5BAoGx76/qRnpCW19CuuQweEjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 DM6PR01MB4282.prod.exchangelabs.com (2603:10b6:5:23::23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.18; Fri, 3 Jun 2022 16:53:53 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3%3]) with mapi id 15.20.5293.019; Fri, 3 Jun 2022
 16:53:52 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] hwmon: Remove xgene driver
Date:   Fri,  3 Jun 2022 09:53:49 -0700
Message-Id: <20220603165349.3348390-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:610:56::13) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 383522ab-eb03-4b8a-9f28-08da4581a353
X-MS-TrafficTypeDiagnostic: DM6PR01MB4282:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB4282BA6C26C26C92B6C8A15986A19@DM6PR01MB4282.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zXNHdyDHX9omMfLzU88KBG5RQKg2xJIL87c4H9Ninb7BjX4uTHRIZSyDc0dZFA3hZ7e52QX3ZWjSVhJjXkYclAnWPevs6ynjhhesfynRQbKDd9gqxrucq+VFdU/C4+OetfMxr/UOls9+BRutJBqM7mvrCO/HMjNpYzvkb2JEMz6eqIKVK3dHPvFB64RToDkz6EsB+7707psZlXdLuPzK/ThtYPJ/JriM4pESoeQoqbWr+i8BmcJSeRIcKaiOLn6caymF24zyxZLXBKbztShulSQdcNAQX13lclSGHicvfPL7ECHPNTETYRT6rTmVbMuNg1zSKmF4mtAnATwh3p7SDu/4C7DUqnNo+TrmUQw1ogNPdFQkm68JvValJSJuWpiraDCyqhc24OO4+l62GcVxv/9hMQmZMaRDA1NuU2mTYPtgnuVDtZ+8z54vQLlonU4mXJMc/UdG5wEwhW7i7pigpmtU7HnCXcKLP4OBADF44798YQfGVy9y7D2lBLkEyPK/rbSHWJ5EA1yU7a+IWWS4jC0/iW1+01AgXcRkcb5saFyJBggxkRWc+uRNWWl/icjW/of35zQuwU53ZA1PoWA7IDMTw6WmZFqcv7q1Lm0zBtm0WAnW6XQkV62a0S0wP6FV6G9C3tyMvLxvu8CsAsfnw9RvpSZo8KKweN1e9kjW/txRLTZ1bPJVG83Dwc3VdvMR76a/4vZp9tjuHJ1oHzyJxrnrqKTSydiiyJXA2tzrUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(316002)(186003)(6506007)(6916009)(54906003)(83380400001)(66556008)(66476007)(66946007)(38350700002)(8676002)(4326008)(107886003)(2616005)(1076003)(38100700002)(86362001)(8936002)(6666004)(26005)(5660300002)(6512007)(52116002)(2906002)(30864003)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rIryHltPETwTZ2EZNvYZrN8Nfmt9ayUO5+THWSnP+dr2krmryTYH0Ew7jyS?=
 =?us-ascii?Q?WAvTBBh/0cZDPgKqxs/1rcTYssHnE8NIgDuaAgYWt6kRY0fBfl9SLDLn4u2B?=
 =?us-ascii?Q?fsV/pTFmBnTlX8pKdFMtH92OZJPqTDla3G3Q/Vo6dytPEl/Zoe5x8EkUAtf8?=
 =?us-ascii?Q?woyiFvxwnfwT+jAr1bYLmDHQV/WL4VSFYKU6DtiJwqIPLtrXVTy1WyGa+d2j?=
 =?us-ascii?Q?RLADX4E38GdBKwsoFmxjhHZEDje9hUgppQpTftMTrHl7ceu5tdjD+m54Y78+?=
 =?us-ascii?Q?yoGNA62mraUEfIMuCBKWyfp1diSnDhJqPHLl6j8dHZXT75zIsdfjV7NqyAWg?=
 =?us-ascii?Q?3m1Bc3/cAroXbo9rzopKWb2grJOZ2U9eDflV8s2BRtogdz0uj4KpjNn3e/jw?=
 =?us-ascii?Q?ocBKh15Q+T7VCWgf0o/94XsSp+3KJt5AqNF/Rbv9aRY/bHfUWNholLYpj9/V?=
 =?us-ascii?Q?quDfOjpMBdfEk5JqElnWHXOm/FdExcsnA8c9El1NyvbiSfhWNOx1cQ0ndie1?=
 =?us-ascii?Q?tr6v5z+HzfTqGgneUXTMvx/Mk6pq9olEyEiGme2rwoF9AXX2pVtm+d7c6oWs?=
 =?us-ascii?Q?Zjh65ptgvPAqexXCcL3nqJTvvecHu5KgxbTvT65BTfLv2EG+VYHaCx+AnKbR?=
 =?us-ascii?Q?Y9IrDf6jnh7orpRgde4uzD/zVB3N8uJCF6bk6YyFo0Ui3zvIn8nfdQNaGdgK?=
 =?us-ascii?Q?horBWyKQ7a+3RR+CALGks03YzttvO/Mx4gUsHaudThegzD1R6+20O4XHuTzZ?=
 =?us-ascii?Q?gDB4nu1D+4xP0zELJ4/ANV4DYON3Ua+yW9vx3ojjba6gWTOVjAdv6wV4RV0C?=
 =?us-ascii?Q?ONvH5YRLvA06t3EYv9d0JLGza3z7W8gtPgyyZXGCtAsNG96+t/fuPTBdbadg?=
 =?us-ascii?Q?zJl7VYvlYGm7XWYexjVKb9Rdm1vmdnkVZd/nfitX0YNtQHQhcqhRUD/1NrVy?=
 =?us-ascii?Q?u5FVT9efJ2JqY4ZLsCkGtAmiaLCXiAeHL4/BI3uc5aru8wYX9jlZts3yOPXV?=
 =?us-ascii?Q?TQyQaLLFUc2P3ud/pctLRc/L8PAwO35Y56mRZh29ElyELjrjo6RYDgePqJwk?=
 =?us-ascii?Q?J2sBeNol9ruH7d1EUKsUbxe2Rr9F30NIgsR+LQ+JOj590YdgrHXHmlAWhD7d?=
 =?us-ascii?Q?QxxhZoBllkom7A2Omwhc48AyGCaVCJTUyTh5LDXWQH5xeoKAevu5eN1pocnv?=
 =?us-ascii?Q?+HNDrODmViWOSg3aL++etUhFvg4UEOxMqpMVxD0huPSfhzF9p24vYP2c8YnZ?=
 =?us-ascii?Q?JxgdQbjd4Spwck2haAuojFop2ND8WZ6v8gkA/zICY8jTr8chD+xFTEIsTlt9?=
 =?us-ascii?Q?4ZYCL4drpdL+S9P0fc7pnpmR3RNndY5v2mgNZAr3aW1x+zQ3i2jnNkJBDk8b?=
 =?us-ascii?Q?FZAAHWgiEP3TZVCxQDEV+xigjAptg1V+b9yjVSs5RjolDjPjyh02jwPRvanU?=
 =?us-ascii?Q?U8APWt7A6iW4oB3voSghQmFvxSowrDSRzI0OVQB0BdfaNAg8HwYA5ewUSllP?=
 =?us-ascii?Q?8it/hHbxZjyedMCxYs4/GG9RojBDfaSlJ4IBs3JmADFy6mXXmML+gCQ3xBKX?=
 =?us-ascii?Q?clgUWTadl21QdiQ2w4WRHCCCCnCX5Q0E8DfuA7INKd2axuKMIDtofDaHkfWY?=
 =?us-ascii?Q?SdF6xXdYFABcct3liBtjNOcTcPkt9eKXBJJ8I/StQf4WNWh3LaT43h/7DkRq?=
 =?us-ascii?Q?AdPHAh9BD5x4YEjX8T82BkLlvy4J+zIO/UKaGoJe6SX/LgvMiTxMf05D7sVq?=
 =?us-ascii?Q?csSt7nUYJ40eaREaBSqUgRSlnRP36uB7c0ewnq4Q11X2utJgyz5q?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383522ab-eb03-4b8a-9f28-08da4581a353
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 16:53:52.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+UcwmZZI8vLHQIEq6f8P0FOaHz85HpCEYghRCSy20cGhtJjrC3rwi94cV45AWEaS1yFuiytwKMtNykryKIM5JZ1rKcoe+whKGyMTcv8j2Iz/1OTwhCcDUDNJrLAA5hg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4282
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the situation in commit 9049572fb145 ("hwmon: Remove amd_energy
driver"), access to power information can be used as the basis for a side-
channel attack. Removing unprivileged access to monitoring information
would effectively make the driver useless, so simply remove the driver.

Fixes: ed42cfa881e1 ("hwmon: Add xgene hwmon driver")
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: stable@vger.kernel.org
---

I've put a cc: stable here, though I see that wasn't done for the removal
of the amd_energy driver.  I'm assuming that removing a driver wouldn't
normally be sent to stable, but should it be if it's being removed for a
security issue?

 drivers/hwmon/Kconfig       |   7 -
 drivers/hwmon/Makefile      |   1 -
 drivers/hwmon/xgene-hwmon.c | 792 ------------------------------------
 3 files changed, 800 deletions(-)
 delete mode 100644 drivers/hwmon/xgene-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 590d3d550acb..382157c7f681 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2280,13 +2280,6 @@ config SENSORS_ULTRA45
 	  This driver provides support for the Ultra45 workstation environmental
 	  sensors.
 
-config SENSORS_XGENE
-	tristate "APM X-Gene SoC hardware monitoring driver"
-	depends on XGENE_SLIMPRO_MBOX || PCC
-	help
-	  If you say yes here you get support for the temperature
-	  and power sensors for APM X-Gene SoC.
-
 config SENSORS_INTEL_M10_BMC_HWMON
 	tristate "Intel MAX10 BMC Hardware Monitoring"
 	depends on MFD_INTEL_M10_BMC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 007e829d1d0d..fe8fa99f3960 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -212,7 +212,6 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
-obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
 
 obj-$(CONFIG_SENSORS_OCC)	+= occ/
 obj-$(CONFIG_SENSORS_PECI)	+= peci/
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
deleted file mode 100644
index 5cde837bfd09..000000000000
--- a/drivers/hwmon/xgene-hwmon.c
+++ /dev/null
@@ -1,792 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * APM X-Gene SoC Hardware Monitoring Driver
- *
- * Copyright (c) 2016, Applied Micro Circuits Corporation
- * Author: Loc Ho <lho@apm.com>
- *         Hoan Tran <hotran@apm.com>
- *
- * This driver provides the following features:
- *  - Retrieve CPU total power (uW)
- *  - Retrieve IO total power (uW)
- *  - Retrieve SoC temperature (milli-degree C) and alarm
- */
-#include <linux/acpi.h>
-#include <linux/dma-mapping.h>
-#include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/kfifo.h>
-#include <linux/mailbox_controller.h>
-#include <linux/mailbox_client.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-
-#include <acpi/pcc.h>
-
-/* SLIMpro message defines */
-#define MSG_TYPE_DBG			0
-#define MSG_TYPE_ERR			7
-#define MSG_TYPE_PWRMGMT		9
-
-#define MSG_TYPE(v)			(((v) & 0xF0000000) >> 28)
-#define MSG_TYPE_SET(v)			(((v) << 28) & 0xF0000000)
-#define MSG_SUBTYPE(v)			(((v) & 0x0F000000) >> 24)
-#define MSG_SUBTYPE_SET(v)		(((v) << 24) & 0x0F000000)
-
-#define DBG_SUBTYPE_SENSOR_READ		4
-#define SENSOR_RD_MSG			0x04FFE902
-#define SENSOR_RD_EN_ADDR(a)		((a) & 0x000FFFFF)
-#define PMD_PWR_REG			0x20
-#define PMD_PWR_MW_REG			0x26
-#define SOC_PWR_REG			0x21
-#define SOC_PWR_MW_REG			0x27
-#define SOC_TEMP_REG			0x10
-
-#define TEMP_NEGATIVE_BIT		8
-#define SENSOR_INVALID_DATA		BIT(15)
-
-#define PWRMGMT_SUBTYPE_TPC		1
-#define TPC_ALARM			2
-#define TPC_GET_ALARM			3
-#define TPC_CMD(v)			(((v) & 0x00FF0000) >> 16)
-#define TPC_CMD_SET(v)			(((v) << 16) & 0x00FF0000)
-#define TPC_EN_MSG(hndl, cmd, type) \
-	(MSG_TYPE_SET(MSG_TYPE_PWRMGMT) | \
-	MSG_SUBTYPE_SET(hndl) | TPC_CMD_SET(cmd) | type)
-
-/* PCC defines */
-#define PCC_SIGNATURE_MASK		0x50424300
-#define PCCC_GENERATE_DB_INT		BIT(15)
-#define PCCS_CMD_COMPLETE		BIT(0)
-#define PCCS_SCI_DOORBEL		BIT(1)
-#define PCCS_PLATFORM_NOTIFICATION	BIT(3)
-/*
- * Arbitrary retries in case the remote processor is slow to respond
- * to PCC commands
- */
-#define PCC_NUM_RETRIES			500
-
-#define ASYNC_MSG_FIFO_SIZE		16
-#define MBOX_OP_TIMEOUTMS		1000
-
-#define WATT_TO_mWATT(x)		((x) * 1000)
-#define mWATT_TO_uWATT(x)		((x) * 1000)
-#define CELSIUS_TO_mCELSIUS(x)		((x) * 1000)
-
-#define to_xgene_hwmon_dev(cl)		\
-	container_of(cl, struct xgene_hwmon_dev, mbox_client)
-
-enum xgene_hwmon_version {
-	XGENE_HWMON_V1 = 0,
-	XGENE_HWMON_V2 = 1,
-};
-
-struct slimpro_resp_msg {
-	u32 msg;
-	u32 param1;
-	u32 param2;
-} __packed;
-
-struct xgene_hwmon_dev {
-	struct device		*dev;
-	struct mbox_chan	*mbox_chan;
-	struct pcc_mbox_chan	*pcc_chan;
-	struct mbox_client	mbox_client;
-	int			mbox_idx;
-
-	spinlock_t		kfifo_lock;
-	struct mutex		rd_mutex;
-	struct completion	rd_complete;
-	int			resp_pending;
-	struct slimpro_resp_msg sync_msg;
-
-	struct work_struct	workq;
-	struct kfifo_rec_ptr_1	async_msg_fifo;
-
-	struct device		*hwmon_dev;
-	bool			temp_critical_alarm;
-
-	phys_addr_t		comm_base_addr;
-	void			*pcc_comm_addr;
-	u64			usecs_lat;
-};
-
-/*
- * This function tests and clears a bitmask then returns its old value
- */
-static u16 xgene_word_tst_and_clr(u16 *addr, u16 mask)
-{
-	u16 ret, val;
-
-	val = le16_to_cpu(READ_ONCE(*addr));
-	ret = val & mask;
-	val &= ~mask;
-	WRITE_ONCE(*addr, cpu_to_le16(val));
-
-	return ret;
-}
-
-static int xgene_hwmon_pcc_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
-{
-	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
-	u32 *ptr = (void *)(generic_comm_base + 1);
-	int rc, i;
-	u16 val;
-
-	mutex_lock(&ctx->rd_mutex);
-	init_completion(&ctx->rd_complete);
-	ctx->resp_pending = true;
-
-	/* Write signature for subspace */
-	WRITE_ONCE(generic_comm_base->signature,
-		   cpu_to_le32(PCC_SIGNATURE_MASK | ctx->mbox_idx));
-
-	/* Write to the shared command region */
-	WRITE_ONCE(generic_comm_base->command,
-		   cpu_to_le16(MSG_TYPE(msg[0]) | PCCC_GENERATE_DB_INT));
-
-	/* Flip CMD COMPLETE bit */
-	val = le16_to_cpu(READ_ONCE(generic_comm_base->status));
-	val &= ~PCCS_CMD_COMPLETE;
-	WRITE_ONCE(generic_comm_base->status, cpu_to_le16(val));
-
-	/* Copy the message to the PCC comm space */
-	for (i = 0; i < sizeof(struct slimpro_resp_msg) / 4; i++)
-		WRITE_ONCE(ptr[i], cpu_to_le32(msg[i]));
-
-	/* Ring the doorbell */
-	rc = mbox_send_message(ctx->mbox_chan, msg);
-	if (rc < 0) {
-		dev_err(ctx->dev, "Mailbox send error %d\n", rc);
-		goto err;
-	}
-	if (!wait_for_completion_timeout(&ctx->rd_complete,
-					 usecs_to_jiffies(ctx->usecs_lat))) {
-		dev_err(ctx->dev, "Mailbox operation timed out\n");
-		rc = -ETIMEDOUT;
-		goto err;
-	}
-
-	/* Check for error message */
-	if (MSG_TYPE(ctx->sync_msg.msg) == MSG_TYPE_ERR) {
-		rc = -EINVAL;
-		goto err;
-	}
-
-	msg[0] = ctx->sync_msg.msg;
-	msg[1] = ctx->sync_msg.param1;
-	msg[2] = ctx->sync_msg.param2;
-
-err:
-	mbox_chan_txdone(ctx->mbox_chan, 0);
-	ctx->resp_pending = false;
-	mutex_unlock(&ctx->rd_mutex);
-	return rc;
-}
-
-static int xgene_hwmon_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
-{
-	int rc;
-
-	mutex_lock(&ctx->rd_mutex);
-	init_completion(&ctx->rd_complete);
-	ctx->resp_pending = true;
-
-	rc = mbox_send_message(ctx->mbox_chan, msg);
-	if (rc < 0) {
-		dev_err(ctx->dev, "Mailbox send error %d\n", rc);
-		goto err;
-	}
-
-	if (!wait_for_completion_timeout(&ctx->rd_complete,
-					 msecs_to_jiffies(MBOX_OP_TIMEOUTMS))) {
-		dev_err(ctx->dev, "Mailbox operation timed out\n");
-		rc = -ETIMEDOUT;
-		goto err;
-	}
-
-	/* Check for error message */
-	if (MSG_TYPE(ctx->sync_msg.msg) == MSG_TYPE_ERR) {
-		rc = -EINVAL;
-		goto err;
-	}
-
-	msg[0] = ctx->sync_msg.msg;
-	msg[1] = ctx->sync_msg.param1;
-	msg[2] = ctx->sync_msg.param2;
-
-err:
-	ctx->resp_pending = false;
-	mutex_unlock(&ctx->rd_mutex);
-	return rc;
-}
-
-static int xgene_hwmon_reg_map_rd(struct xgene_hwmon_dev *ctx, u32 addr,
-				  u32 *data)
-{
-	u32 msg[3];
-	int rc;
-
-	msg[0] = SENSOR_RD_MSG;
-	msg[1] = SENSOR_RD_EN_ADDR(addr);
-	msg[2] = 0;
-
-	if (acpi_disabled)
-		rc = xgene_hwmon_rd(ctx, msg);
-	else
-		rc = xgene_hwmon_pcc_rd(ctx, msg);
-
-	if (rc < 0)
-		return rc;
-
-	/*
-	 * Check if sensor data is valid.
-	 */
-	if (msg[1] & SENSOR_INVALID_DATA)
-		return -ENODATA;
-
-	*data = msg[1];
-
-	return rc;
-}
-
-static int xgene_hwmon_get_notification_msg(struct xgene_hwmon_dev *ctx,
-					    u32 *amsg)
-{
-	u32 msg[3];
-	int rc;
-
-	msg[0] = TPC_EN_MSG(PWRMGMT_SUBTYPE_TPC, TPC_GET_ALARM, 0);
-	msg[1] = 0;
-	msg[2] = 0;
-
-	rc = xgene_hwmon_pcc_rd(ctx, msg);
-	if (rc < 0)
-		return rc;
-
-	amsg[0] = msg[0];
-	amsg[1] = msg[1];
-	amsg[2] = msg[2];
-
-	return rc;
-}
-
-static int xgene_hwmon_get_cpu_pwr(struct xgene_hwmon_dev *ctx, u32 *val)
-{
-	u32 watt, mwatt;
-	int rc;
-
-	rc = xgene_hwmon_reg_map_rd(ctx, PMD_PWR_REG, &watt);
-	if (rc < 0)
-		return rc;
-
-	rc = xgene_hwmon_reg_map_rd(ctx, PMD_PWR_MW_REG, &mwatt);
-	if (rc < 0)
-		return rc;
-
-	*val = WATT_TO_mWATT(watt) + mwatt;
-	return 0;
-}
-
-static int xgene_hwmon_get_io_pwr(struct xgene_hwmon_dev *ctx, u32 *val)
-{
-	u32 watt, mwatt;
-	int rc;
-
-	rc = xgene_hwmon_reg_map_rd(ctx, SOC_PWR_REG, &watt);
-	if (rc < 0)
-		return rc;
-
-	rc = xgene_hwmon_reg_map_rd(ctx, SOC_PWR_MW_REG, &mwatt);
-	if (rc < 0)
-		return rc;
-
-	*val = WATT_TO_mWATT(watt) + mwatt;
-	return 0;
-}
-
-static int xgene_hwmon_get_temp(struct xgene_hwmon_dev *ctx, u32 *val)
-{
-	return xgene_hwmon_reg_map_rd(ctx, SOC_TEMP_REG, val);
-}
-
-/*
- * Sensor temperature/power functions
- */
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct xgene_hwmon_dev *ctx = dev_get_drvdata(dev);
-	int rc, temp;
-	u32 val;
-
-	rc = xgene_hwmon_get_temp(ctx, &val);
-	if (rc < 0)
-		return rc;
-
-	temp = sign_extend32(val, TEMP_NEGATIVE_BIT);
-
-	return sysfs_emit(buf, "%d\n", CELSIUS_TO_mCELSIUS(temp));
-}
-
-static ssize_t temp1_label_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	return sysfs_emit(buf, "SoC Temperature\n");
-}
-
-static ssize_t temp1_critical_alarm_show(struct device *dev,
-					 struct device_attribute *devattr,
-					 char *buf)
-{
-	struct xgene_hwmon_dev *ctx = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", ctx->temp_critical_alarm);
-}
-
-static ssize_t power1_label_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	return sysfs_emit(buf, "CPU power\n");
-}
-
-static ssize_t power2_label_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	return sysfs_emit(buf, "IO power\n");
-}
-
-static ssize_t power1_input_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct xgene_hwmon_dev *ctx = dev_get_drvdata(dev);
-	u32 val;
-	int rc;
-
-	rc = xgene_hwmon_get_cpu_pwr(ctx, &val);
-	if (rc < 0)
-		return rc;
-
-	return sysfs_emit(buf, "%u\n", mWATT_TO_uWATT(val));
-}
-
-static ssize_t power2_input_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct xgene_hwmon_dev *ctx = dev_get_drvdata(dev);
-	u32 val;
-	int rc;
-
-	rc = xgene_hwmon_get_io_pwr(ctx, &val);
-	if (rc < 0)
-		return rc;
-
-	return sysfs_emit(buf, "%u\n", mWATT_TO_uWATT(val));
-}
-
-static DEVICE_ATTR_RO(temp1_label);
-static DEVICE_ATTR_RO(temp1_input);
-static DEVICE_ATTR_RO(temp1_critical_alarm);
-static DEVICE_ATTR_RO(power1_label);
-static DEVICE_ATTR_RO(power1_input);
-static DEVICE_ATTR_RO(power2_label);
-static DEVICE_ATTR_RO(power2_input);
-
-static struct attribute *xgene_hwmon_attrs[] = {
-	&dev_attr_temp1_label.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_critical_alarm.attr,
-	&dev_attr_power1_label.attr,
-	&dev_attr_power1_input.attr,
-	&dev_attr_power2_label.attr,
-	&dev_attr_power2_input.attr,
-	NULL,
-};
-
-ATTRIBUTE_GROUPS(xgene_hwmon);
-
-static int xgene_hwmon_tpc_alarm(struct xgene_hwmon_dev *ctx,
-				 struct slimpro_resp_msg *amsg)
-{
-	ctx->temp_critical_alarm = !!amsg->param2;
-	sysfs_notify(&ctx->dev->kobj, NULL, "temp1_critical_alarm");
-
-	return 0;
-}
-
-static void xgene_hwmon_process_pwrmsg(struct xgene_hwmon_dev *ctx,
-				       struct slimpro_resp_msg *amsg)
-{
-	if ((MSG_SUBTYPE(amsg->msg) == PWRMGMT_SUBTYPE_TPC) &&
-	    (TPC_CMD(amsg->msg) == TPC_ALARM))
-		xgene_hwmon_tpc_alarm(ctx, amsg);
-}
-
-/*
- * This function is called to process async work queue
- */
-static void xgene_hwmon_evt_work(struct work_struct *work)
-{
-	struct slimpro_resp_msg amsg;
-	struct xgene_hwmon_dev *ctx;
-	int ret;
-
-	ctx = container_of(work, struct xgene_hwmon_dev, workq);
-	while (kfifo_out_spinlocked(&ctx->async_msg_fifo, &amsg,
-				    sizeof(struct slimpro_resp_msg),
-				    &ctx->kfifo_lock)) {
-		/*
-		 * If PCC, send a consumer command to Platform to get info
-		 * If Slimpro Mailbox, get message from specific FIFO
-		 */
-		if (!acpi_disabled) {
-			ret = xgene_hwmon_get_notification_msg(ctx,
-							       (u32 *)&amsg);
-			if (ret < 0)
-				continue;
-		}
-
-		if (MSG_TYPE(amsg.msg) == MSG_TYPE_PWRMGMT)
-			xgene_hwmon_process_pwrmsg(ctx, &amsg);
-	}
-}
-
-static int xgene_hwmon_rx_ready(struct xgene_hwmon_dev *ctx, void *msg)
-{
-	if (IS_ERR_OR_NULL(ctx->hwmon_dev) && !ctx->resp_pending) {
-		/* Enqueue to the FIFO */
-		kfifo_in_spinlocked(&ctx->async_msg_fifo, msg,
-				    sizeof(struct slimpro_resp_msg),
-				    &ctx->kfifo_lock);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-/*
- * This function is called when the SLIMpro Mailbox received a message
- */
-static void xgene_hwmon_rx_cb(struct mbox_client *cl, void *msg)
-{
-	struct xgene_hwmon_dev *ctx = to_xgene_hwmon_dev(cl);
-
-	/*
-	 * While the driver registers with the mailbox framework, an interrupt
-	 * can be pending before the probe function completes its
-	 * initialization. If such condition occurs, just queue up the message
-	 * as the driver is not ready for servicing the callback.
-	 */
-	if (xgene_hwmon_rx_ready(ctx, msg) < 0)
-		return;
-
-	/*
-	 * Response message format:
-	 * msg[0] is the return code of the operation
-	 * msg[1] is the first parameter word
-	 * msg[2] is the second parameter word
-	 *
-	 * As message only supports dword size, just assign it.
-	 */
-
-	/* Check for sync query */
-	if (ctx->resp_pending &&
-	    ((MSG_TYPE(((u32 *)msg)[0]) == MSG_TYPE_ERR) ||
-	     (MSG_TYPE(((u32 *)msg)[0]) == MSG_TYPE_DBG &&
-	      MSG_SUBTYPE(((u32 *)msg)[0]) == DBG_SUBTYPE_SENSOR_READ) ||
-	     (MSG_TYPE(((u32 *)msg)[0]) == MSG_TYPE_PWRMGMT &&
-	      MSG_SUBTYPE(((u32 *)msg)[0]) == PWRMGMT_SUBTYPE_TPC &&
-	      TPC_CMD(((u32 *)msg)[0]) == TPC_ALARM))) {
-		ctx->sync_msg.msg = ((u32 *)msg)[0];
-		ctx->sync_msg.param1 = ((u32 *)msg)[1];
-		ctx->sync_msg.param2 = ((u32 *)msg)[2];
-
-		/* Operation waiting for response */
-		complete(&ctx->rd_complete);
-
-		return;
-	}
-
-	/* Enqueue to the FIFO */
-	kfifo_in_spinlocked(&ctx->async_msg_fifo, msg,
-			    sizeof(struct slimpro_resp_msg), &ctx->kfifo_lock);
-	/* Schedule the bottom handler */
-	schedule_work(&ctx->workq);
-}
-
-/*
- * This function is called when the PCC Mailbox received a message
- */
-static void xgene_hwmon_pcc_rx_cb(struct mbox_client *cl, void *msg)
-{
-	struct xgene_hwmon_dev *ctx = to_xgene_hwmon_dev(cl);
-	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
-	struct slimpro_resp_msg amsg;
-
-	/*
-	 * While the driver registers with the mailbox framework, an interrupt
-	 * can be pending before the probe function completes its
-	 * initialization. If such condition occurs, just queue up the message
-	 * as the driver is not ready for servicing the callback.
-	 */
-	if (xgene_hwmon_rx_ready(ctx, &amsg) < 0)
-		return;
-
-	msg = generic_comm_base + 1;
-	/* Check if platform sends interrupt */
-	if (!xgene_word_tst_and_clr(&generic_comm_base->status,
-				    PCCS_SCI_DOORBEL))
-		return;
-
-	/*
-	 * Response message format:
-	 * msg[0] is the return code of the operation
-	 * msg[1] is the first parameter word
-	 * msg[2] is the second parameter word
-	 *
-	 * As message only supports dword size, just assign it.
-	 */
-
-	/* Check for sync query */
-	if (ctx->resp_pending &&
-	    ((MSG_TYPE(((u32 *)msg)[0]) == MSG_TYPE_ERR) ||
-	     (MSG_TYPE(((u32 *)msg)[0]) == MSG_TYPE_DBG &&
-	      MSG_SUBTYPE(((u32 *)msg)[0]) == DBG_SUBTYPE_SENSOR_READ) ||
-	     (MSG_TYPE(((u32 *)msg)[0]) == MSG_TYPE_PWRMGMT &&
-	      MSG_SUBTYPE(((u32 *)msg)[0]) == PWRMGMT_SUBTYPE_TPC &&
-	      TPC_CMD(((u32 *)msg)[0]) == TPC_ALARM))) {
-		/* Check if platform completes command */
-		if (xgene_word_tst_and_clr(&generic_comm_base->status,
-					   PCCS_CMD_COMPLETE)) {
-			ctx->sync_msg.msg = ((u32 *)msg)[0];
-			ctx->sync_msg.param1 = ((u32 *)msg)[1];
-			ctx->sync_msg.param2 = ((u32 *)msg)[2];
-
-			/* Operation waiting for response */
-			complete(&ctx->rd_complete);
-
-			return;
-		}
-	}
-
-	/*
-	 * Platform notifies interrupt to OSPM.
-	 * OPSM schedules a consumer command to get this information
-	 * in a workqueue. Platform must wait until OSPM has issued
-	 * a consumer command that serves this notification.
-	 */
-
-	/* Enqueue to the FIFO */
-	kfifo_in_spinlocked(&ctx->async_msg_fifo, &amsg,
-			    sizeof(struct slimpro_resp_msg), &ctx->kfifo_lock);
-	/* Schedule the bottom handler */
-	schedule_work(&ctx->workq);
-}
-
-static void xgene_hwmon_tx_done(struct mbox_client *cl, void *msg, int ret)
-{
-	if (ret) {
-		dev_dbg(cl->dev, "TX did not complete: CMD sent:%x, ret:%d\n",
-			*(u16 *)msg, ret);
-	} else {
-		dev_dbg(cl->dev, "TX completed. CMD sent:%x, ret:%d\n",
-			*(u16 *)msg, ret);
-	}
-}
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id xgene_hwmon_acpi_match[] = {
-	{"APMC0D29", XGENE_HWMON_V1},
-	{"APMC0D8A", XGENE_HWMON_V2},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, xgene_hwmon_acpi_match);
-#endif
-
-static int xgene_hwmon_probe(struct platform_device *pdev)
-{
-	struct xgene_hwmon_dev *ctx;
-	struct mbox_client *cl;
-	int rc;
-
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-
-	ctx->dev = &pdev->dev;
-	platform_set_drvdata(pdev, ctx);
-	cl = &ctx->mbox_client;
-
-	spin_lock_init(&ctx->kfifo_lock);
-	mutex_init(&ctx->rd_mutex);
-
-	rc = kfifo_alloc(&ctx->async_msg_fifo,
-			 sizeof(struct slimpro_resp_msg) * ASYNC_MSG_FIFO_SIZE,
-			 GFP_KERNEL);
-	if (rc)
-		return -ENOMEM;
-
-	INIT_WORK(&ctx->workq, xgene_hwmon_evt_work);
-
-	/* Request mailbox channel */
-	cl->dev = &pdev->dev;
-	cl->tx_done = xgene_hwmon_tx_done;
-	cl->tx_block = false;
-	cl->tx_tout = MBOX_OP_TIMEOUTMS;
-	cl->knows_txdone = false;
-	if (acpi_disabled) {
-		cl->rx_callback = xgene_hwmon_rx_cb;
-		ctx->mbox_chan = mbox_request_channel(cl, 0);
-		if (IS_ERR(ctx->mbox_chan)) {
-			dev_err(&pdev->dev,
-				"SLIMpro mailbox channel request failed\n");
-			rc = -ENODEV;
-			goto out_mbox_free;
-		}
-	} else {
-		struct pcc_mbox_chan *pcc_chan;
-		const struct acpi_device_id *acpi_id;
-		int version;
-
-		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
-					    &pdev->dev);
-		if (!acpi_id) {
-			rc = -EINVAL;
-			goto out_mbox_free;
-		}
-
-		version = (int)acpi_id->driver_data;
-
-		if (device_property_read_u32(&pdev->dev, "pcc-channel",
-					     &ctx->mbox_idx)) {
-			dev_err(&pdev->dev, "no pcc-channel property\n");
-			rc = -ENODEV;
-			goto out_mbox_free;
-		}
-
-		cl->rx_callback = xgene_hwmon_pcc_rx_cb;
-		pcc_chan = pcc_mbox_request_channel(cl, ctx->mbox_idx);
-		if (IS_ERR(pcc_chan)) {
-			dev_err(&pdev->dev,
-				"PPC channel request failed\n");
-			rc = -ENODEV;
-			goto out_mbox_free;
-		}
-
-		ctx->pcc_chan = pcc_chan;
-		ctx->mbox_chan = pcc_chan->mchan;
-
-		if (!ctx->mbox_chan->mbox->txdone_irq) {
-			dev_err(&pdev->dev, "PCC IRQ not supported\n");
-			rc = -ENODEV;
-			goto out;
-		}
-
-		/*
-		 * This is the shared communication region
-		 * for the OS and Platform to communicate over.
-		 */
-		ctx->comm_base_addr = pcc_chan->shmem_base_addr;
-		if (ctx->comm_base_addr) {
-			if (version == XGENE_HWMON_V2)
-				ctx->pcc_comm_addr = (void __force *)ioremap(
-							ctx->comm_base_addr,
-							pcc_chan->shmem_size);
-			else
-				ctx->pcc_comm_addr = memremap(
-							ctx->comm_base_addr,
-							pcc_chan->shmem_size,
-							MEMREMAP_WB);
-		} else {
-			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
-			rc = -ENODEV;
-			goto out;
-		}
-
-		if (!ctx->pcc_comm_addr) {
-			dev_err(&pdev->dev,
-				"Failed to ioremap PCC comm region\n");
-			rc = -ENOMEM;
-			goto out;
-		}
-
-		/*
-		 * pcc_chan->latency is just a Nominal value. In reality
-		 * the remote processor could be much slower to reply.
-		 * So add an arbitrary amount of wait on top of Nominal.
-		 */
-		ctx->usecs_lat = PCC_NUM_RETRIES * pcc_chan->latency;
-	}
-
-	ctx->hwmon_dev = hwmon_device_register_with_groups(ctx->dev,
-							   "apm_xgene",
-							   ctx,
-							   xgene_hwmon_groups);
-	if (IS_ERR(ctx->hwmon_dev)) {
-		dev_err(&pdev->dev, "Failed to register HW monitor device\n");
-		rc = PTR_ERR(ctx->hwmon_dev);
-		goto out;
-	}
-
-	/*
-	 * Schedule the bottom handler if there is a pending message.
-	 */
-	schedule_work(&ctx->workq);
-
-	dev_info(&pdev->dev, "APM X-Gene SoC HW monitor driver registered\n");
-
-	return 0;
-
-out:
-	if (acpi_disabled)
-		mbox_free_channel(ctx->mbox_chan);
-	else
-		pcc_mbox_free_channel(ctx->pcc_chan);
-out_mbox_free:
-	kfifo_free(&ctx->async_msg_fifo);
-
-	return rc;
-}
-
-static int xgene_hwmon_remove(struct platform_device *pdev)
-{
-	struct xgene_hwmon_dev *ctx = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(ctx->hwmon_dev);
-	kfifo_free(&ctx->async_msg_fifo);
-	if (acpi_disabled)
-		mbox_free_channel(ctx->mbox_chan);
-	else
-		pcc_mbox_free_channel(ctx->pcc_chan);
-
-	return 0;
-}
-
-static const struct of_device_id xgene_hwmon_of_match[] = {
-	{.compatible = "apm,xgene-slimpro-hwmon"},
-	{}
-};
-MODULE_DEVICE_TABLE(of, xgene_hwmon_of_match);
-
-static struct platform_driver xgene_hwmon_driver = {
-	.probe = xgene_hwmon_probe,
-	.remove = xgene_hwmon_remove,
-	.driver = {
-		.name = "xgene-slimpro-hwmon",
-		.of_match_table = xgene_hwmon_of_match,
-		.acpi_match_table = ACPI_PTR(xgene_hwmon_acpi_match),
-	},
-};
-module_platform_driver(xgene_hwmon_driver);
-
-MODULE_DESCRIPTION("APM X-Gene SoC hardware monitor");
-MODULE_LICENSE("GPL");
-- 
2.35.1

