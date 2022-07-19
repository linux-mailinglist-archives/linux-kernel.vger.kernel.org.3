Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB85792BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiGSFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiGSFtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:49:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB72F003;
        Mon, 18 Jul 2022 22:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kazSf58FQZe5sHBf6FbdsXVvW5hpILhhb5o7eRTOk3Y3R40H4OLMWgVyy0LlHuLYS6/OYcrag7dcDG4bJRnejWZU23nF+5xGwcO2urrJmqmoIdb9gwJ3jLy++OcHZSyalYy9319lSUeM3NXOacH2vGNcDuYOMVwyeXLB7LJSprBh1lwTepI0jekQwduiH6pBpKeMF62EyLbzax2uiRvD4SL8DrwvWOeRJsWuRO5x+rwvOcmohD2TYL71SREuQJmQMhXs/ZXAPjAPVtLYG7WTdIDorediyebSUkihI9SU7ebqSIM4LzUongmBWFJ92QEJlo4oblwg01MfDfMc7a6DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f77LvFnHuEDLpu39Wyg6gl3cytTb7OfhayJX0CMNYI=;
 b=PrPIYquVKjxw6kuHNn/9gtvhAkd7vzX4XKHnK0OwQUNRNf3OofNpSgv1gte8LCR+dYqa5SuJ4wce4L3uutb+1z+at/2yR6qhze+aO8qxiIKpcXfvnrVhpTP++bdMl7TrDB4D50qD1ArUttkM9WFSHM5/JLnNgTnXSoh5NQYyAZ9vyzTdYNjnf9+w/zshyeT/MrV7zq6NFJGLaGWNT7d37POTX/SBcmicrg6288X7IEWt9feVdubR535VWx7TqWh96Y/dQUe/R03YP/4o2rIrxLWpDlAkiwAyYkRg+UWRJxIR1RduFzN/S6w22aYb98NGBrlq9zAT8kqtIlhgpCs3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f77LvFnHuEDLpu39Wyg6gl3cytTb7OfhayJX0CMNYI=;
 b=Q01K7j99y53Y+qB3m32ApD3P6fMJMeuhwHqrhiMKy9btUo4HmMMqnnGQEVUM843ZHG3Fb7VrMtoUE0TvwXqmRlbCllTU7NESKXzNcBnz9cFbugjGEy1tKMSgM4jiI74DP45cvNGQJ6XRulGIYfFqN26K0P13oXqSJnpIbJwF8jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/7] dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
Date:   Tue, 19 Jul 2022 13:50:48 +0800
Message-Id: <20220719055054.3855979-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4476c92-e37e-4f29-e62a-08da694a73e6
X-MS-TrafficTypeDiagnostic: AM9PR04MB8145:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PC78MvYstTsfImvDAZGVZCz2lm+i+Taar6o0g9Eg9Ydm9+CkN4Z6W+5kxuBFROfZWpHmY2lT23OLM3hgfm9ZvVQmsU/cKXZnkNzJsiodnAkx0VxuffEwUon8GC2NjG9ThI7W+FpL98s9rcut5OF06iDuROuJ6nx68vxgqxS21TZbawb9Epa1Kvmvm5Ns0ZLzZZIQf5SDf09uld5TOY6NHF96/jwMULWUGub3IAeeoNJirGj7QRGQlXa4wInF5bZS70K23D8hsoTM23IhaWbumjHYSjMrWd+JBQ6tcpK5e/3DLa4q26aEQD0jpjobYg/UF+D3oTpXAmdbHekrwxOlX5JcLwGz85O+oaAr9Xp+XDZk93UTEQ2wSEHPLdtAWeps2j33YJdd3+gFNMOXaPNDj+HuyM05qu7zqtKq+87+l2sdof4cwp+IHdbU1IexCSI18BQHCIi/NKeapy4WnszKq9Tday8RmfySL24X5BdJ8/MeSYV8kf0XdvvXNDouDiBOUP2HpKiF+j6873U09byK4dvz7LQUAQnMavZs+h7PR8ZQuV93qFngIdGqThw5+YN1E4mfu1pWQuS5AzCIMPUno9mCKYOdXd+Oj6SwTiah+lCaajc9rN6t9MDgwso7gRtpr/+Ec6eziJkoymmyN3Lkc94lO0y+ZVPvp7RaTlV7LcXCIcPYqKgStZe5PME5NlEjtKi6Gn8irLLeqizq+naSTQmcqP0nTloVgk9caa0l0KTAmIuQ7I5pTo4xW1YG6+bgx7/QFur6Vth81ZLpe9jf++vsy8G/hnvW7kXDk5BTAdLe+tYRSEZTvdIa5dFDNSjPbiosEx/aEmwCzZpmSb4Fhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(8936002)(5660300002)(4744005)(7416002)(66476007)(66556008)(8676002)(66946007)(4326008)(2906002)(38100700002)(6506007)(38350700002)(6666004)(41300700001)(6512007)(52116002)(478600001)(26005)(86362001)(54906003)(316002)(6486002)(2616005)(1076003)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwTOEYTOTBgDYCiPwP6BSaK5dKUOV2Q8DHKpvk8HCrAfUPLaFyrbHaPsUMhu?=
 =?us-ascii?Q?IC1O0HtDKpuTFi1rJx8GK/g+i2G2yaWA6MLSYxvaKC62bkgLfvaSpAvXT0fg?=
 =?us-ascii?Q?+hUoitadC8m2+53IA3F4kUmMhiJcL3FqVLFrY2weEySW/Z1xfYStfi3o2ZG7?=
 =?us-ascii?Q?KdfAUnfLIaYGpbhC4E9DoHx1I6vg16I1DxeUP9FG6/kRlKRilJqImb5dXadJ?=
 =?us-ascii?Q?gNQz2iWlG7eg3P++HqHyNZpxvBHlCu6kZNrCq83zlN+qwhk4vQ5pjdiiLtAO?=
 =?us-ascii?Q?6EKviOMbJLDrAvo3KvY1gCr5qIg9qtTgbnRFFIfqDkqhv3BJMotvvnJoayeG?=
 =?us-ascii?Q?Fla6itD1aylEdQoQoZMLALgPNqZBAOilD4ludPVBAypBO7RGZFUzhysWjAlC?=
 =?us-ascii?Q?+Bvj4fuMtxkxKe4qnKqFul2Ca5AYZJut7W2ZwAWpMi6xZDFHnrR1Lcv2uUVi?=
 =?us-ascii?Q?X99Hs5a7tqYiC82TIRsBJ+Suib8BFQUm9YSFf7AhYzjqDazkvt/5GTVO3szL?=
 =?us-ascii?Q?OPmgvrcA2X4XZeZSZe5yZf9J9ht+rTuIwJvHU81H8fNNTaAUloHuX3OSMAdy?=
 =?us-ascii?Q?gtUovwAOEcWpro24Q/oZhFVxOG/QwFCoyRCUHBq4pBZpKm6wHIDG8oDx2Zpc?=
 =?us-ascii?Q?lu6ZnSKrWE7pt2n1hwsRXwVJE/cgFJBggbLSO9MiWdAmURisXwyu4ThgFeiL?=
 =?us-ascii?Q?SdwlYuKavKNXWVrsuZZ9o5prb/hHgnsQvuRh1wAMt50ZtU7DQjOVgYnx4IBm?=
 =?us-ascii?Q?06cmb34pU87HxDxaTpijg7y3T5gg8cxo7TVVafG1Hi2p7nl5+X4/B5nMwOaR?=
 =?us-ascii?Q?T70DVTFTUw/lZilo+CVcWwGLMu9tMQInZdLuxADeMye6w3Cj0bXF39G61kK3?=
 =?us-ascii?Q?bFSNcCAkvETmQ6V2IvUsCG8C8P9VOdSCQ0dEs1/EDwrjnYYRb7YzYUk/99mR?=
 =?us-ascii?Q?80jxU9vhpt6N4eHBQlliugtgN3IEkS1GD+AZM3u0XZW6Fj0yBv2HEZQxMm3e?=
 =?us-ascii?Q?jIZYu/DWaFiViCcgpNohKBevZculHuWi62/4IeP/LWjlYqvLOKrz1KjxCzRQ?=
 =?us-ascii?Q?icYnU9f8Nfyd0NdOgCJh6cpZQRu2/8cjhXkvuiEEmOJ+nyuNCBbacK64OHom?=
 =?us-ascii?Q?1EScEBvIVpixhNubz3wGYcrG9QM22rY7NdoyQt9fSjrF9+04m0mmnxLCT+7g?=
 =?us-ascii?Q?CGLeHEv5LnS/VQaKqCuV5wNqKjExV0Z1/N6k6u5/cpnG1UXGYgjGSQr4DA2e?=
 =?us-ascii?Q?mYY6/Nkk4GfA4McQULXhlxq6HtabDgQFf4s2dLja2gB8tv9CXKvRh51rhiHd?=
 =?us-ascii?Q?Xr0NCzp/cugcb1fe3CWUoHNPG0J8I1xmZCfJ5jakdYVmIe8okro6lZF8jVF+?=
 =?us-ascii?Q?rNkZQ7ayderOQoTeDC2tFg4u7HXKc+uSVRdZ7fTwb/f2ebyIPSFS3W4Joeol?=
 =?us-ascii?Q?4TQx39NZOKOSs3Ma+dpwlouXD+VTjqtVEfiWXL7jQ93wSUkjXHl7BEVd3JAy?=
 =?us-ascii?Q?tS0ssO0dt3gaUmzlcvhCb8UuDuJOIBLcQY2IuiyssZW239atsV58n4d6uY35?=
 =?us-ascii?Q?le3UPY4K7TBmWR74woOO8fWUPMncgb6mvT/lunVD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4476c92-e37e-4f29-e62a-08da694a73e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:32.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzbhxynF+YxLarmvNN9hh3mc59PAggtjVhVXsebQGi/0/ihO2NnT17LnH6oQ2+egCQ+7sD6BwijSCJdtFC/XxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP HDMI HDCP and HRV entries.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/imx8mp-power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
index 7789bcca3223..14b9c5ac9c82 100644
--- a/include/dt-bindings/power/imx8mp-power.h
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -49,5 +49,7 @@
 #define IMX8MP_HDMIBLK_PD_TRNG				4
 #define IMX8MP_HDMIBLK_PD_HDMI_TX			5
 #define IMX8MP_HDMIBLK_PD_HDMI_TX_PHY			6
+#define IMX8MP_HDMIBLK_PD_HDCP				7
+#define IMX8MP_HDMIBLK_PD_HRV				8
 
 #endif
-- 
2.25.1

