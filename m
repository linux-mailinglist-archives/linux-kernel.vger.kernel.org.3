Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217BC48F315
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiANXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:29 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:20289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230107AbiANXjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH5YaUEe5N91pFeCvP++5rmPY18ecb+CF0IfrFbOI1kMdcLcVWaXo+rx6KE52y/8feNXmIcDmN7OiRf5wl9Fn9Czb0vA06rzSqJsSxrpDSJeKlUEPhdHtvmRuduC9VfKqNuS6OnWesSfemHEvOgjJMexMLAev6Ohn1rLF1wZMkQyOLOdWhKmKYYoqIVhlXE602DG3jqlCRZLAo/j6GlqmhxLydDRY0L3UFINUQkV1aQ4l1Scjg86nHHDC8u52vRYhkELdSy72GJi0i53J/bKLizQeXVI6akcgcA0WoKblzTC12ZFLYy/tWMH6r0SAJ/7akXvUtOEQHQamtIsUr5lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzFKtk7WmwIQu1CerwD5a//H/DCnq5TlPY9N+JzgPn0=;
 b=nPdO1cSqMCYBJV7BaoeVptSushOrAK6Xh35t80uyMh5cUhSrcYhbVdgIUUW0MdPtQ/hAygoW03Z+Vma6kX+qUJDlRJZhTHrnRidjFClWs8LgyKaLXtrlVhhLg3p9aLfajIjismxbFYUXJhPrGQ2y4LSQ9ocA4A3EIuuol+FI8ScGtGkDTjLkwPCibFZQRANOBG6bUusCQ32wkVQeus5p/EUy+IvnUgiyQomQeV8RLfHUl9Hcr4Iq5jJN3B/FmqNWADLQr9ERNrhqXZxoHPB6EN3Y9BmJfeC6+Lj5T2CVhYrS4E2vG/q1QVT60Yw7w9S9VFy8oYpoYSVLg2VyYgvuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzFKtk7WmwIQu1CerwD5a//H/DCnq5TlPY9N+JzgPn0=;
 b=YGQI1KsJNpJYBErcHZH3FqWh9+a6v4pYY2vtjLKT3ivbrildSUuhYdqxhHRtqSBSY6179cpckjYyni/Aeolgw2SfqYqu2u6YTm9rQUH36o3SdvUnnEZ08OgIEnIG7emVqSBzI9hOOhOrJUrO2kKmAu1yN5Ib1XsWLnyBPjrZa1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:20 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:20 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
Date:   Fri, 14 Jan 2022 18:38:59 -0500
Message-Id: <20220114233904.907918-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114233904.907918-1-sean.anderson@seco.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a601351-1a85-4208-2b8f-08d9d7b715df
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB433671CA3D7D851102C81FBC96549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imJvWpqPjHrjqamXLkGlJUQnbzKEft1Djzt1vroqje5RBYhUovMXLqIc7w3h3gvptCXQZ8AwrJGOWm617qsXTaO17T0kz4bn+Jx3CPl9+HqEnWykFFjNLCoG9SJ0jKDXu/SCopOCDK4RhAL4MVmfXovoI5M2Tg5eWiV2r+NjEWVW4aupQKxIEBKqNJRGxSYb7xpAiXWAmxx7y26c2d6qZTrPzbFPl6R+yr4c6wm5XODOydph7pyWbsD0pVBmIRGerxBtSt4KHmBa0gwemmt6PDOSDrU9QfXxXHwcslMnj4H/9Eva+EAryNYBnktzIRDB7j1Z3gdLLnhfMykdaU8ia6QuuZ7+jfx2/xqRQ0eU46y590nHX1dnl8f/5Yf+EBB2ulH0a7CdkgpCNZnTYj2JVIIItLvHtmpNLzs/jOBtX/aI+BYVe8HLfft7VJ2UK2+pU+2IAcH/3LxUk9UaanS2I/sfWN1MrC58prWPAgXfzCJyv98cqhhuJYUVy5DL9RyhhF+ch14OM4H3+nilYS6KF1VgKaSM75djlxrTtPSkMc4c5LnxuHX5+f7oQKq8hSvNt9q131Sxoi2beyhvQMA6OYIxyAuqQYMZtUq/quuKkSfgdGxnfvCPDT1gB/7viyPvxDHoUgh7DqQHSWdaFXU7/CqvTX2nAs/s/W13kdtjEmiUyENt2852u/ccj7HN5kazycjmH5vPayrsP5+Zcv0OLAsVcuqC1XUTRcr+U3G0NmpHJURrbaZ5mEkj+GLvO3ik7FTWioH+uqvLPVPfqCLT7EvzimXLSzKz2qsfryOaxyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(66946007)(6506007)(86362001)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(966005)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OK1943Tn6mrUxafuh/t6cWC0vA7ywEAXLSmdOLs61q7LXpRMOIv/GHh7gh6q?=
 =?us-ascii?Q?RJ3Wd7z2DKG4yf2QVGEaCNK3pGAMGljouNvGdKAUmTFb0VeIkQ2zl/cU9Ir5?=
 =?us-ascii?Q?B6HsHh+4oRmBF5aW0mJfSkheHV9OPYwqWbTFY3VRzxGLXGhxubJUh9lskEZ2?=
 =?us-ascii?Q?hbC+bYDlB/97mK0oxFB9DaFRzMJ0Rj0jur1UF58oFWFbNim3wXDoZ4qydxXN?=
 =?us-ascii?Q?xVwrZY01kzf5DAeUZKjlKm4/CXDiXKN85cZUWKVJTtQdoKaZr3d1DQKLsF8j?=
 =?us-ascii?Q?t0O77fmHIi0rI4RO0Zwmf3FGpuTJJnVx/vZVgRsQM6Xbi4nLwA7w5TQHQ61J?=
 =?us-ascii?Q?aZa9aV8xK29V/Wk/8BYJ84MS73Th4tvOHoFULSVhonmrLhdmjgdFB76zKKkv?=
 =?us-ascii?Q?Dty6ZMs+IqkpZbhURpVqgV0WexTRgWQR/6SefsQzp1JLoy5ieyG2tuDr61l+?=
 =?us-ascii?Q?Bd3SD02HXNkVN8uERmwU+AWrICpFC8WWnfMWKs1b2K7S4LVCdWZcrw3vzS5p?=
 =?us-ascii?Q?Rg+ZkslWjYJAsm2J7o2hmNrFt23oNPfHYq0oMxKPLy8jnC2X5yTkn1NECG+8?=
 =?us-ascii?Q?34QDbGKxIZN4JwPzGrNBFp6+cuZz65DSKFkb5RJ+n+x2B87rXb2TnamM2hws?=
 =?us-ascii?Q?KvXEekn+pgxhj7sk3vdJ5gq4Gc3ajf79CEceXKtK/AY+Ac8vSjnK1g/FQEwF?=
 =?us-ascii?Q?4CyVmFIY7xtnT5WLojzL2TTU/cPo/DK/hfYpYqQHLm6PN5QbRHyPUms9olfh?=
 =?us-ascii?Q?VPhNS4iVZEYjibiZYI9uQBnAKrIaYvy4HPhbzxqcxb6VgiEZW8VgFE2DGjPQ?=
 =?us-ascii?Q?MTTxbD79N7kS38CIbdGR9iAIntLkySbyloUfaSdAT8Tlxwug0g75gTh3LJkZ?=
 =?us-ascii?Q?JQptom6C953qCypdqiDPTNk7yvtNNpe2aibMqK3V7CNLLFrf1I8cDoGRgNLF?=
 =?us-ascii?Q?y46A/vMEBcoYqDpHTNoXK91zf85704R1VSISpV9mhJCTwK4h02s7uaeLnDi+?=
 =?us-ascii?Q?+CqWXoK29VremmlffH3/vZ5LUCnIPw+sZLmnz/YYjWN5aFbigaRx7pfUpkNY?=
 =?us-ascii?Q?RPn3+8P2fWRaHwd4yxbCjqP/5ausHpetwIb5Fo0lFVNTMWsisOwXylJ3KYEO?=
 =?us-ascii?Q?uooqNaNt+5jOmAyac14XEj9vgmAmpZXT4CryVzP1OSC8NQXYKJmu5wdE7bhL?=
 =?us-ascii?Q?gX58hrpJOPsnrW1x1OdpiAqQnEByF+ZaxvQHhYhv+LWIe5sNFgKm1GqXC9zy?=
 =?us-ascii?Q?LVjc4OIBGuNO1LQshy4vD8NIDOgV9arUIQJj3R+WVr5Ncfdds7vUAeKtGS6b?=
 =?us-ascii?Q?sFvu1LGewcrfF5W+3CKb/FQYGqbv50n32Leh0Qt4hHCMMXKMm0VnaCA84Fty?=
 =?us-ascii?Q?PzwyDwp+W9HsdCMPlnQ+UpI3hbaK+ubfN+AUPGt8UPvA3YYbbVAC9DhQrcUk?=
 =?us-ascii?Q?lZCKUn/yS65VQeLTATFurqPK1XW8IR1jFb5lZAbEpUzIAWYgdo4MVub7x99E?=
 =?us-ascii?Q?8w5L8TqbWOPhGHoxTpNzPejETp+79L6pA38qTCmGaeU3vfXEd/J00fQzNK/Y?=
 =?us-ascii?Q?MNy0v/jjUhjdDNdq+L3GkXNxKsAABwhbHO6e6/RWwQMRVo0/wKx8b1nxpcCo?=
 =?us-ascii?Q?i0ZzRgBO9hVaoME3lb2eif0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a601351-1a85-4208-2b8f-08d9d7b715df
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:20.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HCcYmVaclbs+PDZayj1q6JX5cqcc7aYEDAN89qF5OGGQn79Ty38TTaHUv9V70FLnC4vuZdi7HjdrT0+ke3/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
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

