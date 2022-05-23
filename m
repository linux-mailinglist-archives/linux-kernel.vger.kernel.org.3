Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7C5309BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiEWHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiEWHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:01:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0709.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0760ABA;
        Mon, 23 May 2022 00:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsEnZEMqvBf6CPTP+rO3emVIUSfTkoEK7DtEMNQ+t8p1H6GzCQN0413J2sWXONk6tQXfUN748S8L4Eo1588lsn7/Cg6ISRBcbSqh2MY8W6HNoQW5yV+7OfhEmLU2GWFVEWC/Loncsqt11g06p4/2RsA85b7GSM2qGVqEq+nVKkFLE08eI13ppyP3Wo3WROXeL7wi4OuzWU2QP71px8KKYYUqS64IJLDiMcktFWSQuQDEDGcKFujCZnYkREZkYZaQbT3L8PzoamHYXSP9owJK1xtBXDCFHV2tfOMaSCbYkFnffvKWDQG+6O+2ZbXak/2NBhh/xCR4LrlKp2tRkWPxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=Q3auCJHa2GV0Ti/CcZt515+x1fjTYhWYwwjPdqgN2oB11epqJTkdq8bSbqG8KSweN+j2qwQDxX2Zl5sqZNtQJoBqHnc9COfFu6rdsvG5UmYdpUYemmyLL2wqJpuq4K9m7j2VAtTDgDttFv2dPYUn/bUToNCYK0Q+TBF1MDjLM7kzADuo47959LRsDq5sN2VtIAq9s3bmL2hw7jFpHG6gg+t2jdlx+x33zaCuoSO/vYXJ1eOzlEXxu5liSaZBUCZzJzd3YrVfo4t4kOjvEmxALw2l7RUk3KDRoZO3a6T+oENRgCQ6TfVU2NyW+mYHVgn7ByAZf3Yc4TxqZqEOq9e5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=GtACg4SosHPnvwTZ2e+8n0QlcJci5cOzaeoye0CiayFAyVWiJqVJSXZT1DuoxsCoz8PyiZPmb/zxqKdWR/3GNW3erT5tlB0qz/O+28JpxqB6gkGQV1EJjk0dyQlyVQhdUcRCnI6B3G2KC0Bn1rE8r6kXFkox2nnigLKfWmuBIs4=
Received: from OL1P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::7) by
 VI1PR0602MB3599.eurprd06.prod.outlook.com (2603:10a6:803:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21; Mon, 23 May
 2022 06:23:17 +0000
Received: from HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::9a) by OL1P279CA0056.outlook.office365.com
 (2603:10a6:e10:15::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Mon, 23 May 2022 06:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT087.mail.protection.outlook.com (10.152.11.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 06:23:16 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V8 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Mon, 23 May 2022 06:23:08 +0000
Message-Id: <20220523062312.1401944-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d5b592c-cbc8-45d3-009c-08da3c84b942
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3599:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0602MB35996E2B77D5AC990A1B665FD7D49@VI1PR0602MB3599.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDDiZpscahJbvcyz+i8Mi0fBbqWbqpXia/0VwLB/Nh89SFmGY7UM8IwcSNkxGxJNwjY8O5dyxhxRLhgRlX6sj/Bo0pPLMYNC03Onek2zPdi0hpAO4098oqK1MjSi39TTXodYpDTEDdXqSnHqUT+4+vtO+FC/MOTc0o8du62qr/KGvfqygx5GzpojOUsNGr3dyNvJgaOvWMpuQu5jhHbihxO5EIPL4KboapzDRIglX2hdbnjLjx2ElweH8SOCMJJhOENUUDqnXYLTbGRRVDEUuf4QVtCsriv5tr2xutCpwmmAx9rjNZfl/7QZO0U5GInAkV9Fpd2ZvhCBnaE97XTfdXI0CqC/94HvZ6TDvZtXoGyDsR+eQ8fMyrD1I9+0DuVckCy8sdOwvwAnXzmV029v3HH/5GAYMq6KVaR0YMQQK5oWszXladVg+x4hvWkpx4Cx1NiNeigZAS+OyEaKYLBf+T5pONiKj3A+68z6xlrokpVuThskUi0bKoThOwLDYwcsr0/c6xzoKND8Jevzj2t4nXA4nM1nYpo5hbbVNa/wZEdWhMLr9IQ1KP1/u45aNycv4N1MQ2NYdBMb4Cv1fn1fZv2u2gTHstdPjs/UsspTeb+Eotb3B4JyLPxvUkHWW6X4YCTEunuZYA8uYLdl1diDtrADhi7buaNdi8e2zav9+8sAtxs90R9hq6ze+W02J+lh
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6512007)(6666004)(6486002)(6506007)(26005)(356005)(81166007)(508600001)(36860700001)(186003)(2616005)(956004)(336012)(1076003)(47076005)(36736006)(82310400005)(5660300002)(4326008)(4744005)(8936002)(70586007)(70206006)(8676002)(36756003)(118246002)(2906002)(40460700003)(316002)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:23:16.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5b592c-cbc8-45d3-009c-08da3c84b942
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

