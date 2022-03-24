Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B414E5CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbiCXBp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiCXBp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:45:27 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158613D01
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPJ5i9azA7hR69VPF0Q4W5El90TCD/wlTOpeIHeZ2TTkaCxQYyop1EEQsQFOrL8/wSgfuGlkZ0hHmCE+2X8zTuXgXuUwbQs4qRS1/AyJUJo+Ia5rPwWQkrmeh8wHQabQcfnFrQJK7QbUePGpOY+/+eDPTsOxnd+HG0/k6lhuh+9NhQzOVZ6wcoeKJRogayZCiVdXG7d7Rwz20+IhN7DqHJ1ffXGBFfZ4oSvX+IDeJMtxgFE/lNlY1EnYHvErKRTLhGjdDTmDpiFxQfMkxz0Yt+xeWcnZqPnEom9XH2FgTjC0GQTVvMhmYudRlg+Wyigchdpt9OPJqAxqY4uj62PrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KejNM/NYxfZT6+r25AtIzlkqZOGyzhCgPkBwoyAiha4=;
 b=XlpqCmBS39ddDfUjMVgCqztHrh3il5xrsby5oOJe5pFD1GIp8NEm16eH4+kBQ5PEuoODaayXdPVGJpntz0prnPRcDDBN0EY/TO6M9+mlzVqNB0U6oHLvDAOQeSbmz5sGt8L6+bB0/XB01npciWfvV18aLHIOYNmC3F7+0qKg4xTpMBGP41+Cm3bDJkX5iZfV/ue7onS7AFiPg5/4OyIf5+HM5LUZvEUMzWZZCYEpdcA042Q6Dfb2m/jKY2QMiZeL4Us7/MuYM7QI0fYGKVCJxNxolYYoAUyzaAr3/3IsBqtHVr3bwrMOZqfTB6l+EOiATXATCBZxRuA7KNyHVfWybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KejNM/NYxfZT6+r25AtIzlkqZOGyzhCgPkBwoyAiha4=;
 b=H/opNN0FE1i6HOKoMJ6VPnS7r/6VUX/E3KJEwtS0rkUoRXII+yzsJVbYn2BmiTSIKyHzR1wKz4XJplVsRzRl2CIKcUvvzLmG3nG0hId5fHb9lbd9A5FyCIdkJwDKga5xNLVvlbF5yAdlD0OV8ZLdNF/H+JEuuZX8q2zL47cPnKhSYH9mye6Mf3ab3eBu9lG8V0Y9T5thUgZiVcM+vctroDbfIme2SNOY4AWvmTbR7TmQr7s1dAIvcEYEZ/RJiI0zhqkicYmh6nO+HANSgrIdgyIJ8MZDOwDoNLB3++cEnCVAPZBUV11hDitkJPx7n0x9v/QDnsv7dWdhd+izhlszvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 01:43:54 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::152f:613b:7041:68d6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::152f:613b:7041:68d6%7]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 01:43:54 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     hughd@google.com, jack@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, rcampbell@nvidia.com,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tglx@linutronix.de, bigeasy@linutronix.de,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm: Add selftests for migration entries
Date:   Thu, 24 Mar 2022 12:43:49 +1100
Message-Id: <20220324014349.229253-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe355c2-006c-4fd1-c75a-08da0d37c14a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB440923697F5C977C5C4A5BC0DF199@MW3PR12MB4409.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUKTFYN28o3rjYgRZcqs8pO6kG27wDVHUqesL/Hvd/idYRi3UgBVWJa46lXTYzyMyULBXQUUph7mYXrRELuDTZR66H7rTwz5Sb////fduEoiMwYz5MJYS/iZXq3bNBbMf3MY1BqOUlAqBIEmYZFNmjCVTaolzrA9Kt5Cy5m8nEfC8COmdXT/MAA5Yo+MuEnZfYaQn5m0o881XbjZnvcAvR+TLs93MR50HSksGtMwdniLp4GVuVkwYiWd4vYLTa7dSSu/TDcqfucyh0C8jP7N2Q+li8cARz2SeN3KBDtNRC8GIqLqi5U7jOU1yZhoBT2XInDOKEhkKaFlm3iae2d09um+ypDXyL/VSnVFlE+YmNCv7mjcMPF75GsKoA3vbm+eVgy4CM8Ql18Vk4zwlW9fhBDdKasxOmtmeQzQzfqto8ywYxGcNj5AVUHz7gEny09X0Qx2V5l+QD1zUnWiIFr1uLDGqzwpBp1/ECk9uTS/OfDIEOoaQQgptmPsi6eN+zk8CaetPHqw2wtvvEgL4+7VK/h63qbMsKX8s1069mPJryrgbYw28GvTs5y5kTEWi0m4h9IClAxKHzXaToM3mG0NkuZbHckjvoiYSaUtwveNLBjH8wFYwqoGsVSyhDSd95xTCc2LtrAO5K+nm5Td4oHD8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6666004)(6506007)(86362001)(107886003)(508600001)(6486002)(26005)(186003)(83380400001)(8936002)(7416002)(2616005)(4326008)(316002)(8676002)(5660300002)(38100700002)(66556008)(66476007)(66946007)(2906002)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQIQ/D1w5fbDHfCln8IQPhp4Fl2cV0sdnxgitnCzOz1bf2sFF4gTj+XOlHne?=
 =?us-ascii?Q?fU9cpulsA+PnOqyfIPhrPBtmVECXvGr4o245Q1OdJasSX7DxU1XWpXcRuxoh?=
 =?us-ascii?Q?kNnvYA25Daa7Mw+bAxV/bEdS2p620zOAlwQ6gtfUU3qF/+53klUSDw5tVS6z?=
 =?us-ascii?Q?uHcnMwpTPH4HpbFrDUTSVsO5FX9zT7xPV7hTLO9HPNOVbYOwZtie5mK35L4M?=
 =?us-ascii?Q?loCi/gwUQ/52NpSp+bykQsjkvoCqexy5aEDszV0B37K5gvo3W5mvLLZzEUrK?=
 =?us-ascii?Q?i7+ULVUJBHNMIybDugNBN2acPSNwwK7il7zAiBV+OSBDaydKX5+G3lp6lS65?=
 =?us-ascii?Q?qYQYLwJ76UcxWbMH82wpHRFiSwgSiuDX3VyqeLt1Sgwv1ihJcQsqBFjWancU?=
 =?us-ascii?Q?s4d2bNsWki0tQBa4QpFOXzVbciExg1dxzDnCW3KQIYu4nEybUnYPuL3aM2BG?=
 =?us-ascii?Q?//aWMfnJW+zOkT9mYzP4sIirC9Q/tW5VkjT6JaoXyKFOUk/lqPuej1uTOgUi?=
 =?us-ascii?Q?/TivNWFIVomtvt3KMwYYg8F/TlYVje9dXpsnxq+RmGqKU+C5cHn17bO0a+dM?=
 =?us-ascii?Q?6Crw6lFr2MMCo6P3XNY/2kVIAC40eSA23w4+CqT5MIjgTNKomMsIAkf25wpA?=
 =?us-ascii?Q?a6ET+y6IFRJhDwSancGRV+/qS+s2/XvpDBbZF6KXDyADSSbZrymEEra/zzN9?=
 =?us-ascii?Q?oe6I0OQ6ZbsxtjoPnh2kfNkvVCkL5kGm0CdW1W2qbYkdEDl88/X6h2pLxTZE?=
 =?us-ascii?Q?lTWmR/IERYpNrVUFoATXebEeW0lh8dcxzGSx+GdOehsKCJSW1W77tV/TmtiC?=
 =?us-ascii?Q?HNmrpSO+fkogxYgLPMgwDPEC6XjTXo6+1qHtm5pyHRBREJZ1k3MzBBT1eFiY?=
 =?us-ascii?Q?R2U+7dcxKA5/q0zrdb43BnIo5b8iDy8yAc51aTMzb+T6T8xKMBoTnyq/KC7c?=
 =?us-ascii?Q?Z5SlmWTyO6jvf7afKfjTD2wUc+2Du7dfP6Aci/jjd+Ry9IMfPW6D1unjfGG+?=
 =?us-ascii?Q?+mvMi7ZbgL7RGOOMo1joB543H1jmfa16cVPi3Vqt8InAn7uTCPoLaGhsqtfT?=
 =?us-ascii?Q?pi7PG1Tqr25MptpRMU1eVtK3teazZB59mE387rBg+QrRD1OThzcEGiikpmJn?=
 =?us-ascii?Q?fmsiCpKwhkiPscYfoCtDomY+KgeMHv+L28hJLXwM8+sH6XWxBzH4+fLq5Vxw?=
 =?us-ascii?Q?Snjoahd096vOHuXIvefDbnqbq7BvlWyX7Xs07AwuUut8fGqMCcHnjbJF4Ils?=
 =?us-ascii?Q?vZmnaiB0K6gzklEOoB6TTPn03ZOWG87HdEZIOyQyAukShLcow/ey9ULZW2xU?=
 =?us-ascii?Q?pWl2lrrJXLpPJGnxgjCS51FbLoZdXRw/8wNn/xaE2r6qXaHeVKx11g9KM75P?=
 =?us-ascii?Q?GeUYQObvrXTU2mK647bDjhYx2ji287z3MGqoiYe44ewTOupXeyGIm8G/yaq/?=
 =?us-ascii?Q?2Kn4x6WW4uG2TVBPaj3863cCmQl0Gnh/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe355c2-006c-4fd1-c75a-08da0d37c14a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 01:43:54.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtTt/eE7fLUZAGTjZ0H0qyr6XygDawxYu/SqTsWbsHxHmJU2LYEkjwAo1SPK9lnt/eXwEH3HgLW4KfKXAxH5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some basic migration tests and in particular tests that will
stress both the pte and pmd migration entry wait paths.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---

This is a clean-up of an ad-hoc test I had written to test and understand the
migration entry code paths. I think it would also be useful to have upstream so
these code paths could be more regularly and easily exerciesed.

For example these tests directly found an issue with linux-next f886cdb76920
("mm: pvmw: add support for walking devmap pages").

 tools/testing/selftests/vm/Makefile    |   3 +
 tools/testing/selftests/vm/migration.c | 193 +++++++++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/vm/migration.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index a860daa75f60..4b7a6b0ee7db 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -41,6 +41,7 @@ TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += memfd_secret
+TEST_GEN_FILES += migration
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
 TEST_GEN_FILES += mremap_dontunmap
@@ -149,6 +150,8 @@ $(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)
 
 $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
+$(OUTPUT)/migration: LDLIBS += -lnuma
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
diff --git a/tools/testing/selftests/vm/migration.c b/tools/testing/selftests/vm/migration.c
new file mode 100644
index 000000000000..1cec8425e3ca
--- /dev/null
+++ b/tools/testing/selftests/vm/migration.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The main purpose of the tests here is to exercise the migration entry code
+ * paths in the kernel.
+ */
+
+#include "../kselftest_harness.h"
+#include <strings.h>
+#include <pthread.h>
+#include <numa.h>
+#include <numaif.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <signal.h>
+#include <time.h>
+
+#define TWOMEG (2<<20)
+#define RUNTIME (60)
+
+#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
+
+FIXTURE(migration)
+{
+	pthread_t *threads;
+	pid_t *pids;
+	int nthreads;
+	int n1;
+	int n2;
+};
+
+FIXTURE_SETUP(migration)
+{
+	int n;
+
+	ASSERT_EQ(numa_available(), 0);
+	self->nthreads = numa_num_task_cpus() - 1;
+	self->n1 = -1;
+	self->n2 = -1;
+
+	for (n = 0; n < numa_max_possible_node(); n++)
+		if (numa_bitmask_isbitset(numa_all_nodes_ptr, n)) {
+			if (self->n1 == -1) {
+				self->n1 = n;
+			} else {
+				self->n2 = n;
+				break;
+			}
+		}
+
+	self->threads = malloc(self->nthreads * sizeof(*self->threads));
+	ASSERT_NE(self->threads, NULL);
+	self->pids = malloc(self->nthreads * sizeof(*self->pids));
+	ASSERT_NE(self->pids, NULL);
+};
+
+FIXTURE_TEARDOWN(migration)
+{
+	free(self->threads);
+	free(self->pids);
+}
+
+int migrate(uint64_t *ptr, int n1, int n2)
+{
+	int ret, tmp;
+	int status = 0;
+	struct timespec ts1, ts2;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
+		return -1;
+
+	while (1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &ts2))
+			return -1;
+
+		if (ts2.tv_sec - ts1.tv_sec >= RUNTIME)
+			return 0;
+
+		ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
+				MPOL_MF_MOVE_ALL);
+		if (ret) {
+			if (ret > 0)
+				printf("Didn't migrate %d pages\n", ret);
+			else
+				perror("Couldn't migrate pages");
+			return -2;
+		}
+
+		tmp = n2;
+		n2 = n1;
+		n1 = tmp;
+	}
+
+	return 0;
+}
+
+void *access_mem(void *ptr)
+{
+	uint64_t y = 0;
+	volatile uint64_t *x = ptr;
+
+	while (1) {
+		pthread_testcancel();
+		y += *x;
+	}
+
+	return NULL;
+}
+
+/*
+ * Basic migration entry testing. One thread will move pages back and forth
+ * between nodes whilst other threads try and access them triggering the
+ * migration entry wait paths in the kernel.
+ */
+TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
+{
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+}
+
+/*
+ * Same as the previous test but with shared memory.
+ */
+TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
+{
+	pid_t pid;
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++) {
+		pid = fork();
+		if (!pid)
+			access_mem(ptr);
+		else
+			self->pids[i] = pid;
+	}
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
+}
+
+/*
+ * Tests the pmd migration entry paths.
+ */
+TEST_F_TIMEOUT(migration, private_anon_thp, 2*RUNTIME)
+{
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, 2*TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	ptr = (uint64_t *) ALIGN((uintptr_t) ptr, TWOMEG);
+	ASSERT_EQ(madvise(ptr, TWOMEG, MADV_HUGEPAGE), 0);
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1

