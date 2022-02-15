Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB804B736D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiBOQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbiBOQcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:25 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D598A6E1;
        Tue, 15 Feb 2022 08:32:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2q2u6y2+s+Ki8PMN3w/hd7ygjllsTBX2+IyKK7vRdqjRmIvc6++9I2S8NLW8wkS5mAxHifPlLeIrycGsVs7WLkJvm8raOb538es0tbhoQsWqhJ99O+RfzZnUU+nYo1UKDo0227E+xy2/qCwv3COPhzJBIwsaqOj9duK0pTAYQSzZYxv3fbdDgpiMZZwUy+ltX31XzwskS8fGTrfEAdSC/YH10FCR21hO3+nhzCv3n36GZdba24MujlSuzmPXp4TTlXsSjtMXSttZ9shExqqFhm1dvASL7GNll2Pg1z2Jv1wWlDxOrG2T/r6k7DJ1P/Kofhd4PkGF2FZa9TdfMyLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd5pqa8gCDWksAy6bGNvudpoD+NDuDtCdwHgEfK9flc=;
 b=LabVzlSj+eYeUKxYcsnR8ZWwUs1CL5PHE1yCIQyeFhSoMBdUmBjPMQQqvJcpE3v9UDJuG31AxGZkIdPLyWOZ3zKTQyn8l6WBAZFpAo6NYtGXikQ102D9JPg6cdIKyETixZpwDPdK1mghkP3rrdsil9mQwSjz4LG9OfHV5gyqXgHAKvox7cjirHNA4UDgUqzTV9MQOzVEQUNIjxE9g4RlNk/u5mrI/l1rtnGW4CgTLMjW93ZshQ6KbRl0ErkZLbgqIqDv46ZYl8I1pZo11s2sUNt8pq66Dx/CG+Ef5lrFM5eUd+hdW643TqxQUXUxvFUPHasEGUSDKzWfVwK3As5BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd5pqa8gCDWksAy6bGNvudpoD+NDuDtCdwHgEfK9flc=;
 b=YF1o3pDZlYni3GVz53mEVwBjb0s2xETeIvR4+iv8cQocnv1IlcGmQgkk/47xKxwJLaKvrqUgCgbdnRvrMndBcySBCSpon3QPgmUiMYYbD6jbv2ZnTU9dAAMwxjV3DsTllpZqLFHQAy0VnN8RBySSnDBK+ZCH4QOPLvMMxisNx+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB5695.apcprd04.prod.outlook.com (2603:1096:4:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 16:32:10 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:10 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 09/10] ARM: dts: aspeed: bletchley: enable mdio3 bus
Date:   Wed, 16 Feb 2022 00:31:50 +0800
Message-Id: <20220215163151.32252-10-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3e95bc-6358-48a2-0ff5-08d9f0a0b645
X-MS-TrafficTypeDiagnostic: SI2PR04MB5695:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB5695870D80BC369B8CC613F48E349@SI2PR04MB5695.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ek8/BGKVAkQOSB7tTvLLAXvu+1lRN2yudv+/dw26KpdzN4Y8UlVa/RHbKChXvqKWdksZA4zrqQV0oxfFpmmVix9Zjn2d819ZpBEY4VroMM+VohSG1IhLBdlYypkW4dsBom3y4IVcbOaVx7m8U8OlUegqdvCVgrzXZGuUFYG8FO8D7LCyZGQExOWwTIQKjQrE3k0073GBiPIrpGUQiUegZvEETyQQuQ0vqlK/Dw5ecjUrMn8lULNqpSxPPpqs6O42kuA7wuOA+9/JzoasSx8Ux9ZxEKM206oulc7xc2q2lWZXIzymu5YyU+cVCssA262aGDVSGvOLyRl8n44wEvze42nrvBBTwenx+CzUOmYlRVRR3C5Qvp0S/lOIlFw2uZaAfjweWYyf3zm4LdWkkRzypNS+UGt/iEP2e3AIKbzSS275PJTUJynN44OVdzDbJeoGj5/0KZ9NzQnozAVlBJLzAgh2nwnt2oRKbNxZ0tylqi9I4y9tM2iuW3vyew7WXmSdxyCfn1SqqpgqBX3ujy21o/LgerdIoOqHtTJyEpT7mks3AiTUZjfwBUDMZx7pczUyRtHUK20koIFb7+nSp7X4EjNm23q2j+MbyyJQ2OEqJju/29ig7W+ILycAVNLq6DHIr+foXGZAV+98LbhGp2JTqYqxnfWaAr+N/4ba7/m/yPnsHa2yZCl8/St3XLuYWD0DC/4usvPqMR+ewLnDnq5zUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(6666004)(83380400001)(38350700002)(5660300002)(52116002)(8676002)(86362001)(2906002)(6512007)(36756003)(186003)(2616005)(1076003)(6506007)(26005)(107886003)(54906003)(110136005)(6486002)(66556008)(66946007)(8936002)(316002)(508600001)(4744005)(44832011)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?En/gMD1JWHVzD6FpPG5PmD+x9B+oKxByuuf4Ej2818S7W8LokeKBJXp7+fwT?=
 =?us-ascii?Q?m3VZ9goOBEMg0J5CRlcxghn+ATvpDZDegrAW+xZUXKLxh98dYOs11QD9Pej6?=
 =?us-ascii?Q?g8PInOWHLFy5zh13G/O5fpuYDF+yOO8UDCO/5J5b9oHuohMMWQyQXc2CjzS9?=
 =?us-ascii?Q?aWk8tVpyZ2sGUpmxPbtUVR4PhnwUTfbhuR21uK38jnsosfKs6d9YAMcMb1jn?=
 =?us-ascii?Q?TmkDrcbT23CEA8UutzwJnNQBAmEpTDzYZBlRifEgbR79+YLo53rM8VIiiArL?=
 =?us-ascii?Q?DRptBfaFACczrsE48xekATsJbGsfvnzz0pu/jEV3/8cTWvWzWnJWcqFks3e/?=
 =?us-ascii?Q?gggYvcvhVjiv4jTgUgId2lgkXB1saPihdnPhRuS1zw1lnJ6t+OqezUVBP2YQ?=
 =?us-ascii?Q?oo1KThtu5F5ZDubxLnIOt3qe549QxOiZVlCSozi79Z2v8cKnLYHVH28065AY?=
 =?us-ascii?Q?cKxG2SPIrGINawWicjEiCcs600PUOV5L9vR4+8uApkrr7TGkzSqSnufpl1pR?=
 =?us-ascii?Q?1i1K2WvATrXlFqB0MgsnTDe+pfAmxNxqBzMgO914UP8Okxmdf/a3G42+pu4Y?=
 =?us-ascii?Q?Kw4WSOC3hEuye7Kjze+mBdHwh6vlkR93UJcmdbWkOAV3iI15Ql5m3cA5Lu7H?=
 =?us-ascii?Q?WfjCx5HS2u0Hom6LvbRJv+0P2rgGYeGIQ6ShGD4B1F7iV7AU2tJ62ToEEcmh?=
 =?us-ascii?Q?Vw4y2dFoeapktOb03jbZo9lqlbMS2pPuahMWMMZ8IcUN4KKEioTXyW7Pex6o?=
 =?us-ascii?Q?ovidl+eBkv27pCTWUweQfqnBBQG5WfCbJN9FynxIwUGF3lGm67AGn871r4Dr?=
 =?us-ascii?Q?MNmh4IjdZSMbV+nQFn+NbQOFH7uXvjAOrn+FLHr9zTYsJvNoM8oX6sNLITCk?=
 =?us-ascii?Q?HU98QAIbuHXOGgxfLxUS50n4nkA0unLH8OEfBL9pNqqbaY0su0u85C6JPMdo?=
 =?us-ascii?Q?h1tQ+DpBa/RmhoQoocznaImmdZbDHPR9+p4S664ypy30rOa6Md7MHWAUH0Tc?=
 =?us-ascii?Q?w+EBVcCg3rd5gIR+90aw4SnM1Ue2ns441nP2SymIJcfa3WT1q0nLUo/F47QD?=
 =?us-ascii?Q?jfC1B5aLTV5kB3HjBE6SEn4hiz4F1+XTvxBXxhp3j+HqtXMfy7uIzi3DtFcq?=
 =?us-ascii?Q?JCqLTlGHdwr9FOUyea4db0Yb5xSJjFOVe5iZrggWN6jnJVcDPzOMjmFTOMzZ?=
 =?us-ascii?Q?88hWQHFJW0T7iUVerxm0zF35+sae93TUUD4l1P3NiqbIc0I50tziZ9GozNEu?=
 =?us-ascii?Q?TeIKI0JLwdXpRKqXYibHBtSmdQIIxxzqccrtN8x9KfpgcMhvw7GgXkDBL3fg?=
 =?us-ascii?Q?UaLgAsksT0ezgV1snfg57oyDBIo2wec9ecXPYGhRrBJ8FyjS28fqrFZxLloG?=
 =?us-ascii?Q?X9sy/wGopxZcf2ty7ibmBnppNA5se3S5FN+GFE4vEm+BAva/Z07srl9mAR4B?=
 =?us-ascii?Q?CpaTv2I2tyozAJCKH7yYXWOditHjA4NgKuSkT6r0A6Jf//3QdZwEIFhUggAu?=
 =?us-ascii?Q?GOdXfwZg0MDZ3PA7I2lwADh48nCKWAvrw5Y1RN8yYB42xMYYkepZ9FqUnO+f?=
 =?us-ascii?Q?2KgjrPhROspQhDlp3I1QbGP52OpWxfd9v9rPHtyNlPGicYdRRnGUrJJJvSsI?=
 =?us-ascii?Q?nkcSjR512pJxtmaQDYSgnzo=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3e95bc-6358-48a2-0ff5-08d9f0a0b645
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:09.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2luHct5MEqE+Elx4YXBCG+jEvzwLJqrVibMchEoFS3HxCx13OcMOv+TgO6yFjHadsmI/AC7n7UcuZtAnLq2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5695
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable mdio3 bus based on EVT HW
So far lack of c45 support in mdio-aspeed, at least can access mdio bus
by read/write register

TODO: Add Marvell PHY 88X3310 and mdio-aspeed driver c45 support

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 3ab48420b712..494654338542 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -840,3 +840,8 @@
 		&pinctrl_adc12_default &pinctrl_adc13_default
 		&pinctrl_adc14_default &pinctrl_adc15_default>;
 };
+
+&mdio3 {
+	status = "okay";
+	/* TODO: Add Marvell 88X3310 */
+};
-- 
2.17.1

