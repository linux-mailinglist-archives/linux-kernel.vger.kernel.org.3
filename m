Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1390D482D00
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiABWfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:35:15 -0500
Received: from mail-eopbgr60109.outbound.protection.outlook.com ([40.107.6.109]:38628
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbiABWfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:35:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH8wymgk4v9pNILZDzpjWv2cQgKyrw/56FUaA6orWUzSbKntVn13QjNribFRs5+vf8C4TpAn6LBmHAdMIez8xs+gE8QZRUywjU9cVbFyPmGfuGBlL8T0xNiz7Pr+js8HG1JAHpbgzbYg2ISVHzB8cj5xTMK/D7y88gVaIl8ie7DAUQ7MctEF/STRBHA1MbeX3JZzJllHU5u+yzHmfJQHPgslSJdTxLZ6RxotnHb5VGXlhsqbtWQlycnkKhgdQTCNjScU8Kvyo+/MtZsOBSEuw8vstWEdavZm8rttd/ZRQKmpBhcKFGDJURlCvgobt3m551SCqDIvwelOh5e+e+n8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uMAxwT0txh7w8O0YWF7+73NkfsdNNqfV2KSQQd0x+s=;
 b=hRfUdBwbwYNe9o3qwEgn+pKeueUhcuk36wbljxFpDoByJglUS208i8ALsd3suq4rGRxoOjDbA+FVVCzVVkFCMNxgdXKLYMhd7UaKXujpACxDigTb0b1GmRm/SsEmTBHCZRHkEOhFsqp55hjpj7AEZ2DrJ+4t60ewYrJPZcyrZU9fVf0nUNTR1sxyz/Sd+3HsIAzvNYThbY0/HwEi4Zs4Yj3Uo7rJgCepW8jUg8UjlBBCDjCL339OO8hvQYCcjxfyVMlEx0cxiPCBs7ZsxgM9BNGYJRqebSqXCLUVtCVL+ELMtmB6toGrT+Nb+4B+w/nzn9xB0d/O/DOxi7SdqaSgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uMAxwT0txh7w8O0YWF7+73NkfsdNNqfV2KSQQd0x+s=;
 b=b7G907EwfGfH1to9+Z220tVn018NlFpMOv3vBnylJTzTELoPFzRFe7UtqmBWsKJ+eNGsjmjt8Ft+bG0GqfCMykjIjMGUJ2MGicCd6gbc//43ohcJhcaDuoEFezsdNj8Ooy7h3iykYeBuIo7WaKyrV3QGxJRoAmmjuRvFsTDsEl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:35:13 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:35:13 +0000
Message-ID: <1d01075c-ce9a-ad36-a8a9-1528f41579a2@axentia.se>
Date:   Sun, 2 Jan 2022 23:35:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/6] dt-bindings: ti-serdes-mux: Add defines for J721S2 SoC
Organization: Axentia Technologies AB
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0013.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d76ba48-a93b-49df-9166-08d9ce402438
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB29205EBFCC210FCBA9335882BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJmv6botGhfSvM/MIPCAirFwzhKOatCzspjpHdit2WtgFvXfl8ejg6BQOYfOnxNsUltFrHLSnsmbHZe0EARdDRIgzfvdIxeit8ZtOyMGU79AfbDzFfz/xC4VHYJlEoPF8dWB5+T+U+dq5gHQrX8b5HsmpvZk/ATv1H0bf5chUl5mSBtCgtwBJ9jUqf4wMdHkjE9ydKTSf6uJvzNa/Hr3UifXOuZ+cFStNf77pBfgmt+W3B3JczDdx/gLk7scm1jW/U3eCaL/JPfjPdoIiTnzDS4zP9bLelSz3qtL7GvoFhJlKQQFjzGk09Ym1ZzlgAOQP1dFizQkwKC++pr/wZlSJQd+38+RFiowTRCXImJ7JqrcLklqPDHAM6YTFZepFy2rOkdvDedBlsQ624s872reOAcJkVTByWEfDzRdpH+ByPlbsmW4KkRhJ9GrcaCcgucALPRGS3Uai3mjuENKbdoF2AWm8VC2BaH3mReLZK5w0j7WV25DKOFp95z5KVT2lgBIfvhadZglVp3OtKBmyRN0TfXl/aRsHxfNIQCHWvQOiSN5g7Z2hHf8AzU5KNRDUz7fYcvNlwWq8b4+S0S2mFqgmB/eEu7V5lMniFW7qLhYhuxZUFslekfjHuissOR25ayzj1XcOht/+4qyQEhH1shVObMlDStWmaWBh/cYW6hcruzc78hk+smhaRns+ikvtI5s/o0mSkTMoVLIG+tFbdVMYOdsyKn1fbFDbwFcyB9VvhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(6916009)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDR0aDBRZHBCdTZYYWYrMG9BbllaK3hGYktlRmRiRi9jWnIxY1dSVHVsNTRS?=
 =?utf-8?B?elFWZlYwN2xWL1FMSkJBVVFKRzNNRjBEdkxML25wMHBNUWlJUW5OY3hRaHdK?=
 =?utf-8?B?UlNUU1RYUFBSNUEwdkRoSndqQWJLWTErZENsQnY3UUVPcU5WV1ZlZWd5aTgz?=
 =?utf-8?B?bFFRM3hxSlk5TmNCUS9rQVE0Vmc5bkg0QWRTZ29PdU95SDNPajJjNWllRkVF?=
 =?utf-8?B?NFdJbkhQemd2Mlk1MUlqaTlvQTgwN3ZGaEF4Nkk0SlA0Ym0vNVJyMTdpZDVm?=
 =?utf-8?B?ekJqZHg2QklKS0RKMGg4VzVBKzZoNEhTd0g5dmxkOUtaZm5Jb1JOZ0V3U3dj?=
 =?utf-8?B?RTRhN0JSODRnSFBCajlaUll6QjdjWk4zQkhvSjlOZERjYWc4bjZ6by9oVG45?=
 =?utf-8?B?bDY3WWNuRHhPNDFjcFF2dkFxK1B5VWlHRkxJdTFuU0QxM1ZqLy9XWFNIcmV3?=
 =?utf-8?B?ci9VMWxKM1lSL1BvR2tBK2kxZVJNVGtXTzRNVnNsRmY1WURhR0hFNzJCQmxK?=
 =?utf-8?B?d2o0bGt5L2J2ZGhlY1VDUmYxMUxhQ1ZyMCtydmdSdXNVMm4vbGtQd3JZSzlh?=
 =?utf-8?B?Q2hLSFhHOVdCK3Z4SG1BTEZmQmZJMkx2YmFOSjZoaEE0L3RxTFVMcEJoc0M4?=
 =?utf-8?B?RmF6aVhLOXdYR1RqNHVKSGNDSDBNUDNCSThpdkszOFdQcWtjR3J3R1VoV2xk?=
 =?utf-8?B?RndTekVEdVdSYkQvaC9sL2swczgvK0MrcTFPUkg5d0hRVkFtSzJBMlFySEpX?=
 =?utf-8?B?ajdHNWEyRVczdlZXVWdoVTFtemF0bVF6djM0MjlHSlg2SFd3RWdjL2psOGwy?=
 =?utf-8?B?SXhsUjljSUIrSThKYzZXU3RtUkYzT0NYRUNNRW5kRmR2QzYzS0g5M2JRQzBT?=
 =?utf-8?B?UnUveWRxMVpKLzJmMHNwOU9CK0lyUU9QalltSWkzY2R6WUFGSnFoY3lpdDBo?=
 =?utf-8?B?WXdud1QwV3J4b3FXL2FZeEQzUVA3UnQ5RldHZzdwZlVpN0JqNDQ5cVkvTUxI?=
 =?utf-8?B?bWlldXlIN1FPYXROYUJaM2Y3Vmw4U1pjK3V4WlFCQ04rRHNISmVqSU9CNGpa?=
 =?utf-8?B?bzVYdFFxbHlVejdOenV1NzBHOHorbVM3aGgyckI3ZmM1UTZsZEwvSHd5clFF?=
 =?utf-8?B?cUVibWduV1pTNXdXcEFZQVF4ZzJiT2drdUV6Y05EOFQ1Z0Z0aDlqaWsvcXRv?=
 =?utf-8?B?WStNNDR1S0x6R05hK2lKVkplT0N6TUFNRlEwdUxXdFJYLzhJVDBEbjN3Nlph?=
 =?utf-8?B?U3kxbjg1aHRrN3RFU0NwZ3FkMHRENlIyQWxDUWIwVzBBMUdBOVl2ZkVBYVJz?=
 =?utf-8?B?NkJIbXZWT1d5UGZ6aS9jVkpuRHVXQmhRL1N2REY1a1J1U1YvNVArQlQ1K1Rx?=
 =?utf-8?B?K2VPc2lDSHQwS3pWWkZ6dHZVcjBJOGdrWEx5YlVQUEVtSjJmaVFsOG0wSm54?=
 =?utf-8?B?UkI4cS9HWE1NUU16SjR6Sm1zeG1DVnAwZnBHbUNrNlpJZkZuMHlKTjJUM1ZR?=
 =?utf-8?B?a1Q1bDcrcyt6eGhZS2Fna25BVFZycjRVd2lzV1JRc3pMRHZzNExDVC9xbUlL?=
 =?utf-8?B?TmgrZWhCa0U2bzFacGluMTJLUnhWWDlkelFSMVRhSEMreG1XT2d4b21sTURq?=
 =?utf-8?B?Ym50ZWhhY3hPSDBWQzgwR2FoMlJGM2c0Z3VYeXp1R3FnT3V2MElMYjg2VUZY?=
 =?utf-8?B?L0lKNmMrYXcyRWlWVDFsSXlTRlhYaUFSWnZEVkJ4NEZmdDdzOUhHUGl5T2xl?=
 =?utf-8?B?MFE2YWF0NTMrTHdNY2tHRzhaRHRicUtUQVZuNUVFL1YycXVqQ2dVQ2FhenZr?=
 =?utf-8?B?czFZaks0MEFpWk9jc0hqeVVmbW1qdUQvcS9aa084RU1jTmJHa01DNVlFcTVC?=
 =?utf-8?B?NzFZemNjMWVKV0V0alEvNjk0a3F5V2ZiS2RpT2FDNXdHWXdqc0N0VXVCWEpO?=
 =?utf-8?B?RFIveFhleFRLSmcwUlZpOUEvY0RXRHRVejdkc0hnWUttYzdCeEJ3QmZDZFlq?=
 =?utf-8?B?eUsyQnF6NlVZdTRUbGJHRGJqek9Lb1JTT1F0YUpyeXlRcTZhSHQwdkhpOWZX?=
 =?utf-8?B?M2I4ZERjSVNXMVNkWW8xTnJYOEduRGZoTUxNbSswVVV4T3UyRnd3YnhJNHZV?=
 =?utf-8?Q?xOaU=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d76ba48-a93b-49df-9166-08d9ce402438
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:35:13.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE/yN7e/XZOwzahOWa1QkiuWvKZXE/nQVMP7gVrHBPmLMZmhI1F3oRBhdGbz1dvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

There are 4 lanes in the single instance of J721S2 SERDES. Each SERDES
lane mux can select upto 4 different IPs. Define all the possible
functions.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index d417b9268b16..d3116c52ab72 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -95,4 +95,26 @@
 #define AM64_SERDES0_LANE0_PCIE0		0x0
 #define AM64_SERDES0_LANE0_USB			0x1
 
+/* J721S2 */
+
+#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
+#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
+#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J721S2_SERDES0_LANE1_USB		0x2
+#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
+#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
+#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J721S2_SERDES0_LANE3_USB		0x2
+#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
2.20.1


