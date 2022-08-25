Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B15A1B33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbiHYVhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243855AbiHYVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:37:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C3C12F5;
        Thu, 25 Aug 2022 14:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSTXatUhg7NsXSHWclI3auq7QHfXihesE6yVJYa8NWpTgSP+ESuzeUIKMtnnHgWzUWhJe5Urqg1gmGAK2uW2uFI2wOwciqO5HsZ2ty4AJDNmE4wKvS0Z8SRy6XmB6byk0s9GG0tYQ3EXEu2WoZixOAJ1dSYZaxUbe//0773Jnb2SDb5jAUV1ylLSjPYnQDw1awHeuJ0sbY9Q1VTJUAKyntzv+JWFCfXqWZTpJDFrOldJQewAv0Wa7NEku2RWiNBfwweTZDNhCZ7zt+Z6hkugfHyh4MZn7g3asu5erCphWvALjJK5zoNzeeVUv0+bYKGtj2au021Wr23j+vOXhGNtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTwT5s0tZeQbNWvkPN6C/RZcxbMnvshdeOWLI9ZJ0Hg=;
 b=l4MhMbiuq8TGTCYolbcDJpURGPbVpWDQmeKyNZBRavsWA0R7xrXuBX8pmswYHRXAvSRRWTX4BMnRpjpgsIAsKUJSEp38OcP1DzRr2IdzoAYYbrQzCbWLHvIXcVNEl92u2HPpy7iDv65n6cl3/Xv6URXKgn87zUVb6WbBiPKPEZ5DLWyPD32kizo39MBoOeTPZ0AapbkvleNl5WMh7F2106Ey6Kmndw9/dJP9WEUGDvuMgRiySB1IxDx6SLm/pymH1b6lPSb7aeLlrJxz69Cvi6CGx4xsbUXgbupbYgi/okatz2PKM34vGvuVdfKf8ikQzV9VrJmohYkGMDW5/leGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTwT5s0tZeQbNWvkPN6C/RZcxbMnvshdeOWLI9ZJ0Hg=;
 b=g5iUZo8f34zHkJcVE/cIE1nSN6MciKTsIM/bH/KJlw/VOrUrsEfQgawNYydKjfJ4OBpkoPvhY7yWluvAa2kv1DYkcl3QUL2pMcdGxEu2lI1/sVnv9XeAKEbLJhQTzC4Fi1Q36q1Xm5rC9/riJPtkjGtFP3GpGvWOSL9btOPp+dPX6ab2g4q8bA7G/uaPPPdBki5Vp9TycS+zdyj+jPR2Mhv6sIpFDiZSxG6anoOfMR+l0zMzI44Ppb4TL40i8gl4fKvtA7Kv3ydPxcE+lezVxKBCoI+NapHTXgbW4c70IHS5qAcRu+ssHMjXG0dTelekKyLYy/5Bl6woD+4Erzqp8g==
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by BN6PR12MB1700.namprd12.prod.outlook.com (2603:10b6:404:108::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 21:37:47 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::fe) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 21:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 21:37:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 25 Aug
 2022 21:37:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 14:37:45 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 25 Aug 2022 14:37:45 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 1/1] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Thu, 25 Aug 2022 14:37:43 -0700
Message-ID: <20220825213743.18313-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df62fd5c-626a-4efa-74f3-08da86e20db7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okJUCMWGa4U5NKMF5/XhcXknLJFbgcDG8YNzbjmlEDmDyA0tjKqAJmsinNwDoO1y4UXr9/S6NwcslWcwjyrEP0otMRNXGfWrMZ2Yu+xSWE7odS/RkLKqWKsqF3C7urJO/JR+pvExBhxNEdVg6ZlOg0IRXR3XxEMDVpG8NAm1VyIwMgwQwChYIc3ic5SkZBoD7e5qEB4SHTQowUbwNkDXm7JSzSMmV6+SeSjQCG8GKY70sofLTMDuED4V4n04UK71VfGL9/Zm8T6YHkMCLImjhCn9FnPk8ntHNACVyD4Fduq8Qbmpi9NwPGq82xYR4iTz6ufTiW9kC2IsOAIf+07nI0pYO0Q+ZjlXpVZtJr7hzF4cKlXs9q0KdJNyzJTro5zpTKELWnFET4RrcEz/8KIVooEPO7xcyRipXXxFZO7HFCT+t0KJsPbjckKrMHBVBx69pYBr7jVvhzj0QRolC7dirziOxm5GjJCwII1xn1/JQrK8UBIKlvelFPBxmZl1xwWWsoyw31q+N27j4oudSlAlKaGD4hM9BEIinEpUTYIwZgJ9iUa40A5FoKa4FGDb6Kn0eNRVI/dcJ4f4Xu6WCL1rcWeaHYcBFq54atGLsjKDELaYXvQ4jjZ+TJZEFQK9CSHF2+wXcpASSjwef1bMJ/UxsnwF6QjZb3TPlg83vfqoBvrerhrLJJf+K3E5gmuH/xxci320mUVTe7Cl+yazymBi+NriNtC7wEO6Kist+l0Km+NUx7L/d05kMaby/FGRIjag3EHIEiF0a5I6TCe13gCz7nzjcYzIQJIobwD0N59FQNCCUUyM/r8CaH1jJOCYZE/r7fWCEb4Xx5WqlmS+sDwJxKS8H8/VdS4u1vpPyysibterAia+EL36wf8Zi49EE6XP
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(2616005)(336012)(26005)(41300700001)(82310400005)(107886003)(186003)(40480700001)(86362001)(7696005)(966005)(478600001)(356005)(81166007)(40460700003)(82740400003)(1076003)(426003)(47076005)(36860700001)(4326008)(8676002)(110136005)(70586007)(70206006)(54906003)(316002)(8936002)(5660300002)(36756003)(4744005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 21:37:47.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df62fd5c-626a-4efa-74f3-08da86e20db7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tree, mailing list and patchwork details.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fd6a1721e69..b97cfb7d6fd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9326,6 +9326,9 @@ F:	drivers/input/touchscreen/htcpen.c
 
 HTE SUBSYSTEM
 M:	Dipen Patel <dipenp@nvidia.com>
+L:	timestamp@lists.linux.dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git
+Q:	https://patchwork.kernel.org/project/timestamp/list/
 S:	Maintained
 F:	Documentation/devicetree/bindings/timestamp/
 F:	Documentation/driver-api/hte/

base-commit: b5d939c951865f6fc229094e84b77c9a9e0ed0c7
-- 
2.17.1

