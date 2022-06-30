Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816B25614F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiF3I0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiF3I0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:26:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC1F37
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:26:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k9so8234946pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SypOXZhyCHcQ8uGWyAhO7T7jqGFnGubO/tkVQlNzSa4=;
        b=DeEze/KklMdcNbZipxXzP0SlnFO+AajUe1pUYxnUv+AWjVWwPzyohpvkUKIM4n/ryI
         kKqok4eZ12Vu/RmNcksSQrpSPnMPpu1xcNezPxxq6I9JPbuv3qb0Y+AaCvRwxiX/Q7HI
         JWc4DJw69J8+rfSzou1PE9NF5z1z/HGVXa1m6N/Q4Ck42Xjc7jOlbzS+HQoRv3qiLOpL
         QPekbxL+9AjUVcTADdpI6qlU706Qm1kbsDSaPdr1Lr5P/JwH4Z0CRONmPQ1PR2OiB/eo
         7q/ZRWyOnANN3b/GTEKM3dFyU05OiSE5lOw6k92eR+yjqsmaGa5ZSHjEb3ZlFJp9PxGQ
         R+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SypOXZhyCHcQ8uGWyAhO7T7jqGFnGubO/tkVQlNzSa4=;
        b=V9xCsU9iPpTKdTc3EdqW+4aTBhTj1opDtLHeW9FaMHVzzorkp+zAQdZhSyrbX1thM1
         PV/rH2pWqLLQ0EWUG4wwMNEc2V1BM+SNLZpMSXsNZ4JmPPsoj/6AtOux3b+bNqEZKWAj
         7KirICfr9SElfPpGHba5oeeB3qO/OIUAPrSXWP2CO5O9onfAtxvWuchm+e9sIa5bDltL
         UPW63RA4LjlQONa8fjZdz4MQXEfzNu16s4Vhbzeo7lG6X0+ySiy5HC955PhtXRWx9CbE
         f4p3vSquV8hQIz9pZEJdL4p3/BxeFdiLxMuiwSOF8Ykj78d8KMQLp3dgTpzjVb3qjknW
         QaFw==
X-Gm-Message-State: AJIora85FWXKBHvA+w71C3e7pJ5qUKFaf7rwgLEkkhjzZQyYIa2vMPoh
        IE2Pm5mKv3KjyzQK2upnTiE=
X-Google-Smtp-Source: AGRyM1uQpCyqTx3DGUB2vNh0oC2rmkVbMFyz51r1Y/mXQcmrjjX2YZ79JlIoKH3UTUsU+9gXklGZAA==
X-Received: by 2002:a05:6a00:10c3:b0:525:40fe:6e8d with SMTP id d3-20020a056a0010c300b0052540fe6e8dmr14418704pfu.38.1656577567706;
        Thu, 30 Jun 2022 01:26:07 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005251e2b53acsm12822797pfw.116.2022.06.30.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:26:07 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH v2] kernfs: fix potential NULL dereference in __kernfs_remove
Date:   Thu, 30 Jun 2022 16:25:12 +0800
Message-Id: <20220630082512.3482581-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

When lockdep is enabled, lockdep_assert_held_write would
cause potential NULL pointer dereference.

Fix the following smatch warnings:

fs/kernfs/dir.c:1353 __kernfs_remove() warn: variable dereferenced before check 'kn' (see line 1346)

Fixes: 393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs lock")
Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---

Change in v2:
- Fix formatting issue

 fs/kernfs/dir.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6eca72cfa1f2..1cc88ba6de90 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1343,14 +1343,17 @@ static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
+	/* Short-circuit if non-root @kn has already finished removal. */
+	if (!kn)
+		return;
+
 	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
 	/*
-	 * Short-circuit if non-root @kn has already finished removal.
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (!kn || (kn->parent && RB_EMPTY_NODE(&kn->rb)))
+	if (kn->parent && RB_EMPTY_NODE(&kn->rb))
 		return;
 
 	pr_debug("kernfs %s: removing\n", kn->name);
-- 
2.27.0

