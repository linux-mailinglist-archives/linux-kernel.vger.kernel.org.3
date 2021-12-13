Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC447264D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhLMJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:50:12 -0500
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:9906
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236047AbhLMJpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFozrcEnKucM6PqC5EarDHgq5xI9Z9aYfmiZc3bdN+tqIlAqXfT8M4imq3izMEAGR76xAAwXd49czytyTroM8h8n3z85bkJh/rmjf96T/omrq1pwNFGy7RlD0vna21vILJ6dCmFoZfy7DCqIl5osLBnEgRA6Y4VyZjOcDam3Q1aygvZrgHG47zRs7PaF0TViydKq84Bc/m0t8fg9QVflDLhhc7n2fZiHW7HIglTtGvepbsLsL0qRnTGxj273goFOuVoxg/AnkCWQZ0o3ZvtfJPSznQyHtbXfJ9j7YFgx/aurTKj3gfZqv8bmHufoBHRuILxPrnaGP/0tB/kE+dAEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QgypY+EjTvhEW0HNTsmvDt1mfypYweq6uo34x8GUAc=;
 b=HfRFKgqrxBA0e0MWopI3Jn3x4tu4nJcT6GUsDSIMZdbvwjo91co8/LJo4jVbY6l7rTDpTcly91OjYcmpFMYHQZZX6RrWlPKQLIMQpt6DfSe8DsWUqtPbsGkOzKNrjd46yZbM9twJ5Dsgo/+mNPTAug2JWyoigqmhHCaJhofgwT/miQdKws1n7GHVuPQKYEbeWfhN26x8TnasjryuKjxk4sUdNxlgCCSLUVPocZs7Lc6XL96lKLr6s0vDqnG/wLwAhuVXXU2tL7qntlhU21cNsLco3P3fjjx72BEFDKSVk8bCTor5r3AbvA4ktpWq108ADZIl1/4Bfm0RT58WTFgs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QgypY+EjTvhEW0HNTsmvDt1mfypYweq6uo34x8GUAc=;
 b=Lzqi6AzyPBqSoKc3aEOreBXEWI6tcNWXS9Apm2DCs+F85hhhwQlkXgj9rkSMSJHfF+LlycNczXtOkDx8J0vXxvD/Bk21rh1oc7F4K4GMB1ulbG1jgwAxl2l54dyKfV8l/VSf8g3KziEwvjH4G0jSca2pM9q8dEIwdh99/49ADu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:44:30 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:44:30 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mailbox: zynq: add missing of_node_put before return
Date:   Mon, 13 Dec 2021 01:44:20 -0800
Message-Id: <1639388660-63943-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f1ddde-ee05-4ff0-3e95-08d9be1d28cd
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB305012A77FEAD403B9D050F1BD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zutG1SKC2ciy3y+ntBT5OoiRVR1jwRkG1MUhtl5bti+TNhwZfbhaN87XR9ff0HGcAP4EeAQtpuRLP9stBhsQSwd+dUoBx+A5ISIMBgf3l/WbOd3j9t3fz7J9Mtc4WP9JLrEYbBPNNDmv5XbHIe2R9oNA5dtdOpuGE7/y99m0hHx6yJmi1NValZATl/gw8NiSxz0S+ji/RN2zpU25c9G1C/trh5F+NU0ZoEOT6evWebPS+91/2u0z/mKOUaUiVhANHHi2cISay3FNAvNQs4Gc8+q7Ybf03RkQuHPi4d1DDvWQDNATJE8TJjD6Tpe48SSjoBs6rdL5y2Z4JUbfQgx6cApKsh9IZ9TR8Lw+SqxYL8Dzc/XtWImBxAyOVYdZfprtb0ru8GHoNrn/aKYawn99DW4tu2GB4qoqcdqjcLuPAyJRKFI0FDs0RHCmo+bk6cszhprS1ozShhfNPocv9nBJfgeflYGaLUCtXacHGgkbkkg++SyfaR0LJf97ly6XzIcQWbqxU2qzKwF4NAYAzOQiUaQHt1oVdKM/ETgjzwqBBc93kmC9fiW++c26WekP/aOQgE+fPWjDoYZE0PCIS9pPjxC5OA/mGs+ui+tfCA6OQdEK9AfPI3cW95BWpMFcieUrz2VMP6sZLyKQwWphplJhRtm1eRsLoUv8XMA6Kx/4hU7PU1bSpNQ//5PJ0PyiY9KiTGe6VyPZLiIKoiOveHCwog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(110136005)(2906002)(316002)(508600001)(15650500001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(4744005)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?357ii6jQI9WZqwGkcTJgpsqqfnKqKt7hlirGRF3fKu8lDKUtgp0sr5MJQOB/?=
 =?us-ascii?Q?vtrmMDGbrlmyL4pP+BiU2mSW2khN7meWdSyTMlhY5hPAch/klyzE+Bom8aN7?=
 =?us-ascii?Q?b+jFArW27sdKfOXhw8isMDExZXawB2ReMwh5yg0Af6GJety6mZIOwLEX/0U6?=
 =?us-ascii?Q?pTQwZpqwhtbo4Phtt5PO5nNEN5bFsDfPMYL6UBvwbjj4tFv4WZ1nVHnISo88?=
 =?us-ascii?Q?vmdf2CokU2lO8Giidr5vt6Wq0nZ9oOD2lKm1AggkLJuxqPNNiDpN2d+zNhST?=
 =?us-ascii?Q?o/AMrJah2PXdj10zP4oTZ3L6a8B9ocvYOHxnI3GfpfOCehMhRdSpqQKH/ZSr?=
 =?us-ascii?Q?AJnGY8bE8e9im0Wl0cJaRPuLLT6UnNbWCLH5X3szTn/7xpGJYrmz+Dn/TbHX?=
 =?us-ascii?Q?hmmubnBKiR8QvFW6+vZ70kj/hohDcyApeNyuwUEItGnX34X0AtQJ4tEMmDSq?=
 =?us-ascii?Q?prXdMXZ/mpnVs74+ffKhe5V3JIfD81YolydKPAqQfu9ilKoJ/D1i7u1amwu+?=
 =?us-ascii?Q?SJmUNMkniMOTem0Rg54Hwvu4IMh6Bnl0t/YsVy33rkq8ElfCMZZUCVa3lU/o?=
 =?us-ascii?Q?jbEzzl3Fl5LtJv4VpW/05F6LprriFiFMbehWKejoegjhPBWI2jgE2tzhjOCW?=
 =?us-ascii?Q?/LJxJX2MeasfjnXkxE5/tVdFsT84BpXj2jKfxgiKGaIrwj9HXa1xdEUmHfGd?=
 =?us-ascii?Q?gwfxolwB66mCni1sZJgfcm6thkdLJ/rujUE1yda5JLr+jxx5jdAk79uEDTo2?=
 =?us-ascii?Q?I//JyAZHkEwLGtDTiDeIn7sMMwwTMwflmLEfiK1YAa532RULazLj3lVKvbFM?=
 =?us-ascii?Q?wmqL9aCS5laC6OXHwnOhKJ0JwREaSn01dpM/4cjCQes4zaemKyn8sVj6XFkj?=
 =?us-ascii?Q?T1fzqtO/MU3JqdREcyNoRRWIU0QCj5sSbXRXpyS7WJHf2C0VOCQ2RIXI9iIk?=
 =?us-ascii?Q?U/A98ydRvEmq+UZ/RUd92IjpRB6zxEc+rxnscBSh39NC9ezr5PwerveHUN3V?=
 =?us-ascii?Q?1xTAB3IkIOWFSQ7NhJpFo3HIMt4o+hukMmMfoSETQzU+KgULMFkNOeaoxlPZ?=
 =?us-ascii?Q?MHa1AVdhPjMom2aQQwiyALE4C9OVLa9fRcbpRmIx5NS24aLbUtksc7Zuq3xZ?=
 =?us-ascii?Q?olWIKBQEOL/lQosr11Ak34C4IIfRC92GvJ6kq27RclrsBqrMQDHBQApR9yBA?=
 =?us-ascii?Q?Mx1OyrpRGkB3O/OiKHJI/tFAlsHEVqt94jDjHiv/itC1XW1wGRZohkCDN//n?=
 =?us-ascii?Q?Ppq3uD7VOhyjh6zZoIPhuFo9JafuOZMWc+rpxIW3ON8yjMX1iTrj61Z80k7P?=
 =?us-ascii?Q?M+sZGeaNafj5uJWfjAsQ3GBbLjrupsiOf8K7CFWMWwilAQVv6WBeu+a8+NZg?=
 =?us-ascii?Q?PN1PYeRnoGsXRhSSUKByEAwAjVhsELp00h6lFEIaenyXTVTqoKqY2rKZdEXQ?=
 =?us-ascii?Q?WZBpW5mzqTBtWPXKyCEfMsgtpzefwJ/+ApHQKFCcPCH/WTrlCalIAvVXB2V0?=
 =?us-ascii?Q?4x+RqnwCxb68J4HbT0PbrMlkqB8ILuviuvBpTKFIgom3Tk1CYTcHAo7l8LAI?=
 =?us-ascii?Q?X5FXwWtKmTclZmpYsOUY+YG1BnHbYfSiZStOslLwrgnvEeYjhzYR4lmXon2Q?=
 =?us-ascii?Q?yGhLMJtUiYaXNFJ8mdwVLfc=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f1ddde-ee05-4ff0-3e95-08d9be1d28cd
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:44:30.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AfK5ric6KID+V4imVVYRl3c4/HkRNyZtbnnB95kyAcK83ZfWiNu64agNDpusJgSuoL99wqEIqPUnCFR9LRQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_available_child_of_node" 
should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index f44079d..31a0fa9
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -655,6 +655,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		mbox->pdata = pdata;
 		ret = zynqmp_ipi_mbox_probe(mbox, nc);
 		if (ret) {
+			of_node_put(nc);
 			dev_err(dev, "failed to probe subdev.\n");
 			ret = -EINVAL;
 			goto free_mbox_dev;
-- 
2.7.4

