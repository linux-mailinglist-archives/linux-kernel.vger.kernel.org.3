Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6157ED2E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiGWJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiGWJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D8732464;
        Sat, 23 Jul 2022 02:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzkQdpsSNblHbYB9vabzN3C1OrOAuDzDUM/H3QufPNbeJ31OLQY6D5dQwYtLVzn/NYLE8M7H1LDHyMmm33vmUJkmzrr9+dQLr8OgtvQmR7SH02Sg4UFbvhL0tVeRDTwy5vCe7MQjeKqqQzf8ivc2Ajv3J4JBBB9lasgtOMUWDAvv2HSJWg7Mo8dYK6EXsRwEJZmyL3odfpKz2YvgiHYnyrw/UFa63c2dKo82NU5Il8fkiPXJyFMlpxWkMDkVCtix0LOXoHgrVbrx2HsT4nFyviSw/kZ5olqF83PYpJQWrxZbsb5g3QwV0gu7rPazZJzgX+1dG9H8WXeN9IURWwxMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tevnsb/+TLzzr4fMMpbtnR5jHnTy3rc2UblqmwwEV5c=;
 b=i/BRmy0ZhCKYCMP8aDd7SlipzIlzAdfA7qmRVV64GnUnxG4dccmwaMut08n5DLQwuZyjQ762zQfBy7WsNJvVT4TjdJ69lPmaX0nR57KV8vYVkzr9WU9xV0wkY95iD4J53eD+z3TxC7ULTy64LsF0JFmqjFsiR4sAXwlQezpm/ROtEVVNUYQx6ZJBDdJhv/2BKB+E61sp4vc9k7+8iIx21ID9S0AfhZrKX+RoDMtFXL0kjR6TpKxrrUNA8wk4yqOONkUUAB4eo9N4kx8FyEVhXaG8f2mDFXTTV8KgDdsh7NgC8sd/WHsqdu30BwyQUt+udW+Sl2Wd+gwtZI68aG5y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tevnsb/+TLzzr4fMMpbtnR5jHnTy3rc2UblqmwwEV5c=;
 b=fH7ES0ISGok9oshQaeKFgO6XjD2r3HJC9M/Ou+lUvrhy5vMJQzxoFCKQSGePJD75Tiivs+JegaGKtkdc7/azX3kz5nON6hPla1kVUHcgAeiJ4J76UZ3R2V5N9D4lrAaCqsJHrp3M2ghSeR3kd/WRS0Gh6Fe3MG1z+g414iBHon8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:42:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/9] dt-bindings: pinctrl: imx8mq: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:29 +0800
Message-Id: <20220723094335.3577048-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 702d973a-2928-456a-5df9-08da6c8f9bd5
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23PICYDuLXBDu8Ll+DZEj1VP0DrHs8Wnc7kWgwtMDMdVUIvRUKv2lMZ7BvVq4ry5sqzQ/cb5q6GaUyalBEAtFhfqoF7hMwLeXYrMFI2IZgiXxnEqQ3SkQgafzai5RQxGtWWl9+N19zb3D8eYk5Fw9c+epgmaDp0aDtaJELwP1g6ShJyBxcnOLPRaIaQSSurjaeiRaMqvWnkCu25kimXOg+uBhc+XQ+nYUME5gn7VT6UPYIwDwkhCyzIzSUYSmuCIZuInrvNZoSb3HFKSqrOkxjGCIHu6/fAfpBGfIIdKY5JZC4qr34Iw13fqaiXd4lmDOIw/3LMUhDPak/4aGWghYV1VGH+1hIVBgYfWPz6XP0uYsJhv8UqcVdcg997drAVIqLgIW8ajTvrvdSpK8EevKc9ELlRhgq0VlCQGl643JrmME9HoXmWSTtrf1ZpRzrQZWdAdrp4G3s8bDDFM+6DBDMhL+BRmaK0AYkPpcvjc4xlqPFxq/JiKNFVFYtU1TVxVpslF5J8rhssV44nGGftSe/rKdkU7f2B0ohjyI75P+ZXHtQ83BATKawQDsyjYYa9YNLt1JdkIPfjo2YuI0SFGAHYpYmDotBOFMfqUoRZ7VMxpKyE2vTiimGElXpSuFkshr8SSH5kv8Hl9CRYqj+lEMhUuOs1y7ZfwUqlAEACOtMFFz/RWahexMfjIYbE4WfMp2bEDmCKKWtPwhqpn5hhFq4iYlKcyMGZ/QvtapULDtUefRk5KZEx7npSDIKWtZ5uIByz3uwrqyp9A3t2+V8OjzySM+rrE4N4bo/fU8ltSAY3+I6GBvBmwjgHegkEzszLNaJVwdh/A2pVKL1v/1pGL+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMN8zHg8k5q81sD/O9eQ6hbqgdiundW137J1FUcMXzGixB16IyF71hA0Pbcu?=
 =?us-ascii?Q?Crq1LxotsywSqf2XuQ/Ud9dZ005qqsyzg/X2F6GLk7Bz80zfQg3ZK25daSPk?=
 =?us-ascii?Q?kIP13XQDmP4wyitymz/Jlg7Z60pJOFvzHRQygf323EY2VWXFAm3u2H6F+XiF?=
 =?us-ascii?Q?uEcLeC2hkKACcTtzwYitxMbpk/OXv6fgHU6xP1wl0KOkg4C9friSmXfG5BpA?=
 =?us-ascii?Q?4oyHWP5eslWEJVqTObKf4EfSM8YJ9pEcl8A1k6nFDndUl8Urj+sBzsXcd1PM?=
 =?us-ascii?Q?9Wl3i+6Rfy16kfi085Bdx3fr79j5i6OIXACyFuqEDoJN+Z6INDpPK11UhYXc?=
 =?us-ascii?Q?uhEBUdRFShk59292OF8Jw4+MPpJeIk95Es3wbcDrmw5bSsypx1dgtcDAXJfr?=
 =?us-ascii?Q?gTF94heOpVWG+onTbgSeJok2EG0b7Es/BFToVSzFl/ZTepBJwTMG03Tty/gl?=
 =?us-ascii?Q?o3umUlnfaeha572WrvT9rygfL+6U7Wne9tWtkKYLlgqlQqbKazQ4ey/1ApbA?=
 =?us-ascii?Q?vEH6jV5/ERm7aGCWHoizC9TzfdCnO3CklooJz8B6xIGCUddRsCL6Ccc1UVHk?=
 =?us-ascii?Q?sjh125RnLX5ZUC3RJFyqR9yyn9RTUwK5RDqNm9nOdy2TX2x6xxaYnB9f32Yu?=
 =?us-ascii?Q?NwpvZa2s60uKPBNGVdBrYfoTGZQaWH4HHSs52Bq9JuAjzQSUPwoOlHHpJFNC?=
 =?us-ascii?Q?iqyDAoet1JbsFU47Ryw6UAcoCfr+yCSbwcWyaSAFLLsXUKqh1rhpMs+zZXjH?=
 =?us-ascii?Q?pzOm+WMsryGMVxP/V2bXDAbjD3JWKsVsKjwUiNMo5LOBxMnPAxGNaVHHz+KJ?=
 =?us-ascii?Q?Y5jNKgfTDrkOh+sclPfh9ZfXbLiyH3XUkPqaGoBBFp+A9K4PoQO9gkVXv3/h?=
 =?us-ascii?Q?2h7vjvs2sEHVV2XIDpRWFRaYvxQtOR9kFc+lgOd8JLRZJsSNGg+NFeB0jUxs?=
 =?us-ascii?Q?DOYy2ii0P3aIEW9uz6TqvfmfL3dPbe6g4Y6N0kqocGBV81guj1Gja/3kaVQk?=
 =?us-ascii?Q?WYTIVSM11Z9hWpkMbQWR5fNBwukeCP4ONg/PAbD7m4EDTVRLHY2VUQEJsDJH?=
 =?us-ascii?Q?1K91g0X8R+t9WDlRac+aNi+OGEjDdnNDd61qGIZ3uNabAG2GfG6BIJFmgaLG?=
 =?us-ascii?Q?xGR8Wv5+PFLv6tjzUTKM//YXjpBzlq5qGnOi9+EhDRsdwb+E2f0iNA2EmpMj?=
 =?us-ascii?Q?P1E5duwhYWZTualZdsGbhbMpYUUAl79R5Lv94M8RztGCpW9l6U8VjAaoVn54?=
 =?us-ascii?Q?4r8KaFAzMb6VWu/Jkxk4FmyGdXM72pY8ikNn+NQP/Bq6kQ+qfdTbTg0Qo0X3?=
 =?us-ascii?Q?DuiTtZHxp8mK1A7XbHbYdFEs5cE0acaZnokivRVAotux715mx9fHEMt5F/GJ?=
 =?us-ascii?Q?kBjIdtQhpQZpGTf82rEh/PuDZPns+BqHCiRoSqePpWRrmuQbh4tBVuFl8Yvd?=
 =?us-ascii?Q?PGcyts5CMAv3+kQa6As9CHRTl6I0nHxPKlGyFx0/tEE6+sb0aK/h8ZeVSiSI?=
 =?us-ascii?Q?1MRH5msuNewtT7hj1afFDJFZ2jgH+Iwkvk8gNtQBUOpx7H9Lgyju55L2E7cV?=
 =?us-ascii?Q?FeLpXlt9gH64VrINQ7dwlJX7eWuIrzk6fL5oghNh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702d973a-2928-456a-5df9-08da6c8f9bd5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:07.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86YOivCCmdjEc00kkA0gmb60eF3M2iGZ5v76mLlrAd+RT1MnH3n/tkSMzWnX1WlzRQRSMEuem/nvT88FUnDa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: b3a3740c35d6 ("dt-bindings: pinctrl: Convert i.MX8MQ to json-schema")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
index d4a8ea5551a5..fb9da3036e2c 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
@@ -52,6 +52,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

