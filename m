Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3461A4E4BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiCWDoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiCWDnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:43:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161796CA5A;
        Tue, 22 Mar 2022 20:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgwSPSVO0Mjq7w1k/8/9L5CnHATBQYftXvdsP43thGL+RgpsD+dTKaaQD+yy6P4Q7xnjFqXuDPBKpWCRAIYunhoo6R3cYqEWLvMIwFMc1TLXjBdtY8l1BMcyVh1uNU3vULZ+QGxhzI1MWoTAX6SB56pk7toY5go+BQRo/IJsG3igXfX4NdF2ASJ6uoc2ktK7qLek2UeZim/vh7EprSBqxDSsPXx9KBWOYWCzb3Bv2QDDcsX/whEc3P6D3103rf6gB5kPf+2Nv2BVvaofVd/ROcQ2vkZL3SD9SRUZW/pY8xMPcPHUOHproDR1AdxbCpGUwKr47/iEB+l3JGl531iETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zsBUw2ZzVw/TdhfoZEZuFjx0pPfrRdO/0TtQzBg4QA=;
 b=Ae3JD3fejPw8VH5aDFKoNG+QVPPRGpD2kd5psR6uDl5i4nx2CSlR7iQ9HDYtw/qTYCt10f9Ctmc95NKLRRmXzoY7/MU/oOJnlVw6jNBQz2+oQm/CI/EWsIUJ74VT1uXBNIJ60W6qS3iE1xtIgYv8tgPBxxoyaaQ4kDFMSXcS2hHNxjmF6+MALL+hmkFH17mlJ699/NsxKca3oItMg+OFPjo8nBKnp3QidCJ8CchtmSCZZJHOT/tcVb2s9ks2jMsl6Lc8w5j6IQnG8VqZQbToJcoE5v7me2PtIVepDpRzQAzxZJKQ/h+IdCrMXjrxAal9IJ8nvvIqS1M5NojctYJBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zsBUw2ZzVw/TdhfoZEZuFjx0pPfrRdO/0TtQzBg4QA=;
 b=fAhijZGmfYuh9tvKJ741JHKOiodEejutW74V2T2haZDsZM+D59hfAg7dpl7Z2vwy7jUgk140LC/0QbGPcDF7noquhG0+ciX/044dqoGKNIqNcBDH6MpC1qMaDCBo71deq752XZPYXly8SsG4vhI/pZWIp7+TkyyoIScDnCE7uJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 03:42:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 03:42:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V4 1/2] remoteproc: introduce rproc features
Date:   Wed, 23 Mar 2022 11:44:04 +0800
Message-Id: <20220323034405.976643-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323034405.976643-1-peng.fan@oss.nxp.com>
References: <20220323034405.976643-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6b4f07-a47f-470c-02de-08da0c7f22a8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6868:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6868218453CDDA3F6C48F371C9189@AM0PR04MB6868.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtCQBwYrPVzAsm4Caoq8t0BnySsIIXB2b5l0fa0GlYI4nzIMuDMjvWqJLZZQRiH31+goGUGn/aW+Tvqx7nKMG+5RYRinyQ+JN1guS7sV4r0jtOZuBiIrfM+QFXoJ9jXrJ7ATyesE3R6HPENZW+znm9vUMmSZkR/vlDD0p1N6ez/8DSEp1kGFYjq/G/4GnPjFpmEXvGMIG0oC2XPk5xLdBWUcoI3L2xCwZd6OtejZhBFEHlYxUdP/Rt7q1kKxNSk224GskdDZjTDsJFoFWRLY1BMIpp3LNTtxYpG/aiYN87p7LGYMCC8G90bD/5a3N7klaGWQDVYFMzY95Eu6mo/TiIoL5BJTsovNQAkAEWYcNbZlTt9T8lD5g8orFjh6dK3KpaklKuHUocqHgIBJX3akroZfhRdekoJSdPrrcjhnsKb8ZlCqt0nBZCnwB93sMHxWEQEve0bgcqI30bEwkn99jqoEsPki6AmJSVRJ9lG2gA95PrIdBGQ6ZHr12GLK5ERMQ6VVQ1rrsfp3vGAiaYmvlbxsd1nqgGer8Jj9OggDO13suuUFV5idO2poBT+K5QNA/DyfFb8plPQtYKV3jzHeXzvV/UySpeLv1CplfGwdNgWN00N1PFbK57ir8QlmK4oQqpJIPmX9rl7TL7NV7z2t35cIHsj/Hd3/AuNcORUeK8iziRvMJRNpCsfxt3IfoqrteU2WcJT7UXjp0nHXufsQ/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(38350700002)(38100700002)(26005)(186003)(6512007)(8936002)(2616005)(5660300002)(2906002)(66476007)(66556008)(66946007)(508600001)(6486002)(6506007)(6666004)(316002)(1076003)(86362001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sh9Lh75u7VH/Qrj0y8osjEz3LgGn+LrE52xl2ZS/h75pOGxnPfLLKF7FsyRU?=
 =?us-ascii?Q?CttZdnvNyLXfClD1RXz55g2LlZxRc00Di8qk+FP/kknnEfe6FoMFThuvfMtO?=
 =?us-ascii?Q?uR/buTJVZMm8FV4A/VMsQohrDR79XYTrP9XERbbVtQHquThwThbPafTqRmAW?=
 =?us-ascii?Q?hD7cHcvsRup2kH2ezXQPV/dd5TphUPvq9pp4VTrfCo4yPJlndOXvcibkyJ1O?=
 =?us-ascii?Q?BBwKqG3r3KLn22dibPh5b12pss/3PXvZ63iuvDMAoyKdgna7Q0tP7HwZZX81?=
 =?us-ascii?Q?5pbrGypsF1f95hk1RmDclgqmxmNjr1TEgMOQwjuAlqB2Ozg3bE8rIwJ4tBof?=
 =?us-ascii?Q?OkadMEW0U/M3ZCbBSl2QOHxDC12Q0mxz2q91ERHxuKKTYBLTUp540Mb2Y1es?=
 =?us-ascii?Q?83FOFknE8hkfs5Pr6TcGUOZtS/qIVjZwRfOV8oo9pXyNMaZMzL3pasq6V9Wh?=
 =?us-ascii?Q?qqycAxW2kUSuF5GUT/4I2D/YsEz+bTHD8BQZjZc1gmRAP4elEZcn3rRJ/+8Z?=
 =?us-ascii?Q?C2FcZAUrYiWhNhCDE6422ny4JHAax3lzuGwUXuXWkXoIoH4kFsvoGsUNWPYw?=
 =?us-ascii?Q?amtvxQVy+n5zftl+10maNxAs08U5LlodO2zO2o264HTviCOUF9fn18oElPsD?=
 =?us-ascii?Q?lOb1pdHKGzq2q/W1ItfTYofSdpYGAxTw8pVQ7+FADVi8zZ69eBj4AEAozxkn?=
 =?us-ascii?Q?xm7DmUabAcXtOJPDwkE+z8kDX9yApA+6iPW145b8YVqd+XyYWqWuv6wpWEnW?=
 =?us-ascii?Q?VOIcgBVl7xbnMGo9IdaV0wO9KpJfav3eJve4US1nFmj763oaBQCjp/AW4hXX?=
 =?us-ascii?Q?DShgU14qmfqs8CVmzqOCcVsqrjKV6FbLPc/TuoqyFFbMHGTHrKBEPGM+IUka?=
 =?us-ascii?Q?dadZkp2hZM3Ibfv80d6Y6nD0FMie1JphD7IJWTVg3XZ6wNcjldaIKHyzwZ6X?=
 =?us-ascii?Q?11jABnxkQumnwS8MeC8FHFjZJT4uHQ70b0yllAahx6I7egqleaaZoQugRzlE?=
 =?us-ascii?Q?7tlUUM2chwd7YbWAmUeYrFJtI/dj8m2CDQN7Y0PvHKP2GzvbJAj50muG393k?=
 =?us-ascii?Q?93iNpwvlL4feOw2fCcfH2fQZJB4ajTGS7slND6U73cTL7iuXkq9ilp7oWCgU?=
 =?us-ascii?Q?qMNJFdG5fyu+jx1Xs2DxX6GihOSxGOQTm2FEZZxLeURxN+MHpTWLjpWW1uK9?=
 =?us-ascii?Q?UXtEO5lyL2Zaj84SXAY4wvxawrAJG7/BuVke7x5J2WOgXHVaF49ufSCKffln?=
 =?us-ascii?Q?hpUfKbNuR/HWIQ8C8tt4fs5tIhqaVO3d6szv5zWTeP+U/Yr5NaT34/HAZ3Wq?=
 =?us-ascii?Q?nKapZrnG72OWBcDlQm+GVgo7iKldVavTiVs+h9M9o8djmHWKxdzLCQpzxB0Q?=
 =?us-ascii?Q?BqZqkD8EMIQ+PiZ0OakXLrQUfEEfMsCNEATXpdSdvJsU5G2A4cp5zoUKuaH+?=
 =?us-ascii?Q?eJB1jS9Hs6NMqro2tOUCD5UHvbf7llHQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6b4f07-a47f-470c-02de-08da0c7f22a8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 03:42:21.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Isgqnp6D9P3aLd+C8r2nC6pjLwRQWza4jBHYQtTSvIyCZDb4xIAX0kMn2JjeyAiwWPIpdaCdBTb/ZlQ2l/0zuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

remote processor may support:
 - firmware recovery with help from main processor
 - self recovery without help from main processor
 - iommu
 - etc

Introduce rproc features could simplify code to avoid adding more bool
flags

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_internal.h | 10 ++++++++++
 include/linux/remoteproc.h               |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 72d4d3d7d94d..e9ae743c5587 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -24,6 +24,16 @@ struct rproc_debug_trace {
 	struct rproc_mem_entry trace_mem;
 };
 
+static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
+{
+	return test_bit(feature, rproc->features);
+}
+
+static inline void rproc_set_feature(struct rproc *rproc, unsigned int feature)
+{
+	set_bit(feature, rproc->features);
+}
+
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c943f0a2fc4..7847c6b10a69 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -489,6 +489,11 @@ struct rproc_dump_segment {
 	loff_t offset;
 };
 
+enum rproc_features {
+	RPROC_FEAT_ATTACH_RECOVERY,
+	RPROC_MAX_FEATURES,
+};
+
 /**
  * struct rproc - represents a physical remote processor device
  * @node: list node of this rproc object
@@ -530,6 +535,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @features: indicate remoteproc features
  */
 struct rproc {
 	struct list_head node;
@@ -570,6 +576,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
 
 /**
-- 
2.25.1

