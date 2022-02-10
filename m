Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01264B16D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiBJUPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:15:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbiBJUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:15:06 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232E273A;
        Thu, 10 Feb 2022 12:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay44aqSoel6dYKAC0mX8Dq+gXjFFPOQuYSsg8tX/66XGdQGYtlziV4gvTpsabPIWVBxzhEqo3q/bIANMySIOEphoXMGHw5rDAdNewshPuSdeFAJATAO1DML5v8Mblp+ClEQMCKx0sjOv2H2i+eRD7W/UtIFZb5+AFQ7lkaYi5rcxVWrIZK7gFgnoUJuC9oo4637BcVuvJY12ldyk0oMPOckAcitUuwB5aqRKf4KBjZIJxwNwY1Xmc3Z9ivOQAeiCCTU5QuXbaIr+Hb3PRxoHX5Okwqu8MlSXqw3eNndlXkVXnULHiB/XCU88tgKqfuYnxoOwHAvqzPaG6wXccZUt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84Re3LvUbWh1uPMAI2xBJCBZoWabUHXGeTFc6wLB0SI=;
 b=FHh3et45GycOYJauTBauU1zIteHumjHxzD7ntEMgsqLmV3yVTOQg0uoRy5o8jUXYbj34R+s3TftUlsAMgzKMr4U1g51jodfEybysF3lO3ID3+nEaNvGWNxzDZ+Zh0Ui5+iaaoX7GRUhFpofZCXbWT3frq3gXeBdE8z/j4DkqT6uPJuO+89vR33XjPS8fS+3OQtaFFIhrJt/2cDi3b2NlkMpfnZnqxdKnYB1ruCD5AAs9fqOJQrea+j6CP5q1jYog4xq9smt/RKOC3/1c0Z1m2D/Z4Huq3RqR/QKXSK70X/GCM6XWEap/p/oDkn01ZTwQm/8DJTHhvEGxuMn0fCJheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84Re3LvUbWh1uPMAI2xBJCBZoWabUHXGeTFc6wLB0SI=;
 b=K9vFPL+e52fLDuc0DrEbnoX0GxY4LaMnXmtZ1REU9udv5sGiiya7GzMQd9B9js0QYniAUUhLofu5vhWLWwI4r8Y0r7+/+jGGGYF/mIA4/vSb/5diD/ydgoF4a4eJiJ/lo2+8Z4iRQNPkVTLYZGQm428STUjiGLPAzqjM+AFPCtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 10 Feb
 2022 20:15:03 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 20:15:03 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 2/2] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enum
Date:   Thu, 10 Feb 2022 22:14:07 +0200
Message-Id: <20220210201407.567860-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210201407.567860-1-abel.vesa@nxp.com>
References: <20220210201407.567860-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0137.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::15) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c59d7d76-ef7f-4827-4b9c-08d9ecd205bf
X-MS-TrafficTypeDiagnostic: AS4PR04MB9387:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB9387F213E8AE950CAC1AFA3AF62F9@AS4PR04MB9387.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaN13oWMsbqHtQ9SvItAqs/VcJim6NGD/AntF0ndmB5xMmWSIBCd3yKXdrFSWIKouPkwpSfUDJ62WygRna8h08lh177N+B+7GClD2TRYoc0pL5z/t8D/3OELmVIP1sNk7sjC/HD+PohW2gyyiFiaEPaR6UKnFaB59aZYzQRs5T8++NTMpRSpV2mSolpM8EOc/WUjHbeU9RL7VyuEgB66yoObsuZ8euFeoyykDIcfP472QQyfSe9+j08H6INX1LzZTH9+b3Xb63s5/zo1js+eA4ET13+6QAlJOUBAfBOaWRDitNHLlhlVf38zO+wi+Ax7/RT3fp2CVI1pCz1e0+UAXu7V1mLjVmLh0UGXEn1ZIRlq8GoI1ayMPm82H0UG3yGtDmpymmAXzGfNYHeZcr/xja7H+6cdlso3eP18dyQEyLensS+KNnpU6rxIcKyXYSwU6fthA7GZgyqm3P7+UMbC758xROF2KLeZRHRgYZY59+W5cK5TtiBxWtywn7OedE7+fBvilxYcT4m+o+0THQ6nuZD6ZsiJyLhZO2hrXThZCyEe7mctxigpt0sVy9p2gZCDP7nxPiV+2E4/KUYKy6lF0KFoQbHoXZ1PoQiDj8w9AEujiAt6iNz8SHGcZM0IFaDOSpamOpLO5p8RMip+cPMAs7OV7AjF2hn/2xKHqECbs/HoUaCu5LxqBFDSgsJK/SqU5XKyCcE4a0+lzHaFRa0jMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(4744005)(52116002)(54906003)(508600001)(6486002)(26005)(2906002)(316002)(6506007)(5660300002)(110136005)(6512007)(4326008)(86362001)(38350700002)(1076003)(8676002)(186003)(8936002)(36756003)(44832011)(66556008)(66476007)(66946007)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYyK5zlp8p6Wqs/GloOrG0o0gLecJ9iBMkumzs2hwylYA26wHBUh/1hwoQMg?=
 =?us-ascii?Q?EeTZnxmvX/j05UtX9mC3cKYjJHEFQ+Axn2J5LV/ea+kDX8zau3NuxqhWzqn/?=
 =?us-ascii?Q?HsJao7ZoaPVpoP6QmMwpDk0FrRNdUdeNbTRkJtuhMyEzAXh619uZpefhTuIn?=
 =?us-ascii?Q?4R2mGlXrQPRbOEZEBDyDm1VI0sbO0ZsWbUyFUtkiL8qDgk8SZz8Qz6rJvJfq?=
 =?us-ascii?Q?6mAzrUPdrTyEH3RONZvJbNA5jj32w6P7XNc2PAdDMICwV+rvuYneBNuEeOoI?=
 =?us-ascii?Q?aY8kokzG6VzMUMfZejvXiPXb40RPbmWAi71qC0oF2s0j6cld4wz8KjK8ool2?=
 =?us-ascii?Q?FxmOpBvnnn89AQG0czkClpPapdgQnK6A8+3azcGYSTuZ2Izji4BssmALxme+?=
 =?us-ascii?Q?enblhF8DoJYZzFKS8UnJy3ZEh2PBy1GGjJGgg8OjS2skT7+bZzfi91hckxbh?=
 =?us-ascii?Q?NjiE8ah+ejjQoQhm0352zga/usRiriCnle6Hq5R1NV4k6NCQS0OT5x4YojZH?=
 =?us-ascii?Q?ZobKILfL2EhpdKkQ+24EkmHP5QwUlL9M/VqoX7K79FYLTOW32RMg29oIiI5r?=
 =?us-ascii?Q?fUTr27mhaUPoC4DWBwURIBwl70PXDCZyOs7kb3bYx/HKTKmtSuP+yn3cRUZJ?=
 =?us-ascii?Q?F6cdVsP73kcOUjkTXyWracMKHqpMu70GLhXcwEPCtXnM7kxNWu3w27EmxJ0j?=
 =?us-ascii?Q?bfQ0P47TWzckN9yGU0vTR8GGApcDWoajNYcBwriRDA3WLKhpR5XU8x/UFhue?=
 =?us-ascii?Q?/4LqCYXJqKQxCrChvdJ0npq+LQ+kox3cIfBGoZyCwv/vvo0j+hGSHfIMusrK?=
 =?us-ascii?Q?ySixQuOykfLU5h05RsVz/Z4ppYNhUImZ4ngQcLjdGtLQ7t4jzVWbCKo9tB4p?=
 =?us-ascii?Q?ij8z+SGoFXuDdespH8F1MbXUIh+5+jlOwQ+BFV/+iuyppuC6UKo4+RaFKbOc?=
 =?us-ascii?Q?q92nJBKn/d0mKQYMJi96XM3QMxWkK9KqLF9oq9zg9gfOsd16dA4K3anj+Gj5?=
 =?us-ascii?Q?JhmnQHXfgpO+yRh8C86LrKo1kqrfRekj/SGQFo7dxoVd1q6/9LzYFbFVS31z?=
 =?us-ascii?Q?dwEGAeIfJVAWJeDAu9vJgMRAl0zdBppSjmEPFgoifwFnHWaxqV7iYvCfe34h?=
 =?us-ascii?Q?uEJRJtnM4/p/cr6AMyYmHfQwNmr1LR02afo2QoN40F6Cx6XpU6ZzoiA0Lfro?=
 =?us-ascii?Q?Fip72FTh9VOcHQnyUto8reomUv3MLPJAFUK0/TMaTAiE5/6aTmqAn9r6uX3I?=
 =?us-ascii?Q?L+w9B5v5+eSznXEFkUOzSfdFaXQ2LHEPrGq3vHgOkKxlT1106CHOaWzjupWN?=
 =?us-ascii?Q?RQh3HQalEPzt/wSzXPi8U+AMQ2T88GWPDAMzp/MDIyLbboxi0npK3BmNDw3p?=
 =?us-ascii?Q?1hS4QJUUazVZxgP8SKXAWP9/T1aCp6BNxK/2RY266nnvNsc2CxhGUM34BlnG?=
 =?us-ascii?Q?2pLJKfRXmIv8ksKfJ3qxjZupDPdoAunbp86EX6QfwEBMaPcdJMRmSv1biLHs?=
 =?us-ascii?Q?P3SxVqNnY1TrtRkC4kFXd+HJmOjPfkeg0OtB7flCsEOV8uxm3kD4E3LDqyJz?=
 =?us-ascii?Q?yu8eh8Xd4tn2guQeeSpxeaP9rB4JSKMMfvXS7OJfFzR8y10eFuAxgm5jTOxy?=
 =?us-ascii?Q?T/5lUaKsVLo0AbrK2Z5It3g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59d7d76-ef7f-4827-4b9c-08d9ecd205bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:15:03.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpY2nwD2Rd6MPQgUlJUQ4ct+Yi84Y6OprlRuF+4d4HnJiJNh0bMMMeigOQIqTjRVX7vXYyyIQJdwy0Qf3wM28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QM lpuart is backwards compatible with i.MX8QXP, so lets remove
the single match from enum. This will force nodes to have both compatible
strings, since there is already an 'items' entry for that.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes since v1:
 * fixed type reported by Peng
 * added R-b and A-b tags

 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 8a65f41ef420..11727e1cc766 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -20,7 +20,6 @@ properties:
           - fsl,ls1021a-lpuart
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
-          - fsl,imx8qm-lpuart
           - fsl,imx8qxp-lpuart
           - fsl,imxrt1050-lpuart
       - items:
-- 
2.34.1

