Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D115251CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356182AbiELQDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356155AbiELQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:03:21 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20105.outbound.protection.outlook.com [40.107.2.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B36223B;
        Thu, 12 May 2022 09:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYtbg641bVCQ77qbxgt1x8RL2MTovv31fypR8fsrF69ILwZ0OFUvv+RJrOZ7FgBYr2v1XrYwqPm33wFF2CaafaxtoumT+0RK+HAPdsqtrPulUWN2kMMlytE1fadmmQTI0J3z3EbCPB2mCsyS50QaUyNwxZoR+YWdhdjUWkHFDAbtcNsIgdnoydL3LlAqXZ45nDMi5C7sUTkiu6LxrWYDrQeynRtz9J3o9qAFmOppdrYfOsQMTzbY0577sQ5bltpVzpKb99nLbdBzpJc9ZEWKVwq01WlZsYk0mHpJNdS5udVfBBnRIq6+lkXw4K4eZ7f2jioUaPabbYoW/YVTpiqPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=e0+P5zp6uwUbQ+1fjtOOcTuxGUyESkCF8wN9+F7eIVYs6OKw1ttXrxGJTxS1YKxpDTs6sRqW8mDWzudEq6zYECigGY/AEZ+YZ6oFzdGQzoynh7RIGwZMhXS7naN9Za15GEAXkzQZacLTuAGIJPoV3Voo3GfO+6iFtPALGK/ukmDQLYqETWvnyiE2gqu92VC4yTrK57wtkaysGQv1vnKENzRy0p0tYTL4Ilcm3V7CKqtQbwktRroE5nLl9OhwozjeOl9VttSARM9Quo+DndiIr7fDElp7K0bZjDSShmyUtnlclyPk/PHtsrDRxmlmqPiIPioFpE5A8HrAGl1GC1VDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=cAjK0Z36lq7lMGuH7hwOncQ3Wn8MOI7HVtK5SM0C2yiRzQ47eJXqJOblXWEWYV6X2hdTK/lgqxGT1bbCUJj/rI/jNDGNBiZ6HUI/KGAnNBesFQ8fCuviRdEhSdciDs7tBRrPN3YuWFqfJ1rzMGICIe8cO0N85Ne89b82ievPAPQ=
Received: from OL1P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::12)
 by DB7PR06MB4506.eurprd06.prod.outlook.com (2603:10a6:10:21::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 16:03:17 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::74) by OL1P279CA0043.outlook.office365.com
 (2603:10a6:e10:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 16:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 16:03:16 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Thu, 12 May 2022 16:03:08 +0000
Message-Id: <20220512160312.3880433-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89ca4b6a-f9e2-4299-6612-08da3430ed38
X-MS-TrafficTypeDiagnostic: DB7PR06MB4506:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB450638CFAF8ABE6FC4DA6C7AD7CB9@DB7PR06MB4506.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEiz/UYllkVuuzGhird8JfZr36NbJFTsqYsYMTl6BgTNBVVtQ2SdzATKGj+f0EoUoAxpUXpuI7l3HPY2ZKACxpW0ohA/mSXg2rAMzanG7o2kObhLHD3g4aJe25m++epE4bRFTPFqy+aLl5/FTCw480aa3E0FQp1j6BsxiTitFli4RW5eH1vu4YVYzXjfrxoV5si6lFUNdWGcSl0QVTZnxQkE4a1B87hAxGmlQuj3swyir9ZOd3LAle4AiOxL03q5MVRpUqBuMPjJs5B47qyKE/2ZuOQwX6m0A0JA0H9Dv3Qraey7DiRSDS1KhU5bSabbpKZjXEew+fJBtHozPfScrhPD4igsloqQIi0kxOHRwrwg+s7aK0dwiLOlHv3Nunhp7V0Dt2j/jSobJZpzuVXtTuBhPNLFlKJTffjoR1vpfblYobaIGlFy5K6z8wJZa+3zF4II1ek3sd3ZaGtclwFS+MDS5fEmh9rSGER8ew/I1PCRIJ5PxXc61Wc74Vm8CtJcmLqqkYpK8RH7xhEFnX83YcjNKb8dwvVq5lnUfPkkPL9Fe+/xCPoolHw1AZbZnQm0mThzFJufzF1JUX+4p1rGi7FfG/pOj3Yc6eeAz+yrr8li30IBeQOAI6qsVE9oQyRKZ40EI8Qs3NkzSLdEwVcJdCEYSjCNbhnu1s/8GCdD7tNNVnp657PbLK9dTE18fDGv
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36736006)(316002)(86362001)(6506007)(508600001)(6486002)(6666004)(81166007)(2906002)(356005)(1076003)(5660300002)(26005)(70586007)(70206006)(336012)(47076005)(8676002)(4744005)(6512007)(956004)(186003)(4326008)(2616005)(82310400005)(8936002)(40460700003)(36860700001)(36756003)(118246002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:03:16.4630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ca4b6a-f9e2-4299-6612-08da3430ed38
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Murata scl3300 inclinometer.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
index 55fd3548e3b6..f6e2a16a710b 100644
--- a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - murata,sca3300
+      - murata,scl3300
 
   reg:
     maxItems: 1
-- 
2.25.1

