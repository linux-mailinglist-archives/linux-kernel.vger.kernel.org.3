Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06E50A78B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391043AbiDUSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391013AbiDUSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7A45AEE;
        Thu, 21 Apr 2022 10:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKQOTl3acp/eRIgCI5lr/jYYT1Cv9n4zMGGGtj5dYa4Wku5e6U0t3UPvMJV9ageU8qqSHLuF8Dy31fHJtAUDSC0iHA2A0GRHRb1a7rrLg8gVkpfJ+fYuii9R2UM6qu6DrodBBNCbyDwbaKdX3Mq3+y0AIXiX2fwZr4L7jT0A/e0nUNSKeqMUj9lHoRzYTibl3aDNRFJrgcGLNSIvThTDpx4P5JhWy5XSj8yWAmmt1TfULKm64qMWPGTQgw9MRAdagtaF9vTIGvvccb7/15IANqkuV83K91UYe/i/W7kr0tV4n/k0LIa2JTpfYAG+tbZNs8pYsPB+08OT/Xz4fEEzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2uq07iIVm10MJyFcKFA+LOZyHYAZlm9hF/QuV+/QzY=;
 b=UmJJtzQisJJRIyD1ncC4tjOwf5X+7SA4Z0tLz8BO70FV7lXxOv3jj9D5G4COg+i5UrtYAfdynD56VXAVqB3u9Ea1s6nEsDiqQFq/b1aWEUF9SkdJ07baGOb18eRa2kah6A4sGUENSVXB+bJZNS9NSHvC5tHR3EQ66wwubsdqGJ7oKs0k0t6x8xya+eKdEryOiL5b6JInsPclIUus+65C+MVwQJI2ZNqyVpa+eXDsfv64ytJBtp1wJl3SffJHjnOy3mp66sVvG/8dljql8ESklpLWMkmk6u5T+1QBd9Fr6El7Ciw+ri9lQ1y1+ElBbCxA8giqvbDoDj/KnLfsVX7YXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2uq07iIVm10MJyFcKFA+LOZyHYAZlm9hF/QuV+/QzY=;
 b=BIDTncPCXyJQkWlJFEbIY2SpAl1CF6lTo/zq9bYmtz6vv2Si2jy5dSEVZ5WLoxAD2D8balUb+0Jy6gW3dPncqPho3ed+8cPzSqeFQgLUZ0OIt9GsbFyAuu0ScIf1/vNa7cAkkHSdVRDFrcPH2D01SEHo4i2VM0U+RfpAkEDV0t2Usrq5ow6V4ZlFHfm1mDnhIOcJsaNcC5u10/ZR09VaBvmVSOiaz220aUUvMXCvUJWWF49yyVssqMV92b7wBS5RQM2VYmCoFFa+VZ7FYmfhI2fEeFM2VtV0i8KKaySLTN/MSpiMMLp8HQR5ZiaC4jh9Auhm7nay0cNO2e/w+pfiqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:12 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:12 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 2/8] dt-bindings: nvmem: sfp: Add clock properties
Date:   Thu, 21 Apr 2022 13:56:51 -0400
Message-Id: <20220421175657.1259024-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ecb407-e5fb-41d6-227f-08da23c05ccb
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB810131F23B7E15E60DF1B35496F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4er7u90ad0rDEFgK6RdW1gZKuoFgDkT8qEtdMA2LXu+6TTo/eUsynxkjHDq51CcEh0y/WDSKhqi9OQEgYU72QjJ0FmUlL2wKGvWnp5rpxFu1A0Z1MoBB+dDzvhvw2ZyzeRg52Fn8syTMwrTWdNDrhVUUQkuKwRfRVNVxSDAiNuIusv37dty9f6sbbx8Hl3atjDERzokvQ7Pa80DE+XwaLpE4p9qAVox31JdwYBbQyW+OcyHjcW3Ci1n5MvtfC0xemmm3kFNWqxYpkx0PFszqjtxTDTXzKEAhX0bgegNb8o17rhshsnkDwc80AIW61r3NxDVtNW9LvGahtR66e3dHYlMEepSEz/Z9X/5Mr+6dFlldjWGv9luj7sRLbTXdG5EfFduw9qkCm/iCYc8uJtEDjRmH/9RGoBEAZEXWOWcnN24XClN+nAK4+lc0gDF9xVo75L9VbsrITGgDCRZX0dM6302XXZvuigchv4NQhH86O+2L7UmcYVkOg7P6M/tEh8JXWrWmH/KtFd5B/FGj16VZ184+TFOZOI5Eu+9bzWUV4+QnzZMvvgPkMdfqsNMc6XZ4BfjmlWma0utQVQiAUL0skmJnm06V7lRIIggL/7J+sj7xqIkvNQCYmok5NKv5uAB0OaqJghrdzgR7fCeqtJKYdaFGK0Tyrt70L5SZ/yACRjl/2ApzTKjJ7hbm80cIoroT5dd6FgfQWsi9zPkXtMhzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LMHA1fOL/TMJiFZoAc9k3KyBeaJL6imFr7pdtIyw1U3+76XXJlUHtwv3DPSd?=
 =?us-ascii?Q?auNwT1YAtmX+8uypmTbrN7LKbGn0BMN7KT8NRQvZnS+LbvqNk5/Ck0zYlZ2I?=
 =?us-ascii?Q?c0bTMvxvvklI3bkqiR9qdn6xDQTFTvmjh7jbrg+zItSaxZ8OQ02fgNrf1PN8?=
 =?us-ascii?Q?nQ2NAdWSvty2jU8q9qxd2i1ndKFC1IYy3CmjgBsw75bmzMyNtg4QSGOGspHl?=
 =?us-ascii?Q?omB9EWLBihSQtt85/EekdDJ7MxbiZadFgilowTgPpTLjriJOlF93gKaCOWsf?=
 =?us-ascii?Q?wmCTFXeDCP+l9Wqdi5ptrEKXdHDSeIezD5mwq/Lmz5HBgeOS4JasHvlMk5Yp?=
 =?us-ascii?Q?aMp/RAa6z5sm6hEbaPyPmWhXrQ1hl9dWaNbz0BeLpK/HVOni/ptG6mCC6USj?=
 =?us-ascii?Q?pBfKUht5o1G8hIWwdXhuKNZNDaQ2vfzG6zUNeYJImHLDA0pQn7oIUs6xj6HN?=
 =?us-ascii?Q?/1UhyN1XKBTBrITO7bFGrXTJBAGsYuboWZGf4GFctbJo7NbZn15pq8OG4zUe?=
 =?us-ascii?Q?b+BrdBjNoBnGg6LoUsa+GVOUkL8N6/frPSFLMoEL2y4nkzVP8M+xQFajA0TR?=
 =?us-ascii?Q?UdmgsKcfp7OFzLuh8PwvfXcl1zktsMEgntA5MNc3a0SzTFPTq+4uu8LTnqrx?=
 =?us-ascii?Q?NnKDoBc5rFmu1QPpGs0SFPWXysIatP4SCICIAjiAp6aN2P6sTn20XJOkdC11?=
 =?us-ascii?Q?YI0F/gEooHPrUTlsPrAU2EFsfdx4NYzqy2EpmVaieH7WXnT0JNGCMQwvhCK/?=
 =?us-ascii?Q?gVCbqCY/i28e9vBuBLmq12S4xRpck998gpxSPqKENzum0cQqc2t1or2GHTGv?=
 =?us-ascii?Q?yVnPlk6Z7akQw51yUhjzO5qgGxQ9K1Piz4GC3Gi1Bg4xWWxDRhmN6OrlMrGB?=
 =?us-ascii?Q?29P1eN7RKz7P7JnkGye+PqcFHGD6PSS3TEjAe/oiU6gYfylGRnM6Z569zzi/?=
 =?us-ascii?Q?ggjXGZNdZKwcZkmP/2Nf+yPpbtGWYM9TSE258GkQHCGTP1r/Hij7zUihMsIW?=
 =?us-ascii?Q?3dFOo5ZTHpGE9PU8lEcUomdBK4k2zpsvmFkj3xXgPmGT+C3Bk1mgObiAe6SV?=
 =?us-ascii?Q?ggVTLq2h/L89r/QUwAEmitqSNm9aPg/eMMJXc5FEvJOkOPA3QJdN5LDLHKTr?=
 =?us-ascii?Q?R84Xki7AYhLNHSVcB+dVdsc07Qh8Ti2mBPTck24DkxFwEgNlHjW8YD9ow6Zu?=
 =?us-ascii?Q?9hu6cvV33d59tS3dgZPH5MYC6XCwPWIc2djlPnvlVYdyiZ1xpzBfVLMajTXF?=
 =?us-ascii?Q?7uTRqTUITAU/rfTgoJS8QsU3BCx5qlunkVi+54rk3MToZZ3fCyeFAeUDrNGe?=
 =?us-ascii?Q?rbVPg9xPbwUnltHnnA+Ug5ZN1GK8jiJJ0TwLI1tJQWhXhDqWID7pCjCdZLbf?=
 =?us-ascii?Q?mroNGwy8gt+1J1RoFOqrodSTgRl7iqEmd+ZWfva5VjveRa3RjWKXAMxep7Hd?=
 =?us-ascii?Q?nhBwYxjuvFi26kZWYiDLgYPY5YtCEgcG66tSN6S0dJIf8iOldZxCntxN1ZQ2?=
 =?us-ascii?Q?pdYzkT3NLPBfDTbgDja6q+GRhgpp/w8Dp9301+Bn3OsXTSPvcqOYp6Jz4UXO?=
 =?us-ascii?Q?d2dXlmy1QqLgI+M6fKrKnmIG7KrqPlQ4ggB1kC1FyWA9kVvI192AKzeSrYnX?=
 =?us-ascii?Q?d6F4j2gKc9BA4e1OrgzvSM71SkMxB830H8bqBLD4pkGzCyqHWXn4rC14L+Dt?=
 =?us-ascii?Q?EgyNXQwoo4MxGY+Wd9h+Xmv9JrdDf88zGlR98O8FS8kG90LAOAjq0WI0FhEF?=
 =?us-ascii?Q?ZTlQgb2R5h03veLYWHlTS6R27rPixx8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ecb407-e5fb-41d6-227f-08da23c05ccb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:12.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jn4HFKnwGzhowx8MkJCkkX5pLFfHFdCyvSpkEEoHl/3kbCbEG39zyF0IoyM1OjS3h2dMaSzs2bQKXS+klB3MNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
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

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

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

