Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2054E970
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbiFPSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377969AbiFPSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:33:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A953A48
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmVw01asISba9+uqESiKZc/eYlkMjndfohF1BPTXPlD6L7oPuJgMuUA9oNuJfH0pCG0Rhf7JfUdryBMs9O0KGiifLQI6ExRjxSjjiC/UMjYER/Cz45Iwl1Hf1Nsu8QMezvMj43Fl+gfE1NHh5aHt1RBEWnRdS5fhV+AaKoaOEY5HUEP7pvtqFGhMHkOx0MTXkU//FhOEHv6pe/QOEN7Bj1wzR/wQGIcpgDLetA0vpz+07OTdJ7fnuqnClIhzVhkJ7Q4pF9Jut6NtuGOQtEDxdE3drvLve2Iequh91aMlo3GZ7eZRRih5TnYn3MVGXdfJo2hGvaOgxoqFYo4Ign4wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qop6doHhIDjYq2iRt/PYgeHSlP4xd9E/2hURHVnL+Sc=;
 b=bTGZDx25wrTPEbsVBabqLlhphkez4Hc0oS+DzF9C7LEWggzL3e2NzpXaWpPB6M66UFTTtU0wLUhcXHhS/p1bESu44UA11eWXscIzrOb55RL0jFAijizYIia9I/hEEa70emlk4tCmv6MdjuIUkJMLJ1ETKMQjLTrjOZzFai21ldvaF88mzU1clJMjwXQmVFuUzoKC/ltn/Ya3bVQWRU45C0EzGzLnHf1sWgX3qypmK2JrvCOkoqXy8KEyw+1wmi71ELHJZUvaHP0hIRD77IjxKvlqIT7rj/UnxFAdAZKWDiwLTJQIzg5vWiynuaORakIRCk1YfgHnlLrM97fvCr1TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qop6doHhIDjYq2iRt/PYgeHSlP4xd9E/2hURHVnL+Sc=;
 b=zstpUwp/ySTY4eHMVVpfmKJKm7Df2OY5HbsKsUSvK6NvyVVhXeK9Me6l4VgyJrN8RJFiohGxMnOxvwgnhwBZyf1chZv3/Gra6v+aijDbT8qW+Zf+WXfZkcMNtNf9K2DixedJv/MKduilu5a6vNu+AJN1VgpMZBBwkz1NwnFwWJA=
Received: from MWHPR14CA0027.namprd14.prod.outlook.com (2603:10b6:300:12b::13)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 18:33:26 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::28) by MWHPR14CA0027.outlook.office365.com
 (2603:10b6:300:12b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 18:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 18:33:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 13:33:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <benjamin.tissoires@redhat.com>, <jikos@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] MAINTAINERS: Fix parsing usbhid from scripts/get_maintainer.pl
Date:   Thu, 16 Jun 2022 13:33:22 -0500
Message-ID: <20220616183322.14861-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f163fa8-a7d3-4d14-b1d6-08da4fc6b389
X-MS-TrafficTypeDiagnostic: DS7PR12MB5767:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB576744C1E8C7A15FAA41D319E2AC9@DS7PR12MB5767.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSKU00YR7eihjfWcwd7JZIfA3vYyhmRUXE1W+bKjaVxLAOfp0LGZDRTI4Dt6nBh0GU4/LigAY1739854pa29D/20KxA/lmewXu+RfDWlAUgzxBtmjjXeTgwjE/Q13o4jcmqph+WthquT3/ompN85t0SPFFVmuIpp1pTc4yKHznULZuI/v3Zdm8w3J2p/fpyovMnAEri+sSX3OGKFEQg5+Biugqz6ImDJkn2VbZJJ+1jOH5mxVjWRqMXW14Ns4EVk/aXLK3Q7Tuj89Rc72ZkrJWJYhTPS81ypbcUzhFhohyLIAEMAB8N+6QYc5Tvjjc2nlXVrpiQIRY1WFmaII/CmnKlXLk1E/8EDytVNPhVzBVWkIA6lVqluPzFDNuK5+ZyiPC8DAsTHYTrdxNmT3RNVTWneuHe9vcdjwGyyqozKpH7neY82l7rkPe5kOMeInspSgXfN42cod5Yl2a16FqJ8RdtFhg8HGe/xLwO6L6IeIOE7dFlGVArfSUTbkrZWK8gC9rI/A9v8I0h/v4CbE8lNuwb7VBXTtv1GMd/7ta7cJb4PLPh6ExxHwzIYW9NYtKBNk4dr8iOqWlfRMPWmLCxEYHBrDVMVYQCZAeUtzSY6HlDio+0iNmKKJwL6thPc7vTs1/6vvGfWAVuIEYAnGmILSm8f2usbwnenYpZVbTMdzoGn9JGGpkPG0dTcb9davPYJhWAmwgWT+PrwOAbzh8NKfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(70586007)(70206006)(4326008)(1076003)(8676002)(40460700003)(81166007)(2616005)(26005)(356005)(7696005)(8936002)(5660300002)(86362001)(316002)(508600001)(82310400005)(16526019)(36860700001)(186003)(336012)(2906002)(36756003)(47076005)(426003)(83380400001)(110136005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 18:33:25.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f163fa8-a7d3-4d14-b1d6-08da4fc6b389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently trying to send a patch, I found that `./scripts/get_maintainer.pl`
didn't want to parse the usbhid section because of too long of a line
leading to a missing parenthesis.  To fix this, change () to [] so it can
parse even the long line.

```
(to-cmd) Adding to: linux-usb@vger.kernel.org (open list:USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REM...) from: 'scripts/get_maintainer.pl'
(to-cmd) Adding to: linux-input@vger.kernel.org (open list:HID CORE LAYER) from: 'scripts/get_maintainer.pl'
(to-cmd) Adding to: linux-kernel@vger.kernel.org (open list) from: 'scripts/get_maintainer.pl'
Unmatched () '(open list:USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REM...)' '' at /usr/lib/git-core/git-send-email line 546.
error: unable to extract a valid address from: linux-usb@vger.kernel.org (open list:USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REM...)
```

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43d3d07afccd..f4658912c007 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20537,7 +20537,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
 F:	drivers/usb/gadget/
 F:	include/linux/usb/gadget*
 
-USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
+USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REMOTE CONTROLS, ...]
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-usb@vger.kernel.org
-- 
2.25.1

