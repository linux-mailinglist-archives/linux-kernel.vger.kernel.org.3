Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAABB504E89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiDRJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiDRJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:51:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0341659D;
        Mon, 18 Apr 2022 02:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eztywBL51dfFZE7CtuUrNjsK20/xue5yqs3s2lWb2dR2DutF+mY/T7GRgCRMLspupUj0g74A689gQoyCzDMQ8XaCuaIvzuhEIq/+enakYpKrSuR5vKX3kbjsW0w/53ic1fOSp81phM7pRd/O/0gItPVBWZX1JNxxqPZPKod4P8EQ3VJKeegcE1Pb18O/90sv5kx/9zR6Zt09ciN7s2pYM5CVUBExcg/nMd1CJZdJSw2/S6gaxpY/6g/PgNNM3WE8R57CqYyYmXyW3Vy72F01LdrWzL5poQr6mz4kSVxLcwk7jj7sCAhBAgBEccMIAis0Gu0XlET/q8Bq7gUbMbNzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf6Z4tLZe8HT1mZ+WoJSJ/oMh9z4EEIf0mhvvuxNI48=;
 b=Cdt6coyZ625vhojNoXcp+pZeFam7pE8rnDRhIdblxdf1nBLMTK2XZEhCJFHamooBjAPD0T+G8lD69SacHxRtcidzJFIHumeyGGnzObSDELPtXWqc3BwJuhQ+fCOq0FYr73TlGpKTWwLOQFH/HQsgiI4HeYC6RaYUuhyY3t44hBt0q1mDnV2jR0cqGcFWpUJLxU2CI2uM0HFScIQ8gJCBfcWpjzd5XwqOIcWNqTcMNzoHYBiUkWTX12KLpaLNSoXUyTT/T0KE2L//xEmp/KbbsBo6fuAG7LCmnd8tKdDOOeNn0nl2Zyp91s7e6N5oJsonpR9WXGWw8Nau2Al8muLWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf6Z4tLZe8HT1mZ+WoJSJ/oMh9z4EEIf0mhvvuxNI48=;
 b=zifh9SN/456aXRNiMR73wtodBW7l0MBcjlxU0PYlz6FviZyXi0uWbHr7oCnEmvE/8r2sJox77xIVa3/joQiC7W/Ro0yDhQJQA8+eNGAi1L6Zv/2kvARfNFaDpQS2rVoeb0vafLzrFvrovzT2bt7dWbWvfPxzQpq5NuY4PQxhcYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB4319.apcprd04.prod.outlook.com (2603:1096:400:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 09:48:39 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::1109:2541:660f:1489]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::1109:2541:660f:1489%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 09:48:39 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/1] ARM: dts: aspeed: bletchley: add sample averaging for ADM1278
Date:   Mon, 18 Apr 2022 17:48:27 +0800
Message-Id: <20220418094827.6185-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e11ca64b-98d8-41a3-d628-08da21209d9e
X-MS-TrafficTypeDiagnostic: TYZPR04MB4319:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB4319EDE1359FA6CE31C4EE9D8EF39@TYZPR04MB4319.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4BAnpwnYHNX2OyW1MR+IgT9qCsBc6lff1wNDtVr7reiIuPgReRFFO39RKt6eFRqN3cNPd5xsJ35UtUhM8VYi9SkLA07ztTofUZ39eRr2J87j+nB9dit+WheasYnxOTWC1EHc2vn1gN2+/C05omzluGzB4dvLng0S5BuV8d29uNw+wFJxJBRFbN92RVZYdWmTw4SzcsC39t7UQ/VUbPsChBXWKu+JsQu/b6sei0BVMOy1d7HQX0U6X44EsI5gz7W/7hEoQpzv7UyZaU0O3FiQfStaI4UZJzWw4PoiHt9a7s6b8FkSwgFI7Np4rfrVgF36u1/ZnhIdCxA8+As79JRr7CqGI/pnoZsxSSKOqkHTmZAo6ptv1nNSddUQM2i7iZ+bobxfBKVFkJFFgHpuo1mGW40qaJs8SNnFy2gFVYQjHkp+bzoC5EzdxmN4SF8X4eTP54iuQ9nshmnpCzZ1rDqs1JtvmJQeGqBfbzaR+0As79m9PkyxArUxgyVmR/QyZQxhi/7r/uiouUQ60zqs5SWVh4i5+XKa+wxg+2z1K/QsYd0wY0IoJ1Ie/7+p0rnGph9YRG49I40vehE1cINTFIB9TaU+aNCCM3eUhQZIDEdEsz2Ik13b/VaSzM5x5g5/Il2a1VgcPtUQRqpwiXw2V2amyK8Svpbt1cEr2StK//Sb421h85GsgAgwXbjlruR77LUbDOy+pbDqQh9dLHcSybHNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(6512007)(1076003)(66476007)(66556008)(86362001)(36756003)(52116002)(110136005)(54906003)(6506007)(66946007)(6666004)(508600001)(4744005)(44832011)(4326008)(2616005)(8676002)(5660300002)(6486002)(2906002)(316002)(26005)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5Hb178e8jR98PX8t3/zD1T0z0VfiSbGh08eS8/ApK1yPlu0RErNyv6HPw3J?=
 =?us-ascii?Q?K7EL+orPRzd57gRZGiOurbUzghZjAhd8AVst3F5MrdtWj+cSKWyUUxCce7HU?=
 =?us-ascii?Q?MUouYl3/WhJRNUxKz0CNndwUfYvLr486vpnwup8LGm5ncgWc2kychBhxmxMI?=
 =?us-ascii?Q?k66fFkTFDDjA2h++92MITtuSMgrJDGTrGtj2vsw3lq0sccKsegCWOU79Aejs?=
 =?us-ascii?Q?9AOQiYpkfIxVSF001CbD+XcIe/veGW5/YKYENNIdKApjX1UHhZAYcVkaeaVU?=
 =?us-ascii?Q?GS8HWD84xHWa66UlYk/ZXO45uECUpt4vT+XIpOxNx7OwSHuTVmliH46yhrKM?=
 =?us-ascii?Q?oYhwQ3163qAxenyacRIPpjuoXlBergouuDWvL8YND6QG0L2AsrnFbdltD3Er?=
 =?us-ascii?Q?QyQ6YQWUhIbAL9fEvzPQawjjNDwSaTYKxgqXkdNqPZ+MM5ExfrS0qZlXiuU+?=
 =?us-ascii?Q?qtzyiahYerB0HZqfKDzhMUVjXVpusN337bMSegxZYroZdpBjzKYBZH7l4krf?=
 =?us-ascii?Q?XFEbJ+1QNCi5fk7blR6jBt8fk+pDm5EtZ0MGtSZrQ55GAaCMMd6mqrXJw3zI?=
 =?us-ascii?Q?yraoiWWun+6fB/GBVETEvn7l34JL0zl7ic3UNOIhuiiEfdKW3qy17cS3YgX/?=
 =?us-ascii?Q?AIEW2OGFsEkbxiKj+MpsAooaxr+vsuAmA5aMLSbJYSxYoewYGZUveZFkz0Uf?=
 =?us-ascii?Q?NL5EC+6ubQMwU4VnrAbvpxr+zzUtCHHNoTM/r32FCuQRIE+wyOHEA7XFI5rc?=
 =?us-ascii?Q?aIApr35EqqiDnbuUPHWDNx4glLV5GVZ50mWBjrUFUbu2+51nC+/461bDvlU3?=
 =?us-ascii?Q?E80x+SeHTARB4Hb9l1IVPcowmZUX29BO0NVFipqtEFrkT8oZiuRvFL/jzmXX?=
 =?us-ascii?Q?u1bUeTl+omiQjvK5r3lNPzm4TqTz7Lzq7TeAvZowaJXyHKQjTcsh9DXiijyq?=
 =?us-ascii?Q?TB6Yqw8y//Xlrllg5VFsbYJvpLtZgLZM0+Fy9Tfr3dNPY6SvD7m+UJpJH0Qa?=
 =?us-ascii?Q?INviVRUVu6v43vSJWMMCAT7lOS1PLtmwDSBrS0lOhIv7vlA26x4pg4u2ne8x?=
 =?us-ascii?Q?HaqH5e7CnT/GH0lipJtM1GQ7J64F1duxqeETajRdcBfGo6FLfMjMlZ528GCU?=
 =?us-ascii?Q?QFftCVo4wV1Exu0IpNYI2EP83prc4Zt21g7sfJ2CxTu8sHh/Fh7bG/cBF7ru?=
 =?us-ascii?Q?qvOavAJmOZruYCpxqCK1NHnplL4gLrUdJ9xwMPqlH5Svm9gRQ97Cl9OyYKPS?=
 =?us-ascii?Q?17tJoBCd41O02Gc8umXy670v0imjl76llTcW6G1DTJ9mo29UZ56jdWB/kKPS?=
 =?us-ascii?Q?zOc29adYqbboG0YBg6qYNgjwKyaphLFObx6N5VXE3XtFU1wtzd9616lKTXTP?=
 =?us-ascii?Q?eYUPEh8ik8/r9Lj5fo3OuZ9+FwKg4jR1JZ/qHOlDL+SHa6UeGIlgiXNF7YJs?=
 =?us-ascii?Q?Chf3yn8ZpImHkvEvgTA+Umm3QMLk6Hi+ycw18ccINYcqC6U1hcdrdAL4TMEo?=
 =?us-ascii?Q?ShtYV2kPSiPZA2CWk+N6Oy8utrTrFx0sMXhvLNzydCt6htaByRfVPziKgtDT?=
 =?us-ascii?Q?Rn/mlnybCo9wVNYlxVah5dfiXlx2csj+si/oCpVQ2WeQdKEexoRzZzs3c4xN?=
 =?us-ascii?Q?0Yt8hdaPxbKhqUMhAfnN0XEv7RbDZcLGqUo8F0N3FQwFvyR6qqZsMhQy2oq2?=
 =?us-ascii?Q?ySB1sY0YPevXrvWlpLGKug5bDqccG5byl8UVVyp2OpyeXv+25qAZ+Cv94L5T?=
 =?us-ascii?Q?fXmWiJlODMHsn5zKTn+6/IoAUkGvAFs=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11ca64b-98d8-41a3-d628-08da21209d9e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 09:48:39.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XavnPUgnLcW0ez6zpHEt9y2s8mWgFQmxiY50eRtA6r7w+azoPZ2kIl4wsG/rocm0/22GRne5QGINSy3Jd6QY5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4319
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set number of sample averaging to 128 for both PWR_AVG and VI_AVG

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index eaf1bc261ee3..be76cd955129 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -732,6 +732,8 @@
 		compatible = "adi,adm1278";
 		reg = <0x11>;
 		shunt-resistor-micro-ohms = <300>;
+		adi,volt-curr-sample-average = <128>;
+		adi,power-sample-average = <128>;
 	};
 
 	tmp421@4c {
-- 
2.17.1

