Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389004B16D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbiBJUPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:15:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBJUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:15:05 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5226F3;
        Thu, 10 Feb 2022 12:15:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXcJYRjJbzO7dRAaScW+BL9eXkBktwGpaaDL48zPxKAf5Wc5LbRpfRsWRXsnf/7+RzWm4I5T+H49/TUnijtSg0XJ9mhVumdXTjw9IrIaD6ANE2n9XUKyWZKIi0iPk98IDSiMfDP4DXt/khDCALUPTXjaRg6yzQqgo3aui7OYOO9+r+1OQX5GVg3y3U6Uqe13Yf6TMQMPZlSsJ7BuxNmN9nK0JqtbyId4K27aqEcXOwfY/I/DuBfxboz2QOYhrlqRzJMtkxoUJatZC21Fya1TS4ZuQ4tOgCilrQjTqX5TMsQaGjPiTz8/IS8Tj5X8e0nIVaxBevJl9xmcqH6a9v+jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdFZnx5y5I8aOZWdUNMVpxOVcZRRCh/fssSHbIc6vUU=;
 b=Zdz9woXHJzcYB+sYbE0MkQHvOBekmloeN+MyEMyrWmN0aK0P/j9WPaRruNdN6q4jskRoJieXIJlR1nRHDQdq6G+LxkCk9+X6LxVy0j13Y7HUulrZf1aFqa1vroHaDjDyCxc2gD0P6WctV+9hpK6HxSjsucug9lIk7jDHxw8/yW88qGl0dLCYwcTcYa5uHf/r9aVhuWkXSpFZSMDYeTp5qmndQRVOiIFVHKF/hf+7kdS2E4e+RR36bPZ4LM4QxPmngIK6lL68FRhfEuz+fOs1oX9uqhUbu7PtyVGb3xWnCGaoJgvWy8Kutgr6cI3kvYiYNJs2QWTduhOUuSqSsl422g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdFZnx5y5I8aOZWdUNMVpxOVcZRRCh/fssSHbIc6vUU=;
 b=lmqIR71TsV6lkLEnBNmwsGjWAS/Lyq+jnznEtngFii9wjW7OLvi+O9RIHpF5KvTn51p/Uh6mTf9DJ9udIaInBvNxSNO4vqkhPh198ylyxgCIbPSmF97UzOtAyqw5pVaAIUP+UpYl5NJIXlFAdJelXBg65052VIZLqUhFQzj+vmc=
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP backwards compatibility
Date:   Thu, 10 Feb 2022 22:14:06 +0200
Message-Id: <20220210201407.567860-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0137.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::15) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdaf66b8-0290-42b5-9f7e-08d9ecd20570
X-MS-TrafficTypeDiagnostic: AS4PR04MB9387:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB93875E26E9648CA2D7364DCCF62F9@AS4PR04MB9387.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ympowQ8mVBWm6OHJak7uwEjphWCo0hIXGhpk+1+1nV7PZpZC45yENMAQmWVzUQNpKPCSxbOcoe0XS7cosxXkstVYEep2EMcLQuBrXNvuzojqRzpNxW8fpIhFdvwYs9gYorlZnblUUrjF1RNaZ+p7cYsa2QTwbvr9hb0WFL5Hh+6Eon4/JCQ1nFbxklNVR+KY+EKN+mnd1jN7FAO+pVdF2o1n7yfCvFa+ADh1d9py7bPQ4ABIm/D5bB0qiElaaRSEBw3R0fMf8Igd+taJWMQ3YDHw9iGOw1JaxgHZC0i91gOAPNTUl9N/qW6z0AWCR29fyKnLFKv9aFoDGMb5rn92UizaWcguA0FF7mNhXuVE7sqZkOCjC/XkP7aDKEtiSBC5DMpFQBCY1CuRaANTukXC4MnpUx0GmKutGNkyjYvXA3iuQYIxZ8mD8nX3f3XcIAKvoMFBjIoAIXWEpeZHX6Qu/VK0m/RDgX+AKfIbQ3NC/TYkSIw8rIPgNRpZXGl/B7kzQ1cdbpAe9GGN0bPdzUQb/2JK35+95Fm5vtSak2khIsMp0hUARq2jQuEEQyQpGUUusqP1vWEReRmpojY1R5UwE8VO21snC7tjUyh9+5aTymrqAlGDNlF9R+XOnub9r27iK/K8sbnic7C2MVqDfp5J6il2DQVJwkh+5J0ri2+X0nuroZ1480g3/YkASpwpqq7LuhLFcIGVAIK0pwJXeYYe/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(4744005)(52116002)(508600001)(6486002)(26005)(2906002)(316002)(6506007)(5660300002)(110136005)(6512007)(4326008)(86362001)(38350700002)(1076003)(8676002)(186003)(8936002)(36756003)(44832011)(66556008)(66476007)(66946007)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERJbtbzw0ACABugX5xfUO+1LXfiL5ayAmsL4mHdQ5Y1tLXByLoV3jXTF6nUr?=
 =?us-ascii?Q?g2tOngGpOGNXwp4f6hLJZFHBkMX8768CfMKsSRgGq/A1ISEgQzBz5eBABUIn?=
 =?us-ascii?Q?8drF1VDDNl6Yq4H/Lf373IxSO8UWjCb1VdmyyXRIlS6rQ9eKo0cdbNzbg4Rr?=
 =?us-ascii?Q?5jVPNm7JIez8l2Jm1tZeLsepoJvY26Re7fma0X66I17Xc/n9mNvGlqPVyfLF?=
 =?us-ascii?Q?Q15OGVGofPe770vqgYVYFatCCfs4mYJJXUDZ4dNDvBhu7F+dluNQa1nSiCRX?=
 =?us-ascii?Q?jadU8CsF/bsMJzugvbV7FsCjAMUfpOl5mu/avC6YpV5YxjknN6GxPZ1PCyfp?=
 =?us-ascii?Q?kWIfOlfmgRyCl7WzY9oKhBWYR7aZYLrp2nER1S+WSmUkldn9YAd4KcQpeEpa?=
 =?us-ascii?Q?b+REyVphuZQWLjtieItZR/amkSTrtWrDkrox0DV03NbZhKe5dpSbhCRpiFfw?=
 =?us-ascii?Q?Q6JOGiNZNozV2wod7tm3lgdV12+Dar/iBC8mxHXwVMnkAYto2Ic30EZKnJpc?=
 =?us-ascii?Q?ENGyThgPKVeKYZt050nXt+uJKzqreMmd3GR929wvzA7KmK6JHFWCq2yGd1N0?=
 =?us-ascii?Q?ZJ1zK+kKC4J5rNX4rG2HYXzl+/kuvZr5CYdZUwLtzqxIwi6B4K82x8N+1jI1?=
 =?us-ascii?Q?YXXeLmGzh6dNItQqJfCeUJtRfdPAbo5Qp8MLbeMRvjaRDSR8OXZH74HqCPLW?=
 =?us-ascii?Q?V5Iv014NYFssUrGCa6Xt4jcPWigKC9K+vNU88mmcbLuK6OHD9AY+85Z7BMtg?=
 =?us-ascii?Q?gJEgLbhQRcWGtI2XfOIj7Ft7GsAibV9uv5WCLGZic2JpZwRJaNES9l05t3pX?=
 =?us-ascii?Q?NE1VikUYwLatkZihDBtGU/MNx1cgF9f8Dl6jsnJWx5Tue0LwiscJzgPnzsbG?=
 =?us-ascii?Q?E5MfI72oZ3fWwCbS3BZY774KMkuoH4ydn+n6TZ7e//PJexcCDflfQY/XvWZy?=
 =?us-ascii?Q?QzCS8vCqikKrIKn+qgC7NLJ0EkOZWwnA5D0rBrTsSwEHKqlvnzkpe1T9VcX2?=
 =?us-ascii?Q?4bUfZT+XmVtqsuLaGmuS5geVV6zF5AHN5wQEVVdrViW2tIqmqRKeuGkhsTMx?=
 =?us-ascii?Q?e1XH3NbY3yv2OBNgMOzfk9MrqxfLyi4InLASK9sPQedqHNhkmFuqnuNMXvRc?=
 =?us-ascii?Q?tWX1cHd9Y846jQk1gvCJ1WrPVMCBTvcCTG3GC8oxYIXLhE7iK2yUFT50gIUu?=
 =?us-ascii?Q?SEW3Yof8SP3eLMmqw6BeNfOXSczhVcr5ZW7VbGy7OARtuf7nY0Z58P6letrU?=
 =?us-ascii?Q?Y0C8to1h8SF9DPssGt4KuBO3OS8k9V7o4ZfKl+FTTifKWWSGbJMoDVJeIEuM?=
 =?us-ascii?Q?cBP3LJBy9NqfC22UdT7Ht4FhqQQFwzIFqAQxFGfhqS+2hfzPnjKN7SAjpRgO?=
 =?us-ascii?Q?77dR1AjP8T0wutVvq771c170+2iSj0/A41IN3ASoSb4ewcn6WBqTtgCCPMZS?=
 =?us-ascii?Q?+eRH/bQT+KCYfaFjD69zCItwCecb3AzGAKCwJYWdmgNDkXLBJ3gkdKQhl7D8?=
 =?us-ascii?Q?CzxcDc8xH77VToMzCq6npQEfVAf3vHf70s3aYcHnW5Y2E+v0Hq3HK2F/1D/3?=
 =?us-ascii?Q?IdegjqMH8h7A3MaKh1bbgfVx8Nx+PaXtNVDhmnOs2SvmJpyo8jA8rRaeiMiD?=
 =?us-ascii?Q?u4ZqAISOmg+6Fl6NUIAyAhw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaf66b8-0290-42b5-9f7e-08d9ecd20570
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:15:02.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CO3AhTTaPCFlUXOgNDbjqTVPsgMdlNwdxOQ0g4SQJdNC1JFZyvviwa2Asz/IsiTPCbY/cMT9QsZKEvF/YvqpwA==
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

Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they
differ from clocks handling point of view.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes since v1:
 * rebased to make sure it will apply
 * added A-b tag

 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 6e04e3848261..8a65f41ef420 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -21,11 +21,10 @@ properties:
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
           - fsl,imx8qm-lpuart
+          - fsl,imx8qxp-lpuart
           - fsl,imxrt1050-lpuart
       - items:
-          - enum:
-              - fsl,imx8qxp-lpuart
-              - fsl,imx8ulp-lpuart
+          - const: fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
       - items:
           - const: fsl,imx8qm-lpuart
-- 
2.34.1

