Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1FC50BABA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448971AbiDVOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448920AbiDVOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:01 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576EF5BE73;
        Fri, 22 Apr 2022 07:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk6JXiBjiik3rLF7F6WlCR2n2+QsMaiTEHwJHGDd8J8NJf+paw8l8L5Qe5FSETzVS17M9OdoSbfLT4uH4V+GCe2XuhD4XhKMUy2Ql24AeoYMLZ/FmU6wSBysi3H8YaTYwSiAV48lsUCWsZ8EJR5UTtl/+W3ye4OKgTqpeO5ivQA3TkWN3vUhyscGeDrK/OWlhFrL95rbCAAuv5/XZNdSqeiyBR0iMA9W6lbQr4P9LjLBDH/DJBNS6b45COCKmnCxFY4mvjFN/xZyRDP7at1tuBFLdLb6WYzvB2KnlETV7/j2WTc3LKAPgpFrGd0T82GsrxBYBMernhKiA8JhIG62mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK1kfQIMX5OnOhthEIkqw3AB4wIJzlyKh97MrKqUG0Y=;
 b=NAfcnZmaw1sGriQGvtWIzCkAYKC1YlELhmQGoJYjkqvVKI742nFLQgvMIVqWZSfPGknGG0aUIoBtkn1SyTVKBCfH/3kbh0CRp4ouwr6HEqI4PG0qsK2lf5pS7kkfZD0QgOenEAj/oWtW0ff5rkGbrG+Pc99bWYMprQ+K0p5U2oEomwwPTDINlr541azJny08iqS0UI0qOUUho6dnr05yO2krLtFYzE4XAcQKxAvrZ+368YLwhfl/qvfK4zDJa5BMjfGnxlSlOJtQy1+7a13/L+O7dYupPFsezu0/OBR6YgSvoH26AhuusR3eLhHCeMi7/2EEL84GrEZWwaFiL47zXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK1kfQIMX5OnOhthEIkqw3AB4wIJzlyKh97MrKqUG0Y=;
 b=RxYGbQ7Dfva69OBl4YboG5Q+ie395d5r5a3pCKXWH/Cm97iQcku+PBQESZb38GG5IO6AownE/35p9RGgLAuyNLQWFatsu37N6/AY+eDUEBla99z9dwt0HlrU9d/83m7Tj0S+eiz+NHTEJl+XlW23+DEUDqMmwGMdBMQKKMsXCiZPGU9oOc3Ft0Div4UVSRChGcdBY/lnjXg0woNMB3Qfffco0Lu2czEnoI1jYZb8SA8mDBWZOlUnOh04tAauNpyu+OlJYjabgD87mo4oBYj83tc0NrkkE3yg+UeOflBf7BSxTNZGYSWS3jq4k8XSuLI0q4lmaGnEWNR3HXKBTOL2Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:05 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:05 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 4/9] dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
Date:   Fri, 22 Apr 2022 10:51:42 -0400
Message-Id: <20220422145147.2210587-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ca06f5-93e2-45e2-b72f-08da246faaa4
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2792CB429F7D1AC454D25E3396F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MX39e/PTMy9IUxlDtma5k9XYnmxRxYhmIRQ8PgC0P10LnLS6Q84sPBcQmQwzGk1Tl7JdPTEBTRCmEeR9Rb3fx5UI07FzrhEfRTdrrRXyWV4Vs9rGultdGUvIyf8V7jE/yRTHfSyFuAuk4vICRwB5GidqYIru+9kBg5oB9MdlBxZ+b9WaI7AZciDFfQ17yuvELTkPKz228NyyqDQKIlr67ZzAFpFn3odoDwtZtFfvobjCG0yOZzjhxkFMwPy4+Ck4QBASfboB5e3/FyB3yOWeLIc1ykA6GnSl/A+IpD8bw+vC3PbRJ3EguinOpENP5g60fGywEEWr3HAY8Dj4vSt2KxSlv9QFA7IX9Ke8IMgtABI+9mj5YCS/WkMudUok+zcHYrfqum6+8eiMiDWSw6Xa1YjQ4tdu+yItNdP3XpoYrULEH2dNND5IJKu06H2rkxc91VF+gyKQNeMCj2TmZOZOXtNDLhS4Tbe93qFEs4tFrm4/gVvyf6levvD41gmQ6wbo5sEyieMwUvdpekV+wnbgV5G80xOFt+i6wTLTcBitQ2Y/58k9ZkGeQqlamg1IE9yXYsjy3LTpec1XTVK+13PFKvC4o2WHy9293pdxChDmsDuGyNFbIdZO6SxQe+jxY8Ixhf8aCSYlNuaD9VjHaOyWOD0zMUVq7LMduoWXbKU/39Way89Pa0i82LnA1DSAjpk4NxZgP9OUHBWqdcQ6CR+KQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(54906003)(44832011)(7416002)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDjV9ZNXAclB/kuwM4g7yqOxxmHWMgEQj4aJ3/Ah0jODp45U6tJToIGjJIm2?=
 =?us-ascii?Q?6G3/onb5k4oDpIW/wspTZXYJ0JzC94UmnnZW5l5qdWRbDGGIDNqx5qG4epSH?=
 =?us-ascii?Q?Oigw3H+/dhNlDZ2hBO9hF+Wsq6Veq0sY9Q8HFbnD8+Ufcg5tS6Jw+El3WHL8?=
 =?us-ascii?Q?pv9oHrYYCw4cQUUJHQAdHaXgs3PjlJ0xhYEKOw3j9tJKt585dm0ceJlb0U5K?=
 =?us-ascii?Q?/bHdezrU6Z/7NmGvWuTWCjkn6f7LKJ0ldGOTOu9P8W1M6u5POFe29nPlLPc3?=
 =?us-ascii?Q?EU73+VnsR2xzfpLWUEcT4TBgBzV4Uch5ua/7n8AGXyazAYu5qtGnjSaS6GZc?=
 =?us-ascii?Q?DF7mqxPVLBUJcwaLYngdWScopFDlLmwD8nPoFZXeCyPhD7vu5+dlga6XAkA0?=
 =?us-ascii?Q?aFtwfgHA48RC85fQ9oF63wG7pfKpDSJ3k85BrgpdLcMHWFaivoUMWGQI8LOY?=
 =?us-ascii?Q?UqMm4kGSZaF2ReWuWFE/tudI+SPFWTUcnBvDrSz0zRYZURdwbFx8Xr2fdwud?=
 =?us-ascii?Q?IsZP48YTgPVeaSFr7thmmI29ipUudcmpapf5puqwLl06F3wNPSSd7/Ilwtad?=
 =?us-ascii?Q?SnTH5JxTWlybK5U4/mQi3FewM9hv7ocXN8fFu2VtIdmBUxySiz7vvmUr7x5J?=
 =?us-ascii?Q?Dm7MglfrUicmlJGb7PsRpKb18ks/8iMMJtaAGiS9jPF61KEI+ACGBa5r5k/o?=
 =?us-ascii?Q?Vl9EkA5HA+jmSNrwPIXf5S/kXBOlyMiGdsPzWCUusw7eZFoSFedPM8uxgyBg?=
 =?us-ascii?Q?gMQF1QT7fnUuGizZlyYlHeWb4m+rEqGcj5AYqPefAR7k6dZ+rwlsF4c45bSu?=
 =?us-ascii?Q?5ggRgnJAg2vM6n8GqWI8KygsEQmuET1woVUb3GD4Ae0g8ATCOACQPcLSqGND?=
 =?us-ascii?Q?bvFBUHTSIvDCHHLYIe9k4tzEjkFN5WoXPXb4vKZiDejYOmx85wV/F8yt+FD1?=
 =?us-ascii?Q?HAihSIfZ73uvQsNrO1VvtiSHFBS0CM6xWeh/MBNZdl7yuqWJNFyOnydATZv8?=
 =?us-ascii?Q?sPdBAnkkATMN0dnF0ljtxSqZ93qKe7oHlSxm64XXyBlv5w9los6QLRUIehPv?=
 =?us-ascii?Q?slggA9pTtcjOe1PwFUxcsw8BlRoJD3HKcN8Bd+naKtVBU5ys9Y16bRdDwNIb?=
 =?us-ascii?Q?LE6tCXjTHVrGAQncTnbEmxtaRwV5hnOkChYmWxgUtqO17j73nQzzQWpImOZi?=
 =?us-ascii?Q?F/O7b2nZE5QfWHuJiHUkf2/Zc3Ge5MpEH8+kk6cMjUTw+r1zvdMRLz2rpHMW?=
 =?us-ascii?Q?LljUpaHHxBI2JzufpHCEyTjCSWaXZSWzSXdWen9oubAl7dUjXtbaJ0dh21iJ?=
 =?us-ascii?Q?dK11O+5ByVOnbaz2PZo0XzxcS07CZT3Tbmhi7y7E39GIp0N4NxXi7q5tLiVa?=
 =?us-ascii?Q?kYyseBIr94QUVd/a8q4DpBUWanlt69LW7Txkkjq6bGugVk5KgrnLPBhyEWco?=
 =?us-ascii?Q?dwZ8PJKfVmkMIgtc49UrAJ9Ab5EE3b5qKURBekk7khz3QQ7p/six4PHQllho?=
 =?us-ascii?Q?ILtx9Pr3ukVm8cHw6gCxojDgjzibXo3BJMnWAAhMyYWqt89MdXy0empGrwsk?=
 =?us-ascii?Q?0c29dyY7BXfhVSPk/wBzxaOdlSaZdBz/tdk+N/uc+aEEPLUExAemFG9MApUR?=
 =?us-ascii?Q?54i5nM0IsxAEu4YJRtkGV+9Vb4fNoDsQ+IesWpY5GnvW7iTvNvA89pvbjCYm?=
 =?us-ascii?Q?d51Mfm5EUIkSlctoygwKIH7kWqNn8pQV6LLt1Td7nLQxMdFJ6Yr37AJu/0do?=
 =?us-ascii?Q?A+r/BMwbJ6ts3tjvFQdmm9XFpQ7qst8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ca06f5-93e2-45e2-b72f-08da246faaa4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:05.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCZbWYknVacdXV34iTHN9U7DU9UL+7zQCwpHgh+YTtdJpJW3TAETqeyhDkOi6KQMIu+Y/VIYwobLDsIGYYxv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trust Architecture (TA) 2.1 devices include the LS1012A, LS1021A,
LS1043A, and LS1046A. The SFP device on TA 2.1 devices is very similar
to the SFP on TA 3.0 devices. The primary difference is a few fields in
the control register. Add a compatible string.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index c5d7375b840a..3b4e6e94cb81 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -18,8 +18,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1028a-sfp
+    oneOf:
+      - description: Trust architecture 2.1 SFP
+        items:
+          - const: fsl,ls1021a-sfp
+      - description: Trust architecture 3.0 SFP
+        items:
+          - const: fsl,ls1028a-sfp
 
   reg:
     maxItems: 1
-- 
2.35.1.1320.gc452695387.dirty

