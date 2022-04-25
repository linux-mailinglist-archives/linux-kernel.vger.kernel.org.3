Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA050D974
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiDYGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiDYGcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:32:03 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C95C652
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:28:59 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P6Sw85026158;
        Mon, 25 Apr 2022 06:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=AHx+CEOJt+Vte8QcqCNRag05+vqHqsNSSfhDQQZ5Bek=;
 b=m+ny9tyrTE09WW2Xy/qvGWs1v3AZ2vKkFCsZOs4HdoFWUx8P5xy2JvJvuR0li9oqIhf2
 YlMqwEbpaqt+UrHkCQAmpNovb2FB+tMm2rGf7nLYnbk1a6+6Xt6jGsTyxKIbNhuNB3AU
 u3GOUNdbj1q1gHiJa08gOtE48vtcanezaW7/vnHU/kkWq3zhJ6hpngajK/ktSCM43w0w
 zrAVGBYz8V4pam8m4PUr1Ut3dTQbgPC7fGaPM2QhYWgd7KvN6eU3Eql8AKdKILP15BsI
 DK0Wz9D+Nr6PnKDz8a58AUrPdYtuPCKPWASIhuWc9M4SkzLNBSPfzhMIq3BW5jRKJAZX ww== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fm8e918fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 06:28:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI49vZ+p8NRSG2WtcIgr83xZx7F1RGXh4Z8cZlsAFK/DWoE1LbE3qsE8fVg4hx9hE0LHcT5fI6EQIQBO745I4mop+oqQcMRCaRMsUIIOZ0QHwJa1NWWlBEi6AhbQv3PGdPxG3ec1vCH7Aa91Thgf06GNHr9Gy+bwPua2Qmx9J7ERxcjKx8WNJBWSYDzdOu5sL1TzJklnHZ1eDuK1Q94fHdIMRuqlfarSulLDPLeVgtMvs94Sc0XyWfmTFbR4apAHb2zb8N1GissIoQEkguFNaJJ3lTLfbRE6PCRq8s74gRt0tBrMFSdl/tZhK3d8zV7f0/iiA1ZxZF7I3k3zQxChsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHx+CEOJt+Vte8QcqCNRag05+vqHqsNSSfhDQQZ5Bek=;
 b=oQWJmVH08AjZjnFQmLTA063I96d7YZoV+U+SIi48XMm7x1CvUHF4ERxaz79eiTs6yPrSuHQnpEp1cPvzSQqD19OoHEjEv9Qlf+C7yTqvY4gLFUB+syK5yUJ4Lhyvq7RNA5E5O+/WB65Jnq13cvylbC9/x7kWJum/XxZ+P8l2ILpMTD72cxbYljNyoH306z/wnp2yT72NBmSZYRkwmjUVqVJGlf27TvB2Q4u6G66j+yDu1ZN4RZJ5+goT5LfJOw+WOleGDetO9OgC8FFi6O2wQrdBTNSDCNfQfs7+5lpTLvHrnHv3+ZFUXupq7LpywJSjDvemfTmcMp5jLkh9m8+4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by SN6PR11MB2749.namprd11.prod.outlook.com (2603:10b6:805:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Mon, 25 Apr
 2022 06:28:56 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::1cd4:125:344:9fc]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::1cd4:125:344:9fc%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 06:28:56 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        zhe.he@windriver.com
Subject: [PATCH] lkdtm: usercopy: Make USERCOPY_STACK_FRAME_x able to work for all archs
Date:   Mon, 25 Apr 2022 14:28:35 +0800
Message-Id: <20220425062835.3945462-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4f1c39f-c7cd-4856-741e-08da2684dfd1
X-MS-TrafficTypeDiagnostic: SN6PR11MB2749:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB27495D6CF3AEBE096AE5F6588FF89@SN6PR11MB2749.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2RsVLrHz6Q0vuh55aoimKpho6SnBlPB36s1hKOtNGeeD5Vb1ZUwGDjqxqB+PBPJFETaZvwiEeVnoyQh7lVE0ts1bIQEl3tGLfjtJtjrFkeNcy73NHxURZ7twqTWjvr2cPCqLmtmt7C28Mv2bjjevXtRNUqIKaOGHuFgP7ZWNryf73cf4vUErrN1z0+fseYNrUTVZCbWPFENVpwwM3ee2SGFa0xNVScMgtfGf2AQS6F2G/VTftYcvNdcHfLwxF/Jq31ALR7XRWME6WAU2cQzwI3XQ6C56+B7c0paAcB896nZJGNZ68GpUKccoff5ZIVHeeptQ0dtMpOMiwB57fHArp6lFBHt2DC87SmbV+8l2EdCeJQLfyvhIdCZHOTteD6w8okPBOP6ccb6TVPx4wQxmJe7pE174tOas2hJNRTWvF08RF3uXUUkaHGGat67OjxLpSmboaU1IW1spI/aycnz54x04MZtaC3kqNJVE7otIsDtolijqZZ7HWRcTCS7zZqBycbS7h2MpVMtdQn9g79Y0Slmqkp2T4+WS2fhkeXQuqS6bnGpqBNupdFE88ThN7FtnYKg4QH9DD396PqKSCQjfu7rWsWwUoXYUitgIOV4XtvDzzaFBzX0JgSoQyFN4IgUNHxAWV3Ul5cJlgn8wou4Go0YxNt/Nq7QY6gFnZGNjcyy07aO1cV/83wtjw/La8MCRBC+pFvyE9qoMzfFrJWiFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(1076003)(6486002)(316002)(66946007)(36756003)(83380400001)(66476007)(8676002)(66556008)(8936002)(508600001)(6506007)(86362001)(5660300002)(2616005)(52116002)(38350700002)(38100700002)(6512007)(2906002)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bDRCSUFrpZrCVIOtV+JUTK4s9/KR3nAHE+XjEUwHraTa0DL04QuAaQxSUvTo?=
 =?us-ascii?Q?8ZPtKMAsI1FZIrvmsSVnOGawkjDAhNEa8uHP0Odkr5youWmU7ppffSiFj/74?=
 =?us-ascii?Q?6IdULJIaz+Nyj9PxT20TXVf+WOIZu4IE9XlqimnY4HV2FLfnDQyQGpGcr5R1?=
 =?us-ascii?Q?kxTJKZP/a2gWaqmNQEkOhaoSWf1FpdzcidP8krfQ2WOqTXPLsHySp67AVu8A?=
 =?us-ascii?Q?aaJpBKeW5YtRlDVqjAL6EYhHlp4zC6CEU+OKY+BGwqMIMllHwcQRSnuWQus4?=
 =?us-ascii?Q?isHTbvQ8AV/Hq2ZWWrCnKs/79qP5in7pMDkGU5Jk2tZw8yjQrLVPC7lw0cY6?=
 =?us-ascii?Q?FIt85hqYrIlH7S7T3kaCIZ1qT49B1xOiwdj2eslwUtOB0Soxy3YmqTilJzBl?=
 =?us-ascii?Q?NYc1wSVr4oGpXIb9sFoobIlbgE8YcWLlNztzwB9sQdQIBY171F/myg/bVA06?=
 =?us-ascii?Q?HFXcqL45YqVt3BrR0pOk5ZHQTEn9YBahAJQHK7bUmdFlOahyiVhzIWsmLZXj?=
 =?us-ascii?Q?1yfUgw2lPH4shYfddi/VlcnyRgPnRd2y3X+m+nemlIFVWognrwkXLBIE3yes?=
 =?us-ascii?Q?Y5MGg/zldvAtWsh9H4RgEGww7QHf8oO0Jq/fPCBcUtlCfN8/knA9jWdl0c1w?=
 =?us-ascii?Q?QW6Owy6DoH8FMW+TJVT6Y8eNZzJiUF9dASalmwvs6KVgjaB4tk+Dg/GaTZ8i?=
 =?us-ascii?Q?h5UIgjEt1vA1gGfv40B5NyOa7ZC0sQQVU7kQNIvGcGWuvt9jtAnKidYEvuiq?=
 =?us-ascii?Q?s/ttRqJYMsH/ljlzqRn6ZngkJwTCPth4QpUITBoHI0MoM/9/lXV+Yw5VfqxU?=
 =?us-ascii?Q?Lu98LOt7mDoK3OkLXmC5p05TRehJjtWLGidcRJtWMaduwSVJsfi2997BfTme?=
 =?us-ascii?Q?jgXO+3/IpOa+NZaSXGwHx/HqWYoBaAmGFgQWTIC90IOJf0in7ylW0GTqjHvu?=
 =?us-ascii?Q?VfO1wcF9CgOa4oQniwk/HTytQgsC3RpY1VI1OMUfS8cvNhtlGvVFkuLRBACj?=
 =?us-ascii?Q?0QNdSVU+EItd4r/caaX6chKZgqZOtNSMXz4bGPJ3EgFqfdrwr8JKHyHN0pPj?=
 =?us-ascii?Q?w8PwON/+E0fftDVGxlmHOtaGJYZXCQVam78ji+6TUdDlbGt6BtdiVTt8cOku?=
 =?us-ascii?Q?+UPGvHIdRATbxzH5+zrVWDDW+V/PLoF+g1kyJ7R5ttwOosQmNtnasUglLwPm?=
 =?us-ascii?Q?CUZOKD/KxxysTd75tCUPBaAJSA0VgWXaJDNkRyhuciu6r4J3pMgmeBNIUZWb?=
 =?us-ascii?Q?/lN/E7ogBJhdT+NDZUPIVFeOLjQIqsoi7BJ/AyqAOTMXk5GfMqwQRaJPAf5f?=
 =?us-ascii?Q?Wr+dmeZHmk+pF5XyBhBQa81aFaFnfC5DIEOuOSMob+Q3f1//1vBV6k/1XK7C?=
 =?us-ascii?Q?LQft/vZkhmnH3mY/xrB/Kj7xEBwbJS0yDH69xnmrb4WPlpndqsf6+58bfBQq?=
 =?us-ascii?Q?JMq/JEz2we84l545YxdbQc2YjkyNzPo36bCp1gAYIQGL4LiOB2aS2SCCWT0d?=
 =?us-ascii?Q?uEFCVGl+akiJX9n7fzQjanbxesmYySEKBDtY25tz0Z+KBSWi1I+iQCTZgyq0?=
 =?us-ascii?Q?e8kxX2kvxE3e5F0L6JgPLP9DHXkapvSXkiKO/MgLXyugaFk0xv5rks78gd21?=
 =?us-ascii?Q?sMLFVN7GVv7Y8RYhZoqO2MSHin380HW5iMA+046dkl7o9NGLoLbXRtMC5saD?=
 =?us-ascii?Q?xj+An8yBUW1K7eQV5kG/n8G49AqtXaQOaGYYgZxD2LQ0tg21Vvi76C8TGyC6?=
 =?us-ascii?Q?WpHq2URNSw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f1c39f-c7cd-4856-741e-08da2684dfd1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 06:28:56.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m4f5R8MicvSP/VCnXlABxYYUmTtKgeIpdpFOVVKikEiOC2bJmuKiWPRJnZhpUftJNz+nZQkHC7eLT8533K+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2749
X-Proofpoint-GUID: Wn-Ibqcr5RBndaFcoGCXcxmNXMWXRJvB
X-Proofpoint-ORIG-GUID: Wn-Ibqcr5RBndaFcoGCXcxmNXMWXRJvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_02,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=941 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the way to generate bad frame depends on stack layout of the
architecture and compiler. It happens to work with x86 but does not work
with arm64 since it ruins the stack.

On x86, the original do_usercopy_stack_callee returns the start address of
its local buffer which is located deeply enough in the stack, so that the
following arch_within_stack_frames finds that the address is out of the
frame under check and gives the warning.

While on arm64, the local buffer of do_usercopy_stack_callee is just not
deep enough and happens to land in the range of a frame so that
arch_within_stack_frames cannot detect it with current algorithm. And worse
in USERCOPY_STACK_FRAME_FROM, the immediate _copy_from_user writing 0 to
the returned buffer just overwrites the return address of the call chain.

$ echo USERCOPY_STACK_FRAME_FROM > /sys/kernel/debug/provoke-crash/DIRECT
lkdtm: Performing direct entry USERCOPY_STACK_FRAME_FROM
lkdtm: attempting good copy_from_user of local stack
lkdtm: attempting bad copy_from_user of distant stack
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

The detection algorithm may be improved in the future, but before that
let's tune the test case to validate current one. We can simply use
__builtin_frame_address(0) as a bad start address that can be detected for 
all architectures.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/misc/lkdtm/usercopy.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9161ce7ed47a..000a1be15200 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -24,28 +24,6 @@ static struct kmem_cache *whitelist_cache;
 
 static const unsigned char test_text[] = "This is a test.\n";
 
-/*
- * Instead of adding -Wno-return-local-addr, just pass the stack address
- * through a function to obfuscate it from the compiler.
- */
-static noinline unsigned char *trick_compiler(unsigned char *stack)
-{
-	return stack + 0;
-}
-
-static noinline unsigned char *do_usercopy_stack_callee(int value)
-{
-	unsigned char buf[32];
-	int i;
-
-	/* Exercise stack to avoid everything living in registers. */
-	for (i = 0; i < sizeof(buf); i++) {
-		buf[i] = value & 0xff;
-	}
-
-	return trick_compiler(buf);
-}
-
 static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 {
 	unsigned long user_addr;
@@ -59,7 +37,7 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 
 	/* This is a pointer to outside our current stack frame. */
 	if (bad_frame) {
-		bad_stack = do_usercopy_stack_callee((uintptr_t)&bad_stack);
+		bad_stack = __builtin_frame_address(0);
 	} else {
 		/* Put start address just inside stack. */
 		bad_stack = task_stack_page(current) + THREAD_SIZE;
-- 
2.25.1

