Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2374BF417
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiBVIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:52:39 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BF1111BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:52:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGbwT+CaobcPt/ybc4NIQtPCkHupiZIEUtbdQpx/juJyAEAo3TIhG9WSKnHIHozrVjIgdgsXjcG6NNYCwCritzFtMU1FBZ5xuvBKHrTqU9vqSioyzUwIorXKfAPvWk8LY+dDm1k3jQaGXTBvkPBaA2+f58t42LK2RwisaNJ+G9ZHANQtiPSt0UJLb4Ea3PyfR+YrdOYSg/QPjW4OLWKvokQGqqhNv0lK4pfuLjWia3NFPTFpO4NQO30id9i5AwOYTLlJWXAh4gNjl6rMn+5Ai0sLgb3dVDVxJj0rJoSqWmfaf68nzwj4YaKyzHVsdu+kqttaucv6VH0i2cSQ8asXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlfqXXS5VmUnsV5GJKLyDLZ81byHM47m+SX8M74al7A=;
 b=DDAYAgT6lCJR72231NP8o28dL7eyp0FsEoQLBcde2sgkp73kZoUEcQ8H9IBhgy8Yi1IzFARdYUfsMK/sgT3JaafXBUR21I32rVbPECK/F3IF8TV2ub8MbJZE4IR2/vmqOt28vRpA03+qSbBuLwgdB8YiptEzdoDjb/IRnUGRiKIP806J3HBpHlIW7cAvatc484EZxANRsgRYrnT+aUQb/HUejTw4KTZfEJTB5J6+jEIvMlvtaC7kEl0LZXGdMZ7myRm5JorQHP26/RJTJtvaAsn+lRUmVc41MpG2eYCcFf0ArMcCkiqYuldBcCBxwNXudx65foP+ncXYOjJZFbOtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlfqXXS5VmUnsV5GJKLyDLZ81byHM47m+SX8M74al7A=;
 b=xc+wI/7jOuMDWsWFteNQWuwemXYvvIJyzxil/HKWIm2ExUSmCorajJ44ajltugVFyYzsJ8nA1xTf0QsClmoxeV8yROcA09+vapeVuHk4QfkwNqRo14W2I0LRAEpBWh8V+UwUn/EiPwwAuzNH1D7i8JorrBDSaYjyVFsX8F45K5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB5445.apcprd04.prod.outlook.com (2603:1096:4:168::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 08:52:07 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:52:07 +0000
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
Subject: [PATCH v3 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Date:   Tue, 22 Feb 2022 16:51:48 +0800
Message-Id: <20220222085148.21594-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8982fa38-1120-4938-6b2c-08d9f5e09b31
X-MS-TrafficTypeDiagnostic: SG2PR04MB5445:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB54457328FCA9EA71AEEFBA8C8E3B9@SG2PR04MB5445.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRD1U8DL1SqdvRl3fp0cfnf0vVK/v7FoiH2eJsOFUrMqsrVK0PDzEWvCNyFbug6PiNSfWMX4xfXqGg6VGXsKRzvRD2c+ICM/g5tChp2c1lUiWeqOs1PDqjDLcs+tLKq70aBKvDUcypBHHqu6cCcBUSuf2mLEGTqHcgY2aXdPBDr82++MAtPyxhZ5sw8y0LMajkc0c1RFkHa5FCjEvQemWI0FgD8IjdPiFr5KmXcbtk0q9NMdqhui4qbudctcfVROqjZPQeMKmc1GukdjXxJhLpxz8QN5pImioKfZiYfcmQHl1ShTzoGVZDbceRpVHuuwciw+Xg2HcbJLlulHSAh7EmAA4Z5zSdYC/8s+44ASBZsmXwbxafGRoHaIbnlQs+GJtGoAE6tqYss8PbHXFC/ntgJcd9tEcygv2U0CQ4nVTHKJ2l2tc/E6ZoIwQfGtKrB1IlD6+kpWWcw1vHFSwCAJbjQTMilZ+LMEJdbA6CUywnJVeJDTic09PQKLG/SIGk2U/00SbMT64LxCWnEyoPAEsFarlHAiSmCMEGLJu7LPBNVIEBc1qBJreFo8o4Mo8ykXOcrNxLTuYXghFu0TYYFQarF5LlHbD5ak5b0ld4cJN+FurPNLioW0hF6R0nYpLkymgEUboXYxeLnqp/WLUaowHk5qVyMyISKvLn1Qv021NXREjrhkj+gOS9ZLL5Uu5irpENB3lkmEcsG3pY06Rdd9v5EYNwgotVXarLGB0MgqjIfXhZjjqUcgx1npf0W3LPbCMp2j1SYkIEsfs3wH5lhusE7MvJjpvtizMhp3ePEirYY+dpPmuMZLvYbRitjLMyjhyqDvzOoOpy+YyybdPNcpMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(110136005)(6486002)(54906003)(8676002)(4326008)(316002)(86362001)(66946007)(26005)(186003)(66556008)(66476007)(1076003)(2616005)(508600001)(5660300002)(6506007)(52116002)(6666004)(36756003)(6512007)(44832011)(2906002)(8936002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyGLETxWqSdxoCyboLCEI7ePteAYux0VWBi9K8S68wzrVbgiZVm8g7kSB4iH?=
 =?us-ascii?Q?2gHuuPKY+Q+c602X0lVnM2U3g4Nr3bv+0a19LH6XPyu2dRWVZ+E/R6u8BIy4?=
 =?us-ascii?Q?WCZCFrc2XeATtekCsQ4NFMdV24tA4KSG9I0zyct9rsbf9rhwzX0D9J/wm09j?=
 =?us-ascii?Q?7AEZm8RL7DgP9Ag8WS4cu3ZnQd2Qp4uBidJolXBWx63zf7iA8tykdIW0euFQ?=
 =?us-ascii?Q?P4Ie/RMmKEZS+CeRS40UZa5JJq704fHXsmUjMbHqvmkyQo1DcyfCIojHEaBC?=
 =?us-ascii?Q?rHabuI0YgRRGffqbA7f9jaPwbDGD+jbiXQ5n89dNOSFUDrymHaCAsjmDwFM/?=
 =?us-ascii?Q?VqXutseAjE7KZuECRz0rtDGLft5+UJ+VRFN2FfL93/D/ZnWz65aDMD0kDJRc?=
 =?us-ascii?Q?VF8o1RKPgu7jGNKoleYDG6uiKxAGTQQUpnSnnxC1CCE3V6bFwv2RkgI7g4pD?=
 =?us-ascii?Q?FoJIO0x9GfVPWD2ZpC7lmdcX0FGFQxaUYur/bj+lv8QMiPR6v4UBgMkjMaOI?=
 =?us-ascii?Q?DK2EAIC4eSA8WazRj5WuY6wLMCsYYa3WbuHgqfFON+DuQCfAfbLuvvvSW1rv?=
 =?us-ascii?Q?Tq/tzCyltHBKWh1sFoCPRhJrp6Wt5vtmw/S5o/LfiNuQnqN2k6jTR5lvzvZi?=
 =?us-ascii?Q?hW9qvvf5ps674jF6dPdSE0iiU+wYH/JVw71dBjl4VYlRU0Ws52nIrlJkzj1Z?=
 =?us-ascii?Q?/1jXk5M9t2uV9Z3jucrIfMwLDFivEpZZ1V9qXI9IanCscaf7GrFwAw3GLPV1?=
 =?us-ascii?Q?iBN8JjkVqkRQunhAOxU6oaNJYEEL51c7WZHCTB27OltDLxsdOxWDph+meURt?=
 =?us-ascii?Q?oG7RVVM5Lh2/YKTzxu62ZD/jWO0Je8mL0AVx+6OFTNFwgoumUH7PNoLYRoFo?=
 =?us-ascii?Q?nB/YpLAujP6uYqfbbr+Pw1k0JpHkfcTqFMlcWsWTqaUfiGRbt1fMgsDjvmyM?=
 =?us-ascii?Q?RWYSdvlH/1GRZzfvP5esnQG3ziKk7UaEij94+t41t9lZ2TOKze1HfuNWZYek?=
 =?us-ascii?Q?/yNwtq+uEOOt8BPdT7j2McuLn7fDqs+vxjnZePRQbDPNd43IAKZP0MlqVo04?=
 =?us-ascii?Q?BczaJOw9GVDLKEiM6aPNEV5RCfTfoiq9h3MCCN4X0UmRlyg73e6mFlIPW0tc?=
 =?us-ascii?Q?Oz/u15gCU3+UTC/TEk6d0A8LUl/YxSNVo0K/HKiFubOPORmMZ+cdC8M9g4Ck?=
 =?us-ascii?Q?H0MPGL4Adh65+v0oYeITQX08eJ/9Cm/wtmVagd7mCc6nT+qG8KTnOCkLLMle?=
 =?us-ascii?Q?XM/o0VPNOzogqRO+eTDLDBqIrH+xM+19Ge6KMQMF1Kt8JrrAFDlXdjWe2oYe?=
 =?us-ascii?Q?W75VX91m20D60hSpmeEA/vxex+yY0n0jzrqLmxkLAEmEjRTzvokV5B2lJkHy?=
 =?us-ascii?Q?4I9EABxNTE3fMGhjxkZ9mbYdrLZebF9puNvY5Ohb0XQ4K64yAfDv8Kc67oPX?=
 =?us-ascii?Q?HZUYodbbtUh0dQMZ7XypyPO/ViAbfxmRV65FqaqBQlGmWutTTY2pU7GUzeJM?=
 =?us-ascii?Q?uft5pm4CVbQHKixt8kWZdk2ZXDdefQKh1tV1+nj6XIZtwC6ykZeSRF8KyLVI?=
 =?us-ascii?Q?BqoE6r76AkefDrn8YYGOCXEHgu5kQ5UBdErQb7H/JcnusJLCQwYHZj1NDWhu?=
 =?us-ascii?Q?KlhvS6gitp1EryjzNJ0WBkk=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8982fa38-1120-4938-6b2c-08d9f5e09b31
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:52:07.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCpnI4Yp39ODFND3ISCqpXZbAIYqAaYdgJugY3CQA4jjw3QoXwueYheHbBxdIJ+XXtZVY6+PNAOzYm+t8v9xLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jv-iq chip

Signed-off-by: Potin Lai <potin.lai@quantatw.com>

---

v2: https://lore.kernel.org/all/20220222064227.16724-1-potin.lai@quantatw.com/
v1: https://lore.kernel.org/all/20211224104522.24615-1-potin.lai@quantatw.com/

Changes v2 --> v3:
- move spi-nor flash information to comment area
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
ef4021
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
winbond
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
w25q01jv-iq
root@bletchley:~# md5sum /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
a7b9dbf76e99a33db99e557b6676588a  /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
root@bletchley:~# hexdump -C /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
00000000 53 46 44 50 06 01 01 ff 00 06 01 10 80 00 00 ff |SFDP............|
00000010 84 00 01 02 d0 00 00 ff 03 00 01 02 f0 00 00 ff |................|
00000020 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |................|
*
00000080 e5 20 fb ff ff ff ff 3f 44 eb 08 6b 08 3b 42 bb |. .....?D..k.;B.|
00000090 fe ff ff ff ff ff 00 00 ff ff 40 eb 0c 20 0f 52 |..........@.. .R|
000000a0 10 d8 00 00 36 02 a6 00 82 ea 14 e2 e9 63 76 33 |....6........cv3|
000000b0 7a 75 7a 75 f7 a2 d5 5c 19 f7 4d ff e9 70 f9 a5 |zuzu...\..M..p..|
000000c0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff |................|
000000d0 ff 0a f0 ff 21 ff dc ff |....!...|
000000d8

Changes v1 --> v2:
- rework patch to work with new flags

---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 59d53b4c39c8..4c088250fe96 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -131,6 +131,8 @@ static const struct flash_info winbond_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jv-iq", INFO(0xef4021, 0, 64 * 1024, 2048)
+		PARSE_SFDP },
 };
 
 /**
-- 
2.17.1

