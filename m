Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547C8590C95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiHLHd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbiHLHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:33:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6EA5986;
        Fri, 12 Aug 2022 00:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KemAaTVLlEB2s9481dgtOUgEJBWYP9QFwjtEKLcrkst43MVdU4A+7Hkqtk2Djw5AE9ogaeS3taPxLmUnQCn4WOs/AzQUt9kk8Gr3P81Kd2cqN3w7Ybjjg6XJxW1asWA0kR5to93x+ikW/d4e+U5IrVCI/q5fw/5RZQhDylVbEA8aI950nx1/Oq0EgUlnNRL0en3qdCDONpRYoFof3Wz0B4JcAUOY6QZFMvwKl1ND30bsaaKbECNrQyFPc+vtbkU2QvpF20XyKGXBIA6EMrdY9AuZB5wlCanDF/UQFmD3PiIApPdUEzYaQ8ttZgGniSsOD9JOE62RC71ZfIMUmxcz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCbfbLeOjgMuTWWYh3p3Tyrs4T4dOlwYX9iAdQ3BbaY=;
 b=UiJvbkOMDIsfflFuhkhg8e0qNmgBtnjU+AxJr3SFhDKyfkESji9qYuOWUsVVOXE1rab6S5Kc0ta6qxFKuxUYOFwO2lwh1NXuzfne75qMnFVPpuKgn/ExLgqaqpfmKvKMjDPHsGDtD4bkmpnQpJFMuERZKYI5/AHtOPAOCocYFLfC0oqbg9IIv3S9udrWN97FHca9ohR60Nhqa9ElXEtg40Ezkaw8JOCfBx2nbmRAMmANVYhHA3kUnSngG2VPPjCrhZIjrLCwxd/pLUySrBzpnQxyS0D7CpaMcBuBF3WqbRBEezVcH1Jq9/gOIc5If5NYsdyqhWp7u7RJ6nuwXPjARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCbfbLeOjgMuTWWYh3p3Tyrs4T4dOlwYX9iAdQ3BbaY=;
 b=iHSJPGw+jOYG7eDxp6Wxyct9NT7z+geaG5zVhZk+Cuqt1dV1qPNFE19F5S0ufl7lsMTYDmlEO0lnn0Y4x3iP1LpjZEma+Fcpah8hvFliWO3xYcC1o3Rjsabf4uvGvU5rwbBg5HAbdP3fdXN5lp2FvKKaIxdiW7uee64bXtUMEnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6984.eurprd04.prod.outlook.com (2603:10a6:20b:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 07:33:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:33:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xiaoning.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] dt-bindings: lpspi: add i.MX93 compatible
Date:   Fri, 12 Aug 2022 15:34:52 +0800
Message-Id: <20220812073452.45763-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812073452.45763-1-peng.fan@oss.nxp.com>
References: <20220812073452.45763-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe024b8-8221-47ed-4092-08da7c34eb40
X-MS-TrafficTypeDiagnostic: AM7PR04MB6984:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4l6BMznjTMOZiYbY0dE+b05a8xgyfqTmSnjgqQdJGWdrY3dIK2qactHiG7BeiHknNmY/sPXd3uVki1hDR1mOwEXKO3ISNJZos77TMoRtPWIo9rEff3q49HGR9/JO6ChhfuNBLO/rCyDTG4YcfWVO24fKSsOYKb1MJTrHOOoA+NyQT0DiWLlIlJIpAV/JBC7+x1J7dnROJtTIrjs154w5XUrkRxIaK6rYwUbXNLfOQvWcL2d4wjcKbVXvwf72lGU5hEmtytMWCzJEvfR3Ji7/2VRFA7hYCz/TF6Nm/piqjOE2INs048fV6q6IA9WXucgXx/cQcBYgqKaUz93/kiYd4KET8lvv8KOnmkXiyYJ7Av215lJ9OSEuOdXUzDR7vlppM1Y02/L0nFPIkXK4WIbnGBC1CtOs47gj8WnzyMNYPs6CtGCVYwrCC+42nm6bSpaw8pnwfjg2ZMg4ZDAD5Nfuw/psjYHGgPsxrYSZXg/X7RpOze5DlARCQvIuEk9/yDSgBzi/b3U85S21WGQ/dToImuQbCPLqJNDTaXdBQh89birNDX+d45ptu/mWOTpfL4BJ+eLA8Gho7TEBH2fOMo3vEbFbVfNsQq473tqqg/6PSSNqIKagFfwssMztIsbCmfy+w7HV7cN65AMPnUT5uA/7jiQegSxXKEMBa9wULqyrcB7dJbh0hHk9j3/0eraY/2mtsYxi06yHLUYDzky7Q9hZ/fV0Yt22EP5CXRsDUt2eY+ABrJZV74jubHaQkrHw6k1fB2gNWifcWkDISFG0ef3L0S4H43t4h1/3GOTXjSPh7c3yTWGmfSHjuDV2XVkLj7kp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(41300700001)(2616005)(52116002)(6512007)(26005)(1076003)(6666004)(6506007)(316002)(86362001)(6486002)(186003)(38100700002)(38350700002)(83380400001)(478600001)(5660300002)(8936002)(66556008)(66476007)(66946007)(8676002)(4326008)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llRGDXYk/7RyM5AdIlucVYeLWJzEMfW9n2BnA4UtnpZ3tYGc4hf/iuEQNn5S?=
 =?us-ascii?Q?EA++k2PUy/xJ/pkKG6VFmoVtqDRwHWaI9u494ykW1q9m0Gz5E9YjbV+2QdKz?=
 =?us-ascii?Q?GwYHiYofJhT9j4ykP9hS9uYYdJ5fZgS0D6x+rPe1dap6GbpHX7rwVNQf48+x?=
 =?us-ascii?Q?PnNp4LUaFiXaE4ckO26hL/ABcH+2TIMKKSu2FTsLGR3VG4+JworWMZsKuaFm?=
 =?us-ascii?Q?DAqrG97OPoonboUj9vrr982CJ/LfaqG73VZhpq/m4N/jW/jr6+ensjc/Oj2y?=
 =?us-ascii?Q?TpQVuGD6ts9Vpi0LCAvZmm4HZ6AhK8fUayRO+C1xiVm/OoHr8DUxvKG5zvuT?=
 =?us-ascii?Q?ROxI/VbkimT2yD9W7kEgBnYgaluzAWDizt4OpZzP9QXvSaT6m2DracdKk+S+?=
 =?us-ascii?Q?4jkqnD/LvitRwSmafPSYzDFtaov8Qqy3ws98D3RypQtyct+VoWvZO0IXyPJj?=
 =?us-ascii?Q?2RjhMRx/Qk1w41Z2/VPXbL6s9ZTddg89xHAC+//+il7gF0rkJfHXr5dOGWv8?=
 =?us-ascii?Q?M5Ieu9elqPYjTSNvBNj71af0opkoYAqJsELL+LtZkUo/qU6Ktdo4fJ+cPUpJ?=
 =?us-ascii?Q?UPEQAvpWTIQ2VMnRu0Wp6tGEZJ+81EL5R+jckAhpDXqNOhcsC68mSEBNoidE?=
 =?us-ascii?Q?VLuYiJ/zhykFWMGKB3Lo5Xm7lF8lJgOWS0gdTETb6Wh/fyOLfd9gmqnFmCAC?=
 =?us-ascii?Q?W7fY2psBhKiYSh/ixQcmWaEBsy6nCUzvKTy4ShxRMG6OgmlbE9oVqaV/k/gS?=
 =?us-ascii?Q?6QyItwy/KQZCEdooUdiEkIic3LSxyAZ/I4pw5rmP+ExOs9B1JVlqOfmBghCl?=
 =?us-ascii?Q?Wa1hujG0kGwlGTJnkhs+VOw447azAsW4l3CSMPwNjTA9PJrU4YpYrPcWidGL?=
 =?us-ascii?Q?TbhOb53JMYs777aMFOLGI2Wvq52VO4vPYdXMIjVn7P/uBnlBP5wcauYTClLd?=
 =?us-ascii?Q?kCN3Ngf4VLEKBHYZZ1zO0acMplnhsvWC92izOSx8t/YDd0iMqBDkZ4DEZLcu?=
 =?us-ascii?Q?URPlIXCkbLk05Gp7UOobCMjrS+kAuSvZlOCIzHacPKcz2jHPStQdlOdr3O5d?=
 =?us-ascii?Q?F1WO8gWraIH9EARv/KKHBNxOIq7/NwmtsETQj/pDdOn451W0OMktg+SxChLm?=
 =?us-ascii?Q?FUdhGAT4VszVcPm/saYkO/w5QvOKgOibeTOR1AI6gDy98yO3maTPuK7OjYjI?=
 =?us-ascii?Q?q257aOoY78Lf4wEeaKZAZxQR2Sw2jWjWkU8TSYHzJKpUCzGDMcooJ4e4Lb4h?=
 =?us-ascii?Q?oizeNib8UvLlP8m8S7hVxVb0eAe1I2oNeRgZRBqDQDxWE0hGJqtCGhSCir2M?=
 =?us-ascii?Q?vIoXywMCEkAxJUkcAluIrMWDZJFTFULs7Zb/o5uRKHo6yyFCfsU2Fl3zGuzU?=
 =?us-ascii?Q?9Y/Eku8dRbYB4wralZINgZu5bKk0qC1Kd9WNS4pE7ME8RDaYGuxapbSooi0T?=
 =?us-ascii?Q?/AtA7ny+iAFx7aYPr/NNWxgUlfLYKWj17j90YI7/8XzHAiKse3DnLnQWQ9dt?=
 =?us-ascii?Q?DLG7PfNs/SzwH8vcCQg7+PVGizNkBj0CSGLpgqkzAAHTJ5Dp3ZD+UxfXYn00?=
 =?us-ascii?Q?h9vN1X2iCPhBwD5TByKH/e6AovxqQ4v+CphAdJNW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe024b8-8221-47ed-4092-08da7c34eb40
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:33:15.6314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ikXxGj2LROfFQxFuoURrsVr/EJkIyCNnwhRTAadVFSUVFHJfJehdtPKSaWqGY7pf7sa00sWm1RAwuQbVYnrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 LPSPI compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index f60b24a9a32d..8b44284d30c6 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -19,7 +19,9 @@ properties:
           - fsl,imx7ulp-spi
           - fsl,imx8qxp-spi
       - items:
-          - const: fsl,imx8ulp-spi
+          - enum:
+              - fsl,imx8ulp-spi
+              - fsl,imx93-spi
           - const: fsl,imx7ulp-spi
   reg:
     maxItems: 1
-- 
2.37.1

