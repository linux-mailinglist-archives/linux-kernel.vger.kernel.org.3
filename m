Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A402558B4AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbiHFI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiHFI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:58:58 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80118.outbound.protection.outlook.com [40.107.8.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B412A93;
        Sat,  6 Aug 2022 01:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOjkIPR81x1/Dii8+yVGdeFTq0ze81ZKpKAfA+VCuodcY+s/dILNLcZ757A2ZMzYHnt+PmA/uB1oj6QgNTgP0EFWZ8g/+0uCs1lUGedoJaRIGQGQ5KE75ATD5QhbgHBEOkzm45tCvn7Z8TeFFrju8DuwzRpJIo6QqMDdRkM79957wUsjduXUR77v8aE+4YN7dTcaScbfuEPE40pztWoT+5bqw/LqAKCN6SZFvN75wFgNwRjoW+x4THYzaEKKI2WKHJUahR4AKXtVES+s3bZ+Y/jqaDv20vhUTpOD05J+qpmzsLm9862LY9itXcAVgpxCgZ48DQl6GT7LpKJsHuRdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuHA+cPAJyodlvIi+qb0p8eyAh9zhu79eIruDmALi/c=;
 b=CaR2nTi1QEffR7syY0xSddypsZ6qnIRKlhIqp/RtZCGtLqkC92ZfxJPYoTBS7JIUWaVYY/P3fBdXcBP4jEchPOoZVJN4UkgIjOwZ35hKCVC/Ox0ou/O3/9Mbjh6g+eOivzGLwLPXuTvcl+gMmnF10z2HD8dSTPZq4SnJ+inQIoo+I3kv3+54eB9R4FfVYoT6o1g1ck2ATvWPGqv/898feLwUZuQBMOULUtpn2KPoM5P6bz4AyCXYBMlwBl/7ivxS07aksdiaU9L/ZSwieU6WtuW3eNg60bqL5rRKTlBpZ/NgbNGY2PnNzMtoX3V3CUOWEWRjEloT5QEbeI7/DU/uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuHA+cPAJyodlvIi+qb0p8eyAh9zhu79eIruDmALi/c=;
 b=ZTqVCCQhe1+LmsoigYFqtOu48MtkbPEcrK1UZIuyOWCWD6rekxiT1apEJoJ3bQTryBPZY1+pvMc0ZEA6UccOAm/FqQuwU5gYy/GlKG442BDE9qeyxCVTGnEu2bDH1LqvEYHbBPm8+vqGB5lvwdcYgBFyoX5pIgAQ+wtdHbjiL9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB9P190MB1098.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 6 Aug
 2022 08:58:55 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59%3]) with mapi id 15.20.5504.014; Sat, 6 Aug 2022
 08:58:55 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH 1/3] dt-bindings: mmc: xenon: Add compatible string for Xenon SDHCI on AC5 SoC
Date:   Sat,  6 Aug 2022 11:58:12 +0300
Message-Id: <20220806085818.9873-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220806085818.9873-1-vadym.kochan@plvision.eu>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfa34d70-3b34-452e-ef0b-08da7789e493
X-MS-TrafficTypeDiagnostic: DB9P190MB1098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxJPqV4hlhvNFyXMBHpF+boh7nUW+AVC9375uOFSO/l2+kIpAG6L7ve8ZkPHWjPmSMKAUBZd0by9Bq8XIYJQhyJ5btlAGUyzHOFtzaiUN9trGXoDEQNe47tF3mw/iDXrIA9/3qo31S5BjGmHU8QORtQnyOWkPg852cErBM7eePhL7hWiKP5YdOrDgSTUz1zAdFnh96nXuIzqjhg9aiXz3n13JhgGffO462YDpCT6fLzwJww+h+7duiEM7V1KVkzsSWr11a6oTLYKnH6BBxLoRz0c4DplXrC3ifmDy6Gmz8Yc0158xcR6iPdfUaFmieoNh1yj62qmk7GSgR4xA1Y6ge3yasp2agsJ+avcFFKgl+cEBFfX8McMyY87GrV3frd4rF8z6KAnjma1V6e17SoixyH9zCOFqLrPpOOKq82LLsNQNWgrMuguwxmNceqOXXJme2BNxdsFCmykx7E2Sm2MmKIeS96Ox6mbuvqAKbe053Ul4YW5S/0+V0v85FUpnGqh6uEc6W45rO5a0ZIhSNPQIfPieYFXUlPk/ZdR4VKgB80kgGufEyOFiYa8kGGDuCRzLPFXPPWEdnQUW/LEtBdTN7TugUrze/JYdmE8XARyKLqwDbd/tYahYJMKVCWpOSXWzgPRqdOI0dDsOtZUqI8ao5dqz/LWvq9P3iF+ypQRFUycxKB4l3jY38EkuILYz9Xn/qx0WUo9orWSPnrC+tL0hZ2DuVVsxmOseUv+ztPXCMmaa9XosxF9wYtsnzsZctvhbfZ1gUTspLqxQ96pAkYyIuyj8wq7K5r1Is/PAKy0gw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39830400003)(34036004)(366004)(396003)(4744005)(44832011)(2906002)(41320700001)(8676002)(66476007)(66556008)(66946007)(4326008)(508600001)(6486002)(316002)(36756003)(110136005)(38100700002)(26005)(41300700001)(52116002)(6666004)(86362001)(6512007)(6506007)(8936002)(5660300002)(38350700002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWUI3KXWsS/spesEqIblZLsejyEPePQNPB3r15T7EGtStVSCKOx3wnx4pz/Y?=
 =?us-ascii?Q?XEjxI+cmt8BhGL69e4WUpZ1RQfJGqlq6youMWw4WpsE+O66kHMuqgLObx/pB?=
 =?us-ascii?Q?kzy+gm7hK+d/8Um48XKT3KsHya0+dgu9MGpKxISYZEele3AjIAOLvm+6HAk4?=
 =?us-ascii?Q?Sm7gy4qvtXwwLo/Sn0i8nSjhto4tua8LkIImFvT+GZGcLIJ4Byb7/JK2PPE8?=
 =?us-ascii?Q?n2QNqc6d3uD6SWmPI/qOe1gJ+9pqHq+jENbj+GTPiGzqVnAg6k6xLECDGqX3?=
 =?us-ascii?Q?uNRT3Wqs3FE2dnKBpWobKe0teVOT8GhUeUFOerz4RvnmHObWZ/pbZ7LVQonC?=
 =?us-ascii?Q?ypLJNA0NAddrMMI5GrsadL+i5uDjVFO4Av9TCICZJ+DyTFC+dI1Zcs4AxhUt?=
 =?us-ascii?Q?Gubd7IrifJm6NECoUgbo+Vfo/tb414qOVcMTb9dJPGvEydhTdMrNbtXEjoeT?=
 =?us-ascii?Q?cmHaiOjL7qinSPHg9Q8LRrv4l+NEpgjkR8eBm6BLYqXCOKIwcSZEDixXKwxs?=
 =?us-ascii?Q?/MwkDjuEFEcdjzjftMhcc8wHLGdcr1I7FRaKkmIwPWRNY01i3lfqGM/mjFuE?=
 =?us-ascii?Q?7JNW/3i4B3vK0Fg9cVHiT+BPhKiOVhKCxWAiUcIWyqmWV/n+DjdFmGrCHhq7?=
 =?us-ascii?Q?9ZnbazhTEKazF4vkcuN/nPAQpo/vwcmODe6y+ZaxtwGtrjNPOsFXHL/fQpmi?=
 =?us-ascii?Q?GEsk4m/KakSefsldWS8g/J+gGMcPzdmw5x21D5Ed1cTRCmExugI+jbOzaXcD?=
 =?us-ascii?Q?jitT3SKAF9cgCCR7u9tHMPZFz2D+rj2KnGfcSwbZjRQ0Nna+nSMEPJ9V2lC8?=
 =?us-ascii?Q?aNdyuzargSQrxNtpwTxUi1CtnO4QOULSKgyREdfJ0Ym/EIs2e00rsooztfuW?=
 =?us-ascii?Q?+yU4zDdVk8+oVcwRcrnl6SM9yfIqNemnfkZVMOm6E7PakSFdFO4BihEdt4UJ?=
 =?us-ascii?Q?pmWnUiRXcT7WpvZo8j2l5dnSt2LFPo3r0pdYbY05BRh4a/583H2jm5WsKoM+?=
 =?us-ascii?Q?szy2oDFQND9RPBBtbElUNNlrgZP2JPrSVZK7/A49E36J+II95Gheo4XY3t92?=
 =?us-ascii?Q?SmM0E5Malk7nDewKp2g9y3LatZ+DrRUlxR9XPWqEPKUEHqMRjg3kIE0MQ78P?=
 =?us-ascii?Q?S+2KaxezK6Hr/2/MY9ZtJbxbRbJMGq3ER/oCoDsGsNqdProne0Ij+VcLCf5R?=
 =?us-ascii?Q?J3p2wTZdKborDXyHN6bl5ThEY0ifv3pRTyrltnTb6IHziOQLasdTVQoRyEkI?=
 =?us-ascii?Q?iIaSNekjEmVqXZ06dTia40akxSoj8t37I3NtDIZ/CW8obyMm1Bk5Mt+FMQFk?=
 =?us-ascii?Q?E0KJs01kr/24SWfLd5ayYIah934JqZhY1qkDAKrOxRLrGDgJ42KiWqAR8TsA?=
 =?us-ascii?Q?rCGWz5J1H8HxEinQ6xAeyMsLvx+PTAEKo6jIgcm2gBxNddVYxds0ggbmWnsl?=
 =?us-ascii?Q?TnAF4rX4ftycp4+aa6fbYPNiIQbKPg85r660eCo2WojI2ElV9LHLZK2BmdjZ?=
 =?us-ascii?Q?NliCJGw0zJu505rep5p7fDBttCs+6q6GfFJvNNwZ0F2qrEeo3JzJLEwxafXs?=
 =?us-ascii?Q?s9ZsCQ5+eDZjCz0A3f5IB5h3H7uhk8NWaYxYuOABDDSM1o0NFL9toaLFyj+9?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa34d70-3b34-452e-ef0b-08da7789e493
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 08:58:55.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffvl05YFIKNtXH0vv1D2xci78YaGTpFQZzkTOyo27Hr32uaLysrjvAslj3Jk7Vf89Kdv6Gm86xDXfNDtOJM+UoTbxCO4iPB0XlstaBsYvjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It indicates the Xenon SDHCI on AC5 SoC so the driver will try to fixup
the 2G address space limitation issue.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 3ee758886558..17cda847e0a3 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -34,6 +34,9 @@ properties:
           - const: marvell,armada-3700-sdhci
           - const: marvell,sdhci-xenon
 
+      - items:
+          - const: marvell,ac5-sdhci
+
   reg:
     minItems: 1
     maxItems: 2
-- 
2.17.1

