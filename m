Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5D50E6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbiDYRR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiDYRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:17:40 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130087.outbound.protection.outlook.com [40.107.13.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE681C102;
        Mon, 25 Apr 2022 10:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+HA36cFLsto3TVejp9vHgpc4LwZwdLnWUf45hTmnFTObPh9AiyFmAqTNvBWXXdeIxQ7YfWUCljbAiBQ0ydIQUeYxibtMNBt5IZWF7+39x7okmg0Jxqglwo5XQEXKYE8qfo4gd/kiN89vhLsYY2zkzSxH5hxub6DFfO3wazDu0r73kvB9w3407Sjxb4UkMcGqNBt5kAxvygYyMqtvire908yRN2B23miobS4nu3FBYZ0LMm9Tw/xFF8NY3eqU+obAGXzOMmZIAC4LoCmCgWtOisaeOwhkpIfUNDR2cjhAp3uRbDu+/TZKmvPIPStsz8vrW1PNGpRWq3ReAP5uKJ4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXy+j4+Sk3O0bY7L3z82vtUx5yN29NTblCXf0vUzTJ8=;
 b=J7sk4U53ibqFwzcTm8GfZAXDYKsDzaKuqT0AyhCyla62dwDTcEtjm2neGTNmn5k/GNxwnT5wxWmSyA30oAmGq9/Qx7hMbaIWdyQIDo8Ism5VESY8r8C4W0g6eLN4/70WsIPeKVW08qXqlw4RMGImz0F5p3Avtdravv2GxXusGGE6f8Z3SFtMM67avoCpuFOt42dYN4Tob9Tyomnz1rTRRFbiRKB3KjOCtLpTUzMILqGTKjb/I4zr8eDYf5pQEydzoj7LC3Jmt5W1LmJ4YxuOW80hK5E5P87zns45+XXxQj/0J/ngq7dXNrGrq3BRRBkevZzWRdCOgl3v20HKpLygKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXy+j4+Sk3O0bY7L3z82vtUx5yN29NTblCXf0vUzTJ8=;
 b=nGsZJ8WP5JHvNb85cUhM8FASWRxl/fM+HOyG+69fgDEqptumQwSB/Rm/a0A+dIUUZMaWr0quD7C/V2G6zfJKdbdhf/LerlW2/VeeWIUA2t1mW378jwBiGc6Cme7wewvnAxhrvwYmc7eLt12gD7kEpkL7P1EECYNsiSUrzZHRtCRSlUNuUaO4CrBGcF82nV42i1EaDWq0X2akTUD/yCrznlZcDtDuT7gTZ+uR2UQqhsQ3R3FKeuV+jPhxWdafMH59SdiRcbFPGKmbGdKghO2G6oaqXW/SD21d9qLHs5r6hy/sG/rL+Mog/tIGo3U7Z/K/4GGmwUguBCbbcP1oUkAQ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB3736.eurprd03.prod.outlook.com (2603:10a6:209:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 17:14:35 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:14:35 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
Date:   Mon, 25 Apr 2022 13:14:08 -0400
Message-Id: <20220425171412.1188485-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220425171412.1188485-1-sean.anderson@seco.com>
References: <20220425171412.1188485-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f882de1-e9ad-421d-8d4a-08da26df124f
X-MS-TrafficTypeDiagnostic: AM6PR03MB3736:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB37363B43BA4497A413351BA096F89@AM6PR03MB3736.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDv5gn23R3LsWHiGUR4FaFGC/zJdLK2RhxS2zU/47fBpqSkKLVfLZZLSFxzMzeTR3m8xm8kwVUhxOUEq3DeOQLYddP3dExrsJtOagfnkfxiHhpD306bkoJCbQIA0q6ulDBLXd8undsTtLQ5vsL6hKBKutmV0NCpG+tlf44j67oXMsNH0ycbm09jZl3jwE8yVpdfVd3o/d/YdOPLHxePLLUpqggfhtuhuhStNToiR2XomZEPepmAO5WK37RGBHDoilI5PeCyxgX5ygPznPkwwi6Uqw9+T+p18CzIYZeOET43xy/DTw8CA+o73AqODDnAhy5xeuiSfn768esJRiZceCZA1M5Mk0o1J0tj8GhTO+u77GfKUSSj9fFYIOQrpR1hnR+3mCyZiW9cPG6NYTFFo0W3elUBsydRvRXF5R5LouAV9TfrnO3njG+iDwla/V6z1Hfys8RoMetZIx7vhOomrhkHIKYNsGyWvJO3SOZcOPDZCjWLUUXaXJQQBqT0SWTfAmDLTGy11MiFSzQzOF8Cq4Xck01IqZLshDxglikH/kZ1/S/XZrYqHaHvjdopsM99GaH+4ghpNQ8jE/DtsE+ZnVGcZcnKh4lmSJLUEQcUJlJju7hrxV4FzaRII2Bjn3CqoyuikhBqDeyvz1toNLNrk0ONIQUSJmV4q6pChmEcvp0hmfMfCN3ylW4HSqKcfASZgPnerFSTp14YNZ6oQDIfMGSPy3vfBNQ6gJOJ7O9SDT+1sSf3xD5n+zLJRyn45JchI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(38350700002)(38100700002)(6666004)(1076003)(186003)(26005)(2616005)(5660300002)(7416002)(316002)(36756003)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(52116002)(86362001)(6512007)(2906002)(6506007)(508600001)(83380400001)(6486002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MdlHpy035stpHo+MRRZFdAIm9goCXh08fsgChM0pZvTfazAZ3c1uJ0Tvfc/y?=
 =?us-ascii?Q?G+DzN1oyzSrAEVO0x5yOrkXdm0YFw9MUHRb0ceWgtZOh4Ip8Vtw5J9pamPWR?=
 =?us-ascii?Q?QsNIklxZkNyrfjzJZPDIOuNKrdsW1qgGSBNbRA47EOhUVrSkMJND1i+Ulb16?=
 =?us-ascii?Q?KGwBIZSck+4wo3xxykSyvPs6Nuf2etWVbTycJ/t2q7toPlV9zz4tlJl+xXys?=
 =?us-ascii?Q?DExsj+Hox82m/mpWLW/w3LsE0l0F5a0dSIbyPkfqlaUbmFnvpKMlFheGP6ye?=
 =?us-ascii?Q?3s2/qt4fl/RZ2pmuqpJnMA9neOiIlq8AegghtFGgjil/vbQPB7yZmyymwjwE?=
 =?us-ascii?Q?EkMgfvmTuz805coQellIraJu5gz8InSFdg9slwyg1essCT8Heou108t2wHoM?=
 =?us-ascii?Q?ibGee7zWdtDHdZArxqS8YjpK6E2t9JX3C0poxS1Gd0laCQ1rHAGaBzfN4JQ7?=
 =?us-ascii?Q?BVctu/iSemvikOv86KhSkarAuJQzBQwoQdTWtc3+x3ojyJED6yHm/GgBBj2N?=
 =?us-ascii?Q?BIc65/AsWCse2vcat7nEE2wqi05PWu/dv7p5i7oUIY/tvpbRoK4nT9B/QNAz?=
 =?us-ascii?Q?dC2bYztH33tDH7UhjorhCaQIoHcl1r/Ox8H8y/XEhubwiUz4Ga3R6QvoJ3lM?=
 =?us-ascii?Q?YQTc435yYmBYy6ik0i7jFZI2iKJcFPcm++ftCs+iluP12Ja6rXGhb70f3UIH?=
 =?us-ascii?Q?D+AQKpl0hlfzcqW6Zjp7ygSylXZtWpQO8B63q9UNcjc+xs9vu6yG+ZCHp0+4?=
 =?us-ascii?Q?7KdubmtyDERvD9d5k9Oy726kZ4duGDyw1hPxsTRGZU5LPSmCWVWqOgtquNjc?=
 =?us-ascii?Q?wY9skQxRj0x++LdvEyh6zdX2Up/UbX+C2MCCIs9AXvxcow3KsKxhMUZjF+hC?=
 =?us-ascii?Q?kf4Z9RbPTCugdtv494Gv6y8GUiNfQciI/9TwNTjZ968VSmaGCHh+lkRClHUq?=
 =?us-ascii?Q?BtfRnQEj43OoOWd/GXSDWxanskRCUXnoLEneRVnGzxMGe/qLGzWW25VobbzD?=
 =?us-ascii?Q?VodHsyCgljXNJgzahkxTvsfX5hYI2/g+PvQPY9xSMK8x6b22OVEzZpFTTctk?=
 =?us-ascii?Q?SbOEN1Rfu05gQLc/HElkl9bnEemXhrcE7nIpc5EkjEZlXjHOZnqLrbRbD5XG?=
 =?us-ascii?Q?v+Q5wP+aFRxx+NKZoYUHYd9lTI29s0VzOl2sKTwJN65HXEOAzWL33BfHWThW?=
 =?us-ascii?Q?Qosxxf24c1knpKZnp44fiVyvWNiSg3+pqoAlVKPuny3XaJniyfeW0Yvp9+HT?=
 =?us-ascii?Q?VJPziok36oyNEY1hFFObSSYOqk4GuC2xtH+EYf6LTxohwUGy/7RTZiXGwWni?=
 =?us-ascii?Q?SSTPu25BgU/t2IAaA7dbmoW3El8jcZEf9kA3IMUqqffl1K4mfSjfFBuYTM9U?=
 =?us-ascii?Q?Zx8Uste+b2+6jxG7C1/iNn5G+d+ck7mwb9HHjWFbukZidlCrQVWndM03AvKo?=
 =?us-ascii?Q?RX2cv6p5skDP83loUesk9stJBMyxH4k/3KhtgZOg09uXh8aTItSOJthszenb?=
 =?us-ascii?Q?yq8io8/aK92H71FNF+MzW0ClSHwpyilRS/349xrE9zcaMYqU7gokHsGc7GaS?=
 =?us-ascii?Q?4bSdR2N11eUFeKjcDyuj3KmFZ+fr284amfC+3B38t4Hl3hXQ8jV6ykrRx4oC?=
 =?us-ascii?Q?QEZOcWM10CGLPfBIM/+0/GnT7YaiPfbaM8gXamXI6WK20Zc/xdrjHahch2a+?=
 =?us-ascii?Q?KsxRIn9GqjXZ9alK0OsLSxQH2GAZ/8fXXJAXuT1tO+vaUG6Ye6ciqxBUhcql?=
 =?us-ascii?Q?oI/YUefQpAkoNBcU+HZHP4nnhVqFQK4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f882de1-e9ad-421d-8d4a-08da26df124f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:14:35.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iy2gxZHomVpwnbGYBAHd7pceDzN3TkO4IXxZMd0319oYIkmVKuCKe+QQYSbe4xQgwjl5SDuTtTlZQHW+D1JhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v2:
- Fix dt_binding_check errors

 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 2824c17285ee..b4517b01616f 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -34,10 +34,9 @@ properties:
     description: Should specify the GPIO detecting a VBus insertion
     maxItems: 1
 
-  vbus-regulator:
-    description: Should specifiy the regulator supplying current drawn from
-      the VBus line.
-    $ref: /schemas/types.yaml#/definitions/phandle
+  vbus-supply:
+    description: regulator supplying VBUS. It will be enabled and disabled
+                 dynamically in OTG mode.
 
 required:
   - compatible
@@ -57,7 +56,7 @@ examples:
         vcc-supply = <&hsusb1_vcc_regulator>;
         reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
         vbus-detect-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-        vbus-regulator = <&vbus_regulator>;
+        vbus-supply = <&vbus_regulator>;
         #phy-cells = <0>;
     };
 
-- 
2.35.1.1320.gc452695387.dirty

