Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADBE46CFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhLHJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:21:20 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16344 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhLHJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:21:19 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J8BPw16MKz91gH;
        Wed,  8 Dec 2021 17:17:08 +0800 (CST)
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 17:17:46 +0800
Subject: [PATCH v2 2/2] arm64: mm: Use asid feature macro for cheanup
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
References: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <204aef78-cf5b-a337-af71-5d52ba845aa0@huawei.com>
Date:   Wed, 8 Dec 2021 17:17:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The commit 95b54c3e4c92 ("KVM: arm64: Add feature register flag
definitions") introduce the ID_AA64MMFR0_ASID_8 and ID_AA64MMFR0_ASID_16
macros.

We can use these macros for cheanup in get_cpu_asid_bits().

No functional change.
---
 arch/arm64/mm/context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index bbc2708fe928..b8b4cf0bcf39 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -50,10 +50,10 @@ static u32 get_cpu_asid_bits(void)
 		pr_warn("CPU%d: Unknown ASID size (%d); assuming 8-bit\n",
 					smp_processor_id(),  fld);
 		fallthrough;
-	case 0:
+	case ID_AA64MMFR0_ASID_8:
 		asid = 8;
 		break;
-	case 2:
+	case ID_AA64MMFR0_ASID_16:
 		asid = 16;
 	}

-- 
2.27.0
