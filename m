Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3E46E265
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhLIG3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:29:40 -0500
Received: from mail-eopbgr1300107.outbound.protection.outlook.com ([40.107.130.107]:6221
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhLIG3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/ISkfZm8MseL46GmGVsppqnObgkif9NQAcH4eAvWcAHvI+GHRkmP4g43v1Lre1O7mN9rrEMEcWkhpBQ2anyu0iR6q11z279X4iN5r8oG9rVQEGShB8Wltqj0mcDzNUZFQ61j58alScPRneqI9HFxn14+BXmEWWs2duoLQviV4m+/71E9ewFSSe7Ce7v3EErg7FdxcGJzGxEcBHOZsUxHOKDhF97fwJenntAfRvKtwpMWs4ANw9x4MsoNen8znSsGU8Xb+BV6qawU1YOPF1Koyh2QwVlL6YdlmT4xA/sMKvnNd+6sV7+Nn+vVBnXHiSyGDPSkBpkDfF0FAemgrbrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m37JUSexpC07ebTkYhe0rxsw/qGaswF0RVKpddalQbU=;
 b=AQB/uJQ+oPa7gQ0+XqhCiT0vtFkf39eh+j/az9/P1RmPVbxd878ceZxujS0IqKeCzqRbxVXcERMufhXSRufV472T8HYoWpng+LF/Ht+ng/xK2vhAqFmLYxpH5vUoF5jG1EVCbMtzsmq+PEkR7xpnyx9eWoKqF4lz47tO7tD5AYwmyQVWdyQBqkaoHnJSTgVNhtWpF6QLLnhoy0P4e2gonxUjUbX8F74jgEWtuBrjx+v0TcAWB7w61EEYr57652sS+f4znUJ+lOFVSSbVmjrSIPlF2YmAC9771HdyZqsKa02098PzKLXBKtVaxsmbiZhoNWs6l+wMT0uh7ifZhIyFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m37JUSexpC07ebTkYhe0rxsw/qGaswF0RVKpddalQbU=;
 b=mkLTOxyRN0bPNfcFZ3F/V0Cvj8lXlQBMnOhhrX/C1/J4kqL2DPWZNaCE2Gvy6peczqDYskgdwCRuiDVxBPO36nchhQ3qQ0snuwfiEQIlUi/bPpaEoIBvtVaimhRR1Qso/CkjFEul4aXoy74RKAya+2u2XLBLn7xw2NtCO5NSL4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2785.apcprd06.prod.outlook.com (2603:1096:203:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 06:26:04 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 06:26:04 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Sasha Levin <sashal@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Peter Chen <peter.chen@nxp.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com
Subject: [PATCH] usb: core: hcd: change sizeof(vaddr) to sizeof(unsigned long)
Date:   Thu,  9 Dec 2021 14:23:05 +0800
Message-Id: <20211209062441.9856-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <Ya/eUbdN1+ABFVWf@rowland.harvard.edu>
References: <Ya/eUbdN1+ABFVWf@rowland.harvard.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (203.90.234.87) by HK2PR03CA0054.apcprd03.prod.outlook.com (2603:1096:202:17::24) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 06:26:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e8bc9d-4838-4f34-7cf4-08d9badcc6f5
X-MS-TrafficTypeDiagnostic: HK0PR06MB2785:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2785EC7D5B730A9D06B559BEC7709@HK0PR06MB2785.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwBGtoTIEGqwJUmoRxOOiEJCk2kDZbPr2BXdewW+faXV59UBryTbFAppupqsz5t4zIjkI3JSursD1w+eKVQ5vUf4aNxvxY1ofPXd0Hg41ChoFAv/fpFcZ4gbdK38lb7DIMEPOsP8tpWbYfM9mI8QuMN3dUNaEFjcpJazNd6YDWqGBmt/xUPQwfzpVyALEsSEaleh+l2je8peyQ92Yu9HWb9XChKcbXMyvWAdFi8YssSw4EHjcp8n1hdflzfih+YvzwdKgDmCPU1igiDPd+NEbS283yqYD2sak58owL+Vv+oTStpJ7B7oFwpGzL4ZWWNgKU9ROKodqw/Oq3hySxCquenIr9ujaW8R8cX9UgwGlVUXvpjc5smrhl+pndMjTIZZvmWH7+C1QmHG+E3b8Qd9K5KQh0g13Fou+S/R7VbBdMAWYUWYQRo1py05uGE/0/zrgGLq+gOvzm4mYMcIliXmaatieLLBZtTVQ0nD6WvzMF13REbNKnm4Wz0kE5IESCxpOG2jSrh6clg+sqKik9gmP8pyfiolVJEC+6NEF2thzRO1MokeEPT4osCHv3gq06dI+g+cRiQ7RTTdlaIp4zi3+Wh9M+rjuVuTRvuUmUlpaAURurFtCA4g1jgY/VeqJ+LJ9XIylx3gTuOLK1hYVObxBfgqcKmaz7o//286a7UAMpHtQ0aB2wIlc2vEdm2E7serMLVQfZhz14rKZ0nnslQOsZ99SpE//b1yk09PphNoods=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(36756003)(8936002)(2906002)(6506007)(86362001)(66556008)(921005)(186003)(8676002)(4744005)(508600001)(5660300002)(52116002)(316002)(6512007)(956004)(2616005)(83380400001)(1076003)(26005)(110136005)(107886003)(4326008)(66476007)(7416002)(66946007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLH20e243wS71HNaPuxC8jpceP9+ee9TIn55+uBu/KGFDVBV2Ja4fFwo29tS?=
 =?us-ascii?Q?3STOoBFS8lH0h9uuTEOXAbZwLysaazNIa8sjOKLHZ22I2yIJ4TdH7RZrK/Go?=
 =?us-ascii?Q?QJ3LsjzbLEGdpkrhCH+DAVwL9A7aZ+37yQVfiNHaT68XB3wq+byOCd/gCt1D?=
 =?us-ascii?Q?VAUQi0UXeIMJsONHQyumCOdbdmJNtMyVWR3otK10TZW6+dFfKbIjXSX12830?=
 =?us-ascii?Q?Pa85b0NAHDux/1uKQSEeQSbgBfJRAO5kOkUzvFaukng2L+u97LSf/S95jVXB?=
 =?us-ascii?Q?ckEanwIc58G8oCkluASjX3cUI9TY9z9OvyaL9qR3heJaodidEOU3iOGqOxEg?=
 =?us-ascii?Q?TppXUDGE/sXOmEBpJlPpUij/vEkiil52QtvgmoIgQNND8tJuPBkxKxNtJhou?=
 =?us-ascii?Q?LM6dOwMB1tz9h7AdHM5QkkpRHtxOz3BitA20GhPxrodqWaKkyDf7JiVEPXce?=
 =?us-ascii?Q?lU2ZUTrBJak3zSvP4QWJXGUpix0zaWBbdymnp1Ut7h7BWXs2kFhUzB20kOAa?=
 =?us-ascii?Q?WWTtDe/ZIRS2aV9uTNWjvzORzwXGOkk8M5wTdrZKSmJQJSO/8gkHjzbqD0ol?=
 =?us-ascii?Q?GLsolBZtdUlvRE2p7PHtE1zEyFIrcFjxDjyzF6PXEw8SJt/id+G/GW5W4vlX?=
 =?us-ascii?Q?GGIehjfMHMNY/iUuh47eEG07Pe8Gw7x6MjCl9yMhnhaZ+b6ktF3RQ+ACCuyy?=
 =?us-ascii?Q?MB/Jxsu5aGNE0PqF+nPsX+811l8twavXjyxQiQzbHmUlTea08bGfPqqivrQJ?=
 =?us-ascii?Q?eun0pcayfnQJhEwuGGNmsEuenPtjV/Dd2ViS2B5yvCTzr757NAgrOO/702M0?=
 =?us-ascii?Q?w5PY0EjWgE9vGCGEjROGqRw5cw1i2HstRImuIdwPFqnndt9udSU5OVK8Zn+X?=
 =?us-ascii?Q?B1zh/U9Sbysfsvuldgh/jnVzG05+Gb9U1WG2TMFdBfltLYFf8JhQAavmsGv6?=
 =?us-ascii?Q?qSE3ElQqMzBW0jqREygqpFLIS3+b31vQFU5Sdr9J0wojFnXzRXdL1WeyCBrl?=
 =?us-ascii?Q?P+bxfR+L69oWmjX5Z2N2T2fJ42Jw7GeBM6ERb1MXqPLupROJXAlIXqy5uDX4?=
 =?us-ascii?Q?EIrWonnGfQ6Qry4XH1NBRbvidF7mGBm2PZWS10PdRLkU8EFL+DMyGTNRO64z?=
 =?us-ascii?Q?hJ6tIEjhmj8FyjcQCtaoenupC+ZSdI+tWE+TpaPR11/ZwlxeBOagGYSWRphD?=
 =?us-ascii?Q?Ue6bbbzScGMrvmmIGLdefPRf6axDQPOxN1EN/EInon42NtO2Sid7CV99FzZ3?=
 =?us-ascii?Q?Sn6uQC9M4P8pCabo6uNwIwXuddld3s7pNL5QKFOPKo5e0TyV3FjTiVqde0We?=
 =?us-ascii?Q?K5HhdIfBpERNKdCKIJJgHN14C9wtI7fNHIarAZS0B0LLqzKtXqSvTLUO63iV?=
 =?us-ascii?Q?k9lG2Phkm5fjrtPPB9FIn8S4dk06O7IKkSCJBLDYQCmH3Df4At5hl8Kn3cVt?=
 =?us-ascii?Q?cXSPFI0lA2QfCkCILH9jV9CTCmvZg/aMVuaqap7+Pqft4rFzEQZ9tLgR5G1K?=
 =?us-ascii?Q?6rmGE5E9W/uITDEG2TJm8hQjypvy0ATGZas8q8d0/DL6749Wdt2ytGxC26K7?=
 =?us-ascii?Q?NgTyMx1v+IlHsdiej7soXFvtI8LOk8vVkHgz1hjxatTnsZPFLQwqEX+UGQ/M?=
 =?us-ascii?Q?KxyY5U4NxQNU+CPrmlYXWek=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e8bc9d-4838-4f34-7cf4-08d9badcc6f5
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 06:26:04.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4053IMW5ieGDypoL9fM5s+gVp3iuqQxWi4n4m/apOEhwYWhyL3fUrbed/BIiWdVDldWezZoraBaGB6mxZ5oKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2785
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`vaddr` is a pointer to unsigned char. sizeof(vaddr) here intends
to get the size of a pointer. But readers may get confused. Change
sizeof(vaddr) to sizeof(unsigned long) makes more sense.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/usb/core/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 4d326ee12c36..9ffc63ae65ac 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1281,7 +1281,7 @@ static int hcd_alloc_coherent(struct usb_bus *bus,
 		return -EFAULT;
 	}
 
-	vaddr = hcd_buffer_alloc(bus, size + sizeof(vaddr),
+	vaddr = hcd_buffer_alloc(bus, size + sizeof(unsigned long),
 				 mem_flags, dma_handle);
 	if (!vaddr)
 		return -ENOMEM;
-- 
2.20.1

