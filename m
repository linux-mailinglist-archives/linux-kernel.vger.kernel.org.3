Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55150EBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiDYWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbiDYWVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:21:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90308644E6;
        Mon, 25 Apr 2022 15:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PneKFFdCBFRNLuqo4vt7WhHL1V6MmokbBbh290DvwoPDPQs0Di5bgQ+jVlKT9loAtFsWDtbbWhMExIKLD9dbfyvc4AZRxBfQ1geJBDr5ZVw2A6UD4vqNM+iwSkAhzLiw36LBCNJCs4jivDSBzXFGXFy4tjTZIPOtPz1u1+38noRcVFMGDvkVl8+t8Jj9taCdu81RhyqXNs81dTfouIPeUmoWNc2JDnvB3mVzlQHf2PhAvMMpH8bYD+syCTbekPKUwinto7Nimnqq/QXQeeCmcTdtf9bW5qreQJWJ/N+Ole6qPXd/0GrR0wAnJ0tdhBajby6KYf9j0fwRefn4NlnhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtrvvNBlBlQElBlRpv1FH8wYGHhXgw41j18xQ1uOJaM=;
 b=A3ptzbBPpBYBHfGVSPpbFIpuly5JOam08RT9asjTOLQnacz/8qPVCFiND/fiSahKg2a40G1n5OQtBYE41We3wuIiAcZKgIIjsraxdv13PxJtrXztj1CdMOc+aow85yg7HM1y+E6BcJeg2X1/00wgcR8cPQmzDbdhA7u8dLoaYBLYt0bX4DKCzvNBbwhhCQJWErMl0FYofKFERpLJUNx/T4HjuIj3b358bwyQTA6RL23AeArTd0DZ2NflTDKHDxhXYfGr5ck0Ua5SM9tbVa5Hh07wztTBQdjxPTxkLihWXGqilpeG+X6TIa+Rcfaz0yhaMnco4Q/+Whr/XcfS9zgR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtrvvNBlBlQElBlRpv1FH8wYGHhXgw41j18xQ1uOJaM=;
 b=X2QLgZAF0+BfjtaQDB2fahjdoiJAMDpnxy7HIXeKz/IRFqUaaA9SXs/7HwURFKa0hZ/gtLscVtviIhyW6J5nMQUvRUnqKbsl47aBKAGYGaz7eF11y0co0iTrcPAJ/RFlOSsyx1Yq7k9iejap5gZk/9hup2TB+cNHH3HYqt0QgIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN6PR0102MB3598.prod.exchangelabs.com (2603:10b6:805:d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Mon, 25 Apr 2022 22:18:21 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::6523:e373:99c:8ce]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::6523:e373:99c:8ce%5]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 22:18:21 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: AGDI: Fix missing prototype warning for acpi_agdi_init()
Date:   Mon, 25 Apr 2022 15:18:02 -0700
Message-Id: <20220425221802.68498-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:b0::17) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe2f045-1896-41f6-ede1-08da27098209
X-MS-TrafficTypeDiagnostic: SN6PR0102MB3598:EE_
X-Microsoft-Antispam-PRVS: <SN6PR0102MB3598DD1D6EE29EA71F734E7C9DF89@SN6PR0102MB3598.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NKKsb+OCDE1EXmTVnnQ90cbR+n5oseYhXeel5Mq9SzP/7Brf2NjTbdKPu5HIlDba5s4QxrFnOCbEDg+wWPvzfUFmKFHjn3T3veaqLQH752L8xMJe5tzUXre2r6RkTM7apmgjhe/vtb2ncsMWZCx8wfQ4zCAOz2ShgLR/dwr86Rw3mzidulzgAtwL/pnbhEWXitWRCzBeLXpFTSGPieHkL4IploTT9Js3gWdFine3FprHftGsgnssUMeTBJ4jg8rw9dk3lLgwvAWnSynJrikLaYuTCqDU/6Svo2OrbNRil8MpEzqDpBNwmgDrGWs7HGPIaZpZC9IlG6P2WIkz+xh9o2unsNpSYt4iOk5fU4ZWaDe/jw5++hyA9B9HB4nvycDTWr7o2eIyLF6yNu+kqpyH0+cwflQ0RD4wb/5Ez44fFqWn90zHQzGFq1+lrxIJT1pd39/TkT1B3jBO+1mc4OnGYlgU4XtBQdV3e22EbY2WSCqtiY8mwPdiYpzozasalbU5gjCrF5zxYbrY+yc8IuoZVZet1rA56irW9hOlFvL0DmFMkoQzBxwY6Fz8lLaHkVkQLtJ2xeIez1mSvcIm1i7I2NRnKjLvamFLMvsakcBt7/AwxABexJ4kBAlEvVGOTv2WluioNmxr9InHH5hFU6yWNYrKhyhK3xrH9RA/icjvPDa8FybqufIz90MskX82JUeoNXNP95DDhwLF9MfkQap+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(52116002)(4326008)(6486002)(6666004)(6506007)(6512007)(26005)(186003)(2616005)(1076003)(66946007)(66476007)(83380400001)(66556008)(8676002)(54906003)(86362001)(38100700002)(5660300002)(8936002)(38350700002)(4744005)(2906002)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFYZy8xQnZpSnFNME5XL3dMWWxYYVZiSFlqYi9iR1hGUk16SnBUNHlKTmFU?=
 =?utf-8?B?ZXhsQ3AwdEpPaVk3MUpibnloQkdyTWx3S2pFN3R4UW54di9pb1NObGl5a1FX?=
 =?utf-8?B?ZTl1T1paTVdnVkFqNU82RitHeG5aeFFyeFR1K0p0ZUYrYkJndFpTS040QzJO?=
 =?utf-8?B?NnpBRHYyMTQvNjdETzgzYUVXTW5ldy9tTWlvbnkyaWM1YlBzd3ZmYjI1OUdw?=
 =?utf-8?B?UmVuNmNscTBFZHlER1RpMDJReGIwenFzbCs1MmFmVkduRHh2NFNQTkY3R2dy?=
 =?utf-8?B?WFU0Wk1lVWZUdGRjU0FqbDRiVFZXenplb3o5b1QySmlJWEdjU211L01PWXFy?=
 =?utf-8?B?ODAzUlg5UVl6T2Z4ckZoSkRpYVJ1RVoxdzl2Ly9JRDR3aDVCWVVZTTk1M0t5?=
 =?utf-8?B?TVY5MVdEZ21GQmFCSzdQdW9ET2hlbXp3TjJKUUJkS1lRQ1JkcnJxcDRrUkhB?=
 =?utf-8?B?a2hQZGVJdzlodUFCYnhva0t0dUNBZ1lYTk40TUhQK1ZPczFwQVZacktUMlNE?=
 =?utf-8?B?ZmFGbEZhRDR3MFdmSDF0MXoySFB6L1ZMbEdZakZwTGJhN2Zyaytwa1lKaFJH?=
 =?utf-8?B?RlVxQmV0SnNtaVN5QWFaVlp0bGpWKzNrVFFkbUZxcUg4Qjc0bDZIZldzNy93?=
 =?utf-8?B?eG9YK3QzVmpiWG9FOWtMQWs3NWt6M2NWMDcxeG1tMGRiSXJvMHFmQStjMHFS?=
 =?utf-8?B?UlpPMlVUVGFYTk96TmFpdmJNeVZQeGpTc256Qk1pVjdOeUR2aGxGck1DQzFs?=
 =?utf-8?B?M05XdFM5alhuWnVqSS9aYWVXRHRpZTZkVXNJU2xxNTJxTW02dHhhdTNiVmhu?=
 =?utf-8?B?Z015S3RyMFgzZi9Tdktuc1czMHlGRk5KTURKY2dyMGNLRVphL0VyMEpFVWdn?=
 =?utf-8?B?ek1sVCtNK0R5UUJYY3hEK1pacWEzZmE4M2hkd20zTERMa3NBOURjMWJLQmc3?=
 =?utf-8?B?TUkxVGJMZDdsdWNDa0UycHN2NnlHN1Z2U20ydHRPSE5MN3ZTVzdGNEhRZWZ6?=
 =?utf-8?B?cTVySVpESUZyNU5YdmN3TWRQNmxtZTdXSlVUQVBjRG9jejJwcWpjU0ZoTVRw?=
 =?utf-8?B?RkN5eGZuSXhjUktEY3JSMnRwWEQyY0E1NkZVL2drVlpEOTg1VFhDak9JT3pn?=
 =?utf-8?B?WkN6czJaa282QUhybTdSemVLSkYvZkE0OXVJbXRzVjh1cmd0c1hJU3JlN2FD?=
 =?utf-8?B?RTJVYTZvZjN4TXFwWllNOGp0M2ZlQ2NCUG9hclRvNUEwY0wzR2FIeEI1YWNV?=
 =?utf-8?B?bWNnK2pzUTlSOGxPTWpYckJaSlA0Qm9VSFVETzNBTCtpZFd4V2NMcDlIYmsy?=
 =?utf-8?B?QlhqT2w2VTN3NUFRbDlRT25vdkk4OGd4R1NyWXB5YTdERkM2WGQ3Q0R4TDgv?=
 =?utf-8?B?VHVNS0owS1RqMmNEMHY5STkrTzUrbHo5cWhnbVNFZjY5bnVFVFNuQzA2dk5V?=
 =?utf-8?B?aEh0VHZyM3hoVkQ0Y3dEY0tVWGEzV3NRc1lUS1BmYkg1cC9TMnNJTFhueVRO?=
 =?utf-8?B?MllMb0ozTTljNSthc1loTGV5M1pPRlUwK3VpQUFYd1R2NW5wN0FselhrNjFT?=
 =?utf-8?B?ejFybHhlWGZJVjcxSTA5TzVDOVp3NUtzUWlmM1B1Zmx2cDBBNk9pekVaa2lx?=
 =?utf-8?B?aDJEUlhBcVZFS3dOdDljR1RyQjhlNWNVVTZPcUtlcnBvc0Z5Vjc4QTZmR1gx?=
 =?utf-8?B?U2trMW1wMVVWcHlVYWJtUkdVSkpJUmQ2Vi9SQWVrdnIwMEdoeXcyODZwWlNM?=
 =?utf-8?B?Q3FKbGhJL25VMVR0V0NJYmdXdXV3THdvMUYycFB1TE1FaFc4dkJabnA5MCtY?=
 =?utf-8?B?TDZJVjdPeFd3bWsway9DZUcyL1AyeW5rYUY0SjBsTDBod3BSY1pqQmpJS2dN?=
 =?utf-8?B?VXpzSS9QRUFZajVTQ2JvUDJvMkRHY3B1eUpTUDJ3NE5IZmovZUNFYysxQ1lJ?=
 =?utf-8?B?ZDBqUzFkL0s0R3ZYb3c1VThyalV4VmRFYk1lY2FxSDRORVZ3NWpxOENEYzds?=
 =?utf-8?B?bU1vVlZOelB6QWk2NWIybEg4R05XRXVxeXBPajQ2WU5obkplRXJSRmc0NHc1?=
 =?utf-8?B?dmsyZEFURDdvNDdCWklRaDdmVk5QQUdZWlJRZ1JxL0lGeXcxL2FESHVtTThT?=
 =?utf-8?B?bWpHWjNGMUV6a25aMEN5SGZNK2U1SDludlAxVFJaSGpqMlFNbU5EcERTaHU5?=
 =?utf-8?B?QjYrcksvUHF5dFNJNVdRZjhLWXQvY2RUVDZlTzFLYm5nKytYTFA0N2NVTyt2?=
 =?utf-8?B?cURFWWZXYTU0SzFmUWhzb2JvQ1pCdkhoUHNTSWdoNjZkaUIzUGhCcTNJZ2Vr?=
 =?utf-8?B?WnNRckFKV1NxTStya3B6ZEVQelhEUzY3cFRYQUYyczdkTndpRklib1M2SGRl?=
 =?utf-8?Q?eujT09KyapBhsUWQfKHSrcE1TkJy1KLxiampF?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe2f045-1896-41f6-ede1-08da27098209
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 22:18:21.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFZCEcG1Atms31XCYR0Ui/uBAPReSu4PukRX+Yfa7GXuzdeevfXXJljuL4QyLkkqlpJHEc1aIa7f2BSazUPs3uKOJCTv19tBfDMQYW+n+t56KtmnLTjXNWjqizsa2u0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3598
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, we get the following warning:

drivers/acpi/arm64/agdi.c:88:13: warning: no previous prototype for ‘acpi_agdi_init’ [-Wmissing-prototypes]
 void __init acpi_agdi_init(void)

Include AGDI driver's header file to pull in the prototype definition
for acpi_agdi_init() to get rid of the compiler warning

Fixes: a2a591fb76e6 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/acpi/arm64/agdi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index 4df337d545b7..cf31abd0ed1b 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "ACPI: AGDI: " fmt
 
 #include <linux/acpi.h>
+#include <linux/acpi_agdi.h>
 #include <linux/arm_sdei.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-- 
2.17.1

