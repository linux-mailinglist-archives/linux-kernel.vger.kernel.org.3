Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B034B08AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiBJIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:43:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiBJInw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:43:52 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A918F;
        Thu, 10 Feb 2022 00:43:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Enw3OsEJGSP6QTE47PvIyrw+OMQ9NtzxEi9Pe4SIVXC22M+GBP7BB40xwgG4I87GP1aOsGUCiRFk4bKIz8lbzTPQ/70UXxr3maADbHeXH57ew6PJAJ3syqUdFpo0JcsKLGhMwpYgtQyywWEZsGahrLiOrMniNBTmIyIiGpXscGDWkntUJneyK/452/JuVsyzJO0yol5R4ldbTrknHrvseOFZ2ZYAio01NJ/Rlu0qDVq3Dm09blxwtTnpZMBln688QH/BMliBOuAy5ah6PT6ctg8KFxqxXAK3QoUZTgeSiaxDzYlQoWVAOLCw5xWibzgxoksmzeukUMrYBJSQnhJ7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VveFQqnRYZEd2GB4v2WYNkLikexaaoJr3dH1tvVLJ7o=;
 b=K9Wwt1jxIF+k05Luey/xOpNN7pFK7yHH2bQpJb8PsGn/LJ1D17nqW2qtjlcaJFVGYWtw8KSNxJqqwKHiU14PC4O7GkP2yLPzpEMlLMLT6lx+dWPoF4N/eLmpWvikRU+0saVdx4lAFol6h4rLSlC2QSvU081BdP/YscAux0nt1gpoTVtoIzuy7PJyglsSTBpiiR+/h9/PFarUkbCkmcWQV3HVeH7rrqMZFXjuejwQ7zoLy7sQ0gd5RU4tc/ms/vDrVd1riGnP3BrUNNdTPuZ3F6yvFT0JIXxZMSZ6BiAdzmEXBpBE8p7wOqIijiuvAY3ng3IHUrFHcfYy+t9Trb4nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VveFQqnRYZEd2GB4v2WYNkLikexaaoJr3dH1tvVLJ7o=;
 b=mfooaCLh64v6Kk53T0acbVchEeOR3sIsF0/526PuwxwCd2piawov3+aWzRreL8EDgZNg48qnlgqMrJ26XEhylnRumYaM094pUQuTC65i988/kwJLSJ3lRQrb0YpvrmkYCkiSktEP7C9MUT+AGZeRi5KbLtw9bWhH2aGtPPh0Nao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com (2603:10a6:10:af::27)
 by AM0PR04MB6211.eurprd04.prod.outlook.com (2603:10a6:208:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 08:43:51 +0000
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409]) by DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 08:43:51 +0000
From:   Kane Jiang <jian.jiang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Kane Jiang <jian.jiang@nxp.com>
Subject: [PATCH 0/3] About i.MX GPT input capture patches
Date:   Thu, 10 Feb 2022 16:43:32 +0800
Message-Id: <20220210084335.1979778-1-jian.jiang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DB8PR04MB5771.eurprd04.prod.outlook.com
 (2603:10a6:10:af::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0615a520-9a35-4756-41e6-08d9ec717613
X-MS-TrafficTypeDiagnostic: AM0PR04MB6211:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB6211B2CDAC3865130A72348A9A2F9@AM0PR04MB6211.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoQxiHmJHK5XVRJ4+wX4E/enuSaVvnhuH+DhI43ilI7D5Ax0fWGuf14VOS98YAySuPuhflNPr7y2nf7iAPJ4cFmL8LZTJcL+WPQJ/RxAOZo0ELGJu3Oc2qKAzgyRUy5ikkV2lW71AuEz8wn0yHEaRSopkL4qFCFh8M1Pk60mciTFZxZz2fdF4OfQGuWgihLhhu1atyLhkWCwLSravzqUUt12g0pxGV2eS1txM380DBYC3fWfNXj3U5tzksgeE1nhKT8HM2/RaMWajEgc9zcdzNuGjRm6M6McL1PSMfJzglUInrQaSMW661BoXV4hjOVL+5RUISuuOap6e1HndCk9une4CUsJcwUz0JNGf4vP6hVDAhOEN5vbRf75eBg8SmslHQFLZKWzjkD11US/ljXYYQaRxd8VLkSoMcUZ6RBEC87BH/qQRHFo4DUmk1qCu9l+fKBhfCAUDqyE5ePBLzuNKhSVbr3o5IwYOUL3qOu2IBa024SenX4E2v3RbhMf9YCnXPOP8CbgJ8zJb6zFAKu2WBspSRhTFwFVKBsVZUhPOjtuIdcJIvfGJDzgMrWf8pXKUr1ilPyS3UX69eTtqRQmgepIMaaMj3SRNTjVvaSiNF7Q5Bn0WiNUI31IDKXOdo0g68JIIcrAjeUgELQTp8oHeefZP7Fe6fZVGe73jpZA2oJj5CKm2eMJq8JW4m73EGqUXHfNE6n+PKFp59bAtO9ik0utIHXuiOJypxW+usje1hQbPT3B7qQAeijoewdEZu772VQVGz87O+Ohb8+s58rz4YqSTne2YeL9LMfI4ikVWlgXyXLcLl7KeJ+gKRaLwtzZrjChmZEx17jO1qDPoobUKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB5771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(6512007)(8676002)(110136005)(6506007)(966005)(316002)(86362001)(6666004)(508600001)(66476007)(66946007)(4326008)(66556008)(6486002)(52116002)(36756003)(8936002)(5660300002)(7416002)(83380400001)(2616005)(1076003)(2906002)(26005)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wSgXaSLo0HfT6lpetB3QSTle4o6eucXsD2D+AWcF7e9lXtwIyJC4BzYvtc8?=
 =?us-ascii?Q?tLzuCogM+O4DtpvYlxfCgWd7xorx8YQB45qc2hRin/Hdn8VJNApqyzMJ4Pp4?=
 =?us-ascii?Q?9u6MIGhsqBInGUdExTbw1jrCcilr67nhUArQsncI5mna81nKT48mLIaWpJzS?=
 =?us-ascii?Q?JTL3RDWBH95AWzOyaYmuIO2d7Q9a+m2YkazE7LZeWOppSm89kfU7zbVnCl68?=
 =?us-ascii?Q?+O6EFsc0RU1JNPBwukvddsnKUs95+a9Xh1q3J4kPsf92vsva+Q1i+eOaYjo4?=
 =?us-ascii?Q?/AzgUScBLFJNQp4COKYbHGJsQ4jYrj4Pw6f2WfwLJ3ulqQ9VF+RZokCgVR/E?=
 =?us-ascii?Q?xB5rDaN3bvzV/2PKt6g5jv2mBBBNRCWFOlOTbIc9XW3+8iz4gPd7OieIJg6s?=
 =?us-ascii?Q?L8WeP/j/VpisJG4lKz0Ei/3je8tOyJ0sksk3aAE2jHmOzq6iCBsX5rYwvSQ5?=
 =?us-ascii?Q?i8JoX5EA0MjEVlOW3dv9RanW8LG9u643bn/zMwc+LoChzC9vDoq/+lssBI3f?=
 =?us-ascii?Q?R340q30M1+5ZwDExLbu0SNbeJnhxZURDbIrLae+ARHlKKOfLKSZ2KjLn27K/?=
 =?us-ascii?Q?Pl/ts0HC4o6cMSorv1SguWhADeGC1kC1urYv7rjp0D8P9XceK4Wl3RVOa+qu?=
 =?us-ascii?Q?aoNSHmKbuNduODDcExiOjk/Lo/v1vwyT+oPLrOt/iHSePrx892TpsNYeUSMU?=
 =?us-ascii?Q?VMDrCzyragipU/h2BfJb3Oo0HKepz1X3jBN02hMYDBcMEZXJMtRPxZ0xKcsh?=
 =?us-ascii?Q?7XtxnZBjhwBK7jLnIK6Ftrej/S4uif0zi+X1ykTfccsZPSUZxpFDTci39dqk?=
 =?us-ascii?Q?/4ERMdIdAhmP4RE79FaCRBFlUf0xWthpet+GHiJdeetFsHcP401cvb3LbmRq?=
 =?us-ascii?Q?XOJ1g7WhDxFoQijBpcX0MR0ba3BaBsaRFfzAo8ZP+TeRdripwuGgPSsIFbTL?=
 =?us-ascii?Q?XgDTwJ8EV/bOaiWHY/nnw2yMRfDjz+YEok5SIkvI+kBQH0rcC82baRorUDWK?=
 =?us-ascii?Q?45SvQTsdENlmXjm7TaXi6MnNlcMGCntdr5rtuQnYX1b98ud187VYr8MOt8VW?=
 =?us-ascii?Q?hEg4WfQ9tqBgOHFRrm47+ULvxM5XjdzWYPoOpv3Tfvjfn3TG5ZTuN5KNWCWV?=
 =?us-ascii?Q?eaPnSga/5H1BrjT+HLF/tmk4j9ZoudyQyRntOCmN2BdF8PlT0SaqdUFAWZLt?=
 =?us-ascii?Q?Dw40V0PSRpSuWY5SGo4i10sd4X4I3sxFhDHOoYGwjyvY2QH3dPmPGlq3vsUR?=
 =?us-ascii?Q?ByxuvUf0CwoKSWGAuM/Y+hue7ZrfRBlY9dO/EgwiAJ1t8/JmA+MtY1UyoeGI?=
 =?us-ascii?Q?msdd0qKz/wogUWGaVvAVFdD82wmI+8ZI/o5OrzrV5mSR8mp7m7dlBu3D/M7t?=
 =?us-ascii?Q?1Pnmvk4tvWVl2KKue6GxLR2z6YT4ek8DmpdzLnHPWK8uohBMBur1T+07BK7T?=
 =?us-ascii?Q?oZRQfvMOaPyFdeuy7QmCCoEsByDTpERNEaTA18LmNXIoWw5m7iJTdH/2/aeT?=
 =?us-ascii?Q?l0/3G+DNYqZCsUKb4u83rGk3IrbuYmGEw6ubCFsWIb7QnLUyDGEmeWzIcOwf?=
 =?us-ascii?Q?aF8Qac33ZH/3GkzUn83ZQ/6Cjw1PY5tGC9BnxgXmqDeh3RZ5nHROsrSp3bob?=
 =?us-ascii?Q?QRLSVEkTvd18aqG2uos/P7I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0615a520-9a35-4756-41e6-08d9ec717613
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5771.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:43:51.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRhKF3Bb6LBJi8Mag5yuvQaD0OEjw96NPrKp6K2HPSgezJeXyKIF/YlzyncByrkGNGf0y8MiuNfomrGkHrZ5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backgroud of this upstream is: I used to enable i.MX GPT input
capture function for i.MX8MM. And I found patches following from Steve:
https://lore.kernel.org/linux-arm-kernel/20191016010544.14561-2-slongerbeam@gmail.com/
https://lore.kernel.org/linux-arm-kernel/20191016010544.14561-3-slongerbeam@gmail.com/
After applied the patches and do some modification, GPT input capture
function was enabled in i.MX8MM. When checked in latest BSP, seems the
two patches are not included. I am not sure about the upstream status
initiated by Steve. So as a latercomer, I am doing this upsteam again.

Kane Jiang (2):
  Change to cyclecounter for GPT input capture. Add support for i.MX8MM.
  Add i.MX8MM GPT input capture example.

Steve Longerbeam (1):
  This patch adds support for the input capture function in the i.MX
    GPT. Output compare and input capture functions are mixed in the
    same register block, so we need to modify the irq ack/enable/
    disable primitives to not stomp on the other function.

 .../devicetree/bindings/timer/fsl,imxgpt.yaml |  48 ++
 drivers/clocksource/timer-imx-gpt.c           | 482 ++++++++++++++++--
 include/linux/mxc_icap.h                      |  16 +
 3 files changed, 496 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/mxc_icap.h

-- 
2.25.1

