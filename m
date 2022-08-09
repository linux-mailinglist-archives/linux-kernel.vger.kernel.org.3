Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5458DAC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbiHIPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244816AbiHIPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:05:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23551EADE;
        Tue,  9 Aug 2022 08:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEQeidl3EQa6zlxaKs/w3ZzYeSIqdvJnb9FaJZs93J4VaZZregJQ7Mun5WneTVES+ulciGkInLqaj4bKjRMuSKIvUEZluTUlnUZCJL/jO76GkjcQOI6Pu1BfWtYreIQJ2OBHFCv6id/opro9SasZzdAiKf/lf9RO8J7FkE/PuH2i1v7Mc4JdQzTJaB9OrB5tUVcbWglGqvXaOpk4qsSXNbb6Vq4a4hu8Z1LUmrfn1Zg9R2OTHZ3zGXU4NrrvKF+QgE+jD8gIl/u0i3m6ehV9ci1IP7ViCczKeXiu0iGxTiaZga2OnsNSMRjL8cvBQNdpPN2sYFoMiFbVzWcXXHL/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=YxPo0DWEirbdMG03/cnsFC01lrRLTeh/L3AlayL69kC6theclY73Y6lq6nDGnDoB8+U4WVQTRFWjA43IuGrORmboiSyVsXTuJnPY0gj+csUos+PxXHgs7JWMzQUqLcxmgBGoSqqe0uQpINSncZzBRnFirTWsUExqA1y7S6xViayoBleT6QqNYFJQt4i/1liL2aJ1FoUnN3NOJFINwdSIoT/2SGsIM1iwgmvM3NS75CJrc50b/odpOJfMAq4nD7e4UGIycTcW2HvahsG6VexKR5yF4TotixJYtLUKZZm/m4DKL2c+7toNq9iWqsfbqkqNOOOKSrZsKylJFiwwrSJqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=hGEgXxUIF31q/8C3QcF+0a3AKljUexBrUZnL0xvonMHJDfLNg/cOhiWnebmJn/cb8YioI4DdcLUbh2Ukn4L0teBgXyrYaSHCiChfg+AwARK0AVgRO4GfbdcEYoTpgtiGnztQzVwQWc4nMIOsTl4afXpH0GXEf6ynEa0tcp8ly9BcuF45NOWSRilr/Lx0GJLY7EnLSfam7XkevMAUFviO3nC42fBNOkxoBK6aR3Vah0sFAl0YQtDv/NAB31GN3M15n09HspAcCQhlR8swrX5sabP0EJ41WKBxOzO615n7+E0d8aVPKTThxEjl6n7FuISTtdiPfF/okYXdj4AbnQHnJw==
Received: from AM6P195CA0051.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::28)
 by DB8PR10MB3483.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 15:05:05 +0000
Received: from VE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::5f) by AM6P195CA0051.outlook.office365.com
 (2603:10a6:209:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 15:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT090.mail.protection.outlook.com (10.152.3.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:05:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 9 Aug 2022 17:05:04 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 9 Aug 2022 17:05:04 +0200
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
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 4/4] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Tue, 9 Aug 2022 17:04:42 +0200
Message-ID: <20220809150442.3525-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809150442.3525-1-henning.schild@siemens.com>
References: <20220809150442.3525-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
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
X-TM-SNTS-SMTP: A4D83ADDEC2F83E16A51C985D085CB3DDD5F9A3A4CC587B04CDBD6882E446B2F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39fa3db3-9809-4106-a704-08da7a188ae5
X-MS-TrafficTypeDiagnostic: DB8PR10MB3483:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTAEfEMMb43bR9Zj2AuB6yenhgZCyC9OABRq73d31smp65/6RcIHbPb7S5S+uRngghmPT/cMWhNJQSGtALOoa9Ba3X3h6ur5CMutcrUw+oqhN+18BeQPkA0dxZRCkJbdyUIL2L3EHcHEZmfeZ0IN+s5vR5237bQPv6LpBh4uuhFXSvtiz5/z76+e7ZowNN1gollqUALBC2e/WWFAwdl8ACZ2CPA4aq9MptDZarDCX6df4HEg88TQapBCh1lZB8SeVdWnWclhMIU0IxaGMqzG5koHA9NPUzMppJBbh5ezgyVa/VdSzugX2/q4a12jUHM8riApD9/sA/r1RH/TLtIfEWw61yN/Oft8STW23eMzy3Ywm2Odbrww/4znkdz7hw/0TWVcVSdn0bXAUNh2b9RXhqYuA1p7cvpA8BgxLwglAZ0zYvHS2/LvHHjg5Z6zOyHbWRayljl8zWWp6yfSC5FTU+nxPgGD9LErLdxI9icbwH0+Rvhh+RoLWYYsSHmH9LxUDfJgwH6kORC2RptvBqPLwcNDWkHtA9JFt34NHY0tZJQICm3OrXjoXomLn7N2NGIgN7ISRUSHzH1M6C7XG+Vxir6vnsor/ZodFBfgguMgKo+Uy3l1Ni4v7Q/5pixbJ92MHHUof/BgNE5GSDKdtP3jeGKnrgebh8hqgShvQjR0jQs7ywVqBX9vu7cXeZjyhIGONKKn9ZbIXPZvStGVp8NUuIk/Y+S8spEnhFGdmWiLVzm4NpNtmajwqQ4Uxa9DqiYaSHwiOkCbRFFA/9n95+q2mqZp3erS8Z2rMx0Xk8tacvnR91CdTObW5cnGmUA2EQ5XTnZwXJ4+8BY2cB3W2QsyLrCq5gm45Ej4UJooZoUHPqphnl7/M9+y5SJ/92JhvI5qiyXk2hjQMdQZFmA57N5anQ==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(40480700001)(2906002)(70206006)(70586007)(83380400001)(8676002)(5660300002)(4326008)(82310400005)(316002)(86362001)(4744005)(44832011)(8936002)(36756003)(110136005)(7416002)(54906003)(186003)(36860700001)(41300700001)(82740400003)(6666004)(40460700003)(26005)(478600001)(2616005)(956004)(47076005)(336012)(16526019)(1076003)(107886003)(921005)(356005)(81166007)(82960400001)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:05:05.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fa3db3-9809-4106-a704-08da7a188ae5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

