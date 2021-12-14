Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2547423B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhLNMRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:17:43 -0500
Received: from mail-psaapc01on2096.outbound.protection.outlook.com ([40.107.255.96]:41633
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229545AbhLNMRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:17:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ+sNAr0LXjpzL9nwi3goZ3TqdYNedUG2YEGmR1tLCao7j4LD8tXKV+sc9vZIGC0XHQO8uGivOtqGubJ34mnjp8Jc6Kf/vEnZhmvdP8jTeBRO2AGNkaVACJ852VW/idmkk51/4jrHtkf/UAXERPr3YVyXrVvUrg7OnjWlkJCR6Ud/ow+z2QmVLIoaLIi7rWoVWK7FXniNcH5XcaqLOhwOdU8Gejv/Im6Y4crXQzeBetk9G97miAs1UUjKeMLEDGEznHbhtHpNcgz0W5xjtMTPPiay5scsNeK2cCGHQTYppTh6qB4CxIfC4KN6ohE+vXFEaTHmbAsoeUhy805NZDhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V57wB17+Ox+ce+tl/F+0UgkJIrLIA74tjkXeHuKWSAg=;
 b=GFApu6BW/hQfr44ZL1Ac7A4RG7czsqgq7PtbGOFnmGxOUZIqfOM2skSlkEpZkEhIFE56gqmghK44F1DG4ukyE0CXCbv/oqGX8X8ujuOr1pNMWYp3BpL1UdLgD1PE8tjsIOpIFb7/WX3ttIVk/4TLdk0kTk8NWQnpHS01QcWXG4w5v2DVohFoTzL3+di6a/fuMT2yaXJ6cUezewO1pYCh+G9wpPQG2VDRRLzPwBKZfYJy/ik0laBeALQ7CpZer4Tzokf0M4vEPTDZVKRo3fK8lb5kvdBsI8vT/sfyd6DfKMbr6roZjf4rtNNTcgkhrpPuVmAbOpRcKyHaaBiB5xvbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V57wB17+Ox+ce+tl/F+0UgkJIrLIA74tjkXeHuKWSAg=;
 b=V3KZbcmUS1rRuRmPIea2YAA4+JiemZIP/jRmgC14LKMYz2gXUEaVoPS8QZg68LNfuyMN9/Yi0Vzm2qPr3Z+8LRSiD0Vu6t+RQo/gnIr3epagEOdLSGBkZAFJyoj2yDZ+2/2MnLphFKgAay+pk4iA9pGdnUYrJNloLlDU9rWLQjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Tue, 14 Dec
 2021 12:17:38 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:17:38 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arm: mm: use kvmalloc instead of kzalloc and vzalloc
Date:   Tue, 14 Dec 2021 04:17:22 -0800
Message-Id: <1639484247-75684-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41420b05-36b1-4e69-bd3a-08d9befbb802
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3003AFCE451199136713ADF7BD759@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +E1yJ7z0cYizT+kDPU3jHx+hPeZ0yig+v/usUooAxDJs59AV2PFEHtbXfDocF8F3wMJTts3pndgnVvteQHichoME3TtPMCK9mFChlOo39aByYidaFReKpPp4R1YyC+aXW5jEC5qCp/NIKPE7PdePvUgAko+u9gLMrxAPNX/cDbdrqbqF2AJ4giierpaibMtehl1/vvEZZqXkTDstkxLoaJL2EchJ9Z7v5mBkryAVMFCYF/CyG+eq+iwMrBseFbrwqf1eAN0V4xtjfCRzhaL74chLvzuati0Up8nVbsXVJ7YvFwsT35KfkbNFrNKduZZfQOah4LmVYx4lTE/gJJm05xCkoXWD+seSCl3iPw8EySbs8gfsNj5ovxTzXv1zeeHYIb5ArHibAhHv7+tkwYH3bt2A6Cuy89M+kIQYsnePZQtgpGWhsdSwj6WmirAhEwB1ch5+WjzDFXRV8vEOyEjAhfVcNGHs3oITRrhaHI/tyZc7X9BcUEszJtPpWcF1f8bOU1Bhr+VDFyqzRLK/GhK/dcC7a337Zi/g++UkRorAqvi+fqtnWoYKte+TLluEASVYVceT2Ba1ZRbUfkL2HkPcaIbch8K1DZ9rln4KV8WQBa3duKJMb6Jy6KcZQbJSEyBXrCEzhH9DdXa/WabO7w/wcVO59RpXofyPoXqrhGeFyhyyM3R1B+pmXDWtfrGU4vGeJxeX4DUH07qMjV06p3uNPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(186003)(6506007)(83380400001)(6666004)(66946007)(6486002)(2616005)(4744005)(66556008)(66476007)(316002)(8676002)(86362001)(5660300002)(8936002)(508600001)(6512007)(4326008)(2906002)(36756003)(52116002)(26005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L0xSm179jzoil43I4364KAwFUkA4dBx3L2tWWcUwe/18Dj6UiZVn564PEpEb?=
 =?us-ascii?Q?xa9RF/CSdEV1oJ3/c3cPsexzQKYq9MX8dCu/Vi83b/5T+LX28bAXpxyQ/eIj?=
 =?us-ascii?Q?mzPFPPmI4a3vTRl0lYEKLrhD5q+jebgeqWWRCsPzTEYy88Nz49/575KevVHS?=
 =?us-ascii?Q?zNuWR3gQxZHuseddNhE+7PFIKIwo0WYqiPmQIQg7OG8USzNeSauUdV7RfJgH?=
 =?us-ascii?Q?3d2LPt5myx83mkZ/mqkZ0viTQSp1kTG1azmsj5PgplCdrdKK2/fBUsDHcgpV?=
 =?us-ascii?Q?7GmVqvFV8MfI0d372tAlc1hYznrRWM0QnE0F8d61yV5IflpwBYqWYJEHn/9T?=
 =?us-ascii?Q?gyziOFxJX3kqDdRQn0jvW6Tpqa7l6gasSSTfOuwyamZ3mzohEmZs0b/6M8db?=
 =?us-ascii?Q?nap2mG8rl9VAdATesM+c2EDLn9/GIinQptYNd9d6tu2seq6Hy/aHhth3koYs?=
 =?us-ascii?Q?3YkK/tG1P70+Zz1oF/s4irjgfCRdNrRQjezNA2N7a/zHVWIoAugG3+wRKnRs?=
 =?us-ascii?Q?ysoxUq2PxytSAM7PrwHlSlrxz+yzIrNk5hvEnxHWP7H9CjcLAlSJpACHMMZ3?=
 =?us-ascii?Q?HOU4fOBVoxb/1S+24xJM0GIeCB7ndBQrW+idkBridS0A/JuvdqahhtUFJlbu?=
 =?us-ascii?Q?uUtzNr0UehascDOyxPK18wHovA9hpborQIhhkEXAfNnWGFm7kOXSjDOVTVxL?=
 =?us-ascii?Q?6GRltbrfrZjk9YfHPlhLNdZ2x4pRbGx1CiZZo5+w6w5pj23O5x5UZ7D2mK2m?=
 =?us-ascii?Q?QDUm3MF7kKW3lk/rSdwTVS6SQeHi+hXbIRILcUc5v6uDFiyjVMT7IgpiLG7k?=
 =?us-ascii?Q?nWgfPSkVPMjzvRIwOKoRIy+dSZ8OKMoR5aBYf/593yYV9FdwN2q4lQlFfpnD?=
 =?us-ascii?Q?XlqAqFIVFFph6306gm9i1YBBWj3Ke/nv0TPIKLo6Qod0zE8TUOlMpfe1mC3k?=
 =?us-ascii?Q?4dMqQ1J9qCNcmzRylFM3EzvDbQ2A2MwX1fVnV5Cg/3onl7XWrz9BCErxgqBo?=
 =?us-ascii?Q?dh3r0Du4bbnD0F0w/68wNOiyg/4c7fXXNVWx3YpD/CX+4fPgiMNnw6rU3hgT?=
 =?us-ascii?Q?5+YtP5TBgiirp83AzhDkyJMhFVOn4PiOVxBx1NJFRVCGiOE/fDBwncUcuCwj?=
 =?us-ascii?Q?jtXVSnT60Qr88SSoO0rN3AYrUNvwrs5+OIJTJM8S9v19bjCeeTeI0n7j7eC8?=
 =?us-ascii?Q?yEFZIlXzYWr2ouBoaqhd1mI5Tm/N8WNziEqNpSPaN/1ogPOK2vYTESHwLPIf?=
 =?us-ascii?Q?b1wXMBIVi++GScoh0dB4uIPp7vmn2+i4ZjE+6UZyl7ukJQJzgpaSuNtjzEez?=
 =?us-ascii?Q?BPmTmhLCTi6GTz2WhFfAjR1i6pSpH29zOPKTJd9FXNjXGhVcihRjPzdhT9Dm?=
 =?us-ascii?Q?DW1ps8KbDdK4MlZqAnZxj4o1+LludEUyoaQcCPvvY/WtIAz+LIEznk4S46m/?=
 =?us-ascii?Q?E88U78mGoy6NqZku388ctMJqM83JrD1QBmxUW4QhDnTEuwBZtC7b7W8se0d1?=
 =?us-ascii?Q?sgVOTwqvdlHsxZ90o9irR+5dTqWheUZOhhrv09KjiwEeAe1YlA+2GKwURgDl?=
 =?us-ascii?Q?rto5TQrWnZh89bV/CFI33RSyVB/gs05H/EVwKqqf2p9f5W9DDqQZPNTBMwmy?=
 =?us-ascii?Q?A82PYU0jIwFa+yv+UFL0CGY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41420b05-36b1-4e69-bd3a-08d9befbb802
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:17:38.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c357FGuxilamee3zs/2lAn3Z/lrf2FOc++wb9RhZxhssq9Nyve1SmDMh/1MC8jiB2+2ekwp20QXY5hWniV4HWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

fix kvmalloc.cocci warning:
arch/arm/mm/dma-mapping.c:1209:28-29: WARNING opportunity for kvmalloc

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/mm/dma-mapping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4b61541..0fa8801
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1206,10 +1206,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int i = 0;
 	int order_idx = 0;
 
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvmalloc(array_size, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.7.4

