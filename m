Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194F659116D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiHLNbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiHLNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:31:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B163719F;
        Fri, 12 Aug 2022 06:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpACtzAS4a6b7PfqzW+qx3WHcV74VX3DwkmzybA4waG+kZlA2SOCbTJ+Nl9HGLPZCpuHwR4bQA0YTVGAc07ZgzAZJWcwzhXDsHD/is50XSgJ2o5SBYdDK8jGVbPwFJo9/hKtoqeHxvZbCeLtVi94ceBcnGq685fi8oQtSLc8nibPruONSuD0DU9ivwEF1eQHjHBr+M5G0SckXA2qd4UbgQN2N5SozQMz7Ct2LwkKBVk2xzGQuhEhIuiCTO0oTQeGDJchy8o27IXjm8AOcgc3VfAEj9chS7UtNekGSIbAMgnkne8F45WeubRix5l8NRDP2FpznJP8VSAYw79O2YaZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW3oYBS8XXMbDIVfUbFfDmYG5u/kbfK1bs29TusXIyk=;
 b=FD2uYQcGwSSRQajtqU/Bk+1AZBlpJA9wqVKD0x0Dug/pBakc4oTCnaU2sd9fwuTKTMu2na9INj0D7TgOksNDgKUeIf1JIznbIhhwTZBNjmCixeTLC8JsjBBtOdZfvQatnhWawpUCJhy6oxJiegTZPZXgjM/JTP2mmHQB6EBgRO8ZpV5GgeW3TAYlHR9iJ4s2991Quzhoz5eIIqfaWsrQY5OEOu6nruVxHWdF8cYJKyrjg6x3aj12mmUPuFGG+ypT/IL09vwRH0BPlpvgAW5tR/7s7DZccnq3dJiHSf+ueg6QU1YDEYPK780E1xATtivrHMJWkYgmHOwGBmFDOQxs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW3oYBS8XXMbDIVfUbFfDmYG5u/kbfK1bs29TusXIyk=;
 b=SO1q96u4aabu+EOpPwqhgqKokkQiAyhVTx0E8GaFf03nTa8tDrRfwpjmNNkPE37LZ85EndU93JDka9Cdc4r+C2KS7X1HneBOptR+xPCtrBussqm5HeLco9pbp0tl3LNyit41x0Z4ZPnu8FathCX/C3Y5h5lLy9ewzjqL40E5wxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR04MB3293.eurprd04.prod.outlook.com (2603:10a6:802:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Fri, 12 Aug
 2022 13:30:52 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 13:30:52 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: firmware: imx: Add imx-scu gpio node
Date:   Fri, 12 Aug 2022 08:30:11 -0500
Message-Id: <20220812133012.7283-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812133012.7283-1-shenwei.wang@nxp.com>
References: <20220812133012.7283-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::27) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60ac1831-6cbe-4bef-3b54-08da7c66e08d
X-MS-TrafficTypeDiagnostic: VI1PR04MB3293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tb8+UzJMaxxJ3J2Dyxv7vZ7IFSpWJjldVrld1IB8Swaf5l65DLKvXsz7sy11qMGNEoKWl911FGPCwzuQaEngUtndB0LIm6OBFECTK6QUmTcwF8YwSXobiFN7gu1zUa3EUEe1sWsf+GxyNvc5ZPxX2Gl5XlDob+6wI5Kb+GMCzxV+yF8muUrt0YCkRVLIXeJACsf0BJI77XB/T4Riojx/h7KFHYR+YMgmG6JkKsRcGhK34//C97IMxS+Yi3+r1WA7wPef6i1W1KXa25sfHyVUNt3+Dyc0BGZKv1o3p0Plzx+PEAiREwxsrXVKS1JWQlqZ0odalBlTgBBKxag2YfgpyPw0WLStPI2B0GmG7JP+KDFMz7g8LDWcHTKExl46pc8b9MpRCgwbDhXgiU1HMa+tOGtUmqkDvrESZeR3c4G8mWZKJZ+CcWUREPRXQ39LKxSmEa+tMF4otUahac+KXazABWVu24St9hS9UCNLOXVuTWaBD9x/JKgWZPvGRpqyNNaCvjFJPhD5NI5h59onsl6aDuUSdnE8cKchUDqfV1yBU4Rw/S6pc8zuj8LhnNE+270SfQoIuJlxTYFHJoRu7LMSiEReSLg98bTzr3FDZPCGJrFAC4DJ3HkD+m5tflOQpwrijEIBQ/xW+CLEmulnw7Od0mMt6jBcodf2jfsVQDZxmRVaACIg53UstEHpGd5TW/7g8d1ER+DYtQvVslEemj6z+Z8b6q6gT//n0ViAVMnlXho6nF8jLBJgQHXoj+juJd6OM3E26ngpeRNt5meETY5dFri4Et/IbjWf7YXS54yUaVatTwNa9IHv5GL/UYxQ19AJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(478600001)(2906002)(26005)(4744005)(55236004)(38100700002)(41300700001)(6666004)(38350700002)(52116002)(44832011)(6506007)(2616005)(6512007)(1076003)(186003)(54906003)(66476007)(36756003)(66946007)(4326008)(6636002)(83380400001)(316002)(86362001)(66556008)(6486002)(8936002)(8676002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qM4l+w93AaUAzJVWw4OI2M1npgkJhKIqBPMLqaIljdPRaVNVZOTmrGk/OdsU?=
 =?us-ascii?Q?dnuFhZE6TAEdgrsvKAL0L/V068YMO4v8WKWUty+/gB/JvQdaX+JmcFJBVYqH?=
 =?us-ascii?Q?FV2JKngv99lzS6/qoQ8mOJdv0eXU0Fb3mXyQDRfoKAUQv3J0fs+7/KT6JJW8?=
 =?us-ascii?Q?1wRWXhDvMNqvVRnk1khxKkIlqD2rp4GtC63LNtC+I1scWJI92n4emtAD3PLv?=
 =?us-ascii?Q?yQhMc7H9CWZT1962zTW3J1+Np9+xnEAsDendv3NI6Xe4lXtaaWtyBc/roFd/?=
 =?us-ascii?Q?6KQxyNujfCPNXpHnK0QPMpyBoV/iMEmwSfSXnlANO6J4W7Pp+5rs8ohVVtFt?=
 =?us-ascii?Q?NnHq4EiWpqRWHRCLhEQpCZeMCmym9F0xw4U+GOX7DKnb6Hv3jdQSwVlPxc5z?=
 =?us-ascii?Q?tA2u/rW4A6DZEV/IPHfIuGSGuwH95w6cEY74Ut6EEzZoNvceUsLbkn9X83C1?=
 =?us-ascii?Q?pTRDMVz2LjiGUSuUIA4Bwz9ekuWdF1diNhGHpal7GCvl7s89diGFZwarhKYG?=
 =?us-ascii?Q?RmqOOfJr/vovrlq8Bj/Aror+WLoh9SOLSyL34bDd3ZDeMXx26ywr1Mjm01AJ?=
 =?us-ascii?Q?7Hgq+SR8pEcTTUz69zRS96ahFt+HygEK9NxLuo/bARY210N9hns4CXfvi+mg?=
 =?us-ascii?Q?p1/4CHtptXzZGRcN+s1HEQUuUYsziD49nyhvxDapPl71vz6iE3aSiS791gHq?=
 =?us-ascii?Q?jVE0bViPsNr7uR5IWAigSQPPMNRE6CdmnR1enZuRioIa6s5ybEKhpITKe2tq?=
 =?us-ascii?Q?3DW7yL66CmZJ4e3crWjQDRr4u7OTBYFv04BDD9EnykZzQuPeLZiNjZAevfni?=
 =?us-ascii?Q?vjoX7sQKUtl85zCLf80ddjhUrOTXkdl9iMi7P4vYK+IkzqNp8MbzULtVeslw?=
 =?us-ascii?Q?MtGNK4Cex+LnKEWCHWPw+cnKs9adYQsXm/ELr8XYMsq7sGFGdA1BQUKSY5Mh?=
 =?us-ascii?Q?5SnW0OQGsjSghcVywJ5WuCrAhM3P3FFOBFUpygKaysjzJX6S2FfNWSuwpXau?=
 =?us-ascii?Q?w2zo0B5X67kNzw6h/lRMS4GZPHeiNe4NCelcB7DfIQa/cIgXKdjggLo3ZPFI?=
 =?us-ascii?Q?W1zlEDaLzpoujgXv4Mml4kCKYkwozlgVwX5hi1/VkXyPcVVK0J1y6rRzHWEm?=
 =?us-ascii?Q?m/NZcCwAbonWLWRyptVkf+gpmgIRz0qzcPHn2Z7sqhF1IcU8QNXED6COjpBp?=
 =?us-ascii?Q?3pAPCCbLQ12/5zTNTvNwyLsrnrCQNykGaSyptkyI4K/f/UO+rvWHnUIoqn/W?=
 =?us-ascii?Q?GZVdBFT3TR8V6CTh6aGQcuf99G5k3UghjSVovpAMuu3cWo9zkNPgM6Ligxdx?=
 =?us-ascii?Q?g5ZFiPYCMfanDTo5vhH+RgmyGHAt0EP1W75mDTXBpPWNQIsB1YnRgmR/X5sc?=
 =?us-ascii?Q?dQPH0onB64XStL2l07DD8rHFJm/NpDwpt3RAgpMU5epg/z2Z2liwPnFNc2Lm?=
 =?us-ascii?Q?sMd/jRhlluuW+UcAtJqti/c/XH3tyO4ThnGukaSiNXgDLBOagP76+i4hrHbZ?=
 =?us-ascii?Q?XqV+5O2xtIzij9BzY55WYXFKlxeiOiXwnbl9WzpdPLZOGPJBLD99CNqjeyoR?=
 =?us-ascii?Q?Kn27g6CNgaX1I6vI/V/KTbQkHGsLFSKHKPAXHoUHUXfiyU0sUJMCYUwCzQxB?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ac1831-6cbe-4bef-3b54-08da7c66e08d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 13:30:52.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0ahbMKmNWCK6f+IrAiB0MqcRqMN1TTvWQW5TAtIofSe6CpGooWJBMCmSpQMtCLSsTcd9GYhoKfnSUfblmX3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for imx-scu gpio subnode.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index b40b0ef56978..557e524786c2 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -30,6 +30,11 @@ properties:
       Clock controller node that provides the clocks controlled by the SCU
     $ref: /schemas/clock/fsl,scu-clk.yaml
 
+  gpio:
+    description:
+      Control the GPIO PINs on SCU domain over the firmware APIs
+    $ref: /schemas/gpio/fsl,imx8qxp-sc-gpio.yaml
+
   ocotp:
     description:
       OCOTP controller node provided by the SCU
-- 
2.25.1

