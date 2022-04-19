Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03826506CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbiDSM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiDSM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:58:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A62B183
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXUnWKA0O/oDpCLv9wSAZ6oxmP6bg5q5QRmNbNUIq0IOmCf+ExjrnQtJcK2Wj12A9YGG9L90gT6nIULshGaqvYk/5wKvtgOLZnVY008za5jW/jSXXp8DrReiqlPrE/CwuURhQqfjOnDQjxgEFu6vh2qZ0pd4Q35OcGbsgxK2BpWr/6yv177i0eT5phqysM2fjeMheOQUlZXmWQ99/ZClzhMpg37X0ix418+7cASBkB7Hid8Yz39KoTEBmt8L2WVQ4Hc5zviZ8JtRhdrxq7zwMiLmiQ7KuWB4uVbOn5+Dh0ncyqFiEWAP+f79T9BUYambJFTZlXQOoOg6mjUepMuTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkR/0uA9o742GLsmFXhXaT7TrvMgGEKC8iGu7Dd1Nak=;
 b=EsE5/z2DNuGdpeLkSRCWrToWNaV6ktn7QTXUGbgPZwWNIDlHeSRHJySR2f8J4aEfKSx/Hjf+fp6dh0ZwyNJbZ6565kz9El/OS7/yH0r1wf7VqFRaTGmSgMKGgo941wdeCGm7A7rVLaHf0N/kD5m0lcTFZfuZzDHFN/8YWhWYV7Ce3dyrGVITYIqvFgFMcbwWyqUhfEFw0AOnnxQxTlpjFTinkiY7LC9HTuxpmijI30H1N3M49hT4jmCew9OBucRBxlK3ohUr13j4hXr97ga/fkP0P4ogxYxqGqm7ODhhYmVQ2JgfnSf5dnm87OaYfoWpHU2jTPK75lDcEWB7u1CuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkR/0uA9o742GLsmFXhXaT7TrvMgGEKC8iGu7Dd1Nak=;
 b=MU1iIG/v9enKWbcK6Eu8oxwgaO9f2wS4sQ4nugMasxgWC+t+Gx1A3mGhaQZJ+ZEWEy5oye5LmL91pfzi7ocLZsK+iTTtSdh4j9m7/ioISNClFQp0VAvcctDOjA6z4Aj+crJLTOLs3O/vUm5h7uo+zhFqHN0Tkk/kygOU5W1t+fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by DB7PR04MB4954.eurprd04.prod.outlook.com (2603:10a6:10:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 12:55:22 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 12:55:22 +0000
From:   Li Jun <jun.li@nxp.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
Subject: [PATCH v3 1/2] extcon: ptn5150: add queue work sync before driver release
Date:   Tue, 19 Apr 2022 20:44:08 +0800
Message-Id: <1650372249-10787-1-git-send-email-jun.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dae9e084-d058-4ca8-58f1-08da2203dd9b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4954:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4954F1334C0CA26624109C7889F29@DB7PR04MB4954.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dATlusac5LrTaTtM7YuCqIRkl/lHQypNggHmcvvN+TjKoXzxLgqwhCKMS5rUlqsIdy40Yi0kP6U++Tj7sDGG/sTrQxkG8sI3jtfa7JeyUcVzerkQ9ZK+RMiufaYQDVyhchkq/xUP6tq8M9Tb3xO1v2urDjEqk8MJaQRr5HeU47gSRVk7uSbf754UsogO0qZGLZEDghYDp4BMllaErigJHHYwyF2IzSUiLq3WiEmg/2tDmcR7s1YEOy7E0oaQmPpnngHbN+L4Ba4mUuTaIuTE9gxdedFbKzg/mvgJBGAF9O3PcKNc1fOEyCBX5bI4fa3oxoTAGhBvUYP6jZ9DVqw04mwT95JhXZJtamYZbxFRDN1dSfbwm0ZoxMwTwUF6z3aRZVP5hJaHpuomVcDtGfEFb8TKjxHZhoRSIIrevpRP1XS7fJnLNLKE2dbYl4YMHoUVxyE524CkeQPjV9s5vFHGrmzY5NdeqsyCSWSNTwgYE6VND3ZcLTEdnBA2tNZxDiYSzjHEqSVW4ExG3qul6min6N+75CCBM11140Ghk1XmoBZqCgMea331WbXUk+QndN1AFCyqbBa/Up/Qx8GTr6HxEnGPStK7x4v/4TEjAPOWrHIM5SPmcWYk7edTd6A1DVMwrv9Cg+nrjr+Q2O6JKj+VITyjFuEAyu3homZNfErzmgRBzSf6giaS+Johaqs1s/PpO8o1XaWpj7EDKzYavGyRTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(6512007)(8936002)(6506007)(508600001)(316002)(6486002)(4326008)(52116002)(8676002)(66946007)(66476007)(6666004)(66556008)(86362001)(38350700002)(38100700002)(186003)(36756003)(83380400001)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OWFJQ3oQW/Lzy2Is3ARS5yIz7zUEOeEz8H3QcXRNHgq0knEf9aIPnxHuPhFl?=
 =?us-ascii?Q?iFMyE+Sg6MPON6tRkuBsjKmheduy3oQceen63KJHnMj4YKajDGfhRkhOkSru?=
 =?us-ascii?Q?5EVJqaefLOEDO+epqp5HNRdbGHd7D8nFjoj0BWtD5WBXgeXtAZiHvQKXHenU?=
 =?us-ascii?Q?G/iobnhIYO3r0OhWslhNAAmpGxzasWsjXJVqopoK90XVznrg0cOrRJmsIei5?=
 =?us-ascii?Q?yoHh8BZJUjcZvmafKLP6fIrKiasBM2HiqV3ms5xtK5smUo9Rc0oZ5/quDjyd?=
 =?us-ascii?Q?IX7D0suBWY5wrzcp61qVddh95mX2rLV3TwSIEamZvjDQ5I9TwTka9rVrvPK0?=
 =?us-ascii?Q?70LNzITYHFwOWuX7KnP0lv01J1Rw1mvnTlPtZHKd8xQ0HQX2x7DMmvkWDwKf?=
 =?us-ascii?Q?tGau5R42BMvTU6sjpgBQIp9zPuSyjKTTerRDwtx8nrkTTNIe+TKAAfo4MUvh?=
 =?us-ascii?Q?Rv+UMpbdKg4S/A5ZENh6IC5hzMqVa2h90dq8NOMfiw5hegLG4UKJsqUgNkCm?=
 =?us-ascii?Q?G9m5rS7zCgQOKNTOzao8n5DTvpasGLKHLs6648VbeioRwgWa2UsyGG4fbEAL?=
 =?us-ascii?Q?MIK5zlr2sfNFHG0Xmg20Y+6wEING3OaiGz5428nADRjp/GY46D7IN91Q4dw4?=
 =?us-ascii?Q?j5eS/BAFuksRKNlIoFWNRBe2zLA1z/l/cmRovt+pJO8nKAwJklZ/S9nRyfji?=
 =?us-ascii?Q?OrrtiFEkGRSsyQRjlxGtCVt7pZMQYYfmob+2KT/Ff0mS4Ty7Q/f35dU+8btM?=
 =?us-ascii?Q?FFAmeaf3G5NA5wdg1YjmdfXdxzSNVD7OWPTkx26uK2fIhYZBsG63Zm5lbJpk?=
 =?us-ascii?Q?s4VWUDNzEgmVQLuYGNbP87HOqXJkWas7A5lX1ON0GKypgQv6Bp/rCIfrlxQC?=
 =?us-ascii?Q?qnmSpr/qbWaBCyzKs8kjKw7eVkge++67ye2y+vVqOL2lla1ATx+VT4HLHfH2?=
 =?us-ascii?Q?ZkxwodeBwwKEtABACwsaIm2EoroqZDYohkgVPDSpDO1c6bznjSYbWthtDqeT?=
 =?us-ascii?Q?wnvM6oul/ZRpPQEkOVqmbW+y/97I1LPWNVdMtkeozBwQfshqRszIOcgUWx22?=
 =?us-ascii?Q?xKvIN0C9nIUVRvJLGcia4z1WlfLOouYaSzPe+5rO/Ry7VVKErNefLRxSdUOc?=
 =?us-ascii?Q?9FK9tSHWWaqtLOxEBSRDXz9Ca0ZG4wr3S8MnQ9tzUbWw0ENpNOI8dp9lktN8?=
 =?us-ascii?Q?oa1d7/CL7K6tftJGpjqh7C/WG8hl05wkGKpLFi1kvNu7f4etdS9kc/QoMUrO?=
 =?us-ascii?Q?VSMH3unvkYbQRtHxzZKkxV/TDUoC34koTGFivP1ixhvDP10zUw8DjzYJRDCf?=
 =?us-ascii?Q?4dZydifJVoRTK1M1AIyKiWg4GLjzxgC5L9Jo2rbRCGTkUGa7XPIflBfahLdN?=
 =?us-ascii?Q?DOZE1XybYtKqTIbZMxYU3CrTsA1TKySlNjgxnviF1eedZWPDHYC5VDX+wvWW?=
 =?us-ascii?Q?XMBAigRQDxfjUaH7B0ZdpdemmKNnvBLpPxj0FSeG2bLRb5CvFktBjZxXxHTH?=
 =?us-ascii?Q?YRFUs741Vcxr2B0elzoyTnswGR0IZyFKsL+YgKVXEOy0z/uBZ3ZFaImDqIpp?=
 =?us-ascii?Q?HVkhGP87XD82GqrhNaZzzDI7U/iOghz6Jbsd5SwMsVBhyAR5z2dnJpUpMd3A?=
 =?us-ascii?Q?RlVCd06vUx4+27lxQF1E6gVJ3k2Kb+2JEr3phRs+S3+nGZWIAj8aUIuM1JEq?=
 =?us-ascii?Q?J4gUvVadDqHJZUEAdLz8SsT/lyWKGWwwvwqzPb+CES0VztCULSfwHu5y4gNC?=
 =?us-ascii?Q?/820KrkO4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae9e084-d058-4ca8-58f1-08da2203dd9b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 12:55:22.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8WvFJKz2cFy/hVTuV4qd7Oy644Z62lgsRgnRW9mpR/oNtAR9anISsQlUw3Ptq+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device managed action to sync pending queue work, otherwise
the queued work may run after the work is destroyed.

Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Li Jun <jun.li@nxp.com>
---
change for v3:
- Add Fixes and R-b tag.

 drivers/extcon/extcon-ptn5150.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 5b9a3cf8df26..2a7874108df8 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -194,6 +194,13 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 	return 0;
 }
 
+static void ptn5150_work_sync_and_put(void *data)
+{
+	struct ptn5150_info *info = data;
+
+	cancel_work_sync(&info->irq_work);
+}
+
 static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -284,6 +291,10 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return -EINVAL;
 
+	ret = devm_add_action_or_reset(dev, ptn5150_work_sync_and_put, info);
+	if (ret)
+		return ret;
+
 	/*
 	 * Update current extcon state if for example OTG connection was there
 	 * before the probe
-- 
2.25.1

