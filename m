Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A74E4BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiCWDua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiCWDu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:50:27 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2C716D8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648007320;
        bh=aPCfa2VR27sIrzeHgV7GyBgO3tUA+0rcNecygkJYcgQ=;
        h=From:To:Cc:Subject:Date;
        b=Mmc+oGhqpCYTKxy1vTZ0ENqdY6QvrAvzbptDGOgHumhlJvsVtF1Sq/3jjyJNpRR7z
         WbtHzFKgLJjvhaLkALbe/RLSZ9yxe+S+ZJaXMgoPnuvqS4K+cnOOlrEMsnUH86tAhd
         y0ybqVbu8sJq5uvN79ddag3tjB88fUnUE+34WmJ4=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id C242AE0C; Wed, 23 Mar 2022 11:48:36 +0800
X-QQ-mid: xmsmtpt1648007316th29usvoz
Message-ID: <tencent_7CB95F1C3914BCE1CA4A61FF7C20E7CCB108@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur93WeYZSV4oqu8CMBJfbeHrGR5Ufzg0ImwLGgFHkCDtc9aEgz4Yq
         NGeDZYXHFyzLjBKNk/RIiHuLbFczN4z8nCi1+byjjaEsg0lGS7ubJznSqXmEBc7eSfkIgmer3RI1
         ZdorD4YNjQYzly7jxbkJnu5e4FlNVXQDl9z02dsS4RlkizNLOPKW9Gbn5NSvb8fJA0V9O1JiovYY
         t2g2wgMCC9ZKAM2rWSMFUuroGE0pjtCSLoAR88Q6TDijBdHTUV6dwH5oOTuv1xWKS+aHd/KwjhdX
         Z0bWhHL73BjBUgAsZ93CSUbV4KOKXkYz0vA0VZQQJQcNCfqiEzdWUPygEbWBXWFy5t8ms7MEe3Ah
         V820Atney3HBHBPtsR0yTU0O+Ix5daei5nxB5rCDKImY6oI9G8Xjh0valst5TUXEsVR4GmP0va4n
         QGXiexvDOA6V7nfF7peIFql3JNHE8chLIZKOaqEX2W9LpIFbjun+OkgT2UZn5ydo1yqNwm9IKWxX
         syDDdfgvv7GM3PA0ggcle5ngFDKXPgE4xTvKG5hEtLFa2qsEklAT1oCNsp9pbbiPW6flTvO6xbb8
         SJXOhqSuEyEywpdMQW9XwBK9ERlekOnrDhJpl1l1C1VX82dlzVa64SAfkB6YB9jZy+bkevD2O7vo
         8IRDGwkqCmUwzsmVrhnH3djC7aiRun08g9oLfQykm9x7+1X0FFJf8CPlx/hAwUsA1p0Oek2mmug6
         X5+nkMBLHCdW12YByAhJMecE2c7vs++PZBw0peFXuzdTd06QnRiTg+XUwMcqKmVP/0BvcbcYFVeF
         z7mkSntim5zCXfwKvf60Q1z89Z1iZvfw9VHXh86Mr/dSxh1dbxFWFNUcenrpMEqgm45QVHUa1OYx
         gIcynbaOD1jWv4FL5/INMC90Kx0Z55Sst24Q8Dj3oQt7NdGAvDt/UacLLQSUyrOsKtIRTcuBAX8R
         n6pGNs4A3VLVapGaICeKn/fkSstcoOzrGWa6O7KromO4VGsyYdIEMiKKmbbNc1
From:   xkernel.wang@foxmail.com
To:     glider@google.com, akpm@linux-foundation.org
Cc:     andreyknvl@gmail.com, elver@google.com, dvyukov@google.com,
        ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] lib/test_meminit: optimize do_kmem_cache_rcu_persistent() test
Date:   Wed, 23 Mar 2022 11:48:24 +0800
X-OQ-MSGID: <20220323034824.2026-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

To make the test more robust, there are the following changes:
1. add a check for the return value of kmem_cache_alloc().
2. properly release the object `buf` on several error paths.
3. release the objects of `used_objects` if we never hit `saved_ptr`.
4. destroy the created cache by default.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 lib/test_meminit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 2f4c4bc..8d77c3f 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -300,13 +300,18 @@ static int __init do_kmem_cache_rcu_persistent(int size, int *total_failures)
 	c = kmem_cache_create("test_cache", size, size, SLAB_TYPESAFE_BY_RCU,
 			      NULL);
 	buf = kmem_cache_alloc(c, GFP_KERNEL);
+	if (!buf)
+		goto out;
 	saved_ptr = buf;
 	fill_with_garbage(buf, size);
 	buf_contents = kmalloc(size, GFP_KERNEL);
-	if (!buf_contents)
+	if (!buf_contents) {
+		kmem_cache_free(c, buf);
 		goto out;
+	}
 	used_objects = kmalloc_array(maxiter, sizeof(void *), GFP_KERNEL);
 	if (!used_objects) {
+		kmem_cache_free(c, buf);
 		kfree(buf_contents);
 		goto out;
 	}
@@ -327,11 +332,14 @@ static int __init do_kmem_cache_rcu_persistent(int size, int *total_failures)
 		}
 	}
 
+	for (iter = 0; iter < maxiter; iter++)
+		kmem_cache_free(c, used_objects[iter]);
+
 free_out:
-	kmem_cache_destroy(c);
 	kfree(buf_contents);
 	kfree(used_objects);
 out:
+	kmem_cache_destroy(c);
 	*total_failures += fail;
 	return 1;
 }
-- 
