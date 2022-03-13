Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4D4D78A1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiCMWqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiCMWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 18:46:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D474620
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 15:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty5mWEKdYbvHeghfLs1BC2wsHacsLPti1T5f71q0IiaA5cCP8iDc2fUNB2gInLhbOvkemsG9WTRZxQm3BV618wBL2J/UcBGW+7tOAtCm25RGPQfjG+Y5itVqpSxQO1O1Vzd5Tem9eHC4EfdqjXdKblBnQ1qCkTzphA3wCPEZ7Tappe3aP0q91hCd9p+6q8GwEVPKMl0qXR3hS4WxsbloKA4c8ZpkJCrbLlcrBpSyLl+PiQ6gXESqsRPJquKL/D2RLZpQjPWIFjKMT3IeQlk4Cc4+LPisihJGgnj0D96c3HPgY2Z6h6D6CdDTvsVGWzdGDxiApde+N8tT5Hxd33UoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8/w0qPZxC6e+jobN824w5mv9MLEVGXVpd5JfWDGVYU=;
 b=Zp5aUFPv2GdQGkAGAgBhGJxpV9wHBITZh+nMB9chFFqZM1sAbBfLwXQCoUz6XhTIi4oz9wXs7Wkh52ZwM63B1ofBc9gELEynjwrC8WmeV6bg2VqHROJ5zbJ8TLFzY9a3JPb3Lgxo//ZVLm0FWzBf90pjc+bnaMhW/uQ/C6fVjal0x5g8cAt+Kcv34eOEdthux9ZJQhuU4XB74QN+Shc4LYdz8dIeo10IQ07Vz0gHy/a16dFCWNNhET/O4EEnJFKQJy7zfsPV284Fn2encY9sMQ8dBddzlHIPhnleGjK769N88QyH2yh2s4FW5p0RN2jCzSYZENypkRMkFGnGFgwlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8/w0qPZxC6e+jobN824w5mv9MLEVGXVpd5JfWDGVYU=;
 b=r1K1l6ebH6Bp5RAPcYx3cJ1B8hRBHiSTrlbQvB+QMnfpIMfhYgz1mlBkJLGv66sFyUumfl3p2WtDAllzYEXJqxNUJDS/MYHW/K48fR4FbXuCYe6kYN7TuZEQII5Ln3oPknt24KoVyqkqGeK5b6QraTYV5ZqZZUTJHuZc1eTjWJI=
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
 22:45:37 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC v1 1/2] regmap: add configurable downshift for addresses
Date:   Sun, 13 Mar 2022 15:45:23 -0700
Message-Id: <20220313224524.399947-2-colin.foster@in-advantage.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8653be31-db17-4cdc-2855-08da05433114
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2379:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2379C14BED5FBFB1014B10FFA40E9@DM5PR1001MB2379.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VvYfyRXVinxH4EsLqevdTkV2sHebFMDxCZjN/NJFtqw+FFoF114dkl/VBe0lmdh3NtV6Gj015jeJRdkLryKH07kae9iQotedokMo/U2XnHr1oEYEeHIycuOJm4MpNFP2Q7gSN333LlLqXGOvBUm0VlhVxrAEqEII6sGNmR3SWgoH+TaJ3PGwH4uV16vHpGWOx0GK/iVqmo2x6lauyqenYRLU8qdnRMn8xtIg64UTzVGpUBnK7E1Ht6Be5vuYqu8cVBXlXJO7k79N0XLrA1We1YNYAjMexbfvzvQ09LjiYv4wZDatRwNSlTjHVOdVKw4L5Yt4jyx2szvpTb7Y7qXh3cq9XstYxzQtDGlPq+mYNN41t6IHml9wqOhfWA16RfC8MWxUaPMSkaauJrwPHmFLDLmWRI+HngrJyD33YIveUmV5VpLHgXX7UIoNNpUP5+dbvYP54vdLgDxbD2ba/qD7BzzbFG1goNUmo/WDOwimxT8ug8vFkpW1mhJdWH6uNG/wC/4C0yCb7rKMxznU5EBeQPykBqWKyqWt/sIZsdkncLAsr+OyiQNiI6WjHGjSDK44KzgztSwLF3FnGtUs1lVtWqJf8z4PJH/gW16ylOJgrYNN1oP6vE/9qlfP+TwRwMl1DJxyeab/N1vk9OYL9/T5v9QjJOxBTpvtRQO7RaEHLRUX2KvLA6owaDwKetougSDAdOH7Oy1ZZuwl1vyQn3SVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(136003)(346002)(396003)(366004)(376002)(1076003)(66946007)(6916009)(316002)(4326008)(8676002)(6506007)(66556008)(66476007)(2616005)(6486002)(36756003)(26005)(186003)(83380400001)(6666004)(52116002)(6512007)(86362001)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(44832011)(508600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/P0dpVYRyWnAEW3IbL18oPOPsgxYL+v1RO9K5nayUJu5kyac4fFWWY1wHQ4?=
 =?us-ascii?Q?LxxNtaUicOt4h9vNEPVcR4X3snQZDxVdww0u3k/O6qdAqvP/c+Ico479f3M/?=
 =?us-ascii?Q?2b69e5/eNOkTOb5TNOGw1HUCMuyFCKiE3G+y8881vvl8LzOK2hoLIpfAEe8h?=
 =?us-ascii?Q?ACgS4FGsvvKBbQs/nnoQs+5mai9hNwi5VPJOKunMkbn8aqZn4AjZ3GcYrNIr?=
 =?us-ascii?Q?z17qtRidFiZSl/8P4dpcTPIHRjB92oKxCkhqrdQxllyaOVvwli4bU60IOuEc?=
 =?us-ascii?Q?Ts+9MySpP3/ca3BI6FikIryX6cHnXhdR/GT4tLo8dauHozsycE/6jV4cilu/?=
 =?us-ascii?Q?Id2VSsajo2YuaAj22/ruIe5iCjDsvmI+DROvBcjDgrn16tFroTadAGwZzbrg?=
 =?us-ascii?Q?yYd+pRGAiRQ+70Xd3wZrAmGjD1sZWy5PZtmqHXWO8yKrfsLdquu0GQgUP4vu?=
 =?us-ascii?Q?oTPvE2QYPGf/wfhYSSksSr1vcVdvzLmV1olm78ETMZ+pwa89XpgjLmoS0lYN?=
 =?us-ascii?Q?H6DHxJkQNUMXgUZ001pXBp4fHDKLPN+tzHVkW+0QbOlyv5Ts5ULY03DIMl4K?=
 =?us-ascii?Q?KgD4+0A0Tjb00/VyOrzAIQpxOsOprYW9YVRyE+TT0kCwknM8R6G63muKuokx?=
 =?us-ascii?Q?Nw/ISh/H2ugLlv8V/GvQp55TD2kWiXfZamNeqETHxavR50ri5a8Mc0wYlP8+?=
 =?us-ascii?Q?hsAnejwmJnhm54UP+KAxaHAxiCKWAjtDecVre5vMtrI9HtTvkzMcfCQgeNMc?=
 =?us-ascii?Q?ut9jywQp8mKMraw8PAOag3Iw9aQugvApC/WGqsoYNkDEKyc3w5TyS087CNQ6?=
 =?us-ascii?Q?QALQuZBOD9rMo47K0Ojwktb2W0roIRbcz2xnlyrmzaZDd6hcMSsbcL+LjjwP?=
 =?us-ascii?Q?F2+e6ZFOA7a395lm0xEqGpHKMtUlIL8d9TVT7wPiPsJbia+INFFliXkwwThl?=
 =?us-ascii?Q?gyAKgK/NHBWYM54ZRWy7aRMoswyFTxLqRjUANRe9LWDTtXBHGWuQP5Sa1cEs?=
 =?us-ascii?Q?vlDkWzI4ciQ0gfu40ARQBd2DEgoW0zYEB60xOcjJ2P5Uw6S2KXEMm+otObFS?=
 =?us-ascii?Q?1HhRC3se4lzGvIxN8xoZ3Sew9U3qDqgr8BXSx+APrrESXP6VIUINO8ZqP1TC?=
 =?us-ascii?Q?uudItZulv6nU36mIZkPs32xeSWG2VYeJmM2W857RdvkzP0hr6HHZL3MP7JLD?=
 =?us-ascii?Q?CGRn4F1Tgt1jf7vjL3Al66EP9+x4GNXSvI9hG6f5M3eCigfAV3xj+n0luasl?=
 =?us-ascii?Q?dw11PU0CZwiexO6fLGafKqcPnRc/MIfvHwqdhDjW0tGc6tbbGr61zjj8GsAI?=
 =?us-ascii?Q?QRiTkfaLzxZrlxSlF7U64r4+b16njp4d7MMgfPCLi01CEM2rmYPOaXK1OM1L?=
 =?us-ascii?Q?8/HthW6BVqjV+gCFQLcBGOfUx7qWl4xHB7lkP5cCDoNHRfnNx8A8UCzNrjJq?=
 =?us-ascii?Q?NRGh1uek7hUhNJkwNSHd1UYefSTjeGpYNQVGV0X8Pb4zcvz49KkKQZkkR1QL?=
 =?us-ascii?Q?vdYd8VOIjL8qdcyca/kBSuf25WTeanJ1dBUl5ZGKdfRjBEhajG4NOyfHttI3?=
 =?us-ascii?Q?3H10L/+DJTsY14F1zD/c/QjjQCe7Kb7PiBnJiO/tCO7MB+cxFz4eyoR93GA+?=
 =?us-ascii?Q?T6k8Kw3I7271ZTJMYw3TVYNXBS9jlR+KoArBL86csrj7t7d0gx4my2UnMet/?=
 =?us-ascii?Q?exZ6bQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8653be31-db17-4cdc-2855-08da05433114
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 22:45:37.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avgMjuFNwGHv2l02JeGVI8onx5CZwiUFB1xqLghYGjhmTgmstYuB4N3ZkkDF7vCPMh9FbZ+2cyQF3xuy09BpXc4tmoDHb78/pzvy0WDWsJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2379
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional reg_downshift to be applied to register addresses before
any register accesses. An example of a device that uses this is a VSC7514
chip, which require each register address to be downshifted by two if the
access is performed over a SPI bus.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/base/regmap/internal.h | 1 +
 drivers/base/regmap/regmap.c   | 5 +++++
 include/linux/regmap.h         | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b1905916f7af..88f710e7ce31 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -31,6 +31,7 @@ struct regmap_format {
 	size_t buf_size;
 	size_t reg_bytes;
 	size_t pad_bytes;
+	size_t reg_downshift;
 	size_t val_bytes;
 	void (*format_write)(struct regmap *map,
 			     unsigned int reg, unsigned int val);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8f9fe5fd4707..1c7c6d6361af 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -823,6 +823,7 @@ struct regmap *__regmap_init(struct device *dev,
 
 	map->format.reg_bytes = DIV_ROUND_UP(config->reg_bits, 8);
 	map->format.pad_bytes = config->pad_bits / 8;
+	map->format.reg_downshift = config->reg_downshift;
 	map->format.val_bytes = DIV_ROUND_UP(config->val_bits, 8);
 	map->format.buf_size = DIV_ROUND_UP(config->reg_bits +
 			config->val_bits + config->pad_bits, 8);
@@ -1735,6 +1736,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 			return ret;
 	}
 
+	reg >>= map->format.reg_downshift;
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
 				      map->write_flag_mask);
@@ -1905,6 +1907,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 			return ret;
 	}
 
+	reg >>= map->format.reg_downshift;
 	map->format.format_write(map, reg, val);
 
 	trace_regmap_hw_write_start(map, reg, 1);
@@ -2346,6 +2349,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 		unsigned int reg = regs[i].reg;
 		unsigned int val = regs[i].def;
 		trace_regmap_hw_write_start(map, reg, 1);
+		reg >>= map->format.reg_downshift;
 		map->format.format_reg(u8, reg, map->reg_shift);
 		u8 += reg_bytes + pad_bytes;
 		map->format.format_val(u8, val, 0);
@@ -2673,6 +2677,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 			return ret;
 	}
 
+	reg >>= map->format.reg_downshift;
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
 				      map->read_flag_mask);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 22652e5fbc38..40fb9399add6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -237,6 +237,8 @@ typedef void (*regmap_unlock)(void *);
  * @reg_stride: The register address stride. Valid register addresses are a
  *              multiple of this value. If set to 0, a value of 1 will be
  *              used.
+ * @reg_downshift: The number of bits to downshift the register before
+ *		   performing any operations.
  * @pad_bits: Number of bits of padding between register and value.
  * @val_bits: Number of bits in a register value, mandatory.
  *
@@ -360,6 +362,7 @@ struct regmap_config {
 
 	int reg_bits;
 	int reg_stride;
+	int reg_downshift;
 	int pad_bits;
 	int val_bits;
 
-- 
2.25.1

