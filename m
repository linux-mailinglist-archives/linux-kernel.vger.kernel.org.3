Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E054D5ACA3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiIEF7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiIEF63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8031DCF;
        Sun,  4 Sep 2022 22:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI560asdDB3qnseL6ASQtKYspfjGIggkmmLv1VgwHWSWpmRlmoEyM506L/0uPoQYDi+edUj/G3A7vkzYmUq/FybqG3o/oyUEsdNPlu9aesLv+GO+GwsfB0AW5ztmO58FN8hNZIXf5CYy5hBcFOkp2c3mNRLk8LoVpmPfHhSNJwZhFSp8RQYUAXR/76lArJ5ogd5aIm+Zp7p/02lk899u6JMfeLufj8MFUKjFfxYXxbUcHuX+7Yzwpa1Gcgzv7sv3gWhHczOipUeslh77+EGduZRNycsceO5TUKmRCjCK5BZqisMrXHikbRT74ZKdGPqqKdSEG9Fy/MqevsOkHf9tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCVvlQf9MHQMQrUoKc0dZ+4tTqokulL89U0g/A26mY8=;
 b=KhobTDIXehLio/nrIlBFVKlJ0++2bDApn2rTmTvo3Il/T8jiB2RYuSj4sgRChEcnk+VjnTALvsP1QTqQDpaH9oBLNagWz/bPqfcHh5wFeaUpxzNWtgoVNNrJOQefQMGFRTNXJsNi4CI+GBaK/UlqriBt6u3mfKajYrMdeMheEL2Ccv4cvEH2DA0Pnbo5eczf97xzKQkcHGDv46zXIjEabl86EmKw2IVsD5VWsVXzTFU5mwfb8biRMyCGDspeDb3L2y/unUbFb1A9lLMiKP6cnh1MjIODqU37PWH/dKM1F29J0tt6EEE8R92vU94RsvYmQBIeAg6mC8yhLRoUrwezTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCVvlQf9MHQMQrUoKc0dZ+4tTqokulL89U0g/A26mY8=;
 b=JUb0+PHz7zFinJsToX6BC7rvYiyGCZHryKbyj6mqljdglm/QNPGsE2+ayvzhJb3YJmY8qA9GdnASW5Uyf8kApSoqTnATzHaYhz2EzuXDjkLHUnl5dWNmnGqGlZW5xWclzOUdM56Av1UJuze/kRYJ6I/oOsqKqx7zMGjMxstygkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:57:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:57:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/8] dt-bindings: mfd: syscon: Add i.MX93 blk ctrl system registers
Date:   Mon,  5 Sep 2022 13:59:08 +0800
Message-Id: <20220905055915.3878000-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b89b659-57af-4266-dc45-08da8f038dde
X-MS-TrafficTypeDiagnostic: AM9PR04MB8276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvmMfY6uKclvVlr+fO8zYzWhTlQ0GIc/4XJYIWNrQrBsKPZnsSWcIfcZORmnfdny3Y1w+8oZ8PrADWal7FJR91Q7jVbqRJWqGppDe53hkETTnnfXFuYrYtkXAuxTJyrmi8qWxBIz5Nlry9xkfIl4mZQgNwl7i+6IGHYx7HFgzQti5nY7jurX/5cYic6mxFegwk3mvGKgh13vJuSu2l7tuCkawElYMu4mqf+V8rS8Uhq1dezM747MhO6XtZagGHInFgnVKTG8iULQ9C3C+EqEG4a/bhJ0V0lXzz6t/eqOWzL21nMKBoQArtecc/rZcCS+UoWpkd9j6twj+hkJhJntbC8DEdESZSpAg0DKnVlO/DYtO+C6m2UPLF6FljSp63V8VMspM7NzuwzGPkAPlSgGJpQw/E/BqrRRL3GOYwUnvoK5X2Zu8PxsAXjayOEzeh0i4KRtbprpqRIBFaGHEVknmJ0+1qxjTpVRPNYlbDsdHEQdd1EYl8VKS0AVONJy2ITZH6A7Vm/q/mIChTSDhm11P4d9TP/NeNKKX+TyAjdPF0R9szBdMWCht0ahJDTKiLF6oyb8tFgjuN/IBQTiEJVCshS3om2rwvgXCcD3otMxh60LbITv0TMsCsor0X1Al71LlxySf4h1F++IF7Hk7XHemBTd8zoE4wu4GEe95UM+lH0r7mWcRS6cwDaZYNm2rGJZ+KsSZQw0vw+I6MJ+62kgnRfOPryIh3nm/TS/yOfBF4giLo7bkAFZlDGF3VvMqFsEv0pBztFsnPww6PRQ7dJ5Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(38350700002)(478600001)(6486002)(316002)(86362001)(41300700001)(52116002)(6666004)(6506007)(26005)(1076003)(2616005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(4744005)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5IXHdoHPa+KXgLHucFG/oAXvlcG0FC18184UgqrbD573POsXVAaVIhs48Cvj?=
 =?us-ascii?Q?Urqvbb49cj0F6DThclDVv9alC9ETLzL7Y7X3ruQabq6/6ShuuakWbGWfiEjH?=
 =?us-ascii?Q?4qa5ssNT98FrXM9eH5z/n5i3BzgxYSy97rAaBg0PyB43RPW3AWrSRi773ZHR?=
 =?us-ascii?Q?/ApnPOLDQcuoUTThQGEjFz44JRudXJQMn0UZQR05a+n8GMHCU0cLmgD3fUJW?=
 =?us-ascii?Q?qswoNV21SUJ28CdtFZP+RbTclqqHXPJa6OyTYbH+dsPe/h96jX15iz5pscEl?=
 =?us-ascii?Q?NgkYQ8/fBwY+W2iM5IwucP8llwbIj8zk/2ctnd1f9lrdooLzgg8kdHE/l+b0?=
 =?us-ascii?Q?HlfRodB/Ez2M95j2dH70PkPBVeRgcascsD/A01sM+tY0rFN+Yb7sBdlXknRV?=
 =?us-ascii?Q?a+Xt3U2OP5rcWqc0G6Q9zGSkudyV+rvSHgUt3Pg0Gefip0NcP82EFDwxj/7Y?=
 =?us-ascii?Q?ai2yULNue9vL6V8HNbiMnExntoI5SJQVMnhNUj0BSPBZsZIyzpVFR2og2ZOG?=
 =?us-ascii?Q?pXgtK2/ZnUDD76R5yyv7uQlqaFPHRu6lmfd/+73D1OojT16zPB4oGYIlkOB/?=
 =?us-ascii?Q?F+ZNwTOOuoT3LYOIVKBlAXzOML3tWHNPJgt9oAxWcGyGuP3zx4dF5o6eCvbp?=
 =?us-ascii?Q?kOqkZJOHaXWp2OsxoudW0OSgSumXATBzOlRwfqgPVwNNfiSMb5LWpW/Pv0Fy?=
 =?us-ascii?Q?kWwcldCkTewNBIp3FXJs9eMg+3JHxw/P5GQPyB9nRBl3tdnEkLycFKUrz0Aq?=
 =?us-ascii?Q?+hd8ZyhJhfSj5DTchHrFp/+/ySd5hUXTAJrYc/LeOQfCAsb80rqcfdYWBluI?=
 =?us-ascii?Q?cIkpECFLBL/HAh01/P6hLj2bs2VUO8w+W6LxeRKy6nFQ6VB4ZpDmsQM9BgRK?=
 =?us-ascii?Q?OcR2CbI9LNMuyzfKgPk5y4yV2cNAUoC9g0EXH2FB4SQWKt2Dm7Pk+MPJEKzM?=
 =?us-ascii?Q?+bdo0lM17KGkuvOWqHW5AKyupHFtmeATEioFtrP7DLC9Am9P+XjsvSSc5sta?=
 =?us-ascii?Q?PyoQjxtNbIbuetOuRqCvyjj/jIr3MInFjVCgvZh9yoZU5eyzcVBLgh9aVD8c?=
 =?us-ascii?Q?+jQ7W6BhKCfe4c3hFe73j0WV4uxowMWdVbxjIbS2/PhTfqwvK7j8e6j9WoA4?=
 =?us-ascii?Q?ypCh2jOO0Y2i5H36UIkUvllKvFRLI7FtuHj1ENoE83kC4AzaJcpD8Vmu3F+V?=
 =?us-ascii?Q?v+GyHM2u/FHU0qYWPQnepncUfXFgqB42MQ4T5TDsI3i/RHuofZdpUGV3TNRD?=
 =?us-ascii?Q?6C8Z86dE8Q2k26rMmCuNu1J76/P/4N/J5Q9mH7XKtVOM3ScpxRoUnfYdciti?=
 =?us-ascii?Q?eCwN7ieJtHKr76jcW2CSBeSevmgt82gk/M9XB1n1a/ptdk/+NLBc2RojGxW4?=
 =?us-ascii?Q?Fb0yZDU9FGObQTJNgmxF34JY2mYRz9K7TzILS1al8TPJArUyZ508AqF7YXc/?=
 =?us-ascii?Q?U+knm6om1+DRD557kUfBMiTCwltFy3DpNeGJFKnnG/fejsyf38Rm/Itrf14h?=
 =?us-ascii?Q?z1NTvPCOkRIGGFcnIRzEEGBbcya1fP8Y4QyWsWPOwgGO/fLDmfMGBy3wrBt8?=
 =?us-ascii?Q?WTRFfY6uFnMVzBQWMXbaMZTboAjvk9xsH0ZqVbYs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b89b659-57af-4266-dc45-08da8f038dde
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:57:45.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot1bOrDghdZEtwGnsOAo2wLC0v99ln5CeJQHKT44LpFkrFErnEy0mF83oL25b8PoaPsUEVaCSR4aAaZT+n59xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Document i.MX93 BLK CTRL system registers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4639112160f3..3c9732796832 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -40,6 +40,8 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
+              - fsl,imx93-aonmix-ns-syscfg
+              - fsl,imx93-wakeupmix-syscfg
               - hisilicon,dsa-subctrl
               - hisilicon,hi6220-sramctrl
               - hisilicon,pcie-sas-subctrl
-- 
2.37.1

