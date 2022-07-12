Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB67E571CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiGLOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiGLOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:33:27 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC6B93FE;
        Tue, 12 Jul 2022 07:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFxRr597z9z13B8v1AvAS8rUV76jG3I87ZJDIuiU3GrSROVfTQah7Vk8XrPZnyFZb6C77zkRj5T8KsLBxdnxgHw+eQvXJLJ7FklobpyIkpbw+Wq+KHEBacKQ3uOvL7vMqR50YX8p/Aj1kEEGTNX40Ngieoyl0sQ7KjQ/MUyewqkuwfoc++BjtvQlwp2zuns3WhCpqz3qwcop9m7YxykLbHRniKVTl4I3K2U6fvZ+j6DXl4ZadHkh1KVR6wicdutcIL0DpbBsr1gNCTDZl7gbSIvYpZp+wuUFC4p/J32KaPbJz0WhI8WjNCWpFIlFKstaFr9Trraonplh6VrMM5HyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=gtdDOrnLi5NEJLkEBuXonHhJ0KgwWhb4MWo22lU6uKEwoA6Qc+njl0fii2qgUmOPGAFQ5xPWNaJqpDLTNQQyfUGkkzZUGu9y4bjIejrR9h4XeK4Jue+qx1v7XY7R8Jktrp90ZEuf9FGBKDKTo5lNBMOfnyCFpUFSLQPi2sbmRCfiFmY8PYJ4H2JY/ZiBJHVb2HXDUZ/Zj4v8pXjbyI55cXMnNgzlIO6v1PlC0F0NJ3DfBStQbJNTQW2CxOSx3LUyS2sf1ODG5ZSCVyCr3PF6OSd+DRPM2vi6vVP7FJbebOVIAfvrW3UGlpSroIAAsGHN1aGhK0Qc/PIuakGTF2tX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=F94Og8J7dX54iC/kXBgHG9ImJDIkeK27FS/vAThJR8B4GxIJf9HkgzV32k/XbAw4RKizpKpwRZpHL+IN8XHlUH2OiS/ZGRx3wLPDqQS6L+g5SM0rJyqLKAtExAOuHAyiOqZYCYdC+GfTx8ETdCpv8qSYlOyvkeUlRPesqBPKlzAse2ctb1WFnbC1LWLJRT0dg69jofHUZDoh7QeggGdCoSYvKbA1lSpVz+BxFwlWJhi88GudSfr3Uy6ZEiVoCWy8I9Op3ER5KRuYKcDnAAkB8aFVBoRD305sq5DnvC8tPDVnRzlCC36z1wJsF1s2nMAKcumGrp0FZGeig1dymyU/KA==
Received: from DB3PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:8:1::21) by
 GV2PR10MB6282.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:74::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Tue, 12 Jul 2022 14:33:00 +0000
Received: from DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::45) by DB3PR06CA0008.outlook.office365.com
 (2603:10a6:8:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 14:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT040.mail.protection.outlook.com (10.152.5.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16 via Frontend Transport; Tue, 12 Jul 2022 14:33:00 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:33:00 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.161) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:59 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 3/3] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Tue, 12 Jul 2022 16:32:37 +0200
Message-ID: <20220712143237.13992-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712143237.13992-1-henning.schild@siemens.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.161]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6722c0b6-4ce1-4569-e7b9-08da64136c03
X-MS-TrafficTypeDiagnostic: GV2PR10MB6282:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68yzU6g0ef+sPP8hLnAuyXp4X8iTWhZedGmWp4NcKvV7dVMHIXUVOP85P+kkopbFGXu7sDfebX9pSE8XPV1J7YD4vgi/NW765W2/z8UTAV9b7JZyFEFh999motXhKzJUbWBLuusGCPqToeI+GeIJe+YHCHS8P1FrVYm/rPiypPtEBTBV7fKTR5S38rgwvQkBHFfGCsC6lsX/3OCEgSkMp9R8MUs2FqaDn3lgWXT06b+czC91qMhRjRlji5dWP/3znBhZhU4rmBwT6FVMCURbz8Fx98lj8R9sTnOYJvVMrZAuSPk/sW8+FldE87BCskD5Bme7zj2s3KluQ6gO0aB82Yb2DX1wYsddalVek8G2vyhTN7gqXXDIuJo2leJIA8fZ3sI8YxQGPtKdXeM/8dlILQcbsNWQwxusOOSWqm+Jd83p4CgjMhJRMhnx4siAkHel2RJYfHB45l4c8p1O0lUa3fa1bhm0UHKCGCc1WRwpcuJTP/LIUUEGA7cXf5NwwJrLpfXbmLzUaGD/pbAkE6sGyUQQrBUnNJhuA1dbHf6mBRc9MRx1phOehlczrJovnnSzya4Af7gy8HwZEZYkUty4uf+siyPqpEgPhgGH+YPnCooSNH4BZzTxD/OBMhzHgJAsCYkvFRzPfVnAWRZDNs9u0QRIoSRKwaQjJ0zVjkw5P+lydcGFJOwcUhtXT5naH3bGpuZ/S3WEO/O8RSIYkZmGaZq1293NeJFd/smK6R9r5dM7Ej2dUuaeVz6pHTXgzXTOkCM27Vj4uij5sznm4NIZlfbvRMXe9+C47aTx5CL/6/wvlqXkdgQGPu9hs8635wdygrdIoCMBnz3TK2SwXhcRTOudLSk8yeJ+L/it8ZDvGm0=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(4744005)(36756003)(8936002)(5660300002)(40480700001)(40460700003)(44832011)(8676002)(2906002)(316002)(70206006)(54906003)(110136005)(86362001)(26005)(956004)(70586007)(82740400003)(82310400005)(47076005)(2616005)(186003)(6666004)(16526019)(336012)(1076003)(107886003)(4326008)(356005)(478600001)(81166007)(82960400001)(41300700001)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:33:00.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6722c0b6-4ce1-4569-e7b9-08da64136c03
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

