Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580F64D5362
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiCJVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiCJVFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:05:10 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA12DCE1B;
        Thu, 10 Mar 2022 13:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rci6h86lhYzHXHA8DV1aoSq49FxqxILy2Ypi+cFkC9SMwCZHHfy8/lIPca1zzDhQBXGllpFTp5Mp1JIzlYHmN9lwVA9f61L/qMBOcA6UmFha4NtnS5dM53gStq4lLCD80lwtsvWrjmooZGn6U7mnnMdY+tOQoc1zUODPwB5uLF/fq4SMusgy3yksrexryihcOhuxZydeEWMJawB0JmwItcORiNyyc7DMfmOxTVZB+7jBOKDlIsJP3EaMh7qSLNirVlVkQB2XoroZwwwTw8MqFypN43kbziNaShcrtkR9oPAA4j1PAJy0h//2vnA0TU3VG9nZnfI+I+lmURQQuaO8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoFSco4UbFRy3r5zzBqspPoQlQvb6BJwWLiI6xnv8Tg=;
 b=fJB62rP4azB7bzsmgfZ1TE4UApp4ApCY8kJr8ZGwaVw5DiEKSM8xeVzZTR23h17OrcbHUncgyNAHqhrLAkK4dVf/njkaUhjcWmfN2MBg79iwVcS/xIuGU8srhvJGfIYj6idFOdx1Z8cgIKysrWbPi6fw9FeFPQ4LJzMeuVDnaA0U4Gfh3XaZm/oZuV8VJV9DxaiqQRY/NbRtSrti3TU8J/sMo5XpmeRBPHgkb/pZwzhFpsLSYYS8mdjEQ0cNfpk9sLWjUalsT2o/uMxdv2FxrtZrfMYuLJb7GLWK1ejPB7czPByfti+2+gmyAq6g1VvaFYgVSlGDAda54qnGwnhGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoFSco4UbFRy3r5zzBqspPoQlQvb6BJwWLiI6xnv8Tg=;
 b=rKCj6Zn32MIxaS73VNPeSIe2xsG0qsv/zv1Brsw38madTpYL2MQLcEmNtsHJN2kQIISiYkTZGyeIrPQNTQUoX572x43m8Q2s2ujUVw922gixMoOU6f0mfuwdTncJ52LBlqZOaU9LiTgH81PDcAr3BsWQoQXXz7MzSQ895KlHHZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB5078.eurprd08.prod.outlook.com (2603:10a6:20b:e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 21:04:07 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5038.030; Thu, 10 Mar 2022
 21:04:07 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: add radxa rock3 model a
Date:   Thu, 10 Mar 2022 22:03:50 +0100
Message-Id: <20220310210352.451136-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310210352.451136-1-michael.riesch@wolfvision.net>
References: <20220310210352.451136-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d38729-df7f-4abc-4d84-08da02d983bd
X-MS-TrafficTypeDiagnostic: AM6PR08MB5078:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB5078B40F1BED78005DFFD56CF20B9@AM6PR08MB5078.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4kwKIPhvaQpdhk4OSj8DxO6DhlFGWfk5UIcKe0ICrzF0nsU9PYkUWRi1GZZZPBOAujdwN2KXlTm9IhVgfRJKsumXgF/sAWCr1baZF/6KS2qILh6yQFlDBf9xhgmLxsEGk0MilUbtQHtRj5MN7H6RMunPCUVRqzfzrkFShc/I0DSOoVpyZbqXBAhPzOGoi1J6XrAvDBjJ/X7qxVQDHq1dwjGjbxXQcr0sszOrS2rQJ0W9oQ3TmPgoqeUIDjyeYBNr0spS2lTfCZ/T9IrqLx1kBJq+U3lP4M8IXTp2e8mQ79o8N7QrTyDAMasjhk/i5Gxb0JfcjEm+NzJZ85Fwpx4Wl0jLGvjenMChrC60xRMS7Mopa+YN1tyR7+sioO98Dnpta2DqU324o8trnAhvIqcdvdFPWTSFJXpndoxTHLAxP2TcWTa8C6ukLdqwfncVwvuBuX3rQ2mp7MMe+6gzAPLeZs5JsmJgAFsxZq3u+hxbeUTNImORGTHmJoDMK+ueKPyBarxKBnO2NmT8e3Le+wl7Nc26vBSqsV/9lLjIVSDiSxs6fMwxBYLaBhInZMTRzgKcq8vct+GLIy8Tr2k3MH8ze0vtLvwblpYJxN9OAgb4Sia8rtssCQxZ+PIsMjTGhjTLqYnfJFfmEIt49ejnBAwfXj45qDjm3cSFcDhbk+KaqG4D5l139dJsT04lzCnSE8+FN5ar2zl5dRr+QtxbyNM2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4744005)(54906003)(186003)(44832011)(52116002)(86362001)(6486002)(66556008)(66476007)(4326008)(7416002)(5660300002)(6666004)(8936002)(66946007)(316002)(36756003)(6506007)(6512007)(38100700002)(8676002)(2906002)(2616005)(1076003)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+iyoJjNMLOWiV7ySxk88s4Ba8XlkbRBCAqiE3Jeweq3QFhDwQl1kYuG/JX0?=
 =?us-ascii?Q?xKu0JIFhQIZgZxAi4Paohi6Yob5DSct/G1qLEXKiLUEPgIyc/dsCMIGPLq7K?=
 =?us-ascii?Q?R/2SwIIfsPg9QUHVLn7p7FiuKWOt77++oH5yjbGccLCR4Hy1LnX3qfODGg4F?=
 =?us-ascii?Q?b5hkbbKTzExnEDN3OplIxnzTcin2YFqxs9tdfiO9kP6pl4ndZrZmEiw7lI9S?=
 =?us-ascii?Q?9flPBeCA5OIAxpN13ZK4ztLlPyuW1pWrOgEuYSdqvhvbmTQGlDzrYg3BI4pM?=
 =?us-ascii?Q?WlJclv0eQmNUNA5kw1NQ0eVbn0CiplMe0M0yaH25tw/HF+7Jl2HsbLC2XwvQ?=
 =?us-ascii?Q?P170Qao7EOjK8QQuCkSHtwAobg0x8Z4OZg5OFIPbqPAyLBYbLYs6nmd+JVRe?=
 =?us-ascii?Q?G1F+t1fBD9YeuBM0Dh+QENKwQw+09eC6miWswd7OW6+zKs1jZlkcHZPem33d?=
 =?us-ascii?Q?fFThi0K20mao7sBGGSx9KmUMhB6MivG5wnNIP9dgEJmAeUm8pCTr7/OHCbX4?=
 =?us-ascii?Q?/p56PzoQixj8CspIWFa6qh7U+ECZpvbtx/xV7k+dcP8MMn+PJSbXzqDmRZB8?=
 =?us-ascii?Q?kRkobB/duQG95pDXf0GT2TdAocN5bc8ku+FEBw/ZmPwIzEWtwWEYzOAtx9n4?=
 =?us-ascii?Q?pTB4dkXyIOAo6l8HUGIh7i91rrL7aJ/rzMgZ0z8rp8/rGV5NxiGJMMSwzA7X?=
 =?us-ascii?Q?ZAPiNCteWnY5h/N+YsvhwePgAr0HUueI1Hd6BYJgnM3dabOjpjcsbQKi+ArT?=
 =?us-ascii?Q?MbXNJMHtAzRqTvuKII7xS1dwyY/0SB3VUfrVpVSfzFb7GQ9E8/oK6vHzvfuX?=
 =?us-ascii?Q?MQ7U8iylKtuWpRZWwje3acxrVAYcAamNNaZGKk2vLNuGsCBnEYrK74rrkM/3?=
 =?us-ascii?Q?YEDKCxvwtMh+cRpg0Ghj0vmidvjSim+oXkredXxYzshPZBxfVG7dpUJPzxMo?=
 =?us-ascii?Q?P/HpTLWstQ9u+GtKwa/42+QXGHi8TvxRwM6zal1U8ofsT126GDO2MVaw1K4y?=
 =?us-ascii?Q?x0TqDTemhQ8TKVO2CtJYcrpRDi0YtfbOtXIarG/SQQjsvMS++B1pL3vkwl82?=
 =?us-ascii?Q?z30bwqutlDETJQXTabbLbXvbVTEXV8k8fgrxuWO3xJ2y8HEwe5hYUAxp3Jt/?=
 =?us-ascii?Q?as57CHJos7I+gUlqY/YOa+FTGdbrEPxTiInKIiwdgbX9qXL1pC6sWLb6k/3V?=
 =?us-ascii?Q?rsPB5JJNBvZeT8M5eNqAHTC6TW2HRDIfM/hGkrB1Vob//qJKX/X7U7WVJet9?=
 =?us-ascii?Q?PRPKF4wUPvYHf56gqGboezFc6Mu7iJbEd8tbWosVqEVMQeth1SLmgXpTmZTh?=
 =?us-ascii?Q?BAASgly2ksvEoYv+qwYAZzKZ26otduiiITivbtTt8yl2iDkkC/c8+q3zOKez?=
 =?us-ascii?Q?Ec6cgk4BBYWqn1eO87XPewbVWinZAeuRKcCRYKlSpV/FhBe5aCB1kw2wv/Mi?=
 =?us-ascii?Q?HGnrpJnrtunAKCuKFVaTJ1ent6wMiLAF3QePYVWlSEifc76NJV6AWpT6JAdk?=
 =?us-ascii?Q?VKsowtgCe0VNbl1PNPqTwHKSqYvkg3prdE/byLcFRF6mCnPJuPB2biS60x7P?=
 =?us-ascii?Q?YwWKujc2Xbm5kGmpvKE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d38729-df7f-4abc-4d84-08da02d983bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:04:06.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK+ZZKgiYDxBVsmQP1gbMPIwEnOQdlkKp8n5lgFngaA4BMvwD0GYXTZh6i3gfs1nM09Yy1UvfVW7Dk5xkfchu6Jq2SBkaPMDNECM+vDwJ9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for the Radxa ROCK3 Model A board (with the Rockchip
RK3568 SoC).

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4aed16176434..94b1107ba5f2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -537,6 +537,11 @@ properties:
           - const: radxa,rock2-square
           - const: rockchip,rk3288
 
+      - description: Radxa ROCK3 Model A
+        items:
+          - const: radxa,rock3a
+          - const: rockchip,rk3568
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.30.2

