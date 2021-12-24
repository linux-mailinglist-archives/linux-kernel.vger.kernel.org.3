Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3374647EE55
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbhLXKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:45:38 -0500
Received: from mail-psaapc01on2095.outbound.protection.outlook.com ([40.107.255.95]:61889
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240741AbhLXKpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:45:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej5Ck0xo2ke1qtsDPx8/R+z4HbWt2Fyf0/vfhE4Qt9LREJ/RlVcc/4kg3MyzQG+5BGjikglTNMBuOOnQYTecP2AUHy4AIealw0ekMLxPwJ1nl2ux7WTqR7turYFnjUqnw2YXjuYOeBtfl0FHXyyt5xIcaFo+IvB63Hq1jp+zz9Vd2QjkH1TVwPDmpaMDDyMs3q2uWwfSCh8lemTdUHMfYrc4wF2klUVI2evuH+l9Dic0gx02GH9bNObWiHzkg9/gGjp0sJ+gcYJjXWCnUm2asxz/uoVZx6CYFFa1b6IJF4tN0UWBaZtFqxDQNPGi4C+q/TKfdco02d6AhW80r6IDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWicS1EmQm76+ifRTz0BKhO1FCc423/soviHVgUQPWE=;
 b=bJfkXepWWsb/fg8RdbH7/Ni846VG4idRenleDnA93gJLx+vDmrj7u8C8Wxe4MFRTaG0tJo8H+rCLqlUCIgL/sUtiPFAEo1apxL06DnFE7zcWzJK6X6RVxGwmGVFBtEjRBt8vKD3dYxpQqsH0C2Udr8IaoLrLwj0d04imPIEPWl4dGWNpd8tTfJt6jlqDRpEoa+0stcRuUjPBNT2+3Gb9+swPCPsyH8EgFEjld6W1cxYpVnRSlenZ6kdrWi2w0DeEdKG0nTkM+M3MZR09skx17QwBK5b3JFGUyJ/LeHlaw+aFtmqJV6g4tdgt9irL05/hdxkU+GGzDnLxAyoqCQP/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWicS1EmQm76+ifRTz0BKhO1FCc423/soviHVgUQPWE=;
 b=zk9NnGI8lpYVBLtbIGPrSwVLTYlXOJtoHwxHlUz5pdUZ0HRZnfjMTXFPzJYpadiAEO9r0bwjf9ZxdgU4XZ0upTfibr+0zv/9VvXzeMLglaE3yIW7xwYe9xd6ydAsyU1vNtvUiqCAyrwQf5+1VrFF6FuCCXuQw65L6ykO8zLJ278=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2868.apcprd04.prod.outlook.com (2603:1096:203:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 10:45:33 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b9cf:f0c4:9ef1:d769]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b9cf:f0c4:9ef1:d769%6]) with mapi id 15.20.4801.023; Fri, 24 Dec 2021
 10:45:33 +0000
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
Subject: [PATCH 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Date:   Fri, 24 Dec 2021 18:45:21 +0800
Message-Id: <20211224104522.24615-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:202:16::21) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d54b0dde-70bf-45fd-9b2d-08d9c6ca832d
X-MS-TrafficTypeDiagnostic: HK0PR04MB2868:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB286831891BA404E51ED397208E7F9@HK0PR04MB2868.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lZzBccRJmJ915tF9bzqKJN4C/ElTMeUWvKsdl5236Z+Txk5WGZDvkdMrieai+sQb4XZUM0KtB0qSzDcBBFnbxvsbzKL728P4Zix//zzg6W6d38wM4hzuCyMisBW1ClRPZoVwRLxgv2UkfAfmjMuUIIkwRt5lGDdcAHSPR9bqvbBWB9iJ+aTtI/Ms323uaquGpo46mMO9Dptnph79BzUvSxNQeNONf1zGUij16OscnZzcWgllwEP3Ry92TGSl3OVhdJtVABVIO+c1bwqEJhCXSMrGcYruBN2uuvFmb+6yvMiu/2qUWSlu4mzfGMvHs8QGyZelEsD0xIFp7SFPmLgeSpVZbtdkCcoSp/Hkjs/IQmXfiZiwc6dsve+Yg1Bfbzxm1T5RQvYCqmkI510d2Al5/x47HwEYAN3oF0JH0Q22q+iPqM7vzmtToRr82tMsb7EmrA2NBQ++IJJK9DIjqeHqh/gUu9NBn1bzHmLj6Z2HcA60DYaELhZXtJ7e0LVEJa1nDQQKER6P0VdCygZIDW0OlABA1nbArx2wmNu5r9YpbZ0C6gkl8pnJTUXNmq9YUsAvQm+4ZQ8uw9ZstxTNBAqLyTT6sr1Oo0ghYsUTUZw2OFoSB3V095ev19Sj+7MWKAMPJu3JA9XNWeOvuSqTwngOQ/x//BAhnGrb3XbIAzDYZGQNe/lZbbayXnewUQP7LPHujzTMgN91uSLpuS+I/6A8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(52116002)(8676002)(6512007)(186003)(66556008)(26005)(66476007)(66946007)(86362001)(4744005)(36756003)(1076003)(4326008)(5660300002)(316002)(6486002)(8936002)(38100700002)(6506007)(2906002)(38350700002)(54906003)(110136005)(44832011)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TyQOl33VstGbIZfsPlgA1YJCphS4j8pBw3o1ZlwLRhwUztQnaxCle4bd8pth?=
 =?us-ascii?Q?CHU0bh2Emv0/7qilFQp9ekyNZtfeoq4yjmpxT11siRzqYEVubsz9peMdJ3Oi?=
 =?us-ascii?Q?6CeBdawPsHvXuxL70fSoAtp6BNoVKZsS8PyRel/xU+Ud5yz1cB9HIBzRPWfN?=
 =?us-ascii?Q?cNnKSGe5a3GfURU0xLTigLoFmQLBZZ2Z5t5tmXxyd3miIlQt210jbvX0htJF?=
 =?us-ascii?Q?u0d1aERNXpyec8dTT5FeL58qv/xopMRINeiZphTZgnj6cLGLtm8HuEgZbxbY?=
 =?us-ascii?Q?d9QmFsT+4MmIHSLS4pdkhSI+fPaFcbq7htcxeI4udx57Oqpq1QBnCp0/rw85?=
 =?us-ascii?Q?7bZDjbD0187S2W7DVCyt6Fia/cznC4AEvM5lfI9ZRVIqq23GL+TD+Jbc3yCb?=
 =?us-ascii?Q?0Mn5T+0eqPJARRP/fqzHNZ5jNGLkZ06ulEk8xqU/BkzNHDYqCwUv3hsQLnx1?=
 =?us-ascii?Q?aJIEMKGjH7vAtD3y6oekuMcTOLANiEZcCKfM+loky69248pKChAAibUFWhlW?=
 =?us-ascii?Q?0wY6BgqBWMqgGxB8w5eElYvuDqlv0QS5ylm3YQ1+Z23CjxadDFGOrqvWBvBb?=
 =?us-ascii?Q?RRwICiVpxAR6Ty/E1VMUThs7xSCgjGOc7AlwMtY4Mko/3C0B7+D4oBz8XpRd?=
 =?us-ascii?Q?HAv39/yjHQ74FdZvRKir/tS79Gx4bIlcgKRRSRIEZzvc0iN2uh2Jsiq5NnW9?=
 =?us-ascii?Q?2/aDmVvV9KV1+W/4QJ+vIiD9fhEMenYU7peQFxB1+EHoqLsN4oPgNAFTkrYo?=
 =?us-ascii?Q?Q/fXpCzniEF0ZadR8t4U2VmGU9EAzeE6iUDQsncqDNdE0YfCiBEUK4+OaOPI?=
 =?us-ascii?Q?vj0+/Fh4fVHqAXOBsp8kd/JRbjcRnka2DkVzBUyQIAyuhajrAzJT4ppYCoo5?=
 =?us-ascii?Q?SGtyXvB56yDMEh8ew8rn6xYZT/D156EuSO3sZztwR9bSImfiU3wxgQC46/pj?=
 =?us-ascii?Q?ADEXgoC/hiuFPYkkMNQlb4f5/kHtlfYsu0kdmHOhJnzgMaRjDcDPhhe8AVfP?=
 =?us-ascii?Q?Dcthvve6jcMDkL06VBRZS1G3NBmDW82RKter224fLnir5/7M4hRWQpft/Hvz?=
 =?us-ascii?Q?K//dxgtCzTiKwZ5sXQo1xOIr1zZFXz6XWn7VBdzH8i1f+GcgOHsKi2eZ6qs3?=
 =?us-ascii?Q?ptGlJaZ4LNyTwjHCuhUsRNnzBQxnoGxG4XtGYtwwjAz9epd7Iz96G5VrXfUo?=
 =?us-ascii?Q?IkddoR7gmy600hEYhA6oisFg0cCIVk6uXDjV83JdMdVSsRnUeyNGE2XXPK/g?=
 =?us-ascii?Q?Sq02aE7qSGWm1FdQLqdgVzlpetj4aizL3/g18Dy5lmW2Q4J2Nu6EMZQThDSp?=
 =?us-ascii?Q?LQWaTfwH0w6cAG5Y0TWsGTk3aqsi4hl3HNStsMSJwLSPZNTBtfZkv/iGmfCS?=
 =?us-ascii?Q?+iCmTMf9Nf9MVGpLDoDpVjKI18BG89U7/VjLn8Ay5ntMH6FevJsllLAxEyuO?=
 =?us-ascii?Q?5YX2cGYBHwvXCR5vEDM65NQMRVulej2euy6Z1CNmCM5DVfrlchM99UgtJJBo?=
 =?us-ascii?Q?6cIMClBhJEfObAH6Tps8prpPaQHzE403UgVLh16N3ONbyu2IZoaMvElA40iL?=
 =?us-ascii?Q?SMXuNxcIKsnr18Yx3dKo5fYfikvt7xjcgYyEGdlA4FY8/t6Zg4wFC6WlEpdq?=
 =?us-ascii?Q?7bROYAf8KmMNC1zxjx+Aixk=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54b0dde-70bf-45fd-9b2d-08d9c6ca832d
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 10:45:33.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa18PUONwgqehNmSTH1XoXBI797FzBcRMsC2XjA9Zwwo9i3y2m3GKQy0YLjceWCz+NUNV1gRSCjnIpgwJ4O2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2868
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for winbond w25q01jv-iq chip

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index c783ab4ba1e4..a2a72d05fc28 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -104,6 +104,8 @@ static const struct flash_info winbond_parts[] = {
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q01jv-iq", INFO(0xef4021, 0, 64 * 1024, 2048,
+				SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 };
 
 /**
-- 
2.17.1

