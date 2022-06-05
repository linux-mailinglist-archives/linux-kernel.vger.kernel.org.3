Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AFB53DB56
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiFELfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFELfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 07:35:45 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2019F18396
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eqpUkIQ0qCx1Qjo01B
        MjvUWJtIvSsdBr6NysCXODjYM=; b=dxcKglqlvEfsGpDeNQzMmAdDx95qrg8AAo
        LODKnqt+X/6CdvVCI2FzyH4dlrpvc/1dxSOcnzG8xzNN444gHPSLdxNaywhsebRC
        6cSNIDMizlOvEHYdK1oTze9BxzslAkTzf+cXRsVw8dyOAdFvML50aGy+GnJKWFrp
        Tscrslvj4=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp11 (Coremail) with SMTP id D8CowADn3_PqlJxiz7HLGA--.65442S4;
        Sun, 05 Jun 2022 19:35:14 +0800 (CST)
From:   Xiaohui Zhang <ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.or,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] l2tp: fix possible use-after-free
Date:   Sun,  5 Jun 2022 19:35:03 +0800
Message-Id: <20220605113503.36153-1-ruc_zhangxiaohui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowADn3_PqlJxiz7HLGA--.65442S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xKF18ZF1UWrWfAw1fWFg_yoWkXwc_Xr
        yxW3W8Wrn5Xa1xGr42va1YqFWvyrZIkrWrCw1xtrsFya4rtasakF97JFWvvw1Uu3yq9r9a
        grsYqw47Kw1DujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiCzu7UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: puxfs6pkdqw5xldrx3rl6rljoofrz/1tbiThIXMFUDPVwDMAAAs-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>

We detected a suspected bug with our code clone detection tool.

Similar to the handling of l2tp_tunnel_get in commit a622b40035d1
("l2ip: fix possible use-after-free"), we thought a patch might
be needed here as well.

Before taking a refcount on a rcu protected structure,
we need to make sure the refcount is not zero.

Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
---
 net/l2tp/l2tp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7499c51b1850..b759fbd09b65 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -252,8 +252,8 @@ struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
 
 	rcu_read_lock_bh();
 	hlist_for_each_entry_rcu(session, session_list, hlist)
-		if (session->session_id == session_id) {
-			l2tp_session_inc_refcount(session);
+		if (session->session_id == session_id &&
+		    refcount_inc_not_zero(&session->ref_count)) {
 			rcu_read_unlock_bh();
 
 			return session;
-- 
2.17.1

