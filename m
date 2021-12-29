Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5E48114A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhL2Jcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:32:39 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:54910 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230306AbhL2Jci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:32:38 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACnr58iK8xhbnV6BQ--.12799S2;
        Wed, 29 Dec 2021 17:32:18 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] crypto: af_alg - check possible NULL pointer
Date:   Wed, 29 Dec 2021 17:32:16 +0800
Message-Id: <20211229093216.1753083-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnr58iK8xhbnV6BQ--.12799S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1fCryxZrWxCw4ftw4DXFb_yoWDAwb_ur
        WDAr4UuryUX3WfXF1Dtay3KryIga13ury8WF4Fkr43K3WkJasxZ3ZFyrySyFZrCa4xurW3
        Gw1kKr17uw12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIhFcUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the possible alloc failure of the alloc_page(), it could
return NULL pointer.
And then it will cause the BUG_ON() in sg_assign_page().
Therefore, it should be better to check it before to avoid the bug.

Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of duplicate code")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 crypto/af_alg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 18cc82dc4a42..a1c0118e222d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -931,11 +931,18 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			sg_unmark_end(sg + sgl->cur - 1);
 
 		do {
+			struct page *pg;
 			unsigned int i = sgl->cur;
 
 			plen = min_t(size_t, len, PAGE_SIZE);
 
-			sg_assign_page(sg + i, alloc_page(GFP_KERNEL));
+			pg = alloc_page(GFP_KERNEL);
+			if (!pg) {
+				err = -ENOMEM;
+				goto unlock;
+			}
+
+			sg_assign_page(sg + i, pg);
 			if (!sg_page(sg + i)) {
 				err = -ENOMEM;
 				goto unlock;
-- 
2.25.1

