Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0088C51A706
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiEDRBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354165AbiEDQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:55:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49EA49933
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp9Nu9UobWRZOqvWpeNS0X8U+zuwuQcP5czIXi8FJ6btFNLntE5HiBoCcirfxuLbhyeGFStGIiUz5tCNYUGGZEmJ7bldXarvzWIdOsbiHFlfBXHWV1BDvG19f0bl1jRfbB9xSLSptBTA2WtgkpaG7NgD2eK12zXaFVECXTIQlIYm8XBXCOKEL/2kyIA4gFVNuxhom5cc5kyyscBYOxpweqlQwRuRaTWNyZX+PkDPICJEQmDJBzwe9S0UGeN8VrykZ/QQclODYih0TWYsEBRlOrxv83zBZ+3SWxXTlpD5Q7vWnjZYV7UPKlemBqz0hkCQxhyesAE5Z1eBfHmZPj5oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oBPpMkz/r0SCCCvodITXRX5xZ/Ic8CkOstXBnXI0VQ=;
 b=bPdmVIzm6x2kt7fEwYwbi5h/4kx/aSVcaaICBqMFjoKRhGDs731G9/ki06UAb5ofpa3tsem5Rac0sz7lTBE4neRju/RysgMWV4Yhl8rCLbfV/0v9c3HXQ2io2KdTC+N3TOIizFQdTTzoUA5GI7VcOKsI8/5Nuh75Ggi3TmGTTfWQTdwDLUpS8gyw2Bl4BC1Srqar+PvEyfDitpHJ7CUOcowSHOFqPZUNdd+V5Ppup5mhroRSRQa9UT+VScuz+a+kwWgBljDt5a03TPd+oAbz1hPO6kABHL1Q3MUYoVnz6HQHE3n+dYuH+E6JGQfDF5INs+5h3e8F8fk8J6W5lSsPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oBPpMkz/r0SCCCvodITXRX5xZ/Ic8CkOstXBnXI0VQ=;
 b=E2nA5cLbd2p1z2qp12CbBK584Es09Mfrqs/0PXHGKmiu9vg81SGe1esWjanCaVDygXXjlGDaEWk9hbeAc4ceA+nCbY7yo2RrdxudodIxUQskS0/AgA1FMp+EJBG+u8jTrJQhGvpW65D4VaX/ZIw6yMRT4PM9Lq0jt07EV3TRQb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS2PR06MB3496.apcprd06.prod.outlook.com (2603:1096:300:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 4 May
 2022 16:49:47 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5206.014; Wed, 4 May 2022
 16:49:46 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] i3c: master: svc: fix returnvar.cocci warning
Date:   Thu,  5 May 2022 00:49:01 +0800
Message-Id: <20220504164901.9622-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f836e924-0773-4634-a15a-08da2dee179f
X-MS-TrafficTypeDiagnostic: PS2PR06MB3496:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3496CC906A301CC947FCD9D8C7C39@PS2PR06MB3496.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l55F+MwKx5hlbMjmYJlrPDXEH+YbGdrXTLOFyjjfIltvaX21EShzxivqtsW2KTIHilJOXlL2ZaTR+VF9w3axYkdYZh6p1izi0HYyTrHEdanMgTkUpgXMT2jroHm1tzz48fhvrVmpiiIglesKFh0pEAAiCPWSxomC13PPHhBcl509DYOl3XjUDwI/iSiBpy/YT4cfCOCyJ8EB2BLO77Tu07+hrBdoGgYkLY6rfO7fIqDa3ydi8dex54To3u8y7gGsiXWArx+rIyT9SLfG+yqYjcAa1f990Uqwp77KLUAY2ILBUKAb147aXV9+hq5gVxfu8igQ9lDHNsALeNYoD2DmdOhQNwpF7IEu2XR6hNsMQIYtLYnTyqPMRsgCLtEzB600clGvxqkwRLXxerG/7XIyCVwj/0MqIKRelK0kf1bBWIzyBZTI07hKoVzUT8wsviX55fDREFbRVBYsQAk8CA4rAVopUG+/hOVc92069vGYIKEDZydo/UpFe//gQsg4p9E7Jr2To0TNoVA77rCWOSCWQbwB7NAa42wPy+55MBYl8dY2yRpRAFU8zoa8g8isFD/YUh6/0Xm7uA4FgGPFyJ6wPTUvQIbbjQuo6D0HeMnAvuxII1ghCybSTPq8cHtdPUl0Zp5XBzqj0jSU/ZPeo0n4HmkXl98/0TKyOGrA6EgZzWpnR96Di6gzXvVW/R5J+laGi1be33FSUIZcKKtEHbQ9vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(83380400001)(110136005)(5660300002)(8936002)(38100700002)(38350700002)(8676002)(4744005)(66556008)(86362001)(66946007)(66476007)(4326008)(6512007)(186003)(508600001)(1076003)(2616005)(107886003)(6666004)(36756003)(6486002)(26005)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VaYoU+C71Du6c4mW7vkcfvyKOjLktECCZE87655XsPKD3ZlF3QN5cBaQb8lH?=
 =?us-ascii?Q?mC9U4Mq+e1gKZnDsTUlr+7m2TJYCCMSpo1io2tHRxsoxZcNc0D3LTQRUcqYh?=
 =?us-ascii?Q?r4OtUmQbP248CrLdC10NmKMDd32xjjc+B+3vOy7ZgC1EPSkR17dcGigmUTzT?=
 =?us-ascii?Q?hDTf7ezsYBok/h2TnnQUSiEZvGeM0CMzwDCh41duC65Q6eNPZYvpN2U7UkTz?=
 =?us-ascii?Q?CvsUm4bAp8voMY00hDTVPyekdiebhTIUZ4VM1XeNW1VP7KqE3LnnVg0wizp+?=
 =?us-ascii?Q?2Qq0m10CWFgG9FeEZqbhp5TNqjos2rhU/VVmsWsu9b3vcns7h6rSSVMMAOdm?=
 =?us-ascii?Q?Ktfz4GYVmyjAgKtbmeeEw5va9eN9vBaKWR9viaB5WToCBihPOdJZP2TsdD7Y?=
 =?us-ascii?Q?TYGM475X6bGU19d4zSaSkua+VA5ML8IGqgrqyk+Hfck+LweKOGisBoeh3sij?=
 =?us-ascii?Q?P6mddHkw4zwFNC4A89jaETobGlBTtDq5hyf0xO32lpwXzSvKAYcMercygW0E?=
 =?us-ascii?Q?/LSL8f51OaZGSr1TbMycqFSw5cZq/h89NyDsZ5yLJ814Rj+OhOOz3Nhxpl8o?=
 =?us-ascii?Q?KdmxAtvwMqviRqaJ8kItz7mJNIR49NnCy2gAaOTl5xuM9fXuV9TsQ5eINZ+Z?=
 =?us-ascii?Q?esjitrAwUI4QsFT+vVzJOeYWYiPtmSAmEVeJ9+QbIQPQ+pmJssJKgw6N0FsV?=
 =?us-ascii?Q?lNPTD2LMySkt0Jvjqy8yhdNiBJhGnj319yDGtaU2lC8JE9xVxb7JZpwIwbDf?=
 =?us-ascii?Q?hIC1v6kcK2fuXhivos+nTReSACRpRz/jvRH30CXvNhmaRoN4pyuMmCi1Dde8?=
 =?us-ascii?Q?15gmGOdU7RD4tY0AdQBpnfwkzAx9TFS2ugvQ1o/YnrVhPRij9gjzd7Tai6ax?=
 =?us-ascii?Q?P7AwpxZlDHyu3jAA9qWCHywoHgL1ssM5atN/bKtocJOH4QK7TVXAfmp8i7rS?=
 =?us-ascii?Q?zr8ICli2sIltsjyBiEq0Oi07F4TSMFXSKgEXNlmIeRj/kCOwrclbu6kpRqe/?=
 =?us-ascii?Q?VAaowZcjPl+pvW5zf+ig4WqgyK5jCJpROzc59V8N22FmkH9MWDcR43mbYc17?=
 =?us-ascii?Q?0yM8oyIB8mI3Zc59D7NsfjGzQ1dvILsvLFeipGTzO/TGh7x0GNtimiLEu42W?=
 =?us-ascii?Q?0x/bXQaEu53efr8eCnjKtZ+QSQ2bI/Ru3iNHUyBhZoGoEaKFO0MmGPkNjcpK?=
 =?us-ascii?Q?nfNXmHbQVhaCbIANZtyODVOHn0M6E1fJgB8ku3gj9Li+8QQ22ve4YE3NuHeH?=
 =?us-ascii?Q?ltyRgy7ySUdBjUm4uyxh6U1z9NbQrP+0k3Rl9Tt+D1fxxwg6skIoefNVxvvH?=
 =?us-ascii?Q?IS0WLy+I6VpO/LIPxKrSBegQJIJJqqfUXVM+gVmXO/XOS3BOMtvyqjbqYWhw?=
 =?us-ascii?Q?YjwI7vmzTtIghEhfJgE5HNv30KRZNNK7Jfr7hGdqOMDSy2ylugCnBn/d3+3c?=
 =?us-ascii?Q?ZETfOCVucelzWWkP6sE8+2NsgjtJ8A6DW8lKAq+HoQ0Y4eqaQSd/SqTH9Wd/?=
 =?us-ascii?Q?LIutt1Gtfbp8gt8lrgusQ6cZIEt6rhzc7Lspi0H0ANTpmXiL8nnEUW4yy8pN?=
 =?us-ascii?Q?rTLj3UcZOBuaU47w6Oe5E2hmwgb5xf/cwzrKHRQzP5wYeFYbNV9GeY5vUS4C?=
 =?us-ascii?Q?9Xpsg+Z9v5Ox6BmmhsCOJRqXOY/L3L3Yi0WmS71QFSOsmAUAvBNRHKAO/5u7?=
 =?us-ascii?Q?dQ0f8GDZoaskaLGgJEy2Ncmjd8/5PhyMpqOIuk54jJdWuVStF5fIVAZ34R+1?=
 =?us-ascii?Q?yFj5+bKxvQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f836e924-0773-4634-a15a-08da2dee179f
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 16:49:46.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG88h8gqrBxTs0mYlHOHwW6SRCA7iiLPLXSu5d9HD5w7R8bXhLyVjEUAJGPVcGj+CRUkd5SZuDItw0u1pjx+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3496
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/i3c/master/svc-i3c-master.c:1600:5-8:
Unneeded variable: "ret". Return "0" on line 1605.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/i3c/master/svc-i3c-master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7550dad64ecf..d6e9ed74cdcf 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1597,12 +1597,11 @@ static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
 static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
 {
 	struct svc_i3c_master *master = dev_get_drvdata(dev);
-	int ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 	svc_i3c_master_prepare_clks(master);
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops svc_i3c_pm_ops = {
-- 
2.20.1

