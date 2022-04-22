Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACA50BAB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448967AbiDVOzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448917AbiDVOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650975BE7E;
        Fri, 22 Apr 2022 07:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS6taKk8cUEZcHfS3RNfvfNlRHsRAw9GNe3OOnNw1NR3biw+g9NGq9+RuBU8WnqYVZ11GdjXtMXCwm9fyGR3e9MMd0bIODyOyGKIRrpqbO42+tDsP5kGRU7UcqNzqFPoxIXBx2R6mzNz5es8qGsFBc7o5O22hu0Ya7lrKR47/6c9DM1bJ+LTfosUtXEJV83QFt/n5eS78YwfpisQWXQye/onklcsUxlZYGNTzy77KpgbXthg44CWlGkUQfXLhAGUOI9u3objMDMHcpaHrbNQtSViDvGyItDzc8Yf6RRH6kvHphcQe/aXNZA4gR2uhBC2Z/cvOop/x3n3SAr27tUbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u503bf89sGlMViLE0zYQy0JMXrL0QiWADKiwK/gaksA=;
 b=d+BjoRZOkaCP72P0ZOVesOnJ4tHjkNGJsag/mF2kESPNoNUmD9iLjuBVxOjSHcK4rgiH6JCz7H/szfyvg1C39tH7z/Il+y3YptSOz5+Vic56q3WeMqBjudeb2FxD117/C1jofmiQvV3YS+b5Mw8Kky3uOFyUMr5QBMbNDBEUe2xx6QHZNfcdDoO016eD+HxLrrVwXNUFpeU9aN7cnI4K4pVMRHiHYRmDwCqXsY2qWZovwrc05AsD2L0bOHY7+iXXP+PI4RbfNoQFiZEHJLgL9RCy0wBkigjHqA5wJugXQnFyh10FJGbvLn+hAA8M4f/8nnr76XsCF/tQ4fRCG2TVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u503bf89sGlMViLE0zYQy0JMXrL0QiWADKiwK/gaksA=;
 b=M8YRxK6fvkysyzfJjPhQ/OupfYWMth+VEBq3K4H42h/l7oAwftoNOXCRg+WIHlSZorhFP1/TJkv+RdnSbXK5qayC7xhUxMHG/QGocVRhPY8sc885W7oUaeZ6f+0PjfPuyS8W5o3KLWmMEoaHBxDq/WYRZd1T233dY5UonL+NyOlJ7wIRzSn9nW5aJKRa3e2Al1Lz9uS40ywPLBgCCk83wO+UJ8ohypv58jeOisYiFiATptviPD7DutrIUFGGzEvNUmFQdnd3EVUrULCNRK0WTLdTRheVTLSQwhzV6Oh5AICURyvD1ykN5Jex+IIags2JGDeOGtY/bhQWZ5SMWSOw4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:03 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:03 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 3/9] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
Date:   Fri, 22 Apr 2022 10:51:41 -0400
Message-Id: <20220422145147.2210587-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 693990ce-80f9-435a-c6f3-08da246fa9ac
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2792B00C5BBAF02870E8F69A96F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5f5GGwPHoPDvf6YKGtEnENrlTUi8sAFAuyARA1aOF3VHpivy+SUchxXqogxZZ0ZgwHceioKB0w5ejkIY26Dxqh4Nf7HS02fdjgJYB8B3xMBzDbFZKz0zE9wRqz0/MONP1n3CKbxGMqiNNRFLm8f3Py9ce8jb3AtwR8o1e5acSTlkFeaFvSRwVNarIBKFaI6u5UH8p+Y6zIesqiNWxMpdLh1ZRC4FUVsKf73GZODoZRGaJk3TEeCgR7uszxQME7/B+JHOSIaXJUb/dAqInuWW9p52Jj2GLS+Tw1rihSchv018vacgfRUsN9vMpypJNjCzAdHLm69NgRKMknUczMauKLyzEVZTh0Tk963RnTge49aSDdeOLUyj95/I9v3VfiXKsBaeeIFTwrc3RyFMbCMl4G0jn57ZTsgea+5IDBXcRLZfJHZuu3ar7QNtA/fPOF+USanWzpnhuOB/iV7rKVY2MumZd+PhG/dqfdZx5yc1wUbPoP/4anh4e53mwvSz4s3wVephyr217zg0wuQKIo46VXchuUOxCMrCEzPr9C6wmlor1Lao320Pv9XdvUodE3Okd1AFCCnoKNMS/UaobqgwG1gRferSelD96uzqM81mfGWwjgut0r/jogxuCq6ToEua2IdfrMRmu/LVNTTyYSqiCVgTNuXe/iCg8RWRPIbqO6o4XqOic2S6C/PAXUCLMyiOggem6G0wtpflWtQwLp3Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(54906003)(44832011)(7416002)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQdQNUH6IdSit0/aehQUyMviMptgSZ3bTsJlb8nm4m5kccefP/gFazHjcH5h?=
 =?us-ascii?Q?2nu4MFsG4YlKuVru+zzytN6sOYjxgMja/4ri0quw3/rSvoCDekWsykliRItq?=
 =?us-ascii?Q?AUmt9hXjLPakSTVMayDu9PrC/yaZCNPYbQEoVuTiOVL3pdseh45axcfKChqf?=
 =?us-ascii?Q?foKDTkIXo3qeMxq33xk4fTvWiKgQGtB5Bnm4MqqotZztG6wpVV2fKncJri/7?=
 =?us-ascii?Q?LyyxXEuQ22UyeDPx+/gQjNiG9N+GlPe0sSSKuCtFekMn728M7JzXuGm1626A?=
 =?us-ascii?Q?M3+YoGQiJaX5SuMKyggX7Nt+KC8HJU8lEG7WBsOvgrYaQeEtAEbwJ/zgZTn8?=
 =?us-ascii?Q?9L3ofcyjCHcUQXmeq/33jSYQUdJLAhyAqrLWHeoS5mZ9vM8VBzWFDXR9Ql+b?=
 =?us-ascii?Q?6eLx7l5uBgyMyRfOME6LvsK9xBFFZG9uOOUB8cYyW9ykMbJdhr+NPBoZlQls?=
 =?us-ascii?Q?LCVofxtiJhUhUrZ5eCIdAipTeAhumPA2oRDxMvQ85dJhNDGwITCi/aakAhUA?=
 =?us-ascii?Q?u649mwr8HrlCcG3ut/vH/+0cwGPXoWvIUU6P4S4AO7rcYp1gH9xhPlZdC82H?=
 =?us-ascii?Q?PuMUr7mRIGhJ+B1ciS+vCPQkyBPGFBHKYUVOPyE6f4cB6udj1miGBpFkBW/B?=
 =?us-ascii?Q?hKvNwROME/tBBqA7VcXZjLT6/LozAIU4Uqhq2rGFmpanyGUtWWzljUtb74oB?=
 =?us-ascii?Q?P851WCHEYYoaAjp3ftXy+VAokItWB/Sel/S97oAFtCkcHENXT0Qj+MiGsPac?=
 =?us-ascii?Q?C2RwJ5f4bUJTGDI2PJAp2mrQtBiWObcy0azXVO/lSsCBX2ZjigVMmlbD7gdg?=
 =?us-ascii?Q?U7rND9KAgDdG+7uUNxT12v55XU77d4aBC5cw2BqMb7afvJmvxsblHQJTGfrH?=
 =?us-ascii?Q?f7TyBSgOlOl0En1N6Jd77anz7ezFHYeY4qrLen49j6ogdNZ87AwqmNRFlWii?=
 =?us-ascii?Q?7RA6YAlQ/ZBFv52hO6qvodW5LHyq4iS3EyISY2x9v02AFnvBJU8yZm/PfLHv?=
 =?us-ascii?Q?1m9Z72nMlroi1zO/hL5mFATgYmzXcdALAErj6IyHipcuWqCvGByUt6kRFV4q?=
 =?us-ascii?Q?ShqnQwqs+4hNpxraHX2fR+8se2qscd1Vx0HgQlvG0wEu0tFRNxegD/QcH+vZ?=
 =?us-ascii?Q?YHOHnBCqNEzWv3PNPvmSgfT8sRz8g2RI4rJOibVXNIYbxvQT+ByrVk6j6hVy?=
 =?us-ascii?Q?k3sKq0tIg4Alw9N3plNJJJ+XZgazILm7O2U24SMAvDw7ynreLcduoTvA1Vy+?=
 =?us-ascii?Q?JKpclfPsNh/JKa/ejoWDlAq5ljhpcByE72ny1KFQcv39dARxrw+bqkvglqt3?=
 =?us-ascii?Q?UCxbOUCpfVsQpMDkxDLKgzfechwQQIoxQugbUczzDNTWrwX7N81gtClp/gNb?=
 =?us-ascii?Q?23lkuMhPit0sIEMW1ZuBUY2uf3tijmDDxBx/Ce+YUAjsGE02XAyNxCyBTE5Q?=
 =?us-ascii?Q?vLHFhPfbfmziBs05CYuv3+C7A4JjHncVSs1dVD5ioVIlbmkNZHS2QExC5Ulj?=
 =?us-ascii?Q?rMIibamtc7JBuvHPR4tpakE/A6EcmWHKI7G6he+umH5nv48iVdvZHHtWsSwQ?=
 =?us-ascii?Q?bzorGDWe5UaoW8G162UKW9LW6lpE/VH9ZYjJMhyWu76kyzsSuHN3owl29I9g?=
 =?us-ascii?Q?07Na2+yU4BpVTQOETCQe38ENSmeTGtlAD5uL4Aukk+fkfJU9cMWT8eWeauBM?=
 =?us-ascii?Q?MXJt6qLIbzKO7KPcpVni4kMqydhJcoz7G/n7nsABnL5pp2bi++NNIcnmIjst?=
 =?us-ascii?Q?ZwCG0xo2ajUj6rVik6rmIWYfs0rFOtc=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693990ce-80f9-435a-c6f3-08da246fa9ac
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:03.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMFHQggJ+bxqrO9aakVBDXZOOYpHjwr7OjOxggf67ZDbFmf8OLrsBwCJRlA8Qs1j75QffM7THrf7N0c23OxjsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TA_PROG_SFP supply must be enabled to program the fuses, and
disabled to read the fuses (such as at power-on-reset). On many boards,
this supply is controlled by a jumper. The user must manually insert or
remove it at the appropriate time in the programming process. However,
on other boards this supply is controlled by an FPGA or a GPIO. In
these cases, the driver can automatically enable and disable it as
necessary.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Mention "regulator" in the description for ta-prog-sfp-supply

 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 54086f50157d..c5d7375b840a 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -32,6 +32,11 @@ properties:
   clock-names:
     const: sfp
 
+  ta-prog-sfp-supply:
+    description:
+      The regulator for the TA_PROG_SFP pin. It will be enabled for programming
+      and disabled for reading.
+
 required:
   - compatible
   - reg
-- 
2.35.1.1320.gc452695387.dirty

