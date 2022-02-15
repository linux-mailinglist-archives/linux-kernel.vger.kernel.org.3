Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4224B60B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiBOCDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:03:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiBOCC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:02:57 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36B14563F;
        Mon, 14 Feb 2022 18:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYXAWDFd9+qNar7jypGiAA6hN4hcKNyPhavdCHjiBf2E7Ju9OnTGs2b2q6flH+70lK8BRTqdNuvH5FPGkj2QVLpz51T0NcH9J3diL/yRTIWIEW848TCw/wmAsfLukiLcQOQMpFlQEd3weHJTsRc28He5ONPe98/BuKd1+/hJxBcQvvEpvrBFc0JRG9ttzBdUUX3RCnJd4zWmjAXmGoGjbb69dp6GfqeIk8i46Y5E9m3Fid5HMmutDy4quV4Y+FKQZztkjoA0IP1f6qMBwx17KZxRobABxIV2VPkMjv2+ru52TS3e9tBNBECz3z1ct6J5ZsHdEk+7nWx3WfiA6ky44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqjypasDnGdghAjQel3uKWV9iUcMW8PBkaj7Eoi0txM=;
 b=cctAvk9jY4fB9Wr2x0Qulm6gIwGvVvTLrkhm5ElDfKVnEISfENip8UfxA0LUiKCfzNU+6W526crqmxaRw69wagMUc9KS7AbWGnMcS582KpxH3TRgnGDvwY22Mj2lxHoX/yoDgUcsIQdYeWMc01NVQORWe43bRUp8N6B5bg3SAwmvhjWRq2EWVJM3o/wk5FHK2SOUFoMAy66zb6z7DQT1tu8AModAvHE2UaCNp1Kp56o1KC39XB1u5TMeF7TUFb55+r+nh2jzP8+l2nkkPecJO9Gu9M0H7H5GDrLJivnCVoyUT7ir1MSvF2+f3BD5ZoAo7QMnVw6V9AAVC0VGFKD1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqjypasDnGdghAjQel3uKWV9iUcMW8PBkaj7Eoi0txM=;
 b=i3ozbhXdKFIx5i4pnDj8u899/FCEEMajba/T+V8AUE2jpl9LgnDxlBDWCVYvO7i7OA9F4IN47OsO0+Wo0K0JBERrlRx9pQ/uhfPa/RF9CjaE4OjGqOGlbACoCPtdhbaxw3F8B2iAE8fL9q+2pEG5IPQjymq74zvSVhHDdi/52gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 02:01:06 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 02:01:06 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] tty: serial: 8250: add missing pci_dev_put() before return
Date:   Mon, 14 Feb 2022 18:00:53 -0800
Message-Id: <1644890454-65258-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 876a1666-91c1-4b0d-b10f-08d9f02706df
X-MS-TrafficTypeDiagnostic: TYZPR06MB4510:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB451025BC51A962DEFAE9ADA4BD349@TYZPR06MB4510.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmCsY/MSboLJBuNZBjnKG4uSl89MSfqIS79Fn1Gbp3LPjMmWvSDyYKs6Tf0j5EW7zGA2heJvePzNSHfmDeCAcd+SdEpaHc32Qft5yk8/mXOjc+8jEqcES2Bc5LNJSEbaob1PuIknATUr1FzjLQB4k5qF5lMCPu1v5ZriBUEsCj8ex1yNKkMAaQ84E/Q65nXmjkiXUMk8gWfnV+MkxMZpwwtysq31TDjyiDwOrD7GcGM0Z7jMdobqawNdm1Ye8uNOAR/O0DodMU1muwbh4yJm7DkQohkRvaS4JOEpbBJCoB3LMRCUMz+qjRgS+fs/c/SSJPCC4osmV7Prfl/NyluJAIpr4XyNiYQ+8+7F03bv9lmoEDAyPG4WCRAZuvqEYOxAdmgs1p+nvyRctAFhsni4FrYf0BC45x4RrAb1UN6+M1djgsU2Ar0H+nc21LrJaM28R3Dr8IJuyGVJBR4l1i/1c8CSrLuOzQcBSlZYJ7ZJXHDp+l25YeI6FzPF68cxk2bqaQrCS9CaYQFMFM/4RKUe+8BwyVPp8uCvbXDucXD2J9WD2Q2UTE2WuzJ3ihAJH178PFMVJ4pNn8FWoJ1zCvmR3aoGLgr5sB1HnuatV9X9b7BwiK7ONQcItJuODlDR1X5nly7VgzeAN+tAUDCg+EpC9QWqre+i7P21SXKSaaodyUWxRkK33VopZcK1ziBf0YezA1/lQIk54R9agkKK+D3h4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(107886003)(52116002)(186003)(26005)(6512007)(6486002)(2616005)(6666004)(110136005)(4744005)(508600001)(8936002)(66946007)(4326008)(66476007)(66556008)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPLO2zzswIMMptk5porJv58Jh9HJy2pZU8Q0fm6//iLrX7NJfokE9nKvbF2r?=
 =?us-ascii?Q?/VLBO0nJ3cEVW54AsKP43GUG0Sgsqp3FRfB4fY/p00c2f6kVxCfMwAVM591L?=
 =?us-ascii?Q?l5mS7GMHvX2UCPsYFefLWpExdKuPXCsxmFh3ioRI//+Ds1FwuzH3CqQ/qlio?=
 =?us-ascii?Q?Omaxs5wYQ5xWwbKib9yvwzKGuXTw1ts9BlNbEasIkVIsFKFZRAYaU4Ns9cZX?=
 =?us-ascii?Q?iNKTlZCSHteaRLirI5CAZzS4rrvUkHqYyrBdoUoNez/GkMF/i6wI9B7nAKGF?=
 =?us-ascii?Q?ob+rBOjbkr2Fd85RtH925gJNLV9mpWVFvZ0NdEiGBuGiW5xTRy+NAyJikmCu?=
 =?us-ascii?Q?VV2QDTi5NF/OYzJl40YxTeEHvFV5W9MbBIK4+R8mibDzCpJXgXskqjl+E/jG?=
 =?us-ascii?Q?xNEfd+eNnvCqBxFX9J6QwjqmSis8BJwcKSE7v0tgMNNKYdMgIxwloLmTCte0?=
 =?us-ascii?Q?dcPPVtockOZAZ1WhNBQwh6LV5owPovt7CZdWu4YsVElf0YQHhplqgttWrAre?=
 =?us-ascii?Q?4qbJo0whmuC+vQdqCgB6WIWCthCqOJEAhSP93MP0RDK+Es0F/3EeKVl98abT?=
 =?us-ascii?Q?zSghOGgPn0RroGjuhHUBkK3Lc1M/VrL6oPqG617sNBp76xbFC7G2TOEnae9W?=
 =?us-ascii?Q?4/QU8662+E0Qkj//+VwZAd5q6CL+lPENvxwNZ/htLjJzBCT95Z4wzX41lM1V?=
 =?us-ascii?Q?jhLjzVpi0+api9stuu4LQwkYk48tFrppbpFBT8v5Uwy/pZaLHXK6cYEZldWW?=
 =?us-ascii?Q?RjWCJbQB9pFu+8yDV10anffgNTIm/8dWfjnSQ1fl8Nz00F6oMpTLD9eR3Zao?=
 =?us-ascii?Q?d/W0bq9hopYY3/pxmDvrUgelyG02lBkryudiovbw2eLL0gfIY4K51WFMQybF?=
 =?us-ascii?Q?74U/Y/t1aKMYcmQMUacrE1YF3tieaFCvd0bNd6Iy1jS17376Sz/6zXnSEZgm?=
 =?us-ascii?Q?s+IbdAyPbk4dVJxlkG/QkXaS1mFRBDJF/nRP89YnKic9maht1EE3GpZQBmWd?=
 =?us-ascii?Q?jDohF8AE0j58T8Ufb86FL2THbMV7cQemsbc+RwVTzXvzpQaquFYzdCj4IOle?=
 =?us-ascii?Q?sxgpC62lM1atsrt58s2UyX0ZbWHRazHled2CRyy5JZu+uxVxZHwv5kEYkcDm?=
 =?us-ascii?Q?ZJDjtp6prX2t0uWkQQtjxfCGP5uxngQuE69V4/tL0skii1bgdO8sG7u3bHGE?=
 =?us-ascii?Q?5GhnrSqvp2I9bys58e7wyFaFRQbHl2drvQIv6rdmuVeKA1nkslzs9D1MpBBP?=
 =?us-ascii?Q?p6xLJa1M2lAh2lLSfatOPtgEKo2QUsQ98BBzvKn5Tide1eTyZJCHELKF745q?=
 =?us-ascii?Q?6cXcRZKAkx5ZHapYn8UmW+28ek8NkgR0IP2N/h0boNIPHMy+5sC8NMGcleq6?=
 =?us-ascii?Q?NLOj48vXy9OQVNwytaW5Apd0CSYUo4a1j/FWFqa6w/uMR4v93n9yQan/tCLt?=
 =?us-ascii?Q?6gG2idYeW5CU3QmzRIpfOJXwqiv/AYJe+5aUWqSO5/lP9XJEfvujGnYc9TyW?=
 =?us-ascii?Q?7I/uegxlqzYqdv0M9yyIVni7RsY/VTdnF7WZkTK9dJTepRhxLpxpPvJ5Wrw6?=
 =?us-ascii?Q?bpZ2y83AcJT7wVbf3ht3zItjdGzPNM+dm+AM6kDhc7xbHtE8diymNa4m2cPe?=
 =?us-ascii?Q?7UnrO5BQ+39RsG70QlL8Lwc=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876a1666-91c1-4b0d-b10f-08d9f02706df
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 02:01:06.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rC5VmoNXshwD6w+l9YGnwIF6o8YpGCRdz1D7IYfYviyRG73E8XVM9KC2K2n1rzXNm+kWPisZwRioCyboRJ5eOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

pci_get_slot() increases its reference count, the caller must
decrement the reference count by calling pci_dev_put()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index d3bafec..57e462f
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -149,6 +149,8 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	/* Disable TX counter interrupts */
 	writel(BYT_TX_OVF_INT_MASK, port->membase + BYT_TX_OVF_INT);
 
+	pci_dev_put(dma_dev);
+
 	return 0;
 }
 
-- 
2.7.4

