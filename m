Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E444D2C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiCIJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCIJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:05 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50048.outbound.protection.outlook.com [40.107.5.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CA106CA7;
        Wed,  9 Mar 2022 01:41:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExLzqNAcAWWE0XONpYALixxPjA5+C1qML5a2HriEJoTWOgqkUYPeLHaOrjITWDINeD93Ua8kfE867yE48bWoLRuL2yAlhNnzgW73pH3z0MRIfvV5Vk2Q6tDecWHHDTwrVKnxXila69WDSgm4uy5yJqKVLa45jqCmR81XBglxbCr0lBHgPSf52bZHwM8Oi/4uUzGcOur+2BzF1887wRQpNFvQGMid1owaFGIYWB5ip6gS8p/aCiFZoskoHCDTuOgJEVSiHrBZsLH1SNh6cg76N9UnL0ajYaLPOTG//i52mI9vdYibAaG2rhJ/mXr+uluWRABTVRWJFWynBll6OJ0Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNqHSPKxL3oC1pudsU1hWIqe0O8qhQwnJwtiPnDEpjE=;
 b=JOz7lVubav0VE/FcXVD1p7DQlptQqUdR7c4/BqZIKFgHX+IcpGFp4hyP6T1n48+X8lFM/EnXJoUV3Nn9HJCADQf5XHzCyXR1rdrpIDnyUOFgwY7ey3oHd8LdUX24Y7gVd2d3mBPzKgb7ImlLs+rXfjlUABkvbHd0eGNPEQslURSsvTb5qUOfUYixhylmW7uGPH1pGTcHAMjZiRIhJ64PLf23lQM5LGeyaOnxDmyQNK8x9KI7WCIpS77GdkOpK8Qq2bNIpJBiTN+y7oYIVdW4PHDiavZme1o78lhfkX2afE/oyXq88f8VYx5sv/thFMwlK2GNwViVJs1PdFhzWRUZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNqHSPKxL3oC1pudsU1hWIqe0O8qhQwnJwtiPnDEpjE=;
 b=JGpMAhXjtS1eC1J5E+sMCXEfEJsYd0FnTHVNe3k3fSu3seawA8fF8h+kY+Imd8ol3KKMMfwBHkIvF78+2qfZ+axtKi3clDn3Ge5SA8du0bzB9oO2cgER/IhHx+mbg3r8o5YcP1ZZYrLTHaK/8CTbD0s84uf24HuJmNUWWXOVn6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Wed,  9 Mar 2022 18:21:12 +0800
Message-Id: <20220309102118.8131-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664ed3f3-38ba-4ebb-c57f-08da01b0ed4d
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB60434ED0DC95943E7C551919C90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBDwRqHKtozxI0aFbdAbr4Avb3uyFOufEtr7ENdDu/hB9CpAo0Cel4JCq1Le4E7CIGmTq0lvYZCey+rwyolvQscGoilDe6x//e39txrkySo29lZ+Zj9t8GeaiiyWx6AozOlPxJwjDW2Ba1djc2mFxQwj4bx2EBLFH1uROwMeBzibxxG0T7gysIw/usrU7tJg1tgVQjJuAF/Cds2TiU9yoM9taq9TSdVZAydEYUJGgfJk20TWSKk7iA9CUZScPS6RMXKluJuqm3B19mcKhBriWw3vlwkOyrId7roZJjizFU9xCRqIbvcAzTfw/db4wUA7xyvPbXNEVssnl39VMk9/o86w+aylODT0p8fXDFKDw99kzoEAmQUI8IbnaLqPe5wv8v0p9M28vFJAyiAgArkOovmlKZHdlJ7HaTIVX/8pMfC+o5bbou19lxOLDcU2MGN5s0rCR5RfVRe9av0qVwbNOlAAvM0qVCLzgwomREHxUNoQKeJe6DaIFRLr9XpEa/EMzcBmCHX3xutchKTyt2BZVar6WFMVjWZuiJiWqt9zV5vwRl3VxqdMn31918wCsRXLjeov1XOx3/uquqIDEdJwYMadYBoUNW+DnoXseJHBo9sLnRHxXAs7mOyZ3aEUq+weod26Vvsk8GygPUQUeBBXQAvJq1k6ysg8NjQDZzDElMbfdJ6MNsaSet/Lz2QnQqz5lMB3JjVrUER4sB0XIJBOu7/OCmWLdiCYwv/IbeyVYKdK8Xpqg8IpYkoob3uCFqYK3+7bObEie3fgl2uq6GAtylQb82Dvff5tMFqGqjQ2Kms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(6512007)(8676002)(966005)(8936002)(7416002)(2906002)(6506007)(4326008)(6666004)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYA9rswvJcb06jSUuCxJRvGPEWLeY+Yq8TZYwIIWMWPgzNB0bGcVDHf3TXwM?=
 =?us-ascii?Q?mRB1emhM3WQ6Tq0/qeTNelL76M8KpUF3ucbk65ZFLdWvQ7GzaPWmPY5gkv2g?=
 =?us-ascii?Q?ptYwtsXFTsdMPxUQRq2z3lDxIVmmCbyz4Fvqn/0pJ+gPamuzCADFFcqTKJH/?=
 =?us-ascii?Q?FHZlesUUOkJBlK5b7Z8mT1yaS+oAUJyWsBPnDcQE6zB/4fO8Z+dJsJ1o9fKv?=
 =?us-ascii?Q?FTvyAuW5OtYywt602piVvjdaYjhHjXcTx2wz8tg0TC5Suc5avdn4ch+Sw+UK?=
 =?us-ascii?Q?ZjmHgp+FqCXfNj7AtTrjI77npSYaTxL+qmpWJlyCt7wCl1be+5EKgtO/AA7S?=
 =?us-ascii?Q?4n7SRpm0PxNTT0tPHfQQEW2hfUk4ZssEL9iclC97HuE3IC1RXh1HeP9H4Gs3?=
 =?us-ascii?Q?F7h4EHdYrQLRPLbpTB5WeREAWwA0jjG4E/YndVhballmxsuwcXyBwV8A2zDs?=
 =?us-ascii?Q?hwQWUjXU0zDO9r12oCaJMuT2N7Y6zLMYReVG7SLvADYggL502lQmYvqEsszw?=
 =?us-ascii?Q?9Z5nxIuwUe+zgx5TxcGAPZKSZ+pR7oH6vAziWbTZw7lz86QDB2LqSQkKB903?=
 =?us-ascii?Q?hB6CMMEtIXnY0xWgVpPJz0M6Ghk8Exz9QVjjkovdhCdJm2XqNAO4nbqdIxvq?=
 =?us-ascii?Q?7zOFD+RB2YweRgY3UsG5bgc9UiNsXue0AbiE3VT/RBYVooitTGuYakJJ9del?=
 =?us-ascii?Q?f4hhC2K20YZXpAh9Nz0oQGAGS58fKHMrIzAPD2mpMrpHEPsd6ArfFVfACffo?=
 =?us-ascii?Q?N3sWs1J/IQzYBgNbDZWNa3hKPXM3dPt7wAqPlYmyRGF16oapD5AhbsAVUSfU?=
 =?us-ascii?Q?0v9QqjCoKkqf/avETtgCGX8ZfnOrZvXTeWNrNi/Cja+DmKxeZvwIoMtlyJsC?=
 =?us-ascii?Q?29kFyzNqCLr3VDvGsEVkvjQABKk8P3sSBHGOUtREzl7p3+SFH/wZDZCeJWCS?=
 =?us-ascii?Q?+di0ULjvb7kToClLj1GPWD8h3GEV8D+HD1ydXVz1nC4MnwwzNduzD5EC9Ovd?=
 =?us-ascii?Q?dJuC7IBidHIE9DqEJMx8EALWm6tOgQ7vP9KMbbG8lWEqMo+WdknWKfpLzPBM?=
 =?us-ascii?Q?hymGBJKp/XOksHS5rBp8nnjvZabI+2JorKnrfvJPlwrGrsGU1t5BUtfFr3w2?=
 =?us-ascii?Q?AASoByJnQhArzp7BcsNhjO1BSjyUSLoe0KMmsZa3axAZtBwC840T9S7X+/9t?=
 =?us-ascii?Q?I080n3w7g/Uu05NDXoFXBBamydsQ/C1I9qvExw/cDlEnQ00qcPGL1nzlv57J?=
 =?us-ascii?Q?us6YhQ37ef7wNwRQeNeldeyyMcdOv6o5MJ6hVpwKZJbYCBzR3WGgpiEyci2j?=
 =?us-ascii?Q?pQDQPv5oeqEA6MFC5kzb+MbemdkQuUO89O4NJxw/HOA+7YGoAgpdjQ9xqvo0?=
 =?us-ascii?Q?dVDMHFauL0ik/72snjqwD2jStA2RlWWG029z0oa7atXJm00g3mD7BuMrANM2?=
 =?us-ascii?Q?UCRqXCk9I1TTwbPjRPOEC5baAQVD2IPOZr3glbHzqKLk1WyNjBL3guY/ebjp?=
 =?us-ascii?Q?dM8gkWgxy2tr6OJ8jVdFwS87OP8M+ApmNRZswaXxWOm1AJmbJcasf+4MbZdG?=
 =?us-ascii?Q?mtr512eIsAxslcYb+aQev2dh90UfR2AY4LBO4EyOF8FY231F/bWbVrjZpK4+?=
 =?us-ascii?Q?8YYC1EOZNCW8/jJJHoe15OI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664ed3f3-38ba-4ebb-c57f-08da01b0ed4d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:03.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3iHxzA72Tlb9GqpYglG0kkSYpnL8JIEEeyYwJ2cvTuPfjzmmpB2UVKWzcEKl5vVLlzQmxXp/wVSQ5I3/N64gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Depends on https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Tested on i.MX8QXP/QM/8MP
 Addressed Mathieu's comments
 Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
 Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
 Update commit log
 Drop magic number to get entry address from device tree in patch 4/6

The V1 patchset:
https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/

Peng Fan (6):
  dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
  dt-bindings: remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: support attaching to i.MX8QXP M4
  remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
  remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: request mbox channel later

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  19 ++
 drivers/remoteproc/imx_rproc.c                | 240 +++++++++++++++++-
 2 files changed, 246 insertions(+), 13 deletions(-)

-- 
2.30.0

