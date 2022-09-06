Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87FB5AED9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbiIFOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbiIFOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:33:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB5083059;
        Tue,  6 Sep 2022 06:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3btgql9/7JAESP7P7+rkKQvdxG1dCn6suINiujJ6ZUTi/XUbTJqdtdwv1LkH5qaEwRuIiMn1TxHSCM1r9vh7ZB6eeM17IKaKz2wQHK1u8SvBG2gg6N4BD2q93DmI/HL/MQpXTA605l6nc9n4Zj+1dAhBfyfkfmeDgzQHVhxAmtt2i4WALNexzArQdPXPT0neD4SGG8i1vGYoqjljcSHPxzym96Z4k4cfKB8LCcqI+bPLnRNVttv1/5jz3vWpTBswZGXLiaNBxMt4iYAjVCleVp1ey9IpUuUGR9iVfJ1N9Xiyf6Ivk2KZzJG3uYi7R5Wpom5DQnC+HB9mosnsJXM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=IWJAHAYEKYFAQ0xhIe5Q33fcLQBOkHvhHc5JMqbK8gIFt5aUcOp3t9X7CJ6UuSuyNg0mM8DK2S/FCXdWzbMj/VrolhwiyLPwGMe8v5GRVzfZxfLDiOytbhu6rImPUEKc3LJkUjX9an1tdYVfQMOhFlmKn85zyY1ea0Gmq/2UBgRiRyK86iMnRixQqvWdcKC0Kv5CTuV9a6Gdn+0isL1KimQ6xs4o7cbQAxctn2+lyzq5iu2zcB/MAFChI2keG+UGQYPZsus5XpzRznWl/sNvKcqC9VxDNDQZdwF9fQm+x42cssgifAilRS++Nrwubtkhl0TLSV+YO4bPDd6XrG0NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=lggqb/9oI0wtltDgO1WV/maXCSCzDnXCsKjYTR34CQdx4DdDoBHfN2Ymy23uZvl/CdO6KwUJ7QU4nbKV3inC0SSu+IxFmX7aR3eNmo8RKLmW9w9AUHrUTeDnLqboZU9XNJp38a5qHqyjS2bLBKaO9D0BOE5r/5sykrdLh9VN5ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 13:55:38 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:55:38 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH v7 3/5] arm64: dts: imx8: add a node label to ddr-pmu
Date:   Tue,  6 Sep 2022 08:53:43 -0500
Message-Id: <20220906135345.38345-7-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135345.38345-1-shenwei.wang@nxp.com>
References: <20220906135345.38345-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52d5cc26-34d1-4470-17fb-08da900f7a87
X-MS-TrafficTypeDiagnostic: PAXPR04MB8749:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nHQIixn0yd+3IJBdFm+rCN1NeBntXYaRYvApumWNv+YJKydi4zu/ecF3v6j/H1i6nMvmAMirn6vOEKSKQc/ONdl2U3jELz94REoMszjD7K5uFNFR8KaswcNtsnBzVMGjczNUTS/0uZCAAZgvE1irD0gHrEJVZICIoi9qjjZ8CeQO6gB1DAOsEAIpJ0MueczsH8O6TaX/oWJSY+HUwGnYyKl6HBtRak30csSBzsh8+Q7c/PCbkKt3fNrYEkgNSoqMRdNVzNBOhq85HU2EEPb21ISGUfN+cj36pi4YP5GWMub6y/5bOp68QOhIbsJvauryMD09MDbBRQbKzvLXlLS+4C+YhyXqH3teZ+gmddnmkkAtNSrFOt12hFdSYFI6qldxrlsCmtPGve9QQoRhhjbNbJpNTaq1o4kAfdA35DB7CUPg0xOQ0V4YNmEP+Mv20Cbi1ih6/cqY6aenB3wO+x1qUa35NI/lDuNGkmtB/KNtPfZUn8D52Xi2p9wv4HwsBO8Rr65118PSEK1L2SKcDkwWvB5rCQS9DPuZ2yluB/SU4Zw+eOKmJ1SjeI0QLXqhvSqovCW9sz5Jv4xDzu4Il5KXKeI2GSQfOPVXootWJyvEszBEgR+lIliM1XCFquVaWvpVHpppW/uy8ZlbS3z0+SyM+aQ9TeNjHsr4s6+0wflQyPIC8gVrlJ3U/x1cdtkwvxJYHaH0Q5toTNJehN1EphLxrtV+N/O/rqAPMjtar3y2jANVW8fizqgMV0qZlHxW+Qs/kFjdYOWqw+T8/ZZaXVt0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(86362001)(36756003)(66556008)(66946007)(66476007)(4326008)(38350700002)(38100700002)(6486002)(6512007)(478600001)(6506007)(52116002)(41300700001)(83380400001)(6666004)(26005)(55236004)(1076003)(186003)(316002)(54906003)(110136005)(4744005)(2906002)(2616005)(7416002)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFvzxvunwY9Q5IFr1POZlDR+7RAco4zewIOl8op9XuNoor8PeYfnp5q5e8w7?=
 =?us-ascii?Q?bZel5u3Q4G7VJ/TyZL/x7veuEQDluz5qqcrTbJSu5pEBhTe0eNEHH98DpweW?=
 =?us-ascii?Q?aCEnLbVrIJn5xb5en6UA4Kgl20To52fMvG+DAOsUjdymLnHTYNj00H14F1gU?=
 =?us-ascii?Q?oGM4PAlgUnNmTTJab9/sy+jgEFVEDxiSx8iPhGAtQx/tiZsm5mhaGji0f7kL?=
 =?us-ascii?Q?/aHt9i8LaZ6ddHXVDht7J7mgl7wdXkwOZg5OpS140+IyRyhMfgQpejnwVpH1?=
 =?us-ascii?Q?kabcO8iSFnV+v15w11D+yDAF7Oguwg8ODe21SzU0HzQdMNTtS664opcnj2qw?=
 =?us-ascii?Q?m/SyXOPzTfcj8ok/zWadOFAxnXo3QigcZqqB4YI1KBcrpJ59tgPdTCZ0pM9h?=
 =?us-ascii?Q?0+rKezV0ZWT+FrmTuWAYLyjQkDii8VX4QcOGy5QXvLBk7bjuYlh1SksrzJEg?=
 =?us-ascii?Q?8ConFFW7nfOZBKksHWoLlmE/ZhvJ86wEgPflLoaYsb9bKRfCFCvUAEbsj1wT?=
 =?us-ascii?Q?yycZzhkDgpZJFBbsQL63dRMxy80IEnZ9xwFwmJYV0ID5WmskEE0iv7YxdX2n?=
 =?us-ascii?Q?JV624BsYXoDmFxmEJC6aApQ9RzIUJI3I/d7ZJKoOi7YButbniJKj5FiSTZAH?=
 =?us-ascii?Q?3z5pw+8rPviDNibw3+qmhhGTdcYatUbRYprpNDMZEY/8aVjYDI6KZfplMyC3?=
 =?us-ascii?Q?nvUQQrIqHY+s2fwqhT7x4RbRr6jmPI9yRoECMKs0zW2ORuYkPd2fnXzzX3vu?=
 =?us-ascii?Q?3PSqRxa7mkZ0bHUww3SOjfn9RanWBuj/O1ahDNPiLk0nVtz6j11NanQ/mmaP?=
 =?us-ascii?Q?XoBFwJ0deJ6QPzec9ZEKSNodO8Hjsa1hELTxFDUkYxZ+IHaox6aAC06nCXDm?=
 =?us-ascii?Q?o3FZBZv4qbC2NzVYw7HYszxBbR4bGJEPdkZydoNv8J6E7C0I6Qts1R8VsODZ?=
 =?us-ascii?Q?4SbbtvP+RcKULMPJcqicoF0/b9HD5qM+Y5UE0ipRDOHtFG3ggBHNf5a735hl?=
 =?us-ascii?Q?hMTX5/Eb4Q5KuHHR1OKnVRYqJI7RBq9GS6kOr4Ng6W2uuMboZx/eWsXyxgBv?=
 =?us-ascii?Q?cRf22ypRJIjlhx9yTajCIFs74hlF5vQv9/cK+mxj9UD6j2y/gZdThpHZgeRA?=
 =?us-ascii?Q?UzuA70P4gLaYITSjeNHYkodI83ZOau4QxdpnCF7uJo7XbSEe2DtDwuP/MjUj?=
 =?us-ascii?Q?IkqcuNVUaPKwqQ3iXQ/TRl+rChPLGQcQcQ/1J/qEWjOAhocbHGV2Z+jo2I5g?=
 =?us-ascii?Q?iPvoRbBQutwW5UkchlpGrPw6JAqPgxbFFE/yZh94UvKp/Vg1dVt2K7G7sZIt?=
 =?us-ascii?Q?1RB4hQduvTdIu4ozBr029/40+AToNw04ccJPbVKyTx1aVkcnLxRbheLU8n45?=
 =?us-ascii?Q?+BqwIsFQ3YacL2VSpiBTjuJvWyvZyQga+L0dDGARtMUTRF7hNTEvqSK8LUG8?=
 =?us-ascii?Q?9UHVfg2eEGraJKbucrv1xTE0JxniU4bwzjqROz04Cz5GSy0W46WOKyQYuxnH?=
 =?us-ascii?Q?XnooM7UFA7UMExNf32kW89Y/mK2MD7/QxcHg2S+bcZVpjpulLMiJeHM/M55r?=
 =?us-ascii?Q?RvGRvFdXl218GLqu0WVZljZFIso8chotmNq+mmhM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d5cc26-34d1-4470-17fb-08da900f7a87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:55:38.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KPRksk/aE134JXnAYCdL5RrpoO6maI3GcXXJrYMHop9XD0y9HgAtP0jquPXooEhZbxJxUlxFFKzFXT+q86LfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ddr-pmu on i.mx8dxl has a different interrupt number.
Add a node label to ddr-pmu so that it could be referred
and changed in i.mx8dxl dts.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 8b5cad4e2700..7d5183c6c5be 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -10,7 +10,7 @@ ddr_subsys: bus@5c000000 {
 	#size-cells = <1>;
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
-	ddr-pmu@5c020000 {
+	ddr_pmu0: ddr-pmu@5c020000 {
 		compatible = "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

