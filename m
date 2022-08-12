Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71E590B73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiHLFXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHLFX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:23:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F98A026D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewX8H85xGiA1mN2sJQCZroK03SQxPxyvSvYOAylv/n7+TzrbLUnfIKf58MkGGKeLSd+8UBvySoWipfgCPUy8bW40jjGgNQdxkUTaWgv94JG9N7h7jdSKrj66+/ImOsu8RBclg3EOyMywCf+GzG/1sx5Oc0ESXm6uiqrpSS/TbOAd3qYTZ7cHWKvoTICM1h9gXR0vJMc+XWiMQgwg/8UIsm5m+S2Ppb8tLQxVmpMLWDAvein75yC2eo0hH7dV6TDEjKV54HjNSOEyZkAMhoQ92Z6x1kxqQjdoA/Q1EzfTog+W6CmCsk1YXhOeF1DmBzEjvvkhlPnOgvgNWXoY69CcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snVPulbAKBAi9Wd3KFPYZ5rYVHb8mY3ptG8l5yLntdE=;
 b=ROxhFtybP/MZxfos7JNr1i8X3gW7UfjboEnvoKweaR6zGvsNgbzJlqalYZs40b5TnBv+36CIFkBN/iaIK5IIcpq0xXQUN6KxZ1EyGlqAsaqK1eVgTMIxWc5YWYblNtKUDQQ/D+cpB/1QUC8Kcg4661Gk1mang4Mz5ex2pZsQIz2IF3k6J4G8sZe1WzYsUJcWH5dc3ds9MqaJ4VXGgza8i/bkdqIlNZPfui+m1J2MqrrzDiZEMKRy5RWYCfE0PMfGQpy5GxYAEQ7FfgSFqyr3n+BYOB0CtEEADCmffLPgc0vPv+lQziUr5FYXB1ghCwhYtckV0VQb+qMugl3TL3fBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snVPulbAKBAi9Wd3KFPYZ5rYVHb8mY3ptG8l5yLntdE=;
 b=WvsxuMbpBtrdcnRprhJNYN/tn+9cpPDIBh1zAQpbwNkWRVve5EZ1/K3rbo4qWOGdQhMRf25e5JZz3xjNZBrsTBaCppte1axhhLU0vltg43h5++V4GeR1GIRv2BLJjw6qH4q//YvLG4XpBdEdt6nfB/6TnyyU0z8Lr+8uuEWlA6Nkoin+WCm28avyx/ST5d9JylvEIo2w/cCircfHOEzJ8BHtibBHap3dD9fKaxFJ/scpkLZHi1pdo11SoeiF0jgD3JQb2/1jlqvDXg1Lp6I6DN5XD1448zkC9m7D+1NZ8sWmjsORuhTqZotjNiqGKlBpHRs04B60Y/P5mw2iRnV6lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB3978.namprd12.prod.outlook.com (2603:10b6:5:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 05:23:25 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 05:23:25 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 2/2] selftests/hmm-tests: Add test for dirty bits
Date:   Fri, 12 Aug 2022 15:22:31 +1000
Message-Id: <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0cf9f9-0ff2-41c8-56e3-08da7c22c810
X-MS-TrafficTypeDiagnostic: DM6PR12MB3978:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BknpDFaWS0vAiU6bh+AAC73T35aXCDrL3m6Ha87v1IHvSAtLXfLpxPkoi2f+IXfybynrKhjOn5wfTAHemuJWrASpLA1s0ny4CvLp38XeYJg5NCnjhHh3e25XnROWagkTgv/tEkFxObVi37tLlF4TZ73GIklIqfaIEs2JRecbgQaBt+aBvztvGUPLSHnBCt7HBxcnzepQBHjmfZ/gKrc3gZZf0fOEb+4uZXcceuMBdC0BehoRpYS67t8HJPeaujS955DNHGwpGSExfUOKccT8PoNlhokuI42mZDipf5XZ0NcLuGwUBqpkhrFRTYiyxrrhBf1PR3RQCVK7DXKLwTr0CPkyWHEZv5PePWvLp4xyg6DVhdUcDSQ7hIqylb7Yb/wodMjNREVNgSS7gS3ik2PIJM8+K/uB2iJ3OEdc+iDZcs9sCsz6e9H/bLgLDKO02BEWCBacfPBBMMxNWZwNDu83WxpmKV5Y2KcJi5xkxdrecet9QeroEpyfW1ORa9UF2be4w+JsGLIomh0iXzUMrHD65goqYEjLUyV0WjUsCaDOMS3rPueeS69EhOYrfkEZmQDNrwrALdo3fKbzZZ6fDcJ5zvwYptXozVMRLXxddgWXOYies0DdzpbsfBHcR9lraYLgDInQzTpkP9xiXfChIaKpBa/J4dEbIRVn9J0Cu8Q8fLLw/YMLmoecNuwzJq6+b6zfNCxKoyBu3Z3DRXDX8SgTtWjHwf7Fl2kCxCxIfD61xXOkbM/5M9wI6lMwa/bYxc2o+5kqLYpneHgRWT8qtcMxWtgnCFaPzkKbFnPoxpvg0VY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(5660300002)(6666004)(6506007)(41300700001)(26005)(6512007)(8936002)(86362001)(66946007)(316002)(54906003)(478600001)(66476007)(6486002)(66556008)(4326008)(8676002)(2906002)(36756003)(186003)(83380400001)(107886003)(7416002)(2616005)(38100700002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARSHuESIg3SAbtY/c1geWpBtnQqH8AeEUOp/ZLDukOlQ918g0zdsfEZLAtBT?=
 =?us-ascii?Q?GyuBgugUMNyzJTAxlOqnF2JidjRMsP6OWP9lsi3b5ZDx2KYJnn6/Lc9F+EU1?=
 =?us-ascii?Q?FNd/iqI2OGhWAYfBuavv5FSflwWH52V0EFE3fa8Jl8+k3xopR+yWL4BA3PHB?=
 =?us-ascii?Q?avMXaapy7xZNoEbuiLznSasr81q2xlu31PMv1ZO65GzCMWXNQziUvDDUWrfq?=
 =?us-ascii?Q?LUEOoNDvKdlosyVLdufvQCEHsO6E6Tfn6VdHXkM/Y0WeoFVmMG7Ryk7w8PhQ?=
 =?us-ascii?Q?CCuCm3pRmQr3iEwT9g4DVRhNYf7KpR+Q818b1IyWq9jO0w3k67NTtVwMZEFN?=
 =?us-ascii?Q?bVRED/JyjpR5wTIXJCyNkzqIgsu2OtP2tdIWf1YCQVmHAl11USWGuf+VF9vK?=
 =?us-ascii?Q?WBz5CDamFuuAAedFqiau6EAuzB2P6f6eUfkxqtWOP3rlHiGO7Vo+tp49mwBI?=
 =?us-ascii?Q?KDcF8YYRVnbQZIoIUVg5SyhIhIvxLcN06rR+6163+Z14HCEi5EAyN5FwXc28?=
 =?us-ascii?Q?aeQxYQ+GYS9oxSnwM55ou6BDJSOtnh282hMgSp+WpGNsGhu1YV7oLJ9Eh4Km?=
 =?us-ascii?Q?w66qZeaZXnRzVlbsHBAG2GqSAip0H03W6ER28TkvNaSMp3Yhczaa6ALS1Q/w?=
 =?us-ascii?Q?bZFInDZ4/J9yCSTcECZLHGncFaJB5wIDHDdH7dfH2V+HnF1Dt4reiFh/giU/?=
 =?us-ascii?Q?x08E+5SM7TSSEx+ly4PdXo8ZIZDuitMZuf5UPw9R/E6lfJjy2bkWWJFCLBff?=
 =?us-ascii?Q?BQFhhwxebh/3hlgl2J+ml9cPvpdMa9yUvRc3Fo/n7WDyoGTXywlwd5TtfWG7?=
 =?us-ascii?Q?r+z/+TofN+aotLFAH1RY1cavt5vswfoTNsglwPiLer64SRqJ2PNeqp5UDXFX?=
 =?us-ascii?Q?1j3tdSsYHhC7RIgdeRbcOgaUMunwTt/PjBhPsbvbSZudy9FUESzaHrFFxi/d?=
 =?us-ascii?Q?MPV8483+wRP/fRuXauB3nqgNSVrkl4QTwVMw04bBLV980iz4v4JgyRGtlPi4?=
 =?us-ascii?Q?UiFLg4t2hQvJwCU8qVyDLhkQnA3DfgyWD/OM9UKIwq8VyTnVTNv8bsuXBmsB?=
 =?us-ascii?Q?pBPIpBvJVhOFFt/uKjscDFjV3Z/myCvcFl9KC+vK/NL733XUFX3hJKz+G9+N?=
 =?us-ascii?Q?eHwI4z0YesC9IVS7NIRwtMMunUrqKtLG4cEM4uFmBM8QTgRJ0gSVmCUYocMF?=
 =?us-ascii?Q?U6tgJ/N+u+Pkwe3QyLXxCGX+aqh/lgeVI0K454XZAQHmMGgd8XA0+vEKbiMi?=
 =?us-ascii?Q?dPETiqBFBFkk8EaXVG/Uve+88f0g8mwOAdJr0m2mcWXzDyhns92LmcGWvRlM?=
 =?us-ascii?Q?Zs+sqktgzGrGXiQ8gSiSBFTTaEBsmoMbzpzyFpI3J23/u+j+FODFwOcPkioL?=
 =?us-ascii?Q?oEZfjZ4rMcgv2TkD6WaWlSojIxWkE9zNbduHRWnh5OcWMJzdCsoAxaaWnhcI?=
 =?us-ascii?Q?GhY69JWVecPzZdQ8L7pGJN1t0ySzfv6urFuIYonbtWTN3NHSJee3RVbxhXjj?=
 =?us-ascii?Q?iJ8al/bVzjIEJ3bMk116fwJ2H+K7iW0h5sVQ1fz7FoNRAUNNqzPouFVBdKbe?=
 =?us-ascii?Q?3WQrIHclAICoPH2sePTVIk5wmZmwp78frQGqPygd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0cf9f9-0ff2-41c8-56e3-08da7c22c810
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 05:23:25.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QM3/thaEV5+TmkPKdEnM0UHNs58xRz8d3bCJdlIsSSyeGBY0yOjk8jNRL3WMtN+TjZ09gvJdmopbuXJcRNrEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3978
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were not correctly copying PTE dirty bits to pages during
migrate_vma_setup() calls. This could potentially lead to data loss, so
add a test for this.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 tools/testing/selftests/vm/hmm-tests.c | 124 ++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 529f53b..70fdb49 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1200,6 +1200,130 @@ TEST_F(hmm, migrate_multiple)
 	}
 }
 
+static char cgroup[] = "/sys/fs/cgroup/hmm-test-XXXXXX";
+static int write_cgroup_param(char *cgroup_path, char *param, long value)
+{
+	int ret;
+	FILE *f;
+	char *filename;
+
+	if (asprintf(&filename, "%s/%s", cgroup_path, param) < 0)
+		return -1;
+
+	f = fopen(filename, "w");
+	if (!f) {
+		ret = -1;
+		goto out;
+	}
+
+	ret = fprintf(f, "%ld\n", value);
+	if (ret < 0)
+		goto out1;
+
+	ret = 0;
+
+out1:
+	fclose(f);
+out:
+	free(filename);
+
+	return ret;
+}
+
+static int setup_cgroup(void)
+{
+	pid_t pid = getpid();
+	int ret;
+
+	if (!mkdtemp(cgroup))
+		return -1;
+
+	ret = write_cgroup_param(cgroup, "cgroup.procs", pid);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int destroy_cgroup(void)
+{
+	pid_t pid = getpid();
+	int ret;
+
+	ret = write_cgroup_param("/sys/fs/cgroup/cgroup.procs",
+				"cgroup.proc", pid);
+	if (ret)
+		return ret;
+
+	if (rmdir(cgroup))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Try and migrate a dirty page that has previously been swapped to disk. This
+ * checks that we don't loose dirty bits.
+ */
+TEST_F(hmm, migrate_dirty_page)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int tmp = 0;
+
+	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	ASSERT_EQ(setup_cgroup(), 0);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = 0;
+
+	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
+
+	/* Fault pages back in from swap as clean pages */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		tmp += ptr[i];
+
+	/* Dirty the pte */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/*
+	 * Attempt to migrate memory to device, which should fail because
+	 * hopefully some pages are backed by swap storage.
+	 */
+	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
+
+	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
+
+	/* Check we still see the updated data after restoring from swap. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+	destroy_cgroup();
+}
+
 /*
  * Read anonymous memory multiple times.
  */
-- 
git-series 0.9.1
