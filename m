Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D65494364
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiASXGg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 18:06:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbiASXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:06:36 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs857030729
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:06:35 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp0x32bw6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:06:35 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 15:06:34 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BB60528220C5F; Wed, 19 Jan 2022 15:06:27 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 1/7] x86/Kconfig: select HAVE_ARCH_HUGE_VMALLOC with HAVE_ARCH_HUGE_VMAP
Date:   Wed, 19 Jan 2022 15:06:14 -0800
Message-ID: <20220119230620.3137425-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119230620.3137425-1-song@kernel.org>
References: <20220119230620.3137425-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oHZNtHzHI1255dt_6tz4z63Q5pKNZnF-
X-Proofpoint-GUID: oHZNtHzHI1255dt_6tz4z63Q5pKNZnF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=948 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1034 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201190122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This enables module_alloc() to allocate huge page for 2MB+ requests.
To check the difference of this change, we need enable config
CONFIG_PTDUMP_DEBUGFS, and call module_alloc(2MB). Before the change,
/sys/kernel/debug/page_tables/kernel shows pte for this map. With the
change, /sys/kernel/debug/page_tables/ show pmd for thie map.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8910b09b5601..b5d1582ea848 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -158,6 +158,7 @@ config X86
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
-- 
2.30.2

