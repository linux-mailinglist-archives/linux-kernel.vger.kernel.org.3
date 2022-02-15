Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE34B71DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiBOQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbiBOQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:24 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D78B6CB;
        Tue, 15 Feb 2022 08:32:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWUjJZVdWchJHf51C0taqpaYHxqDIa8STE0M64VBFMyy4vwopEyKTZFldGBaR10OtwtwryD0MVksbHRzlzX7/NjCNC3xytwGQeHT4PAPHkWBVP2FKZWu0QAvzncrXTgsfRojWNAG2hHcJxTTPuXIr6XXI5GLAao9a1xJmL/r2HLsmkZcxsXm55CERUriVM0WkZ8RUzSgCSkF3tluA7yDPo5S/i24eiMGRe34Mx//A18sOa9yUrl2jf0Cw8nmCBWXn+CZVKGjljI+ZRpGXENvg566hys8a3HsWifuHlR9+cpsk6FCzmuA9GauiKrbMsKtvgHAwxQVM/gkh3ljRtHkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lt3iNPXKIzzi2xs+5EMghw6HXh2oB6hYycNYkBAYNo=;
 b=DU5mVDvaN+ipqryiLCqZULXXzeGm1Ifjifmh13cu/zlgKQucAF96pcZfJRxVR6M8tEOpjIJ/gGjhbhWM7SwfQHLuLXzLn+MHtCaNxSjvnepZ2saOk14DW4h1X/CViDDQldBwWmQNSEAWtg407M+1bzlu0OsSLK0exIeRSVrK5xinAkBfxEk+3dJbKjnFDdHYYTpqYgCwraKJP6zPeJX4Bl2Zdg+2TNuirlGnwzYx/99GOdyj1TEr77u4911ezv+l8ymTIaWLv1+5rPjaOpndM876KCZW6Xae5pIuiwKy0jq1IMfvL+jtqrsoSnrv8AezcfFhoe8XVhMBbBaoo4/zUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lt3iNPXKIzzi2xs+5EMghw6HXh2oB6hYycNYkBAYNo=;
 b=dkpB7/SpRCxb+Q/L2HFY3HYX7cFYp7Ue9i2zpg9hkrE2eHmQsU27U/k9Vml/P9BE6kTUCxjgeSfwsHlLcgOp+6gGKKMszbi2cVulM5v1IMYK6UrWi3RPvyD+7PkGubbyI7iO4V1NXtZV5de8ot0Gsasni0265hnu+t7EXZWyQVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB4602.apcprd04.prod.outlook.com (2603:1096:4:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:32:07 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:07 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 04/10] ARM: dts: aspeed: bletchley: update fmc configurations
Date:   Wed, 16 Feb 2022 00:31:45 +0800
Message-Id: <20220215163151.32252-5-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c710da65-ecb7-496e-12b3-08d9f0a0b4dd
X-MS-TrafficTypeDiagnostic: SI2PR04MB4602:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB460279C4C0E760935A66191A8E349@SI2PR04MB4602.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 957do0z6t+rwn0b7+8FbvoYILCZ22iIpoEcn3fFb7VXUtSBOA+2NEgFJwUUqHfuknwPQYE5mrEWVP+tgtTl7LPNVlnhKF/o9NmcNQIAgjS6k2RZtd7DZ698aQ6llSlsp6awwuVx+ePj4swfN9SPvV3Z1W0mDzT0sX8j95hck0bLA3Ubp9g+z5+9rFlKPxjye7iUXDnt/iaRaQDc7SDy3l32ERepRZX6oXd0T5Fy8X/wX+L0Z2vxiJrhglUABrO5tSXz5pRpfoO06bR9Tf5mz2wrlNjg3jRzcSae5UaQEGdJUAWONLUVEJnoIcfCmIuUngdOnEpG2pkGA6X4Q8YxSimvPzLi08U2GHfDMV/M4+KodYCGWK1lkIygsgQdEqvDpSMEGtL3nLm0YZqwsPiIYfCtEG4yOIQX/hj3kXwHUvY80tZhppQr4uZWVs4FAaSk/68obcpjkda2+n1moPfoGhQDjb/pJlQb7K6jCNBdGpaziD8USfoVLDl9ow1gieFjLAGiQv0DGdV15Od5vyRzpAPSlWBgWfsoBel+OKLMG778hg+OQPDlaV4+04W7dWXdh5h3snmVhhV1UqGyPzoH8FKnV6I/THBXNNjhuPk7GLrw/Uggu8mYlEODuDlvYGkmVZDllYovRcep8duene1sHuP/uT9igwPWQHPfoE7OP2UPuX8CkXcpa1oqAYXLgdILIyPOviEOmuahbV2nEeq75ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(26005)(186003)(2616005)(36756003)(107886003)(6666004)(6506007)(52116002)(6512007)(508600001)(5660300002)(54906003)(110136005)(8936002)(38100700002)(8676002)(44832011)(6486002)(86362001)(66946007)(4326008)(66476007)(66556008)(316002)(4744005)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DaMcb9PSv87eEhV50CPa25IiOUdZfbsZvro0reVFXEin3F5mA185HDBW+soW?=
 =?us-ascii?Q?/gV2iCdjZPZfTI7WoDZjrmuC9zuCPexhscMlqbXS6N3GBZIHTET98mS6Y1Qk?=
 =?us-ascii?Q?CYyKnkjQQfg77Z/td566Zxs+N3r3RWvs7Jf9SPSEzS8MfA1ahyCU31qjFpFv?=
 =?us-ascii?Q?3SnVjM53bn1FNOcXP77FEp/VfMi4AbHkDLbRjEFEmjmAgYIZDDsMSfI7/wDB?=
 =?us-ascii?Q?y/YwMibefdtNJJ9JwbXoRWgqOmxhPpCNcturYscJGksmQiXcPcOgjx79b0Tu?=
 =?us-ascii?Q?4v9IbFXgUBQ1nJ1+zhWSHqZtOSN4g/QaSn/hg/oV5MAG8SLYmM7aSFZIZs0F?=
 =?us-ascii?Q?4WiVncOIypifmJo2fAT48M4SJUYyY597+4tohjZQvXuwpcWkqE7tH1V5M0Ge?=
 =?us-ascii?Q?Ze29r/QRk4NdC++0K5mi9L7CmY+U0mbVp1zYy48xjb+lxINQtbavdLhcQe+C?=
 =?us-ascii?Q?5q6Ie5OvuL61TqI9nFgCN00qxkcLvJUzXPDZuCY1NOjxqmIY0Vp0ioJsxSN1?=
 =?us-ascii?Q?pqXadwO7pfE4pC6MAkjqavOdY3YdN6lHY4hz0wbqk/6wn0+y9mIbdosayf3X?=
 =?us-ascii?Q?UTRjsRbFXk80JOJL+QjRP5JjDLr1N3my/glKzFEJXK20K5CNHtQv2qUuo/pD?=
 =?us-ascii?Q?Q6d79navbC4kxr5caYKBAaj0bu97L/ibFGLuvtUt8Okp9/gje+hgh+1A+593?=
 =?us-ascii?Q?P9Qa1Q+kppsEgGt3n2QVC3aUOszakixrtNK7QHyBaYCPRVyW5YLL/euc72E1?=
 =?us-ascii?Q?gvTWLdPl7uvJZyW+scH0zzdu03zckdN5lqfi3GWC18SX7A2riPUFxGQKG7yI?=
 =?us-ascii?Q?WOnfJBo3IQMSQatjKHuiw8fbFHk41UshzXPFPLBjQq1sOBUy+eFhDgQLo6Sc?=
 =?us-ascii?Q?/oKJ36yK9P2SLtfo/WooSl5fzL7H6N5q66uivvG90qGVDOGiKLRwqFTb4Mbi?=
 =?us-ascii?Q?D0YwybNjyfoAxqFL6G2L821aygatxJM3IrMjo62eBN13gFQTibWaFaLNuvfm?=
 =?us-ascii?Q?dLgeR4ae9R/LvhMn0m5QcHtKcTxwpf6pSI5Fs5Ozz+eqi78fz8BG8W7xCpnC?=
 =?us-ascii?Q?m0qcKpuAEHMBTS22ANwbtEVGIkzvzs20Gv8hYIvewJPfQoem7CAISJcrNVyv?=
 =?us-ascii?Q?WIZF4OUEFwbEALo9icBVDnbHKDWlUqgUxp3867zJJfyZMfR2b5beYpg6OT0x?=
 =?us-ascii?Q?g1RRKIDYtWRAph1eZRXCWgWkBmIvjZHvID/lAMLdKsBJJSEekzXj5NK1u6Qi?=
 =?us-ascii?Q?6spf8hvO+yQNQKFEo22nSu4kHWK2Fnn4q8fpQbSAF7bWFn+2WyLchESFtvfj?=
 =?us-ascii?Q?vi4XL8t29kxHNSr1nNk1JwPCpX39tLVkxKkHk+A0ZYsVUgRyFQWM0WzgrwAk?=
 =?us-ascii?Q?WIt6invadZ5j9z7FQNhJRTY06kEenW2NkF5qRorb7sPD1pQ+bBJveBxn03Ni?=
 =?us-ascii?Q?0hXJPudeRgdlwo4BMaXU3CXuTeL/q6DP/ESHs0U0fvLGKhe347nJzMLJQ3CF?=
 =?us-ascii?Q?G07dBuXbNjfTOIs49qsxUOQnLI5QwLPUHXxNDeqbN46kTHtMg6UljBjNXQoV?=
 =?us-ascii?Q?Pw0ICqRQaQdHAgvb0L68LssuJGuPUZIvuHc2oPvjrPkqO+ZV8cTnO66hMyoF?=
 =?us-ascii?Q?zhVOdrkP94/RXKp+0BNlu+M=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c710da65-ecb7-496e-12b3-08d9f0a0b4dd
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:07.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nns8NWZPlRXtbCZa7YSkyN0OhbJGOglxt+Vb6RQqnjxHlyIAUWKktE933HXQe6mzEpf796hFqn+ya1AZ4iO3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4602
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add flash1 in fmc to support dual flash module

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index fc0690ccdb0a..b01f1e7adb81 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -217,6 +217,12 @@
 		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-128.dtsi"
 	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "flash1";
+		spi-max-frequency = <50000000>;
+	};
 };
 
 &spi2 {
-- 
2.17.1

