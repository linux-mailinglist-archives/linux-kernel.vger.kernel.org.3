Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CEC50B337
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445631AbiDVIvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445622AbiDVIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:51:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2139.outbound.protection.outlook.com [40.107.92.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C1532FC;
        Fri, 22 Apr 2022 01:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blPxCcs90SPV+9PQ/2+DQCrVMZdmudwUGo2WskZhN361oaKAqURKc3FgBxGmxPkPi8NF+7c88RsqLKcaR8jWw6mDGZS86mV0r3um3sAZZwrElKALs1qK+3ZYsME1Ghh88HZoSl5GXP91fAQTjl9/bFo/nu0nKHzn7DI584Bwks/vOb3WQMyVmL93gHRe4whA1842wroAjoX+LlhgOHE135tXCNhGyW4pPfeZ2xCaFOp/H9ggZyEjZaix/j8T3S6+0KJb08LZhzhPx0D2pVCxYALN+CMR6ObRfbOIXHOnVH8zOhtneAK5jxjYcWCEJSvzs83yk4K+WvD57vVASHEBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDUmGqoPQJPeaUBTy3VMMIGrX6bXimoNGoRclxSiTcU=;
 b=ZychKLkXN84CrXKVCYakz46lCM4jHmNznAZFXBOCT+0X+4Y9BxGQU/IIHYy73rwKLz2pPGXx0abxJgbMZU0+CSq2MEDQgXKTa2gGrWoEcYZ2xpRrxKDIe3nlNHS4rvLmU+g6MISl5H6oXhi/r1FumZWKJdFLfQTqNpCuNmwq22Rh841LxSr48Y3NZdbTSXBeuZmh51klKRa8xzUI7l/UqNAdXOAMEVeDu4zPGLZSRSPHPExh0cysaioYdhS5SttPJgVpXGi7bsqbhC5Z0xDFVrh2jfYFMCOSkOlikU+wLXi47jkAbhQx2AmYbywF+yaVxSQ8jFa1YUBpZtMR+6S/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDUmGqoPQJPeaUBTy3VMMIGrX6bXimoNGoRclxSiTcU=;
 b=uiDZWgoMCzYuZyQOojZBr8/NGQ9F6vBIion6pY382vsrpQ1z3UIr0x6h4bsKNueQnETPxdYdxn/FvenRAA+HmEm+Agg86rpNnHvk5mCvznQKVEJKUY+EG/3zqY90ElemJY8RYQvzOdyVWz87Te1/gEBuSxcPLQz17GCuPIEM6Gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4598.namprd04.prod.outlook.com (2603:10b6:a03:55::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 08:48:37 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::e9ba:4c90:6e9c:39f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::e9ba:4c90:6e9c:39f%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 08:48:37 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robert.foss@linaro.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: media: video-interfaces: Add new bus-type
Date:   Fri, 22 Apr 2022 16:47:16 +0800
Message-Id: <20220422084720.959271-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422084720.959271-1-xji@analogixsemi.com>
References: <20220422084720.959271-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fedd639-ca2e-4890-c0a6-08da243ce47a
X-MS-TrafficTypeDiagnostic: BYAPR04MB4598:EE_
X-Microsoft-Antispam-PRVS: <BYAPR04MB459808C3A028ABD38739FAE8C7F79@BYAPR04MB4598.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeF21xPvSz5QStzMIZ9Lna/RssCEwwPwtg//cYBu2RJbNTu3A9piqN+pYIlHJLlWe1wgXDcHtc3f8kJCjxLdGOYkRfpvBXCxPI98lBU4YT7Xyii3rsEeFPdgXnkmN7A7CUAE7aL8HMVQ4j4zv1VKfmFdN+0lJNZT7K5jE6sru4/MXi75fDNvpRsrKC5TI9GEHS+W6410BAcegDvGarglRjU88KZaHgoX9mrivsbCrPVvvdNKx8IlZCG0eoEktUmh4bppaAfHIZQOE4B3npN0YDFvr6+B4qt61CD7Jk4i0flXin2QHEPq1X052L7d1g0wGu2TQLJlzzsJZvsev/wh3TKNdedv0zZcvHMV0K7yqdB5WVaFUE3lq2u37yTqbzKb2QCpwWu/B/CFyldNzP/kcYPImv1en4kEykbJF4JJsPmdkPWMoDvAlHC+46JaX/HrH03MBY9k6CTikDVqTgFE9SOhtu3rX6buqbfDhKP9RU1CWYYLU0lY256cNU5lOsIW/XuJj0be9s8SG32rbATa6QRiHRFdoouyaKMOoglj9ay1TeG3KH7uVPIwrrPR3hYiawqd+bOZjckNaGu3IKRZadhag0tV1tIfm5WCgJEbG7qiSKML3P9Kn8et926aD/xv703dRtQ2zWehuuQ2kWCO7dzIlgZr6zLveJe80b3myOk6uZC1lf0R5sxYalHIAEIcGqCeHWzfpl8lXXc7990bq6jwpoGkzhad9JT5GM3Rx2IZu5/VyK1k9hWEXUXLAO5h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(4744005)(110136005)(7416002)(5660300002)(38350700002)(38100700002)(6506007)(55236004)(508600001)(86362001)(52116002)(54906003)(6486002)(6512007)(6666004)(36756003)(66556008)(66946007)(66476007)(1076003)(26005)(186003)(4326008)(8676002)(2616005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSjBIoBf3kLZ9zt39/rhAthPpxmFilpfbvwxZoTnqBbUsLQRVJVoEIAdpHL9?=
 =?us-ascii?Q?2vQpHsWol9FYbPNWdKBVk5VWxTsV7bLHcuNflsq++zcw9TpppLfsuc0B3AX0?=
 =?us-ascii?Q?o56sgjr4SNhDFbWkBsqCs33kuFGsFh7+rd1iO6t1DyKFw7M6NsM2FAGJmwld?=
 =?us-ascii?Q?buf4GyQLd0SZU8YLeY5x30GHg6TGXcuNA1lRswLzMxUkFkg3ymwLEfBmtcWj?=
 =?us-ascii?Q?f3JowNA8enAjB35xfQpsrfvprAbBPr/4+RIGjL9nP6FN6kB4WzfDpV1oKp0n?=
 =?us-ascii?Q?Il6B+BxLtKqUL+JN4UUmXJIA2Swca2A8oqcaNpOnQGEo3K+293sCpymDBdnF?=
 =?us-ascii?Q?ABOMPAZ8AwPbUilfEJw25SyDUz1gEejhpgbRhGW2QCnHtZmAxjOsreumEc3E?=
 =?us-ascii?Q?6dppDIlmj1NDHVLMhm5oEqNSzqbfUO2/2k6rb81HJPRPcIidzvseSPftZtGk?=
 =?us-ascii?Q?rhiFM/iDY3CIaKkfOJTMlSRgrByh4MLJMjKGfMsfn9t0tevuTn5fU2qTNGSt?=
 =?us-ascii?Q?LSzm1I8fAW0/vXBWHcGYwrVaZt+wjKAPtRDbVMuMvu7vKuDuzr5Llmp+UrYp?=
 =?us-ascii?Q?So/3aqcCm4p7kf37LYBcOX9hxDNQBhMEcLh9iO552Ahc41Kvov9eQyiephAY?=
 =?us-ascii?Q?EfT4M7DWn7O4LvTsWK5tWTfcugQLcMSvixXW2ftFQ5CCQG5MU3KjQndmjm9t?=
 =?us-ascii?Q?QvxG+4Zgu0P9f/CfmyW1POZ8qTFdcLLx5by2m1hbbCKQFHDXro0rnQyL/C9R?=
 =?us-ascii?Q?2QW9psaFWxLPjHYI6dq9D/8FWXUZk4ss7OG5ed7xRtbznx1T8/ldRsRpsrt/?=
 =?us-ascii?Q?UKBZkDBrbj2uMu+sfiIPSm7Is6nGjHE2zzQim4S44G14+1wF2/FzpT642cT/?=
 =?us-ascii?Q?K6/2ZXihUsRHlSKY4CrHoHWNqVbWAE91hqJw0f35iAoeRDlbRqbZ/Q3Mr7yD?=
 =?us-ascii?Q?Uv22wmWGQ/zfs3yq93/7fc4BD9gbXbtFmyxqSVgls3y/qmohD4EZkqvO8t8a?=
 =?us-ascii?Q?/ZVtmKfMvtI0PkhYPp2AyLp4Gp/umwvr38CISHsz0Dvb4jh2rTttPD48b5mJ?=
 =?us-ascii?Q?RRIeaOEm3i/zSutIkkFSY+H1j8XxFKApWfLCmnQWKdRJiyLmI8qX/y3DETcZ?=
 =?us-ascii?Q?I+wFjLS3C3NZTrrZyeeU9SM7ELidxMJ0YrP+YU8T373TX+1PrgC3f746/dlf?=
 =?us-ascii?Q?ZhpZDVvsr/nEEJAPfiac8vP/o9M3iQJVTrKC5hI8/9JlJJLr23MaV7E1aWln?=
 =?us-ascii?Q?oEYvrXQ6q4kzUO4+2vlE9zVwyc4tD9yn752MoDjGzALI9u3e/2bUNZ7GLMUi?=
 =?us-ascii?Q?GBcEK0ESL+FFJlSfPeCD1Dr97+dF8bUZR7qkmNe5OhBxAC/wJKZMOBs+38Zw?=
 =?us-ascii?Q?/5JyDTfysjOAQFQY46drk1dfRQ2E7JY3yfe3WrXwL4T+7JaQPSaQ8c1gV2Hy?=
 =?us-ascii?Q?oeVESC7divZeAbmEdBUdeK7K09U1TfpZhXArk6s7FC0CPlOpJfB46pc18as2?=
 =?us-ascii?Q?Jo2DbSTWpN36Vl9hKs8wE9kdCRpHuIOD3IypQ91rFjMKIKGRwNIGBssX864j?=
 =?us-ascii?Q?3Gxp/kyoRRzR9SZLmxyh4GQzXBMSqdLmKZE06KYkUd56iwc3YZtpGCBcVp6T?=
 =?us-ascii?Q?ssAkEo2h47T6puvW5Jq3siat2E3iUCDBMWmCbCC0L1U8Zv93y58L0eghP4yi?=
 =?us-ascii?Q?yGXjxpOhD5c0SnJqHfOSLogP+wHyOehaLFMxzOS2vO6U3W66/xSoZcX/ULal?=
 =?us-ascii?Q?yXGN3wBJGA=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fedd639-ca2e-4890-c0a6-08da243ce47a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 08:48:37.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UjVWNeqnXNQjCfatE6G7xIbS2ISfVTWGDbs7DLDi13/u+iYMEVKcafaxAPOVcKsCQsRCjPU5IhU2qVn644MHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4598
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No properly bus-type for DPI video bus, add bus-type 7 for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 Documentation/devicetree/bindings/media/video-interfaces.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index 4391dce2caee..68c3b9871cf3 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -93,6 +93,7 @@ properties:
       - 4 # MIPI CSI-2 D-PHY
       - 5 # Parallel
       - 6 # BT.656
+      - 7 # DPI
     description:
       Data bus type.
 
-- 
2.25.1

