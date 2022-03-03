Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49234CBDDC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiCCMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiCCMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:35:35 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300133.outbound.protection.outlook.com [40.107.130.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423517925E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:34:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NErIOJVe+/lKqvvxx8O2xf0C4kXUNPqO6BOLuGC4y6sBufX+cK9iVrnkB83COsQ2x2DSNbvjhbIWwBfQdZKqEDbD6WSzw33OgKjfpx0LO5Hvk5fm2qGuMsWQY2ENlBe243NY8kfuxoKfuNix0a2dwWSBqeAjkyQAz04xeSInHCyEr+SdWxIUhCZWyFXeSNm3pBOtyKfFxX4pRCGCNl+7TGnS2Zr7ygpljGs36BW5CUXKCXPbqI8OBoDQMD0f/FK7842Umvw3p2zo/7OgahdBbnSiOlTdufgpHMHlc7RCsRbKl7DVbVdQllPsB+2PQbWVIl+4TvsMmO0+fu2PGvvqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKHxZrw0/Xdh4wPURR7swiowURDa6GcoHSCZsBngSck=;
 b=ii6usSkjBlB4YoCcp+KihdDFH6uWyKVW3dSAyF1Ip+yfzojrCC5iscLUtg5NyA2NvoDtaV7D/aJaSTR9UGy4hAq8T/2PU0LaflqIkPkPm1CCC5I0tuaGReEOBfqfR9d/wFBVq5TlizZPUCmqQEFHc5GlX35bdWY3DppCtjGTCS7J4XKpWub5lqTPfTS+N3eOm6Y32ShbQ2PRlSNFQ4+Z9F+L2VFGs0rZKo1JGY/C/wB2FqF3xbhOSKcfRzkSX4EyaP/3ZA1C8Ipk4IMZslyaI3rLbOhxVM8Q9vCay/8StriuaAfnWjO1C1zrHByTCFrMHN4QGfQrMANL24npRryxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKHxZrw0/Xdh4wPURR7swiowURDa6GcoHSCZsBngSck=;
 b=Rfo1lR/krfXkRUbSz0LXAV91CVZFORfHnKWDfV3HdQzrT9KE2DE/8nGnrymg6jbeRrTJdizuIpi55judCOyST52WbVugsESKbZaotPblOTvhYJ4NeUS4NDXpXGDwjEFIAbbiR4jy6MeXYsQQUt2oHqBd3LdcoTX4+N3HdJnpRXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by HK0PR06MB3700.apcprd06.prod.outlook.com (2603:1096:203:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 12:34:45 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 12:34:44 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, Zou Wei <zou_wei@huawei.com>,
        Yihao Han <hanyihao@vivo.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] mtd: rawnand: rockchip: fix platform_get_irq.cocci warning
Date:   Thu,  3 Mar 2022 04:34:27 -0800
Message-Id: <20220303123431.3170-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23e0a189-efbf-4376-2e5e-08d9fd12323a
X-MS-TrafficTypeDiagnostic: HK0PR06MB3700:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB3700D51C125B89D2905E2F1EA2049@HK0PR06MB3700.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMszuqkT6OuV6uCeTYSL+9gsMQJ/8sjRNdea+3gtu1mslQjgJS5AWQ0vUmqqOOR81qkT8rybPRyIdGS1PreSirfD4Y/WteZv8pQ0r53/hr7NA6avZ0SRy9FywNAW8Q1eCft9l0zaOu7+dSABcnzDbVL44toMzYM9xjf0wsLfTNH7eqHQqTwK7TlKqMGdb0+XKZRTv9SBGX6FW2GfO7SfKfInZaGYMshtWKTMbFAjrN4m3ff7/adTR4zKIrbds/AcqNYaE2foNu4fMHW9cieVQ2EiIo/vDhezpY+eJOISn0SJDLj7bOUkazCbXJQmpkonzyHkou3nuPZP+D1QIwF43kcf+VgLOP4CtVl9poDOwUOtlOy3U/MAFeJJ7iAAmTwx8MXDqmh8LYDbj9FU7ltw9EDO9+4RDefp6Ek1kaDiTIKjL2xyNbMiZ1ybAmhUd1jxMEkfF4rSV6CS3q9cRexxZ5IbqciobQ0K3WYne7f+fNEMUbVicDRGcb2uVxCo+IXFuyhVW15lXc7lUnj4MfwP535krdxsdRPBx9JjzPXMs0qn8BQyigxOrXWeWyUcFmE6cAKoMcSHZkOZeweBE5tPrh5r6TKEFPRVPDURtUxMyejl32hDKUR0ZULfFPAmbQ3/jL2gabjAtka74z7/fFGluaf/+Rsfkw/pgVgdU7lWx9sB8lr6q6yFDSEaovBgl5MnBa41/AeRDisHuujRj+lzjBCbtmAj0onBqxwG7VxC7AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(83380400001)(921005)(38350700002)(38100700002)(110136005)(316002)(6486002)(6666004)(36756003)(6506007)(186003)(66946007)(107886003)(26005)(66556008)(2906002)(66476007)(8676002)(52116002)(4326008)(508600001)(4744005)(2616005)(1076003)(5660300002)(8936002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3sQKkyt8HBK54zg8Ln4xalwR2lYXmh4KhHvfE2ijaX5S+tSuoqEBiaoTMV3?=
 =?us-ascii?Q?N2lnPNpL1VYI2Ucd6QxdGsrhe1hOhu580ZmPVmGfV2OVIr3WiS1acMCMcSuY?=
 =?us-ascii?Q?wmFr9r6xq+PeypaTAParxI5B23BxfB6vXixddGK1xlhwnuxWAGJvw87Ojvkl?=
 =?us-ascii?Q?lIUb4We64xRXAbO6GqtIUH668jI+sCEE06k7l3O9fHYVZORVeOvNkJLGaUAP?=
 =?us-ascii?Q?xqdAfbkm9Q42zr+9PxLGjf+l4kCwaNyUke7I3aDldFblkFpcUdrFaM9ScFCm?=
 =?us-ascii?Q?udU+mlJyoib81wSL+DCt0WdUyXT4V836f8aE54f76A6J2rDG3QXLygDClGLg?=
 =?us-ascii?Q?bruTt4bJTK6xxmh15kJDSU1wzWAzpJwhUG3tTRMBskjsuWfmg5qOfQqA5ujZ?=
 =?us-ascii?Q?9ox1ZYWOjOfmDmt5EfZywi6q1B/+sljF44lRBeRNPv0fix97bhTA5nwqadGD?=
 =?us-ascii?Q?LcWUDSmmQ3MXugFtdApWJ+aW1P8afwtd/Z4DKpJ6AoYlvgIOm9mhrGl7m/r7?=
 =?us-ascii?Q?r2bw9W6KovnAGja0LboX3PaDD+iiok1pF0zZswERaUa0ejldif68yL6kXDUO?=
 =?us-ascii?Q?abCXdCNnukRkoEkNLP8oN+cn1YwX0AqW8Uw+Ir3egn5QA1QZf5Hl0TeNk5XV?=
 =?us-ascii?Q?QPnmkdYZ4vlUdZzDktexYTO6RXsv2lqiKbIFgqFeoUbOarki0ZyetyQQRUVx?=
 =?us-ascii?Q?nkUy4Hp8J8AEM3zCam+GZYzcczlpf7r1Z3Mb8ATaDTyPYcQf4UKx3Zhm/DO2?=
 =?us-ascii?Q?KPtzTWxn5WylKnUY1yunGadSVgpREx9zYQcJL+peQzVeWZ+MjgePtqOM93E4?=
 =?us-ascii?Q?J2QFbVQgIUYE5CpoZwepY+bc6wMHtoIYVJQr2+UpYRtz//E7o9GEi2WkiHIf?=
 =?us-ascii?Q?b1NljLKyUOCPro3Ze3Al139a1bRgZTK4zJi63IZ7TlzQY7wR2vg46s2lbiXB?=
 =?us-ascii?Q?EirjqhOSU4zfbvBZuy1TGMkpno/ExaCoEIwMc+S5VMXtOF328nJH01zpXjHc?=
 =?us-ascii?Q?OWpPoQ1hFm5Pq8143d51oFztQXml8CzJlh1So5HeF1ahqBXidqgxDGvuggo+?=
 =?us-ascii?Q?sIzHP3uOsZ3jX8nSStngxBjrECPTf3FWCHp6vT0LPXgv04+SwvuQ4iP9OEdb?=
 =?us-ascii?Q?Lkx6/8Uzkxds+IDDh26XQltu8hKakLlLnmXpXb4GuwmG2nuuyYNcTLDsf5Hf?=
 =?us-ascii?Q?KaR2BsurbDZl1NkS49Xo+DQyEb0nbSObUK8CpZrxfVwUMacRwnPKeRtXnJGJ?=
 =?us-ascii?Q?2NfZN+JhaC3q16XLxP7Zqpu9jUztDXbHeT5jkS8v+eoIYp0KLSCFoF+jGebg?=
 =?us-ascii?Q?S6YbWBzfGpgNTDDlA/TQwuDMs/lmgLHZhr88iA4zNwHjviaUQq14RrJFZQXe?=
 =?us-ascii?Q?UlJ/qITfESOZ5vXcQqXAmU6XYZj43QiYhv+FHqAfuuWMs0JF38ZjgDp9GEN6?=
 =?us-ascii?Q?ebmP1+Xjh8OsaV7TLW2wnLB7n1/8AjYdDs8gHbLBzo+uMganFRDDb+K7Prvb?=
 =?us-ascii?Q?n3XVOtsHLmDx62fupDp4uwV1cpPA4BYClbzf4kgYUIQEwsCy/bcv32HxyVmA?=
 =?us-ascii?Q?inou5tjL/wC5+YYpHSBD553W7a7dxB89f0/l+7qdjwWoUjFeowgcvr5kAOIF?=
 =?us-ascii?Q?5VIvdhEUWCHT2/drp5WEoqQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0a189-efbf-4376-2e5e-08d9fd12323a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:34:44.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbdO1NpzGaKyaBbEkGZs7shg4N4rwlFQ2fPawoy9NiExe/T25zpZZkHuCK4E/XCPqORyMPTZAvMVLEIskKb8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3700
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index b5405bc7ca3a..cbaa4f1c83da 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -1403,7 +1403,6 @@ static int rk_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no NFC irq resource\n");
 		ret = -EINVAL;
 		goto clk_disable;
 	}
-- 
2.17.1

