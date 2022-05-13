Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0B526233
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380396AbiEMMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiEMMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:41:46 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10133.outbound.protection.outlook.com [40.107.1.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E736322;
        Fri, 13 May 2022 05:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OloThzCxM7KN7nHHoI4C6bYsbZ/rwUPEc773F5cu5bZ+c4xFx0HYItnYpYTGSADgcOZYlNhr5KGsrUgCE05eDuVCG1UqDIruXmw0DxP85yxBP5q4Dr+8sIURtEDA/E7Vex813h+TnUnt/kIFv+3mK9iXWI7/grtrkfsjj/11aj+N5bDmVAlA6gXpFPqWyQdoMEBUHPh9OZyr6hpqVBp7dJJ8gFUeGRvVDRSluK6gQ1fNnKLodZy6HtHb9LGXI67O7j+Kot0f2IzzGulNmNHu/ADlVqR73IDXQKHAnTAam1lihpNbBfvnQEpo5SBTNhL0ujC8rDNcBCaEE+Xe1QDimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=JMsBbUJm8EM7Wl/GmGCGCxNOHllfCwH2J8mqmiyYt6af5Nq9CtOnewhfrNO/e37vMLf9L0hYsU9OUTzbAMf/inXQU9n5r/SYvog/DGj82z1zTmS5xkaiBCkf6R4p43RV5ecUxYZjAIqISMNjlY44HCoZzXDtrnOeRCBA9AivqY5j19UPjCiQ69gTQIEk9KwSdL2ZZ1QVWT99qEVNEYBmP+QUuOn9JgfFGlfu5N2/Eb+ZfC9fLhvF6gGIbvYBgqpV/wQjRoU5GVYPs7sPYGTEIyzmvh2Trwx344fIFELQihQq1Gx/FVaUw0LbGqjRtE8g8WovGQSsBZX4X/0jK6IjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=SFEov4PFx5zx+M9Znn6SETybV8+0k+b4kAjD2CIzXR88BfInUkjzN7x+yq8LIlPeJYpKIdX/YLNVJDlO84t7IKi6rn+Uf3iQ69o4NVFaMJWkUef7RTkvLTQI8RpJAH6kB7Awp4ZtE0IpAs0rRZJtI6Qv4yIxd6dwMyzB3BJ+8WE=
Received: from AM6P194CA0105.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::46)
 by AS8PR06MB8120.eurprd06.prod.outlook.com (2603:10a6:20b:3c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 12:41:39 +0000
Received: from VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::42) by AM6P194CA0105.outlook.office365.com
 (2603:10a6:209:8f::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 12:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT036.mail.protection.outlook.com (10.152.13.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 12:41:38 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Fri, 13 May 2022 12:41:31 +0000
Message-Id: <20220513124135.1295822-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db6415f9-1225-41a1-d92b-08da34ddecc9
X-MS-TrafficTypeDiagnostic: AS8PR06MB8120:EE_
X-Microsoft-Antispam-PRVS: <AS8PR06MB8120BE8A92A64543F487BEB1D7CA9@AS8PR06MB8120.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFZXJ/wqz/gz/zYsgfuOujcuNInsKUUHFoCGunWl6z0+KbPFVNxDZZr+w0Cle/FYP19nCAJzRuDdPcR+6iF9Kcvrqw6emZZuIswWy1C/YmMBQPXgwgZT2vQ/+tVX+WXaNsmoLr8+c4iEXooIcr8h26SvAAHAzNkz+cinfnBFxjOLcQWqXJNd1I0YDNnFGtjWTNPYSMAjhgsm353giYBsNLXgG3NjUI9hLFTZgv9QiQ89Ax6EyvDxm4pki0ciusGLBdJ/Z+6ll/4yLp0ZeSL19vAM0zzZ+vzL08VAEZzCWRX4Qc66HezV54hoIz2tkcpvER25x51YPA8I/JewfiboDXne3Y+/uMqBw6F7JYqaYYZhQ860sKzIC3OWoMmQjpsTHFz9cQRNwSof5OXqDVOTYpgGeevwcJGFM21jEjMkN5Uas6z+HnNhGoMe4UHXmu+EyYero8rQCjaK/novNo8flbHkR3zQQAVekTltWaMzk76ISExd4tSSBHh/Vj63Ywc7xAp5c56IeQSCWZ+rbN1vc8+1AK6euOc64r0zjVvRhg430L7Y1MMw8Utj8Or6Tu4vqq8JtlDw5GMxTJmAy8fvmBrAVLn5ZWJ+edFbBLXDoPVKdeEMRjm7aAJhExBmqmISfmO+jn4KkyEvDBsaX9yDCYFEa0G8nzD/HtkKDAh7P+ExD8aRLpzZ4rJibZ7Bk3HS
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(1076003)(118246002)(316002)(70586007)(356005)(4744005)(2906002)(36756003)(47076005)(2616005)(956004)(6512007)(26005)(36736006)(6666004)(186003)(336012)(82310400005)(36860700001)(81166007)(40460700003)(86362001)(8676002)(6486002)(8936002)(4326008)(5660300002)(508600001)(6506007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 12:41:38.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6415f9-1225-41a1-d92b-08da34ddecc9
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8120
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

