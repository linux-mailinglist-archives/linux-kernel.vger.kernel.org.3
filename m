Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83055B03BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIGMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGMQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:16:38 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2129.outbound.protection.outlook.com [40.107.104.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44EEB7753;
        Wed,  7 Sep 2022 05:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd1EDrhOYdleXZUVFkLaMrhMyPBuq+NR4qKo9wrMT9+K605yOdcMwfw5fG/a04Nc/+6DgmWCTLS/LL8uGyHMEAHGjXY2cFgAK9RTuZjwU3AGtWq9Uj1eVxlSyhtaw+n853dwlFnqU/0V0LMch/WyjhsrR7zAuZHKvDDkBSHcriSm55YfEVWVmysToG4bEGkjW//gjQlXXOVGe8e+4v8X5MroAF3DyhufsA4feCjY4Wu+MAcSjKg+jyvhm7/ZHNmYv87AngQqCxEsqCJyGhrtL9y2djUWve8iyOvC0t+J0en9Obh39CRR3lC3lClXPViEdQnOLPxlebe714RylwOjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeqoaIoW7Rso5zUg3CjePLQcE2rg4WtD8XMXcCpFNws=;
 b=RgbjnEfmbC++nHo6GL6T/Jzmcp+Y7DpinmmAS2VRf+vknBjxjFGGjWoUyCqTWufmaViJEKac+erhksGkX8sn5Ocdw2xV49HCB8vY/dZhVFh/XlJW4ZrLrXxCE283Mg3GWgApiMUURloVrLcIibU1YFO9KBCXsUoF7YUCy45BzNPiEQWq+4+H1jsW3fOmjFXn+AOwM9x/Vj4+TKkc46kyVCJ81WaITpan2wc8UkA895xyGSq7sseNk1e0HxYKlE4r8e7ZsKUpzGKxfLh5vYrdQKcQV11aNUl6tIeBcYCWh1O6y9cD3I1Akm5LCuXxkNv6E7iEeaP0Rk2HiCdRQLYUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeqoaIoW7Rso5zUg3CjePLQcE2rg4WtD8XMXcCpFNws=;
 b=Zq06+bh8BUbqNqdnb+CgxxIfZdvT7ctyj9M8TlWu+J2lqRXjf0xcwH1uo+CFN4F3zWDDdXeau44gU9un+Vg2y7xcJ5GIUt4kVhkesgE9+5z1XW4vFq5+z5BAGhplmi8+VROXQ/ft4/vVAf0ZgtvntKtPc5opU9NUNM8+XRXinvc=
Received: from AM6P194CA0032.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::45)
 by VI1PR07MB5488.eurprd07.prod.outlook.com (2603:10a6:803:bb::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 12:16:34 +0000
Received: from AM7EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::eb) by AM6P194CA0032.outlook.office365.com
 (2603:10a6:209:90::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 12:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM7EUR03FT015.mail.protection.outlook.com (100.127.140.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 12:16:34 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 287CGWos026061;
        Wed, 7 Sep 2022 12:16:33 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] of: irq: Report individual failures in of_irq_init()
Date:   Wed,  7 Sep 2022 14:16:29 +0200
Message-Id: <20220907121629.54330-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT015:EE_|VI1PR07MB5488:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a66ca8c-0a13-49dc-4e58-08da90cace38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipMPPK72B70WrTT4EHDheBoGLcXe6P7mJYVB09aqbiJSz9QDsC3CzQsNkkz3IyLpkzzaPYfeXevE8uyvQCNHBlTWL4Bjwj2PlS3X6b8UdBObue87iFp5XO0z5xXy/oPltkUvrwTuBN7CE2RbE7wEwImK+NU5TWsg8PtiKe8dWd89zqQFuPV2ZQBrSwXC/aOUIgJt8NAQi+y8JBSepANw9Vlx3OLdRuEFz0MmGeHt+gBEAejI304M4YUKQyDVoyFCnxncyyakiReaRc1nHZIHcatzjT885Ayz6OnG0tbQcKhPxhiVt5PsR7LizE4w9rqGqMx6qE2d3rKwEW0bI86QpC6lEWIcpTeAfdo3K2o2HviA3SM2OkJuk58MwGpqnoKAdjzrXYOWmzZUTykV+tJEOr1NISymHKGKxwkbDSDBiyw1zXen7gGqvHekkEYQG4W9HoJYXOq5paUxMBbIRphW4jrG84zUE+fe5yEIDe3qK+g6WGPV0t6yZmuqiUP7kzAfDslg5l/GESuRLAqIQzfaQjaU5IVhUHi4hzUk7ZXW4TY1JSjb7DKXa7KH7HueQp86z6N3a497Kr4fviievxzPdXYvh2MpMil14CqKXl3W26l041l4LTXv0H//VzyzuNOeS4Azt7S/lWgM23U6aK0KGahTJoj2argJ9jksahfT/IvsgrhGwqJim/e+YHcYXnX2MgbBU0G/wmJUTHb+J8GwcghO5Jka9v198coKMDhU1yJtH1rKP5r30nA/TcfVvtWEXf8EyDMx1ACslxKa88VR/Ze/zI6ut2NDjg3iOgnURHAPNToOsy5jqu+85vD3h+C3HFHqkUJWIRl3rCl5RTJgfA==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(40470700004)(356005)(82960400001)(82740400003)(40460700003)(8676002)(4326008)(36860700001)(70206006)(70586007)(316002)(82310400005)(6916009)(81166007)(54906003)(2906002)(4744005)(5660300002)(40480700001)(1076003)(186003)(8936002)(2616005)(83380400001)(336012)(47076005)(478600001)(6666004)(26005)(41300700001)(36756003)(86362001)(557034005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5488
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

New pr_err(), a copy of preceeding pr_debug(), faciliates debugging.

This change was inspired by a long lasting debugging of the
octeon_irq_init_ciu() which fails completely silently and leaves the
interrupt controller half-way configured which in turn had very non-obvious
effects.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---

Changelog:
v2:
* Kept existing pr_debug() on Rob's request

 drivers/of/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d22f605..2bac44f 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -592,6 +592,9 @@ void __init of_irq_init(const struct of_device_id *matches)
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

