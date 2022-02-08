Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306FE4AD3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbiBHIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352055AbiBHIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:43:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2101.outbound.protection.outlook.com [40.107.236.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFDDC03F91E;
        Tue,  8 Feb 2022 00:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj3SNWj/rjTVOD/WU+0WOBnWOCBXJYLbEUeC95boIeXoLpvIMHZCMQtWoim7+sf46hW5bb8Hzh78tNY5vG0W51i9M8TA7bDa+ew25CwOdkpLdlcZOz8DhMdM19NryGJ/crN2dEtniu4rs/qaGzqVCVpGDBzjjuDgjhD30yL1cN3UQMIwZypFuiiN1ShnqI2JE/8Rq1Bx+w8i1Dy51HkPgFSnAJDlmW5LZmuhoYfl5yClbwDhWwPC+RsdB6UPfXfbvvvcOzp2stoYQLFJF8l901aF4M/dhJSTHmFx8iB8XgZ3QO2+SvBJGXlqV/ea6p46xUbCBZzYg0Ho7TJ7GjXGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=TMeXWG1+AjZcQmtB/3ymawsaZsWUS2KtvdooY5xhigwwkXKJr1tbgScGjCarIRkx83EQKAgOEJr8c/3CFxsvCJZSIfNB/J1n8h7xb9Qocvj6cBFWVEyltrjc+ZnHBZx6kjzq4TrHO4J3Kd3B5YwtOsuaMhG4+Vg8yUcCG83gbF/b/lcR/GkA6AiqcyeX29xXBJHFUTNxyIU691EGBFv/nnoXVQS1ZKsiVzfeLLeeNTtM+JouhK58RECIDgU7dFcUdTUhlYOfV7u3eQ3Sf80DHYhmfvhLtnflprZTcf3LZnH2+3G15YR3jMlBqaki6TndJKOWTM06KLJVM3YfzXmXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=YhVvyPpENFs6/326aLgTFBaYCuZF1fdWueAGHTXRYcqGJpmGwoTzdKc8VUS4Wj+KGT2MEVi/bAcmSXwiUK2TwclAlXzacfF/lEj2yBOWzfM0qjEXMGXvwTiVMSKsSnvAhiwWYBJCOO0uPGwtXTlFVo9ZdmG2yzgIP/C+wNAUODU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN4PR04MB8333.namprd04.prod.outlook.com (2603:10b6:806:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 08:43:22 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8545:a99f:9aba:4cd4]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8545:a99f:9aba:4cd4%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 08:43:22 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue,  8 Feb 2022 16:42:38 +0800
Message-Id: <20220208084240.3678980-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84e9855-5fd4-4eb6-b604-08d9eadf0ff2
X-MS-TrafficTypeDiagnostic: SN4PR04MB8333:EE_
X-Microsoft-Antispam-PRVS: <SN4PR04MB833306B25A1ADFA3C81F87F2C72D9@SN4PR04MB8333.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FTBnYVmH5dTlXw2KeQBgD1Api5OY5pvRuW95fNf98VVwVZUSzO2WRk8+7LEfVRt3YU/K5r+EEBX3WU5Ldn115ay0ct3w+iGiYcJWEZs2mPupFlXtkZ5e1b6YLMno14/mmD5bu8C5yk0DmL++2ppJ4givcQh6GTxzy5mgkycF2t+qF2CQo+ewQ2t/b2whev5mwkLrDRq0SC+Nsn+d1E0h2LOyo8I0P25QcJFOBx2syq4r36j6uub+4ZyhonB6+APY5Ev79+GW46QVZgK9KArbLO0dgfMu6I6+PnYMsEp/SITO/K7p1JkRHk9l/GnR0bRBCP5GSGUzfr0TLxiP6kv5nZYJfXkWxWQWnHzRWq3lVdXyCDFeBq4nACh3QbwHfdAjyzkhYYGtj8BC/WWsLfBF85S30LBDHA3pDYRwh1M4H2dz4I1piK/C/T7jKrrWKlenkLR99EfmZwR46JqeLGfVfYZcyGiAHtDNeYvc5g99ZlomHBVvrfZ9EdPamvAuyLD2MSLFY5VlOZP2zHh9ISZ2kfFLlf2nkpxqi78hTfQtu/3r9tM9YqoTyDYMSgbK++3Wp2UJL6jZAuXmtHAowkZUB097olcHI3iYeLXLmU1ELPjdBKF0bb14UCMndX+OBapE+d+4wIhkhoU42xWxMTOIfTOMDZ4W9PvtEu9miIEwXLvJRdyZi4RIQjNHNdUMyp/gGN6qCTKOgDO1dNxAExYZ6Y+jH4vaMKk5/7aH5NQCZQnsqTxZ3BFWzlBIgK5NhLwGA5Jp9OI6sShSwCK6HJ4P+bF8BkyizqoRSnUbinQ6i8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(376002)(136003)(346002)(366004)(396003)(1076003)(38350700002)(4326008)(66946007)(2616005)(26005)(8676002)(66476007)(66556008)(8936002)(7049001)(86362001)(36756003)(38100700002)(2906002)(110136005)(55236004)(6486002)(6666004)(508600001)(6506007)(52116002)(6512007)(316002)(5660300002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?022Pmw6kiinubAbkDaNyGJIr4rYo7b7R/HLEuJNmxR3wa15ZHBW/Oaeky7J3?=
 =?us-ascii?Q?Wdp+F/Nochw65Zb+74zOLhhks1ObYQrADBuHpk3bVzqe3mMbgWvHTd4c4H6M?=
 =?us-ascii?Q?Fou4V6dz06nAwRxvTfC7k+FQDinj7PKxsZHg6DJziwDZ5Hduqf8aJ09ai1MX?=
 =?us-ascii?Q?s68RW9xvKAehpxbjWM7yZuzPeBvrUq6wI9whyr/ipvurhKCJuMdL0i6zQff9?=
 =?us-ascii?Q?rmEJI2OUnovxHkX87E1Nvt2THolJMObaUIX6NIU35rq1faI4SYB2DZTmr6az?=
 =?us-ascii?Q?QYdyVG1E77PK3CxNIPUELe2tR1LmZql3XQl/IqO9plMLmFys7zWMvH7NUr6F?=
 =?us-ascii?Q?QGmGBFvDtjlv1UXdmpmyAGVuwF2EReX/5dfyIbZ7yzBMAv9UB2EkppwOXm5d?=
 =?us-ascii?Q?KYTc93ubk6NOA3xNAIvaswScPBKQu+RKoX+7Y/s1Tvz0uS302lXe/yOk7mDw?=
 =?us-ascii?Q?2O5GQxbvZYVkHEG+1Y5iXj3L3DnF+fGwD87swcWAmQwznPierecKaHtKNG/2?=
 =?us-ascii?Q?HFiTbGHFPheMKDYHSvyVzYrZc7Zy0/2nVTURr7M9dqYE8L5fmxj8t9mNzzY9?=
 =?us-ascii?Q?2kuaHsN4ee6vFIaleEsNTv8iW4udSncmPxSvinb7a2JtZRDDElTM8BJGYngl?=
 =?us-ascii?Q?xa+vuIS2fKm9eK380GuDuh9HjAsbg8Fl6ezZjd0E9Bh4HfrRDlL0TJRVdxlT?=
 =?us-ascii?Q?B70W6mFSdLDAq8Jv+/gd1c/mMvaBfyUwNnGNLrt11XQgvzK8gxyHzC9Gra2x?=
 =?us-ascii?Q?lvngJyz7vqBPrpaSxEQRl6NR7/W1GdkEfXB9hPEKK+08lXte4SLXC0fhJ3nn?=
 =?us-ascii?Q?dKAsnls7b4PsMfV6lzURRDl2UCvnwk4EkisOOX3BroqIaAqF0In+fFBaa7I+?=
 =?us-ascii?Q?V6Z7AgLvt7qUYbsLfT4nczR1kUyquyqL1pvFygGrn8bHKmE0NUT6QJLVeXoI?=
 =?us-ascii?Q?PxOoPzz67lAwKdruxcC00vhh4DeQY0pwG+0kI/5GfFoFmK9ZhVJulKahcSEE?=
 =?us-ascii?Q?KXHso5Af1zL3DSI4ZrhhYg5FHyRZW7mOLYp70mlMBv1Xk5iPx8KMPNVraEs+?=
 =?us-ascii?Q?Jzwa7BxmWY4LmYoKb+QnGBTN39pkwgyXnagsFql0HunPfy7r6mxtK4fsm2gr?=
 =?us-ascii?Q?a5CkA4cr4Faug+Qzg/qAN+ku2fuGmyaRQe0/G90vv66VFrQXOrdVJu/C0i/H?=
 =?us-ascii?Q?o0GaNs7M4OKwtGhqCPuw2NMZPL5WDpYwBbLQcgDwtzy/f2HNVPKFj225JvT1?=
 =?us-ascii?Q?NF44Mu2c6E9cjYRZ25cM87VwrKY9SLt0TGRJ10r2M7edgs+LdPdsdEoJJ2bQ?=
 =?us-ascii?Q?Y2e1u2TPMGirs1RTrz6NE4DaihrRWhy1l//m6bNfHB53KIOMW3C8nqRmogNl?=
 =?us-ascii?Q?5AvN1Aqzkhq6MDuIsRkMLnn9ai2TRgJYeaBNLrOpcWhW04spYkWS47cx93wV?=
 =?us-ascii?Q?uC1vSykJkMdKH3GQJ6PsF1yTgRQnPgVT6MMd9hWriawSo2pp6eehZJ92EnN1?=
 =?us-ascii?Q?Hw77UUubC2c2l5qjPXVtfXvrsJqTtSTJI63GJOAc5nuv2iji2cXK86PmMpjs?=
 =?us-ascii?Q?gbLkmuzw0yYuapn8uTJ5dMIKFhTMt/OMWhOk2Lvs7hsYyjs69qIZWFNL4a2d?=
 =?us-ascii?Q?5DPetOOnfPf8adAiBBMArts=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84e9855-5fd4-4eb6-b604-08d9eadf0ff2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:43:22.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+ZfGOmnuol6ubqfEsPLt+Kkdja53uE/Dy97fIKDTGsEwiC/lnqXPuwBAHkLZ14BHPtg1AXtbStYvsi6LgZvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8333
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analogix PD chip anx7411 device binding

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..c5c6d5a9dc17
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/analogix,anx7411.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analogix ANX7411 Type-C controller bindings
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+properties:
+  compatible:
+    enum:
+      - analogix,anx7411
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+
+    allOf:
+      - $ref: ../connector/usb-connector.yaml
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+      power-role: true
+
+      data-role: true
+
+      try-power-role: true
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec: anx7411@2C {
+            compatible = "analogix,anx7411";
+            reg = <0x2C>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                power-role = "dual";
+                data-role = "dual";
+                try-power-role = "source";
+
+                port {
+                    typec_con_ep: endpoint {
+                        remote-endpoint = <&usbotg_hs_ep>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

