Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C8E516AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383521AbiEBGtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383512AbiEBGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:49:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385812CE1D;
        Sun,  1 May 2022 23:46:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8of7JKJ8WajbO7iEaQdEJtnPaET27D73gG7glYcbyHeqOCMiIQtZdbIOVLEd5TFzvLBcSzQht4pL3nlYQ/neg6qhBLhSazRJBXhncCxb/vA1nHq8AT3h1Xb+8ZcHbeoMcE0OJ1hJ8Me1U8ZPhdni3UKnqr5u7taajowBh2htn8ZHibBK54C9LhXn8d0PY5U5GTZWPIDs0rk3xez7dWFpDkLPUHNA8OcH0FNtEH0AqNIi5V+6GO4DNPMmaEnw3WelSy+2SeqxR23rHcwUcANrgbx9WvViD/NLKGI6s0gBmvroVBLFRXn+jbdRTMbjUYtlf3f9Wqeo1zMFhz0aHy7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcHxIlP47SjL8DUajpla9eRJDZIVYLstav6t1q7csS4=;
 b=XlHs5r9bs6+Ccqc2uMmuozm2NBQsF55pv1hvzDk5PwIFWRVCEnDYLzRfN9QlTJolvvwetHj8WAK2EMFOdKH0/8PYBnybIfK+OQPg5JLqAAi3b5oTIRd5xKO8m/sG0sbzhsVfkh+pDEa3I0A6nCzyRS/Ad/HqwAJTXmRxqvYz+fmCTaf2xNB51mmPdqgGlNMnrY0/Z9441929vHL4/iH+q0tmZcW8pNEhtC9vKT9fbKYQVJUdsIzgWNaC0Jws08oEiSNy/REdNi/xthWSwwMqDxdztUPs5r046aR4HKEEmdPactoBoIH7r3w3Fv+mfx/Bh1TR0+pCie8Sx8ELh+OTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcHxIlP47SjL8DUajpla9eRJDZIVYLstav6t1q7csS4=;
 b=lSGLY3J/tPONK9F3atb3TnHrCYS5uVkgyr1g0aVlaNTevKBtvyWeRPPGzblu7h7CAW1104oy4ZanwyHDF0xmI6o2o6AMbo23eDL2sh5ilZxga+/IhZqERdGNAKVNOXIfXsf6t0LbNP2xLCMIgak/DSIj80puuNe4Mp7Ft8EMXu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AS8PR08MB6407.eurprd08.prod.outlook.com (2603:10a6:20b:33e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 06:46:03 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 06:46:02 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v2] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk3568
Date:   Mon,  2 May 2022 08:45:51 +0200
Message-Id: <20220502064551.202613-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::23) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a4449e-b62e-4c90-3089-08da2c076c62
X-MS-TrafficTypeDiagnostic: AS8PR08MB6407:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB6407A8AA10546C6CEE36B60AF2C19@AS8PR08MB6407.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiWqEH4FEk6QCrWuhNOs3CobnOtPto4GXsId+GtXrZeKtiPNJ6qPG5sxsEXAh3KS7diTuy8/MJvFhUk6TPKqn/9ztn2SnlluhUb+OTOLvjh2A5Yo61XQBha/Xj+UX6Pp7BbTHqC0wE5vysfwxOcPfBJTMCIuzeehY6HiSyz0WKNYf/DSZWBe5zyAj8ChRC9lf2D3qnEWFYErVB9qUXnztFgZioc//LYvWMgMqxxtP1WDvVc7BbDx3FwL+WV1Uni0eTdnrpxRmFHIGcmnerYVz3ddIsyK8Ut31xOP7BSMvNqJ5l8Bn+6VPlQBJgRXHpT8PMAuvXh6GOTA9lV2xL0z9+iC5M3VNvKwGpwU3CLB5pkq9pmjGES2z+jJW6gxveHDvfDFshwxrDrbf+zJKmHQYRE1hTZIgoFxmQdFv5v22Gj2BFQiGO4W5VP+NUfAC4XzagSLQK1yjboGIDrUNXKfub/FG1Es1ytZKTyPS2VVXy51GLlqJ8kxeEi1xkBpD53MOw6tJyuNORY/FR9HLjbbQAALLlC2Hl7Df1lyz9sDQTTjTnBTIQm+71LH9UsZ3wHSJHcMaz5f6s01M2uWFOQoVxT5Pc8iCcxZtwrzQi4Ql8Xm5L/cGt9yWSWkeycisMVuFOtw2ReKAohk61tCFpZhqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(136003)(39830400003)(366004)(396003)(2616005)(54906003)(508600001)(6486002)(6506007)(6512007)(52116002)(186003)(1076003)(86362001)(36756003)(66476007)(66556008)(66946007)(4326008)(8676002)(2906002)(44832011)(8936002)(5660300002)(4744005)(7416002)(38100700002)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tms4058hipIzToqYeWaumFXGfUS6RMoh03N3jUT4MMlLkjPCQW3l3DtzSbvD?=
 =?us-ascii?Q?zCvpaXvy7GNyA3yK5DlA2P8a1OqnzMuiQFQncf6oeW3PwbXDs5+4BXQrOvzf?=
 =?us-ascii?Q?cE7arofZp7gsInvRnW0LYRUhhvi8YqXbf5sTa0FkU8BpBO4tiI91EekU8dm8?=
 =?us-ascii?Q?VhitvT/eLY0peGJNx7ppwluRux4FeTM8a0rb/ce7MPBysV0vQC4Ow5u0/csi?=
 =?us-ascii?Q?6gzkQ1PH3ZXlwW3w8TaTc75eX4v6zld0UoKrvSMBe7YuCAIl7lZMSfNOWVXb?=
 =?us-ascii?Q?JcWWPE6QaLMUwpBirL/krOlUm6D16vbUtPCPZ0+vyHDGNQx9TOdXLmfJsDn5?=
 =?us-ascii?Q?EdljshjAVbeC8ISFWspvQl14kwoUa5/McsmH4KhVfp4ndqq415b808mEQHFU?=
 =?us-ascii?Q?8qDom2G7VXUyGHyor9TcwkqwzG96apD8t0/nVbEVzmVSzRk6sQZ1MGbj1Geo?=
 =?us-ascii?Q?+T83oPrsBtZ+uBnQTu+q2rj6+BLd7iNug4NJodtDgS13DSLheVN4M9V1cZAF?=
 =?us-ascii?Q?wdhlhvjQalIejJStOX7deI6RcJcW5M6qinm0ToAzGrGrfNGcKgClUE0ydMDV?=
 =?us-ascii?Q?fOqmkwS4cL0QlgD6QX31z+UZQezvgVPEPXDE+UDdkswFcUAywrCMJZURUV39?=
 =?us-ascii?Q?iUtvNnyJPfij3ifJWGhz7YhTfMIz5aEm8xKHY9StJaZ+0O96kNlJ3VDUcmuu?=
 =?us-ascii?Q?YPouWun/nYe1o4dZQvEhy3uFRBXG7GJ2nC/tgFp764lhtptrQTnOoeGdK597?=
 =?us-ascii?Q?p3dWvdb+LIXp9f+qH0arvHcFlB9afynwgs12hDMIX1PxNAuho9kbMlnkZUeT?=
 =?us-ascii?Q?l47ZbNJgDWSM+2zrg6PntX4RwSWPPAI+sqikgGNQHc6I6BBphp+kkZB0rjeL?=
 =?us-ascii?Q?FwA+IqML9qBEPlpLCzMWGK/wrv4dVmobJseYv0LvzRYJIKk33iGtg5J96Inr?=
 =?us-ascii?Q?mYiq8g6+vGj/3UBfX0T4ZOkwK/P83HoY7iOXuzuv7YHGnXdn2shCXvoB/6TR?=
 =?us-ascii?Q?PcHHbZyhsT+Y0/He6Wanu89nUqGh0WsTIIBNwUHuBv/dMlMUxJz89vEI/gps?=
 =?us-ascii?Q?qw5DsKetJ0RcFR8ll/EMF/lA1qn0jmbYu2HownJXtxw1qg8nRe60zpgUqlKr?=
 =?us-ascii?Q?IgQC6qUNj+8vW6GEpSacdRlyxqTzY+1QJOD6FVVEF0FWsHQTD09MCcVW2DD9?=
 =?us-ascii?Q?JBjGF69WA/Rq+vxPKjJxrH3YAz+IfuQtMfCc6zhNh7LcWoiagAs94lmEj/MI?=
 =?us-ascii?Q?JCSDhsb1+K9n0OodGVQteWBsbhgGJXDbwU/rrDnISkOg2DNqFAfu1UI9Snb8?=
 =?us-ascii?Q?LMfMRLgvtUfrWDM8jXNGGNwmt5nnCZz9Wi87jFb8BncktTE0KPSUDu5I8rKt?=
 =?us-ascii?Q?r75ZiBPFTAnRA25z5vays1yO6xGlcwkgXWr9/FW29WBXQvi/EpGic+p/ARAh?=
 =?us-ascii?Q?YoVPsDz+QrnZWGVL5pGcTgwSrB+nNKD5iSl80Icwm8eqkcKOjXErPE0DlMAy?=
 =?us-ascii?Q?UryP7O/1GuujSjdpu/wT1WVOWYjF1NjRwuyBF711YU3fwiwJSpPcUEVcUWTr?=
 =?us-ascii?Q?mGIvkkEx2hxKJNajp75dtWqthQLEQzaavXPTDJWK1mal0YofCaLvF8vRUfF1?=
 =?us-ascii?Q?0JLFdRMoBxLHmgC7udiVnXVLPAGYCcCk8901fZJv7+W0Quj/jpbTQU1PipK0?=
 =?us-ascii?Q?H2iSp/0q76MdcxTfHBpmISFnh9+OyiGL9WI21WUzZtqcfvO7Clb6Grdx/8uX?=
 =?us-ascii?Q?FpbnGUlKI8Dq0vpYx55r+Z6zpapJd95+Lewq5Wjj2u+bRC1UfsRjREhe2JSF?=
X-MS-Exchange-AntiSpam-MessageData-1: jtMTmOuaVkUIb4Mh39hjS9d62tOxPKomQrmhbupK+tcOTHCFgZLLHpQG
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a4449e-b62e-4c90-3089-08da2c076c62
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 06:46:02.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoyY/btp6ems/yy60LJvKX1ZKSJACQjE19lAW1LFcwxpb4A7Cwrfuv8SKsXa+QAsTiSCM4CXGtIW31K49vSXDR9dSx6ggXWazSXusEuTc4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This USB 3.0 controller of the Rockchip RK3568 is capable of OTG/DRD
operation. Enable it in the device tree.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v2:
 - As pointed out by Nicolas, this is RK3568 specific. Moved change to
   rk3568.dtsi.

 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 5eafddf62edc..bbfe8f3d68b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -134,6 +134,7 @@ power-domain@RK3568_PD_PIPE {
 };

 &usb_host0_xhci {
+	dr_mode = "otg";
 	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
 	phy-names = "usb2-phy", "usb3-phy";
 };
--
2.30.2
