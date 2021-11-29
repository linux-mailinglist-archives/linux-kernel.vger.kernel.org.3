Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0E46240F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhK2WPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:15:50 -0500
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:29665
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232141AbhK2WNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:13:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUBFCu4KiA+VOJeEvigYnvakxI4qQyhbTNiBtFpQn56XoB0D93abPSfv9icSLu7GjdjUxgu6lTQ6aDAUTKWHbVLbmcBHJtvkluuOXxPn7q+9EIa0AbWKmfdafKcuEzmOoxoVfw5uZBh+Q4gWr04N3XFnpNIDFu8szMTA9ut1T0H/lPLLi4RB+L9SAOb5F/qLQRB4452ZnwKmNwQTe/+QonelCsFwLd9eTWgFfGuQSNYz+ZqDis08SRCru6TOHJAAzLt2sKKOGLhiunxML8f/rHQ/RaF/neJ0EYjoUDP1lNA2jBpRJ2x+y3jDamwGyJsWsLd46gfOyO+81ROawMUsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt+2+k6f+DGPa3HrUbXthZgnuY6D/ROwoeeP3ig0e10=;
 b=EBojQ/4uBVMZkEEr0iK36YiSk6DzEpgurb4A9rs+lYTf+oosxg5BzkEU1yxx49ZmUmivYEZniMgB9A27KNwuFIPUbmrCL3YmACBYYhOGZkg/f/wwnp5LmsrlMLb3qPUQWMVVCqMaVZyfyMRbCgvPnCq3+psW/C+JxNQJaZoNhDI+ewFtaR7XOvW0h0SBVRrtLTumVeoKfR0FDRxaorpD0Jy1uC4acEEgQj/2V4ipmOUDaTMWGq1uBo6o4sCeFwY9EvIitv5VBw7ck9xLRK7hGd8/3Mp6Smj+De579MUPwvw0jw+8C56Zex6mleBaHivMAj4C8FSFeFNDCb8WcTkpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt+2+k6f+DGPa3HrUbXthZgnuY6D/ROwoeeP3ig0e10=;
 b=JsF1QSh5OxT6dw5rSdnvB7tQSYJUAGSmn5FMz6iHnBbBZbxNQa78Cl0uzSnNhwMQZy+BZKyrAgLLm9cwCG2yPGET7wKOIIOL4XzR5ppxfCd0EB4bG7BNrPclnJLJYs6MuaX0AADlMzVgrYkhj30xxTP2H+HVoyXBf27eS92hjPw=
Received: from SV0P279CA0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::6) by
 DB9PR10MB4796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:254::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 22:10:24 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::c2) by SV0P279CA0055.outlook.office365.com
 (2603:10a6:f10:14::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Mon, 29 Nov 2021 22:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 22:10:23 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Nov 2021 23:10:11 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Nov 2021 23:10:11 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 82C6480007F; Mon, 29 Nov 2021 22:10:11 +0000 (UTC)
Message-ID: <9293e3ae4ff8776704257085df65516b81209b87.1638223185.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 29 Nov 2021 22:10:11 +0000
Subject: [PATCH V4 2/4] dt-bindings: da9121: Add DA914x binding info
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e09be8-6a81-4ba8-eefe-08d9b3850aa8
X-MS-TrafficTypeDiagnostic: DB9PR10MB4796:
X-Microsoft-Antispam-PRVS: <DB9PR10MB4796186F8F6FDC0BEB09AB5ECB669@DB9PR10MB4796.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXTKjI5QW1tnDdRIrwsQxM+J+FT3rtOr9oknmYUC5vV10RfTEbbHrW5bYu2oWoOLOKPZuOHOte6bL170FR1OWIOkYuHAOiNKmkAqYU+wHsYT4sebsG7y2qdPw79u/0eYn32n/kwg7y4rNCWGeE6mgbDZNYB7fPqb9DFyJ2HFIpYrjraxgTIe/YDZ/3yIJqZQmJ9oPu8LySD9Z/P5NBh1QSQMLr8qB/qQpHf/XBTuUXKTTu7AXIutx+0iokTbo5BbuitJmfidOeb6p1KNT36f/OXBG7BAxc0oWOn2igIK1RO34pPgC6Zb6m7Mm04+jDTsUfxh7POQaf4lamSSzenyAoY8EawzhyFjBq9Z6Yg63i16hTQ2xGakNcS0WFXF7PBjDdow9HepTlhF0ZjBCMHeDzdZMdO0QlALt/38BISv73HyC/U9SfZb3JmDA4KUwCS6Sy+LtcHkYNO95N2FEa7JeDtL7pkgySMLuMeE2yBXGvq0VagDNzKuWK5GGj0mXDsTeOqxmvEFuyHVrpdGdOhnxuWzzpu3+p1gj+cwNcBJoakCDhM2gqLlf7YVzBHIuFAMHqAnN2Q13Gx+8CehO4sc6deK2YIJsGMN3D6727RZkwA3P7RTJ7LQ9wd/Z2/qJN7tGf+OX9jTuZXRD/LE33ZKoWiDh459+Kz5f+LyBsXnv8hCcyhxWTXLQ4x1T+57A3UVCeyrBxQBH8kgdv4rgIvjTqRNCR3ljY6CzAI3C/gcSBA=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(6266002)(508600001)(83380400001)(107886003)(86362001)(186003)(336012)(70586007)(82310400004)(5660300002)(426003)(4326008)(70206006)(110136005)(47076005)(8936002)(26005)(42186006)(81166007)(2616005)(54906003)(356005)(36756003)(316002)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 22:10:23.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e09be8-6a81-4ba8-eefe-08d9b3850aa8
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4796
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the configuration for the DA9141 and DA9142 regulators.
Also tidy the table, cleaning away superfluous information.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/dlg,da9121.yaml        | 75 +++++++++++--------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 0aee5fcd6093..24ace6e1e5ec 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -17,27 +17,39 @@ description: |
   Dialog Semiconductor DA9130 Single-channel 10A double-phase buck converter
   Dialog Semiconductor DA9131 Double-channel  5A single-phase buck converter
   Dialog Semiconductor DA9132 Double-channel  3A single-phase buck converter
-
-  Current limits
-
-  This is PER PHASE, and the current limit setting in the devices reflect
-  that with a maximum 10A limit. Allowing for transients at/near double
-  the rated current, this translates across the device range to per
-  channel figures as so...
-
-                               | DA9121    DA9122     DA9220    DA9217
-                               | /DA9130   /DA9131    /DA9132
-    -------------------------------------------------------------------
-    Output current / channel   | 10000000   5000000   3000000   6000000
-    Output current / phase     |  5000000   5000000   3000000   3000000
-    -------------------------------------------------------------------
-    Min regulator-min-microvolt|   300000    300000    300000    300000
-    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000
-    Device hardware default    |  1000000   1000000   1000000   1000000
-    -------------------------------------------------------------------
-    Min regulator-min-microamp |  7000000   3500000   3500000   7000000
-    Max regulator-max-microamp | 20000000  10000000   6000000  12000000
-    Device hardware default    | 15000000   7500000   5500000  11000000
+  Dialog Semiconductor DA9141 Single-channel 40A   quad-phase buck converter
+  Dialog Semiconductor DA9142 Single-channel 20A double-phase buck converter
+
+  Device parameter ranges
+
+  The current limits can be set to at/near double the rated current per channel
+  to allow for transient peaks.
+  Current limit changes when the output is enabled are not supported, as a
+  precaution against undefined behaviour.
+
+  |----------------------------------------------|
+  |               | range & reset default value  |
+  | Device        |------------------------------|
+  |               | microvolt    | microamp      |
+  |----------------------------------------------|
+  | DA9121/DA9130 | Min:  300000 | Min:  7000000 |
+  |               | Max: 1900000 | Max: 20000000 |
+  |----------------------------------------------|
+  | DA9121/DA9131 | Min:  300000 | Min:  3500000 |
+  |               | Max: 1900000 | Max: 10000000 |
+  |----------------------------------------------|
+  | DA9121/DA9131 | Min:  300000 | Min:  3500000 |
+  |               | Max: 1900000 | Max:  6000000 |
+  |----------------------------------------------|
+  | DA9217        | Min:  300000 | Min:  7000000 |
+  |               | Max: 1900000 | Max: 12000000 |
+  |----------------------------------------------|
+  | DA9141        | Min:  300000 | Min: 26000000 |
+  |               | Max: 1300000 | Max: 78000000 |
+  |----------------------------------------------|
+  | DA9142        | Min:  300000 | Min: 13000000 |
+  |               | Max: 1300000 | Max: 39000000 |
+  |----------------------------------------------|
 
 properties:
   $nodename:
@@ -51,6 +63,8 @@ properties:
       - dlg,da9130
       - dlg,da9131
       - dlg,da9132
+      - dlg,da9141
+      - dlg,da9142
 
   reg:
     maxItems: 1
@@ -69,26 +83,24 @@ properties:
 
   regulators:
     type: object
-    $ref: regulator.yaml#
     description: |
-      This node defines the settings for the BUCK. The content of the
-      sub-node is defined by the standard binding for regulators; see regulator.yaml.
-      The DA9121 regulator is bound using their names listed below
-      buck1 - BUCK1
-      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
+      List of regulators provided by the device
 
     patternProperties:
       "^buck([1-2])$":
         type: object
         $ref: regulator.yaml#
+        description: |
+          Properties for a single BUCK regulator
 
         properties:
-          regulator-mode:
-            maxItems: 1
-            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+          regulator-name:
+            pattern: "^BUCK([1-2])$"
+            description: |
+              BUCK2 present in DA9122, DA9220, DA9131, DA9132 only
 
           regulator-initial-mode:
-            maxItems: 1
+            enum: [ 0, 1, 2, 3 ]
             description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
 
           enable-gpios:
@@ -97,6 +109,7 @@ properties:
 
           dlg,ripple-cancel:
             $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3 ]
             description: |
               Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
               Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
-- 
2.25.1

