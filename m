Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D04CD105
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiCDJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiCDJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:29:34 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E215678D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646386119;
        bh=9nv3X+PI2qu6S4FIO3dCfbr9ddZT2wf9ArBKScnME/0=;
        h=From:To:Cc:Subject:Date;
        b=VBlSSm+K4N84PyldKA051om/DtFDMIdKNXpSapGz69ke3yj8jaLQQFkoy/kZGNb/q
         n99NdkVBVHvXigTJij7//6QK5TT8HNuTFhSl4gHCy4WIX3G4R9eYP8F2pw1dnsV+/Y
         dyYlCQiD6W9kxKWfYHXglm0lterVQKNvtQRKucy0=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 72409668; Fri, 04 Mar 2022 17:28:36 +0800
X-QQ-mid: xmsmtpt1646386116tbkzo2c36
Message-ID: <tencent_DE1C3D1422E1DD4A35FFDE2048CC48B94E08@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NozOAi+JJCABEY3i1EXbuvNRsh15xf91h5rO8srnqJ7a4cQkxZyU
         yMtZYX08rGRz2HoXf9OkTZWzJ2Nf2SiuTB6L5a1wAKykuso4yqT4U3P+ttqVgliTJFHk6cHQ3unL
         E9m8+1LkSdU8d0zaD1wq6Wnx4BzJkyLW/2ZATSR62kbv5vr1RqBvfp9x9cjc4JYdu0VFTYO6gm/6
         gdcU7SDadfg8KCHMyulAoZT9MF1syTbLfs2rsCNR9uGLrv085QiHH7qYfCmiYJAFvm99JA0L+vU1
         wkO/yTRBPtX+PF9HDRF85y7bx+bV67exLS9I1cchNZXHj4vjZDKIf4VRkk9vzKMiyKdocAEqSj0d
         lBcHa6nhzqOu4vZOl+UHrbVnlsVqfoPsLXmsz8cnN24ITeSUhENF0Cx/AAj6Qnte4eVYL9h7PDIp
         6pKkI6Z0sjYMSj/fnvC4XjjlLBaWaLOxWoNOjPSo9vwE4Bl9MVzWVSYVcnAnxu7dysR3P0NW3W3l
         ABpwOHXoBnEmRqolSfRrdICmEBm+iyjYpSAELX/7Z0gwi20jdNOa/b+592zvuPrevEk7QRtZyJZb
         G5o3w9NafwRxefHs/8u1Is+nLVjESNSa9CshQ1UHRGpmdvvrO5g9HKwYdlKGMkqXnleakR/UG5ka
         Vnz3dUVvzABZ+IUNtNHbCqjFUsJRk3yvXA0konaER1l6S7Hhary8dztgfr99HkjKuomz85D5qvbj
         KnfvrDpwr0cLsU9sua1ljXUQSTB7MTiZNcT5IZW7RMCxaVpBb9GViHE/WRnkoVKjiywloRAby81q
         Ud2pWoLV9XwkTueT0sA9NRvMIGBlvVrMeJUvoUpyASl3AMyV3KOxD0oE/7K9KGTA8+JMSQ8YcjzV
         e5odC5TfMSC/txIpI+8Jlatl1inYx4/2b2rBy41K7WhFIZnl+mBMAKAP0R06FPrdBoPbhOxVgr
From:   xkernel.wang@foxmail.com
To:     linux@dominikbrodowski.net, akpm@linux-foundation.org,
        pombredanne@nexb.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        luc.vanoostenryck@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] init/initramfs.c: check the return value of kstrdup()
Date:   Fri,  4 Mar 2022 17:27:34 +0800
X-OQ-MSGID: <20220304092734.5096-1-xkernel.wang@foxmail.com>
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

kstrdup() is also a memory allocation function which is similar
with kmalloc() in some way. Once some internal memory errors
happen, it will return NULL. It is better to check the return
value of it so to catch the memory error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 init/initramfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index a842c05..49deffb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -139,8 +139,12 @@ static void __init dir_add(const char *name, time64_t mtime)
 	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
 	if (!de)
 		panic_show_mem("can't allocate dir_entry buffer");
-	INIT_LIST_HEAD(&de->list);
 	de->name = kstrdup(name, GFP_KERNEL);
+	if (!de->name) {
+		kfree(de);
+		panic_show_mem("can't duplicate dir name");
+	}
+	INIT_LIST_HEAD(&de->list);
 	de->mtime = mtime;
 	list_add(&de->list, &dir_list);
 }
-- 
