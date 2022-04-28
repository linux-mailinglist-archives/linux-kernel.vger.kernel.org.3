Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB74513B65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbiD1SUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349499AbiD1SUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31555A084;
        Thu, 28 Apr 2022 11:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwWJRkwECMKXWBjlWKcIICWb5afldzaNrWJk4IcFy64zcDduugvcNGz8RS+skP+MlBt0YNR/jTKdLbn3856SWA4duARHS+wddWjXAO2HZrH42y8qjEZQR5uY4DbWxw/Vnq5LoKzV2ZxJEgXnekblYMW7Fi2yjqusK/7ATt4B38mmSxMB8Sw5CWHC2HD9UNJLOFi9yQY5wOE6VzRZjAq+YLjG/e7zQNCbASNovMKvGHrNskpuVzuqf7PVcgZ0pPsMkQu7auQYib9hi9kijcmXgJYuALbfMM6neRtCzsb7OP39MgHa0TBXJg/bkI7JLF3EI6tXwa4PDhmU/taUcARACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AODrMzluPVtWvVgNYwpaPLBHeIUL7zU60OP6D8ebqs=;
 b=LH+KuXdpaT66czX0UKDmqUXChfwNs5BaRd+MxHVsutdRF3CEBJ9SZtKf0Vp797Ja/MS1pGPG+a+CspdzN6tOb/s2HCLmG60h2F+kMaQRUfFVesaYYoFZuFh8q7vOOIJZWsZZ+aBv/2lZCHTL3Jk+EnEupwGLTJW0mE1Ba2/BaUaQkLZkXigJH8J+0H8jJWSdckHHSSaAfhyK/+2ptQ9qoZylQvuPPg3XmfxNUc0x6KGjC7Vhbb6kSZvtIxtvYz8Cqvx4LsZu3qWSLq62Vs62nCA5r/UdZoopt8OKmwh3qMXU0FEZL2y2eCitoOv+FsdY9zKd1rb3TgEHI98wCuLd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AODrMzluPVtWvVgNYwpaPLBHeIUL7zU60OP6D8ebqs=;
 b=S0rG/wo/8mZ4vn+Z4BK2+3oFyqGggkw/fuwjxKhT3SAcTFi4zJc3U97CU5K8WUFBOOFYpsnG3dCsd1mIg0py4Xx+epQm4MiGfjyOYsTaF5gczBjU6uHiOPpVlo3UPxonxkNW+kSzkZ1ArcEjACCHVEBZZUAgqwm0PF0zHF/aUKeuSVB27DaGl1rgXMAqaeMrSpJZSh7BusV05V/uo+W02GxIiaqRUvPadP4KOK1jWdGp1wz5taZBhYrb/mR0Fjp6Sdf3eytxbuZpr2lrubtTJo+2Mfl4mNj7pDUt8236IqbHuUNOClYtwR/UzDLD0K8f8klGSZWV4xB9Az5oUA8poA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:17 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:17 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 2/9] dt-bindings: nvmem: sfp: Add clock properties
Date:   Thu, 28 Apr 2022 14:16:56 -0400
Message-Id: <20220428181703.2194171-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ceb3201-17be-42cd-3e8e-08da294353ce
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6775D95A5B1BBDFA125ED9C796FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVxcN5Niscp/mvSuVjXdQ39qzrGnuQVPTDrST/V0PZ9XgwN5gTfdYW6KUL7HDtkC79hzuLl3V6+EoRTWFIm4I9TCVcrL+n7s5geJFGqtRgSJaaJS5zitTIsri+Q7yzncTVT2qXH4RjbprHEAhNnRx+XPlK/iisnKqs7lzZE//DGbWOjsFPpQggBy8k3jXMjgxkR/AzhSkGSCB+w/Mhn3IME7bE0LCT06DXxjwy4EwSjB/TQYpexyxc9ES59tkwPD1BXOHnkLloQP6upexsSB7uUufWzqclRbBIwdKuBY4b7TBVURDL/u9S/ly+Dmco3VAE3EoXVUtTgjj206YTROK5IHYE2/kxQCMyszaxzGZMM+ZqM7KFljbGyIXwMrYR2gXaGNXODiRZCv7xl+MlZg1gm3tshjEV6qqFP4VG75fzc18bnFTnYEQUE75jEB0zVIFsobj/wsf+D6EdywrrUVqg1kG0AwnVgeJusdatSfWIeR5XKnui9rDY+X78wmJ4zmmjggXLjAeTILU1z6Jz+6d1N36nzTpgKzygT2eviVkUYEjWGLFGO3DqbDefcJENg0SriM5wRvf1Ery2TndpSw2oPNVMrkTBtGEvxPyxiFe54tfNcqFncyKdCFS/Jae7vdwS2tUp4Xj5acmWLpgM147bByZ2w+qRNZ5UUVKHRLuRYOF5wo0FjQOYxMO3cAyo5lzQB7cEENjjXs/EAWrBsXmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G70vu4DQLHVYke6ZJRQ/SxZQ13dA3ZTse4G21cwx9xIjMV2xSSTolD1m87bZ?=
 =?us-ascii?Q?PmUqmt2dUgGUY4tmEpd4M11lG5pb0oau4DEocWgJQTVSYIBna6qYgfU1ybUN?=
 =?us-ascii?Q?0JnYDd/4qft7BHfDfWHjuE3F3DjGWSR//x9XL+Afg0GusSqseVSekR18IlXw?=
 =?us-ascii?Q?VM9nF5SFJwtpbt6ZUi/KWJ+mUcU3FHuR3WPqZ46RQsFW1A9TAk6fL6cW2xX1?=
 =?us-ascii?Q?ouMjSPimBAtqbhlbS12qgE5WZsm/gpBqrnMrXmxgwxAFIsFyIONojzjGv4k4?=
 =?us-ascii?Q?EAu+QLUm1yIr3sFML8IeODKcAQCy8jQWw6ORjz5fwy0iyTLoiUS9I06/ip0G?=
 =?us-ascii?Q?mYNnd4jZ1KMrpuy3X/qPPXEkP/uQH7In+PXgGsT+q5xhldb4GFIbiGNfjw/s?=
 =?us-ascii?Q?IyV2e6oAYW1mDajw0PawY1UHxpGbG06wXaQKx8MdT5R1+zkO52BHqgsb/LGP?=
 =?us-ascii?Q?eUSNKF/oZcZPSazVQhrAYx0FHFnmObTfwV9QI/QCq3w2Rl4mnsZGEBOXRIKm?=
 =?us-ascii?Q?y8dNnM7wt/aXxjwz9z0vyMrIORI7MzYgjHzt1ntRomb+k2KRPay381BXFKh9?=
 =?us-ascii?Q?JHCp63fKYkgRv1DDo1qkIon/lxlmVxRNqxOWXcuxbRhk/kGoKoU+/e8ecFdg?=
 =?us-ascii?Q?wCdfnNKk9mipeCi/pOvIxRnknj8+MlECcmMbKmIsraJTBOOGJNvEUDwFbizw?=
 =?us-ascii?Q?sIMtNbBPgqnOMZ0HkZw1dEn+UWQObg4az1omZ62gYmhdqBAkQ6dp19sQ0svG?=
 =?us-ascii?Q?ZfhA+8/1njSIuhdAaf29x94FTVcCgFBc8NaURk0uQSXC77ZaAqdtrMDu0kS3?=
 =?us-ascii?Q?eOADm/mhUnBUhhDLBJ33XGbePgDsbabBpbpseFjb7nTbf7FqWlSKgFdOV4ce?=
 =?us-ascii?Q?M8zPMAiSc8mj3bbKC1Nd2XNgY5CqOwtAAj+MrvL+nX0UQou/Am4AgnLUgq0g?=
 =?us-ascii?Q?bgChBk5WW2C7O7JSp7HaFTFKUF+ciQz1p39yDnw6c83rNr/tg9Mbzisml3bN?=
 =?us-ascii?Q?aFwgkMFW00SfICrivo6HK3DiL/kNQ0nOLlo3AYMvVIfImLXLM8puhJyOZaKv?=
 =?us-ascii?Q?vgzuJUY+Br3Qlq8VtGdr8Z2pljFdsWHGDf5hHFTz2crMjjIIm0sLJqZ1XYRk?=
 =?us-ascii?Q?ZTAkFFaK6TjSotOrcBCuw6JxJghVCfConiRt3W8mK0DGCjpSSzc9dtCUsDEo?=
 =?us-ascii?Q?yYxKaxxijPAMognzwSng316CYVSatMMemWbIWDAHVcC6qOGvYR4NCgtqBeuV?=
 =?us-ascii?Q?19o98DQkeLqMF6QWdgfsEhh+Crt3ikZbnhKIu9mP7H8BwQBrsDDemjQD50Ky?=
 =?us-ascii?Q?f3lJrnaz/TMqwl5C8lKLSaXkzQdkTwTA82dh4ApbmvSMdN1A1+3CGQYekpJn?=
 =?us-ascii?Q?I2NNry3ep4i+jsny2YFEUq94Zu8KM5MebrHrCqUCNHwo6eZ6QD2nnv8hb2H1?=
 =?us-ascii?Q?dOd4UJq1jYG581lCnb9QMDCPQSh6YmQG9tp8ykToJzgYu4oT3hlkGwXgHtnY?=
 =?us-ascii?Q?3a5JOEc4iUfLSzJcyfhZpG/ggUWhMmo/KsHmrR2WH2ZtToTSxGFbyOmg0kcB?=
 =?us-ascii?Q?ZB/Rop2yxIOjR/6hQj0qR9A9pu6g/87XLp6GPqH96HXw20cOdJ7kfSSJRBU5?=
 =?us-ascii?Q?Geoy/urD2GyzucNEufqr7zvfN9xn8RsRRC4MdDBWyJhUEKokEcv1tlMmtTJ8?=
 =?us-ascii?Q?um43dsRrItRjmaSh7/mDkLRhA+6slVQy+sKIER7W/ML8LMCnje6e6k3v6mT8?=
 =?us-ascii?Q?KwmocZsb/2yMaRktQgk/hq3AMCeyqYI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceb3201-17be-42cd-3e8e-08da294353ce
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:17.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrL6p6xJzU+tfE80QfvEaIAnpsJedX58Yyt6vFMmrUeNcAUUsm5YuqdYE8+Xs7KZXEO/iK2NPheWsjtCJyu8ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To program fuses, it is necessary to set the fuse programming time. This
is determined based on the value of the platform clock. Add a clock
property.

Because this property is necessary for programming, it is made
mandatory. Since these bindings have not yet been present in a stable
release (though they are on track for 5.18), it is not an ABI break to
change them in this manner.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
This patch causes CI to fail. It will be fixed by patch 5.

Changes in v3:
- Update commit message to note that this binding has not yet been
  present in a relase, so it is OK to make otherwise breaking changes.

 .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index b7798e903191..54086f50157d 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -24,15 +24,29 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description:
+      The SFP clock. Typically, this is the platform clock divided by 4.
+
+  clock-names:
+    const: sfp
+
 required:
   - compatible
   - reg
+  - clock-names
+  - clocks
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
     efuse@1e80000 {
         compatible = "fsl,ls1028a-sfp";
         reg = <0x1e80000 0x8000>;
+        clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+                            QORIQ_CLK_PLL_DIV(4)>;
+        clock-names = "sfp";
     };
-- 
2.35.1.1320.gc452695387.dirty

