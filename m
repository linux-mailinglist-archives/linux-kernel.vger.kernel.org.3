Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE647B906
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhLUDep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:34:45 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:41771 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhLUDeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:34:44 -0500
X-QQ-mid: bizesmtp36t1640057672td298u9c
Received: from localhost.localdomain (unknown [182.148.14.81])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 21 Dec 2021 11:34:29 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: F3yR32iATbiWwFtQBNBo5sJaNmYFcaa2HQV0Jbgf2FLm/S+e/ehz4wRmp1/xK
        jCu1jd8+8eaW0DflD1tdNU89q6YMXc1wz+BbgWltyuz8iNxv9KmhpTvc43HIHyCw4cWbXpA
        PM34fYjAkhfTFvlOB2qkrv9gvixVpoEwbymeFHPFUBAs5Qog//9nzVsOcbEncTF6g6SgdHN
        uOqbXtmUK72FpcmB+DjihealX09Y1kpJyMcUlcVJ07yvwPUrUVumac8+rpuPUGrC2riNQNN
        V/pk1ISnOuN/JYoEjCzAAwZOuq8QfOZlAZP/8gZsr2gEIGEcyUcjOepo5ud3dnDwGjDuheU
        t7/mtiGVXRoiS5V4uhFk5hLeO2SXQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] powerpc: No need to initialise statics to 0
Date:   Tue, 21 Dec 2021 11:34:23 +0800
Message-Id: <20211221033423.29820-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/powerpc/platforms/powermac/nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index 853ccc4480e2..4d23793c2f1f 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -71,7 +71,7 @@ struct core99_header {
 static int nvram_naddrs;
 static volatile unsigned char __iomem *nvram_data;
 static int is_core_99;
-static int core99_bank = 0;
+static int core99_bank;
 static int nvram_partitions[3];
 // XXX Turn that into a sem
 static DEFINE_RAW_SPINLOCK(nv_lock);
-- 
2.34.1


