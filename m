Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015C34D789F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiCMWq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiCMWqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 18:46:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9574628
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 15:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBS+wzDU9fTPS59kcIvEKnTgUiC8neVG+MzLQHzP5JRTxF9+8p5/qMm6TXzN+mMxE6PnbOx8hDjYS7nkKoWRQw6vFVdVQLo3fFuaN23evl2iBHQoZDgbhPH4Rhcd5zcgdqpvUDmemI90hbdcJ9UDmC16xS+vDBTUTBz6gwiMwYg+rGO3fZnZv59w5Fp/A5jDy2rywA2zmn7mrnJS1xh7NlruJb2zqcRuc4v06qndW9S6rcLxGyt6TU0/etGLlvVrzOqZJdvjJ5CAvqZKPKnDr+4xL2eYlZyhOiBIWhvrPId2npKlD6mVJu4SyDotx63xUwVN0Cfmx0u0tttr1YTvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH7ZC0QqqpoiU4/EBEbLeSWFB/Jb+IHK4HCKbYx2nyI=;
 b=jj+sOFo+45q4xtNNkAnljU0X/+3QbuCgw0D8e/xy7oOLBNxZs3Qpdh4U6U7Fi3uHs3UUg1Vtvkj1wzd78MgQrvRAL5v8yUhVZgVi3IKr412K5vfTP3rMZWbeNDQB9vK7ljzRkQLGvYu7Hn1FyiS+uFTZ6UDD1DbwnHnZaH77H7Zp5mdPXTSpbVNQJIRt74p9Nxic5nNw1roKro43v28oGY6dS9KJFupENUwjDd+wy0b8wvJTPHhVGNcF5xQzuMWAOouOVxQ2xRrxVgUIGoaJkNNtkQgZsA8/0Cedsd96ZOq0a0d3EZrI9FHOKY4GeDEmFzrAxIBmLxzR14eiCODkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH7ZC0QqqpoiU4/EBEbLeSWFB/Jb+IHK4HCKbYx2nyI=;
 b=mxXjGTgNJhI6/0q9busi+D2Fx9bPW9shzMIGvaMhnWJps07XN+bqUcp8EPWP89Tw2ZVjcxS51DPxvHktQIDSdG9G8pPJwQyzi1jiM6pCfuHABJIXeXYdUdz6naMrfGlRG9zixo5JK7X7Loeq2IsvG/OhuXX3PV9bDKdD9PO6CYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by DM5PR1001MB2379.namprd10.prod.outlook.com
 (2603:10b6:4:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Sun, 13 Mar
 2022 22:45:38 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 22:45:38 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC v1 2/2] regmap: allow a defined reg_base to be added to every address
Date:   Sun, 13 Mar 2022 15:45:24 -0700
Message-Id: <20220313224524.399947-3-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313224524.399947-1-colin.foster@in-advantage.com>
References: <20220313224524.399947-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ada5f06-aa0a-4440-fb74-08da05433169
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2379:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB23797A1675F179A0E2CB0E49A40E9@DM5PR1001MB2379.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5z9mULaJYLgerI7QNb12mdCCLn/FDqysfJAb/cnTd7SGuwevW04m+5zEB2x13UQUV6cN+qKzhwDbz+3Fp1Q4wEBeKdxDc7Mv4Qf6dlgsm0qLCsx+huu6dr9Kt0yGYbK+gpMnN6LffcKaP+SWHXW/lUL4qyrYHFZPEjXoZJT8eyF8VmDUImJIERRLP0LAZycQ/F6I0JkBDNkZRKQYhFW7Zyc7zLoGcMAu6j3j59uv/B6RIFenj/NkuitisTpGPb7KSHH8QxBuNU0lINkt95davbZYzW5auNUduBh6+/fMs5xCaEykXWUjQC/9NFcphTPP067TQlzKrz4NhoO+JHL5a35ZFdOIVMTtD2w5mNCtgbv8rhsJmcoZziK7T2E0hHS10VuuVBYrzDTpo14HcJVQqcrTCWOUdtYVYaoHHr3fOvzy8Ih6TYHPrNCsV5UnMqdS2tem8jx23enQQenrP11icfVXxwb9PWKDDb3OcAQDYFDz/YkRDtewSPBuIypODB27pJE2esUPAwz1frpE64vEYy7XW1szPa1MHV0Y9F6xBD7v59cK09/1pS+7OCtKTMQCV12aZ6FZqThVGrNiSTZriAclgFktzz9I8i0t52+p59iTkzHUCOATbuoEV0tvVrJfQ+6J7CEfxSd3ch+yoyWad5TjBe/8ri8ZXFjO7EXzxq15IPs+LAhCfoh13Uuc2JfAAqO/CAlmWudqSdhImHtfJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(136003)(346002)(396003)(366004)(376002)(1076003)(66946007)(6916009)(316002)(4326008)(8676002)(6506007)(66556008)(66476007)(2616005)(6486002)(36756003)(26005)(186003)(83380400001)(6666004)(52116002)(6512007)(86362001)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(44832011)(508600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qntIW992OyZ09q4O27EdCPEpK/c3JGFcUk6Sx+1pL8fEXg+eWflUgIVMVg/h?=
 =?us-ascii?Q?WhWH1R/uFk2sV9t9NxWEG+UBv6taDZPFWMIocmdASGi3ctJY2l2ax3t8sAdu?=
 =?us-ascii?Q?Na1Cml6ZhJP5oWPRFVuAHEHvUta5ysA1p7g3CHlLdL5cSXmBf7gnQcYcMDlM?=
 =?us-ascii?Q?6HDcki0vA930g9hnoUJwVsjWXOn5YeSo4BRfxZz3c5CUqEOMlqQlt7ztDg2J?=
 =?us-ascii?Q?HFM387tXFAiuIWwCDiomia/KM5WdzcTtwmi5yAqA9cwq3CDaGIOi+BRg4Dd7?=
 =?us-ascii?Q?pL0l3FNM5h5xXPcjQqnHRs8SGOkTorHxcC/MW41s8a02XPJSnKNodlI81nR6?=
 =?us-ascii?Q?pSBdbWQuvgz2hrJtsBrJIR2lDKGBCfxwWrXuAfHZHWGVB8tyAjlavbzK2DW5?=
 =?us-ascii?Q?ok9TMNncGX2oF6vX7/nayqK5lkJ6q8KeL46yWPXM0LZN6AnVW4R5bU2dOktt?=
 =?us-ascii?Q?gR27laqX8NPljjuGAsnbWZgsE3U0ojlJiKYBTDyMpi+SBI5edg7XJCe234W8?=
 =?us-ascii?Q?KoxhuYcm4qj2kRhaufs2UC544R4PGP5Ql38y+GZ4jt5fYmQv4o/88huQzlxX?=
 =?us-ascii?Q?/2i7URBzvIQvZEUqH50iKixzaNPCC3VHjma1gfybZ6LmTKkvCnzVhzjnka4I?=
 =?us-ascii?Q?gxUv0jdRO67+BB76fIqOdVZ+XbcsWFhECOOZIwApKqgftO5Bc8p6D5fpGksY?=
 =?us-ascii?Q?E5LohHPFlzT+xHx2mecy0UVyoKWZg92QHfT/VziBwgzSDBhRhfx7OMfdxn8Q?=
 =?us-ascii?Q?y6zAMZrmjwaKu+x7bxiEthNyvhGkOtLoUtKebG1jhvZqXCVnWofxWqdv3k//?=
 =?us-ascii?Q?P6Gv8y8ZUeflaw4XZIht/xHracGbcIV6xzU19vMolxfFgT/GTSfxmTAGcdXG?=
 =?us-ascii?Q?7YrzHCYIJ9Frp4Odzyn8iNtTFRgtYBb5P4d7kpV6MA80frEbOV8V5zDU9uYg?=
 =?us-ascii?Q?lgj4TrBOkDWV3QKEMN6uaQtyh6efri7ouRfGOUq16EwtY4WfFk69H6MC1SPt?=
 =?us-ascii?Q?kD0egg4n9aIWZqmyPJ+HCmpV8S3YUh6JB0JDMbj2XG/rawblaMr2ybgYcmBn?=
 =?us-ascii?Q?ymH4BbH5bFW/X7EHEtZGpTlNQGbGOuXTMPMlnNneclZBWJ20X3Ps/o6fj+oU?=
 =?us-ascii?Q?NzzTc3Up/i03l1FqTMtilx4fML58AQovS2Cw/qqlgHrqTmi5MROg8Mk6GgHG?=
 =?us-ascii?Q?gSjLy/jLfRi1sFA4DI814gt0yB/BR9JnOHXRq/mYWiWWEiLOBqmYEP6k71zQ?=
 =?us-ascii?Q?KuCXGRRYAk5Og8hNRYEo1wAS1lalHAwOuUVPGWwdtgnaE7ZrpvFxvSNpzMCr?=
 =?us-ascii?Q?QZFbeT723BBgWJoJ8izuQ142UPphe4rxkGkPNAC37Mmxq//dmUFhZddjEjFr?=
 =?us-ascii?Q?CptvI1RYESETcDKFStbK9RFLBvkALmDuj/2Gk4ek4t4K+mwx45PUzc0ZUDSY?=
 =?us-ascii?Q?bUnmTcewBDrWDKJc/uxDttM7Zm+U8A3rOwMoRqUK6d6myskLU6OsP4GOsQCz?=
 =?us-ascii?Q?7cpeumqSbXSiSnxpnVxzJZodbgnu4bsdzptMDIeWzIeV5aK6CNteg9y17y0J?=
 =?us-ascii?Q?0n7+CKzafElAgxVQdGyHIFpT92/YkC/Mbp4aAF9rVHDlBov1ymG3hWYMCPFc?=
 =?us-ascii?Q?2uuyoUcD+0QWl/TGsHKQCZMsW4tT28Z0UoH8WwECugdYQ06VUDimdghQtoGh?=
 =?us-ascii?Q?ICnDC0414YpyOFm0NNy2Y5jcy8Q=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ada5f06-aa0a-4440-fb74-08da05433169
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 22:45:37.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y446/uTlmYnPMKZS1lH1oqm6KH8KozBlNIGtxN3TFzZKTDJMs9q8TPY61xiDpH9z0TilP9WSOQ9rPI8XJ33qNbB7URm5YX8Obr2PuxdYho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2379
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an inconsistency that arises when a register set can be accessed
internally via MMIO, or externally via SPI. The VSC7514 chip allows both
modes of operation. When internally accessed, the system utilizes __iomem,
devm_ioremap_resource, and devm_regmap_init_mmio.

For SPI it isn't possible to utilize memory-mapped IO. To properly operate,
the resource base must be added to the register before every operation.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/base/regmap/internal.h | 1 +
 drivers/base/regmap/regmap.c   | 6 ++++++
 include/linux/regmap.h         | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 88f710e7ce31..b4df36c7b17d 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -63,6 +63,7 @@ struct regmap {
 	regmap_unlock unlock;
 	void *lock_arg; /* This is passed to lock/unlock functions */
 	gfp_t alloc_flags;
+	unsigned int reg_base;
 
 	struct device *dev; /* Device we do I/O on */
 	void *work_buf;     /* Scratch buffer used to format I/O */
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 1c7c6d6361af..5e12f7cb5147 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -821,6 +821,8 @@ struct regmap *__regmap_init(struct device *dev,
 	else
 		map->alloc_flags = GFP_KERNEL;
 
+	map->reg_base = config->reg_base;
+
 	map->format.reg_bytes = DIV_ROUND_UP(config->reg_bits, 8);
 	map->format.pad_bytes = config->pad_bits / 8;
 	map->format.reg_downshift = config->reg_downshift;
@@ -1736,6 +1738,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 			return ret;
 	}
 
+	reg += map->reg_base;
 	reg >>= map->format.reg_downshift;
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
@@ -1907,6 +1910,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 			return ret;
 	}
 
+	reg += map->reg_base;
 	reg >>= map->format.reg_downshift;
 	map->format.format_write(map, reg, val);
 
@@ -2349,6 +2353,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 		unsigned int reg = regs[i].reg;
 		unsigned int val = regs[i].def;
 		trace_regmap_hw_write_start(map, reg, 1);
+		reg += map->reg_base;
 		reg >>= map->format.reg_downshift;
 		map->format.format_reg(u8, reg, map->reg_shift);
 		u8 += reg_bytes + pad_bytes;
@@ -2677,6 +2682,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 			return ret;
 	}
 
+	reg += map->reg_base;
 	reg >>= map->format.reg_downshift;
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 40fb9399add6..de81a94d7b30 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -239,6 +239,8 @@ typedef void (*regmap_unlock)(void *);
  *              used.
  * @reg_downshift: The number of bits to downshift the register before
  *		   performing any operations.
+ * @reg_base: Value to be added to every register address before performing any
+ *	      operation.
  * @pad_bits: Number of bits of padding between register and value.
  * @val_bits: Number of bits in a register value, mandatory.
  *
@@ -363,6 +365,7 @@ struct regmap_config {
 	int reg_bits;
 	int reg_stride;
 	int reg_downshift;
+	unsigned int reg_base;
 	int pad_bits;
 	int val_bits;
 
-- 
2.25.1

