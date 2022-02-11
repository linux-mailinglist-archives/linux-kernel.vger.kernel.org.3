Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF64B1B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiBKBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbiBKBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:22 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478295F93;
        Thu, 10 Feb 2022 17:44:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCdypYSuuNv6jdjO/nt9S+ge5feBTfblQh3X4g+mXD11VZ/+C1WpIJOtJYgMRDrutnuof+p530BA7XIilTsH8tbXZrE1vjNsAvDv+JNyznoQsMMVg0eVdmRkIlQLZY0hRH1BxqTMt04bVlTS3MXC2ZgVm9RFpq/YWs8AuGHwFKPG2C0Z7KRc5+whfjwsENsr65BS2ftqsVkg83VczNMFur1DkVWwtWyF+MsNVQ8u42u2jO679mpQdl6OqgJ68I95VMrWsMxkkbYdHyPgyjTs8lI3+yvVzE5dZE0us5lB1j6a9oHqRdNoj49q8Szqvgxarbp6bZqWO+IkflEWD0HvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpAZh1T7C+POkdbs/YT2d/ls+QvRhT3Kw33SEe6rvw4=;
 b=ALSxnLWX1jIYa+9B3CbhtY0eA9MN/KWWXHLymovHYD00dB6JU1N8o7fbT6N/ihgiH5Oi33+0JM9SZebt9oBqKBD8AggmEBW510zcGUevd2uVuT9/+pFRAFZqefTlIbUHSP5mWIDVhhJiaxg7S5ju5Qhc+AqqLVxnBG5HDoebhY1JOq/sFhCZEOgfZuOzNgGqnqZYPH8BiRqJNI5SyY0yv5Ud3XwMUTC5HWSEV0Y4OqCzHRiYs0JAYilAUZWH3yMPOH2VeHusnC09GfGLs966yDebiQ1lK/UA575uwOasXgN6mPbXZCVrZhmyHL0VNGlc+IgZHluYiBsmtJLjBtBHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpAZh1T7C+POkdbs/YT2d/ls+QvRhT3Kw33SEe6rvw4=;
 b=FqINrBTiCo+GReIrA1tVf6VFtcdCSs+44AyBd2GI6m/gMt0DKdfE+fGiqTp3eyN0aXTjffDR9SRRq0K7mx7uyIS4UPqydzgZdROJ2w74lotVeeLEpLxDx5j7zHkHxHrkMu1Viu9FMlQG1UOoj7HZT2YOHwdwMP2FLmxcfAbB5ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:17 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:17 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 07/10] arch: arm: dts: bletchley: add shunt-resistor for ADM1278
Date:   Fri, 11 Feb 2022 09:43:44 +0800
Message-Id: <20220211014347.24841-8-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564e6457-a75c-4144-b2f7-08d9ed00035c
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB357798EBF5D177DA523C94808E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoTZIh3yyo2QDxDtsuHylE92aHpPjh7ef72hOpsvmnoCn4u1eo3UirW7R6ykCsRcWmJ4xpEFuxHQ5Z0MdVMpUK6g+syT4lhS55tLF0Zib6IEuVwWina5vX8/0ewYp1YHnyX42uScwKDrDUavCwawiiO14XS5RIIGTks5momyWThJRq2JK9QpG5wjroaJOwzGVYZfO9OzP1n7LyJpQZhYvOBWiOxkRwTfTQWpI02oej6EFqSKMLw+SFTtyIbxiGclxw0GBlmpgPzZh0ivjUbohPfI0XkKuqu4jl20J8C7hrk0Z4GHOaqV5gkQHrUV4W1c9YTnQYqsB8NpqEXN56NDyXqrAIJXl5QMBjARpTjQjYbVtmEOtleNMLrs5DKZyqeLft8GevLF2JczxHlojgI0i48jZuAk8XgH0GaMNuqhkkpRDP+Poke3LZzdiazv2n+ANhAtndMXD5iMioG0erIMfPDyDZpqkPblgesqUPyrFT+cFH3kXkwDVvVZOAo/KJftIgA/Xf8CW+kfdpBmpdRtcvoJaDPd3URX+cqdZ7TWGRQJDLWAFKGnh617OL4WAO04G9FHzoPvMxbjL5GZEm+UE2AdUwN10wn7lKSfeQjQiqxPba00hWQozvg0DxUQ+n9G9ps3+xWbWWyC0ip+R2ZJhwiDoIVz9FMIbRbbv3k6v010B2wtbAFcXPx7AkfZyIRMQWuwamEPheHILPaPihe6Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(4744005)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnM8MgFN9pssvSSf/MWpRKV0KfwQLwDeGjiTcmtnBFuwY8Qs2xy8ZkYvvIs2?=
 =?us-ascii?Q?2QXPl2uNqQ0KExa5UH4fo3CxQSaK0ZITzEGmIqjd0E2ZUyNyeeTdezpJSplU?=
 =?us-ascii?Q?oWwHDmNlMu9o8NgHEn1WSOrQlTW4RZHecotVNHQXRMluE3WUU2qikrms5D/X?=
 =?us-ascii?Q?lldDK5REg8lwsA/3hQAVrAg9PvXKLsFoXVRBHiwBvD14P/RBI3A1aEl1RIRR?=
 =?us-ascii?Q?CqgonsE6av1/H/cpOuLjwrD/UBaLWhj0VGY51PVaVMZ+zfHrCMKBcmPob97b?=
 =?us-ascii?Q?BEMD2QYjpArse2PkisB/k1wilNWz+LHN6Ydu1nwk7J11lc3oCPRpimABaOdi?=
 =?us-ascii?Q?beHkRn9T4pYfk+3X8Ay6nKZrBhMKLYV/MzkMnEIy/NS/NC9vqkKO5973TzYI?=
 =?us-ascii?Q?F32dgpi5Tu/OncjQKju6Zes95d9qabp/WctpBP+w4VSb7IJFSJKycjB8kCeu?=
 =?us-ascii?Q?uxko/JYWLYkEBQmEe/1S3Gb4C7jk/jck/XAZOIZoJImeGRetvKop5CdgQfuw?=
 =?us-ascii?Q?E1rHDwL2WzAjf8SbBhACQTpdWB3QqbIsZdrc3OC/TMy8/MxMDpCsnjwcvUzt?=
 =?us-ascii?Q?HfHA1ESwwOiKCZEXGkgkaNwJoDv1ELwKyg7wZngx6qZaXUw/s0CdqWcWiSrC?=
 =?us-ascii?Q?P4Wv/9PuCB3tGL5EfA0krjHi0yA+ayoy8NVf5egIF2kSAmlO+biTqzxIMhSQ?=
 =?us-ascii?Q?oUbaVGdo1CQjXXrFOvIg5+wio3rRgrD3PwRx7FP/qSlmSJ3E/t4bl8EyGKIm?=
 =?us-ascii?Q?JJ3/i3zVOiNfiRNzAwQm0LNhX48L2kCyPUPe9x/KS6lKgIqRb7JydPqBJ5AB?=
 =?us-ascii?Q?eRcOQE+GzoDdMY++/q5xUBlmHJSLDmAJkUo+TP35QWVc6jiA8ypOvPrbqCqj?=
 =?us-ascii?Q?bMukZCgNhHgdfWbe1760dP1lQ3cAkIRA8/8hZNJGeF/wTTPm6jjsP1kVV7It?=
 =?us-ascii?Q?FTgcbgPDwLQIiGiUaCjDt3PqeB2nwfbm40HiNygRRzIM2PN9jLA1+Uh3rYQf?=
 =?us-ascii?Q?GbdVsq4vF3DawdD2NJuRfiJjgkolT+6XJwL+rhSoZ97dBHsGil3yN1EEajyO?=
 =?us-ascii?Q?TEB+xbFeBYntoQCZFs56g+kn6YnKd2IjK0ofNf0Tg7q76312TzWCPS3ilAqa?=
 =?us-ascii?Q?KqJr0U9pYSqWtdQuzfYtnRD5ObiOm191Vf3jCn/8YYTlQdiycJBHt7NxZ5kE?=
 =?us-ascii?Q?9GGM99RZap3RJ6lAyVrkppqkxl+4fgcXY1TvUMbBheqn5K+aHvm1pQtsk/DF?=
 =?us-ascii?Q?Vxhcn60WPdC2X5x472NLMLNpYrN8RBycUPe6fo/b+86BbKP2udLikyorGas9?=
 =?us-ascii?Q?UnkKlEwN0x02WAp9ynI/spCFstLS+sMmppCLDH8VI+96Qc25qrHWtrNl10JV?=
 =?us-ascii?Q?p7yQjqJHDPvaqL2gAiMzZiuBo+pfOPM1OMu7E7CYfrwvCxdStzTBS1MPKIA9?=
 =?us-ascii?Q?So+APVCqLfs17WccG9/GBWQASjD2klVOhkOXhmgU2irRHFzeaFJ/5r1U+Hou?=
 =?us-ascii?Q?gCdF+Z2RU5DCDgpua0xwki9XWcvtBkCoW1JB5rLYb9V2/Ew/v9Wa9w5U3Ayl?=
 =?us-ascii?Q?wvIzMDwiF3z9HxNwkGWe++mvp3fzp2/TOCvSQNk1OY1vvO95gNEAlZGoupUr?=
 =?us-ascii?Q?iCNayxgK7/fDapDlYvg1d44=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564e6457-a75c-4144-b2f7-08d9ed00035c
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:16.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibozp7iNH5Ik+oY1lj1WgIaZ5yuHmW9BChHFkh0tDoXxvYQ9ucLb4Ypn/IrD+JO1i1RkZAN8RfA6SZnJMiOd6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix with correct shunt-resistor value base on EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 8afaa8f52c38..76c086ea7b71 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -715,6 +715,7 @@
 	adm1278@11 {
 		compatible = "adi,adm1278";
 		reg = <0x11>;
+		shunt-resistor-micro-ohms = <300>;
 	};
 
 	tmp421@4c {
-- 
2.17.1

