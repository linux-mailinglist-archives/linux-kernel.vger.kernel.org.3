Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7C4931CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350456AbiASAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:01 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350435AbiASAY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:24:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mlg1J0KHSQqJ8SdrjcPc5hsJS5a9+AXLO6bmyZEaNRJcz9nDmNrjTHLzrHBNkB/jKfEjpbodWcNYOL6n9m9l8H8oZWMXRRT8w8XBR2o+OJBY+3R3NhG4d4LAaFvZSEq0hYuFTg1iwAdpwIqt49aWilfTcjnAsoj7unKNhWl53Vs6fI+gmbYGVuvEt/ezYshWP3ke0l6CQ96ErtJ8bsWnWr8ecm7wOj1Tj0ByvurxMuRl+BCxAKnBzG7pUiO+B7EMqSYMRpA82aUYkPNU0a+fIQ46Jo0n53q3ZciO43pqXUsWDBnioqWq+m314U6gusIvqVxca5LwBwau4J45MfyNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46Vm8bIeJhU1m0VRjX/9XSG/qzVTA39GNLwzLHVb1Mw=;
 b=HlbNzM4C7QwL1HRp8TWfHWVbXiXc+6r1apJpQD0XUX49ttev7X9PyKGofmN2r+Ww5KQlVUGTj+LQsUzjGrCE/Mc+X+55QeUIMdTlTiPpgcnXO64Cf4Zr7LDnzq1aw5bgGsWLVFTSwsj8TWhQp7YGG9+zWvpauSiU9DdHVRWdZi6GnGWP3ePb4V1AeyVVUGV+hokMQZIPQOc6zzSPppOZli/2GOvXYtc22DWYIuY66VxAz59e5t3lfgoaMr/Rnq3XhzzkZTRdo23BjGe60CtbOXymId8693yrwqb1kqsZwLk3snyRJ1YPpiofY5tMwwYK4B8sYHvIRtmDuhto+mge0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46Vm8bIeJhU1m0VRjX/9XSG/qzVTA39GNLwzLHVb1Mw=;
 b=Ci6yFIuDjqVlBFZnx9XjBlWhW5n1ZTZtToYIvs2HHJton8TDUc/ijPjF0t/n9yQsFbwFdZFNpX8UfpYuvdZzpc/rImCRXRQOoRfFcwSm8In7IZv746pYa0DWeYHPBGYF2i82nJESheUozP5MqVaFb7I+nMtT3O6soofB4UAkd/xIk8oww/A0Ex57kghg8M2iwTNnEM3nyIK7JqCUXiYkrUu4+FLmjUS1RZhb+MI9rRvB1JhUXpqw14BltOnfEj1n3vEqCdJpLXNwOyeABHsw2hYuy9izvWFHFBC5w5A3W2hwrSkIHbd9UXU9l1Y3E0TizF8RWDjVv3/KI02NrUIIBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:24:54 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:24:54 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
Date:   Tue, 18 Jan 2022 19:24:31 -0500
Message-Id: <20220119002438.106079-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d212ab5-b766-4b7d-5f39-08d9dae21d55
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB4373D0E0444339C8C80B0DBE96599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX/kuZmSwmLQegHaJ4vFcgJerSWN2Z8IpiYGwBibjSMX5ViKAX1n4cOeIb48v+E/Zac6wWmb73sz/4+r95DAJTUExTcC3ZjUT9QcaVMfBpR20S2edfT6zL702sYAdcS2qKLZ1QHDe5QmsdvXM9xiPFQItszZMqLzPKdASNr1/+tthhzdOXuJunqZZMMuOPbCf3uzq8W9KS2TnEQW43PNJvh3MFWTqB1ojI5AOwLa+pvCM5AX4Q32AJacd3WX87fZ3TgoxR9J3S7ZX+/26z2LmROUdhuqIIU6M1IlKXq/pFl2cCJMVzLOCc1WPKpszDfBvZcnyp+jNI6kYCpGjEwpoF939RezIVENNVolI8eNcod3xFeXUCg2KrQjwVHYex7gIbSPwoi53LzkusOBsIdoJy4u/eTck27ZYb6SWLguOMcRbOSvLrvV0GshCGazTDJXbpmXxaPuT0t0OQDUR5b+XUR/NYOBPJ4aj4K5I0t+iyWklb9vbp3DtR19btaFZnYasyQKswJNHr+VigiA1GaYBoMhu9k7VSD7IRXMMKNW9/d83XlWokeLUIH75umSsNPhriUw0R/tmoWMn1q1nLEt1IvhbVmOvryCrjwHHANgsJpHSrDS+FFEAYjwAW0/PV0Vwy/eXSidbbyWD5j/hF9BAZpbcUX2xDlbRw+qR11ZLEzRSdsN9NoGww7cy3md58llzwkYN547V7koOIt2EyNDpgPTAyfkODj+1o+3hHGuCs6D6pnRwVZJCD7EZQvZwribIkeifQ259htIJF8S7/X69HBjHuZqptFLo+4g2oi8DrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(966005)(7416002)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZBJLFTncstfL1xRcnYprMidb/Rj0uSPQ2MFvayr6KSf2PXc3wCsRGD6/lx5r?=
 =?us-ascii?Q?OURDNBL8f3RNdV2C/3s4a0NWSCui3MVxG41j7NgcaexhdoOBH7RQrR6FqNps?=
 =?us-ascii?Q?/T6YHt8/qdPLfA2Pv3S7Q8Es+JjJdfohDqy083+3/Uy38efnBpRgaFdnsvqo?=
 =?us-ascii?Q?ERjc4Aisl720xdb3eHAn931ya5jjBRF2H34A+7MakPP6dwIpJuOqXPaSfXpu?=
 =?us-ascii?Q?DXK7fk5XvdKQlN3S6YePq7aoGKziezGxIqlYnAABw1QyM9EIMNT/jQftgDc1?=
 =?us-ascii?Q?VBkLRTIvNOKYowXeySTosWHNH2nSKcWatEv2VCsXEYzZ2ceBA9ICCemlCEVv?=
 =?us-ascii?Q?LISZQBQdzBBRVq7iOYwxhZAVMaOwAnOzl1jYsqxfr3Ntg12veMe26vTD64gt?=
 =?us-ascii?Q?aZI42twknb2IVfJfFZxKTdVgnfIM8fPOf0CZodaQ+sm1DHm1HtbYLs1vUEsr?=
 =?us-ascii?Q?lA7avpKH3rOfzWg/YA1IFaA6IY+vcIn+bgaxfXu6lXf1WEurRCfmuujBISYi?=
 =?us-ascii?Q?82jDXOaDDKTmug7dE63DI7Zo3smVNNV1QF6WZaPBm/5gkQ8lvYbX8D6xZToP?=
 =?us-ascii?Q?t1QLr0WNXCvK9hfHkUENvRBcA39Z/TqMMJNUH+BPeS7J+ewYZ3bdV2mE/NIX?=
 =?us-ascii?Q?yh/BXHTvgpQ2X2QYaLURz1d4FQ+1Zo/Nhe3tzrI+VkudONMdCySMOxepcXQm?=
 =?us-ascii?Q?xjBVz69eGEU/XPe3od3U1q5rVz8PSILAeCq8JGI30swO3pMHIcxPRvnuFUyG?=
 =?us-ascii?Q?HddAxZ22ularMKvDxffZbeDW/mbQo2q8gTL6e/rVA8She+mMO60Z8Hy6ssbe?=
 =?us-ascii?Q?re6f5f/nEVqe13yxvM9CIn3m1LfiCdcK7DFtxN9NAPi+AZ0Yw+Kmf2yI2q2H?=
 =?us-ascii?Q?kSFA2PUndyTbpousZknhv4L+WAB3YNDEGcpLR1B3MZ3Q2k0AIOfZxQ5TM+/M?=
 =?us-ascii?Q?zXp84KylCXBA5SiPjAu4WLSm8LX2S6iQn8ARz3EnQH6KdPer5SjX7SaT4yIR?=
 =?us-ascii?Q?CycK5SvIw8zFWqhftYqXP9BJ/lS86Pg9wK1yD7nP7npKDWhf3v8WHp4z3WRV?=
 =?us-ascii?Q?PSi8QE80yDgGt7zwCymTlm4y/xwk4YN4P2yxHdRi4Qgl2a20Ayd5VrnlKb3C?=
 =?us-ascii?Q?AQYAX5GvNut12Hz9mFZS1FxvHRGGGGXLqWuld/WFBLN89o0ohiiA4D7s2pUP?=
 =?us-ascii?Q?LmvWNKbGgZNSHwI0IpQDeX5WmJkoXUZfnSQOI3RFbo2s0ds9inUm6Wbcf/d3?=
 =?us-ascii?Q?ew93bwqzZ/nvecQqywkcH04wAHxBdtauHgLniLn2yv1QW+IQxlm+joGJnIYq?=
 =?us-ascii?Q?C7GetxR6thOyoby342Ab2S7tY7enuRenotbincQ2Q7iKaCdiP5upNmacNfX0?=
 =?us-ascii?Q?hs47aJ/d54uDkkY/M1se84L2njAFBbGU1nTESmEYXc5hcz/9U3i3+GKxjLC0?=
 =?us-ascii?Q?LbMettnyW5UVjbmDujZ8fskQ+wHoKctjlM/av5HFtZSzDWj3oyRKgwi0P19B?=
 =?us-ascii?Q?KR5fJc8quJIXrVLdkMyGOihhGxy8KIuk+eEirFhNLVrhqVe6IQcKRwvQLoG4?=
 =?us-ascii?Q?jCVGTzXNQhpbzco9C1GFnR+tIIho8mT0P5I7aL6MTBik74R96ZA+0+TMqzpS?=
 =?us-ascii?Q?opiCKR8AfiWclDpqamsEAyk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d212ab5-b766-4b7d-5f39-08d9dae21d55
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:24:54.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2APtoGJoztPSOcuVQz1qPWHi5SR+6ktAt1EXWLj18eOoUq/KoxMUcdY/4TzEyMrHcSjQIufnTsyuAu3U9nv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is redundant because we can determine the correct value for
REFCLKPER based on the "ref" clock. Deprecate it, and encourage users to
provide a clock instead. This also restricts the minimum and maximum to the
values documented in the register reference [1].

[1] https://www.xilinx.com/html_docs/registers/ug1087/usb3_xhci___guctl.html

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index d29ffcd27472..4f2b0913ad9f 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -263,8 +263,11 @@ properties:
       Value for REFCLKPER field of GUCTL register for reference clock period in
       nanoseconds, when the hardware set default does not match the actual
       clock.
-    minimum: 1
-    maximum: 0x3ff
+
+      This binding is deprecated. Instead, provide an appropriate reference clock.
+    minimum: 8
+    maximum: 62
+    deprecated: true
 
   snps,rx-thr-num-pkt-prd:
     description:
-- 
2.25.1

