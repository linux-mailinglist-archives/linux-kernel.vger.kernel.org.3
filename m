Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD51D4D0BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245286AbiCGXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiCGXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:17:31 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAA321BF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:16:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbRbZe6sQLDDgImOXva4ZnczNL2/7VsHuoerujzfjRTR88ELCz+KCNQc6VOi/jvcW4PPMxDndjeUflDPxMoN6qP7W6Fie4gIsSZ9CUBoI6qPFhXBGqQ3x0OWGdg3f0u6ymUeDswdaDTzXVk0FXDl7U5k+80PLjFcb9TKs7w0CpjtWCUjG0ASNVkrBs9tasFNXAZeE4PSDC2ipH9IrB3soHJ20cUHop26f2wTiJ6plWzAIhXY4ug3xWOf+tdLryJhYQAqWOA9+mIPR7LbyAQxlsmeuoMpoaMvtZ9PjqCxR7bv7E56ix91GKpSB5ioRdhzvZDfjkQ3Dro+tEwbuDcaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtpk3ooz2Yx7pfMcooSd/QDSvt/TRBhARH9NT+zNoNY=;
 b=ZlNmOWr/S0aKPFFpzNK7y/dcCsM1DOzp+xSK95sX34rGFs1Cg1CiqBtlJxFBhUs9qF4xgD/wzNGmkXKy7bYS0jkFpJQeR+Xwpl0Q6NMbt/+uAfchLa19PySciYDWda4+upGhdfmyczYolF2beN4D3i0XymBedAdgNnwHDJlIpfdGJmzabIKL4j4da2m8rSsXKZ+lepuPF/+M9LDN0/84bDavTPX9xXOtgQO0qJrz0UHrZzEHgDUAh/i8V3pKxbEAAa7ckRUdVQJfyjN2AeG1GGBHGJMIkzLi+9Nm/Q5fSpyAdke+RJTYs/MOG8hoOU7IvbtGdWQ+HEXXP7SgO2qJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtpk3ooz2Yx7pfMcooSd/QDSvt/TRBhARH9NT+zNoNY=;
 b=MmasjnGY1sEiIp77Zm5IPsfYGLKRktiBpOY/ksD+57iCpRU8yb0YvHpnNVkS6vqzcIImsFI43Xfo7o7sGyRBajcLF2bHn0T9IbyYCmF8pt9MZXWQEgAr3ychCPY1KE+C6cCud6E70exJP7wWF+aCD1EOHRid+Ej9rwxU2B/zxAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TY2PR01MB4043.jpnprd01.prod.outlook.com (2603:1096:404:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 23:16:31 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::e9d6:220e:4c45:8909]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::e9d6:220e:4c45:8909%3]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 23:16:31 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     richardcochran@gmail.com, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: [PATCH net] ptp: idt82p33: use rsmu driver to access i2c/spi bus
Date:   Mon,  7 Mar 2022 18:16:12 -0500
Message-Id: <1646694972-15133-1-git-send-email-min.li.xe@renesas.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BN6PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:404:13e::27) To OS3PR01MB6593.jpnprd01.prod.outlook.com
 (2603:1096:604:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc5bf5c4-acc5-4394-504d-08da0090839c
X-MS-TrafficTypeDiagnostic: TY2PR01MB4043:EE_
X-Microsoft-Antispam-PRVS: <TY2PR01MB40435C9FBB2987F8DA558846BA089@TY2PR01MB4043.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTeP/kwyIxeKA9098ygvEMkPne3J12K2E8dkL5EkP2FQfb7ZoYyrDwA6gqhHp+66VdbNak4WMx2WPDHP6JOkBYfAWzofUHXFm2mXpiN4hDA7bPJPDboXkZpUX9ioddio25vlsQceA20+JqeEQ8/QpE1yAPm7Rn3ZHcOcAHpTVE8/KSBugRkRdNyvBQtiqFRGqat5QcVJhQqB6eur255F296trwH2J2H78yl2evWUGuL0RgoYbXpjgIP7ciaRQFpdZYrkUJIoQUc+Ge6ch9QX0XC85wp9wtnKMPPu6XSrl0c0BRv4n4cMbjTVEND1A9BAxQ1IsKekG5U9R/kcEG5pyXwCEV6EfAIWzozyPTTY2TrbWdpzrDBfBNmmoEzA7ZarCheLzMhvVgqwFlvq8rMSzTQfzNr5L8GXH9OTFaYr/COgID0cyXLOSVor6x/p1kbGs4ndR2RxpIRjfN6/O2NTuYXowL10yRs8teZAybjl5LakterQed+BJB2JC0Pdw878iEwx9jbP9X01WrbidNoTbZ7Jgmu3GzWw4iSI/1uTod7Zi9jWcuxNE1dyYVOzUiPFaJYuGQYQafFxU8oiZA5CDavVPN7kAlvgj7B2Sy33vqwtq7yjpdyIlQUMRT94h18AY66a+ci9Kgs5aN8/eurBYrVN5SssXDsa2DTr+CJ97UTztC889nLvIa9/MgiBZbnundTag2aintOCRVw+Cf7X0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6666004)(19627235002)(66946007)(66556008)(6512007)(66476007)(38100700002)(38350700002)(6506007)(83380400001)(36756003)(316002)(8676002)(508600001)(107886003)(186003)(6486002)(8936002)(2906002)(26005)(52116002)(86362001)(4326008)(30864003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ctQ/pgQnKBU95u2BVVnCuYdOrO51Tc8Y7+hnJHsvQCcWaRX5lgQR24iIxPQ?=
 =?us-ascii?Q?eauA8C4gEMG1F3BUEWKvHQpoU3Jl9OO+2BvGH+cBQG4qrDRq/muD/bVIkFWQ?=
 =?us-ascii?Q?AZW9nfmvYRrug4H5E9dnIfWTEPbZK0TenCJ5os0uTlFaczqjC/LDPUzIEKIN?=
 =?us-ascii?Q?gZdThZRjtE7bGIB3BWm/IotvUxxnEQpAbzh9FaHfbZqvJwBQbOOxHFeqr2ex?=
 =?us-ascii?Q?tP3CYygRJbF8f5vwUBKl5GMBmhAf4w0aoWVUQOGSELxesLXNVD/THQDqxgmZ?=
 =?us-ascii?Q?hBGZHOqSBP0KX0Oca+e+oyxqHTIa7t49jqGfOtn2YXfpXnYu0TlmhYICXK6F?=
 =?us-ascii?Q?11AJ2wKZOq9zMcDuAEW4LhYpfghtkoxYyRyZFlWuCslh7EufkTLU4R3QKmGr?=
 =?us-ascii?Q?J5e8eD3eHquxXvO4lRPAqZJnzlqDRz0D4K7N9HXfhvXYBH29155QtIsADOsZ?=
 =?us-ascii?Q?XyhCHHu5qAdxuCKIUr7DxWCfw4XsoXg3p9eLTdthRf+pdwXkq7XRt37TXpRS?=
 =?us-ascii?Q?saWQpQfGKVk4eMq1hXnleaH43wBOrT6opdr9XgCuVT4T73s1ibkixiLv8/PM?=
 =?us-ascii?Q?rqxLZ/PjbSxs1HpON0GpN6Ei+tzEsN6obWPN57wQRK1O+HCNQJIOikKwR0QW?=
 =?us-ascii?Q?TD1Bn7TQG6LxLY11pvDnYDowl0DV6eUetmGQ9CTkTOdnPeYcWu4XaJwatkBm?=
 =?us-ascii?Q?UWJCkmEFlwkaEz1gGFxmn6JhwotxHYAspdwwRcDKCjshFx5HKhFE5cXJlOlX?=
 =?us-ascii?Q?Yia71NNICFY1GkJn9B5p7GrjqKhFBadHVxcV8YXxy6Czz9J3NsC4uABLtfl8?=
 =?us-ascii?Q?1SpncHBzcj7eqh1qTl1pZCku8ufWzNLaTYLB6hYwC3lY39SwLt4nDuiPX/A8?=
 =?us-ascii?Q?8lFLmdZ44/+5Vw8kzZ202eD24lotD/feRp8GCc5uSBcEAN5Ih8E+nzEezXPQ?=
 =?us-ascii?Q?heDeK9Ezk3s/5dRaTsTSY+AlSAAq50FgU82shEK1A8yeeXsO50TRLZsgSs9E?=
 =?us-ascii?Q?MGfw4x5Sp97bu5FpYdR/pimA5J5p7qhAXNZPzzLZlA4ZfTqRy0MClXQ3pO6+?=
 =?us-ascii?Q?p85Gnr8v2np1ejwxej3FtYtjcKaqCwRGqAfLSQalHwqii1YPRTnVwjoR9bq1?=
 =?us-ascii?Q?gT9xPRY5fZdpsVZkbcU3S63BqpcVzm1t1a3EzSWgcT7ZkmATQJ1U07ExVhUX?=
 =?us-ascii?Q?zUmGFCVcPchuTPrDi5+fOKuD53qEX5pTTHKybd8dcK6iS9O93UJZWeEL6o6Z?=
 =?us-ascii?Q?HQPhhAGaFFVuAIGJu6RH68SD9cwKs6bHHIvO2x8YBz22ChMU6/RYGYGb/sSI?=
 =?us-ascii?Q?vTkkXykdbRBF+ZyEiFjelOo83TDtOtGRsd+4S8vpMRQPn9GCeVpkXp4rHOAx?=
 =?us-ascii?Q?EhdjonvafbL5rRWlKVYvF9n+lG3MBhgT7YDhU+mhSlPcfcwUdHAbFESjTIwK?=
 =?us-ascii?Q?xLQBHYSyYDtAyYYN1lQalsM4jmbZWobJfNLtuaHD6TgkwQuZEFBjE9+/gyHH?=
 =?us-ascii?Q?XQJ6yk8hv1Wzn6NqEBQCKolPcrUZOSI0Y2A6ijARpJXKd3Q5jCyy9iuSd4tv?=
 =?us-ascii?Q?0bUhvYpmnyBLCZCXrFdWerZr9Kzwwwnenxri+8ZNRecmScSAvmO1aj3lFTsQ?=
 =?us-ascii?Q?iHS1xb/Kj9/ibbMwd07vREw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5bf5c4-acc5-4394-504d-08da0090839c
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 23:16:31.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7knm7Y1y4DN7KI14B407+Omc51At67eMmYZHf9Xkdo3h2TCUwUmCCBMegpEHlNy50IoYz7VS3/FdOvIv3kNUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4043
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rsmu (Renesas Synchronization Management Unit ) driver is located in
drivers/mfd and responsible for creating multiple devices including
idt82p33 phc, which will then use the exposed regmap and mutex
handle to access i2c/spi bus.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_idt82p33.c       | 344 ++++++++++-----------------------------
 drivers/ptp/ptp_idt82p33.h       | 151 +++++------------
 include/linux/mfd/idt82p33_reg.h |   3 +
 3 files changed, 129 insertions(+), 369 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index c1c959f..97c1be4 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -6,13 +6,17 @@
 #define pr_fmt(fmt) "IDT_82p33xxx: " fmt
 
 #include <linux/firmware.h>
-#include <linux/i2c.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/timekeeping.h>
 #include <linux/bitops.h>
+#include <linux/of.h>
+#include <linux/mfd/rsmu.h>
+#include <linux/mfd/idt82p33_reg.h>
 
 #include "ptp_private.h"
 #include "ptp_idt82p33.h"
@@ -24,15 +28,25 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FW_FILENAME);
 
 /* Module Parameters */
-static u32 sync_tod_timeout = SYNC_TOD_TIMEOUT_SEC;
-module_param(sync_tod_timeout, uint, 0);
-MODULE_PARM_DESC(sync_tod_timeout,
-"duration in second to keep SYNC_TOD on (set to 0 to keep it always on)");
-
 static u32 phase_snap_threshold = SNAP_THRESHOLD_NS;
 module_param(phase_snap_threshold, uint, 0);
 MODULE_PARM_DESC(phase_snap_threshold,
-"threshold (150000ns by default) below which adjtime would ignore");
+"threshold (10000ns by default) below which adjtime would use double dco");
+
+static char *firmware;
+module_param(firmware, charp, 0);
+
+static inline int idt82p33_read(struct idt82p33 *idt82p33, u16 regaddr,
+				u8 *buf, u16 count)
+{
+	return regmap_bulk_read(idt82p33->regmap, regaddr, buf, count);
+}
+
+static inline int idt82p33_write(struct idt82p33 *idt82p33, u16 regaddr,
+				 u8 *buf, u16 count)
+{
+	return regmap_bulk_write(idt82p33->regmap, regaddr, buf, count);
+}
 
 static void idt82p33_byte_array_to_timespec(struct timespec64 *ts,
 					    u8 buf[TOD_BYTE_COUNT])
@@ -78,110 +92,6 @@ static void idt82p33_timespec_to_byte_array(struct timespec64 const *ts,
 	}
 }
 
-static int idt82p33_xfer_read(struct idt82p33 *idt82p33,
-			      unsigned char regaddr,
-			      unsigned char *buf,
-			      unsigned int count)
-{
-	struct i2c_client *client = idt82p33->client;
-	struct i2c_msg msg[2];
-	int cnt;
-
-	msg[0].addr = client->addr;
-	msg[0].flags = 0;
-	msg[0].len = 1;
-	msg[0].buf = &regaddr;
-
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].len = count;
-	msg[1].buf = buf;
-
-	cnt = i2c_transfer(client->adapter, msg, 2);
-	if (cnt < 0) {
-		dev_err(&client->dev, "i2c_transfer returned %d\n", cnt);
-		return cnt;
-	} else if (cnt != 2) {
-		dev_err(&client->dev,
-			"i2c_transfer sent only %d of %d messages\n", cnt, 2);
-		return -EIO;
-	}
-	return 0;
-}
-
-static int idt82p33_xfer_write(struct idt82p33 *idt82p33,
-			       u8 regaddr,
-			       u8 *buf,
-			       u16 count)
-{
-	struct i2c_client *client = idt82p33->client;
-	/* we add 1 byte for device register */
-	u8 msg[IDT82P33_MAX_WRITE_COUNT + 1];
-	int err;
-
-	if (count > IDT82P33_MAX_WRITE_COUNT)
-		return -EINVAL;
-
-	msg[0] = regaddr;
-	memcpy(&msg[1], buf, count);
-
-	err = i2c_master_send(client, msg, count + 1);
-	if (err < 0) {
-		dev_err(&client->dev, "i2c_master_send returned %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
-static int idt82p33_page_offset(struct idt82p33 *idt82p33, unsigned char val)
-{
-	int err;
-
-	if (idt82p33->page_offset == val)
-		return 0;
-
-	err = idt82p33_xfer_write(idt82p33, PAGE_ADDR, &val, sizeof(val));
-	if (err)
-		dev_err(&idt82p33->client->dev,
-			"failed to set page offset %d\n", val);
-	else
-		idt82p33->page_offset = val;
-
-	return err;
-}
-
-static int idt82p33_rdwr(struct idt82p33 *idt82p33, unsigned int regaddr,
-			 unsigned char *buf, unsigned int count, bool write)
-{
-	u8 offset, page;
-	int err;
-
-	page = _PAGE(regaddr);
-	offset = _OFFSET(regaddr);
-
-	err = idt82p33_page_offset(idt82p33, page);
-	if (err)
-		return err;
-
-	if (write)
-		return idt82p33_xfer_write(idt82p33, offset, buf, count);
-
-	return idt82p33_xfer_read(idt82p33, offset, buf, count);
-}
-
-static int idt82p33_read(struct idt82p33 *idt82p33, unsigned int regaddr,
-			unsigned char *buf, unsigned int count)
-{
-	return idt82p33_rdwr(idt82p33, regaddr, buf, count, false);
-}
-
-static int idt82p33_write(struct idt82p33 *idt82p33, unsigned int regaddr,
-			unsigned char *buf, unsigned int count)
-{
-	return idt82p33_rdwr(idt82p33, regaddr, buf, count, true);
-}
-
 static int idt82p33_dpll_set_mode(struct idt82p33_channel *channel,
 				  enum pll_mode mode)
 {
@@ -206,7 +116,7 @@ static int idt82p33_dpll_set_mode(struct idt82p33_channel *channel,
 	if (err)
 		return err;
 
-	channel->pll_mode = dpll_mode;
+	channel->pll_mode = mode;
 
 	return 0;
 }
@@ -467,7 +377,7 @@ static int idt82p33_measure_tod_write_overhead(struct idt82p33_channel *channel)
 	err = idt82p33_measure_settime_gettime_gap_overhead(channel, &gap_ns);
 
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
 		return err;
 	}
@@ -499,8 +409,8 @@ static int idt82p33_check_and_set_masks(struct idt82p33 *idt82p33,
 
 	if (page == PLLMASK_ADDR_HI && offset == PLLMASK_ADDR_LO) {
 		if ((val & 0xfc) || !(val & 0x3)) {
-			dev_err(&idt82p33->client->dev,
-				"Invalid PLL mask 0x%hhx\n", val);
+			dev_err(idt82p33->dev,
+				"Invalid PLL mask 0x%x\n", val);
 			err = -EINVAL;
 		} else {
 			idt82p33->pll_mask = val;
@@ -520,14 +430,14 @@ static void idt82p33_display_masks(struct idt82p33 *idt82p33)
 {
 	u8 mask, i;
 
-	dev_info(&idt82p33->client->dev,
+	dev_info(idt82p33->dev,
 		 "pllmask = 0x%02x\n", idt82p33->pll_mask);
 
 	for (i = 0; i < MAX_PHC_PLL; i++) {
 		mask = 1 << i;
 
 		if (mask & idt82p33->pll_mask)
-			dev_info(&idt82p33->client->dev,
+			dev_info(idt82p33->dev,
 				 "PLL%d output_mask = 0x%04x\n",
 				 i, idt82p33->channel[i].output_mask);
 	}
@@ -539,11 +449,6 @@ static int idt82p33_sync_tod(struct idt82p33_channel *channel, bool enable)
 	u8 sync_cnfg;
 	int err;
 
-	/* Turn it off after sync_tod_timeout seconds */
-	if (enable && sync_tod_timeout)
-		ptp_schedule_worker(channel->ptp_clock,
-				    sync_tod_timeout * HZ);
-
 	err = idt82p33_read(idt82p33, channel->dpll_sync_cnfg,
 			    &sync_cnfg, sizeof(sync_cnfg));
 	if (err)
@@ -557,22 +462,6 @@ static int idt82p33_sync_tod(struct idt82p33_channel *channel, bool enable)
 			      &sync_cnfg, sizeof(sync_cnfg));
 }
 
-static long idt82p33_sync_tod_work_handler(struct ptp_clock_info *ptp)
-{
-	struct idt82p33_channel *channel =
-			container_of(ptp, struct idt82p33_channel, caps);
-	struct idt82p33 *idt82p33 = channel->idt82p33;
-
-	mutex_lock(&idt82p33->reg_lock);
-
-	(void)idt82p33_sync_tod(channel, false);
-
-	mutex_unlock(&idt82p33->reg_lock);
-
-	/* Return a negative value here to not reschedule */
-	return -1;
-}
-
 static int idt82p33_output_enable(struct idt82p33_channel *channel,
 				  bool enable, unsigned int outn)
 {
@@ -634,18 +523,11 @@ static int idt82p33_enable_tod(struct idt82p33_channel *channel)
 	struct idt82p33 *idt82p33 = channel->idt82p33;
 	struct timespec64 ts = {0, 0};
 	int err;
-	u8 val;
-
-	val = 0;
-	err = idt82p33_write(idt82p33, channel->dpll_input_mode_cnfg,
-			     &val, sizeof(val));
-	if (err)
-		return err;
 
 	err = idt82p33_measure_tod_write_overhead(channel);
 
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
 		return err;
 	}
@@ -673,16 +555,14 @@ static void idt82p33_ptp_clock_unregister_all(struct idt82p33 *idt82p33)
 }
 
 static int idt82p33_enable(struct ptp_clock_info *ptp,
-			 struct ptp_clock_request *rq, int on)
+			   struct ptp_clock_request *rq, int on)
 {
 	struct idt82p33_channel *channel =
 			container_of(ptp, struct idt82p33_channel, caps);
 	struct idt82p33 *idt82p33 = channel->idt82p33;
-	int err;
-
-	err = -EOPNOTSUPP;
+	int err = -EOPNOTSUPP;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 
 	if (rq->type == PTP_CLK_REQ_PEROUT) {
 		if (!on)
@@ -690,15 +570,18 @@ static int idt82p33_enable(struct ptp_clock_info *ptp,
 						     &rq->perout);
 		/* Only accept a 1-PPS aligned to the second. */
 		else if (rq->perout.start.nsec || rq->perout.period.sec != 1 ||
-		    rq->perout.period.nsec) {
+			 rq->perout.period.nsec)
 			err = -ERANGE;
-		} else
+		else
 			err = idt82p33_perout_enable(channel, true,
 						     &rq->perout);
 	}
 
-	mutex_unlock(&idt82p33->reg_lock);
+	mutex_unlock(idt82p33->lock);
 
+	if (err)
+		dev_err(idt82p33->dev,
+			"Failed in %s with err %d!\n", __func__, err);
 	return err;
 }
 
@@ -727,11 +610,11 @@ static int idt82p33_adjwritephase(struct ptp_clock_info *ptp, s32 offset_ns)
 	val[3] = (offset_regval >> 24) & 0x1F;
 	val[3] |= PH_OFFSET_EN;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 
 	err = idt82p33_dpll_set_mode(channel, PLL_MODE_WPH);
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
 		goto out;
 	}
@@ -740,7 +623,7 @@ static int idt82p33_adjwritephase(struct ptp_clock_info *ptp, s32 offset_ns)
 			     sizeof(val));
 
 out:
-	mutex_unlock(&idt82p33->reg_lock);
+	mutex_unlock(idt82p33->lock);
 	return err;
 }
 
@@ -751,12 +634,12 @@ static int idt82p33_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	struct idt82p33 *idt82p33 = channel->idt82p33;
 	int err;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 	err = _idt82p33_adjfine(channel, scaled_ppm);
+	mutex_unlock(idt82p33->lock);
 	if (err)
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
-	mutex_unlock(&idt82p33->reg_lock);
 
 	return err;
 }
@@ -768,29 +651,20 @@ static int idt82p33_adjtime(struct ptp_clock_info *ptp, s64 delta_ns)
 	struct idt82p33 *idt82p33 = channel->idt82p33;
 	int err;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 
 	if (abs(delta_ns) < phase_snap_threshold) {
-		mutex_unlock(&idt82p33->reg_lock);
+		mutex_unlock(idt82p33->lock);
 		return 0;
 	}
 
 	err = _idt82p33_adjtime(channel, delta_ns);
 
-	if (err) {
-		mutex_unlock(&idt82p33->reg_lock);
-		dev_err(&idt82p33->client->dev,
-			"Adjtime failed in %s with err %d!\n", __func__, err);
-		return err;
-	}
+	mutex_unlock(idt82p33->lock);
 
-	err = idt82p33_sync_tod(channel, true);
 	if (err)
-		dev_err(&idt82p33->client->dev,
-			"Sync_tod failed in %s with err %d!\n", __func__, err);
-
-	mutex_unlock(&idt82p33->reg_lock);
-
+		dev_err(idt82p33->dev,
+			"Failed in %s with err %d!\n", __func__, err);
 	return err;
 }
 
@@ -801,31 +675,31 @@ static int idt82p33_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	struct idt82p33 *idt82p33 = channel->idt82p33;
 	int err;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 	err = _idt82p33_gettime(channel, ts);
+	mutex_unlock(idt82p33->lock);
+
 	if (err)
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
-	mutex_unlock(&idt82p33->reg_lock);
-
 	return err;
 }
 
 static int idt82p33_settime(struct ptp_clock_info *ptp,
-			const struct timespec64 *ts)
+			    const struct timespec64 *ts)
 {
 	struct idt82p33_channel *channel =
 			container_of(ptp, struct idt82p33_channel, caps);
 	struct idt82p33 *idt82p33 = channel->idt82p33;
 	int err;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 	err = _idt82p33_settime(channel, ts);
+	mutex_unlock(idt82p33->lock);
+
 	if (err)
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
-	mutex_unlock(&idt82p33->reg_lock);
-
 	return err;
 }
 
@@ -864,7 +738,7 @@ static int idt82p33_channel_init(struct idt82p33_channel *channel, int index)
 static void idt82p33_caps_init(struct ptp_clock_info *caps)
 {
 	caps->owner = THIS_MODULE;
-	caps->max_adj = 92000;
+	caps->max_adj = DCO_MAX_PPB;
 	caps->n_per_out = 11;
 	caps->adjphase = idt82p33_adjwritephase;
 	caps->adjfine = idt82p33_adjfine;
@@ -872,7 +746,6 @@ static void idt82p33_caps_init(struct ptp_clock_info *caps)
 	caps->gettime64 = idt82p33_gettime;
 	caps->settime64 = idt82p33_settime;
 	caps->enable = idt82p33_enable;
-	caps->do_aux_work = idt82p33_sync_tod_work_handler;
 }
 
 static int idt82p33_enable_channel(struct idt82p33 *idt82p33, u32 index)
@@ -887,7 +760,7 @@ static int idt82p33_enable_channel(struct idt82p33 *idt82p33, u32 index)
 
 	err = idt82p33_channel_init(channel, index);
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Channel_init failed in %s with err %d!\n",
 			__func__, err);
 		return err;
@@ -912,7 +785,7 @@ static int idt82p33_enable_channel(struct idt82p33 *idt82p33, u32 index)
 
 	err = idt82p33_dpll_set_mode(channel, PLL_MODE_DCO);
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Dpll_set_mode failed in %s with err %d!\n",
 			__func__, err);
 		return err;
@@ -920,13 +793,13 @@ static int idt82p33_enable_channel(struct idt82p33 *idt82p33, u32 index)
 
 	err = idt82p33_enable_tod(channel);
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Enable_tod failed in %s with err %d!\n",
 			__func__, err);
 		return err;
 	}
 
-	dev_info(&idt82p33->client->dev, "PLL%d registered as ptp%d\n",
+	dev_info(idt82p33->dev, "PLL%d registered as ptp%d\n",
 		 index, channel->ptp_clock->index);
 
 	return 0;
@@ -940,25 +813,24 @@ static int idt82p33_load_firmware(struct idt82p33 *idt82p33)
 	int err;
 	s32 len;
 
-	dev_dbg(&idt82p33->client->dev,
-		"requesting firmware '%s'\n", FW_FILENAME);
+	dev_dbg(idt82p33->dev, "requesting firmware '%s'\n", FW_FILENAME);
 
-	err = request_firmware(&fw, FW_FILENAME, &idt82p33->client->dev);
+	err = request_firmware(&fw, FW_FILENAME, idt82p33->dev);
 
 	if (err) {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"Failed in %s with err %d!\n", __func__, err);
 		return err;
 	}
 
-	dev_dbg(&idt82p33->client->dev, "firmware size %zu bytes\n", fw->size);
+	dev_dbg(idt82p33->dev, "firmware size %zu bytes\n", fw->size);
 
 	rec = (struct idt82p33_fwrc *) fw->data;
 
 	for (len = fw->size; len > 0; len -= sizeof(*rec)) {
 
 		if (rec->reserved) {
-			dev_err(&idt82p33->client->dev,
+			dev_err(idt82p33->dev,
 				"bad firmware, reserved field non-zero\n");
 			err = -EINVAL;
 		} else {
@@ -973,16 +845,11 @@ static int idt82p33_load_firmware(struct idt82p33 *idt82p33)
 		}
 
 		if (err == 0) {
-			/* maximum 8 pages  */
-			if (page >= PAGE_NUM)
-				continue;
-
 			/* Page size 128, last 4 bytes of page skipped */
-			if (((loaddr > 0x7b) && (loaddr <= 0x7f))
-			     || loaddr > 0xfb)
+			if (loaddr > 0x7b)
 				continue;
 
-			err = idt82p33_write(idt82p33, _ADDR(page, loaddr),
+			err = idt82p33_write(idt82p33, REG_ADDR(page, loaddr),
 					     &val, sizeof(val));
 		}
 
@@ -997,36 +864,34 @@ static int idt82p33_load_firmware(struct idt82p33 *idt82p33)
 }
 
 
-static int idt82p33_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int idt82p33_probe(struct platform_device *pdev)
 {
+	struct rsmu_ddata *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct idt82p33 *idt82p33;
 	int err;
 	u8 i;
 
-	(void)id;
-
-	idt82p33 = devm_kzalloc(&client->dev,
+	idt82p33 = devm_kzalloc(&pdev->dev,
 				sizeof(struct idt82p33), GFP_KERNEL);
 	if (!idt82p33)
 		return -ENOMEM;
 
-	mutex_init(&idt82p33->reg_lock);
-
-	idt82p33->client = client;
-	idt82p33->page_offset = 0xff;
+	idt82p33->dev = &pdev->dev;
+	idt82p33->mfd = pdev->dev.parent;
+	idt82p33->lock = &ddata->lock;
+	idt82p33->regmap = ddata->regmap;
 	idt82p33->tod_write_overhead_ns = 0;
 	idt82p33->calculate_overhead_flag = 0;
 	idt82p33->pll_mask = DEFAULT_PLL_MASK;
 	idt82p33->channel[0].output_mask = DEFAULT_OUTPUT_MASK_PLL0;
 	idt82p33->channel[1].output_mask = DEFAULT_OUTPUT_MASK_PLL1;
 
-	mutex_lock(&idt82p33->reg_lock);
+	mutex_lock(idt82p33->lock);
 
 	err = idt82p33_load_firmware(idt82p33);
 
 	if (err)
-		dev_warn(&idt82p33->client->dev,
+		dev_warn(idt82p33->dev,
 			 "loading firmware failed with %d\n", err);
 
 	if (idt82p33->pll_mask) {
@@ -1034,7 +899,7 @@ static int idt82p33_probe(struct i2c_client *client,
 			if (idt82p33->pll_mask & (1 << i)) {
 				err = idt82p33_enable_channel(idt82p33, i);
 				if (err) {
-					dev_err(&idt82p33->client->dev,
+					dev_err(idt82p33->dev,
 						"Failed in %s with err %d!\n",
 						__func__, err);
 					break;
@@ -1042,69 +907,38 @@ static int idt82p33_probe(struct i2c_client *client,
 			}
 		}
 	} else {
-		dev_err(&idt82p33->client->dev,
+		dev_err(idt82p33->dev,
 			"no PLLs flagged as PHCs, nothing to do\n");
 		err = -ENODEV;
 	}
 
-	mutex_unlock(&idt82p33->reg_lock);
+	mutex_unlock(idt82p33->lock);
 
 	if (err) {
 		idt82p33_ptp_clock_unregister_all(idt82p33);
 		return err;
 	}
 
-	i2c_set_clientdata(client, idt82p33);
+	platform_set_drvdata(pdev, idt82p33);
 
 	return 0;
 }
 
-static int idt82p33_remove(struct i2c_client *client)
+static int idt82p33_remove(struct platform_device *pdev)
 {
-	struct idt82p33 *idt82p33 = i2c_get_clientdata(client);
+	struct idt82p33 *idt82p33 = platform_get_drvdata(pdev);
 
 	idt82p33_ptp_clock_unregister_all(idt82p33);
-	mutex_destroy(&idt82p33->reg_lock);
 
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id idt82p33_dt_id[] = {
-	{ .compatible = "idt,82p33810" },
-	{ .compatible = "idt,82p33813" },
-	{ .compatible = "idt,82p33814" },
-	{ .compatible = "idt,82p33831" },
-	{ .compatible = "idt,82p33910" },
-	{ .compatible = "idt,82p33913" },
-	{ .compatible = "idt,82p33914" },
-	{ .compatible = "idt,82p33931" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, idt82p33_dt_id);
-#endif
-
-static const struct i2c_device_id idt82p33_i2c_id[] = {
-	{ "idt82p33810", },
-	{ "idt82p33813", },
-	{ "idt82p33814", },
-	{ "idt82p33831", },
-	{ "idt82p33910", },
-	{ "idt82p33913", },
-	{ "idt82p33914", },
-	{ "idt82p33931", },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, idt82p33_i2c_id);
-
-static struct i2c_driver idt82p33_driver = {
+static struct platform_driver idt82p33_driver = {
 	.driver = {
-		.of_match_table	= of_match_ptr(idt82p33_dt_id),
-		.name		= "idt82p33",
+		.name = "82p33x1x-phc",
 	},
-	.probe		= idt82p33_probe,
-	.remove		= idt82p33_remove,
-	.id_table	= idt82p33_i2c_id,
+	.probe = idt82p33_probe,
+	.remove	= idt82p33_remove,
 };
 
-module_i2c_driver(idt82p33_driver);
+module_platform_driver(idt82p33_driver);
diff --git a/drivers/ptp/ptp_idt82p33.h b/drivers/ptp/ptp_idt82p33.h
index 1c7a0f0..0ea1c35 100644
--- a/drivers/ptp/ptp_idt82p33.h
+++ b/drivers/ptp/ptp_idt82p33.h
@@ -8,94 +8,19 @@
 #define PTP_IDT82P33_H
 
 #include <linux/ktime.h>
-#include <linux/workqueue.h>
+#include <linux/mfd/idt82p33_reg.h>
+#include <linux/regmap.h>
 
-
-/* Register Map - AN888_SMUforIEEE_SynchEther_82P33xxx_RevH.pdf */
-#define PAGE_NUM (8)
-#define _ADDR(page, offset) (((page) << 0x7) | ((offset) & 0x7f))
-#define _PAGE(addr) (((addr) >> 0x7) & 0x7)
-#define _OFFSET(addr)  ((addr) & 0x7f)
-
-#define DPLL1_TOD_CNFG 0x134
-#define DPLL2_TOD_CNFG 0x1B4
-
-#define DPLL1_TOD_STS 0x10B
-#define DPLL2_TOD_STS 0x18B
-
-#define DPLL1_TOD_TRIGGER 0x115
-#define DPLL2_TOD_TRIGGER 0x195
-
-#define DPLL1_OPERATING_MODE_CNFG 0x120
-#define DPLL2_OPERATING_MODE_CNFG 0x1A0
-
-#define DPLL1_HOLDOVER_FREQ_CNFG 0x12C
-#define DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
-
-#define DPLL1_PHASE_OFFSET_CNFG 0x143
-#define DPLL2_PHASE_OFFSET_CNFG 0x1C3
-
-#define DPLL1_SYNC_EDGE_CNFG 0X140
-#define DPLL2_SYNC_EDGE_CNFG 0X1C0
-
-#define DPLL1_INPUT_MODE_CNFG 0X116
-#define DPLL2_INPUT_MODE_CNFG 0X196
-
-#define OUT_MUX_CNFG(outn) _ADDR(0x6, (0xC * (outn)))
-
-#define PAGE_ADDR 0x7F
-/* Register Map end */
-
-/* Register definitions - AN888_SMUforIEEE_SynchEther_82P33xxx_RevH.pdf*/
-#define TOD_TRIGGER(wr_trig, rd_trig) ((wr_trig & 0xf) << 4 | (rd_trig & 0xf))
-#define SYNC_TOD BIT(1)
-#define PH_OFFSET_EN BIT(7)
-#define SQUELCH_ENABLE BIT(5)
-
-/* Bit definitions for the DPLL_MODE register */
-#define PLL_MODE_SHIFT                    (0)
-#define PLL_MODE_MASK                     (0x1F)
-
-#define PEROUT_ENABLE_OUTPUT_MASK         (0xdeadbeef)
-
-enum pll_mode {
-	PLL_MODE_MIN = 0,
-	PLL_MODE_AUTOMATIC = PLL_MODE_MIN,
-	PLL_MODE_FORCE_FREERUN = 1,
-	PLL_MODE_FORCE_HOLDOVER = 2,
-	PLL_MODE_FORCE_LOCKED = 4,
-	PLL_MODE_FORCE_PRE_LOCKED2 = 5,
-	PLL_MODE_FORCE_PRE_LOCKED = 6,
-	PLL_MODE_FORCE_LOST_PHASE = 7,
-	PLL_MODE_DCO = 10,
-	PLL_MODE_WPH = 18,
-	PLL_MODE_MAX = PLL_MODE_WPH,
-};
-
-enum hw_tod_trig_sel {
-	HW_TOD_TRIG_SEL_MIN = 0,
-	HW_TOD_TRIG_SEL_NO_WRITE = HW_TOD_TRIG_SEL_MIN,
-	HW_TOD_TRIG_SEL_SYNC_SEL = 1,
-	HW_TOD_TRIG_SEL_IN12 = 2,
-	HW_TOD_TRIG_SEL_IN13 = 3,
-	HW_TOD_TRIG_SEL_IN14 = 4,
-	HW_TOD_TRIG_SEL_TOD_PPS = 5,
-	HW_TOD_TRIG_SEL_TIMER_INTERVAL = 6,
-	HW_TOD_TRIG_SEL_MSB_PHASE_OFFSET_CNFG = 7,
-	HW_TOD_TRIG_SEL_MSB_HOLDOVER_FREQ_CNFG = 8,
-	HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG = 9,
-	HW_TOD_RD_TRIG_SEL_LSB_TOD_STS = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
-	WR_TRIG_SEL_MAX = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
-};
-
-/* Register bit definitions end */
 #define FW_FILENAME	"idt82p33xxx.bin"
-#define MAX_PHC_PLL (2)
-#define TOD_BYTE_COUNT (10)
-#define MAX_MEASURMENT_COUNT (5)
-#define SNAP_THRESHOLD_NS (150000)
-#define SYNC_TOD_TIMEOUT_SEC (5)
-#define IDT82P33_MAX_WRITE_COUNT (512)
+#define MAX_PHC_PLL	(2)
+#define TOD_BYTE_COUNT	(10)
+#define DCO_MAX_PPB     (92000)
+#define MAX_MEASURMENT_COUNT	(5)
+#define SNAP_THRESHOLD_NS	(10000)
+#define IMMEDIATE_SNAP_THRESHOLD_NS (50000)
+#define DDCO_THRESHOLD_NS	(5)
+#define IDT82P33_MAX_WRITE_COUNT	(512)
+#define PEROUT_ENABLE_OUTPUT_MASK	(0xdeadbeef)
 
 #define PLLMASK_ADDR_HI	0xFF
 #define PLLMASK_ADDR_LO	0xA5
@@ -116,15 +41,25 @@ enum hw_tod_trig_sel {
 #define DEFAULT_OUTPUT_MASK_PLL0	(0xc0)
 #define DEFAULT_OUTPUT_MASK_PLL1	DEFAULT_OUTPUT_MASK_PLL0
 
+/**
+ * @brief Maximum absolute value for write phase offset in femtoseconds
+ */
+#define WRITE_PHASE_OFFSET_LIMIT (20000052084ll)
+
+/** @brief Phase offset resolution
+ *
+ *  DPLL phase offset = 10^15 fs / ( System Clock  * 2^13)
+ *                    = 10^15 fs / ( 1638400000 * 2^23)
+ *                    = 74.5058059692382 fs
+ */
+#define IDT_T0DPLL_PHASE_RESOL 74506
+
 /* PTP Hardware Clock interface */
 struct idt82p33_channel {
 	struct ptp_clock_info	caps;
 	struct ptp_clock	*ptp_clock;
-	struct idt82p33	*idt82p33;
-	enum pll_mode	pll_mode;
-	/* task to turn off SYNC_TOD bit after pps sync */
-	struct delayed_work	sync_tod_work;
-	bool			sync_tod_on;
+	struct idt82p33		*idt82p33;
+	enum pll_mode		pll_mode;
 	s32			current_freq_ppb;
 	u8			output_mask;
 	u16			dpll_tod_cnfg;
@@ -138,15 +73,17 @@ struct idt82p33_channel {
 };
 
 struct idt82p33 {
-	struct idt82p33_channel channel[MAX_PHC_PLL];
-	struct i2c_client	*client;
-	u8	page_offset;
-	u8	pll_mask;
-	ktime_t start_time;
-	int calculate_overhead_flag;
-	s64 tod_write_overhead_ns;
-	/* Protects I2C read/modify/write registers from concurrent access */
-	struct mutex	reg_lock;
+	struct idt82p33_channel	channel[MAX_PHC_PLL];
+	struct device		*dev;
+	u8			pll_mask;
+	/* Mutex to protect operations from being interrupted */
+	struct mutex		*lock;
+	struct regmap		*regmap;
+	struct device		*mfd;
+	/* Overhead calculation for adjtime */
+	ktime_t			start_time;
+	int			calculate_overhead_flag;
+	s64			tod_write_overhead_ns;
 };
 
 /* firmware interface */
@@ -157,18 +94,4 @@ struct idt82p33_fwrc {
 	u8 reserved;
 } __packed;
 
-/**
- * @brief Maximum absolute value for write phase offset in femtoseconds
- */
-#define WRITE_PHASE_OFFSET_LIMIT (20000052084ll)
-
-/** @brief Phase offset resolution
- *
- *  DPLL phase offset = 10^15 fs / ( System Clock  * 2^13)
- *                    = 10^15 fs / ( 1638400000 * 2^23)
- *                    = 74.5058059692382 fs
- */
-#define IDT_T0DPLL_PHASE_RESOL 74506
-
-
 #endif /* PTP_IDT82P33_H */
diff --git a/include/linux/mfd/idt82p33_reg.h b/include/linux/mfd/idt82p33_reg.h
index 129a6c0..1db532f 100644
--- a/include/linux/mfd/idt82p33_reg.h
+++ b/include/linux/mfd/idt82p33_reg.h
@@ -7,6 +7,8 @@
 #ifndef HAVE_IDT82P33_REG
 #define HAVE_IDT82P33_REG
 
+#define REG_ADDR(page, offset) (((page) << 0x7) | ((offset) & 0x7f))
+
 /* Register address */
 #define DPLL1_TOD_CNFG 0x134
 #define DPLL2_TOD_CNFG 0x1B4
@@ -41,6 +43,7 @@
 #define REG_SOFT_RESET 0X381
 
 #define OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
+#define TOD_TRIGGER(wr_trig, rd_trig) ((wr_trig & 0xf) << 4 | (rd_trig & 0xf))
 
 /* Register bit definitions */
 #define SYNC_TOD BIT(1)
-- 
2.7.4

