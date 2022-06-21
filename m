Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874E6552B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbiFUHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346302AbiFUHCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:02:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50771F625;
        Tue, 21 Jun 2022 00:02:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k7so11723466plg.7;
        Tue, 21 Jun 2022 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP9kY1WLbTW1UUbmBJofW8GbuL6xle8PjzjvugZSxOg=;
        b=SLV71dKUg3TQYNZ8Ov1PzCQj/KlKFftSY4Elu8YMPPFvpS43VsZa3GnP7e+gmuBo4/
         diOHtXnjRDfe/yMonBX4hc2qURDLdQikcTvxwpH5DUsufrgoI+k5oanXVjLM/16+R10L
         vu6dP0U7M/27ARt8/vf81kvSe8cj9iUMMMUyJDo873tNPzQGra//6xwXO4nDD0a2XkbM
         aeOKwmsPyo1mKSBCwj3yLzPM7MKlEZLfB3TGx2cSvD9JBVKoS1Xe7dI4geKr5h+gMLVx
         ZwRtXx83cQo0R120KKbewu2Cl3dZumo8xmJJAQcAJf4V9dVJCCfL/gKjsWBs3h059vkP
         EX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP9kY1WLbTW1UUbmBJofW8GbuL6xle8PjzjvugZSxOg=;
        b=fhEI8NO8wa0mG5irEwFjTHBrnIJTQgsd0HmKTA5NyhYFE6b89UUAFG/AD2f5Ujku0B
         dUCqhxm9Xb/ODtiB60RktDY6hfESBXvhqjS6PKxWa7OLX7vCD5P2jN5eh3g0xm3d2OAU
         E/ODVj6bwlpAIs3xz6bXI/yogK1dxh+ukzggXGpkla/g6cbXFou7YPF/55B10f+kju2d
         myBx91LHIxLDzxkir2HeIYZNRQ0GUDCbuKAqEUqCUoaHPcvYPZ3s+guF6F72dYmRj0GB
         2rgOXxtySl6vQgxeci9Mnh2ahzACti+3pSTe5K7JGUwbOF1GmmnV6tfbVDd+NhOjNpM0
         biTA==
X-Gm-Message-State: AJIora/ubKQVPAt32QBrwuO0jWvx1xjKDjh1WEOE3ii4s1MHVg0UbvRr
        HujlQQe6uGh2wZe8By5mfhA=
X-Google-Smtp-Source: AGRyM1t3BNK6v69eKX4WKcobj7IS/1nTrq976lTNyPKRkLdkjl7F/QjYJKOnACZGunK544a3XGG5ng==
X-Received: by 2002:a17:90b:682:b0:1e3:142:a562 with SMTP id m2-20020a17090b068200b001e30142a562mr41217624pjz.91.1655794959392;
        Tue, 21 Jun 2022 00:02:39 -0700 (PDT)
Received: from localhost.localdomain ([178.173.230.211])
        by smtp.gmail.com with ESMTPSA id p9-20020a63ab09000000b00408a9264b36sm10454082pgf.3.2022.06.21.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:02:38 -0700 (PDT)
From:   Shida Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Shida Zhang <zhangshida@kylinos.cn>
To:     djwong@kernel.org, dchinner@redhat.com
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v2] xfs: add check before calling xfs_mod_fdblocks
Date:   Tue, 21 Jun 2022 15:02:24 +0800
Message-Id: <20220621070224.1231039-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks are missing when delta equals 0 in __xfs_ag_resv_free() and
__xfs_ag_resv_init().

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changes from v1:
 -Add checks before calling xfs_mod_fdblocks instead.

 fs/xfs/libxfs/xfs_ag_resv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag_resv.c b/fs/xfs/libxfs/xfs_ag_resv.c
index fe94058d4e9e..c8fa032e4b00 100644
--- a/fs/xfs/libxfs/xfs_ag_resv.c
+++ b/fs/xfs/libxfs/xfs_ag_resv.c
@@ -149,7 +149,12 @@ __xfs_ag_resv_free(
 		oldresv = resv->ar_orig_reserved;
 	else
 		oldresv = resv->ar_reserved;
-	error = xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
+
+	if (oldresv)
+		error = xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
+	else
+		error = 0;
+
 	resv->ar_reserved = 0;
 	resv->ar_asked = 0;
 	resv->ar_orig_reserved = 0;
@@ -215,8 +220,13 @@ __xfs_ag_resv_init(
 
 	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_AG_RESV_FAIL))
 		error = -ENOSPC;
-	else
-		error = xfs_mod_fdblocks(mp, -(int64_t)hidden_space, true);
+	else {
+		error = 0;
+		if (hidden_space)
+			error = xfs_mod_fdblocks(mp, -(int64_t)hidden_space,
+						true);
+	}
+
 	if (error) {
 		trace_xfs_ag_resv_init_error(pag->pag_mount, pag->pag_agno,
 				error, _RET_IP_);
-- 
2.25.1

