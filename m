Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56448214F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 02:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhLaBlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 20:41:04 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:36718 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242471AbhLaBlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 20:41:03 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAAXHFiVX85hbHPvBA--.30636S2;
        Fri, 31 Dec 2021 09:40:37 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     ebiggers@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] crypto: af_alg - check possible NULL pointer
Date:   Fri, 31 Dec 2021 09:40:36 +0800
Message-Id: <20211231014036.1870631-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXHFiVX85hbHPvBA--.30636S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1kKF4xGw1xAFWftr4ruFg_yoWkJrg_Cr
        yDAr1Durs7Zr18CF4DJa17Gr10qayUurW8WrWjk343K3W5JasrX3Wqyr13ArZrCa4xuFWk
        Ww1qkr17C342vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbYFAPUUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the possible alloc failure of the alloc_page(), it could
return NULL pointer.
And there is a check below the sg_assign_page().
But it will be more logical to move the NULL check before the
sg_assign_page().

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

* Change 1. Move the previous check in front of sg_assign_page().
---
 crypto/af_alg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 18cc82dc4a42..f79e446d8132 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -931,16 +931,19 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			sg_unmark_end(sg + sgl->cur - 1);
 
 		do {
+			struct page *pg;
 			unsigned int i = sgl->cur;
 
 			plen = min_t(size_t, len, PAGE_SIZE);
 
-			sg_assign_page(sg + i, alloc_page(GFP_KERNEL));
-			if (!sg_page(sg + i)) {
+			pg = alloc_page(GFP_KERNEL);
+			if (!pg) {
 				err = -ENOMEM;
 				goto unlock;
 			}
 
+			sg_assign_page(sg + i, pg);
+
 			err = memcpy_from_msg(page_address(sg_page(sg + i)),
 					      msg, plen);
 			if (err) {
-- 
2.25.1

