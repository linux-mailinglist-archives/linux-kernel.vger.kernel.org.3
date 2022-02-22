Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE74BF22F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiBVGnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:43:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBVGnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:43:16 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300122.outbound.protection.outlook.com [40.107.130.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793B1052A4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:42:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjfaHRgUkUFQv9xWw4LV87MnrjqvaYl34jcB6L1sd4Cw3X8xt5tsM9FKIoTgXgHxrME7NmSTADn1ZukjM+wk+fyEKmgP2g2YVzQ5JACsuGE7PWkD/PEVkJvhtTYIlWMEmEXDaIraebvf+20p+8hEAib2PFxQmJHWTNAtpgkuOJ2GhIhOGppjdum8h0UNF5czKRPzVMrBlQh5DfLfNIMD3n7Zbnk8kZ6dNevSrpWzl6DGP3rcdjG5NzRY7VR9sAT6q31rePYCaQHsFtuxSwjZm4vm4bUU0qlyUVHT8ue8w9F+Df+hukl0F6MF0KofkCj6l8tahhOM00kC4+k6xCu2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WI4xBQR8QxGTiTjoN+KZVjFNvzw7MWNWHh2/9uSky4g=;
 b=j33OY3HMEMxxTMzYvcSpj++3ZyzabjoPA8i+vFDW2c9DbKdP6vB+9Lc9/NBaGPMcNfu0lBEUhYmYV4NbaguHMm9F1xun7xWdECTejMF/atGVIaMG+ZGgBgC5bGk3WInCuqga6iZLPG8U9iMSPiJlLdJk/n1XY0/WpWPa402rf88hnoX5uFJq2CNh/pdau0aOmH8k52Iry/zHAcJ1rNxQ8ljySUQyeCZ19hOkd5pNGIiXI10Ak6WxCEOAT0aWFyka3Iv6MEypqfcvIm1mbhjBQrSu+BSbR7lR3JhUpVEJieZJE67lLug9PaO7u6CLcGtJDJxx/56ySTvx3ApPHhjH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WI4xBQR8QxGTiTjoN+KZVjFNvzw7MWNWHh2/9uSky4g=;
 b=ngl0OHyUMI3NCqCjmoRlwWuYAznEWeC5TGFacgPpM6x/WcQVktvT1vB7TZBb1DL+Y7AHmfCwsq0P3Ht0VulAQ7bFU3d3ocM6neuVh4e8jCwTkedGn32O7JLwciJ9FMtEN0T3GmxB2AeifucWI86hStS17UW63/c+ra1rO5hNzQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2548.apcprd04.prod.outlook.com (2603:1096:203:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 22 Feb
 2022 06:42:46 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 06:42:45 +0000
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
Subject: [PATCH v2 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Date:   Tue, 22 Feb 2022 14:42:26 +0800
Message-Id: <20220222064227.16724-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fa37d1c-3dab-484d-45b0-08d9f5ce88c1
X-MS-TrafficTypeDiagnostic: HK0PR04MB2548:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2548B1E271899E311486A6E98E3B9@HK0PR04MB2548.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Kf4cn1P9SE/HiQb+f2r7eYiCwp2bofxe1MWC2Q67sBjh3DtaMqcRvD1C942dwlEPWKl3sPxFE/FArPZegD9Lk4WzM57XSJTZRuuO1loQikibIPjj6oBcUr14QJExzY25mizDpunwwVEOxk95VcX+PS+YR8mmEDYKkwDG4lH/AKlP8ot5wSAxt1mb5o9xFdNNClVVhL3A9pqWUI0HyKSP0ufWtBaDcKMy4/0BHSk4ynx9fimHKIkCg8AgoCOHLQRlBz6i5myyr9UslquZJOPYnpZy7pwmN9zX5SXYiCwgiK7NhcR5YiAeemRKR5uYc4JlEigL5vVphFc+usvPXMHQiPFGgM7xTWiChnr11ByW9rrEiX7/lrcbI7s+zqSlvfeNiX0eSQu/753b42CCSTFssH4wDYsrt1qDR+LnWNTZ2QZwQgFCA/ClyVM6t2d3EeTDWJ2cfaFbGkrzI87NBW/MBPQ0SvN2R3vz3fQbdz1JCcIqGPhFIymhkbXiPMkn8tpFW9IJwK8wZ58kTUwcYll5mcpzDJGeNgSRVsklXFOtxcouBiNKgahEyd0kfbg1MNTArzflsIJVnI+1MajA59g119+606whqCD0GUVxpxUebV/lXqp97ncrTRwR20XfseT6Hb2V7tb34qmbPJRPeg1LrMUw3qf4oyGAquHXR1MS5JM9PGp3xNFTfWxuER7xD/H9d5PDqzzx4JQHBmBHLmOqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(8936002)(86362001)(508600001)(1076003)(6486002)(54906003)(110136005)(2906002)(316002)(5660300002)(2616005)(44832011)(186003)(8676002)(4326008)(66946007)(52116002)(38350700002)(6506007)(6666004)(26005)(66476007)(36756003)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVu8ZfgkwFOgRDLwzeZb05nPRW0aFk+XEGSEQD8eSjLPAvj/7Sl+wwG9hxWP?=
 =?us-ascii?Q?ywl2D8i3padYIoPco2WHa4BlPnTGrTijHtP+uExlrmi2I2zpkwoj09GzrurY?=
 =?us-ascii?Q?ZdyI/tISw9xqHm1yHrZYQPYAA2Fj3cV/mP/SrT9HxfAeaqVpmfM3N43sz4eh?=
 =?us-ascii?Q?cQZrs8Ac389Sx8nYYfYJhpuJcpmZw7GuGiaBYML+9v9e6I187gxl6ZWYLO7W?=
 =?us-ascii?Q?GFCJ0OhUU1k4mjCrarBRHoXBwUHUa3Ps+0gh4aPM0CzbtYDYIefYO8aLjDs8?=
 =?us-ascii?Q?uaXSFXYwUea0c4jP9UoF7ttuttU+WxnzKJ6ecUpJKeebitJg2ykCz+qQpl7h?=
 =?us-ascii?Q?lPUB2IldrIVRfIoIed3HIbE9jhSlLRmsvej7sV+AqjI6xi1daq7FiGN3s0uO?=
 =?us-ascii?Q?SV9OIU41p00wIJG6+BMWUVhA9WUpRdJcFHIrmMnsDd6W+AyaAYHg8XqPDnQo?=
 =?us-ascii?Q?Jr/z5ERZjDsGQp5HAZLuAmxZrzwQt55pZC++Eo7LjAgwY2dyINtZ+k27kG1G?=
 =?us-ascii?Q?OoPZ7t5IUWz+YkWB64alBRQfLQaS9ggrz+GaE9OKA772ePTI+4YqIYeEEWp2?=
 =?us-ascii?Q?Y9Xaejo4XgHqSORkDF82+6SKjO2QbTVjTum3iMo4I0SkVvIzwYIggor98orC?=
 =?us-ascii?Q?AdeEpwPg4LzA79AcUVaGMxqZx5PJepqtKsItJfqi2EcGXnD0rnACLQm5aVUO?=
 =?us-ascii?Q?4dZ6c/Dj0tqX8TQ5VAvysekg/t7aFXaL9LgtcSlC4s78uTPkObtK9eSschbT?=
 =?us-ascii?Q?tRs9ejHsVqmeqBKhcqmmG4wYyitJirQJnGJGmksTq9gZBk0ee3URzXKnce9e?=
 =?us-ascii?Q?l9zXOOBJf9U5vFSKVyxZoq+05SVXtvmVeL+YnNlXtjMW2ncJt4KgjTHpnR1E?=
 =?us-ascii?Q?IZQfcI4VAoPlcq+71Ig0yFzR4uI5axDGWveGZODzCu5L1EiO4KHiv2+ii6mL?=
 =?us-ascii?Q?OcuB1DE1PLJaBX7WnKGFchA79DQoresfj/0+XEPQkfE3RAwXXHQDPuC33BLZ?=
 =?us-ascii?Q?Ad6wBYYWoxase/ZYbQsNfCkIc/uTtQPkUWX7o3g8DFQA0HE+4d/D0nHZICqk?=
 =?us-ascii?Q?q3k77KYc5BTo5Gy30Rk3bdaNTT5Ovqk1oL06BWfjE78BJMHOWmIJdEa2tAF2?=
 =?us-ascii?Q?BfJUK3sON4ksiwpcM9gJnGUPBBxa+EkxZ6+9ZbxkSaRGvbbbIvakvtvuhCRU?=
 =?us-ascii?Q?326+ehgsxZDzJ6UVxunjWIj8jsnhRRlqUyLdMo4Uafr66NJnfol+39EBzYRf?=
 =?us-ascii?Q?FGG4MKxRIg/asDgp+4lymG04z/wrnajvO9k4RfixXXKXez7f5NuGk/r81UcF?=
 =?us-ascii?Q?WJg/efkWCjttbUpN909mB1BbcRVPy0Bzoi9HYERauIFeNf/6oUnkqR5TvN6+?=
 =?us-ascii?Q?NsTt+CT2YWG5S+KQcNa5ywsIx/VXK0BdvQTG93p/teQPtSFdWxFDuc9J5xMW?=
 =?us-ascii?Q?9xAueZ4Dc6DeMs7pkejt09L531Eg6/oFusZpMj/6fSw3CuXUw0Ci7Lx3XZG0?=
 =?us-ascii?Q?TE7zmkGhcInUmJv8uqN53JytjEVVB1lSxG7cq1Y4H02L07HOEt6jLLn6Ecn2?=
 =?us-ascii?Q?xISTMdU1DiBnZbxixrko36GDcCFedLz/8ZmEFIZGBb/jhT+ZLXIHU8wZLYMJ?=
 =?us-ascii?Q?pcQ2ubMty3IZrLgVnwxwNec=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa37d1c-3dab-484d-45b0-08d9f5ce88c1
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:42:45.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn8onZMveUrZwKztrXCip9q8cO2bZtg1hih8lsRjhSX9qpQ1Cm23UwPhLkZ1pm7w3tF4DJBS1dWSdv9IB7dsXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2548
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jv-iq chip

root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
ef4021
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
winbond
root@bletchley:~# cat /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
w25q01jv-iq
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

Signed-off-by: Potin Lai <potin.lai@quantatw.com>

---

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

