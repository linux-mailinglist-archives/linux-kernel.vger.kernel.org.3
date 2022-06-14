Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2E854AA20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbiFNHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352657AbiFNHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:12:08 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AC983B54C;
        Tue, 14 Jun 2022 00:12:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 71A761E80D5E;
        Tue, 14 Jun 2022 15:10:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ro-17gUlV4U2; Tue, 14 Jun 2022 15:10:44 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 30F761E80D0E;
        Tue, 14 Jun 2022 15:10:44 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com,
        Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] libceph: check pointer before assigned to "c->rules[]"
Date:   Tue, 14 Jun 2022 15:10:59 +0800
Message-Id: <20220614071059.23696-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be better to check pointer firstly, then assign it
to c->rules[]. Refine code a little bit.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 2823bb3cff55..6ec5007f96dc 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -571,9 +571,9 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 			goto bad;
 #endif
 		r = kmalloc(struct_size(r, steps, yes), GFP_NOFS);
-		c->rules[i] = r;
 		if (r == NULL)
 			goto badmem;
+		c->rules[i] = r;
 		dout(" rule %d is at %p\n", i, r);
 		r->len = yes;
 		ceph_decode_copy_safe(p, end, &r->mask, 4, bad); /* 4 u8's */
-- 
2.11.0

