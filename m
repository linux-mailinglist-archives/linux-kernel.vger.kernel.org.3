Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D748EF09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiANRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:09:58 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64900
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243689AbiANRJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:09:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3Lhq7vCcN+ZQucXZRYGB1vBOeitD/es/SiermN3LlcskcCY1fZhqMzHmrdJivvykfFEjUFGVW/FSDDKTZkoeEcEKS5nWiIBafpDUWmX5fYiFyRXIs3GEDm69vEGpAhrfcKJ2Q+KsB+LahAi+mv5Ylq07GaksXdUGxeF0NUFzI3zhpslPOFpr1+pP4UgNboErheGIkvces4i5l+bxur+8W7r8+GJ9EhSw5TQGzE+PAM1e/m/CbHaoaZoQSPZJkIxc/IkTALZwdxzHdwltD83mMe2VZT88agIwPlf0igeTE9keTOhWey0lQj5VICjrKEPpb49v+WJrUI6jfjuXbmRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfVWj9qcIF0ey1QKaMha9e4/KvbTT7TqO+v8yIYBY7s=;
 b=hTCJB0KOwhoj8w6RPjmfDXaB4fpW0mNFQa1U/ihQRQvd+EN+PHHYl/r5uMwHsWQJzZeDj34AlxZMNql3J4Rc7gqvK8PF3tmTmIMA9wDAZDDJAQfAiEwVaM3mlpMoay0uVgbQq9iKbh0DlrxwKgOqnVrqn8GWURKurPvF+yili1uT4rH5JI1VU2Pb0dL99sqGgHYzONhWDt+B8mEHgUJ1/4DOrOEmWU6ps1vCLNl6tyTlNDEKWUJrk63b+QEp0UMLljulnPJU8PWVsq7V1vnrnFh4TTfwaTp5ZjU7zFjmYY3UHXRXstd0e5FGZCkFE4PyiNfOTIp9yUqxkQZVGqdPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfVWj9qcIF0ey1QKaMha9e4/KvbTT7TqO+v8yIYBY7s=;
 b=Lsp6cZHDzhR1stFp14FfYxv+16Jr4mjzr7Y/gkWKZgkJPXgKTWkfSD9pJLzWiS8g0xySmFbGV3pwtiv/rvYhoDTF0pyCEWPAu3S3Jh2+W5VCQ4TPGM1/ZxrdDtEhw2pObKuoMUEvUcaHCa0cjIyNPnjHdbXkGJjg9XhfaX4Hu5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 17:09:54 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8%5]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 17:09:54 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
Date:   Fri, 14 Jan 2022 12:09:38 -0500
Message-Id: <20220114170941.800068-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114170941.800068-1-sean.anderson@seco.com>
References: <20220114170941.800068-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0072.prod.exchangelabs.com
 (2603:10b6:208:25::49) To AM0PR03MB4514.eurprd03.prod.outlook.com
 (2603:10a6:208:d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801358af-54ba-4b16-dc23-08d9d780af0d
X-MS-TrafficTypeDiagnostic: AM9PR03MB7742:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB77422733DBCDA77FFBB73F6096549@AM9PR03MB7742.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLgN43/Rig+MChkf+zef6xGPnw6oEz3Vw+F6/ikvbWTD0G8zUz6FGrmmc4S49H3FAPDHUODioV1j2DYc8PI9Vl7PTj2IuMgK4tEb1Th+kEL4wcImFspmOWjOdA1lyw46g6XSRJdQ3/SmMnCWTNQjNh9+qOzuBec8wen0WWPLfV8XYtTPL4QCSjB63aJVbCKi2JP/v/B0uB7Xmpep/LZOC7t4nXDNirNQLYu8HwxXHVZNi7n04Pj3+lcSVWH7AyRbSYnO1L7LnAkBAmvDv9b4zbgUWpcBGTGyVZFoGeqKYOx2EjJjaBOwSAy/2YfhD45c8SRlBmqWW0T3bBXKDZeI7oIzJA9BeJrxhCs6pHVPcj0HBXe4OdET5upquVFnTKgJ2hdDNP5joDQChso8fy7m9uRZkSQHZKartknaZJby2H/S+HzRKSpPkzPmFoFSwEbMpqPiWaNo74+sy9ZPCV00ecKI3DA7VEcxnD0ClDy93QQm1AE40lp6uJcJNLxyV6Iz2oMn2rAzMSdVQVShAqu8hzfO8jlQHN6bmPYluqXfEg8jvds42mobvo+GBUaRIDZBZ9f670GkP0BTN6BhRnaiTMPfQbJqcN+FZYET1sP15P0wC9J7gbfFmwTC0FKy7hsH3KM8C9R4nGsAz22xahre4FBCndYZX5jc26ZNbSeIFjwvE3NobBvUM2vPUYiCen6rSSuK67f2VzuJ1ap3xOUfk1+oNTO1edKhTZdLLMKyDLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(316002)(186003)(2906002)(508600001)(26005)(5660300002)(1076003)(2616005)(38100700002)(38350700002)(6512007)(6486002)(4326008)(36756003)(83380400001)(66556008)(66476007)(8936002)(66946007)(6506007)(52116002)(6666004)(54906003)(8676002)(44832011)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JeDXevWF0ex79D1NbGvG+1EnhffrRlmSqhyMprQumixX5LLDQGDG3Qliiljf?=
 =?us-ascii?Q?zoPD+d58FOByxa5/l2CfwoohEnhyJNU4DFYsUsJM7LHE/KAft30JbHBYB211?=
 =?us-ascii?Q?I5/hjJqk4cV4YiCYp1OWHhfooxhDUQ6HkIZHIc336KgoTpEMwKi52LY+RKFj?=
 =?us-ascii?Q?iGY+qu1D9Cm9Ri44L0Nk8uKqnMj8ykPbgTYPoIWIDX1+e3AZlKtO3/UjTz+v?=
 =?us-ascii?Q?vUmq9DuJpVe/09LsoGAT6HbqY3coyfNWnfesV/rIIAoeDbAJGefN5SC+znuI?=
 =?us-ascii?Q?AseAZmH96m321nSdpcdH6YI2FuNM5BCouHoNOe+FLXQYXiJOJLci8Qpwbqp4?=
 =?us-ascii?Q?3SkX1feI4BWPlCAjxUrsCYolHQYyrTUtLyJBuMgYIxnkGWHx99OLeU49TlH6?=
 =?us-ascii?Q?0ukGHk/Ef08M4h2ZBXuMVxU2ns7wH3UR3kNtAED41AJ79XpQ6gvCr6D1Btng?=
 =?us-ascii?Q?KyBbMGH0/BvWEQEVEs6+AHjcGshHPTaDM4N+jurix6+8zfqnRCCLsVgS2nyw?=
 =?us-ascii?Q?BzepebVtihgsX4oNhGhu15fRRRoq8Kaf3wRjUK0t1gT9P90OUnaQZMVjt1tq?=
 =?us-ascii?Q?f5XYusjZ3k/tV8NNUNLLVcMi4JRAP0TD+JWDIFJ2Eh6OAT4F6SxBlhDwu5Ld?=
 =?us-ascii?Q?I7mMc0QllY8VTCOIaRgHwOxBsllRKa+WiqEPPUetlxvd2ZByC6Iedd5tTFXw?=
 =?us-ascii?Q?blQuD/ayGe69wp4pIIDqFmGEvOa7hwajN+0hwobZb+ixCbK/JfR5AnBAf0La?=
 =?us-ascii?Q?xl7vNNCiGGDvyvL+Dg/ZcmgKnRAyaVwj+X1beC3zMle5dn6/jCmggimH0X9o?=
 =?us-ascii?Q?4Gh4GHVNMwhiVW8NFd0R8uzsKoj1BXH8wfXX7nqccXsjIVLQs3S6HyJ2YLe3?=
 =?us-ascii?Q?04o6lZS4z240opJ1BeqD2Aucr6vGPm/yXQPjnr4TwlJwYQUraLIuVkoRWFp9?=
 =?us-ascii?Q?Ok+keNST1x9XI5OeUFCvbgAjBxbto6N0ipMB3MXFLlcXyp/mP6kHDu7jENo2?=
 =?us-ascii?Q?t2GxBVZ+2tLf4FfcgCzfBQNYT8tsGSb9PEA+QR/aLm0OsJHochcxw5mUZFRx?=
 =?us-ascii?Q?Lfg7CYIW6ox6lPTKywhohgoEIW/dlA0a57Ly9x5tLRcz+mobpPkzmwclu2p3?=
 =?us-ascii?Q?CCyuPDURGcsxS3dXpZx4xGElATBtp9jUscH9H/675fulG9WMhbQI3S4KMWV7?=
 =?us-ascii?Q?jO69IVUCpmMBC3hWTE7dSOybSzL1u9GgsFtgoc7vy/cXhVWX0+8G8gy5osdA?=
 =?us-ascii?Q?SGyZWmlea4Ov8hS6naHVLIOo0sQ/CBKaEYnMGtxeqhp7+4wro2NVatq3/507?=
 =?us-ascii?Q?VO2Jt2MpnT6j14jcuIfHwwGEv4WxscvPS/mwkVBMLxouZtZK1LRwkYdWPfor?=
 =?us-ascii?Q?C+vj/EseQXLzfIzX3s0a5XgsQIPTdF1U13wAMYKuQzKCjZuNxBO3gZgpdD2F?=
 =?us-ascii?Q?dbQhs09ej/6R6Nw/t/pekUDVrDv3EZBWe/OZdqt0LOehLiSkb2nKC7FNhQQU?=
 =?us-ascii?Q?xPtQrwOpFHYte5aGo2QT4MroqS8c962jX+WacIS7woJ3TanH6wITm4OGJs26?=
 =?us-ascii?Q?uvA4VPC+tjPDTs+oS5MRpTvDJcC2iOHcxXNLD894kCOU74Yi2IRwwFOn1y8L?=
 =?us-ascii?Q?adBNI2cBz+2fWe7qnBSw9ZQ=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801358af-54ba-4b16-dc23-08d9d780af0d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 17:09:54.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToeotTfkklNvojH0jcRoTFsFHAqSMOSA+Fn8Bs6WCHmJjolQw3L9vw3aMXQCfxAtkWT16ETO2h937VaoraFsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vbus-regulator property was never actually read from the device tree.
Introduce a new property vbus-supply to represent the regulator powering
the VBUS when acting as an A-Device. This supply will be enabled and
disabled as necessary. Note that this is different from vbus-regulator,
which represented the available current available to draw from VBUS in
B-Device mode. Because no one was using vbus-regulator, remove it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 2824c17285ee..a79459bb5a4c 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -34,9 +34,9 @@ properties:
     description: Should specify the GPIO detecting a VBus insertion
     maxItems: 1
 
-  vbus-regulator:
-    description: Should specifiy the regulator supplying current drawn from
-      the VBus line.
+  vbus-supply:
+  description: regulator supplying VBUS. It will be enabled and disabled
+               dynamically in OTG mode.
     $ref: /schemas/types.yaml#/definitions/phandle
 
 required:
@@ -57,7 +57,7 @@ examples:
         vcc-supply = <&hsusb1_vcc_regulator>;
         reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
         vbus-detect-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-        vbus-regulator = <&vbus_regulator>;
+        vbus-supply = <&vbus_regulator>;
         #phy-cells = <0>;
     };
 
-- 
2.25.1

