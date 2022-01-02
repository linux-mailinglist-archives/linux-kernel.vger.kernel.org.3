Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E5482D07
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiABWiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:38:24 -0500
Received: from mail-eopbgr130131.outbound.protection.outlook.com ([40.107.13.131]:53476
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbiABWiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:38:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtinfcD09AxtBDMbX2E8upuvbXT155GiTE0Y+nxNusC84h62SzjAfpDJoMVZCKsnOoYW3tLwlv9PATvRNokXGBZwoFCzwt1kKSirg12lZi5qRy1L0A9Uc2KeQT7e2MMlbIGfvpVrQ1T8D9qbAEOBasIAUqcyX1EVDNlFOxXK6RP+HbcheLHOkJJV1K0gIypV00hBQILwxXhND7qH/v9K5q/wZEfWjF+lwCROJa+v0hWNDF3PBOSZWztajI5WG/hpRXxqF6CBKhq6i1UQBrCKqbO1qKqt0UtZNrUQfRUHsiqCw0CM57PE6TY57dD34+fTIb1sMZDnIgHEIiP1HA70Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMGAuQpMsjvTncl9JJmypONx+Lp0PQEHGgyFUDxm2nE=;
 b=DoHcBHCAdrInVSTeGPmXRFqKhJHfORnNJAkwizfVYf/ujRIK9c7tdRUjjkimEBelzU8cVxzNmkXh7B9ENj7GQA/AMLRQ7yfrcsO5seLZg6rawGejTLGi9exaRSjKaA78cfU+ATULvjlBD1E+bCyLwdDKtZWJGOGqSXvqB9Ij8HMJZt05ewfEcOqUm8c0UYj4Ho9D/y9/17GHVvNDKKUQCE0W8txz7sZjSkIFHmXWdZly0brOTabGJ+7114tg+Tb+Cw/g+M5b2CZ3QQ0peXrvG1h3WE1QsHwNCvRg5jnvAb+IydeK0W3hfsccFMOwhe/gp53jUQ0izrl+eRYpP1kGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMGAuQpMsjvTncl9JJmypONx+Lp0PQEHGgyFUDxm2nE=;
 b=ICBH6X33AeBncuobpSmKUify7AJaLzXwPejbTKytqdjIfIQfcPN5fS8K3Z9VvSOqwHz8L7mvse9NQPVAeB2rmcW81heNZ5ARFh/md0SGRMYwbcUqfx9uOYcDgAarefxGlfJEOHNGstop5bApqX2CMFey+puS0RuiA+kW/PlbhCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:38:21 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:38:21 +0000
Message-ID: <f4d02ac8-23ee-d891-4056-75c672cc59c9@axentia.se>
Date:   Sun, 2 Jan 2022 23:38:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/6] dt-bindings: mux: Document mux-states property
Organization: Axentia Technologies AB
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::24) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d225445-ff7b-485c-aeab-08d9ce4093ba
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB29204EF7D38530F13448D3A6BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj5nlNATlFSMoPsiAvb5Lu3uWV6fQp4+ovaX70WT0ilKhrPVHS0aCuI/3OM/kyVe5eHdtSZk+CjNxObV7ZQjgx4IjT1DV9PbdQ9Oy1UVlTn7NseHOlUHcw+WbitFuaKd66YQ6gLjLxn4FYQKo+kPwgmHMGjsXVC2uCMYa+Ay8a1b0F4qBBSs5gPh/qJSFxHXRNldxMpPzKILVoZrC4YxT1La5p+819temAFM9UwOGTan1k8CfNn82ZI+a/xF/A2y2hKod0t74o1qicdDT6lxJrDbMjDpEWJ3cxoNzaK9rABSzpuGWUIt9gyRq2bPm71EvYz47LnZPzzc9tSVqATCBgaI842jU+IAGV+RKZgT8XVDCMyGwVWolA53ASaT35Oh5pfrnjujN3UmLsUDRf0ZX6uUHyI8s2rfgzTYzbObHykIksEON6Ax7unynXIZYljtcjUn7Qlb6JmMl0aGu1EngMjrKzi/oza1ykPQdSrfRMzBbwklQ/BbHChl1KxvcI3wXc1ERleQxEd3rafuaZbNQYYYriMjZe+Hx2v5C6lZXi4VkUYP9NIATgRDnVfTiCgpMr78hDOJpJAGiF9CPdeXIrVjfCRrY5Fl9WB+nO0rm4/AjBCg2R1hycUsUzCGikKgBBExsmy9QHkFUB61LqkUd8l6nLOaDncHIh+gnaFQ/wUukzJ4HhsRBv0P2lttdCWkGPSFnhClfbUu7Gfzb9FG2Jmfq98oJ90pBJ6ws1blnM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(83380400001)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(6916009)(6666004)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhQZW9TVHNuUmtaNm9nbWtRV05FK2lPc25XNkx5eURnWnpDQVdzcXhKZkdi?=
 =?utf-8?B?MDNYQ3VXYmpZQ0dwdlFqcFA5M1FSTEVsSHd1WWh5ckJDdkxLQys4TkxwUHJ1?=
 =?utf-8?B?UnhqeXJLSkhEUElOb0czRk1iTFNybXVxUDQ0RXF0Z2M5TnA3TzBRT0ZqN050?=
 =?utf-8?B?ZFRDdDJyb0pvbW12NXdzWnZ5MzErMFJ2Q3IrTnQxdkdpQnQ1elFBZFlUS0ZP?=
 =?utf-8?B?elgyQytqZWV0blV3WXJIZWlkUUV5a2E1OXpMdTZZNllPSml4RDhMbVVYRTNl?=
 =?utf-8?B?Z2swNHZWMCs2elMxWjA2Z3RmbTFTTEdRUjdDdlRTQmdLT2Vrd0JkNjdiWmgv?=
 =?utf-8?B?K2dIOE5zQXBLd0hsa2haME5VbEVVTXRobmxFcStaaVNvWlJTNEhCVWh2WHNP?=
 =?utf-8?B?T0ozWGl2Y0R5Y1dEZlFBZU83NGhEaHVlS0trcE0xOFlXWDZzQUR4NmdpN21C?=
 =?utf-8?B?OThqUkFkU3FUQnpESHVnTzBKSVJoOVRZMHhlenduclFtM1VFVTRyZEZjYTNR?=
 =?utf-8?B?MXJDSXhKWER1aUdUT0RhNW5PdFJHUmU4akNvZW5HbG5SZ3gwN1pkZncrUEVF?=
 =?utf-8?B?ZXNFSnNCOVp3ZU9CZWtoeXJDR1RVa0MxalNiR3RoeHFCMkc5cHNBSEowZ3dH?=
 =?utf-8?B?dE55SmczUXRicnVWUzFOTnh5UmVvMW02U2tQbkVBb3loRXZPOExCOVJMaVVU?=
 =?utf-8?B?ZU5PbEtySHJEb25xL2lhdVMrYXFhN1prM3hGMTZxcWJTSVZ6TEtlaDVvMGxv?=
 =?utf-8?B?YmthaHVMSHppZTFYMmJoM2p1NkxRd2N5ZEoyN3RtcU9HVjByYlhDZmhsS1RT?=
 =?utf-8?B?ZUt3NWFZTlJTNldEcjJ4RHJkZ2ZpUGxwNUJVYmNrSFVseXVYdGc1ZDVpYU1N?=
 =?utf-8?B?OEVnR3laZEJhTG5PUm5ONCtCZG1UTzNlajBKUWprN1RFdDdtVWJyLzFmQW12?=
 =?utf-8?B?SVQ4NDJSbEhwL1p1TncxWGVLazFhSVVMRmxkZkNkaXFFMzVJR214NEFGcmgx?=
 =?utf-8?B?aVdtemNxaEdxeVJWTlJNL3NIMXZXUlBvMW1GUGxhUzlmb3FKTzk2bTVDQzd2?=
 =?utf-8?B?OTlUOWZlRlRxVTd5YXlVTHFTV0hmREpTZ0g3TzRJdkhBUVpEMXdaTGVpTkVH?=
 =?utf-8?B?VTVhUXNLOEw2Rms4eGhDQkYwMmFKMzRSN0k3UTd1ekFjWWZPVko3Q3NOdUFk?=
 =?utf-8?B?TVNhVDA1SWtlL3lhaUNEYUJEQU5kRjNqK1Nvb3VLSkdaMVExZHB6SmlzZzZ4?=
 =?utf-8?B?REtEZTFrbEVqcjVNWlpmQk5EUW9BUXRMdGRiM3NZT1NpUisrSTloTDl2TUFr?=
 =?utf-8?B?K2hVRHJPT2JxODFZREVDSXhzSUpEaWNLQ1RpaFhZNmZHaXBUSm1KYllFbzVx?=
 =?utf-8?B?YUFJcnIvaU8wbWY5UnVGbXE3MEV2Z0x2R0svaTdBdS9hZDFqTjB3UWVGTWpB?=
 =?utf-8?B?T3c2S2VPMTBQUG50bDRYc05rd0hvdGt3ZnY2c0VPR0xURXhBY0hUeitlQXdH?=
 =?utf-8?B?YS9hZUF3dU9pNXE4S00yS0NhcWpSQThSZTR1blBNelZubXh6a2U0MGdoWHla?=
 =?utf-8?B?VkJyS2Q0SWJlVmt1c2Zzb09ndlUrcmpZWEEvcE9vNE92N2JNcGU4cjgzWis1?=
 =?utf-8?B?LzBqUm43L1ZwVHgxWDdJcVRiemRBMklnaVZLZDlPcnJzWFZxRTltZ2JSakw5?=
 =?utf-8?B?WXZVWUMwTGlKZmQ1OHo0cWhyNkFXdjNEeEVablJzcnp5QW53K0lzdnhhdWFK?=
 =?utf-8?B?K2ptVHhXOXB3WmNhaE92TW5OSk9PUlVzUEtKWk5xdklBRkQ3bndnbDBRc0kr?=
 =?utf-8?B?ZmRNUGZ1T2hiZXZVZ0cvVFptRlJVditBKzduajkyUGxZd2xmM0NoeC83M2tR?=
 =?utf-8?B?aEdOUTBBVUpuZTR4WWdHN1hqakFlcFVFVDI5NmpyV3JXZ0prbXYxNzJQMVhX?=
 =?utf-8?B?OG5MZlh5Qmprb1JNNDRJR2grWE1lRkM3Q3NJR25SR0NIbGEvYUhYZDE1cVRt?=
 =?utf-8?B?TG43SWx5eXA5b1YzbGJ5L1ZuYXc0eDVXVFZmcEJVSjNCbFNlRXIvZG5PWEsr?=
 =?utf-8?B?MW81VSsyRk1PQTJxRDV0c2Vyb0w5eXAzTElnN3ZPTXl4ZlYvQ0FTeDdoQk5C?=
 =?utf-8?Q?ADtU=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d225445-ff7b-485c-aeab-08d9ce4093ba
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:38:21.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1bM6EaNJuQA5qjgVL6JWdhrt8lXXT25p3Uqw5y7w8PFU93xAAd8BuIVILSP1i+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

In some cases, it is required to provide the state to which the mux
controller has to be set to, from the consumer device tree node. Document
the property mux-states that can be used for adding this support.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
 .../devicetree/bindings/mux/mux-consumer.yaml | 21 +++++++++++++++
 .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index 0a7c8d64981a..ee4de9fbaf4d 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -26,7 +26,10 @@ properties:
       List of gpios used to control the multiplexer, least significant bit first.
 
   '#mux-control-cells':
-    const: 0
+    enum: [ 0, 1 ]
+
+  '#mux-state-cells':
+    enum: [ 1, 2 ]
 
   idle-state:
     default: -1
@@ -34,7 +37,11 @@ properties:
 required:
   - compatible
   - mux-gpios
-  - "#mux-control-cells"
+anyOf:
+  - required:
+      - "#mux-control-cells"
+  - required:
+      - "#mux-state-cells"
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
index 7af93298ab5c..d3d854967359 100644
--- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
+++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
@@ -25,6 +25,17 @@ description: |
   strings to label each of the mux controllers listed in the "mux-controls"
   property.
 
+  If it is required to provide the state that the mux controller needs to
+  be set to, the property "mux-states" must be used. An optional property
+  "mux-state-names" can be used to provide a list of strings, to label
+  each of the multiplixer states listed in the "mux-states" property.
+
+  Properties "mux-controls" and "mux-states" can be used depending on how
+  the consumers want to control the mux controller. If the consumer needs
+  needs to set multiple states in a mux controller, then property
+  "mux-controls" can be used. If the consumer needs to set the mux
+  controller to a given state then property "mux-states" can be used.
+
   mux-ctrl-specifier typically encodes the chip-relative mux controller number.
   If the mux controller chip only provides a single mux controller, the
   mux-ctrl-specifier can typically be left out.
@@ -35,12 +46,22 @@ properties:
   mux-controls:
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  mux-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
   mux-control-names:
     description:
       Devices that use more than a single mux controller can use the
       "mux-control-names" property to map the name of the requested mux
       controller to an index into the list given by the "mux-controls" property.
 
+  mux-state-names:
+    description:
+      Devices that use more than a single multiplexer state can use the
+      "mux-state-names" property to map the name of the requested mux
+      controller to an index into the list given by the "mux-states"
+      property.
+
 additionalProperties: true
 
 ...
diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
index 736a84c3b6a5..c855fbad3884 100644
--- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
+++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
@@ -25,7 +25,9 @@ description: |
   --------------------
 
   Mux controller nodes must specify the number of cells used for the
-  specifier using the '#mux-control-cells' property.
+  specifier using the '#mux-control-cells' or '#mux-state-cells' property.
+  The value of '#mux-state-cells' will always be one greater than the value
+  of '#mux-control-cells'.
 
   Optionally, mux controller nodes can also specify the state the mux should
   have when it is idle. The idle-state property is used for this. If the
@@ -67,6 +69,8 @@ select:
           pattern: '^mux-controller'
     - required:
         - '#mux-control-cells'
+    - required:
+        - '#mux-state-cells'
 
 properties:
   $nodename:
@@ -75,6 +79,9 @@ properties:
   '#mux-control-cells':
     enum: [ 0, 1 ]
 
+  '#mux-state-cells':
+    enum: [ 1, 2 ]
+
   idle-state:
     $ref: /schemas/types.yaml#/definitions/int32
     minimum: -2
@@ -179,4 +186,21 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mux1: mux-controller {
+        compatible = "gpio-mux";
+        #mux-state-cells = <1>;
+        mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
+    };
+
+    transceiver4: can-phy4 {
+        compatible = "ti,tcan1042";
+        #phy-cells = <0>;
+        max-bitrate = <5000000>;
+        standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
+        mux-states = <&mux1 1>;
+    };
 ...
-- 
2.20.1


