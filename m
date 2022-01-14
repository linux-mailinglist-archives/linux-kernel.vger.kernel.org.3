Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21D48E8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiANK6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:58:20 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:52566
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237803AbiANK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:58:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkjpspyKk4/cvHXcpNHhJF8TyvicTYOM2zVjmrCr4ztp4+cXOw1Y+5VQbhV2tivlYdpZwemRfP4xRqwe6agZU0i72b+6CsGIf9qy7OB1JuD84wk7y18yyf3kuJiZjDWFhc8HmbDHEnHGX9k3b3EjxfvxESJHpo8y6J6qbtdrid+PlqTShGc/rn8q5xRlX+6NnwNvwFhkQa8QPpvpDqx8DiptgPJhKXpD55UNsWHLPqmNADOVD8DjZ14EOjMdr6IeyPUdeLv+tdI2MzDp66tWpS+6QArxeBMWgaF4T3IgOSUt5C8WxKfa065Nb/o60nj8iKMW79AqDpOQcrSKYLc/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu1KEIpwqtyUidtEfHSShYNkVFNLgDiyOxLILRuMu+Y=;
 b=Fd89L2wZ61ZR7mUalqNdsCcODSVc2Fuk0atGxqM5+Lp5sEJH845aA86t3xUAOoHzpUr1tcKtfAo1hosrMfIT8JyRa8uGP4G/WVOORYhW3qJSDOq42tniJIDQyXyoS2q8pUxNCgUPLFdXqWoEWRKJynpIupuI9pt92Yvy6601I1kPIT3BF7hlexZbgNQLd+XWSEA8UEphoSiwlfZcyJ4hBzmXmsF96GPRNcF2MeVhDQx42sqG8F8q3aB4Ob15UTbymNzm7TsTR3ZYZPDK+YKmyzyOUrkaE07HBlGsISIHqYXP9UM96iO1KlsJjYTBunTpq1DmwhtstdnuKDlv7pnCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu1KEIpwqtyUidtEfHSShYNkVFNLgDiyOxLILRuMu+Y=;
 b=f7UZv57vyGY1DZbxODa/N4D2/s1ME2koR4BNLiO1QyI5TpEt7w/+gg3QffC8wYZGJztSUoq9wsDbae9kcX5MH6vMhprzPrYRlW+qzbHTPQPbRVOF/7W6If8HaVXHdPFHW+5+VRqs0yvurOz6qhJ9pUKwPnHwUbmCzUylWpGvkio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR0802MB2282.eurprd08.prod.outlook.com (2603:10a6:3:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:58:11 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 10:58:11 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 2/2] media: v4l2-mediabus: add support for dual edge sampling
Date:   Fri, 14 Jan 2022 11:57:55 +0100
Message-Id: <20220114105755.730200-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114105755.730200-1-michael.riesch@wolfvision.net>
References: <20220114105755.730200-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6113499-d9ca-470d-53f9-08d9d74cc178
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2282:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2282AAC035E2098FFAFA9CDBF2549@HE1PR0802MB2282.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN8oinviGz0K4s9MEbBIZ1M6FLh9VEA30OT2XE95mbdmBhETs31qLJpaxWTdGkSj3JOw4IA6c/0h0ZTqpDUnupyaCLRvXVpqHmVPg8RAyBCv2+YFIVbC0L5K4q8oWTie0qwfUh2muqnqbvM1ZaCQvN/MywL3siXLewE5DuLkf/4IZNpBo8GLaai+QYyeEE9dWWpZsY50FCjCS1NBY8YuizTeMpERZNUW+vk0f7g4ZBUTnYi+FwocpYn2/Q1nN1Q6kfvYE5jd5UfcA40ToaEThjNzG0dfpWdQoSFcLZ5dXpR/bM4gcYrYJ4sXFFX2LDCBP26rudzrdZvGc3mTaXxg2v7K5SCWzaAFCFgV6iweEgqmPERBNQUpn2S19PF633DwqTQsP98bRNWUw9dR0ceIWmkgY7hXP8BjF2PgnU3rpVKrxMvdmsG+38ezIcUNe3S4ppwVE8KoH39D2H+IIwD2GMuizdrbvj4bKncquYPGGZai/G2XqUM5h9P7EqOjO499Jn422GeV+uTEmGOzVvsyNetV2fGfrgbOHGH5123RQn2zmz9Rddyc1b6BlKIb5J6yF6uy0NQHB11pZO2Ymq9hEyvDuCf/rjRdiA5uxKb75w6a78zcZ3dmEabQZx3CcZHtCqp/OlnReESd7kmSNmukCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39840400004)(366004)(346002)(316002)(66946007)(6512007)(8936002)(6486002)(8676002)(508600001)(52116002)(86362001)(5660300002)(4326008)(2906002)(107886003)(66476007)(54906003)(36756003)(6506007)(186003)(1076003)(38100700002)(6666004)(2616005)(66556008)(44832011)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PTGeeIc9CvUlZQJX4Ru5P7qSqJkzJLiAUl8u+1cAbrlMHx/0GFTs3tTFV00R?=
 =?us-ascii?Q?syRl1hV5GdIK1XcdhkTa9YGiOKaKvEalq2i1R6vaiZj0/ts61IButsdYS+Gn?=
 =?us-ascii?Q?tM/hgcmpxoyr7kqta6+gjOsW6Lv2jOFZrNOcu2FzCaexlSnsE2j5/zq0b1oE?=
 =?us-ascii?Q?DONmaWkgXy0Pcs84/a6kmHQk10OvGmkPUhX/YLB5bXUU8B1KyQhLZ/cH5PBw?=
 =?us-ascii?Q?cUhE7L/0O46+h2pv795W4wtmVZ5nOZYYGcLNNyxG46mBHTufq6W9eT3JKcWT?=
 =?us-ascii?Q?77bYfc8OeQyadlcsi92lq3xQbH+6QSIUac0ll5ffWIqK1cGyBm0+codipjjc?=
 =?us-ascii?Q?G9tg80M9GaO3A5WEecjZt6xBrgQX5GxTwLaLQfmoMeyD9EDpWA411etimIaN?=
 =?us-ascii?Q?7PRQyZP1OBOnH/KUr9iTepIyAXoygZe5mdzouKk/fx+511RWo+IiU7LiYKu1?=
 =?us-ascii?Q?InmXNBqnylPw/EW5JSOX3SIjLekELlVyzLsYov6Jdxogt/mVGUXYfh6tf7Yc?=
 =?us-ascii?Q?FjzlQ+NWUpcfa16CuDhj/apdq4CmLiULsvds/nht2FEFInqvauqxy3DAUgYm?=
 =?us-ascii?Q?H9hcZxyeSDFMicE9uLGzhW88SnnBJOBDvMMP+vgQ8YpwzSYH8blqmpAwr/wh?=
 =?us-ascii?Q?zWVE9fnjwh244csEPMD9sRdoEbI/JNSfYKJNhyS2XGO2GLamxOpVhXkpppWo?=
 =?us-ascii?Q?hshNSoBZcKjOIpAyX6KlVyAxJmjQN4e1/dR7336ProsuZXMl0yM59SUmFwdW?=
 =?us-ascii?Q?cE5kc1RVvsTjbfSbGiRUyC3G1ovGrVAbNIyU+yBWc5fhZzlYGQlJRTtRKb7c?=
 =?us-ascii?Q?W0AahG4H+jY5nsCAyOVUoa+05w2x5bJuWgCu2urI9VjPgn8RolmPIMRl6fen?=
 =?us-ascii?Q?OXKL0bFknSBdg4hA0jg3QmANT5h57HYCB4vnF6+XxeTUYPeTkZNlCyD4hq7G?=
 =?us-ascii?Q?bJoBEFp/AKZuV/FOHTYlQgstOPEoIIa1QBdYLeoTeni3VU3VIAHNLu4EFui/?=
 =?us-ascii?Q?bVs77/sXy8Q4YURH5ZPjvVpwWcgZ0dT3w1o3k+ElAzbYH3lfQVqzSwtaozmG?=
 =?us-ascii?Q?xD01P3qmgy5rZRIDP4eqY4+hU2UnB7ZROVZC755M2Rv9rG7J2CKLgMyxEsv2?=
 =?us-ascii?Q?onGhxD8nsJ1ZBdufAEeH5Q0e+zkwUZZZ0qkBaZw9J0XZNp9z/tnWLEr8VWTM?=
 =?us-ascii?Q?DCisUxjDB/t4hKfwgYuPEJL8JBJjc79l4TF5NU7+aWHoKwS9rvu4mWsYwYcd?=
 =?us-ascii?Q?gCCOTbqeVtK9GslkimWlgMPTkBZ5IfsjWbVgAm2WioFNUGL7NlNvwgpm2Xmg?=
 =?us-ascii?Q?0cPXKqSAq6uSr9ARW7Xsb8W63EX7HqDhlgDfDZWIDp1ijBopEA9zD6CiCXHq?=
 =?us-ascii?Q?X7RtOwh2Li31dQd/0F117IfsJ6jT5jtX9DKsdiFdu3LG7ya6bBJOUy48XuIH?=
 =?us-ascii?Q?Rj1eH3HnYg1p7JlGnq6OIeMJVnDcgeo9aNsxgcAz4i6SKvWY/e0o2F3O8Ia0?=
 =?us-ascii?Q?yrbRtX85d85eg1OiFtfhG29hvWwCmYA5W7jg/7HXul/ZpqwNxvyr4bFZHREy?=
 =?us-ascii?Q?SL0HeE7N5/RyDuT69YXgNTpQZ/cV1vMJECygfImKtc/iXeUryCvzpbyjLoRl?=
 =?us-ascii?Q?tPHpzUD32iLIrJ8CxxHAAlCLwWKYqsg+DP6TTkXJ3M4yuSSFOS0SI1Pq371a?=
 =?us-ascii?Q?wOtokpcdNlpEo9SY8R0rYOI2bikjl7jI+R18vNo+qIrvteOQj69ITGpuESDC?=
 =?us-ascii?Q?eQs/JXkszax4ZyFZSjahxdbhLUju6zs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e6113499-d9ca-470d-53f9-08d9d74cc178
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:58:11.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erJ0EFIBPGn2S6Jdem4bmpA1gMlSTT8OF2TwQN7imdY3RAwy5ciLEVuxUJ38ZJ32zVypt3x5I0fC5pWtYkQ4nBZcWAD5ublGLSwT1QmV1Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices support sampling of the parallel data at both edges of the
interface pixel clock in order to reduce the pixel clock by two.
Add a mediabus flag that represents this feature.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 23 +++++++++++++++++++----
 include/media/v4l2-mediabus.h         | 17 +++++++++--------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 00457e1e93f6..70adf6549f5b 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -296,10 +296,25 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 
 	if (!fwnode_property_read_u32(fwnode, "pclk-sample", &v)) {
 		flags &= ~(V4L2_MBUS_PCLK_SAMPLE_RISING |
-			   V4L2_MBUS_PCLK_SAMPLE_FALLING);
-		flags |= v ? V4L2_MBUS_PCLK_SAMPLE_RISING :
-			V4L2_MBUS_PCLK_SAMPLE_FALLING;
-		pr_debug("pclk-sample %s\n", v ? "high" : "low");
+			   V4L2_MBUS_PCLK_SAMPLE_FALLING |
+			   V4L2_MBUS_PCLK_SAMPLE_DUALEDGE);
+		switch (v) {
+		case 0:
+			flags |= V4L2_MBUS_PCLK_SAMPLE_FALLING;
+			pr_debug("pclk-sample low\n");
+			break;
+		case 1:
+			flags |= V4L2_MBUS_PCLK_SAMPLE_RISING;
+			pr_debug("pclk-sample high\n");
+			break;
+		case 2:
+			flags |= V4L2_MBUS_PCLK_SAMPLE_DUALEDGE;
+			pr_debug("pclk-sample dual edge\n");
+			break;
+		default:
+			pr_warn("invalid argument for pclk-sample");
+			break;
+		}
 	}
 
 	if (!fwnode_property_read_u32(fwnode, "data-active", &v)) {
diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
index 841e190aedd9..c98f956ef586 100644
--- a/include/media/v4l2-mediabus.h
+++ b/include/media/v4l2-mediabus.h
@@ -57,17 +57,18 @@
 #define V4L2_MBUS_VSYNC_ACTIVE_LOW		BIT(5)
 #define V4L2_MBUS_PCLK_SAMPLE_RISING		BIT(6)
 #define V4L2_MBUS_PCLK_SAMPLE_FALLING		BIT(7)
-#define V4L2_MBUS_DATA_ACTIVE_HIGH		BIT(8)
-#define V4L2_MBUS_DATA_ACTIVE_LOW		BIT(9)
+#define V4L2_MBUS_PCLK_SAMPLE_DUALEDGE		BIT(8)
+#define V4L2_MBUS_DATA_ACTIVE_HIGH		BIT(9)
+#define V4L2_MBUS_DATA_ACTIVE_LOW		BIT(10)
 /* FIELD = 0/1 - Field1 (odd)/Field2 (even) */
-#define V4L2_MBUS_FIELD_EVEN_HIGH		BIT(10)
+#define V4L2_MBUS_FIELD_EVEN_HIGH		BIT(11)
 /* FIELD = 1/0 - Field1 (odd)/Field2 (even) */
-#define V4L2_MBUS_FIELD_EVEN_LOW		BIT(11)
+#define V4L2_MBUS_FIELD_EVEN_LOW		BIT(12)
 /* Active state of Sync-on-green (SoG) signal, 0/1 for LOW/HIGH respectively. */
-#define V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH		BIT(12)
-#define V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW		BIT(13)
-#define V4L2_MBUS_DATA_ENABLE_HIGH		BIT(14)
-#define V4L2_MBUS_DATA_ENABLE_LOW		BIT(15)
+#define V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH		BIT(13)
+#define V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW		BIT(14)
+#define V4L2_MBUS_DATA_ENABLE_HIGH		BIT(15)
+#define V4L2_MBUS_DATA_ENABLE_LOW		BIT(16)
 
 /* Serial flags */
 /* CSI-2 D-PHY number of data lanes. */
-- 
2.30.2

