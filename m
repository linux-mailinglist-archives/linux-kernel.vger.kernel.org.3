Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB83501764
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbiDNPea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347594AbiDNOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:12:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79EBF011
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eds2KC6ollFfbEV6EujqG1MWai/OY+FJ8IoZfWBfWntVo4GbjiVbDDKpiTUuA0c61KkdXUngIJbUFyBUvR8s7BvdqM80d7xE9yy6f+xQJfO4X9Lp41yCudyhSLb4dZu3/M+ZkBPaK75hvZm+3Bjmp+NC6IUuTvh2zHm3KY9Anzl8D6xvF10boO22n2Le552ABQ4MSjNcEHr68PuoTorUoDfKAoUb/h+7OTQvtkuftxrkkC55sNoKXhUylMRobXXL8x91TWLV3BXaB+FWMN1fR2500OiZuc64gIwGx6D7t7mATHfokEr/DCdZQm/yX65rZvUGyB1QbSmAftYx4bTnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvDRcUOEPLXaVETYYAHuWrBJa6tmWB68i3kWT3zDowY=;
 b=cgrY984hcyfTzqC9ldXjAv+qNpKYdop3C73GpU2swzeY5SykzhOBCYKuhll0C90ov6GLu0QiOiqFsYi/Xhnb8mhagHVYX2PZ36WjOg8/SnTsFLJifb0EgFJ3fUg0EE5wC3U93H74+kh7ap/RORqAhxhMgbPsmyx0wTmFqw16NXMLrufaf9YottjjhCIwXs7JFyh4my201miYT/G36MJP84xaZluQc+Y58RqD6uIk3AIirFZkJRa6xPhfoR5WkfYLEZTeSvOWwL+0XAmc4KFKbjL/MfoXgXEjbt4ta4JxDiMfvcUikLLQy3rnqXNDvTZ1hgyZYWi30TtvhHPuFCHFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvDRcUOEPLXaVETYYAHuWrBJa6tmWB68i3kWT3zDowY=;
 b=JX55wPFmyXiOG3KIj3cJg284TeFCCf17xR75wAhOz6N5/qXLKLtmaXXI2PofjrifuN3TbnIAywJOdSG6pGnMf7NVYTEIYREpYcyumIfuQwTT+DcgtsaqCw7K1pP5OPpfcYhEWKRphtG6Nx2bjP0f0p/p9JiShKJlkmZu6Cp88og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB2252.apcprd06.prod.outlook.com (2603:1096:4:d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 14:03:40 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb%4]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 14:03:39 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Yihao Han <hanyihao@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] macintosh: macio_asic: fix resource_size.cocci warnings
Date:   Thu, 14 Apr 2022 07:02:42 -0700
Message-Id: <20220414140304.82751-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cfaa211-6328-4066-7ac3-08da1e1f93b0
X-MS-TrafficTypeDiagnostic: SG2PR06MB2252:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB2252E4B7F22271DA504F22C2A2EF9@SG2PR06MB2252.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kmyj8XogfNGPB/dJESatiA0gzGo3SmQG1SRvYKplzOkmIoyKBYnRAlqCjCDWHIPUiFPzSClzhaF1yZ4MXHlUfqfCBrwjJxNFaMKhzqhcpxP9CQ4ZpRYSKt4wvkjxawd8RWbYLh/XVKrHfPENLT0Zgb5OneK90ttwjs4eg8Br+z2o1yjV9smBSyNYwZ19WJMUHJHIbMcmZ70pz41+9cT1NZBEKMZDNxXKSH6rwItePERPST66PNMC1L7X/HjAaw9LavDZ51OH2qMJHRQursFeLjdJlym9ZjZKu5TSXkO9b78u/dz1pOacnCTVxk9v5dkvYL1Tnf73MsGGcItEKdgV4o7PEkPS1vhLyLA6SSH1CHO+dW/mfmrCY28W3mqYgtEbQ1sQ1Er78q8aWSEowF2iR5SdLPBcvANEn+2pyuDw6eOYqroa7A5UtveEwXHm+l7gXV5Yt4SzNC7zoLrAQoLEneHD/7GRwAXI4ehHtuqZojQUmfaklBwlAWlICTv6yN5C9VGTqhBdfa9raZaUDZZeAuxfnM/5wHDEuQgnviNTCv1DufUzvhMbGc5iBGXF4BPR9PiJKHnfaxNMeiiHiaRK7AJLZp7zL4H3MtmETSVrNMsFnbvAM+DnT38XwICAx/pDnCfxZQeJVxiEIbVef8+jd+993piOejQvr70KUyfFI+2OsHz3wmbFMCRn4idF8DmaCkbaXNp0j0NhFSkcMw2/9yokebFayNdN902cRqI2o5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(52116002)(86362001)(6506007)(2906002)(6512007)(508600001)(6486002)(7416002)(5660300002)(6666004)(8936002)(2616005)(186003)(26005)(83380400001)(1076003)(107886003)(921005)(38350700002)(38100700002)(66946007)(8676002)(66556008)(110136005)(66476007)(316002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJYrTRvhgrcfzSjgYhonGT7OmVA/7d5wtIPy3bQyhP6Ue1RE7NoZ3391fv3F?=
 =?us-ascii?Q?K7ZEJYZM1z4l9Rh+NoD6XDMro/OZbYmMKsjyQzkel30e26zRqEK5myPkVqdT?=
 =?us-ascii?Q?WUP/Uv9j7VqPIjNIQTtkorJjfxnF3VDx/F0S7nZbDY4D3CnWfzWSxiaATtnr?=
 =?us-ascii?Q?y/a3w0ab3RuQXUpD6G8BMtdL7GJ+o4MrTRV1mc+6DwHabmb2GEVXNURwoO4V?=
 =?us-ascii?Q?RP/HlkkXCbuESA7zvWT6MzOafYc/3MK4RPsdLEBDaT44AC/eQwXAsotkZ9zy?=
 =?us-ascii?Q?Gp6iUbU0WSVVOccYayRAwbO0pCuKknGJAAEk1dhzq5npzVbZ4B1IAVzn1kuP?=
 =?us-ascii?Q?u9Tj0Z2R0ONznwNS0OH+ZYinbRxO6/vnUSuKNDgeSTWiztavrJV+i2b5Ulfr?=
 =?us-ascii?Q?dkenFvAKCuEphVXWbIZA5mSNu6x/HUfSXxqccjTdtzE3oyWhEejbz9UH4c7M?=
 =?us-ascii?Q?/mCqV8augxFMooxNK/QmzB5Yas0iqRWX0/WxCESofkhV8qIw1/kJOW/dy/+4?=
 =?us-ascii?Q?3qw2JM/lPo/HanLRTsx4dGBg8p2qrZA+BF3F1CE+s1hezfUEdw3dLxKXm3m1?=
 =?us-ascii?Q?24yshhmxnJkPOylU8parYWCEp4YP6mCZq+xns6TrXmjEp7QRjENrMqEH52LD?=
 =?us-ascii?Q?Zsty1layJwXTb0eJu8Lq2iP8ofAYsW5/q0oZ6/WnA/w1hdnHdXxBZqeygY2P?=
 =?us-ascii?Q?qQqIHadhQzk2cqpLtrrGtOX+HVrZNgZs3w1G7BVPxFc2jZcymeUHdJpW7pgO?=
 =?us-ascii?Q?nG3ZSVLtvfkfjz0JLlicdg5O17eWyGh9oQt+JeHU00B9vE0l7RBW1LYzYqPH?=
 =?us-ascii?Q?mFQ7cboj0CMg9PYt3GWRXdcVs6H9WKoAqDUhkWQ5PyzA8b6mt2rvMpNC07wn?=
 =?us-ascii?Q?g0PswS9yMkIXHtnZt11CiXltr/tAZhfaoFIn1Ee336ewhz5S5VoQ7GPXMXIC?=
 =?us-ascii?Q?1MwLLLS+LrQ3w85Qp7ugs6DTIX6k6ZetyXfwSljge2uAfpw4p1LXC9AIxkjC?=
 =?us-ascii?Q?YIvdwfbIOyGQpxGv2DrsmoW4lX0oogBkag7obOvNbE1vLSeqcTfs/l+jgplq?=
 =?us-ascii?Q?GqAnTG1Vd+4ZMWUijzpHSVRv2MOz+0mSXp+fjQQZVY/zNeZvLWG9OuYlKB+Y?=
 =?us-ascii?Q?tbWsTvXtKkpX97jxI6zImgjDuzZAx+z5LGwNx+ahfKJB5vEuYvuW67qcfGYU?=
 =?us-ascii?Q?Op9nEkCF1N5DdqLHAZZYC5lPSOF6Brivvt3zTgC3Wfj+BzVEUk8PhXIIl8W2?=
 =?us-ascii?Q?roOq4yfS1jDP76SKB2C3bjVCkw06GW6uSISutqmwBHQhdYLtpf3vVfokQQ+H?=
 =?us-ascii?Q?CfcUKaFgwpEsvhVyWOOsqI1KXK7IDTUZRxZkGZHhR3Qrr/zbQx2cJk0lou9f?=
 =?us-ascii?Q?W8k0mOe9jwweDU070BldWJP/HxJoWhIPWurbp9wHTjlWKzQ+vh5dTb1P6VUh?=
 =?us-ascii?Q?HYAk6+2KEw0xMPWpBoaACx81prUGccpY2HO8wfMoNSeHmN/T5MRJwcAqUn7h?=
 =?us-ascii?Q?EtF3H5z1IZZqa1B4pPW99ErBl7tgnKjIIusOoJ6WsJpD2vM3nekWj0SI+TFg?=
 =?us-ascii?Q?5QOSvQBthTkRcy4IVTpaOMwtFeJg3BkTNRT/TjDpaTibpc5Z+hLbwcQ7LM7x?=
 =?us-ascii?Q?7gxIS1NZk+DEZSx9hWIlxSqtr1e/5y/Vz9bluvjP9+fcR/E8alggpXwcNhkB?=
 =?us-ascii?Q?cZKTtsXr0NdIQBeGTNk72kA/QtybXNgmAeI3PeZQdTKAqKGRjJsyYqmI7K4t?=
 =?us-ascii?Q?Fs0Y1XMCAw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfaa211-6328-4066-7ac3-08da1e1f93b0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:03:39.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J5MdpxsDhImVLlVGaHnycbQM6gPGPkfAJiahg7UPozMTDU4RT8J4EjsK8VDjefX2XlIMwwhG6yb1rPTpCy3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/macintosh/macio_asic.c:219:26-29: WARNING:
Suspicious code. resource_size is maybe missing with res
drivers/macintosh/macio_asic.c:221:26-29: WARNING:
Suspicious code. resource_size is maybe missing with res

Use resource_size function on resource object instead of
explicit computation.

Generated by: scripts/coccinelle/api/resource_size.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/macintosh/macio_asic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 1943a007e2d5..260fccb3863e 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -216,9 +216,9 @@ static int macio_resource_quirks(struct device_node *np, struct resource *res,
 	/* Some older IDE resources have bogus sizes */
 	if (of_node_name_eq(np, "IDE") || of_node_name_eq(np, "ATA") ||
 	    of_node_is_type(np, "ide") || of_node_is_type(np, "ata")) {
-		if (index == 0 && (res->end - res->start) > 0xfff)
+		if (index == 0 && (resource_size(res)) > 0xfff)
 			res->end = res->start + 0xfff;
-		if (index == 1 && (res->end - res->start) > 0xff)
+		if (index == 1 && (resource_size(res)) > 0xff)
 			res->end = res->start + 0xff;
 	}
 	return 0;
-- 
2.17.1

