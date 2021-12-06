Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08741469445
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhLFKxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:53:49 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29153 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbhLFKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:53:48 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J70Wx5tSjzXdbb;
        Mon,  6 Dec 2021 18:48:13 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 18:50:17 +0800
Received: from huawei.com (10.69.192.56) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 18:50:17 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v3] crypto: hisilicon - replace 'smp_processor_id' with the raw version of the macro
Date:   Mon, 6 Dec 2021 18:51:09 +0800
Message-ID: <20211206105109.21847-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_processor_id() is unsafe if it's used in a preemption-on critical
section. It will cause the call trace when the preemption-on and sets the
CONFIG_DEBUG_PREEMPT. So replace 'smp_processor_id' with the raw version of
the marco in preemptible to avoid the following call trace:

[ 7538.874350] BUG: using smp_processor_id() in preemptible [00000000] code: af_alg06/8438
[ 7538.874368] caller is debug_smp_processor_id+0x1c/0x28
[ 7538.874373] CPU: 50 PID: 8438 Comm: af_alg06 Kdump: loaded Not tainted 5.10.0.pc+ #18
[ 7538.874377] Call trace:
[ 7538.874387]  dump_backtrace+0x0/0x210
[ 7538.874389]  show_stack+0x2c/0x38
[ 7538.874392]  dump_stack+0x110/0x164
[ 7538.874394]  check_preemption_disabled+0xf4/0x108
[ 7538.874396]  debug_smp_processor_id+0x1c/0x28
[ 7538.874406]  sec_create_qps+0x24/0xe8 [hisi_sec2]
[ 7538.874408]  sec_ctx_base_init+0x20/0x4d8 [hisi_sec2]
[ 7538.874411]  sec_aead_ctx_init+0x68/0x180 [hisi_sec2]
[ 7538.874413]  sec_aead_sha256_ctx_init+0x28/0x38 [hisi_sec2]
[ 7538.874421]  crypto_aead_init_tfm+0x54/0x68
[ 7538.874423]  crypto_create_tfm_node+0x6c/0x110
[ 7538.874424]  crypto_alloc_tfm_node+0x74/0x288
[ 7538.874426]  crypto_alloc_aead+0x40/0x50
[ 7538.874431]  aead_bind+0x50/0xd0
[ 7538.874433]  alg_bind+0x94/0x148
[ 7538.874439]  __sys_bind+0x98/0x118
[ 7538.874441]  __arm64_sys_bind+0x28/0x38
[ 7538.874445]  do_el0_svc+0x88/0x258
[ 7538.874447]  el0_svc+0x1c/0x28
[ 7538.874449]  el0_sync_handler+0x8c/0xb8
[ 7538.874452]  el0_sync+0x148/0x180

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
changes v1->v2:
	modify the comments, and use the raw version of
the marco instead of wrong code modification
changes v2->v3:
	modify the "changes" lines.
	
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 2 +-
 drivers/crypto/hisilicon/zip/zip_main.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 65a641396c07..ffeacdc4a85c 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -277,7 +277,7 @@ static inline int hpre_cluster_core_mask(struct hisi_qm *qm)
 
 struct hisi_qp *hpre_create_qp(u8 type)
 {
-	int node = cpu_to_node(smp_processor_id());
+	int node = cpu_to_node(raw_smp_processor_id());
 	struct hisi_qp *qp = NULL;
 	int ret;
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 90551bf38b52..c3d2dea40202 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -282,7 +282,7 @@ void sec_destroy_qps(struct hisi_qp **qps, int qp_num)
 
 struct hisi_qp **sec_create_qps(void)
 {
-	int node = cpu_to_node(smp_processor_id());
+	int node = cpu_to_node(raw_smp_processor_id());
 	u32 ctx_num = ctx_q_num;
 	struct hisi_qp **qps;
 	int ret;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 7148201ce76e..18498138eba2 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -277,7 +277,7 @@ MODULE_DEVICE_TABLE(pci, hisi_zip_dev_ids);
 int zip_create_qps(struct hisi_qp **qps, int qp_num, int node)
 {
 	if (node == NUMA_NO_NODE)
-		node = cpu_to_node(smp_processor_id());
+		node = cpu_to_node(raw_smp_processor_id());
 
 	return hisi_qm_alloc_qps_node(&zip_devices, qp_num, 0, node, qps);
 }
-- 
2.33.0

