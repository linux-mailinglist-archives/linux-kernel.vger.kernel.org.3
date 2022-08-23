Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2059D289
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiHWHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiHWHoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:44:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2050.outbound.protection.outlook.com [40.92.99.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D40642F1;
        Tue, 23 Aug 2022 00:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOVONaTwF+RwCihyRyGUrvgez/agsohVyz7tCIV9RdjX6LCBnfYGU4UhPYBsNJErsCxeq/eRUqa1BQU4tMfEqcrqu3t7HAqiKuEykV//Z5xWXquksFRpnzNbr9k/2KdTjPNXZwPUD/WWEKkKUmlMcXfE5nze1yg9eIN/A91AJx5bsFm9VzeFpsGGKMecpwO0cjVx9ICkOcJhMnRytl799cL7ydRIIj2qPdSV2JFs8jxU2q5V2TKZ3yGKyzR/whnQ14PhaCHtCaOonbDPS+++rvtCTdARlIFx4bWNH1F3d5QBTT0LsGji3XzzeBWrevkBY1fxea3IQXPSh/lR5BqRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYWqBtU45I4EQkd+Dbg4pnygsbhlRMw7LJlSRTag6Fk=;
 b=CXHCWlRQrNsosllUgIoMyP9+tpK6wup/waerDoFVSRnq2PNeH9+6KXWB6HAOsu9vqU1ZzLHj09wi6+YyQRf/ZNvftV87Z1fAUY245fibKKVvXsnsD2NX7ogrQZiSNSK4NZJrPESC+dHPOJxAcDnnY4v+wGdIhTTDisySOKkUcf3Ui9FnyHb0y6hrcXsIPFz8JPG0Q+YMtR6n9Rz9dv9ftGWiHxWztpGZQzw023Z7C6WrYDpv3GhH6m0wtqa/20JvVmiKwFJwwma/ybC9lDlUVLeAJFnRvLApzz8muZ8/OM0xsqmLch3KaM2mjFYWBEExbLlj3Kfn71tqhkT5sUgf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYWqBtU45I4EQkd+Dbg4pnygsbhlRMw7LJlSRTag6Fk=;
 b=MttYetpuk4FJTU0XZOJ/n/sjfrwy/K0Pq8hdNRZAWxd6xFeda9HIiZjkUP7kdT6AZRDZdja5++gE9H8SKPm8jDFIqI3GgQ8q0r1cF8QyCQ0hK/L5uceMTDU0o+/wNsgWGfCpvVlOgfxcprTjt4IRrp3oO4Z+VeH2eHMBBQBSv6MOVmtPIVwLbeKuLbjF+4J7ygJAa708BFePmoQLmbSvfpS+OFR5iW4UmJZtVAFce2zLepaGPhyIslyFMqBcrpNobrsR+muFPJRf6VKIg/HxrzgTbLhW+ElnAINFVmVgKow0kls4lxlrEGWEDrQ6YodZIWm2uqdDYqAw44jz7xHPvg==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by TYAP286MB0281.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8040::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 07:44:14 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 07:44:14 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        jeremy.linton@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: [PATCH v1] ACPI: processor: Remove freq Qos request for all CPUs
Date:   Tue, 23 Aug 2022 15:43:42 +0800
Message-ID: <TYWP286MB2601183235622B29FAF707B5B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qpx019S2UVF9r51+UW40f+C0o4Aku9XsQoCDB5Zel5Q=]
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220823074342.425830-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75babf41-0838-4294-261d-08da84db4654
X-MS-TrafficTypeDiagnostic: TYAP286MB0281:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYtZHdbt5zxD7CYSB6lBkQXLpfkdjdofPIYiZ+fPv/5e1Szf5vkOruHkXEcDUSUPE6Ts2MOHXWLdcVSD2BmOnhDUIHbNSXgjmlNnB4MrW/A31+zjR9N04gq7FRfdi7Hplzj7eNUcMjNiLaxnrgaxtDtr9R83rfbWcpeFpuA68qH5P53bEbnedhHBzjG5g7h0Mbv8xT1OWInN0eX7Yr7cRlcS1b+4MzTq0NVe2Z0JimrV5LqsQALYOhrFOcBVtou9UJgKK7wfTAJF3vtVfNBe41A2/w0cuPcYEYbwr7NUfpem/IyMyi4eIaJeQwq3O58Ulz8hc7okyuQ5rb9hptLHyI2U+bcvJikGCGNlUF780RO89R9W2uA1DZG5iAzH9fX9WF8feAx36PVCcbc/3UHXE6+K1pGdsMSFFc/7EBCi/ljwDLD8Hgw9ZV0bj/TiZRaE2Ie56t/LLOhPpZgoiB01ffcZUkwaO5ZffW9h7XRUpuGFM+wpTt4/mKOicmAeNKcB7oAh7VHleT9Lt3x3+lRdeCNRcEIs2gsNj042QADuUGoaVF0V08rVM9tE3qxKhXYWOA9s5TSAH2u8IIKZLJfzFIxE5nC4vW8Wl93Rx+OugISTRgG9TL81cK28qcolWVYeehuov4QrfY3kC+DgEF2Vtg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBUsMaa7t2THVHhqCN2tZEDY/2yl1ocaxUa8MfmAX+qokxIjgQ4KA+szLdQu?=
 =?us-ascii?Q?JjW94CunACfE8EsLOA7Iutzxk8BJf0DLZR2jUbs794oMhpYUcDyFbQIzhe9N?=
 =?us-ascii?Q?ZqKVKJm3MdfU1P/xcVLjI79L+/QGmKDI87QmysTfzUAnSsT2xrzw1sNxeDEO?=
 =?us-ascii?Q?/16/jZaogLVRQaVXC9+AebVNFd10twNvp20ivLoGjgnpLMhFQuvij3dy+4rM?=
 =?us-ascii?Q?x4BFdrCqi29H4rEWqH9BA13n6oizXLgmae0FvOkwqWDD3ql4bgScJw7lglYb?=
 =?us-ascii?Q?x8EM7/vSxpUE9mwSTkuXsWqK4VZ0/1HQkb6kRb1ETXl2UPniRL/R/P7XNW22?=
 =?us-ascii?Q?PP/WX2vNOtcLe0cogCRTtfNKe3KBhGPEvLQfUvmemlZrmLGVy5yPcm0k7JKo?=
 =?us-ascii?Q?Y6Yf+U2o64s7gMYHsk6o6gGFBmkBA/vc5umdYvfKhKk0spBY1xMomQfJ6byT?=
 =?us-ascii?Q?a+PsveDxtYRXNS/r7o4cW4R7exxdfmMbpwQ4e453DpYMf8/lVyV9syKLyahB?=
 =?us-ascii?Q?DvxQeV9dJ8GT6hd0NkTyhPAmhP/INBoi06bDAJIyeYFrqY+IDYJ9ZTNt5jkI?=
 =?us-ascii?Q?8VgT6O0ie4E5EhYG/64KFKwmGkpqW3Y+ULqHV+C87dF3vUoz/+oqYn3QYxro?=
 =?us-ascii?Q?ne+eiuSkTBDfS8mHGDbygzJYotHoSRnOAGOtmWaa6Ed+qqwTi8CQPdlN5GpY?=
 =?us-ascii?Q?35Pnr+dVWp7HD/uKqjPfNeWRVoXlPwtaTcS4IcgvVnvUwbJhBDoXBoZYyXQ5?=
 =?us-ascii?Q?rzZW3u+v7Xat3XTLwrzcNzGeUN6NyIeZuTNRhPGn2y95YHt6BU5AmaYW/apQ?=
 =?us-ascii?Q?9LOvSRC0LhRwau/JPcZGs07gqwWaTA9w+c9xO8d0Dx8JvY7aftuJS7OR++al?=
 =?us-ascii?Q?ec+XVn5Lj/z8kyI/3E1lYve1os7NI0tIyoVDpeQ7DQ/KiTCwr3gMcBetnmWX?=
 =?us-ascii?Q?YwVyIt/eKRv9Hv+OXPfFpcXcdwpZvNlc4rYFzKnmiM0sSVbd6oIO8Fdqt+UC?=
 =?us-ascii?Q?M5Bi4bDIWXbCAhcEPlEw8NeLiQM02o0NvdaV1rzZf7faU3ccrdUoJhJadY/F?=
 =?us-ascii?Q?3c9wPzKkl9k/yBJ7ci2emc1kMfetjpCidMrRRzjcFBdJ6jhnHIZfstRjjejo?=
 =?us-ascii?Q?lZysnFsoSN9qGt9dvlNRlZcTNB1XtPU8vwA9MG2mQY7fYlRzTZuqomI+5q/d?=
 =?us-ascii?Q?QepQZdkmo+IDaRcsNbDdV29FbFZCtiA0I053zbH1ILNCltQt4Mv0p5uqrm4o?=
 =?us-ascii?Q?4wC1poBL370wi/qjwZ5TSJDsgN3GK6ebtYrZ7yaXXg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 75babf41-0838-4294-261d-08da84db4654
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 07:44:14.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

The freq Qos request would be removed repeatedly if the cpufreq policy
relates to more than one CPU. Then, it would cause the "called for unknown
object" warning.

Remove the freq Qos request for each CPU relates to the cpufreq policy,
instead of removing repeatedly for the last CPU of it.

Fixes: a1bb46c36ce3 ("ACPI: processor: Add QoS requests for all CPUs")
Reported-by: Jeremy Linton <Jeremy.Linton@arm.com>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/acpi/processor_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index db6ac540e924..e534fd49a67e 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -151,7 +151,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 	unsigned int cpu;
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		struct acpi_processor *pr = per_cpu(processors, policy->cpu);
+		struct acpi_processor *pr = per_cpu(processors, cpu);
 
 		if (pr)
 			freq_qos_remove_request(&pr->thermal_req);
-- 
2.25.1

