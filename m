Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A64D00F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiCGOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiCGOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:18:57 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937B3335D;
        Mon,  7 Mar 2022 06:18:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDa8srAbUTYESXCVzlkK5fj7Otu1qMmnAntblNqD+SNAQIiFxeDF3MqiEqud7Bt1jI4RtcXomBsOP/XEowwvuPmbeLgGSvFu7Q/Piz+WKLGiCKUSx5Wv4fvrJub7xN069eutG9d9OAkXUhaDRZLDuWexM6WlnpQSf4Wc+Er1UVpbWyqDH+6GXIOoRsNM8Jpq1/qBVJlPkTmIfnUEOvFO637iIuGjOFMSipFczvJmlg+3ZTYU6Q8eGx33Fe+86t2zP2TBAgNNDwSrCqi/owgBPOM6OafSQdMqtv548m6mNpkCjf+2zDp0Wm6t5K4zt1NsUD/v2J9BxxrvQNbxPbIMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQUiIvhJnvhUOr9LUJ/uPq39sjgi3jL7+QEbeGYDRNE=;
 b=Z3MOZFfp8soji+VaP5AjFV+527BQJ7KIpnRJGFtJHZoc54wEh8Uj4f2G3NkWONOzjg4PWyqLgF4CmkRQjfU/+SBbz2JQ34uI2QsNZ4WaLurxw4wtkG5fIyRt53GmekA6KjVEPN1G1cmnD8+bswleD7Ah9LoKUFzpdGUC7ZNWo1k7KX7EJNSNZMDhjlsKkrYW1NtGRy5Sqy1/F6sEVi1WL6sI3y8b2HCyzLAdC5GlBq5E0iEiTSFo5qyj434HpB2wn2ppDEvcM7+tCnuWnmmp/uRlfWmkytKe7JIO3lpfYU/Kc1YuD8/5FW4PQ9jfreulIc56tKLvywor4niB5krOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQUiIvhJnvhUOr9LUJ/uPq39sjgi3jL7+QEbeGYDRNE=;
 b=iLoiHMNBwZqNG6rcp6I59MzOHwhhDURjkLpAYLxcAya/NSZctMwukRKXoqS0w0SDeIZCIIC50mITywwuwSrN0Bljrau9Vq/nu3e4kf2BIYE/Q0Y7CBNGZ2+Mu5YtvSTT3Zd71RuTemgG0Fc4Jf+pXZG38SlIh3dejekAUHcrmR7CWAMc1h+fDG3qMcnMUYj5qQ/4TXjzn+TWHZ84JaEORxtrzJcE700PIpPgBoD+0G3tKG67l4ssSGvOzDe+TuE7MRfRk7WeDNpuGWgToRvS7qvuvnGe2VauYw6PMmthviocPJH4Whf9z1T49n2fHHSHIAaJvntWC+mLemxMg1XhHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
 by PAXPR08MB7246.eurprd08.prod.outlook.com (2603:10a6:102:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 14:18:00 +0000
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63]) by AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:18:00 +0000
From:   Alifer Moraes <alifer.m@variscite.com>
To:     linux-kernel@vger.kernel.org
Cc:     a.zummo@towertech.it, eran.m@variscite.com,
        linux-rtc@vger.kernel.org, pierluigi.p@variscite.com,
        Felix Radensky <felix.r@variscite.com>,
        Alifer Moraes <alifer.m@variscite.com>
Subject: [PATCH] rtc: ds1307: implement suspend/resume function
Date:   Mon,  7 Mar 2022 11:17:32 -0300
Message-Id: <20220307141732.27891-1-alifer.m@variscite.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP2PR80CA0155.lamprd80.prod.outlook.com
 (2603:10d6:102:2d::21) To AM9PR08MB6999.eurprd08.prod.outlook.com
 (2603:10a6:20b:41a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13829ba0-dbee-434c-135e-08da004548aa
X-MS-TrafficTypeDiagnostic: PAXPR08MB7246:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB7246044DCC93C0C978EE92B687089@PAXPR08MB7246.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 765+gV2rjZoi53VbrgVYAUE5xLyMn4Gd4ApjtgjQR9UK9r4oM6kyGg2kTySPzitIXmwClBzGOJ9/1BWVVtQYPkbdS24skWvRE+qasAKQpNjntVLiYJ88J54V0/9DWlrTzPl/CADDrydVmQA442czUyxjV7cFRrPA8TXI0OJlNlTmBS/UOXcFCkq9XuVYwWJXCEz9GqHw/kWqUgEkSKuG5PF//enBfem433m69u2EUc+Tb8sxkiqLa/8whSYz8UHAzwn8UnZ24CNT5xshvJSIFulMsc/r26+C0tzEUY+p5eegWZiI3zOaBUeJFU3dA6GDpKuNr2CXECbVbRwUNkmRQP5HGyLZn0aRSzXvp9P6COK9UaY/oGoGQJUh/97ZS5azFj/L4LzpU1eghyLHcnJm8ZWbS0efmNKuXFpGXGC80NcllOCS7uo/EaLlo5j4wro/ax9famOVINPap/IhOd+qAVaxoLMcA/r1j4vt2PqdNWdl0rLD4DPSos2SD53+t2VwJUii3lbw+riC5p0C4envd+QpW5kLxYSzIFAmD2IrW0cS+Bjm2TWil8XzLk99QdFlN4X7iTr7+Ku3iE07q2DDB+wKSi5YXZ9EMd7dkjPjGAIvi/IAXbbYa9NCv6L9qXUb4vpceB0eLEUZY2p0ypyJyZ/wt0PH2wShOTMW2P/jBuo1AeU8Lg3RFRI3tD4PcITugytxPmfEigzKClb4ZnA19Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6999.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(366004)(66476007)(66556008)(66946007)(15650500001)(5660300002)(8936002)(4326008)(8676002)(86362001)(2616005)(1076003)(107886003)(186003)(508600001)(6666004)(6506007)(26005)(6512007)(52116002)(6486002)(6916009)(54906003)(36756003)(83380400001)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUZx59NeqkR7RyVlNf+qsvliJHscu4LFnMMe9TCEw7QBRRosCzF33urGBz8O?=
 =?us-ascii?Q?2GPakl7KNPdd0LEQ38vfs0X8HYNrU8oa0V6yQ6FdvIUjYxJaPLYupPWzZy0z?=
 =?us-ascii?Q?vzw7Tg8vxGta3DNIhD10FPb5q5AZM0hYn8+h16y2yi0nxDM1NLKQJsLpYX1K?=
 =?us-ascii?Q?vEM1VsBA+M1bMj74vXBmYfnMhdyhVk+P30FCB8qm1MKLT7UUGskDSdHT6Tz9?=
 =?us-ascii?Q?iEUEbN6WsB/9QI9atii0SxMaDtdFusI7W7u4GG94Mifw/txb+OSY7xXbqbsF?=
 =?us-ascii?Q?LskgPRhuTrv96z1m/iuQrL4q/360ABP33XhnovnRmi0PaQbueHPW7RAeXLta?=
 =?us-ascii?Q?S6nrUJJl7fMbmBx6E6PcCk/JIc4IQhH2u42JPcXlUDxVZwoLiAcWlOdKAik1?=
 =?us-ascii?Q?KvFtxR3aT2rckq76l2EFMFGiRx0X1FbJ7Vo8e3t4mKRuMayV5EneDvSOVylk?=
 =?us-ascii?Q?o/T5rz6tq4nfj+Fgsx3AgwM+kSVTUrO+CSRDubj0/RPV27eyX/YSur+rs2Po?=
 =?us-ascii?Q?rm2MWrPMrw3B9tLmRnkqK37KQ1PV+UVHMvDNoBr2XMr3gtXw1f/oLgd4Lnmr?=
 =?us-ascii?Q?OHufpIhUrzZ4UWLOJg6oKive/4QpALLmPe0RWaY9inP9w92rq2Pp2hvvMlDw?=
 =?us-ascii?Q?M9dPcLUO6u+TcpjwVaExa52OzQoI6lQeOhLtfITQDHAncTfRRcegPh9UOaYg?=
 =?us-ascii?Q?cx3xrZ3K+sDrdAKAuewnHPYdyqWC/gUfimUTFAgtAeFbsqQmT7aYh/7XTMzm?=
 =?us-ascii?Q?Pqmq9gxckCc5gnO3KWY6S93cSd8U1nTWQQJARVJPl1cRU3XMS1TWnrhTnFEs?=
 =?us-ascii?Q?x+3Pf6kAJVxXpbvLEPX9mBN4EGrFPN659qNI4bvJcULPls5FmYHJNb3bCUmN?=
 =?us-ascii?Q?u5OnwCM1KdRSpnOicTGK1j9pYEOyNT6vgO/2ZgqfOZnZTAlSyf8TABBpqpF0?=
 =?us-ascii?Q?c52P3rb4qFgB1C9SWPsOJI9LzvuEPA2bqL/ZbF+EB33RpfnHX6BNT2zblm/i?=
 =?us-ascii?Q?6T1T4Cc4avSPnDXX96P3iUhe16AtZtJ8HT7NJjBo04EfYN/wynr+NzWfDBJk?=
 =?us-ascii?Q?+Lz7nQY2noBXQowjPeJx1+LxuqBOHRODW9JKA3yFn/FFd0sBvEY7gnMPZrbG?=
 =?us-ascii?Q?FuxdxW3yjQdSDrdpTaQf1IxVLjLKBYXmfUcKxB+2QYkceVnly8we+vZ5ppRU?=
 =?us-ascii?Q?LfQfnMhFMUkWU/7U+bJBiyumfQC8LL148pHHJNZVVNjvEZIjWQGrSwkxZh/k?=
 =?us-ascii?Q?n/rsdib4vvHmpmK0iyvx5rnnbf6OUksWlcG/je12sXvU5j+J+wjpSCK2iCIU?=
 =?us-ascii?Q?+c89JeZoaeAt1xlaXOUPHNu7zmapO4ZnHohTFM6UqOpEwMywhJVHpuaXHrSP?=
 =?us-ascii?Q?MQFli4/pR9zYmET7DELOaKI9nyy/5VcwMuCCKjJJcCiufPWLILrlhD6VpGSh?=
 =?us-ascii?Q?is9qpexfNGuz1KzNQ29X6M8zGdZEMlOCVyQkDCLHt/a69kTkUypwB0m4miqF?=
 =?us-ascii?Q?/kuvykkKLZv8pzJwAbu7bKziynRTwZ6/7HVApZ7J+LNJk3D3k7o6a2s+1QwZ?=
 =?us-ascii?Q?ERArhszi4tYnznV9zwuKCuvSVdR1aMaMNZfCpTCymMt+OUurFfQWyoR9aCgH?=
 =?us-ascii?Q?MwKzgkelUJW8AXZ9i83JsTE=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13829ba0-dbee-434c-135e-08da004548aa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6999.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:17:59.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luK7pfEK+SdAwCYv7IhohC7avbWoR4DTjsU3AD8WDjcrdQiKeBxUe+FS8rAZjS7v06G7caea7ATjpgb8ilmsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Radensky <felix.r@variscite.com>

Implement the suspend/resume function in rtc-ds1307's driver
to control irq_wake flag and handle as wakeup source.

Signed-off-by: Felix Radensky <felix.r@variscite.com>
Signed-off-by: Alifer Moraes <alifer.m@variscite.com>
---
 drivers/rtc/rtc-ds1307.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 336cb9aa5e33..fab6e2ba345c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -2006,9 +2006,36 @@ static int ds1307_probe(struct i2c_client *client,
 	return err;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ds1307_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq && device_may_wakeup(dev))
+		return enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int ds1307_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq && device_may_wakeup(dev))
+		return disable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ds1307_pm_ops, ds1307_suspend, ds1307_resume);
+#endif
+
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
+#ifdef CONFIG_PM_SLEEP
+		.pm     = &ds1307_pm_ops,
+#endif
 		.of_match_table = ds1307_of_match,
 	},
 	.probe		= ds1307_probe,
-- 
2.25.1

