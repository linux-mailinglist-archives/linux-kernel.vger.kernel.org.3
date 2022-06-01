Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1346653A0CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350580AbiFAJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351173AbiFAJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA414AE26;
        Wed,  1 Jun 2022 02:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyaKKQZ6qp2gtl8imdPkPp69jKNklYQq6CJzSYcaa63HfAqpXJXtfsinlJ+ZmolwagfbYxpegkiBN3z4mmBhAhzYF5q3CiCcajOHnTilyARMhTuetyhFrMI2uyHqrZbkEipWANa/8C4hLzI9j8Sm/MhhpkI3eu/LBGGCEWjIauAdkEnzvHEZsF5jByO6HKGb6T/wi2Dg1bhEWhc9W0RLOhoht5UbetjAtSWnIs0By5Ps+oaDEk3hxmg10jj3WTSJKcWzgZVudXCActj5J3OttrYWM7o058bnFI/2E0IV6rOGjC8bjtta1BfmjmGAQMT5ryLJYLT3ziYAOayb5rPJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMN6I0fkhcwqz4bfTqnYdUPG1Gt0c+m9PEnhVtENL9E=;
 b=PBE5mDQM4eFhjOf09xgBeIHdstbnaR7Ve1uSb5YW+Gn3b9L0icePFPQuhNrSbJK/DQqql+pE3+qNmmpkDXjx1P7ik0n1mNeKwH/Aobo3FPGx3SXsVwrm41jnSu2inxH+l14srkXbleOAPImETFH1ak2US3YOFPdf8LytIQ3RNZScKHOqmYJZpiR6N6I/LBUhQBfxUMfeaKUgObADeSZwukFdE/1z4YAf3F+TMSb0rdF7DtIXnQG+uQPz8WBzRFfqfY3QXdGs0ZAvHQzStux8KKvNcbftUqdilCi41pJ8wKiZ+Bqt1PS8hugnSfpAf+Bbt/GgnaH+vOFZvVslCmnA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMN6I0fkhcwqz4bfTqnYdUPG1Gt0c+m9PEnhVtENL9E=;
 b=H0IaDrLxC5XxZYBvGYSMxQfa4rPcfzEPsXi0YwvVNiPhLyVxdTsJgdcXykf0xKBEfbYwa7iYC4+4JC4urSi2RLp2jp3yxj4L2v9LgJq6/ioQup1YffmUscQNhKxViV1c6Md4QFzQm49ApC+ypJPU3X591gFzEWclFKteGwmDgAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6498.eurprd04.prod.outlook.com (2603:10a6:208:16d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 09:40:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/8] interconnect: add device managed bulk API
Date:   Wed,  1 Jun 2022 17:41:50 +0800
Message-Id: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce703fa-a9d0-467e-1ba4-08da43b2c176
X-MS-TrafficTypeDiagnostic: AM0PR04MB6498:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6498A26F2A57B2D502D0341AC9DF9@AM0PR04MB6498.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ru63DSCij+aNRn3ejPWR/+riKEVlT8uA5kbVoDp49TYseug+kKHNVqasRt5nK1Y+ZZCVli+es4L24n73t75q9e7+nFaN9cTVejm8I0WczwWEkohk66qJqdnGFWIKEF2Aar+NEHGg3v81oV3UxzzFsZrix38inAc9HSh7avAzVlCcpt49aISoxZVE2RTdS6E71r+SvUx5EcZ3WV7Br/Khn9Pi48Pd0hTCJVeFVq+ISwCCySCodn1n+tx40ScO1ehkgmtSljXyz/YmxrkqdmvNpQ+2qJ+FYKc3g6bXKI+OntAmSJaaTWJ9e/+qBuxTatNcWTgtjGiG9jJrtXbYPG8o9ipIpYrWse0b/ov8eOeDD4KsiP2zTX4V22P4nTK9HbPPIntJzWrHIH+tkE1besnhWcyn0TVJWaWJ02cuQhq5QvLVgGLAd05tRclHUqYQn/Jv578s210kKDzi5cHVvK3a6hoEkc4dg7fh7X2IUyAdGVe1x1wqVSkNUdj9YtdU2AGKkeRS0wjwMxsprquKJv8rZqpadDDx/sdF/O3ibLJJ00cUbyhPvo1GyUobDljNHzNhKnvbNE9cMoaizYh4VuAUwFd8N+4jWZSEJCh/Jtda1qwsjQHfaubgIlniOOpm+cS55U7M2Uq9+wrtd238wQAxMoCJgLqB2dz8VvRhmx9um4n2SbHrpR30MSuZ1zwf7opzsVdG5BPposOWpkoA/Ry6OM3Yqwd8D8q6TKtE/D+tLuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(52116002)(2906002)(6506007)(508600001)(316002)(6666004)(6486002)(1076003)(7416002)(86362001)(26005)(2616005)(8936002)(4326008)(66946007)(66476007)(5660300002)(66556008)(38100700002)(38350700002)(186003)(8676002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71L4zzyhThahqsTBvaZ3anw1nrrVGL9pBE9dzz+zD0Ku/ht+5rdiXFwQvNfX?=
 =?us-ascii?Q?Q+5K2yXP4sUqrqTaKHp9eucCyG0GX0yKUSCP6Teu4ygFQINrYquhOgf07j2v?=
 =?us-ascii?Q?+ZGt7AxZ+dLetHwwY+Z2mlRM6NVeMQgnyy2e8WkpYDGfW8t1TijRj1zOiI68?=
 =?us-ascii?Q?b2cUad0JVFUVmwaWDUVMPgiLot+eQZiFeFsZwmkKrP9csZttR+JWZ6g716AC?=
 =?us-ascii?Q?wmB6UkaKSCERfe9hRPnVmj9ver9Sr0aIcErgVzMTKCsLTnoVEeeXgrZt+6fO?=
 =?us-ascii?Q?63gv80SwvFk2KGyZjuTiGK061TQlgqtBlCSFyz+kyU56ynMLLCEGKZgtvFZc?=
 =?us-ascii?Q?k02lpSbEfrWCPZAhIj+ZrCWx9gLF8BM8VdCdv0Fw5IK/HVv0zrH0tpiyVZFz?=
 =?us-ascii?Q?ufpGL+mirjihlbPwDFMIjpDztC0Ht/DJ9UZeqT3WY67ARlV4VPjdoghVSfkM?=
 =?us-ascii?Q?QOMzb5hpQzg0bONPcmdOtDYgAJzH9z7jKZnivhpRaiTVy3ZsBpC9UZafSgee?=
 =?us-ascii?Q?Qa6RIdi0/LXKWKi1vME2Zag4qOjfg5K1OhljkCv4KfGHUZ4iC3FDoOb7e8YD?=
 =?us-ascii?Q?D4ePsh8GKvGlwqdz1KWDXXfT9kw2esZSbiufHuL2ZqJflj2e6TKKfan+H986?=
 =?us-ascii?Q?q4uYvRjj1cbymOzPj9XZH0yehptYMEZzvLPYEKX0tcoejzoydrs129X7kQoZ?=
 =?us-ascii?Q?PuisP6cwI2yeovPrwZ/HWtYlpzEUMqeCmY89Mu1uY6rK5MlT2C0lY3aX29W1?=
 =?us-ascii?Q?5ZJo6Ug5VGMoo+APXtaDAxpXC7td7Jgr6qe7jiQ3S74UihNv8qbsPeLJ3eud?=
 =?us-ascii?Q?U9QuMkVWIkRwpLgpnZbnHHHiEgFX/thP2q4HlkeYthXm+RWnHzd2VVlhRh3u?=
 =?us-ascii?Q?MGfOe9QGtl6sb2lBR8zM+mF62GIJ20r2f6jlYnqqGYBCmi24kpiQRylxVRLB?=
 =?us-ascii?Q?qPtXxuGRjuOUf6dSJ/0PL8x+SmP5bTrU1N0EgvOKQyOYK6eBbVhpoHKNtsS5?=
 =?us-ascii?Q?RDWyNI1NxcosD2haSWuPDVRUC7YYlEhfwMk6wnwiyTyg2nz08K1RFgsuymsR?=
 =?us-ascii?Q?C6KsGNXFdJc0AzLSNoKRPrInhBwRbUZmq1ltS1MQeJ3Mc4IsyapbEz7sQJ+a?=
 =?us-ascii?Q?fve3re/TL7rNNvtGY3KGk/hhwe3g+8tkT9KTtiWB99Yc5rlLZHLo/YVdeOO0?=
 =?us-ascii?Q?tFPPMIzZmBEQPA+w5W4hoU4ZwR7mHs1Z1S6gBSVBVVOIfZxK4My7hRp19JH+?=
 =?us-ascii?Q?b0cUeHKTMb9peQSf0W0qdhc1cKmCJV9j8uDmp1NqWuqlGL0tc5sfwnIKBCfR?=
 =?us-ascii?Q?xVTtn3PrCuU5rm1Ll34Ztr2Bwx0+pajMbmwrED9NpqAhPZaP0apYWti8p9aM?=
 =?us-ascii?Q?F6/4zMPLf9PgSVXDgNXr+m7DKRnJzuVymEZoJrnZTi3FPNaqAgGzvqP64uUh?=
 =?us-ascii?Q?BfRovx2BfBAYT5pffQtKQ6PHm0yhx60Bqn45iRBWtwr51+TisqOCgCml6S20?=
 =?us-ascii?Q?qsxUkpgcow6FpV6vDkJMLy4Tu8mFWIsNAOGhxmfVevjSqF18tKe/hqgCIVxB?=
 =?us-ascii?Q?+PgUlVFuXKUJZqF3FdX7jsaVarmSY/j6Go85numevI2eN1Nz1fsvCDAhFbgt?=
 =?us-ascii?Q?uIVBUn4PpcLXq3SicvQQQ3/D5BbHW7yQMq81YtCrSnr0aoVDzl1AVM6kLpFL?=
 =?us-ascii?Q?AQI55IbVy/3ke9J6bi89jzFG+zTRJm5Sm6UQ9RCtx6Sc4WCScQOwGKxVv40e?=
 =?us-ascii?Q?gUMyqqJJFQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce703fa-a9d0-467e-1ba4-08da43b2c176
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:25.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3GFBVZafQMPc2wOs+Y6y1QH3Xxcq+RtaLscr3VRMpzPDM6kbNawI0nSlIs9gVsl4XpeRTQfJetyRkDOuPyVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add device managed bulk API to simplify driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/bulk.c  | 34 ++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
index 448cc536aa79..4918844bfe0d 100644
--- a/drivers/interconnect/bulk.c
+++ b/drivers/interconnect/bulk.c
@@ -115,3 +115,37 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
 		icc_disable(paths[num_paths].path);
 }
 EXPORT_SYMBOL_GPL(icc_bulk_disable);
+
+struct icc_bulk_devres {
+	struct icc_bulk_data *paths;
+	int num_paths;
+};
+
+static void devm_icc_bulk_release(struct device *dev, void *res)
+{
+	struct icc_bulk_devres *devres = res;
+
+	icc_bulk_put(devres->num_paths, devres->paths);
+}
+
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
+{
+	struct icc_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_icc_bulk_release, sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = of_icc_bulk_get(dev, num_paths, paths);
+	if (!ret) {
+		devres->paths = paths;
+		devres->num_paths = num_paths;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_icc_bulk_get);
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index f685777b875e..1a5fdf049edd 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -44,6 +44,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
 struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_enable(struct icc_path *path);
@@ -116,6 +117,11 @@ static inline int of_icc_bulk_get(struct device *dev, int num_paths, struct icc_
 	return 0;
 }
 
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
+{
+	return 0;
+}
+
 static inline void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
 {
 }
-- 
2.25.1

