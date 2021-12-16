Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D18476B15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhLPHgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:36:13 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:40568 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229664AbhLPHgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:36:10 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAB3fVlW7LphnmY9Aw--.50137S2;
        Thu, 16 Dec 2021 15:35:50 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     jiasheng@iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/mpi: potential dereference of null pointer
Date:   Thu, 16 Dec 2021 15:35:48 +0800
Message-Id: <20211216073548.305145-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3fVlW7LphnmY9Aw--.50137S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr45AFW5Zr4ftF4kJrWrZrb_yoWxAFg_Ca
        yvgr1UWry29F1S9F45KrWYkrWFy3WkGFWFgw1fK343K3sxAryfWr9rXr95tFW3CrWj9rs8
        ua1qkay3tw13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUh4SOUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of kcalloc() needs to be checked.
To avoid dereference of null pointer in case of the failure of alloc.

Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 lib/mpi/mpi-mod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
index 47bc59edd4ff..54fcc01564d9 100644
--- a/lib/mpi/mpi-mod.c
+++ b/lib/mpi/mpi-mod.c
@@ -40,6 +40,8 @@ mpi_barrett_t mpi_barrett_init(MPI m, int copy)
 
 	mpi_normalize(m);
 	ctx = kcalloc(1, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
 
 	if (copy) {
 		ctx->m = mpi_copy(m);
-- 
2.25.1

