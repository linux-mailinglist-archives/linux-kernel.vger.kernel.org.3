Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAC4CD8AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiCDQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiCDQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:12:35 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613351C8DAE;
        Fri,  4 Mar 2022 08:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNS4N6A5/aHHKc9+t4pIcaqMdTC1RALebffs77kGwMPUMB09vlkPOq2lQu68gU7eNAqFPAfbfa2f7QmK0YdyPn3q0Khn0cPdiEvAi+yyFEyFWPH7h/1DUIgP9k1PB8vP3pPy0kM5wVURSjx0ZiXOPau9k/Y5YKyIr7zBKbYeHu/uK2KPtdMFRdxTvnbQYnewKD7J/jVuwKYpJclV7DB7rL0LWXsKzUukf2O8QrqGiUI/h5jKykUVDfwMQXO9E0FweiWGYz4neu+1DZ6B+Ohp8ql9/b9vq9gbJIF+gjb5g4wITa/LIdmdLfGsZQPIKSxfkkd2bjG8l6RcUa7JWIJovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvI7z4KR2veL7qgxqkrIQA7ZsqlzpVHMiwmsB7yl9tw=;
 b=GIhnGXN3+17NHTzFolCVE+aPpv7sv/3D21ZtNMKAdMz7wpStV3H+aj92OXgXCVEJ7+oKsxBOYM5RFwsZtRakz29Evu9mMANyTBjcnvq/LOOc93MJw97xS9YX/pIsQbVCptdE/r6JWjtEqjgB2Ltne7d5hxpjzqu7A/XIivPIu+ys6WpbNutRte7ZXI7Uzk4fhOXWqTkncz207V5Y6/wZy91kR7npvGXee0QC6Sp7R7lKCm/XkjDcGgO8GOOTPy0YEHmOXNrdh2r6F5vKz+ICkNtb5ZNUfUJCdyK5ZS03HJHDk5Y6qxbnrpmZI363bwhc7Yp/2VmagR9tczzJz97+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvI7z4KR2veL7qgxqkrIQA7ZsqlzpVHMiwmsB7yl9tw=;
 b=p1El/qlFBEG6L6/UxummLMfH0HROY1/LcgXjF0EqDA+IoaRQeTp1mLwq/ti1CK0G7zirGdgmdwErB7dKie0CL6tqmVR96zaMM+UNEdobqgkpQwrGPnGVABFOD/XJby1RiBvxEfF2N3rVRYq+8Qg5Xoryhhf7EnbJvh7+UXJL/6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB5481.eurprd08.prod.outlook.com (2603:10a6:10:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 16:11:45 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.028; Fri, 4 Mar 2022
 16:11:45 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 1/3] dt-bindings: arm: rockchip: add radxa rock3 model a
Date:   Fri,  4 Mar 2022 17:11:28 +0100
Message-Id: <20220304161130.34977-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304161130.34977-1-michael.riesch@wolfvision.net>
References: <20220304161130.34977-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd0a208e-efd7-410a-ccb9-08d9fdf9ad82
X-MS-TrafficTypeDiagnostic: DB8PR08MB5481:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB5481E3F66BF5FFBE0BE68160F2059@DB8PR08MB5481.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqlRwef6hXr7RhcW7iOBjYCjxXYQs0m87nZtiHe4fus1PS48AnsDDwbAAh4TdxBv5EcURJzUgq7Ve5hcMUgfGq7J/FPG7towoLKpw++8b4na1vU1r9jGIUaDAD0eM6KS+iwC/D5TJHyilC7waFIZpSuqu7HnPTHOo/hmicP7vbW6OCsXqHFaaYDz8k2tD1H1NgyBzCoUAiWPF/+tfoJfYEngMpxCfG6xO+97UOkskIPy9PPHZ9n+aPCf94Iy13LD1eiBpXg/mBqeb0QzWdNqkvfhFXL/3UbLK0GHauU9AKTKvb6YIxZQHUOrv3c9fZbsW3ygKkL35V+3pkCXCWrtOlqUfEftrmQ6JGg62q8Eosqn+454T4P3PDE4Lh3bSgdExnOuK62bwcQsaRZXW9hmH6KeMmFc0hdW73Q+EEwiqTvF7oi4xLHovFdw0hU1bZR9H0wUSsD7HnQp3yrM56Aq6Y6f3A5x2dzRdu9usLaufvB7ejSZ5SO/1FWhG57hHwD5OI0KCt8rN7KYAoBaHvRWZtTkim/LbNnNROtPLr0hpOnIy0ym0DUWHKI0WSPoS2S0s7wUNcqt003n8kdhO0FFH+d0vR3FH/KN0I0OJg/nyf6Ja/xfTQZuw5xuAULi3VZVyi2ifzrO2NAUWPpJRoE6hykfNbvmf8F32r1w47TnYU5+6aFbJ3oTHnLKRxMKxZ7ONGSNRvQxo6g5lsECXgTzIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(5660300002)(4326008)(38100700002)(8676002)(66476007)(7416002)(86362001)(66556008)(44832011)(6486002)(2616005)(508600001)(4744005)(186003)(316002)(1076003)(107886003)(66946007)(6512007)(54906003)(36756003)(6666004)(52116002)(6506007)(2906002)(8936002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+4KPVCmVPdLsW0rENYCXsofjzDllJKHgKPFchkxFIz8UXv7xYrDFzzbVmwC?=
 =?us-ascii?Q?8ch//et6LIRCzzKs+l34WDs2BemhFPfGeIkU3u0gAx50E2OKJrTkYpuBdTj7?=
 =?us-ascii?Q?vzoiGXVdltPxNOF8rA12tEFoSvdUyWWTIi/15E2Xg5wO5xH30Tlq6oa5huLi?=
 =?us-ascii?Q?0llSjqukSUhcMa6wiNMDC70qe0sKcYznzXNbpqTSdq8O4TWZmvkmcwv86tfA?=
 =?us-ascii?Q?aNnBbCmm2mykmyAiWrz2w16c7bQfybCOSgbxi63F0WLr93qHnSNFBhy6xZZM?=
 =?us-ascii?Q?Vf55lxdGLd9ekNbAFXT0IfCgBJ7DUIxbm0JdvUmfsW+BVjxdjTGIbD/H+yQd?=
 =?us-ascii?Q?mjpVJhpvjhBZNd+WTsWmTTgW2AiOtVtG1l7MzVfBo6hvH8Lv7Rbu02kZ9XZC?=
 =?us-ascii?Q?cDcWoylcnJXRQ4hq2tyRHVgFZ0aAHyWcHJIR4neisnLtf2LLhAO82NZ33I3t?=
 =?us-ascii?Q?+ynXQqPwI5d3tkwrvDcOVGIUatEjhGx1qhVCNB05th4jJ0H88S4oM5p8NFhx?=
 =?us-ascii?Q?OONSAg63uWIOG1yCpMstSXa0dn/b+kwh9mlpXLFBC4D5m3W9j5hVill4raDL?=
 =?us-ascii?Q?4NToBZMrwE4Sze5+VhUu96N7CPiNiG29nxR3yCmuhPBAB5kGS9Sp1aLTnYXq?=
 =?us-ascii?Q?vf4DVgGD1a0x8O9sInbfd6Se2qOcMXdlF5qsmDk/BUF0ZPhy3uSmty6iHf73?=
 =?us-ascii?Q?5+cbSLsmX7R5KRF5YgtiQ41ilKDDyWNbE345Fq4pbciZgPSpG6q6R36j9XN9?=
 =?us-ascii?Q?Ws1EzoGrVo9I5hs4dXQw6uXUjm32ho225BOtoafZlzn5LHb1HUIJXgPsNzxt?=
 =?us-ascii?Q?2EQcKeesaGKBCROoWr7EwKN/dGABiVwTnARoa+WoYyc34QqE/Ai3xjPWbmdO?=
 =?us-ascii?Q?mdQ1iJN1YdanflFWAOact9GgnIwa3u4GFRgV/9QYr7uru6My41KTiFQlELz6?=
 =?us-ascii?Q?WWLAXItfqSPmWkNtCv3E7x6KSNy7TFKgdTDLidwzh2I0Qbyu/PILjOsZaSVz?=
 =?us-ascii?Q?X2PvQtQLzmQNePTcjJq3oOdHRT+bgC9VBBREnLVyNbG6LVbEY9Luj5w67Gpu?=
 =?us-ascii?Q?1rRozz9+Fmt39g8+n2L4Eu9Aia9SFTtZoW4qOQJar2zsI7WkAKmLi4JWDP14?=
 =?us-ascii?Q?pEgehm2dVc2/T8yKanrTk/D9mseKvvOLSkPJ978poXAReeo25pQMlKteGPrr?=
 =?us-ascii?Q?YAyZm0uelz0rwvRmRus40FqERj1XD3/xddu9Q6rCHLuYOg0MT8w4y/AgM4mY?=
 =?us-ascii?Q?9ccV5xBc5D3GfnN4IBs5eyI/tyTjwmmRXszI+qRrtUhHfH3d0HFYpZ+3RBPO?=
 =?us-ascii?Q?KMlxeaJfZJYeGey2VE1lG2xcg73D06xf1PArUYSV6ptTwxFdRTz3kaGlVw7f?=
 =?us-ascii?Q?PVeWkn/a4oAtWcQxWyPuSOZ6BzmmKapeVnk2JqX2P3StPml7ybSk0HwtYYtC?=
 =?us-ascii?Q?35pp9Db0+K3KZueRmuRtfGGPMYtdOjHs443CCA6QO1Ll/eVD8m1AMRHx6E7y?=
 =?us-ascii?Q?NzQZH983knIibnPDpSedYgJNoGZttKK5CaiKUEGwCaY6ctNz8Nk6sSieO/GM?=
 =?us-ascii?Q?eFYIzdUmwOnFhY9IwrEnbLUEHhaVbXgYLCJH4WOtIBvvfWgIsKUgA2HkDLyX?=
 =?us-ascii?Q?jc0pcEvKq+dcgCAyKX5LOHj1KMoDwt8aGAqVH1rnyrcyN5CQ4+4TxVd6ftJL?=
 =?us-ascii?Q?8r+RJMFcdJopIOLNglXUYC5TbTIh/hdQXa5poJmjBaic2I4Mm1vq5vDU3DTZ?=
 =?us-ascii?Q?fL2CJ4dvMONqHMWa40vMEPOCeFc+DZc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0a208e-efd7-410a-ccb9-08d9fdf9ad82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:11:45.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XelXqKCehbUUwp/Roe+6vI7MLUS5V0owT91FB/bvEPgGX7hVG4Di2jdDaSGZdxVP/j+9WiMnynSnQ5qzzOSxnZWIuhLpyfG1158vrvt0Avc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5481
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

