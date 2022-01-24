Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B599497A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiAXI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:28:25 -0500
Received: from mail-gv0che01on2128.outbound.protection.outlook.com ([40.107.23.128]:41184
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229800AbiAXI2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:28:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8pyt7FdFPbib5r5cgrcaZqznj9VvN8SpTcUTWjYT1Rray1jvTWB82WLs1vFG8hRQj9BbANsTq4mX63qkYpxaFv5LOewDQU7Dxf3Z1u1tPwymio4+U6xT6LrI2YCYDi0PQMpyh+ZTT28dgQxbFpScK7twSU9B4ICx0UzH/+v1Ovrd+vDxEosAQkwQPuen0miNfsc3L/kQNqepc1yTBAqqHtltezItlagGIuW/GMAe1bwesmsEgSwtw29hAm/qvMKU0Ab9JIEhmCUYTfIfsjIMe/i5jpo2b9NkzQC13DPBdyuBOpXb+TL8OWunxJltO3Jo3xdp+nQsJ6Z6kwR6ftxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWmaWbMbNAfXdTupUt6m92kFhXSXdjA3e27dLOocQpM=;
 b=DYEart3L9hx4IWpBqF08beusno9sdGymgSAxRjwHMMybTV2NVOqbFkCHnoWOmp2yRRbibrwfAiCAMat542e+8HCPHKwR5svo9LIt5J2adBVo1OLb5IMTfA1S8WX4tty0iNAHe4CradsTNIP92v860s60YkHixxa79fCHkzj1gK3RzlATOsDblxikln8tJUDsxMJHBvdzmhhnrcaujs7pblTUS7NaIBaPCfaXWH+JJRzg5KdNX1xyh5k3XbFyYpg58wAORW/OHXj9o+cHJ6lCJVYWZ6MKXwr1YcqEuA7EFs+yh5S6zDrBbtIri+zIdHjrNaQLvCE1FP3bLmJ//HReEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWmaWbMbNAfXdTupUt6m92kFhXSXdjA3e27dLOocQpM=;
 b=Jq2pSzuCvGAowhmUwNm5EM/dNDQ4d6tArsC4RGsCrD+2xrwKmZmu3WWgnlVuioPBTfDO+mBfEIKSdhmM49W2pb0OnydfvS/Nw7OvS/u/R8qk+DEcRjwOWvSiD2BkJxXsBFSq04GE8+CoTrdRL36Pnm1Y40Q8/4cCNYL0R6lhJrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0227.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 08:28:16 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:28:16 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/2] ARM: dts: imx7s: Define operating points table for cpufreq
Date:   Mon, 24 Jan 2022 09:28:02 +0100
Message-Id: <20220124082803.94286-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124082803.94286-1-francesco.dolcini@toradex.com>
References: <20220124082803.94286-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0052.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::21) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985b5869-faa1-412a-f6e5-08d9df1377f8
X-MS-TrafficTypeDiagnostic: GV0P278MB0227:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB02270D0C8F6C7DD2564D5825E25E9@GV0P278MB0227.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HfirZSyT0lSY20COGAmWXmCjEXIrwl+Yc5Mb+gUehBItrKD9k/Kh6XmcpIU6Zwx422jgSYc2TupwsVX4U556leYIT9u2Ssn1KWmqAqrzQigfZOLvUvSCyrCpKun68ID3SZrAwRsy4IbDV1mpB6xpFXeNX+LIUoSfK4xLBdaB1DPdrtLEA6PpSvp6QgK/KIDmfZUdj4RhxcrQ1YRcbZB4faS1uSMEYYER4tBL9tntZlVZf8SrAhSJ1PsuSlzXb3S6ECWdjbEYtk0CQ6RGN1HLsElPMloOwC/97xnPSQddwf3Hw3SyCJE6S//xUi5kELXkKkUyGmbuPuHMiz769ezSDvQZZU1Wec/e1Zco7CSWNIaP8ybXvHenj8J8dj17mZ3mtmBDEIvGFHUorgVwl7vMdMmx8gwl3vwRBfUXcu6d0a7yXGYOcbzTKK8HneMgRdco+XXxVxt06avRRaY8V9BMLA47I2CRSiqwvzuPuoATxIpy3k2QukKRMKiF91y4zCw/SpcRZHdRNI80EbBvfeRS1/AG+A2dRxs4bFne+w9KkOqiI98+VCK0f5YQ8dSjnOZjIeeygWtRrgWnTrlMKWRwr6XDV3Ssjg62DQmNmKfgP7etSyJrsxo3sPHMzxKgTMd/cOfVBVZswZQn5CnjCkw300uCo/VJpTh0bgu/oCTWT9K8C0PCFyAEJY5pow6SfhjxCfRp7GwMtwTnu5Jq0srgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39840400004)(366004)(396003)(376002)(54906003)(52116002)(26005)(1076003)(44832011)(110136005)(83380400001)(5660300002)(38100700002)(186003)(38350700002)(4326008)(8936002)(8676002)(66476007)(2906002)(66556008)(6666004)(316002)(86362001)(7416002)(36756003)(2616005)(6506007)(508600001)(6486002)(66946007)(6512007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGg6Xr1jvGCY1e7hwCC57gQPz6qyLgx11HDp0dOgeXG7+m2PJDmwi3xXsTw3?=
 =?us-ascii?Q?CqYQ3hzjCI9Om6yXKiPoIYOK90SFMt8EOBSUabRCbkAq4tMF1bEzOkUpkzq9?=
 =?us-ascii?Q?TT7hHFS0Dh+eSPz4QQXr8Y/soTol/XbiKGPOUd3XixxXXyqbDAmzxfYhUU/f?=
 =?us-ascii?Q?pBjut9YTtiU1AX4fkFFnTLiESCwl/9tzcAmB4LxJeXd6WtITxRNIRp7JCvip?=
 =?us-ascii?Q?3GT3urGSBJo2J3uYseNfD2y8nwRw9gQrCyKLK83xgpFKHfcy3g2Tvx75hZ9t?=
 =?us-ascii?Q?f7VsQcVHQPFpeQ3C8Ts5FWBgV9oZLG6uudb2oeE02TaukN7Q2wH3ZO37H781?=
 =?us-ascii?Q?gu9Vmj8f16YjXV9bCf5mzSgAlBRzQZu67F3T6nIQm9sngVPk+VTrTC84PEv0?=
 =?us-ascii?Q?2uOsxP8i82gaUnZ5DOBjw1gZyIuMFC+Mta0WQAJP/izL3u5DxMLbiDyogDID?=
 =?us-ascii?Q?DIivyVBAsdEwteKrD6+de0102s8fYpmAILnSxsaSstkkEYZSyU8M60a5oTFS?=
 =?us-ascii?Q?syZ4aRV6Zw1eSO53hv1nbT8WploivDopUu1dV3SKJiClOsZXZDzJKe02is34?=
 =?us-ascii?Q?KJADqejURCP/gZVFRrArvQvGiVmBGK4oWzF9av9SPeT0+32rPmu0Es8LMG89?=
 =?us-ascii?Q?w9hDn8JBsQkw/jvNZV7yPyWApNUVxylLpSaMpsPJbeQ5eUjTqbCbVMey5G85?=
 =?us-ascii?Q?2P3jX3X7dt5Tdoh2Xko/IxEmsOxiTz9wUH/XFAljzFA98Ryt5zG4CJYqvUxg?=
 =?us-ascii?Q?bXduJEUscmuKZ1ug82gzaJybfbl6CmShwR5ZTrOPDlkSXM50Iybu14hL/iP4?=
 =?us-ascii?Q?ELquSnGo8fcDfqAgGEGAeEXfgLj7Y7jyMjldmUBUnVPfmh36tGP+RoHNqc6j?=
 =?us-ascii?Q?P6xrYr9RaWRJEX/CG8x+jKNxl8onGXMxaKx/1Shyee2D8PVm8YgxpwY0Ga1N?=
 =?us-ascii?Q?0hvTyAJa2F8snuGDQ0wwUN0P2XCZyAapTHMN7L12JFwvFoBRrt1cfeldz+jW?=
 =?us-ascii?Q?ryQdRMFBqqU4PSm5uzHx3yg/yajEF5m1UrBzifRTwrz7O9jMogpTZpbPAgb9?=
 =?us-ascii?Q?3LtQ7+Uq46KjlCYY2mGk5sH+dq77wyOmfs7UmsE9w7zbGtdnq9fA0jtU9GV9?=
 =?us-ascii?Q?h71uMBFzUpcvNH2gfrO7wWolvK/ixOhSDlcPMCH5nyqXmsuePxEyNf38B0vN?=
 =?us-ascii?Q?+zd1UlxSD4seGOwa8z5oUfgUUz++XVnQKhXPpVQHoWppQE03XSxixPMGXk/1?=
 =?us-ascii?Q?MOL/tMvHLmzhFGZTnMsk4nOB3v6rJtC5ad0VHSPAIwqcMfVDzark2emVTit0?=
 =?us-ascii?Q?m1djlN6WfqQ1KHFVRgeqztA14MPGbTJIfcF63f29dU7qTghMiR3utdbv8bq7?=
 =?us-ascii?Q?/t0X7Szkqc6R0+1wqRS3TQ2u+A3LJtLLgN7WlgN5eFgxySaZ0FzHXQhTVwDI?=
 =?us-ascii?Q?NFxCrtQ9OdHR0m2yRaVhuyWP/hoOrB/3Dgh9j9NW5OjUrcjgz48CnEKsLgRq?=
 =?us-ascii?Q?xf40O1mmr3rv1/eTll086G8p+i7C7N7XV3jP7tmf45MilHA4BeEgzHPfFjIe?=
 =?us-ascii?Q?fvK8EIrBxUS03D5vc2bgcqeQOIyswowC64Dp5c0wn/9IWDZvMEkYcLiIjFua?=
 =?us-ascii?Q?GztyW9l+dkAWmR6J8H/gara3qeR1oAjEsVc6Tdghi1l28+UaLlXh/KkD8iyO?=
 =?us-ascii?Q?yw2V+w=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985b5869-faa1-412a-f6e5-08d9df1377f8
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:28:16.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaYwZjiZ1I5yM2H9KaD9jQHjM2JXQYWq2yaSZe/6lSmXkIUM8wX3N73iCWB4hLMbTLML28M6zXaHVzLjpMLqfbFroDKXlQdcQqQ6wEl+CQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Processor operating points for imx7s.dtsi should be properly defined to
perform correct imx-cpufreq-dt probe and registration and provide an
access to the temperature sensors using the i.MX thermal driver.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

v2: no changes

---
 arch/arm/boot/dts/imx7s.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 52a9aeecdbb2..5af6d58666f4 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -76,6 +76,22 @@ cpu0: cpu@0 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
 			cpu-idle-states = <&cpu_sleep_wait>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+			nvmem-cells = <&fuse_grade>;
+			nvmem-cell-names = "speed_grade";
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+			opp-supported-hw = <0xf>, <0xf>;
 		};
 	};
 
-- 
2.25.1

