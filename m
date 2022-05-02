Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC08516E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiEBLFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384719AbiEBLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:04:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302E657E;
        Mon,  2 May 2022 04:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+40QvW5kCMlDcCiZnHtf/nHP4/E6zyR36Dl29T2HtO7FdlAsiYOFE17sPBLElUjWImPx5tlqgRxl/7PDs3nmpuu67Cgy0PgikfpCnZ+Au84BLaIe8F3GpUOJGtepwdL/xOvKTetSWLcHDZVjMvNn7jYPwt+Z41iByEEEhFe4wl83fm0VTpxTIZjxIAxhIoWjoxDVqnWUKSITPqkTnKs3jkaY1ND+xKbcUrpmL60Uef0A8XfDKkXy8/jVZ1sj+rzAmttjXjzGwYLENaoJv8OBe9K9VOrjoaro1vlet8V2YirxQ4TyXeXwmneW2Zx5KswVXunbt1KhP7qOJuYnLK0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rfP8JgafFVIQuJu0dS/pT8SHV34ZdOe1pDxgYaqIbA=;
 b=A97IilqrNky0hyM9lADq8gVIJJ2tUFX0oYuf0fyeD1valshQbZvcooA7HDWKC5RQY/ryuEuFVCqZo7yK9M8ug0A+q1wfG1N36Q7XXILQHYHd6pw1mNzUps2P05p4b4o8PTWSj6sqaNSl7morEnoN5/K7IoRwSFZ56cEtHmu3uKGAmDT+SxnI87KV4NS2k6P/xmIPhOmhDyeve9JgXmj1GJc6CrI/7uUwS1uBN7q6ogvIFpW47JBMYNPo5l/107JOkc9Fr9RupEJYWqbxxUFI6JaJTkAdlYtYuFY1UWxS/52AUoW4wQN47Dblp8wsM406q1UYdkyO2pHcPD1ZDoW+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rfP8JgafFVIQuJu0dS/pT8SHV34ZdOe1pDxgYaqIbA=;
 b=CmZeulmDfp+hTqtFEHW8Y9KDnSt9uCjQxm/NyULO9NP/FwMMRsE8sP2ecNYZfbB/f+EIc0TEFWVU/cbYqXnTEPEpx33ix9PN6kQrrvrMOClLz7eT0Xl83rlYLUG9Ym7BAR3XpZhsL/rYUIFUgE3QuR6fsfX3Oux8Xgwqgu6qrOo=
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by SA1PR02MB8496.namprd02.prod.outlook.com (2603:10b6:806:1fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Mon, 2 May
 2022 11:00:46 +0000
Received: from DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::10) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 2 May 2022 11:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT062.mail.protection.outlook.com (10.13.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 11:00:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 2 May 2022 04:00:43 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 2 May 2022 04:00:43 -0700
Envelope-to: git@xilinx.com,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=45250 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nlTnH-0008EW-2h; Mon, 02 May 2022 04:00:43 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-gpio@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <srinivas.neeli@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2] gpio: xilinx: add missing blank line after declarations
Date:   Mon, 2 May 2022 16:30:40 +0530
Message-ID: <20220502110040.12225-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ab4700d-0b10-4b9f-325a-08da2c2b02c5
X-MS-TrafficTypeDiagnostic: SA1PR02MB8496:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB8496F1D6775688E3A7E9BF6DAAC19@SA1PR02MB8496.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kok4RIbNUsiO7uyY8EldzO+JIlII+3Y5hPqtCsSmuWrlHy417o9EtLH6ZaiNsQKgmRqanXCug2EV5+p7Y4nJvvxq1KmgyWafInRhY+nV2m1T17V8p3YjabQxMFTsRZL8LmbEhh+z179HbHsi6tzf+Z3GeBbvNsHjjKQxM+8kwLX7/Go3dnTKyyR118TFJOq2ITLJ2EcMJlId3hwzzPOWQKSfww5CSfg2FuqxTomEL9RBqbfSaEQtIOlSY3fPAQt/eoc4zkwO7PQttO4SqWCoyRE70cTZvbsY9gD8p+wwhbQvnhU2PYsVsr79s6lAWKNZWJ3vKIGnVOxhEi4f6lsdz//9m5wruhxCsx2hxcfz/t2cUwAh0EUXUXp0BmMugIj4cUspcakTuXtbv83kdQ/XH84ReQbWAZH2iUwfx9wwTE3iWl4obxpY/e77UlcDuTn9aE9DDvjlInNGyfDOtr8/w7k+S6gvamB8BaBnoiulQ9ULu+4n9uNxWdeBTLt3KbqyoYf7LSqpmD1fqHroTTOGqAJl/2RHF28RJzvggUVtzFNG6DGxJN5ziEyBJqBo7obHfZ8KLNt1UqQAzMSbmvEpmr9qGoVS16ol7mzK1aJ1lRUbMUbW5i/Zh9l3n2+GwfT6ROiy0fi9zRPLqC8TMMGYMOpA5HvpHuqqDDHczoB2dEgzc8UISTZUcnDfbzkhuFAw3huilsN48DehlHwFbafww==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(44832011)(36860700001)(316002)(1076003)(4326008)(26005)(2616005)(6916009)(107886003)(508600001)(8936002)(9786002)(54906003)(7696005)(36756003)(5660300002)(426003)(40460700003)(7636003)(47076005)(336012)(186003)(2906002)(82310400005)(8676002)(83380400001)(70586007)(70206006)(450100002)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 11:00:46.7102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab4700d-0b10-4b9f-325a-08da2c2b02c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8496
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing blank line. No functional changes.

WARNING: Missing a blank line after declarations
128: FILE: drivers/gpio/gpio-xilinx.c:120:
+       void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+       xgpio_set_value32(a, bit, xgpio_readreg(addr));

WARNING: Missing a blank line after declarations
136: FILE: drivers/gpio/gpio-xilinx.c:126:
+       void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+       xgpio_writereg(addr, xgpio_get_value32(a, bit));

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2: Update commit message

 drivers/gpio/gpio-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index b6d3a57e27ed..7f129e7eae78 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -117,12 +117,14 @@ static inline int xgpio_regoffset(struct xgpio_instance *chip, int ch)
 static void xgpio_read_ch(struct xgpio_instance *chip, int reg, int bit, unsigned long *a)
 {
 	void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+
 	xgpio_set_value32(a, bit, xgpio_readreg(addr));
 }
 
 static void xgpio_write_ch(struct xgpio_instance *chip, int reg, int bit, unsigned long *a)
 {
 	void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+
 	xgpio_writereg(addr, xgpio_get_value32(a, bit));
 }
 
-- 
2.17.1

