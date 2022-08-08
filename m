Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C758D01E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiHHW1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiHHW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:27:04 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130084.outbound.protection.outlook.com [40.107.13.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884A186F9;
        Mon,  8 Aug 2022 15:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAaBVUTemRFRl0TGuOtUjeKzmoUqiRqJTWCV9BMsL6su9/UGS2p2mEA8xHAS3GY4XU2QaBnbhP7aTqhlshnbj5nzbt+FMsbvJknDcUDnVpc4WF631JNLXpLn+EHUDZ96G85lQRmv/wMw2bmVbZQXSfIYxMYsZo63Bn9ILL0MEtmWby8tVpXUp9A3vr3ROIe02a+2ViVMPJPi8QxOzqJQrRu2Ao0vit4HZPD2o7mNFaqJ5a9cU7Yfs/Lg5jEJQb1b8BXtqHROc+eIulFhRbw1+Ak7GO3t+anClG/5cOORJL41JWOGKJpayN/MoqhF9eBYiP8Q77ndszw69i7MQXYWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8euka8C2XNL4h+8FMHqsbeinK58nVAip5rY+XaB76U=;
 b=FcrwfxYFQ114Y2Edh0AQZvUznR5EIwLimvNHfdQ4RdqmSNxZNXz8GLwhlXQQ5kYgk58yzUTv04q6iU5d+WjAUDsjB/KYs0yzen8GfbYZtl9PNkb6LM9NXe4Jw2NTsoha1dKiF+zls8HiUV4ZDvzzP/v6QkrpyD2vgAa9fDotMDHA/5qRaL3qDkbrfjD+29gyheNl5+M68CXcFJJFBhLSmtknWWhKEeRudBVabhI2k613OEIe+IQ6aphnobtR2bL0SbFVaP3kaN0oLPluKl1w8SKLFqDjpMnJURe2A3G5ODFWxEOLGr3Fv9Rdd4UqTFUurKjOwge97MZrfCN3xgXoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=baylibre.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8euka8C2XNL4h+8FMHqsbeinK58nVAip5rY+XaB76U=;
 b=mCYwMkrc2jUHlyfxidzJTWh4lc02zgult5ogVCjuFpIN9u1CxOHvKjWcluoBzLcuqIKK9O+ZUcEOJAKS2AyORNGk39/N9p4G7WYHZ3L+M69M940LZKP9EC7fFZLKSnZWMkf7IuM+fZw4WzoEVuK+0Fhcv2FFXMBq2rywr3bTMhyC1k8i2aUEmxxD/tySSrX0bq2+DqtR48IvYFBbZRT8mxuYN17rnii7OrEJAILJTutICqwQu+dupE/gPBkJiJJiYyaDGvELHpU47CJ7sw5noxXjWv5ljZqvpNl0D2S8+YfXAuFxDc+TlG8v6vSPHwq/QRBHZpMQBY7zWuf9sUidFw==
Received: from OS6P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::8) by
 DB6PR10MB1800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Mon, 8 Aug 2022 22:27:00 +0000
Received: from HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:30:cafe::de) by OS6P279CA0007.outlook.office365.com
 (2603:10a6:e10:30::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Mon, 8 Aug 2022 22:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT044.mail.protection.outlook.com (10.152.0.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 22:27:00 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 9 Aug 2022 00:26:59 +0200
Received: from [139.21.17.33] (139.21.17.33) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 9 Aug 2022
 00:26:59 +0200
Message-ID: <63d9211f-d5ce-562e-358a-50f26c7caf35@siemens.com>
Date:   Tue, 9 Aug 2022 00:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] clk: ti: Fix reference imbalance in ti_find_clock_provider
Content-Language: en-US
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.33]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.399900-8.000000
X-TMASE-MatchedRID: bXMpGXE7chvIGA/Cp0+6dj61r/jXlCG+1+TuFsIS42j0hv/rD7WVZFHT
        1UEyKOESXhmWufKBF2QytonrvDOcsd7VhaW3DORyxGmFJbXOeUq0Tit9+Kk6bjfu+RTlciXgH7b
        pDOhZpjbalJpeFb3A2GtwOoXDbvJwLU6XYI3DIcdU9ZTmNAkt630b5ebfn7XIqhcdnP91eXGm7E
        UWk2jS0f9LEanWbLZ2vSwD9wZivLrfPhslDCCNNpscC5DV1Se5YlldA0POS1IaPMGCcVm9DjRpd
        OU52PyTmyiLZetSf8nJ4y0wP1A6ADVmQqp4ykTAVymkLM+r7VTiRhduhvElsvJT+hf62k2Y+gsS
        eW2jNCdJzeIvl1c2mAmh3weEGTty/O+kykSBSCeQyls3PL5DXB/BXqwE9HSW
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.399900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: C5371C369A0952EC74FF6DCBBF415929522FD65D3DFEBD62808FD6CA8F14148C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bd02f7-beaf-4f44-d0ff-08da798d1ca3
X-MS-TrafficTypeDiagnostic: DB6PR10MB1800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPFF/DPbQWPTINZ4JTIxhQ/OycI1sKch41ZyiciTKfwGYKT0gxnHJw8ycAx066KHX/0sF5WhuqL4J443CA1TnX/bCRUxjwduxdNhAPJ3MhvI/ry/IVYRFwWxfRh28ZSbJKayTQWJJrYc3Hziu5OFy3bVEPL+O4taz+OMnMUSP9jxMnPttemoO335iGbZmQ43WW1BwU9dVcik06+/m97jtNNbHWuxo5M5bA/OUVrfodhbmzcHo8uf8KsHWCFqOtwDmdC69AVN7i2DRkA5Gv5re/sMi7U+FaBhJwF0qvqnV9xGoyD4THc3IxiVaqo7pp0KH7KeuIaR4Gj/pB1PcUTf/DqUWqEnxrJMvgWx3rJ2Wkz2THWAuPD6O5tYNX12SQBoL/ww+02tRKUXN+YgEXttbVnvJw3fBLNW0M7hqKHOtHp4TpnFfRkjCPHmFLHPX5NdroKAVi+lm76VxU41l6YoFfMwnrtyN6fH2agJQ3M43tMSpu2Zo7Ryf9XiQpSjvirmHGvEAtP6uc4BBTSUbX7UE541K2hYgv8BXIfqfXhTqmxQCSoQXaYSV6JYblh/lOAuNCeYTXP/GThNzRrdNt6CAYyCpQtb2mpai6HDb59yPY8O09Dbt0up1AwjiQciOL7u8P+CYByaYwXNYioZRAy2nKv3idr/Jthvm8Mm9QbgHtLaYkEsL0jUgAvZtCBKSyX7vIFDzCEl0InlrTa/Baqp73CzDBfexHkSHDKygWQSHMdR62a/jMzTeGeNoKCLMwzQRHTr/55rqhoAcHNNkMfTj+Wohlq76sngcRWdjkAqs0QpdMU3Cm5ubcsd1h/oT7HxGZBzZ2s3+e7YsSZayG4U9aKfliw5C9UCFoBOD5JlC+vIiZl3N/CWfO7cHjz1amJ+W2A13a4dSjzzr2l06pLU5g==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(16576012)(316002)(6706004)(4326008)(478600001)(70206006)(8676002)(45080400002)(110136005)(5660300002)(8936002)(41300700001)(31686004)(36756003)(26005)(16526019)(2906002)(186003)(54906003)(2616005)(44832011)(956004)(81166007)(82960400001)(356005)(82740400003)(40460700003)(31696002)(86362001)(40480700001)(83380400001)(47076005)(336012)(70586007)(36860700001)(82310400005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 22:27:00.3185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bd02f7-beaf-4f44-d0ff-08da798d1ca3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

When a clock is found via clock-output-names, we need to reference it
explicitly to match of_find_node_by_name behavior. Failing to do so
causes warnings like this:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at lib/refcount.c:25 kobject_get+0x9c/0xa0
refcount_t: addition on 0; use-after-free.
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0+ #37
Hardware name: Generic AM33XX (Flattened Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x40/0x4c
 dump_stack_lvl from __warn+0xc8/0x13c
 __warn from warn_slowpath_fmt+0x78/0xa8
 warn_slowpath_fmt from kobject_get+0x9c/0xa0
 kobject_get from of_node_get+0x14/0x1c
 of_node_get from of_fwnode_get+0x34/0x40
 of_fwnode_get from fwnode_full_name_string+0x34/0xa0
 fwnode_full_name_string from device_node_string+0x604/0x6d0
 device_node_string from pointer+0x38c/0x5b0
 pointer from vsnprintf+0x230/0x3cc
 vsnprintf from vprintk_store+0x10c/0x3fc
 vprintk_store from vprintk_emit+0x70/0x240
 vprintk_emit from vprintk_default+0x20/0x28
 vprintk_default from _printk+0x2c/0x5c
 _printk from of_node_release+0x11c/0x124
 of_node_release from kobject_put+0x98/0x104
 kobject_put from ti_dt_clocks_register+0x2d8/0x3a8
 ti_dt_clocks_register from am33xx_dt_clk_init+0x14/0xa4
 am33xx_dt_clk_init from omap_init_time_of+0x8/0x10
 omap_init_time_of from start_kernel+0x4f8/0x6b0
 start_kernel from 0x0
---[ end trace 0000000000000000 ]---

Fixes: 51f661ef9a10 ("clk: ti: Add ti_find_clock_provider() to use clock-output-names")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Tested against 5.19 as at least current Linus master does not boot on 
the BeagleBone Black.

 drivers/clk/ti/clk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index ef2a445c63a3..5261642974df 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -142,8 +142,10 @@ static struct device_node *ti_find_clock_provider(struct device_node *from,
 	of_node_put(from);
 	kfree(tmp);
 
-	if (found)
+	if (found) {
+		of_node_get(np);
 		return np;
+	}
 
 	/* Fall back to using old node name base provider name */
 	return of_find_node_by_name(from, name);
-- 
2.35.3
