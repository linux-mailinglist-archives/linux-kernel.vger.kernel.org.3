Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AD551EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiFTOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245578AbiFTOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:32:04 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21A4DF66
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMu2xUIXzFgvLBPsUl7mHHaj8RVvmCgNJgcR1Xdg4DNbga/MuaTOApxmRMroXLBeoDHkWi+oReRd5Aq5HIFrXNZXg1SFokQlhoz5wFi5FJgkHbwxLeQIhkt+jkDJHqyysdtAGQRijiUk3CoDcbXZNLT3vbhZk2ND8cpzNdOttL6a8DQYDYpQgsqF2IUHuktE1AkHX5yIxeSIZ5kXBljjrXKaYMuRrBiyqMuKmodh+iff/5A4t1BQKkFWhnrjpiSferKa6rBOpyfwWLnNxIiyfYDpFAmzw8mox9z29GxUTgxxgEUG5V7rwfEEGr1dzkWnf+MlTeQ3rARNKEcpUdTvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdkELTkgoW1SmJBXeGmowTe5qBBm1vW0moKvh9z8ufc=;
 b=O61IBzqYz3tB6kDruLEd6lgaCcypgWiF794QFJWWMhlzUHriyV/PgbPDZiHXwVE7tMHyPGDF/Go0RIke/MshwIH3ET3FeHAmqJ3/2IuIl9qgTlnYbwUkWXmV/7PpZAyafDGOyK7d4KdFuNUBJYJWpvdgATXMqfbGz81KTGIunZ0Tx8RtmKI0tzuIQBItPgOsi1lSV6qnxd8dLTiZqq+GfvYLEVKgncWSM/N+P7mOmEwKBnsAZT2i39Ty65j6rrPShHo5Zy6QAJG2HNhFH0nsq9PRq0ISFfG5ikpSz5C3K0Y/7NYbhh11UR3mKuVeTNeh4yClxtu7Pj+0YLtaWA7PJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdkELTkgoW1SmJBXeGmowTe5qBBm1vW0moKvh9z8ufc=;
 b=OY0dU/Pifl8Cd/DVY0DUluDf+RFMXWhgWnOIGziRquFHrk/BW189uMNoMJYHLurTblpseKNR440E5cp/1cHF8va+caHCPk/e9Ek0yBa6lVuvohrEPhIYMS64XxmimnM+mR+ep8CXTimBGrb9VXkoxhLsQsoFVVyPPym35YpoCto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by VI1PR04MB6190.eurprd04.prod.outlook.com (2603:10a6:803:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 13:46:25 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 13:46:25 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        l.stach@pengutronix.de, peng.fan@nxp.com, shawnguo@kernel.org,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RFC 1/2] regmap: add option to disable debugfs
Date:   Mon, 20 Jun 2022 21:47:57 +0800
Message-Id: <20220620134758.1286480-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620134758.1286480-1-aisheng.dong@nxp.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 137b2cf6-d1f1-4b21-ede8-08da52c34472
X-MS-TrafficTypeDiagnostic: VI1PR04MB6190:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB61902D708F80E0DF45FE04A280B09@VI1PR04MB6190.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBDXnhEUR3pzHO9zKdQySWbDXhbeQZIzV/Z7wUmzyscN7FfuMMZTcL2iEaG07U8NeS3o5ogdXZ3PH08164HKcwr/nXoIs/goVtkoQj0BzJuu7aQaIszoBQLZ6JsJVJbOgX4geOeNXyLih4j5LoHl/Vt4WdiaxI4UjqF8hnczG5Adg7UvXbgdlTEcYFc6tG9EfxkbV2otxW9g45JAAQEW7CO//PWI+bCZ6gMR/AwI99TaTa3gnILKt+x09TuMXS7ilxG+r5zEusYhYB2BHRje1PWezwqE8/f8mBxs9oCXhBIK+4GZ/mvKLLrrC38OVXdc90zSAUYE0cx6ZI0t5vZLFTqOkp40n3VS7Paz4x66siSZlRf1f8DbviLLzLR4uQ/XEykm5+2OVx+5Ahdw6+4E4oAkFj+Y+qcgiPzR/TMz2B4HvRD4zTGYLmycWvzTUkmaFEoMoZY4SB7U6x0SlEE8EC1C4Yzkt86FIpkg/euTBVVVwMcT9VvCyZDhSvZRIlAFgFGVNtTd4FJvooqghk0OTVeZN1/sh4D5JBjtVtuTIhdoknetjvt1V7AVEkqvdH6jz6u++Pjann+Jlv141HOXce23Jp/G2DNq5B7/CnDbcbdzbqopH2uK05pzYVofC7i/i3XQF++L5/echUQqqoWw8Z/GknddtgB1XIyDzjLaNTc2Cwpi6rBbnkTt31iIwqJAq/9+NZmdsKGiEWNB4kNGA5H7NSvKdZToN5d2z2n24dlZBiXQWxJDxe+HXwsYTvHgtfKVNXZra8S+IE6QBmOaFZ5jWCaXX8G8Hc12SO8Sobs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(66556008)(36756003)(66946007)(8676002)(66476007)(83380400001)(4326008)(6506007)(8936002)(186003)(478600001)(316002)(1076003)(966005)(6486002)(2906002)(41300700001)(38100700002)(6916009)(6512007)(2616005)(5660300002)(52116002)(26005)(86362001)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LwqsyMEZSPF5lC1pHzvHI0+naIZfYN8h/EY4JDCAkHKigaq0ix+8AiYTohkc?=
 =?us-ascii?Q?kz4o5BOkdRJjSM3RQObtbqCd5IEVF3X5jlcDs8vmcZFiNuptVPtjSV94aPst?=
 =?us-ascii?Q?wjRve8tjV/LAIPfBx+SRjICwS2sU7/DP3ioFuFyBUEqJKoS0sL2+DtmvTK82?=
 =?us-ascii?Q?Drqh2MRr5S9mEnmwmFxJQN4TQMoVF7OitS1MijpxqjSu3vvdclf8yknr6O98?=
 =?us-ascii?Q?X9AA40PSROIuWUKKibrRtQQ9WaF05nRhN1+ZiM8C89lAUxsNbZbxJsdOHdVd?=
 =?us-ascii?Q?kZWz/YQl59xgbn1lZ/4hymmdbPFDLUgRs6YdlSxBe7wn6/QfdFmjgBgtHllf?=
 =?us-ascii?Q?CU4unvMbp/ReUGNb6sJ475gFZluyp91urxycvF8Gzt2XJ0J2QEmQzoqgLv+w?=
 =?us-ascii?Q?BaJf9mrT2jSbvtKiwkNvMFAUEfFBsxN/NeIEoyYZI71gqVouKQiExHvi+paE?=
 =?us-ascii?Q?RY5q+o1LQnpjJc8DutAVyniAuxx3uK7tVH1ZEY8zqcgWzwgFP4Kd9qTVWzUt?=
 =?us-ascii?Q?xwp9kYrR4J0TCoIpHl+7RqCRU1EUUSvfdr9sGWF8rkvXLG+A+/PFYXTFijOq?=
 =?us-ascii?Q?JomD2sVBt5/98Ai2dmXGADQfGMW9VyoOFJlgT2GOJ1LqUfgMHEQ4IkfGQhUY?=
 =?us-ascii?Q?V9qDybI6RSJkv+Q3F6dCowiYQXb9ZD3X7Sfo8j7QGsVAErjlWBpSuCln49uC?=
 =?us-ascii?Q?ah8pgTw4HMMti29I7r19dYqJi/4EB3CZKBtLR5rQvAUTKHPonggt8VnPYmMc?=
 =?us-ascii?Q?gKUPXQ2vdIQV9wIO1ohaOo147/JSvr+WzcYer+rNa2nvxkEWW+ZJzlrvYEKn?=
 =?us-ascii?Q?qLOEyCls4XqtTQxIjSHzBifrx/kh4b0lCOcirk1iZ6ncIfEYTh/eJVjcnGcu?=
 =?us-ascii?Q?imFn6qtQoXmBwDkRfVRVqDOGRF1+R8mqBi1k20v0Rcs4vvLvVW04Wlo6n4os?=
 =?us-ascii?Q?U7K1lgwnNgfFETta9cZbUKSbKbUJ+/B5WZ18W2WoBhlqqZBEfNB87PNxqKVV?=
 =?us-ascii?Q?t/d7Izw1NMO42Gv7msTKEnKgUna6KBHq6yMttneC8SaLopMBEKjyu04te68w?=
 =?us-ascii?Q?Wvvc2t5MCy3/zuTZQGxq+3TZnyGRAwrRNRmxjh/xuPAE9jTJZbh7yFy6V9ty?=
 =?us-ascii?Q?ZpoYQfBihuU90qWNbnrVRfmLJQL7JrEpu2Mz9Ftu68taX8X72Ml6LgKYAdFe?=
 =?us-ascii?Q?XacklJSAwWPOG/0H/h7rELtNNUtSlPliBE0Y3S25JXjc7NVmr1ApudED4kL4?=
 =?us-ascii?Q?dAQySUFydchbSpBl+sw2lksT0hhI6y0UurWUOVzgJ4Mo7cUB1YVRHqv/9oWw?=
 =?us-ascii?Q?E79GSV/LcA+iJUlZuj8phffEWRPa1LXOVpTAPyPdWdF9ZrXntcuC0PHtqE0k?=
 =?us-ascii?Q?uAX7IBT5axFWtimRHEURi/fPkW/7QuEkOpT/Mt3k5oZCB+YBKL4On1PP9A98?=
 =?us-ascii?Q?athvzOtPGqtHXRp1lLtB6eedr+JVAYEdVvM5kdWbZ/8cmrYQH+/bvpv7XvDQ?=
 =?us-ascii?Q?kyC7+7eBzRg2IDWVIuudb68bRjPIYT8F54G2a2teacFzlIPOFBr7Rx1hzFwv?=
 =?us-ascii?Q?OYJML8xaDSPIn/BGSLH1HSB3BWvinHZ7PRsBdTPvHN+adkxBIptAHGm41LN3?=
 =?us-ascii?Q?GLvgl31a8wGw4OP2edXVobWfqVz95wL0fIoitdsupy9ypOynB9q1i13L4497?=
 =?us-ascii?Q?DbaqEAj4epyp9B1nMwCdrdB/mApUL02K8CeuSKJCfYTnKBQ6qZZn1smbbtGw?=
 =?us-ascii?Q?+5HKXRcyhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137b2cf6-d1f1-4b21-ede8-08da52c34472
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:46:24.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnIQ0xP9UKW7m+Yx3snrLO+XxnZshBSgrt9cCOsHz8kKCI+uRyij94s8okA7tklU63eLNMHvPMnJpGBTbdN6jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap core will create debugfs by default for each instance.
However, it's fairly possible that some devices may not work properly
with regmap registers dump via debugfs due to it may be in suspend
state (e.g. Power domain is off).

Current regmap core does not support runtime pm for MMIO bus.
Although there have been several retries [1] in community but finally
didn't get accepted.

This patch adds an option to allow drivers to claim no debugfs support
due to possible platform limitations.

1. Link: https://lkml.iu.edu/hypermail/linux/kernel/1204.0/01646.html

Cc: Mark Brown <broonie@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 3 ++-
 drivers/base/regmap/regmap.c         | 3 +++
 include/linux/regmap.h               | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 817eda2075aa..82082a5f1729 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -556,9 +556,10 @@ void regmap_debugfs_init(struct regmap *map)
 	 * a mutex or a spinlock, but if the regmap owner decided to disable
 	 * all locking mechanisms, this is no longer the case. For safety:
 	 * don't create the debugfs entries if locking is disabled.
+	 * Or disabled explicitly in driver.
 	 */
 	if (map->debugfs_disable) {
-		dev_dbg(map->dev, "regmap locking disabled - not creating debugfs entries\n");
+		dev_dbg(map->dev, "regmap debugfs disabled - not creating debugfs entries\n");
 		return;
 	}
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index cb0be5e7b100..bb603b4271ef 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -812,6 +812,9 @@ struct regmap *__regmap_init(struct device *dev,
 		map->lock_arg = map;
 	}
 
+	if (config->disable_debugfs && !config->disable_locking)
+		regmap_debugfs_disable(map);
+
 	/*
 	 * When we write in fast-paths with regmap_bulk_write() don't allocate
 	 * scratch buffers with sleeping allocations.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d5b08f4f0dc0..db967a331d36 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -282,6 +282,7 @@ typedef void (*regmap_unlock)(void *);
  * @disable_locking: This regmap is either protected by external means or
  *                   is guaranteed not to be accessed from multiple threads.
  *                   Don't use any locking mechanisms.
+ * @disable_debugfs: Optional, don't create debugfs entries for this regmap.
  * @lock:	  Optional lock callback (overrides regmap's default lock
  *		  function, based on spinlock or mutex).
  * @unlock:	  As above for unlocking.
@@ -383,6 +384,7 @@ struct regmap_config {
 	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
 	bool disable_locking;
+	bool disable_debugfs;
 	regmap_lock lock;
 	regmap_unlock unlock;
 	void *lock_arg;
-- 
2.25.1

