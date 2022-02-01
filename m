Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF94A5745
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiBAGeU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Feb 2022 01:34:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23174 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234266AbiBAGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:34:10 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21111Ra4007814
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:34:09 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxq3gakcf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:34:09 -0800
Received: from twshared19733.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 22:34:06 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4FADF290EC90B; Mon, 31 Jan 2022 22:28:21 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v8 bpf-next 6/9] bpf: introduce bpf_arch_text_copy
Date:   Mon, 31 Jan 2022 22:28:00 -0800
Message-ID: <20220201062803.2675204-7-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201062803.2675204-1-song@kernel.org>
References: <20220201062803.2675204-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: k86lWTSXupwe3NZZB1bR5mW3N5g2RFTw
X-Proofpoint-ORIG-GUID: k86lWTSXupwe3NZZB1bR5mW3N5g2RFTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_02,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=992 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used to copy JITed text to RO protected module memory. On
x86, bpf_arch_text_copy is implemented with text_poke_copy.

bpf_arch_text_copy returns pointer to dst on success, and ERR_PTR(errno)
on errors.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 7 +++++++
 include/linux/bpf.h         | 2 ++
 kernel/bpf/core.c           | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36f6fc3e6e69..c13d148f7396 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2412,3 +2412,10 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	if (text_poke_copy(dst, src, len) == NULL)
+		return ERR_PTR(-EINVAL);
+	return dst;
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 366f88afd56b..ea0d7fd4a410 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2362,6 +2362,8 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
+void *bpf_arch_text_copy(void *dst, void *src, size_t len);
+
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e3fe53df0a71..a5ec480f9862 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2440,6 +2440,11 @@ int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return -ENOTSUPP;
 }
 
+void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
-- 
2.30.2

