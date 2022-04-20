Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699750823E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359832AbiDTHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359834AbiDTHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:34:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF1D3B578;
        Wed, 20 Apr 2022 00:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM5qsSeXq4rSzC0C/uBOLvzWHzzIPz3+ZcqFyLxaQb77thaKShj6l2iJ7zfSUSIK6zRZ8QeJ+USDQ5xK1WgfG24W6VysY/TEgPRJ9OxSZrxsdZY4bpUFPRsRazr7n8I0qq5K1nUD9fSM+zyh48VB+xmmi7MAHjGGU3vr79C5+Q8IXbL8t2T0P0Lrli37SgNn3M2ju439yLXcEu7RzN2hCZ0z93JdtWePck7xlVaVf8/lsMsP8AZzt7xHP35lamJVErZ4+ft5oivEjyhfflEJ6V2FuM/5GXzYfa0V+pZGGSzPGH3TOiOz/mefXYh4GO28giQKfETOVVAAeUjymnuggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnCe52Sq4XspF8/bw8Q1GZRFbuP3BqWrvcwQB9BibGs=;
 b=fMEzxagRFCpjDxyUjqucO5pM9VltdGiEAGZ+X7Pfv4v8CNGVB5UNvrTwU2ful/eXCt4b0y7DpRqrvhx9zUn1LgK2xNhFUkmladERYAv/GeVB34Nw+cHzEZ177W/Bh7gbNZgviNNC7gra4gBg+MQENz20f7eCgt/mS6fpaCL0yj7TJLd/vK2nVrN00wOyyTi+lxQqBlHIsHC9JBTsJfxrfQtL0WpMHTZipPUF5b8eXzEQvvwK6CPmfBJGCne3EYKR7AKn6x9SbX4OccCzbrNKb2pv31kSjmhmPFebl/iOmtFCFNwz87r4TFl7NzCyr5DxJR7mXBdNH5cruejYwA5VBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnCe52Sq4XspF8/bw8Q1GZRFbuP3BqWrvcwQB9BibGs=;
 b=Ss2lL9Tixwf+o61SwamxF+Xd2mSQP0xpuv4xjfl2zFPbadZWLbi3aIr4Q/RtZqyh0SgM/jkUjvL7hKiZRjqXXjLvYM6kBtMT73CeA4ZRxrzjWoxNbnICBJmIIxMGuA5z/SUq0jh+MVtElkSbMRsSi/zoUdzTiQF8wn79o5G/B7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 07:31:53 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:31:53 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 2/2 v4] arm64: dts: fsl-ls1028a: add dspi2 support
Date:   Wed, 20 Apr 2022 15:31:46 +0800
Message-Id: <20220420073146.38086-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420073146.38086-1-jerry.huang@nxp.com>
References: <20220420073146.38086-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 605a5244-10d9-4008-ebb4-08da229fd759
X-MS-TrafficTypeDiagnostic: AS8PR04MB8628:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8628D3335B70F870E6DA492BFEF59@AS8PR04MB8628.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuWYCswydA9rIcXwVFPLF1M4V47fTe8Me+Ovkq/sg2R1TcaAKil4qINmVDFRE36l3Kr0uRQcdCBUB/Pw9LQdyYa3cgOIsVRKV02Ore+PXFnzAbFQFmt+tNPb5ao6HUlWGaQ05aiA7VaC9sbOlHp7s2W/uY1qmvVC1dmhc5yTSFVJ6Vr6ym/kftx+byPMNyqN7+0y5PuOMVA8JiC7FtQswFls1VU8w4rAtYkT5wD7ZyXffpMiHigub3UmV4pgiVFObnkxhoRgdHpalDTcPpaLUyYjLWR1m/oquMnkCVkaT9BhFrUMHqdISyNSSZDOhCd//OvqbNGIBjO0Y3y+MxVtndi4TkVZNFEX93IIadvPf+UOcTG+IieXWVpDIjkSWTVAsxS+JvVzFOQ0WE0DYaeT+OeXCTDrmjhv0XdKQVhstYPSnXHdlotK9z4+Y/J7tSqLNznyPQIQjV6LOhtRmjURX46RfKDCQ2/WcOee9AWFNwFF2Rn4UafNqk/ZAf3InPwGEXBTdFIvwcmBvnhg+DmNC51j8+yLPMjM0gL3/Kd/D5ArFJdQP519mbzbn602YJVpE2hc6Z7ooekWSd6OhUIcNJ0TLhl9/N5B24mQBfPr8PK41KsWotzI0uMGMwBpXvEpR7drUtvjfYfY7NVB6IlEB/aCJnv5qq2crD00LGph5wXHcrKpYfYdF23FHVsJPQ0g3E734MXvtydVFizTcWyybQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66476007)(4326008)(66556008)(316002)(8676002)(36756003)(66946007)(38350700002)(38100700002)(86362001)(6506007)(6666004)(2616005)(1076003)(26005)(6512007)(186003)(52116002)(8936002)(4744005)(508600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQK8QcOny54XowV2cXC3ynET3ttT6lTVATiFhLNpUUuXAA23vMZZIrV+K0Wu?=
 =?us-ascii?Q?VdKsRotA7RswooMwd0S3juTY2tCBwwW2xLIsNwiagDZL5YP2aWPhqPQZk755?=
 =?us-ascii?Q?HOn3YLz1V8lSDwpmHUAUMMZIc0+PUutQOnSCYyyGK5hLYBE+d8fRyBCf3q8/?=
 =?us-ascii?Q?Y6lG+2Wen7TG6plLVBVsZIBSGoawK+BSUavDt0bTdTAHnp0wewHkPtZfdUTr?=
 =?us-ascii?Q?Z0gyMffyUTosBUJsYHIwBBDGIhpnqLSGJ9XsC1VjLk+zdO7vf88VmjrgQdih?=
 =?us-ascii?Q?ELt8RF6a+jhk9rvBJcoxTWWNLihxgqVBfsM5GrcVRypRY/LQqMtM9NS2iH5d?=
 =?us-ascii?Q?QwtoJrDseudXKlyTogeRVmsCoAS5xGLIaVj4c5T3MKpwX1RpIVULHPkzQOBU?=
 =?us-ascii?Q?NQdN/GG466mZS679Ztm2e7b3SNQoOuGihy+0k1t1RhygqiCQ0sFb1APh9911?=
 =?us-ascii?Q?3ik3ib7Wo5urBnX7u1TVWetIbML4N4plplkHmMQuzu17YVQpTQ7+0w+BG70v?=
 =?us-ascii?Q?E1uUpaLYijg51oqemdPAcRp1JVKkV2qonMDZYhwXFaCgkGCCx5295jLKA2W/?=
 =?us-ascii?Q?J9CANDOvUM+YUQjQGI0VuPBZQfT1qn6QTwxm3Cf6/lwtcfgxStp4wu3T/fYp?=
 =?us-ascii?Q?L1MiModV8hPjFgi/5w9RMZkHy5Z37qZ8CeYfvWDrOarKLlKxccOQh/Xmfmhn?=
 =?us-ascii?Q?7DCFTy7esifajDjUz2NUjDCqgIz/TUNyASMHIgCtdsylxno1grWBLRj/IH56?=
 =?us-ascii?Q?Dtks7Tm1RENvTQwjSmSjU2AlhFeqC+Dzb2MovFynbwYmdAoJmzaWeTBe8/4Q?=
 =?us-ascii?Q?RWyqaDZ2Ac7Mk4zaBxdZ7ISX/fsvrl72sWLJ0YY0UScgatcpPhu3TG8BFpuV?=
 =?us-ascii?Q?nf4Usp39pfbbL4sZbdlrNlLCgHN0tfAeVT+gJhsVeFwspnROABykM4f9Rwro?=
 =?us-ascii?Q?i/jf/qC6s8ZcWoeEWoHGeFqKQ29Xxyl6t8yXw4Bz1ve1jkV+vnA9nYUAjNGW?=
 =?us-ascii?Q?XsOpqXH/r6ekxmgm2Oxo2uJJ0OvjZ9amW03r/b8FxxpXjdn0XPyogRlG1fd3?=
 =?us-ascii?Q?caNKWp7rGSJATKicbJ8ripF+IdCpmGh/37q8m//aVeEQYkYof8edQyQeJCf7?=
 =?us-ascii?Q?t76I8m0dFL3soxiLx1/qQ+vrkB2mpl2btpAFwL9TS0JWoxzwbibnsqx3aA7+?=
 =?us-ascii?Q?pX8N4e/gfEjiIFjnuxo9FggsLHxxPQSRGtYhCGF2tZQTUZQtNni8Oox8R2i7?=
 =?us-ascii?Q?LPDVzynbf6cQYcEapwSo0nSKLiYAxlKCiqeMcnoBQUktv6ypYw+ETsyQba+u?=
 =?us-ascii?Q?iseK2pSWYLfGi04LnUYA0b/8ZvWnyOuU7/X1liwWeTCpuG4QT+5l6kYWyXVy?=
 =?us-ascii?Q?euA2+ymq8O6OUeXtr8R+zz3UhWxFl0u1QNpVqrKzMbOMfP/JhLcXW9+lnuGI?=
 =?us-ascii?Q?B4K/Y4eepOSyYO3ReUc6XItPqa1j6syO3QxNiq7K5pwU4Wm0hIU7z/S4N2jd?=
 =?us-ascii?Q?M8s9qcsILBPeNfL4MfnEylJ3Y7HYmRv8lPMOf70o7DZKOQ7t6E978/RKtlu2?=
 =?us-ascii?Q?MyD4Fx+wykIqQxXm+btMcuTjbvqF9ft09rPnv8SD6JJXiCfH5mbbNHKWjpsr?=
 =?us-ascii?Q?Vnps1dezLi8U5uc7jzCv4UXMlFJK39XTk8b0XnPJXZqH3QlQ+gkuIZLEqH3g?=
 =?us-ascii?Q?iF3/ACbqxzjrW38YCrWem2Wk84y+XX7IWKOiedMSObb54UKZn9dvUvC+J+Ko?=
 =?us-ascii?Q?9WuTt+F0ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605a5244-10d9-4008-ebb4-08da229fd759
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:31:53.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/UJIXz2Zmm2WpzwQ6SvVprHShNqSiMxe9wQ9PQQlnL67xGRRq3OxH0hK3HSVl+/4FalR1iu1vkc2Tz+63DeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MikroBUS SPI port.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
changes in v3:
  - add the dt-bindings

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 68c31cb8eead..6d0508d5abd0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -117,6 +117,19 @@ &duart1 {
 	status = "okay";
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	mikrobus@0 {
+		compatible = "semtech,sx1301";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+		fsl,spi-cs-sck-delay = <1000000>;
+		fsl,spi-sck-cs-delay = <50>;
+	};
+};
+
 &enetc_mdio_pf3 {
 	sgmii_phy0: ethernet-phy@2 {
 		reg = <0x2>;
-- 
2.25.1

