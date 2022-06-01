Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23C4539F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350530AbiFAIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiFAIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:09:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9F1C10D;
        Wed,  1 Jun 2022 01:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGGH3CRhIEMPQo1SK/8w8Qttk5DugNJeqLusgEgsRQ9BxJes8LMlkGj10iQ3l/y/8pgKrHhTHu/2LyjT8rNOdFE2CbE97ngPTp8N2aOmoPb9m9qzdnkW0eCQh6g9oby+UGmd2Wfapc/UC+RHcc8fJ3P3F1+sV6nrLEWNd5LxNVVvD/7Lqh+TUzbNb31GJuX9GuslYMfS4lzp8keHVZttqfcE1CVfWaQrLoi+FpfwkezFqdY0wE1iZcR1ctKNxe8zx2vSPY30QF0djXP0uczXzlsVk1J35N1c3GWwziwNInpc9vh7pmWZG5IUMRaCBBQfMmxsRR5yDSpnz8miZKoygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzD18PMVdgS8MLkO+C+nsIPU5G44iVHqxmEiaDwsLdI=;
 b=K0ZoNWqAYmOGbpQ0j3n5z09EnXU1eyiBY3AAyw9nSyghiXgt7zDP9UQHVuqA3LYj/T0daw7IgIpUjh1fBgQIPfciRaizUvZp8ZXV+xfelPCnLKj5/jMvo7wCgihXYiFn358JZb4n4JALJEbVee2V7FHL1A/DfAn4loBw53MWdbz5TObRjFU5L8Kd/Oa7FJgfFkrKnGMr7Pud9gurHrK47qcZR7SdKsAVyX+maR2Ts+qHYNZKAuhqwOvVmMmn+EluPMQVCKPRj/8mx6QLXZo5jgiAeFl0gKtb3FfzxKmUuu2d+tzFzBX8J7x6YkpQijfI8vAtqfZEYO6G5j/bV6RE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzD18PMVdgS8MLkO+C+nsIPU5G44iVHqxmEiaDwsLdI=;
 b=CXh8Zd+islH3JqJan6rDgz3ERY+E3TCIa5poiXa3X9QFYKXIScOlcVuSzxcqVG16B0YIJaU5YnzmVUs2Go10MPYbMs3qZCjXaojcaRvmDX3WfU0x74ptIp4a9/y0U1JZbO+oyadIcKl+jiIkR+692tSDsxPFVRAH42O5Go40JSsdZsZnmRvy9kOlelTa/can+XDwjHd2ODHUybN57EA1KkVhudPiIangjb8C09wR3QTe8MMtRy2ehYg29NF0dzV1wdBStICFzwOV6kejt1brVtFiK1Iz3zPGdu5m6h8GAt/6cu6cf3u5lotaSPeBKzJfiGFI5K4XMzM2645oRcJG4A==
Received: from DM5PR19CA0032.namprd19.prod.outlook.com (2603:10b6:3:9a::18) by
 BY5PR02MB6226.namprd02.prod.outlook.com (2603:10b6:a03:1b6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 08:09:17 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::80) by DM5PR19CA0032.outlook.office365.com
 (2603:10b6:3:9a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 1 Jun 2022 08:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.161)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.161; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.161) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 08:09:16 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB02.corp.JABIL.ORG (10.10.47.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Jun 2022 03:09:04 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 1 Jun 2022 03:09:02 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <ben_pai@jabil.com>,
        David Wang <David_Wang6097@jabil.com>
Subject: [PATCH v5 3/3] dt-bindings: arm: aspeed: document board compatibles
Date:   Wed, 1 Jun 2022 16:08:55 +0800
Message-ID: <20220601080856.1548851-2-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601080856.1548851-1-David_Wang6097@jabil.com>
References: <20220601080856.1548851-1-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e038ca-af96-414f-2cc1-08da43a605d7
X-MS-TrafficTypeDiagnostic: BY5PR02MB6226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB6226A6758BE472CAE4BFEF02EFDF9@BY5PR02MB6226.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ln6MvkwdEAS6qJ5qCVJioWTFde81vvuD9QgkYvcBJIPVdEBXBfQc52mCb0QoZGTAvchGbj0R78g97kbxGi3R60jVBxho+iXKX+cr3WA+WRBGxcBJkTTYaTIuxZ8ZmiwVVttM6g2VLLuNkaBjq7tervcecBUyfs2TSGiL2EqE93hllhvpc2/xNooZ+hSm7nMSTy2jOt8EEE8Df8sE68nwxOXyHhSkrielk3h5vIUYyEs0k1ZSlQhBE8u0d3c/XqV8/yWhrujz4+MR6b63gIz0or/FWaFHI++ctFhkwcrZuPqldXKoOeicudrfgm0VolSl7vkTAb3brq7X96XgyzNKjSK4y7LeBmP9VZspD6etZ3rQBj8SLAYD32PGK2i6lK78SeHnqi34kNCo0R4sCHtB1rE20EwjEHuklhAWsaHo2O6TMI0Vw39OLfkcGtLtJLoUhUoZ2KsSzOw61rLeVnlSqDxCsJbkDSl6inUsgnLmx8tZzjMH9HUWJbq06rwYAW8aew2hVu+r+BV7sKrvGVcnXFjG4vm6K5IzUA48dIgS+XIS57VA86UtPRt9XHOd/LLiKZxuId+++MnsgxGMQ9yoYnQjQO4SzGs+P7+WvfMU1FTtzr9GbgsZEaMxGmyyqoySO9J2pGGg+G2/br4CarGpDvP+xkqkfX9GAqcE7xFF675j3MCvIIpWjL7DGZedUwzliO/oSInvRO++W6VCRAMW+g==
X-Forefront-Antispam-Report: CIP:8.14.198.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(4744005)(2616005)(36860700001)(26005)(81166007)(82960400001)(356005)(47076005)(110136005)(36756003)(316002)(336012)(54906003)(2906002)(6666004)(40460700003)(86362001)(8936002)(5660300002)(4326008)(8676002)(186003)(508600001)(107886003)(70206006)(70586007)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 08:09:16.7185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e038ca-af96-414f-2cc1-08da43a605d7
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.161];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Depends on Krzysztof Kozlowski's Document Board Compatibility Patch.
- Document jabil board compatible.

Signed-off-by: David Wang <David_Wang6097@jabil.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 5c9aa014432d..407cfbe85153 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -78,6 +78,7 @@ properties:
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
               - inventec,transformer-bmc
+              - jabil,rbp-bmc  
               - nuvia,dc-scm-bmc
               - quanta,s6q-bmc
           - const: aspeed,ast2600
-- 
2.30.2

