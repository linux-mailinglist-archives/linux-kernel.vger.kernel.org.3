Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED65900B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiHKPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiHKPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:45:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4F94EFA;
        Thu, 11 Aug 2022 08:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbSQgQ1GmDV+NNLhwXu3GcpQCVU94jKW/hcJFMHWD/Ki6VcEO4b7n7tS6nBMgPogI144/M3ckyOeBPzOHxPkolYajHMF52UdGSVCG76JgpB1y4S9Cwl8v3HDRHywp09+3wqhwGH7efJuyBtcrB5WgudJcwIodal55HYbnTIUUbqJAckdJ27K2GvrXS41DcBAiiGZ5IhTaJQNt7wRR8Bg7iRB49wkXhLmmYoz9lj1TQ/7b4DUk7iSCWPzx5VJklknoIX6dPcedsnuYvLqgJZtGIeeiKWIZW8tS5Y8M3DYd8uhS38Hl0DKPqC3NaSlPM049k8sOIZazrh9cIGAstRYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=Ij+DoNKfxgX36ycONiDpovGRqEZjXYqq7Z1RWyiOAw62nn7z2gqTtSkBIFAMuqhcneVpiXF5cOBGTXo50uJ2gPTOHwYltn5h+h9A8OJOcI1gUG/akZcK1Zh5CrOAx3/1S4FtKu+BbfJkl0ZV9nciUhwxQgFkVJk/TgCzC8yDm3BJfpQfK/IlC+0j1D73hxmU7EZdyXE4SQmSiYiFwzAVYUK9AkDIzAo6eKiFjkGYs9WTZlRnhqbIcIxHOZn1jkt0ykc5G3ptg5TaUTZv6D5d/VBzTI1hadgRr5/xftE1yTwZ9n+Q+/ntH9xZr07DEQx60idWtEAewyToUffj7/HkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=Llu55QOoYYgH2rAek17SJBL1I7KtIgPR5aGiAViHZFsDkbWz6RYJZD8UUSA6t4kzMVjX5RtNd8bFQ0pI6/ck2EpEjGbnj/EuLM5mn9QRoNEYsdJbCaG5FgucUPE3QGZ+ErdVgqGgWNiXtgqkbLi3vauvIV/kPTUife6QBbyj8GgxuRx2m51dnNxC7syWErulFsiTLIWyguB+GRqYxCAizOfu1mg2R2ugvzDcbvHQebBgF33U3/TkMbGM94l9yGeLFOJkJY8dVBUawQqcBsaR2wTrZrqx4iUaeNehWeilqPb/417Mr2EiewGS229s6n/bVFw1jE+Mkmw8ZoincILC9w==
Received: from DB6PR0202CA0041.eurprd02.prod.outlook.com (2603:10a6:4:a5::27)
 by AM5PR10MB1603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 15:39:31 +0000
Received: from DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::11) by DB6PR0202CA0041.outlook.office365.com
 (2603:10a6:4:a5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Thu, 11 Aug 2022 15:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT018.mail.protection.outlook.com (10.152.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 15:39:31 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 11 Aug 2022 17:39:30 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 11 Aug 2022 17:39:30 +0200
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
Subject: [PATCH v3 4/4] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Thu, 11 Aug 2022 17:39:08 +0200
Message-ID: <20220811153908.31283-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811153908.31283-1-henning.schild@siemens.com>
References: <20220811153908.31283-1-henning.schild@siemens.com>
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
X-TM-SNTS-SMTP: 74FFABE4D269C50FA2E78DF4D2D29745AF0B71DBE84558311B8F7F47BB8804222000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d9bec9-9721-4246-9ab1-08da7bafaefc
X-MS-TrafficTypeDiagnostic: AM5PR10MB1603:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVy8Lducye/3dSuQynh44BDFxbEaYBLOmnh5EbCJc+OHP3hg9/8PR4bw4m44fOydbHfFgwaOYm+WUIec/zcYj//sOi+nMbWJSnWQoYdP+z5+noYhJIiuINY23r5tKkwmyysTas9FK/If0tKEwas7YTwCxmVhCPuJKD6TjcFi1R7QXt8+1I18nE50ivp8H9Qrdy2byLVepHk4mb1o99tek54jow9IE5IOjfa4nEBQml8LdNU0b7pxStScQ32qFcXzxUx3A/M86HDHskvtTOAqV/ROi2HDZWzb1ebyq1mqLreGDoatOc94Fliwnnx160WMzA+BAm5WMXXZM/D8puQXwtuoZreexi0B5UW3GmCeERRIMnM0DQpE7C9OzhlD6DR6OBBL+bDyCn5lQgEUkBqyLZ8Sh+RTYZMyrSleudYtVjpjy2t9npfX7czHftJ92HZRg+nLv4fC3EuX8D3FCWSt9TGuOnNeJyLgrRn8AxUbKT9lYV13gkST1XbakoROHRoNhMnp4+e1rBpuFUi3zVJIG55W6zj8noHQ8k5s6mwK+4+hTEELX7nzpS/KCA6KsXBiHosCI7al7o1cWs8xBINVkFYGaFqnaUBSSmOZsGknvQsapXxUZByRiYQcWMwjv0C6y4gZ2rQwjwkUjcCAOFuqnR9PQRyQys23n7vpFUlWuHuOn2vOA+Rjhx/2SFqZT0GPzAM18CWMEUldzs5w/zJbuHBvFsKsncG/rr5xo4JYlYrIQkfG5y4SNRr70NP4jym8lv1UbXQexsnMl/C33OGhOIfOxMG/D4WOT91Mmrwiia8iyK09Tcn+gEyGSNdcZXtmY6smVRU8WvFYh71nMtx1wpU/A9PwogrAjeG/vzUTreOxX3rn0f8vElPVMjMw8y/Q
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(356005)(82740400003)(82960400001)(921005)(40460700003)(7596003)(7636003)(70586007)(70206006)(316002)(8676002)(54906003)(82310400005)(2906002)(4326008)(86362001)(8936002)(40480700001)(5660300002)(7416002)(44832011)(26005)(4744005)(41300700001)(6666004)(47076005)(336012)(956004)(2616005)(1076003)(107886003)(186003)(110136005)(16526019)(478600001)(36756003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:39:31.1005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d9bec9-9721-4246-9ab1-08da7bafaefc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1603
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

