Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C478259E5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbiHWPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbiHWPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:16:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1501665B9;
        Tue, 23 Aug 2022 03:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfIrjBK1Ay25VnwiuVkeq5VbeyZmCqouyfkZgjt0GELQrqOPd3hCsRhNGDcSbNf+EGwKqCIEU3srba9qvtZUTxULnVnpu1TCYcRG8g6WHEfRmGi4kAmc6t7Ko9Qut8Cx8EjWLBIc9wbPh6ABVpakyJP2mJaRcSK9CdV6dpUlcjM5kedsKChNzs8JDYB3m4nvEC06DoAmzxZXwK3QbNegIS4Q8qyymm7QKFWIvKgRyhxYLoFwKHILyufEfsaB2T8OfVjULiZegFQiMHmd9YT6j8MaYBjn9sxRUqqplz6Vbk2Tz7A95XPqGKGc4IcplNMTe0zMWNByQE9WGBmlfpJVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=VBJUZqEYWashTny5uuCO8svj5qfG0WOxnInOmxbmaTPopuihx9WGxjBHlBFt+IhF9zVg1Q9q1IwpLU0jTJ7OspXtjrI/PPrSXZM4gHZZ8JilD2MWJQVPtoSQGDWfmlrIeFMdKyeDgHXDjB4ifae4tQ3Mem1ztlqhwPwNhCvw+gT32aTbiVSrYO/i/1WTg7gbxJPZR2kCfq2002ZRyhY3H/Q/UyF8EKJsbYONL/RDng18Jbf/zDDvv5k6uamCJI02mAi3Kuok24s2tW7opg1kRZAliYCI7MLDUXECSsuM6PreYF+AJwjsivG8b+3DuMpM+xZEDhapWqGvS9GmHbxXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=qzJezurO6Gvp6kVORMpgYR6Euw/3NVBc/+bkcFVBf2cavrDZiENLHIF6p4rLFaarxxhOTrgg0S44Xxwp8MwM6if5cf29VKoPCrjcp8ZGVuBOxrc9iy3HokWGmSsch2IUubvOtdiZ7wKzGndwMYpG7lCWvcv+U7dq58Yye+t6Ll+OfiujNQLxV5O4V19Z0Wh+RyeE3fMBl7hzKEpvEH6CA8HLwplUrUqeAv5LC/8kClYT6+FAk3SCSgc9MaCg8djDLUMNu4jpoDo3jZiDpuhsWVPsk2rHjBXzN1uy4VbP38GHXFyWnrXPnaajQlhlLj8P+PSIz13OMWoHggNc832LdQ==
Received: from GV3P280CA0058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::28) by
 DB9PR10MB4846.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Tue, 23 Aug 2022 10:24:07 +0000
Received: from HE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::7) by GV3P280CA0058.outlook.office365.com
 (2603:10a6:150:9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Tue, 23 Aug 2022 10:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT029.mail.protection.outlook.com (10.152.0.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 10:24:07 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 23 Aug 2022 12:24:05 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 23 Aug 2022 12:24:05 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 4/5] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Tue, 23 Aug 2022 12:23:43 +0200
Message-ID: <20220823102344.17624-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823102344.17624-1-henning.schild@siemens.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.447500-8.000000
X-TMASE-MatchedRID: L90KqhDWgfOUYAP3WXIsZ3Cm15xQGrnE2mwVXKpQ3BdHg88w74mNDktc
        8DbogbSE31GU/N5W5BDT/pFzauZLmXEK4P8QtiVHs3gZaLIY9no/aaS8hrB/2J4CIKY/Hg3AaZG
        o0EeYG97Gr09tQ7Cw/1BIVsvVu9ABIAcCikR3vq9vibMxAqYXjWHFPUyW8t4AX3DcTx0UaPNCEh
        brM/bogi6eQ3HQcWnw
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.447500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 06510759FC19E0F5CCD4FBDB51AA4970CD0F36EA6E75AE5B40D375318C7AA1562000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a25ec1f1-5b42-4212-908f-08da84f19c54
X-MS-TrafficTypeDiagnostic: DB9PR10MB4846:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xdsrH1gmrKCcNeGeKdMaFs6BX7eaMSt46g9aQ8vtrD75gcvqhAv5do4ki5AV5YEBPnv8brz7Vs87P6A3vl8gDrHR98an5eNxoiK027kRCmiJ0vjG4HGbgeINGe04cPguU5tcsPEZWXVT38JZE+zwCRAobs4OWgTTgvLeDP4u1+piYBPPWqkg+oXMWizfEZq/wW0OvNrgCSPXffVlrcCjCZ202I9mXIlf2VZ/CfxYaRz0ZI9WSjxGQK+asjRyHibLeOs8atpuDSjggy+A+aY28Poq2hmsY4IsoJCsaEwpgmESj9ZhX7cGe1WtDDOZNTcM2QHrgl1bTYpVgZLftITTYWukQ64jaoyHwIVXJ7D4zdtRKr98Av87elHkzs8CWdJ43+J5vpbWwXe5ieYXFLrZo2UgBWwd262zS8vz2mdXNUKW375nwImk64g5TlwrGeJ6vDFE1qK6va4MBSCWiEXgmXjje40Vk1o6G2VcTcJIlJKJmfgQRUxXuLBnVg1NWvU9a6yUeaj7+yba8vMeGQYCFoT3fVnk66Jenk7DZlRGhuF0rdffUcqHAmG9TR4MgxfrW4eDJSpNRbU+hp1t7PGD/Mq8HnLGJmVg1bgz2nUtNi8MrtjfCxQoec30GRZMrf/WJJo1QlnAOv0dYJc1P7gyf34Shxwo/70EDXaV743nS51R+f4jK6nPcXxAFv9bgha+IPelXjbr9LCdic6eLGbskSXYttEha7H/m7KVEsnzPWwAW+Wn9TzeHD0RjdLno5gY/I1xUW8Yc7LhajOofaKN6Sv4N5ipoVUuKkHBU0oUqMXe1T0xd3Ma5fYzYpFUq/CNQTSVvkULusSfFNoEBE3kMi4F5L7yvbgz/ye+5orpXBf6YyXOMsjx89vApVmCDRBkj+QvFkOZkrF32YREZqikQ==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(2906002)(36756003)(82310400005)(5660300002)(40480700001)(8676002)(4326008)(70586007)(70206006)(6666004)(316002)(107886003)(110136005)(54906003)(41300700001)(478600001)(26005)(82740400003)(81166007)(82960400001)(356005)(921005)(186003)(86362001)(16526019)(47076005)(336012)(956004)(2616005)(36860700001)(8936002)(7416002)(44832011)(4744005)(1076003)(34020700004)(83380400001)(40460700003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 10:24:07.0025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a25ec1f1-5b42-4212-908f-08da84f19c54
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just load the watchdog module, after having identified that machine.
That watchdog module does not have any autoloading support.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 1825ef21a86d..8dd686d1c9f1 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -96,6 +96,9 @@ static int register_platform_devices(u32 station_id)
 			 ipc_wdt_platform_device->name);
 	}
 
+	if (station_id == SIMATIC_IPC_IPC227G)
+		request_module("w83627hf_wdt");
+
 	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
 	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
 		pr_warn("unsupported IPC detected, station id=%08x\n",
-- 
2.35.1

