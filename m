Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6510348E8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiANK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:58:14 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:4932
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237803AbiANK6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:58:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUADj5XZ5YTl4I2F0nuT6ZpZpP4exo7MMI92pmfyPpgRjXH/RDrNUZin37ZV9oAEZLQixN3ivbiuunWJbsrEplMg4jXc+FZCNCdrqFQQIlh3zq9KWO5jBtnLrSHT3X8lbhb7flB6YCYABdR0Tqudyu52W2hzYg6EaV4X9jCjCkDLnTVlvaSgCH0xnrCya1jB9DL7BDbAJIyX3DB8lY65QQ+pzxukW64L/i8BQ+xXHXyDlHoIlLrowZHOXD0IPU2cV292UVlKovGNw6NjHXGVW8TKVycwTOARPKPsd13UL+OwBlylf+MuCZA9juXR0ze8dJNoytwQ3DIGlJOHnxV7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIu+JeCdxa3gIXiPdXmRZS+0hjA4wgMyM3ginypIAbM=;
 b=M2lDcIMrbn4oLjWhH2pN0FsFKYhBw48Eszxg247FoU1cOHLtdEDE63rmk3Wjj77HYZclScCMrVmEh7GUbUlgxae/Iqxf/p7Ke3N8o0bp693YHoE+WkRCPKv0xX7hOwQy6bc4S1P+5C2RgGKdFI/+0cCFVosRcUBF2SrYYE5bB2gIlximArQoNqC4BeO5mKLYAMPDUK/9nJRM5On/biCkcMsoEl+wdfXv2AQ6MLZQ3gGAo/iHTItrXJKBrbxF8n5WK8xbVuV4vvAcXGdgz9WEqH3DLgBvBHuvQ6PHSCpTnBcbgqq1knezvHf9bw39Zv+SnI9j7iQDjVmyRkXyiJuBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIu+JeCdxa3gIXiPdXmRZS+0hjA4wgMyM3ginypIAbM=;
 b=pz0jfjkisqedeeF8PrgiDzQQrmx7sHtoyltY4B+HzYxNJm++k9hmE+gH+Ly2UAXEOyYDAgLjRVhOdqN5aXA8ahyw4Fp3rdjF19T0DEXNtiBurOjoX14EDer2NWCY2GppZlU217rKNpmwZvzSbFdUIXF+k8iTCDRDOXa2q1vgOVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR0802MB2282.eurprd08.prod.outlook.com (2603:10a6:3:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:58:07 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 10:58:07 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 0/2] media: v4l2-mediabus: add support for dual edge sampling
Date:   Fri, 14 Jan 2022 11:57:53 +0100
Message-Id: <20220114105755.730200-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b87d65c9-7c78-49ae-d2df-08d9d74cbe9e
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2282:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2282C2D185ADB2E2B1CEDDD4F2549@HE1PR0802MB2282.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRUuagdO2trZ+T/7AF+iX1hRhM7t3DIBKWYkWgd9pjao+hypUmmUJfhT6EeUZl0K7K+Zp08WLcyLtWJ5fIed4+Tu+hPjaOqNENXKbj/npm5KVmgzU5FlVy8kgq3+uloyx5Mc9Zn4IaRvHCvFyaMWxvZKfLavupz5oQPCzA3t4bTO8qUy4Dk2VGplrTA/IzdNIEuuRmmyyrnYPntK3oBsyI3HGwvch4mh8UfTM3UYaOR/RCIOkU/5TLrUNsrsTzTlEhf6oAeTjIHV0nUl3dMmIZm2eN4ELnTFfBEslCAlarw90cSdZ9tdF2lsLnXExKqdF73R5guG4Y5wEwBJLSB+9UQv8g8f5K3zYvT1ZVorV606MKDY+x4EM0ZRXRu16CRjOhoCuKlJsWhTBDerNEeM/yNbCy7EStaeZN66cBQMzio7TUOVI6VO8ZMgaZKlcJqcXBUfHuJt2EeBLh5L8A0HxRGc56KQSDQST1UIto75x1fAOkQHiDmQYLdaGCkPgzzIPG2GgxEIjizRIxrIadtL2f7787uxnsz14wo7pl98PzmG/2gunkt9qa3pE+dfPJMDlaDfIVxi8UhE+A7uRdE51hEZJpdPl0k4I9QI0XtriZCseUshhzxvtsrcIFBpPy3SFMlKgjq3JruAZkyJCKEPHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39840400004)(366004)(346002)(316002)(66946007)(6512007)(8936002)(6486002)(8676002)(508600001)(52116002)(86362001)(5660300002)(4326008)(2906002)(107886003)(66476007)(54906003)(4744005)(36756003)(6506007)(186003)(1076003)(38100700002)(6666004)(2616005)(66556008)(44832011)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QwdQZkfPjHNcsIdJp3BxWSplv3sGvTNvP1sqaX9baPX6S/ZObuWDimGhKhdo?=
 =?us-ascii?Q?TgRCjIeRGUPMqICDtJPHEP2uJxD75LI1WLdqMrYg+xKFgAhamUgJKmLVsKww?=
 =?us-ascii?Q?IVJ/p3d0E1FgsvTp9WqIR/etptiShphJ8sApL1/HM4GbekclJDIIc8hij9iM?=
 =?us-ascii?Q?2mPhHdV5ehlqkB8/89Owqm1nizWxP8Ao/fVZJqDK4VGcHjzvd5LGSj4tdiVq?=
 =?us-ascii?Q?b3hU2O2wRbIaWtPNor2ovF4h5PgiXJL3NIzNpMDUbPs4Ve7/b0hVQ1o2K2Pm?=
 =?us-ascii?Q?5Cy9hVuDrLuyX6eqT39CKCcg0v2t6Uy7+OFJCRJc8yAzM1gVnUaFkH+Hhquf?=
 =?us-ascii?Q?G57Yc/ngH99jUPj+QpxAkYzvNxJk0WJKzn8Jj4boqb3A/0HWQ/j16pRNSgd4?=
 =?us-ascii?Q?tAVFBotEUgOjZNL8Zx2uxGnFU/jD/uOV8rD46csJs7j1+kpuoS9GERadzzBY?=
 =?us-ascii?Q?qLE6z9VGm1Q4bEdZ/oQlJW3oHnJSq8Yjy7TmOn9kqm3Gf6D6Qv3iU9oohHyS?=
 =?us-ascii?Q?UDI2QMSyBp6qJ+sXtttouD+1/f16Ol0M4fLFcsu5jEP74I9W/zD/GYqpyGmN?=
 =?us-ascii?Q?TeXMQwGhNuiXGbmUrE0UpcE1UXQ56A9lOXZW73cYYkcb9eUXb+/H8HjOZmJS?=
 =?us-ascii?Q?spylVvq+L0xQyNxS7F3hN6rGE4Z7RhJQvq1dqv5o3CUHk99YULosevmAicN2?=
 =?us-ascii?Q?ZIIXVKAPb9Gz3IgfRwVfZfu/4T6KL3lRW1RQ+oToBYBMWUB+2/BQ4rQKIugB?=
 =?us-ascii?Q?uT8T4YdoTJzwxbCoSyRNq5P6M1ylgFFJ3oUGp3GYPuiVm5x87NDXEv82V0MH?=
 =?us-ascii?Q?biUZ069I8xxVSDcjCsVmXW5GHu7a7UKpeWnVotmpnBmwgnOo5rrJhWPzmDMr?=
 =?us-ascii?Q?YnN08QVNHwNbMwL9sq2237/Rd2IQst2hbJpuNoKILavpiv97fD+Ocro+bP2x?=
 =?us-ascii?Q?wCdOgmKtxR7ILFfh99Yo92GlIGD/gj5FR7uOxanCI9C26t0ldgBvNjtMEZmn?=
 =?us-ascii?Q?GHbZg0+bGurZrsrOsKXTTaBVyFzLsfOzMg3SNbkxY+lEV50k91i2L+ox7p8K?=
 =?us-ascii?Q?WJzxF9bXOr91IANiOWqpvvTDYWNwKj9zatF/Ao9nPkNOG5wgM3KWTvcvmWXK?=
 =?us-ascii?Q?dYUX2ockC8ed3RSE9oZUcrLYTcfx8j9m5GOdKcdYiCGP1c4Tcl4UZHd1tH40?=
 =?us-ascii?Q?KVl6l2X4lTKDpRC3vzYeyfEEKtjyC1Zuwjq2AD8Q4itZZXSXnzHwEySqvnvE?=
 =?us-ascii?Q?6ocJofImI3o4jPU1kmHZDI7YfkUD0fzUPjjGXg2YBwyQS4kZHMUn37zB31Ef?=
 =?us-ascii?Q?wyRVRhkZvE00thhrpFbkQe2Pkr1mDjuZgX+1BIYXd5xjHJek1mIndMb06dyU?=
 =?us-ascii?Q?dS84t09khz2xRDH90P2yNQqChzBLguPO0h0xxUP+utSFV1YG82k4zDnfPB6O?=
 =?us-ascii?Q?M/g0bbI5KQB1AQ81PCZh7uNr3L/4E+gQTQ5X/4AiZcpGlajrEPN4XzumEPQx?=
 =?us-ascii?Q?i27BXQTarNyJR7TKB4THkFuW42dFTXUJmBR789wD7pG2VAryDpp2o59mJUwJ?=
 =?us-ascii?Q?ZJqYcD+FC+jFg7I9yOox9OvjGkz4zmYjn0bqo2Vkf3Rx1xmXyb5oNPkQ2Gfk?=
 =?us-ascii?Q?JjmdgYK0hX4JYwaxOjfb5QlPtx9WguyrPt++968+NvAyWc8i5fSfzhzHZFKS?=
 =?us-ascii?Q?prSE6cP9MWnU/2OTsRAkBmiAOp71ZhERsYWiHMThKOrR+P6oxZR5N+m4osmm?=
 =?us-ascii?Q?mWMYACngEA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b87d65c9-7c78-49ae-d2df-08d9d74cbe9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:58:06.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RrW/Fggmhlee7ODWx6fub9NBQ1Xiqj43RkMMyzKgTd6vaJmcg0k8pXHmqMLSevK7eFLmboOPdY2WwI2CRifVovmC2XEhGdONEH+bDcuf9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Some devices (such as the Rockchip Video Input Processor (VIP) or the IT6801
HDMI receiver) support sampling of the parallel data at both edges of the
interface pixel clock in order to reduce the pixel clock by two.
This series adds support for this feature by using the pclk-sample device
tree property.

Looking forward to your comments!

Best regards,
Michael

Michael Riesch (2):
  dt-bindings: media: video-interfaces: add support for dual edge
    sampling
  media: v4l2-mediabus: add support for dual edge sampling

 .../bindings/media/video-interfaces.yaml      |  5 ++--
 drivers/media/v4l2-core/v4l2-fwnode.c         | 23 +++++++++++++++----
 include/media/v4l2-mediabus.h                 | 17 +++++++-------
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.30.2

