Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D4528516
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbiEPNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiEPNNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:13:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A11EEE6;
        Mon, 16 May 2022 06:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTkxfwKH3IoVu44LpqInDRGDGsjKIa0TdJox1rPnY4KeatRcC5khwwk9YOYleOuwG17wtbbEywQuq/simYxlxNl6dfc7v5Im88ON2w1t38wnt1pVRuUJZIebA1GWBNloyKP5x1WaTiLTP2pxSyKafABPTNlli03o++z8tjDGPm8wOflUbFxviOqovU0iGwqQAYdu/qxWzf/w2ZkSSvzemv7va2RrAVG0JKWQk5TQDhVGpSzH75QX1n4aX0iQpu4WNqVYUh58MzWkPyr36MC1chrWek+UkdUNl8uxAYvy/CgKigRH6M0afxcnL92syKIBfVu2ZJybkibQWgttOrnUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W11SDcr+LtrZACvtNLZUBBbJ3o/Shj/Nn7qBCKRTL+4=;
 b=Jo8srWAEIRRIlJdkQoVxFlulAl/wUVzsKdRRh+jofmBRP/hkDFuh+TihP8zCUngI0FUZkgUHLkYOA428ohIX4/dxq3pfYzfikWpJe7fxcGs6p+MP4EKYI/IcZQUiaTsEKA7a3wQIwZIUDlA48Sio/IzKfITiXs+7LJ/QeFPadRhaclkfXQwjKl0Qphh0/lXKUm+MVNY7Tmg5rzxmAYj1Mvp8t43UVXzF3kIMZBJ47uxCKob0WKjmg8DmNZ6EFzXkKqC0EMg1wTRK7lo3ishdMb0bWPZcrPpin/aCF50gQyeJp5zbi1c1/f5n9NZV/PL2IYgK0DEZr8woNHK9QJR0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W11SDcr+LtrZACvtNLZUBBbJ3o/Shj/Nn7qBCKRTL+4=;
 b=LblGD9Jek/A0SzP2dTiFDnBP1Dl1ZEIlzymH/dH4zO9xknesgYPKow2vOXUZw4IzihxzmZh6yLTVoajUv7Z/+3c0VtN2YLzqXuLlaXGteqfHaMOIU55JJO1e8pkmUw6V5IcpN89X+0Ado1Pg7+pR9xOO5dhskrA82GQiFCjC8BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SEYPR06MB5112.apcprd06.prod.outlook.com (2603:1096:101:58::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 13:13:42 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:13:42 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] [media] st-delta: Remove unneeded NULL check in delta-v4l2
Date:   Mon, 16 May 2022 21:13:30 +0800
Message-Id: <20220516131330.13970-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd0fd11-7dd7-4200-3105-08da373de623
X-MS-TrafficTypeDiagnostic: SEYPR06MB5112:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB5112E61073EFDD9F5A7D1ECEABCF9@SEYPR06MB5112.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dA+j4zS8k01eGy5eiagOoqg4FoQ4N+ZzSwdFgY7Vl5mJKoINGJ77kjbidEW/UpFDYb36m/A3v4Bed+tGzLjiY9veT6Z71F4EQTeb4HsPnHEOxaANUrxZgerCxZTdKQeWfM8tqZxESWH+li85gSWPS38uqComGxpRgA4bdGhyaGWYvRMDV4u8dAnYKyvzwJquRTQNSR7xcKvX9FCc6d6mqLkV5V+E6x/iXzs+p5htX2PKeNS/ptQutv1ttzEJ0zY/EOCjKkLSW9os8emkWNaqBiRNBT4I/hXFc4ijfCjGbTxVjBtacnks4MKUOVNp/kc8CLLnSy3y1S3H0TT9f8RMvu6aSGku8maAwbiHsuGB7PQwUDlccuaz0dGtM6uEvPUO9qS1H8KsleLK+xC8JWC84OC3ELpkC64V4jFBTap0g+kNGXULGaUDBUEoTZ8IIA/tvEOoJ3wPhTlDFSywu7gikMrgQqkr2P0H4RdGnGHmr4+H0HWQhE6wu0AJlVfHtAo5THewbECF7hi9IZtat5AREhDsUXgXbHnYz7iaIqAA2rW4HzDqIrp+HN8U0e4ysjvkXYm/e9X80ZDWvdYCYHOcYQgQOZpXp4osTbGq78QAkUJ0zLXjV+J6pITfL03KcOKwC5U9flBuBGfb/AWTGJDtyPvql6jHjqYn2QUCV0M5qJx13MBkdqnD6dvq6384484Sgjk0plvj3ydoydJe7NBwbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(110136005)(66556008)(38350700002)(26005)(316002)(8936002)(38100700002)(36756003)(66946007)(6512007)(52116002)(83380400001)(8676002)(107886003)(6486002)(6506007)(508600001)(6666004)(186003)(86362001)(4326008)(2906002)(1076003)(2616005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfLu+4FdO2+75uSmAPfs350YCkC8yLi7KcDO6bPDm1VzuWcv1Fgj9q9UswEv?=
 =?us-ascii?Q?ZMC6daq0fyF5R02MDaCS7bnJixo1myd6Ke7HUW5HWXhtPij8GbzLmwBdlsjD?=
 =?us-ascii?Q?ktQi3KXzOyJBh958MP+7JIRrP++GE7UfaFE8ClQK+B4ldd5tjPtaTOUQNE26?=
 =?us-ascii?Q?UIyMkB7/wVMfXBoOs1RZKp+jTijT6Jp4Yx47Z0IDNqTkXUvPCZxqek91viva?=
 =?us-ascii?Q?xS4VaejImNi9LtTQOLNjZRWgCmPNCH28Vm/wDZJWHLC9JJAPC78HzZmLfNVA?=
 =?us-ascii?Q?SvaOQBD+fwV1Ax+NEN6Z2zZe1ztqLH+EoVNNEDqCSF9/U3g1Jwt8FWOAEwpm?=
 =?us-ascii?Q?aDRvCS2pcojgnCcpYriwWpDfk42B1z5yhUzOkcwhrPtOwuTtz3P4RIXsv9QV?=
 =?us-ascii?Q?9wEgi79aRNMOkRredsiWJBZbSm7YtFlOctdHnbldEeaSpSoTbnWweRV76WFD?=
 =?us-ascii?Q?zDOFHcvDvroTiZB3REqWkKOMWpw+smW1YOzgkKvrtt4x/ERO7sHQEqp7+2dq?=
 =?us-ascii?Q?dOW9rH4t8gIWWFmo09yN5UkYUkvHjGKRjDWjZHZ+whO0HQ45pwzBHphBy3X8?=
 =?us-ascii?Q?JRpx2Chws2gZ0E8NLz21ZtAhPs73GQ2Vnle0sli4VsAd7qRP8hgtlU0eZgIA?=
 =?us-ascii?Q?6sxKNt7W3wyGzHdn8w0PcgPJWFUKxZhI2zMAfqGrAy8+SuU0nQ4peI3QS2Yd?=
 =?us-ascii?Q?yQvluxyPijsx+t+tHKSnssS2BHAq5ro97csobTN6lM1LX7K9Y13AyCiy2evb?=
 =?us-ascii?Q?8Bxolvrk9h1Uw5+qwi5Bc9PU7z/chuo59rKE3Ew8H33Fa5M+bqo+u63P8O0V?=
 =?us-ascii?Q?uIIsOKeiMlAr74+xshXjIKPDL4DiKBk0vW1C2X0PtRi5EuyLzmUpeIGEjPc2?=
 =?us-ascii?Q?4D4+FRVcRKdJ7zl0Wk71MLxwZ1aQgx3q6Hzp6zvfoQSWzAavZhPV5f0Y7T3o?=
 =?us-ascii?Q?KYox9ncgVFIMWEWYYp8hhPl8M2cjvL0CYlKYBc1o30epY3OEuCT36Sn19AKO?=
 =?us-ascii?Q?QjXvWHeDaNfOHlWwXtrOZ6AWm3sfHzU0Qr3yQPxIapg14ibMEt4ci5r+c+9P?=
 =?us-ascii?Q?TQ+9XMoKhVLzZIJdtBV95fpvH6hKzdC51PVBjpUEJMGiNjwqHqLnYKWsJcDc?=
 =?us-ascii?Q?z6CJYUQCksZFVYLouoajigBUa+YQIqsaMNSvrvTOHYF5VSe9UfssgYAWKvHz?=
 =?us-ascii?Q?QoS9TLr2T1+gSx0JmH9qBfhgI/Z/byD95bfa5Tk7iAs1wg7GZ5whHoqjSxr1?=
 =?us-ascii?Q?sP+P+nIwimtlQEKzEUt2LwKCz40DnTLYiWErCkFhOCuwERcx2xWD1S/34NpZ?=
 =?us-ascii?Q?nSYCrgnkKRg9Z2kHhgAk0KoKWKUHHntjzfua0E6x1GkcisJLTms+rR9GYZZY?=
 =?us-ascii?Q?yvgx6HrW290VcsYbXrVk+1B7O6VnCk/3tsoqNcByiFbAXx61SdP/EwrRuOoI?=
 =?us-ascii?Q?/3xbkRabi1pIgC7WwfT1+KatMNoAwpIEblInyKFfrDm71rU8tSPvwhiSL2nd?=
 =?us-ascii?Q?ui59ZFLXajAc8NxBsj7u//gyLl+6siAED9xwKic+gf/7d7Lv+cpvTXcMEF9A?=
 =?us-ascii?Q?QD7kIBpvmzLeDmLkJkVWMe2zcmfNbfd39hcCzwFog9eQBnp5X2BXv4T9Tovu?=
 =?us-ascii?Q?cCCkqKlh4KdWHvqxmhbLlfJn1+rhIjvLKj9uUj03Wj5ocOWkhDqd/txfC9z6?=
 =?us-ascii?Q?ZBYiCdKTUUEDYKQMt1IZ19DDF/hv5ulFuvhcg96o4Tdmx8lRCZ+NOOGYiTY8?=
 =?us-ascii?Q?+6DKT6isYQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd0fd11-7dd7-4200-3105-08da373de623
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:13:42.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uug9WOyxGQxWBxeFLJM2XOFUr7oRcOo+bRIjPSlTxXVcfXKDGKCEhdtEEyy/XrNFm7T31wCPAydfU+A8Jn3xzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5112
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare_enable() already checks NULL by using !clk.
clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL checks before them.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 .../media/platform/st/sti/delta/delta-v4l2.c  | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/st/sti/delta/delta-v4l2.c b/drivers/media/platform/st/sti/delta/delta-v4l2.c
index 420ad4d8df5d..03eaee6d15da 100644
--- a/drivers/media/platform/st/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/st/sti/delta/delta-v4l2.c
@@ -1669,14 +1669,12 @@ static int delta_open(struct file *file)
 	set_default_params(ctx);
 
 	/* enable ST231 clocks */
-	if (delta->clk_st231)
-		if (clk_prepare_enable(delta->clk_st231))
-			dev_warn(delta->dev, "failed to enable st231 clk\n");
+	if (clk_prepare_enable(delta->clk_st231))
+		dev_warn(delta->dev, "failed to enable st231 clk\n");
 
 	/* enable FLASH_PROMIP clock */
-	if (delta->clk_flash_promip)
-		if (clk_prepare_enable(delta->clk_flash_promip))
-			dev_warn(delta->dev, "failed to enable delta promip clk\n");
+	if (clk_prepare_enable(delta->clk_flash_promip))
+		dev_warn(delta->dev, "failed to enable delta promip clk\n");
 
 	mutex_unlock(&delta->lock);
 
@@ -1717,12 +1715,10 @@ static int delta_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 
 	/* disable ST231 clocks */
-	if (delta->clk_st231)
-		clk_disable_unprepare(delta->clk_st231);
+	clk_disable_unprepare(delta->clk_st231);
 
 	/* disable FLASH_PROMIP clock */
-	if (delta->clk_flash_promip)
-		clk_disable_unprepare(delta->clk_flash_promip);
+	clk_disable_unprepare(delta->clk_flash_promip);
 
 	dev_dbg(delta->dev, "%s decoder instance released\n", ctx->name);
 
@@ -1926,8 +1922,7 @@ static int delta_runtime_suspend(struct device *dev)
 {
 	struct delta_dev *delta = dev_get_drvdata(dev);
 
-	if (delta->clk_delta)
-		clk_disable_unprepare(delta->clk_delta);
+	clk_disable_unprepare(delta->clk_delta);
 
 	return 0;
 }
@@ -1936,9 +1931,8 @@ static int delta_runtime_resume(struct device *dev)
 {
 	struct delta_dev *delta = dev_get_drvdata(dev);
 
-	if (delta->clk_delta)
-		if (clk_prepare_enable(delta->clk_delta))
-			dev_warn(dev, "failed to prepare/enable delta clk\n");
+	if (clk_prepare_enable(delta->clk_delta))
+		dev_warn(dev, "failed to prepare/enable delta clk\n");
 
 	return 0;
 }
-- 
2.36.1

