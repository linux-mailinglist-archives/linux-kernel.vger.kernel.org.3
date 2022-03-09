Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2214D3CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiCIWWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiCIWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:22:20 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B11201AC;
        Wed,  9 Mar 2022 14:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvwoEcZTXUwkTskKbkFUYtSXWFnaY3AAShgSUQuSk5+mL1Q4mlnDAJVb1m5z25GPEZuU0aCx2fERa4MICluQD/E94renavZJpxES+lDJm2ocyU98DZ8suAw07O2Xf2c0QgZM9SHGGEadjhWxncHUPtE/eT6oOIRSlbZeosU4ENPpf663c9iJM2prRiOmTBUS4kITCzWwPttTiza5Wl/xTBzfYoIvBBapMWLO2vVqTwSq5xqBt2jLJYgjKQy6UREWt4n80e+7Mo/ZzaQDEGYAIqoTZrQ0WiE8vonXXZl6g2akqhUH+Y9dTqWLQXQN1WmnX7sYCO5izc/19AX3Rn2FOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w6XjxDsTRw2ygrMRaDXzrP9hbU44XmfL5c9KuuUHPM=;
 b=e6zddwOtM5tXV1DN2P9heSi8glpG9SJepyQUlFnMUaNqzjB4shhFeeQyrXY4tNttBU0tp1Z5Nn1JN/7gabfvC8hIxVUIbD2pek6KRd+X7YAe6pEOSxJIqQQ78w1/WOBtfLtNqe7Qm1KS3a1wAimDhu1VwI8pSDGLWbCdccbJ26Los0yBu6nYOoXTQbLKlna0mW8CpCBMMrGERca+CrUTbQ5fVLoY6C09KbcFjjCq5xI/xVHy7GLtlNLFcbda9LuJe8wjpmbkYwJxa56zH+srcEZPOeAiwLz+iT5hergZOo8X4EL8FsOMVMb7L+LlEf8QMhds46nSqjZDroiK4Tl1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w6XjxDsTRw2ygrMRaDXzrP9hbU44XmfL5c9KuuUHPM=;
 b=FTvpc6MFPQUuxfhRghUQSEtrnNEwkWByB4Gf47mrh8tQidWdXZfgisbb6TlLFyXg09HqDPfXZ2D2RM2jRrsAvsLuSXSz3T9QGseUQ2jXvCPhXBqWEL6Q6fKrxzx6JnR8OJINpgycT5GqP5hDD0jlxeTTbJOs5Rgma+YsM67uV2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4512.eurprd04.prod.outlook.com (2603:10a6:803:69::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 22:21:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:21:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V3 1/2] remoteproc: introduce rproc features
Date:   Thu, 10 Mar 2022 07:01:27 +0800
Message-Id: <20220309230128.15856-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309230128.15856-1-peng.fan@oss.nxp.com>
References: <20220309230128.15856-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a8e1ec-14bf-42db-afd0-08da021b21c2
X-MS-TrafficTypeDiagnostic: VI1PR04MB4512:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4512F45C6CBC9BCA06320DFBC90A9@VI1PR04MB4512.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xiss0xhBd1kbiE7mUW4C/+ubZqosKlubsMzFUr84Ve3XXRxF/xZZ5FCSBxH7ZMNEOLEn43vtneqVoFzP6THCPqg8inkkwBXfj0Uvu3ZfzfW0usbGWWhI3ImS7a+5234qbLP7AXlOJqHNWLV9wrFq5up67ki4NGElA4w0FsEcGFVSAACf7OWLSHlGDWHoU+4eYslOJhtVi/zzwvt4V+0TPWvW6+RDp6bqRhgFIOTUx9WDQsRvbkdu2wEoV8aZ914I2Zg3MRLTcHxhyrbWvyyVHdq908aWij8pAiDJ9/UOuzbJM8iPS4vVaO3w453Nb5sb9i5UVfJ71056Ua6+0IEhe309E0HjlIpoJstbQLpgZFRYhwdsaEsgSFg718f/wpwvjTUMcP2urCiogzIEqFneRdNM9ngWPjQHpwzDZS+KYQFVeKyyjfIV2UvErDbgzjUlnNmhwDKCbjBjVebo408jYE8C0Jc2m2vZrYW9zJ+ZYyzQTsOt7Io/oS8dCr2hE9rbwy5KpIXXLWj5AHUMMGghmdZ7qYrXEnKoeyX2m8VxUPIT2iNEuyO/gMR7w5Q0IN/mYK/KFJXw+R6yjcrlCXLx6dZEngk3ZYKVffk/5fKYGUlzP8fqWtrA5EazilBAviI/zAKpjj+Q1o0+HTX2+xA362SFJq/91g+3uuldpDDAddHWLNqLJmxVTuj+7S2rAb+8cKb8kIRkL62O+S+hRd+kNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(2906002)(6512007)(2616005)(26005)(1076003)(186003)(66946007)(66556008)(508600001)(6666004)(6506007)(66476007)(6486002)(4326008)(52116002)(8676002)(86362001)(38100700002)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fcvdy3CgcQ6WhuBAvtySKEL78v0nExhU2xuoiJVqm8rrNIhL8OAkts2UIbCB?=
 =?us-ascii?Q?H0t00WSgYKR5rMDB/1uX3R6DaIDYkim4Okvusx5qmsrwy4nnqseFKDYsABzf?=
 =?us-ascii?Q?FkZOAIpz/pVXLMxFcFhYyU9JZzN1ieHrtfK8ODUAEMAZU+ULMvMJlKxhhtFA?=
 =?us-ascii?Q?ICnK+KR4tewWyZoixtecn82gzWyLvQWUUxrf20w8QZduokTcG84b464MQwFS?=
 =?us-ascii?Q?CAbpCgEIU2hvhtD3R41WIpdB3O2QoXo9l39tSdrls7i8ZSQyBk0N7b58XUNd?=
 =?us-ascii?Q?ubOl7KGXwgm6VmaCpwWPcG1d2qhs5kHfX82f6GeQipVIqcmUS8Yf3hw39vXu?=
 =?us-ascii?Q?9r/9g3nAdQ8pq5t+D14iHO+UxdllUxbglTYuDU6F3kZVDGqlpYVemuCRbhKu?=
 =?us-ascii?Q?BhjAYr3xBDNYxYCTbKTfDzQYDDg+izeslNXS3m1IomQvY9Ttsj11fn6/0TlV?=
 =?us-ascii?Q?2YVe1CcNV+wiaXfeVIp+feqJH9iPPG+wtZd4Q6sVUg/dX2uQhpjH5kccemmt?=
 =?us-ascii?Q?5guEG11KpsmDUnhnkAjvhKgcDEwxN9YmbRaDIlnMzWvRQXACPB4QzJ6Ng9hU?=
 =?us-ascii?Q?OcgsqJb+XuiY2tdRaQnCojZgL4OBGBJp4TqCTGW4coYhP9q/8gt/ZDXwPVeP?=
 =?us-ascii?Q?xhlHhA8xaKAboWFpnS3h9j6tHBRh2KKDTEeFjyyZ7AfVAJucbN6x5WNHqQSD?=
 =?us-ascii?Q?4csokm7xVYWhEwqNVd+sGM0ru2CK5jASNROTVHIh74G3u4EtudibTYLSB7Rd?=
 =?us-ascii?Q?CzCFIXfE/+lwtMZKX9q66GK019NHdnzOwbLo4/aSNHFYuC5cwLjRp3INCsm3?=
 =?us-ascii?Q?rTC6nI61xxsYzuVLZQ3ytQh1QD/KeB5gNKIIrAqbkgz5x9aMFD7dnvBBLuHc?=
 =?us-ascii?Q?gcXT+XwtjWmNQeoTp5a2JDwyCa8AlmwvY3jLbT6fm79N06UlRQsvr8ReksZl?=
 =?us-ascii?Q?yNJ0NccNGQ+yhGqQjXbpJrDsTHbGKyXZ7eW8OOpcly722/abeEC6CN13ISnU?=
 =?us-ascii?Q?mE5B6vJ/CIAoU7/yvtKl4PDUHhxOY3DMh8FJ40iQ44W1s6jpzZqLNYV1NaW9?=
 =?us-ascii?Q?bHDKaji5TEX8ugqemk29t7fZXxmo3GPnq+MfuXp2DAyC29tC+ox/JQdOznET?=
 =?us-ascii?Q?rhhxxuKbYJ2j1WDrQ5oSSd9MaiduN0Xvt2b61V8H21pqOfa89lpkI4RAqdxd?=
 =?us-ascii?Q?RtaxvYi3xoYDaP1zQ42l0DLx4yRL6fgQY+tDwuMPNE9YO/1shZwNouq0VAqT?=
 =?us-ascii?Q?z8kNGiX4oJOhRRPL+YpblwlFI5IgpGsJX3C3Enbra9Dx3y5ySL9jjSIv4VMM?=
 =?us-ascii?Q?WQ11iKogkMOdfyUrKMhfa6Cf7b4GsZbd+P2OSAVZo3Rfx6/Qd29nOvPxkXET?=
 =?us-ascii?Q?BT/YFlPpHtp5O3ZirCmknrS1aD88X/Mx1K7imjhcZ7u+6YWxLcdWen/y8+IP?=
 =?us-ascii?Q?YS8xA7MqYso3HpdHcmtDZoLD6Qs0MdNBHpGKHy4BGEzmlpOGmm0yihqi5W24?=
 =?us-ascii?Q?WEi12Bb63CAyW45eH8rd4fsZvcT8NBXrriPeXcbGQ7LvkUkqR4q0Zf5VUrbC?=
 =?us-ascii?Q?Eb9qI3zTWKWvAREGAUpC/MJf4f4qRnsQjZsFL2mtgdS5capULq+2sC5sWMxT?=
 =?us-ascii?Q?zLpEPv+v1kGQ3SFoW4a/F/4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a8e1ec-14bf-42db-afd0-08da021b21c2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:21:18.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAhsIfM3M/Y0vG937TlhmA5MZCsgJ7C7CtSTW7B/4jXS5Y3NG8kA/pOB58wsqqj4UpxKdqyx/ActKQsN2kfIqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4512
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
flags and let us optimize current code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Resend

V2-version 2:
 New

 include/linux/remoteproc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 93a1d0050fbc..51edaf80692c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -417,6 +417,7 @@ struct rproc_ops {
  *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
+ * @RPROC_CRASHED_ATTACH_RECOVERY: device has crashed and self recovery
  * @RPROC_LAST:		just keep this one at the end
  *
  * Please note that the values of these states are used as indices
@@ -489,6 +490,11 @@ struct rproc_dump_segment {
 	loff_t offset;
 };
 
+enum rproc_features {
+	RPROC_FEAT_ATTACH_RECOVERY = 0,
+	RPROC_MAX_FEATURES = 32,
+};
+
 /**
  * struct rproc - represents a physical remote processor device
  * @node: list node of this rproc object
@@ -530,6 +536,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @features: indicate remoteproc features
  */
 struct rproc {
 	struct list_head node;
@@ -570,8 +577,19 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
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
 /**
  * struct rproc_subdev - subdevice tied to a remoteproc
  * @node: list node related to the rproc subdevs list
-- 
2.30.0

