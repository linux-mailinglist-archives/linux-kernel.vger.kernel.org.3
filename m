Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE95AE4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiIFJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiIFJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:59:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2122.outbound.protection.outlook.com [40.107.21.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67B220E6;
        Tue,  6 Sep 2022 02:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5LUCA6ooCgmOj+vUUW6aQT1phebP8IR3yZoBNlXRHemYYJj5x3//PWfYWXAW8T+jl5aDxzoRq32yBUCoEirR0XdmapleshwjBXFAGmNhG3bod7iu8V0g0FvJTD8531mEmTzWlsP1lvInWoZn1bBUcvQyajl+r6VdKAtvg7VPeDiRc0W9CdoWls2jyalrkuL3/LzbYV386fnDtFH/+S7KlfFbueBmSy1WrJBEPVwQ+wPhHenXjKv8LrU6K/OTAZw+lEPst2zxH5pWzOHWsvCQdvFE4rb2q9YPqLokDFe9bwd0dS2nyiCvdCNpNi4+VZ6B3wNxgouxZXtiYHs7Y99CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qTdsNBB3DA3YjLALevkD2oULKMZ1/Cl4cylXohiiLc=;
 b=FqGLiyvNqPiVVZM6UbGs3JF/Wa9vl9BhN0KxXXyAng8FX1tjnqpPNP94htcU7vB/5wjRABbDJL7geWdzTYajGlLxFY9T0r5q8uMqgpxfGTXJ/9b5nHMgTyFk+9Q+BYD+KfxGuYeluE7rmor57yjFcqoCAzIigHzMRwdLeFGarxWTvBLpxR/Pgxfd7DBpiXyeORUEN9K3+GCqYRbR/D8DMDnDKzeGTbhp9O0wIf02J1OYbpY5KbNJL1/mWb3IMS1Nj4zZO95da+sRpljcGq6JieFc+Ed8QJtfjcYYeJRLmx+UNC2CkHTAhViJ2LRZiEpZv6CeL4HRLAexLNZhMrF+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qTdsNBB3DA3YjLALevkD2oULKMZ1/Cl4cylXohiiLc=;
 b=CcmQuQ72V8uRe38lRC2s9mdAdbsnPZVxEqLz7OT7XQ3t51W7pJQ5zCLYDRKpHjDAGCX1t/qOOJGcwTww8Lpzseoe59b5PkPDS363xQ/ABKa+U5c+l4n0tyEFtwp6N7b3OBa8lERw0rjOHHSkUTCy6aC1oNkH/Zz+IqQ4M9X8bJ0=
Received: from AM5PR0701CA0017.eurprd07.prod.outlook.com
 (2603:10a6:203:51::27) by VI1PR0701MB6893.eurprd07.prod.outlook.com
 (2603:10a6:800:196::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:59:52 +0000
Received: from AM7EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::cd) by AM5PR0701CA0017.outlook.office365.com
 (2603:10a6:203:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 6 Sep 2022 09:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM7EUR03FT033.mail.protection.outlook.com (100.127.140.129) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 09:59:51 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 2869xo1s000637;
        Tue, 6 Sep 2022 09:59:50 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: irq: Report individual failures in of_irq_init()
Date:   Tue,  6 Sep 2022 11:59:41 +0200
Message-Id: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df793356-c050-43d9-59ae-08da8fee8acb
X-MS-TrafficTypeDiagnostic: VI1PR0701MB6893:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ExtY5JXX9TjDS+V6HB6E7x41IOVzf6Ek05D9RG2bRs0E0dvoQgX4PD8gcXmlXAFBn8YgeytaLGwZ5VwGOtZt9lR3t//jG9uTVLuwSJ+OniBOrbXAldu55SdZwDZzC0sCypoX7oOHaj6mHNLlJlSyViQdEeIWexSIbYH0qcGnvPLes3bICJx8GWLfJkBVNjAgrk4LBuuykTg99/DDiD+PgP+OyVCkD1IeZbEg4sXK2UwfFiQueAHMn6gBMHjVGJHym4jGF+tK7Hy5OVG22PbBzdE1Z34nUW2qjBHWdosgoPy3kt3cyVCI9+Kp8FFoz8hNlEPlXSUPcpgJp6NJtD+Vwho1QIbbes55q5PfZKhfdYOdi6yv1b1z1OfmTTHy9ax5HUdsOycRcP3oamw3x4mlb3mbZmcZrlhGQPdgP8at0Pfi8D1GtaT6EB2RWu18TimKDLGoSoSxaksRFyA1zWGzvQ16CSrhCwzZf3v91xF3MGXOB4I4wEGUQHE09Y1hOIrPX4CELkII2nmK9bOqubErrzvnzAtU4AL/sX1vWzuSjdQlJfrGK3iwO+QdFWJJQan93p/9bVy1eeyxtJCDRf96ILnGsEZ4nKEIZzvIFJFiUgITljgZV/i1b7n4zhUrTbJFlLLuSyxKLlVYtsAkCS78SkMpcBk1I+Ozg9XUmCR1Y740x2c3/bIX4kwu5YZqKf7ZBEEoGQ3d7BKf891YixGa57eM71LtBBxKP1Pn1AD/9jln7/GA5QjBDVaSk5sB9Hlk0qGdvM1GRTero+aagdGz4lnh3eExrZSqKQfl6vS8WaqiU2lb6PtuDr2K2f1Sxk39yOA6v6eQfMRA9zU1DMpnw==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(81166007)(356005)(82960400001)(36860700001)(82740400003)(40460700003)(4326008)(8676002)(70206006)(70586007)(316002)(82310400005)(6916009)(54906003)(2906002)(40480700001)(5660300002)(8936002)(1076003)(2616005)(186003)(83380400001)(336012)(47076005)(41300700001)(478600001)(6666004)(26005)(36756003)(86362001)(557034005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6893
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Rewrite pr_debug() as pr_err() to faciliate debugging.

This change was inspired by a long lasting debugging of the
octeon_irq_init_ciu() which fails completely silently and leaves the
interrupt controller half-way configured which in turn had very non-obvious
effects.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/of/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d22f605..45e4392 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -586,12 +586,12 @@ void __init of_irq_init(const struct of_device_id *matches)
 
 			of_node_set_flag(desc->dev, OF_POPULATED);
 
-			pr_debug("of_irq_init: init %pOF (%p), parent %p\n",
-				 desc->dev,
-				 desc->dev, desc->interrupt_parent);
 			ret = desc->irq_init_cb(desc->dev,
 						desc->interrupt_parent);
 			if (ret) {
+				pr_err("%s: Failed to init %pOF (%p), parent %p\n",
+				       __func__, desc->dev, desc->dev,
+				       desc->interrupt_parent);
 				of_node_clear_flag(desc->dev, OF_POPULATED);
 				kfree(desc);
 				continue;
-- 
2.10.2

