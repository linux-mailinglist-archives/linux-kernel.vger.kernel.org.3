Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5B5AAD2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiIBLL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbiIBLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:11:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B65EDE3;
        Fri,  2 Sep 2022 04:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaytL19vpq5RmSIZ8jrl/Z9+X81RBS0QZEii0PDto6j8nDeQyjiwXiwmD/vXjlt6w4AsIMNxsPrhknP7uYGBomhWspV+Hq97dsLadyau7WnzMYscnPD+44aqn3SlWwudPTcxiN/mEjRpGJFBQUO2JcHhKXiJUMSX9iyvlXpcosMWZsXesDWpf8fumrTMsbgiTH88RrPl0a/yUwqvM5v4WaDFy6Fz7IvuifX6GyMzZ8VNQq+GJrFo0kQFUq5wuycVyYhHeG1hrMRiJnGyl+1KmreF+XlRCCJjXxA03B+RiFUyrSPw8tabmZG0Fyq8+RC/AtJmHJMqEUHTpEdmRqwRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wemzhi+iapPB6sVILlkmaeZUGSmoKdUkNL6+NmDGUnU=;
 b=eEgA6cRwmYk+vYv5jRVQGrwjt2hEMBfLlQlMeYGEWY0iuFUPlQ4/TUNOsS3N+z47ItHX+2WK91m0NIm7CgLeTfImxYjPnIXOxjCl80510XZs80qjtZzW86/GnoqO3p/08rfaHBTNMOpgzGmGynf1yQzSgYTwRtozGVjb/uQy+P3kLk43fmU0hdTMFBf6lK54TEDO/vaNcPoD12vRDZcrFim0tXCvFB4GmfBKGKX/72ZlZxmOoAZHc6wzG+piqRXEAFexqsYD1HfclUow5cR7Q/EI05pg1OJKtUZ1UgXJpKhvxlEvzR0EWLgplpwpiif6etSK/BgBBe2bdZIkoni3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wemzhi+iapPB6sVILlkmaeZUGSmoKdUkNL6+NmDGUnU=;
 b=LsGi5Kkb3/8SBKiSt5T6gfSzKvP7PKvNAfzWOQyWOvIT7By6QCn6vM3oHZP3LdCSLm5kuY8E4uukG4UvojV6nhaT1LCEywr+DdPAYKsAzmOMpiPFbUmjFGtvpw1Af5+BOavnPos2pXqfxnGOy/m2EtnHmFt//tWz/qaZoCw4WcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 11:10:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 11:10:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: timer: nxp,sysctr-timer: add nxp,no-divider property
Date:   Fri,  2 Sep 2022 19:12:06 +0800
Message-Id: <20220902111207.2902493-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
References: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c6c139-f82d-4c4e-4971-08da8cd3c47d
X-MS-TrafficTypeDiagnostic: AS4PR04MB9409:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkR4i2zwcRloNnE4swXKAg9JOxWiNZRDyl1d7XY3jsNKLKaeQAp3cbT2Z0SISf6gIeNsfYusLDuF8dohICDWszYKBNUxaoPXbgsGNniPS6hAf0takjBveQiN2z9+c6XjpQ26x82XuhD2u1znBgY9p/K//eBSoD4F8XTEl6JqoDNzMP5OQo0jhv9XGECP+yBcq8wPT8bBLUnOKEjFuW8fM7QEG/YRrZm6axgs8U8Aa1FAjF2+8dkZtRJL65reE8Lc4XIRK7UDg5c39QbaFY8KwT8T8scav5jSbexbP/KQ0P+nWNiiVuznIJs7LCmzWDMIIPmtlyKVwaYwcIVsk60LAyORoLlUn0sWRzGbsuQrZ0wsyJq0KiUkKQ3LTUmZkq1qKe269lyMOHlgvQSh45HsSrWAW3apusdGIXv8KoDV8QK9TSELsUHXSBc6XYTuwGlSl3ky9bZ+HW0wyvC4sA+QF3rUnm0iOAi2Q6lpqj3QYOSyaJFAREZMUEYJHKHb6546B8qbkH6bd3RBLJS8o0J+uRP+/di9fNMYSN5XNnJr6xv3W75x8KCZnzUj4vYG7X/48PaI+1TKDa2pi8GytXyApcUREq42st86gl3qPHq9Eq5uAq7yio4lQUBmwp45eeJE7z7c/ogPVykLPpMIwfXJfd6OULboQcFkKV9UuChHARL5DGkSxPOl1CvGod8uyCGiqqwIZ15MCqoNU4gCQCIa2XER2fmg2Hy5DTYerRcAp1jAPVE9zlNXF61q9CYzZwH1Fy2QI4Yr4bGOkrfVxi7F8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(83380400001)(38350700002)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(2906002)(4744005)(8936002)(5660300002)(52116002)(6506007)(6512007)(1076003)(186003)(2616005)(26005)(41300700001)(6666004)(478600001)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XAFSfgE7/FCE3D46AO8GEDUL5GqYb1yn8fhP+oElOEd0S7vVmQcrssS3dtzn?=
 =?us-ascii?Q?DPdEPLNKuDj4WcWLsmJlmoztJrKhb3WIp6B20ta0zGWxeVghoXPGDiIg30pX?=
 =?us-ascii?Q?byy48esHMGIrKR0LlEvk+qqE6rqUOHi+/6rg2mW/CD9xjTOxPu01avNOgwRm?=
 =?us-ascii?Q?5A9ZQpO0Eblf8CjmN1ocCduUYslPWkx1NzY9QnaVFNCpF0qgahUL+9CxYOZn?=
 =?us-ascii?Q?N8JKAX8LdxYJk+J7BjMwY0oA4YeIGeMDXSx/KqlzwUPaphqZ1DTyXiNzuUqG?=
 =?us-ascii?Q?m2UMHeQ7zrOGboY5SKxkxlTrKRUt81S30Qq8HfL6aV8gsTIsOQVXgz0OEg4S?=
 =?us-ascii?Q?ljWoGCEzhCm2okxloQkal69AuTyWnboNo/zJ+n1prydVI1vDVePkF73fxbpV?=
 =?us-ascii?Q?fnjJGQ6A7VzrN8xIRP8zbMIaoF1uB3ymlgZwwnSNcfo1yAHRnodP5orflQQZ?=
 =?us-ascii?Q?OHc3Jj/5tXcljET/HP4aNqrVJDY1WMydCNpp7PQLIZaaq88onubZyb/seEZL?=
 =?us-ascii?Q?TM3caFsQ8sbGKnUbhhutq2k7wfhTYyoUtCxO0HcLNOe41vmGa0PUZAt3gD/9?=
 =?us-ascii?Q?sEVu3LvlBTJsD4Rws4732mdNs+aE0Ns+gtCclUhuut31JhL5aAvIE/8FXGEH?=
 =?us-ascii?Q?8fWj9fLQmZ5NHj5MsvCY4S82VlWH2BBhj5DYUbr8oILUhjc3zWNDw9p1KZ6M?=
 =?us-ascii?Q?n2cIfcA+/En29LXwAAwRi6wQD0X2WzuH2d2qVZh/0k5EOtdOJ+DPh/pXq80S?=
 =?us-ascii?Q?gA1iVnMpASXpaIKQ33PPU5FzxlFQ4ngcNLC1CVHXZ/yuLWPk1hDaWJf0KIpb?=
 =?us-ascii?Q?LIhBG40Q5jmXYg6tJAiXPtLWbo0ojoOQiGW9yPAfQSGW7FMovoDiIWEBS+uT?=
 =?us-ascii?Q?BZ97qhG4LxxJUKnN1GHMoJVwOXn7UsXlut6E7cUnr//s5YPySwfHl9ALAm/M?=
 =?us-ascii?Q?x3FPin46cPoN8+Qy0jcG90ubOT5CYanFgcxaSsKMn/o8kISMAQ5u/IxRqzSO?=
 =?us-ascii?Q?B+ml5TsfvDEiebDB+hm7Y1rsdxJDO9LuTxo5pv4iXaSJAXIFPoYXlIvJiKGd?=
 =?us-ascii?Q?PBHv6kP9UQ8bc6s6IfGoyFp83PZSerypYQ2EaAmm8tUjfhTbPUjmUnEzZ4We?=
 =?us-ascii?Q?gKFKQ9rqjX/N9hThAvzzjQ1tauuqGf3reKrICVdHPvW3ILxuercrJEyNX5d/?=
 =?us-ascii?Q?CB++k+dJrFsXmCFNz8xL0mKXos6OX0AAtcZWv7sDAfX9grzx12c5ORKM2M/r?=
 =?us-ascii?Q?kpP+7Ip4qglgYfcbcEnkrUPlM9lmU+BjOARSgM5P8yOwj353wpH6OjOPWAlp?=
 =?us-ascii?Q?BygIKrA73ZKdyMTMEJdvEVuI7PCrkIh7BIiHk2tEiVgHaexv3ya533H0mwxs?=
 =?us-ascii?Q?el7Z8YFGIV3Wn7FXh8Inth97WxKYQvIlzGb9+nr33BLFbpx+NCCuuh35/xRi?=
 =?us-ascii?Q?l1dDMkBBfT0U8Wt24Jley0fs1vistJOYR5uAM/q7GSPkn1cYMipTsC2eV42H?=
 =?us-ascii?Q?RlXGNyt1aFmlXV76/0bD6zsI5R+ylqh7lMFGUN9NIKwd/ADmRs+mKzECK07f?=
 =?us-ascii?Q?Ji0NzbDmXDjKt+zABjw6Xa5zHXHpY1eO2W61kGL0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c6c139-f82d-4c4e-4971-08da8cd3c47d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 11:10:39.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rf5GvlKpGoG5ma3HpM+pEezAsFPD4H9zqaHKMheNmjjYh7qOp59/s4jPIPIp8mjOa8gOrONWpEbNW0uR479KFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The base clock input to system counter is internally divided by 3 in
previous design, but there is change that no divider now. So add
a property to indicate that.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 830211c55b4a..2b9653dafab8 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -32,6 +32,10 @@ properties:
   clock-names:
     const: per
 
+  nxp,no-divider:
+    description: if present, means there is no internal base clk divider.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.37.1

