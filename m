Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69A4A0496
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346680AbiA1XvR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 18:51:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344665AbiA1XvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:51:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SKhMY3026408
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:51:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dv7skekt1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:51:15 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 15:51:14 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DAF5E28E02F9C; Fri, 28 Jan 2022 15:45:37 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next 7/9] bpf: introduce bpf_prog_pack allocator
Date:   Fri, 28 Jan 2022 15:45:15 -0800
Message-ID: <20220128234517.3503701-8-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128234517.3503701-1-song@kernel.org>
References: <20220128234517.3503701-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ORaH1_D7aAYJxJK-mcfuMEE-QAIXAN2r
X-Proofpoint-ORIG-GUID: ORaH1_D7aAYJxJK-mcfuMEE-QAIXAN2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_08,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=909
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1034 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most BPF programs are small, but they consume a page each. For systems
with busy traffic and many BPF programs, this could add significant
pressure to instruction TLB.

Introduce bpf_prog_pack allocator to pack multiple BPF programs in a huge
page. The memory is then allocated in 64 byte chunks.

Memory allocated by bpf_prog_pack allocator is RO protected after initial
allocation. To write to it, the user (jit engine) need to use text poke
API.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc0142e20c72..25e34caa9a95 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -805,6 +805,133 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 	return slot;
 }
 
+/*
+ * BPF program pack allocator.
+ *
+ * Most BPF programs are pretty small. Allocating a hole page for each
+ * program is sometime a waste. Many small bpf program also adds pressure
+ * to instruction TLB. To solve this issue, we introduce a BPF program pack
+ * allocator. The prog_pack allocator uses HPAGE_PMD_SIZE page (2MB on x86)
+ * to host BPF programs.
+ */
+#define BPF_PROG_PACK_SIZE	HPAGE_PMD_SIZE
+#define BPF_PROG_CHUNK_SHIFT	6
+#define BPF_PROG_CHUNK_SIZE	(1 << BPF_PROG_CHUNK_SHIFT)
+#define BPF_PROG_CHUNK_MASK	(~(BPF_PROG_CHUNK_SIZE - 1))
+#define BPF_PROG_CHUNK_COUNT	(BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
+
+struct bpf_prog_pack {
+	struct list_head list;
+	void *ptr;
+	unsigned long bitmap[BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)];
+};
+
+#define BPF_PROG_MAX_PACK_PROG_SIZE	HPAGE_PMD_SIZE
+#define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
+
+static DEFINE_MUTEX(pack_mutex);
+static LIST_HEAD(pack_list);
+
+static struct bpf_prog_pack *alloc_new_pack(void)
+{
+	struct bpf_prog_pack *pack;
+
+	pack = kzalloc(sizeof(*pack), GFP_KERNEL);
+	if (!pack)
+		return NULL;
+	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
+	if (!pack->ptr) {
+		kfree(pack);
+		return NULL;
+	}
+	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
+	list_add_tail(&pack->list, &pack_list);
+
+	set_vm_flush_reset_perms(pack->ptr);
+	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	return pack;
+}
+
+static void *bpf_prog_pack_alloc(u32 size)
+{
+	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
+	struct bpf_prog_pack *pack;
+	unsigned long pos;
+	void *ptr = NULL;
+
+	if (size > BPF_PROG_MAX_PACK_PROG_SIZE) {
+		size = round_up(size, PAGE_SIZE);
+		ptr = module_alloc(size);
+		if (ptr) {
+			set_vm_flush_reset_perms(ptr);
+			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
+			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
+		}
+		return ptr;
+	}
+	mutex_lock(&pack_mutex);
+	list_for_each_entry(pack, &pack_list, list) {
+		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
+						 nbits, 0);
+		if (pos < BPF_PROG_CHUNK_COUNT)
+			goto found_free_area;
+	}
+
+	pack = alloc_new_pack();
+	if (!pack)
+		goto out;
+
+	pos = 0;
+
+found_free_area:
+	bitmap_set(pack->bitmap, pos, nbits);
+	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
+
+out:
+	mutex_unlock(&pack_mutex);
+	return ptr;
+}
+
+static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
+{
+	struct bpf_prog_pack *pack = NULL, *tmp;
+	unsigned int nbits;
+	unsigned long pos;
+	void *pack_ptr;
+
+	if (hdr->size > BPF_PROG_MAX_PACK_PROG_SIZE) {
+		module_memfree(hdr);
+		return;
+	}
+
+	pack_ptr = (void *)((unsigned long)hdr & ~(BPF_PROG_PACK_SIZE - 1));
+	mutex_lock(&pack_mutex);
+
+	list_for_each_entry(tmp, &pack_list, list) {
+		if (tmp->ptr == pack_ptr) {
+			pack = tmp;
+			break;
+		}
+	}
+
+	if (WARN_ONCE(!pack, "bpf_prog_pack bug\n"))
+		goto out;
+
+	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
+	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >> BPF_PROG_CHUNK_SHIFT;
+
+	bitmap_clear(pack->bitmap, pos, nbits);
+	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
+				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
+		list_del(&pack->list);
+		module_memfree(pack->ptr);
+		kfree(pack);
+	}
+out:
+	mutex_unlock(&pack_mutex);
+}
+
 static atomic_long_t bpf_jit_current;
 
 /* Can be overridden by an arch's JIT compiler if it has a custom,
-- 
2.30.2

