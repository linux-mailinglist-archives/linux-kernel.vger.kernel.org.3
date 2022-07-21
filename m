Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C957C572
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiGUHjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiGUHjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:39:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E47CB45;
        Thu, 21 Jul 2022 00:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1a4ioRLcvz5oi0cfl5O+a7vJXK2g6YFuIQKkZ2jsUJaUjqEX52hR4Gy7HCIWBa7roTvcAY3kygWqs5otq04tabJvdLUAFIyInFUJ0y7RP+xXqeUrzRs6zLeEohLv2OAPJykg6xrK3JikZ1jC+yqknopyO1gDMiwsSWaeehaYJzCIO8kRZL5LOms+8qwz0xmbJ7qySHeOMcDeRIZInVtazxSWv+5zkoakyG58KPiX6n7ypzd+I+AFA7iyJT3kkf4LzPKO2ZOE92h+1wmmCxw8su8Rh2IuXkWnmP1CUKLEOREYmXDHqhwCs63bMJ8UzNahJOOfCe3r68fkc3VVhDvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwsNLZMr+9lkkOTGvkXuaa8ZuGrwcp6R2g4WHSDYC5k=;
 b=bpkjcC08FegxGxcJpUDDpzZfoCChrOTeVgyDyA0we3D67pM7976pJKbKZ0fs22YtCr6I06I0Cnfjk4ZiUTyD0vz0A8kWA8dQpvFSf7WodBDMEPb+q2rE4VPlWZXOmzQMHNuQ1yE52njQQZ+ptwkwLPXqeAvil9V/gGuzNqb7Q1KeNUaeXWQ7HEeLMtahf0o+tDCY5EoNNkEdTxxjnssnrd06PYPTYCJAOcv6R4WZulmgOxvq9nsT8Voziv8FZj22oLf8PO9NN/Dt3TCzNyzpEHMl+bOVQywquo/lEsYv3blKsAckHgprOMxiyGtLpKKnpaPcpPai7n6hahqrEK3J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwsNLZMr+9lkkOTGvkXuaa8ZuGrwcp6R2g4WHSDYC5k=;
 b=YTvy44+qQCM5VJ/rySjIUP5p7s4F7RqiFTk+M/ujEEoJYevFc7t9S9Jb7sJXuqmW+w5Ow95R9gQvj1heQb7gKpRWd3kh5NNoFO/uXBa8livvH4nhnrdLvUAsvvNV1i1clxFLHJglpXxR24vpQji3xq7ZijSeyhPBBw3TGHp/soA=
Received: from SA0PR11CA0098.namprd11.prod.outlook.com (2603:10b6:806:d1::13)
 by PH0PR02MB8661.namprd02.prod.outlook.com (2603:10b6:510:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 07:39:15 +0000
Received: from SN1NAM02FT0031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::f4) by SA0PR11CA0098.outlook.office365.com
 (2603:10b6:806:d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Thu, 21 Jul 2022 07:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0031.mail.protection.outlook.com (10.97.4.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 07:39:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 21 Jul 2022 00:39:14 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 21 Jul 2022 00:39:14 -0700
Envelope-to: git@xilinx.com,
 linus.walleij@linaro.org,
 brgl@bgdev.pl,
 neelisrinivas18@gmail.com,
 srinivas.neeli@amd.com,
 linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.66.193] (port=46292 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1oEQm9-0000Aj-B9; Thu, 21 Jul 2022 00:39:13 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <michal.simek@xilinx.com>, <neelisrinivas18@gmail.com>,
        <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@amd.com>,
        <sgoud@xilinx.com>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH] gpio: gpio-xilinx: Fix integer overflow
Date:   Thu, 21 Jul 2022 13:09:09 +0530
Message-ID: <20220721073909.23318-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17583f5f-af0f-45c1-bd2e-08da6aec1ccc
X-MS-TrafficTypeDiagnostic: PH0PR02MB8661:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRMNmHvpgYLVcUqpzA8n+13ByGLEv0gwDzXS8yATGGe6fFfv6z6U8ENP0oxwhDSRtDklRUyzXPwEDICMf0c0vffhIlqkMltavg2ftMRHNNynPvsJHkN62KpJqQalk2b+PYehfWSugQvz6bYSFtwBXeX7kJvuSX+/z+Ys9LWzBPHlQ53rmIT/CmR8z18Cy5qY/Xt1dbvJv7hd6mnH6Vn+PTbdIxMxrSIUSOUZZGQefdlqVd5os26DuE6PH39LYg+XF9aPPNDCeYXTzLibXlbVi42BFj4Huktmm+kB9TP/P0BgEnGkv4xUEmJnBQah7MLYvN++e5NjPz5zmmUs/ybHqQ5RwMQU7XTetWPysYx6uFCiqRoL8y1H8s0e8JRDQa2eFF5FiZBw1yayQFaLqkVuy7ZA+AuHOfqaHooHd3CrB8J6HagtRrvy7htTOfslGBNSb0sVl0vYj8I98sMTL2+pzNDrdEAD7FptOq/Kc3TNlm7cPcr1kyy0fxg7NzHR4H0LKQwFIyvOXH4x3YcYNo6pFdbU/QYrhhbImLL5Pbdz+1JqpKC/rHV1tkwMqnKk8+Zmm4jNMIBgaev66dOD+zNpzqC9SnwXlq6kyNH8VeGGPKqGqGTOiEQiS92M62MpYpOedInyOLC4rWys0OMIk/uZJJkKMDiYiGS+CjjHaZZzl8tqiWlZ99pkHtUwkjcdoJHguqKVa7rHyRaj3KrHVIOTzkXZWpAjkI4QisZ5m2sPlqqERLPzo3+24FmiJ596OrTcBDKeN1o6frUoyYgIcgKdkD3mqqswACg0vhlWzzZIDUZA1m11Y+mCblYnL9WNVvVTsYY2bvEUbsysLnZLMfv2JQ7w25ZLxZWeuUOL6MCJYoY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(7636003)(8936002)(5660300002)(356005)(9786002)(36756003)(1076003)(2616005)(54906003)(110136005)(4744005)(6636002)(4326008)(478600001)(41300700001)(316002)(186003)(44832011)(83380400001)(107886003)(82740400003)(2906002)(7696005)(336012)(47076005)(426003)(6666004)(26005)(36860700001)(40460700003)(82310400005)(70206006)(8676002)(70586007)(40480700001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 07:39:15.3571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17583f5f-af0f-45c1-bd2e-08da6aec1ccc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8661
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation is not able to configure more than 32 pins
due to incorrect data type. So type casting with unsigned long
to avoid it.

Fixes: 02b3f84d9080 ("xilinx: Switch to use bitmap APIs")
Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
 drivers/gpio/gpio-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index b6d3a57e27ed..7f8e2fed2988 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -99,7 +99,7 @@ static inline void xgpio_set_value32(unsigned long *map, int bit, u32 v)
 	const unsigned long offset = (bit % BITS_PER_LONG) & BIT(5);
 
 	map[index] &= ~(0xFFFFFFFFul << offset);
-	map[index] |= v << offset;
+	map[index] |= (unsigned long)v << offset;
 }
 
 static inline int xgpio_regoffset(struct xgpio_instance *chip, int ch)
-- 
2.17.1

