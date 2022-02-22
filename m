Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474524BF499
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiBVJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiBVJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:23:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC813C256
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:22:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeitY5/cFRZf85TsHVZc+R0252Pa4QfzppzmX3diKPdhGi5wrddSKarbU5V4s/+K8CfpKzMhdFn2M5qx6Y3WOzHFGw7IaFS6jpOAqeJjlMPwzwe43bRuO0ylF+rZeqtvCcmpeFB2wAI6E1IzKXN1Y9do9sRIPA9HzNqOhP83GHtikUpd/58dPXp7GbSawAUi4RY2aSXhZdb95xU7ZtS6EM1Lg+v+hgYiBcrNIQtpcaen5FM3v5XoZp2Y9//HrPI0VjgFUjsybQ7JwzVNE6eZQjjB/LiaUE9l6P4vj3QGSsIYCGB4RKGboPvkTfM2Gdqf29y38utiYhRsJR/hYJ7lJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqmUpvsBZrdmmeNS4S2Bn7kniOSBxwht0+g+VIaev3o=;
 b=HmQly6lbggmyX9/k99eoZIBYeNLSMMnwVsf5aX793k34HqUFL9O1Mst7XhsaOgSubAb+iKWK+f2IhUqko11gbob1LJHkxcZiMAEBSNWePv4uQ7NtQ6prxvjbIIdde2/fbRm1cZ9YbJOwQNu0kTfdaaljKcH4YjXaJ2htN0AG1seUH1vjHBFjdQoeN8N7nvncl0XaNF92mTV3cjbgej7CYh78SmUcfFeaa1HYrIZqUSSVZ4VuiOU4wi691mCAON/BuQVz5znZGhPB8M7lARrvSk8cgAWPsZODHLMHa22Q1mqEzqQukLVMh7yg+2kGqEDIVRpdB0ojo1UT9hYCVJJGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqmUpvsBZrdmmeNS4S2Bn7kniOSBxwht0+g+VIaev3o=;
 b=rrMIJ5Zb59C/mqjKtIvZviz0MVOMJzPUB3PwdS93M6CnloL9/ogGfTJgac9xmtnKxXv+GNCitQomG6+/WGwcJZbnaBli0HlwK7C2P9JYAK9n0q/ZUEPj2StfPwBMQ/t8wCLe99+zcKTrQDHNIrM6yk6RNT5pTUQa37ul3ld9hxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by PS2PR04MB3704.apcprd04.prod.outlook.com (2603:1096:300:6a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 09:22:38 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:22:38 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] mtd: spi-nor: winbond: Add support for w25q01jvq
Date:   Tue, 22 Feb 2022 17:22:22 +0800
Message-Id: <20220222092222.23108-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c68a2418-fcee-4b46-74b5-08d9f5e4de2d
X-MS-TrafficTypeDiagnostic: PS2PR04MB3704:EE_
X-Microsoft-Antispam-PRVS: <PS2PR04MB37046B9D002D9BABB8D844328E3B9@PS2PR04MB3704.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQqBSENdJzA/vuQPCEl2y+Dm7mm9uv+B2uTJ8tE9894tPUpw9UPi7YOQiGxlOxhzvXWYbnn5L+84/+9QPTtPKGIX6Jo6ONoEAeac9oxuyzUFlpnv4ptHbITt5QV5FAT+rCf6s3+pwiyttL+VW/b6BObrEavarPsSi98FNPYnJ4QNdVtHi1li/ZvMwdfZS7IHrFvXalGmc4zsXSfq5aq/0+c7ZQyWjF719uAGCK0sUa/kSHFGOGCo3YSRhJ8Uk19jFN7Jw6YJaMEZv1HHbDwGEyzAFo3pd3MTv5KG2Jos9xwB8NgCDuYutoORymiDYACcrWDwflO9b6zNXzXqed4DWLj1NO4/VMh0UxmzASnA59IdUgNXvbYKC4M94Ix+AqXahaYIQAU3dEP+HDtOsdzrGcbh1U7a4n7WrHFB//1xT5jSnIijtAsqCdEdqcbU7oKybo84SwLc6f5XEpGPN6D+8PA9LUz3TguNSBZNrYJQotgMbOhFkJRWt5V3mwcpdrFWuNustM0hfb8MDNiXe29lQM77ysKWcs45RSEf0E1OKUUIJBfEzzRDJKAMZrh+a30oU29IaYkkF80kNlaFPWBTHz2lfX8UE5Q8f+zL4yJVh8eWJv9aKynMkHpS/fHSzm10lbfUgpgL4LAZwjgG3pkWMg5mw/oYV9nHQ9CasGxILuyOtTl4EVQdH00Ke+mjWqDu5r9IKWpQBFssOFByu5Z4w0yJfcQIoVKp0j6qrztaVfnpxP8weltkE9s27OQKZWrqRrXk4oNEGvNIeaN9AYBk6tkdDKpI0469u1p2HcqSmhX5peKaZQbqGF1FatrvuK4KZgksH+q/4oPxeIw5CSsTS9pKDELExAYbvIDGsyo6sDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(1076003)(2906002)(6512007)(186003)(26005)(6506007)(36756003)(44832011)(8936002)(6666004)(52116002)(966005)(508600001)(38350700002)(6486002)(8676002)(86362001)(38100700002)(316002)(4326008)(5660300002)(54906003)(110136005)(66946007)(66476007)(66556008)(138113003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?57Km00itOleW6iEiThqqsUUpNFmyXi80qRVO0K6d/ZwN1rzIFubh+5LvhydM?=
 =?us-ascii?Q?XV53nTnznQxcXQ9+Frlh4SFj0lFMP8C5A6OPZiHL6qO8L5JNhKv+a4Yr+/7o?=
 =?us-ascii?Q?X6vHUxd80tLBEcx1334rSz7ZxKOd06+/enJ9OZeJ7SKAazY7kxVyqzzSehdg?=
 =?us-ascii?Q?33lmzVfpcw8ichlvHpopr1n1/cNlO1SFxH5I3A35o5YPxmxBPenbJQpxdLPu?=
 =?us-ascii?Q?zIf2PqtKUTQho+Fp9iMQjRS5G/coPXFVOXI6TUIk5lN2haO++ABKH9R4o1rq?=
 =?us-ascii?Q?TC+YcHUTh8jKGn0SgKKkBruADTt68qEBds8RSUNnnBebf5u7v96qIfL0EdOj?=
 =?us-ascii?Q?bmuEoCmWatHiI+LNZ7PKpGor6s2q8RRLn7oWhUZ+oSfBXD98KwDihgu2Uzrl?=
 =?us-ascii?Q?1hl4B6VDYhNJdYUL/oN8FFIbMD2n4NmeKd17Sr4C4dxYpYZy8PBEAfI5etDz?=
 =?us-ascii?Q?aWfcDIccaUx7YNmsBUHac/NlNpS4z6brCwk+NV8+DvuSgV3GVYPmw0GUXwkx?=
 =?us-ascii?Q?VW9pzW4vLp4gZnzfDqfFDoifR32r+KGM5C3uILe8s2lSicbt4dX5Hs2BH/sf?=
 =?us-ascii?Q?rwAZUnjZcW2tfp/A3WeCIN2i5sG0GGhwDGZxOqaolWxBelUqapQaQ4wGqAxc?=
 =?us-ascii?Q?xIzbZDdi68qT5dweVHfg8xnGhNDHgHQIUqLY+4d3PI2T3ZN+1pDh68FBf1Te?=
 =?us-ascii?Q?GVncpo31NZlHxvPpJnH/THVr/yAtlqku63wBjRQAdTQa3S2S9RgjO4EBgFfh?=
 =?us-ascii?Q?yBRINZ40XggNOZGtYNlj0/B3ytaU/uqgal+0aY3zkrxGCJiYByrNqkwLa92G?=
 =?us-ascii?Q?dkTwx924TyAJKwAYMSArVh4YZ9ql1pgwopgAUWnHDXFfrxOvhrmNm6h3bnAN?=
 =?us-ascii?Q?D+XSgA3L6ovqY9WrP29cQVR5WV1nnENqlx/HpAHy39WkcJ+YYOr/UeyN/57w?=
 =?us-ascii?Q?VQS/kSveG4Sw9p1giY6KCswxRj8XcHQfjpZP5TJunw0d1VdQDomPv0zd+o1S?=
 =?us-ascii?Q?vw9VeNbELm7voHuFMVw97t464MDrLHaYhtiNF+8XZbKZVYbgPsgZwUvCNUuT?=
 =?us-ascii?Q?dRPyOcA/hJufp6HIAvtYROPZ3+dxowixOXfYSkBwOl7F4IbPHOd3QoFXaRMo?=
 =?us-ascii?Q?/13DZnCTTPnm7ZXO9dgEVBFL4rABKjcfazaHsF951RcYMNnGoxxFmCY7Ur5N?=
 =?us-ascii?Q?XBV8tgSOkvZcl/ZX7gWaa7w1DJZz2T8N8xfEKL81z4UMlfsaTe1tq0qEFLf7?=
 =?us-ascii?Q?baw77iOuVD6cp2Ht5li0V4ppImnZ7ExlscDwcJJKdo2EEwYm9HHTHS54FZtO?=
 =?us-ascii?Q?vB9xAbVg++DlNFemIe3dYsaeoFZfqPQMAlIc+uXH3x01aiPjAbJnCKU4xUNT?=
 =?us-ascii?Q?zqXh00TYesX4EfBNn6+JjscYm4hjQsKldFD7qMJzWw00l0tvbCPo9Y7CRHR/?=
 =?us-ascii?Q?Fx0YswUBvnw9BApvrtJxkVMKSOcPLkPaalrh8X0eRrMXVVTRod1JTZGg3uVN?=
 =?us-ascii?Q?s+sKqnqk1+lCh8kZpd7juh02iY7PmMv4JWQ+TtELeoepVCFcHMMSSdSC9zNM?=
 =?us-ascii?Q?y+qwqPbMbXwcY+Za8ffyuy4bVmGDUuIo8ufGED7h60cOsKekd4vdWpt5y5AT?=
 =?us-ascii?Q?0nGDigh0sOEBa+emv3EgS3M=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68a2418-fcee-4b46-74b5-08d9f5e4de2d
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:22:37.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVT8c3sa+sU379N+t3P5qCzoWu+FBmn2CbL4E+enwX5w8K5QmBBoEEXODqGKmY/TQ/wJqGwlRZYyrOyYMkEAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR04MB3704
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jvq chip

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
Reviewed-by: Michael Walle <michael@walle.cc>

---

v3: https://lore.kernel.org/all/20220222085148.21594-1-potin.lai@quantatw.com/
v2: https://lore.kernel.org/all/20220222064227.16724-1-potin.lai@quantatw.com/
v1: https://lore.kernel.org/all/20211224104522.24615-1-potin.lai@quantatw.com/

Changes v3 --> v4:
- fix correct chip name "w25q01jvq"

root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
ef4021
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
winbond
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
w25q01jvq
root@bletchley:~# md5sum /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
a7b9dbf76e99a33db99e557b6676588a  /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
root@bletchley:~# hexdump -C /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
00000000  53 46 44 50 06 01 01 ff  00 06 01 10 80 00 00 ff  |SFDP............|
00000010  84 00 01 02 d0 00 00 ff  03 00 01 02 f0 00 00 ff  |................|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00000080  e5 20 fb ff ff ff ff 3f  44 eb 08 6b 08 3b 42 bb  |. .....?D..k.;B.|
00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52  |..........@.. .R|
000000a0  10 d8 00 00 36 02 a6 00  82 ea 14 e2 e9 63 76 33  |....6........cv3|
000000b0  7a 75 7a 75 f7 a2 d5 5c  19 f7 4d ff e9 70 f9 a5  |zuzu...\..M..p..|
000000c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000d0  ff 0a f0 ff 21 ff dc ff                           |....!...|
000000d8

Changes v2 --> v3:
- move spi-nor flash information to comment area

Changes v1 --> v2:
- rework patch to work with new flags
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 59d53b4c39c8..960ce04ab381 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -131,6 +131,8 @@ static const struct flash_info winbond_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048)
+		PARSE_SFDP },
 };
 
 /**
-- 
2.17.1

