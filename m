Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E274E964A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiC1MNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiC1MNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:13:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5114665F;
        Mon, 28 Mar 2022 05:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaH5d7McdU+Yn/Ai+jiSRfjftVyt2ZF+EjSgJNMnSG8X6d4E6qswuqUzwE2jk0QdJ7MgavI+Wq6BdJ4+lGC1kKyFfv3/ZVWa0Tp8xTdz3DoORun/9MjAOGsrKjyTkCaCdKV4tVQVDfG8ttqKHJooTTQWiHI35eWofsmgphw7JLL6SFu6/+gYVwBqPcv/y8B6ZypTiwTEtvK/KE3rR/XHjByytuyft4xXVIzZ8E2nkwp8HywMXuO5EN6s74OkWbWlD848HJdkImRwRQnjECkKql5Mauq6KP6EDN4e4ZHG5FMMuEhCyBuXdDjm4ts01Pmb8A158zqfzz5AVL8MnLENQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4MTvm4JmgiDo2YA6SVD5iA1/bjimKuv2vxvwvv09t0=;
 b=OldxORZGfqjP7QrGY+x23KhhincpI23SUaBRrMT4b0ISr/x7scPyXqRkMRe0v+7fzeytd+QgJe0KtVM3d7oTH7zbyGjdJgRVIoMd4UXFH3Mf5LxkQDo5OqRYU9WJXyW/O3TPNB4BTiwP2g13GPosSTZInvaWH/+cu+KjtKPvcjFL6APa3uAoBvdnOUjZ0VQt7z7AomKGST7CF/YD/M2nH9134HPZWo0sj8P0RsrVGaBpvdk6wN0RTIftn6tA9nuAOflcyDYxR1zj/D4GthOIUgm/g8GRKTRdXapoltjn1AbK8pG3rNZcT8dWz8/rbBPemGixcUKLy0577mp17WDuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4MTvm4JmgiDo2YA6SVD5iA1/bjimKuv2vxvwvv09t0=;
 b=Q5oqnmzF1JqeZy0dBsPFnivpyljznzVghIJlfGFPFuWrr6XkiS9StzRDTfV3/Ay55Ap4tn8he6PTdaBiYrxg7ky4i8mKWTAkJyACMyJdZ6/o7z4zWO9ZVSSLyD9gPyDTvW/vYy8qJij3ckFavOAjXKku8bf3uNSL7Fmz/Y8TuI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB4170.namprd04.prod.outlook.com (2603:10b6:5:9c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 12:11:51 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:11:51 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robert.foss@linaro.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: media: video-interfaces: Add new bus-type
Date:   Mon, 28 Mar 2022 20:09:53 +0800
Message-Id: <20220328120956.1848795-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328120956.1848795-1-xji@analogixsemi.com>
References: <20220328120956.1848795-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 178f3af2-9997-4cf0-91fb-08da10b423f3
X-MS-TrafficTypeDiagnostic: DM6PR04MB4170:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB41704D299AD804588053A645C71D9@DM6PR04MB4170.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbAAFsCNPp7TBFFyjAzwoVob7Ij6B6MKVGdERtn2sYCsD7wZq2dw0vmKqGhp5OgXCOoBOjWthlAVV4gnB+8dAC9EOY+xlTfGVxSvxiPGGVwizrny6QxjPzl6Ns8uDnNbig/DTi3RiaOTHemzmYTetAJKXdhPrBRK0IqpJc57mCL3ZSd3ObmAxDSm+zVd6SaUDM0nuPFsjZDrajcR/FXoXP3C527E8zXfMJobS43NX3+1l1/xsGidn9EaAAAF8xL3ooci5CR2A2nVsD0yBbF8OlBtX/pzKbPfreM2Ylm3TPs0ZwfTZscYRqxr+pwWqS/xUsW+/FCVq7FXmT5q+EJIjsVOVNIO1HNClH3EAl5XuXr34yzeBnawkdpMfkYRJFJHVNdDpdyBO8W4pZdQj3z6MxX4jsrQv+FufOJxpKdkQIwF7E4+yfZVdclPJbS7xwNmk/eOmmo8anEOF22FoNT+bY5ByWO/n2S88nIRKCqDEc9WWOWqhPMCb+4bL4N0+9Swa4Yk9Mx+t30EG6KPtRO1M2zribX6z7CL5snLuWNFJJqJsGZ5DOdACqYgAiRQNUR+ojY0o7ZZv3jr0MotffeCjLJUlKxdE5I9Fvmc5zoKs9zHKecyQ3AuaRkVLkpCNlli5Pn5AHydV6RmL/cs6YSv/dsLch9GosrO/0x1svCGYlfWF2KmoIGnX0SBUIAXACrDnbmJj5sHPXb3i5bcHWhx1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(4744005)(2906002)(110136005)(5660300002)(38100700002)(316002)(38350700002)(66476007)(4326008)(86362001)(52116002)(55236004)(66946007)(186003)(6512007)(1076003)(26005)(66556008)(2616005)(6486002)(6506007)(36756003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mbb3aUsKOGYxKuDzHVLQWS6KWSwTfizkBVC2EmwSvM8pYL3C7oauclamcnd?=
 =?us-ascii?Q?9Lf4pENPBa2As0XDNP5nHATb2t4voKu8ObsgHmDGt8ku2tW5LSFzt6vbGwHU?=
 =?us-ascii?Q?QtmhQ6Ke5gEEGyWRvfv7ho3magkSsCxtSx7ZnJjWXg0pQikVbrHtrSuRRp8U?=
 =?us-ascii?Q?wi5iChLM3MG7Mj3eciE7nPVLZyIO1K7CVAjZ96ZKqASIfAbELXFhh0UocvmV?=
 =?us-ascii?Q?M0C/HMrqKrn+7AQMJoN3EDQ5wVy+gDgVCm3TQZBcMOEzhnMEN6mv2rgb1Uip?=
 =?us-ascii?Q?MgMX3/mKu4Djve00+At1tuXYqx6Hd1GVDCjCoftU3o3lohocUbkTYrnihojW?=
 =?us-ascii?Q?Pj2xb4xIImQNVONNqMNhvVdCl2vltOV2Vss0LiQwZZQpHFfV3+EU90dfxVAW?=
 =?us-ascii?Q?K1h8slNnY9fBejL+UWGL4rkybwAoByrldAwOw6yzTsum6qhP0pOuvT40PRYj?=
 =?us-ascii?Q?uQAPNAiO8nzsj7lVMViHP2b7aqvHxZ/6SqNFSrmnG5VhbZd67J3Ch+rXzBM5?=
 =?us-ascii?Q?LBrznTBmqZt7lPXTvj0rgGsb59gPQT5TTbUamHXw8SalC99fXW6BeCGsD3st?=
 =?us-ascii?Q?cx5Jq1+kPaLIBUppr+Kd2chlBkYTwCtkQABD7dEiY3Qtqu3rnuESVMK4x5i7?=
 =?us-ascii?Q?SwdNjIT6fhO91Byk5dMr99zsykXT0niPrEzNzzEIn/nd/0yoCaunZalbz/qN?=
 =?us-ascii?Q?+KjF5s/c0igguGO0wXp/qhV74/uVgPRsLR6QoOSpdZIo7YzOBLvgJRcZDrkb?=
 =?us-ascii?Q?LBpsf/h4QyDxiIT3QBSKdNRQTNnYaFFXaNSRL+eqCH4EKjPlHujsA8mKD5g5?=
 =?us-ascii?Q?4eM3IAdWKuehhI8IlucGOf45N+bMawNZEQUQafdxZL1Ow0SiYuszuUiyhflr?=
 =?us-ascii?Q?0DQj0sjcqYrzaY4OnJvb0Y3KB91Nqd5MY32REtQZwaSMb8cmdzvfIlJEloUL?=
 =?us-ascii?Q?jPQtcpkz0RKIoNyB6en9uNSs6ML0twlpHnmPSwKPTc4DBsLsgRpcuLNDvAwQ?=
 =?us-ascii?Q?ZwI2aqghNvNSw75WMDL/E8wuQDnNC832hNiFNMuBsWWRPizoOkpN8iVTyZha?=
 =?us-ascii?Q?ykMqSAYnRhIMliWUg5dwyyu6bG3HGF27nVMToQgKU9VGfNxIJ71yuIGUNoBD?=
 =?us-ascii?Q?sHdpWgcgbq+6m85pqLRehTu/ZczmJYay7waCiVlJVN/r3iv/cBTU/Q2f/xEO?=
 =?us-ascii?Q?8Vu6COjWPXKbu0y/WN6D+7xujnA+nlEs0tHI7c0B4blJC4XnXOYAMnLMEWXr?=
 =?us-ascii?Q?oLjz4QpZRwBSo65V1D8e3f5XJzi6SEms/dR5bDe18QgN+3CdW3BHI3dd8bp2?=
 =?us-ascii?Q?wX1oFVjptKjhA1kAQhd2lu2fJLthC3V7tLkHp9aECPLIP+wYmsNK9BwvvdgR?=
 =?us-ascii?Q?sW2xGWreh4ruxZxzpa49Dl8s+p8jxt9HF0uyF1wW2zmBhe54N1uhV+WsyypK?=
 =?us-ascii?Q?o3ns7PLfgUTF63MnCYaqKCn/hPL0U5u5HCBVVV0m+tYeAtkuJaWfdm8kX66y?=
 =?us-ascii?Q?azRRqDGfzknv6xyAvqhVUSOqaXOs15JMVtO2h0YPGdQwIE9viqmn0A169URw?=
 =?us-ascii?Q?8GrDtc994U82PM+a5ALPIGaoP7KWJX/iuce1BAXvjFK9u3qlXGKq4HxVPLSQ?=
 =?us-ascii?Q?Y7fe8OuZdR7yTUxKqUNnXTdeBUm0uNuSRl3k3am0GUBsd/9DVs2bLQ4uzQXE?=
 =?us-ascii?Q?bkvQDJOph3BjowAvw4ta2GgXQ0m6P6VjnL5WMGM41EcG3OW7VS+AoXQvLdrg?=
 =?us-ascii?Q?026UiG3+KA=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178f3af2-9997-4cf0-91fb-08da10b423f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 12:11:51.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q65S/0ieyIQU8gFoIOpQDlJASvH2UMMTOrRSMdxE3/mFhhxKifS+0+X8KAz5JyywOBXTNV8ASy9NnGYwu0Twrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4170
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No properly bus-type for DPI video bus, add bus-type 7 for it.

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

