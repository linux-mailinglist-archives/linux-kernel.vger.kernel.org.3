Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BFF4D0149
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbiCGOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbiCGOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:33:21 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB931360
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHv6XbBT10V6ys7QcNyw4SndyVlcesZduWmQTzxu1SaiAI9/noLWPDqSvoinSUUzhX5nuHguV6VPfZD+gksyVvu5aJsuLDxs5Xrqi3DYoDwPvY89HQYpmwUKT3Sh7IzosyHfekdcd4zRbeO2hOeB5A8toqeaTviR2dP/KJQmFxj5qLKs3U2FalcghytQL9YwSREh618UCwJTymIPw4MwiwVQGpe/IGLmSKmxLC2I6GuG/GPjS/VYH7OnwtTgl+gDS6FFySVp/L+ScCsjIuPixFSvBgfB48LLFTpbgwNl74+ltRX5Z6SoTADOd3huw/qPfowtoDhLKQBY3M45r/+5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diTjgBGPncoJwBHe+9NDm/od+MBbyK06HlZStJU1uIM=;
 b=ZouipMtVm3Pdxe5gvO61LDVlngv3qwVX+UcEYcNG8yx0Afz9NLL5dxnegFX2Q2Wqn6upIwv2nKUhoJJp5bOTibPZ8SMK6ur+xT0nANiU3cRREZsSQH7+ai9kNAI5I8D0N74cUeMIsgtweYpvCPXF2MzUQADRiiV6sRGL7u3+tRlaUQdwYrC71UEF7pv/24XhC5ZfyzPgxb8g4cv2fiMWXALiTheGairqdJg2opXQ3BRbo6DPGa7nn7a/wO8MnRYRAa0tLPBdRZrOTvpppjFQcLEJF85o5U8o6QvssNwlupCSoPRgmmfjuRtdXT4kGueG9Yn7XfqPJc3iwiYrRiSrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diTjgBGPncoJwBHe+9NDm/od+MBbyK06HlZStJU1uIM=;
 b=GeL0OVm/KAFVRi6yXnYkUtvRq9tCGZj7dw1GD9t/A5onzB2fXS5PcefvpZXXHnIYP8xO0HfKvLTzj19XS6bwQ1n7nywTdik2DZLyKXt9TTtF1rTb5qWe7N4HORsmoUzEZb+SFmM8sCrHsgnILe8HYYkG0UNHtRI/lWF4z1B8npYti/XCPFsDsE9eVqJrYmOWGNATWDJDipWb1drJ4glv8lcnlnn+sy+DTQ40NdTnvH8bBScEPErdfDlPO5S4xUPmDwJiqrC4sOm5PYyDTblIVt9nn+ytS8pI3o9DBaJ2h6W15eIW1/6c0V8FuEiMQT69P8YXtYJd5lor8wmC0TgIxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
 by HE1PR08MB2922.eurprd08.prod.outlook.com (2603:10a6:7:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.21; Mon, 7 Mar
 2022 14:32:22 +0000
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63]) by AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:32:22 +0000
From:   Alifer Moraes <alifer.m@variscite.com>
To:     linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, han.xu@nxp.com,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        pierluigi.p@variscite.com, richard@nod.at, vigneshr@ti.com,
        Alifer Moraes <alifer.m@variscite.com>
Subject: [PATCH] mtd: rawnand: gpmi: add support for legacy-bch-geometry
Date:   Mon,  7 Mar 2022 11:32:02 -0300
Message-Id: <20220307143202.28474-1-alifer.m@variscite.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP2P215CA0044.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:102:2::30) To AM9PR08MB6999.eurprd08.prod.outlook.com
 (2603:10a6:20b:41a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5296dcdc-8036-42bf-17b7-08da00474a86
X-MS-TrafficTypeDiagnostic: HE1PR08MB2922:EE_
X-Microsoft-Antispam-PRVS: <HE1PR08MB29224F2A386D02E238C6473087089@HE1PR08MB2922.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: konwxPuLM6KI3RbZ2p1eUZ2NtqJVNkPdkD9CRxkVPpDs9QUIRVE0C+VSVE7/YJGdY2f3+7AvXw5rSPmy7Ma1csuXiyaBRqm2RqVlp3Vu4Ek46AhKtoOjaoGfECFm5Kmb+15ng1hI1b+BU9KVCPbFbwl6cbAOTKiXx5aDi+19ZUeUDWDyDU5dHOX2d6prAo2c1zn20Y30J0ih2+lJp401VwbCI5m1pqZm4kkaeatVF+Y11+mW8hKNqusJCPark7C0RFPUnHkRbBAHP+qayctjKrQ6a5s5O3UorfOvxCYFA90Q5ZTzy9gWC3HeCeRetXFbzPzX2I4aio6PBsXTbF+FNlu0+x4bfIi4PIyVhJsbsxot6k5RKknXdsJ1tYr93PPMA3U23ViqGgogEIKQJDlp2pHNBkYfEVTxL1MpAHbLtMdS+AydqwE875QE6n5ZZfB5sO/IithvehqeWMbsfcIhn7lZMNsTSaCRIlK4wISss+2FDtrCE2TO+2defR9Uv7plvy/WjRPBN8rmMz5aHWXQqCQZ1AvKsqk+8NW8KpYPAeaA2c4ojSy/6SiRzvjYFDdIfRywnhC8E2bcjfN3M5clm6dLILrRc8gCI9VMZ0TaIWp2fC6h4x2rS2l7vc9AvdNqdYsyr/PKKXwbC2mUQfsUqrMz2406R7ykpda/UETnwQKMaEdLdjoxRTK+jzBDDnhqkgovct06dbCNzFcv+xbaHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6999.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(346002)(39840400004)(366004)(376002)(396003)(107886003)(6666004)(186003)(26005)(2906002)(1076003)(2616005)(52116002)(66476007)(86362001)(8936002)(6506007)(38100700002)(38350700002)(8676002)(66946007)(6916009)(66556008)(4326008)(6486002)(316002)(83380400001)(508600001)(36756003)(6512007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+6e/QB8dds8kk3e6UogiwBgjVrsCCuAqBMwbo9UOkXgNwLieZU7nfUxFNeD?=
 =?us-ascii?Q?aejgb2e+smyxxX99nS85AVxC3TAwrTkybB5hjeSRZDDejEe1u/VpgO0xqh7Z?=
 =?us-ascii?Q?K/6e9D9iFxFkGgMgLVj2lM/wjIkmzbHDGUSU3O4EiVuNX9YeYHJ0i+fdvCyZ?=
 =?us-ascii?Q?tMNpl68TnB8iJD4Zo1Vd0D4Gn4UcH1xKC3h3CtVDci49bKsZQFetio577rHa?=
 =?us-ascii?Q?DQil/ugCGnvVGMCZAYxZ5HNOHToyW2AsbWOmeO21YgvgSr6jIbGCEVJomt7H?=
 =?us-ascii?Q?8OqJQYMoLnE8j6yDdXbz1zm7jlQ910jmoBDLtXfTVwEOvK6+6JB5Yoj9UXgJ?=
 =?us-ascii?Q?wiTcia/vAmJjnQQOI2PcLmAZncqjfuEbtwyQ1OJB7PC28qtBsVluiRGLRiE2?=
 =?us-ascii?Q?5ZLM8Rb1ojGKM2fndpN5cvZGJ+b6JXHVFHOYlPzyuYX3QQDKrWb00hf5fey2?=
 =?us-ascii?Q?XFqBpfenLUUY4/NilI/Uu4tfH4rJsXM1j9JQgMhjnwHQ9vKzhnE1tTz9B2Pb?=
 =?us-ascii?Q?ScxP+8z/8pyThB2rjX2Rfh6ujcdIGOBXrKaiwQD+xtR6siOVPX4nv9xxX4Yt?=
 =?us-ascii?Q?a0Lt8VaPGy72rkctLCci7fJrLgHaZZ1iEPRZUJHc27PYlJ30NFsoOcyRk3pr?=
 =?us-ascii?Q?UH3m/AwyDAxkJo6yKcGrC20GPwlAw/sEYg4ILhc0cteGj2Ahqr/stXe/d3Uy?=
 =?us-ascii?Q?TYpu82WKOr+3gfr6vi63c4UYJ0tfxVjS7D3AOtVBwiuWAIBblBM9oO8IBICT?=
 =?us-ascii?Q?fRIZazI4TwUVejUyRo0thDireYbqxHOovvWSa2Nx1GybVRidQjY2VaLCXGLk?=
 =?us-ascii?Q?WCTzk7CECEyXM0qZc7mJFt8jQGxNwsbp08CG3h6gV9RJIdJ57m0P8zE64QFX?=
 =?us-ascii?Q?OpdqV1epOZ2zBNYwG8NH9KdVl7K81XmOPjV3UTttPh5DnUtmYjCIyXhAfCRm?=
 =?us-ascii?Q?sQo83GWhdbLmFrxNVA7qPov3K8JujLahUfQmYjFTy5YjRS3JvwmIl7FdeRoL?=
 =?us-ascii?Q?cBTyJ35wOwkNMlwTWVHVyby9drGXUmsxmiYQL+DlX3pl7dImf9Nr6DaYhi/0?=
 =?us-ascii?Q?DG0neMdJTdNqSVwK1+dn8A2nfqOMUZ0zL+YkMMCJW6BUQzA7n6G6glske5cG?=
 =?us-ascii?Q?sGzcrm5KG9yBNzkHSneE20z7GJlB4jqVfM4imyihbXXSDVgQwtHoRDAwRLB0?=
 =?us-ascii?Q?FpxJP2TpmW+3hsA7yOmbWC48dp9GeRN7MAiityotXfeWNYBEPYNvtTgoWFKy?=
 =?us-ascii?Q?yejzXchRiQILIaAbSYk6jd2sUe2Aq8MlVGnQ+8qMdEwgqcDmcAWyLi3STLag?=
 =?us-ascii?Q?F0zQB31pUepAh3aOZHrZqFmVzcGkK7ebQBxGpJJ72pGByUa/fpvPnys6OfM+?=
 =?us-ascii?Q?OO+Bsh/cqigOZihbAT/yIE/Tq7eWAsY2JiMPYmYKC+RebLqfTfjU4WlUgpNf?=
 =?us-ascii?Q?49lTn7nlhpkqPi1l1EVFdke4Hqe4pbhZrvKkxcVnjsxzDFShm8REDCoN56gm?=
 =?us-ascii?Q?bD+o5qZ9woJU9kTgrPgdpgNfga0hEzLWDJQOORVRxOlFR3WqNPW6V5nvDSIf?=
 =?us-ascii?Q?UE46kk4tW9WxrJ4NhohUol1WICYlqD04UdCuBVG/RQShxLWEbrWSheay8gAw?=
 =?us-ascii?Q?/FkPJfWVa/CnmNaHeB0CLjk=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5296dcdc-8036-42bf-17b7-08da00474a86
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6999.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:32:22.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkyNNIcKljkIqge0tPpDl55iC/7EFORKWBfLQ1L/gES+0SRCe4iQyeu1qOEDRqoSLzqbLsOoR2Rsia5k0B3LLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierluigi Passaro <pierluigi.p@variscite.com>

For backward compatibility, allow supporting legacy-bch-geometry as in
original NXP releases.

Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Signed-off-by: Alifer Moraes <alifer.m@variscite.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 9 +++++++++
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 1b64c5a5140d..ae375115ef0a 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -517,6 +517,11 @@ static int common_nfc_set_geometry(struct gpmi_nand_data *this)
 	const struct nand_ecc_props *requirements =
 		nanddev_get_ecc_requirements(&chip->base);
 
+	if (this->legacy_bch_geometry) {
+		dev_warn(this->dev, "use legacy bch geometry\n");
+		return legacy_set_geometry(this);
+	}
+
 	if (chip->ecc.strength > 0 && chip->ecc.size > 0)
 		return set_geometry_by_ecc_info(this, chip->ecc.strength,
 						chip->ecc.size);
@@ -2072,6 +2077,10 @@ static int gpmi_nand_attach_chip(struct nand_chip *chip)
 	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
 		this->swap_block_mark ? "en" : "dis");
 
+	if (of_property_read_bool(this->dev->of_node,
+			"fsl,legacy-bch-geometry"))
+		this->legacy_bch_geometry = true;
+
 	ret = gpmi_init_last(this);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
index 5e1c3ddae5f8..d9926cf3d5e0 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
@@ -151,6 +151,9 @@ struct gpmi_nand_data {
 
 	void			*raw_buffer;
 
+	/* legacy bch geometry flag */
+	bool			legacy_bch_geometry;
+
 	/* DMA channels */
 #define DMA_CHANS		8
 	struct dma_chan		*dma_chans[DMA_CHANS];
-- 
2.25.1

