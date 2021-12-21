Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8D47C19E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhLUOgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbhLUOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:36:21 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF3C06173F;
        Tue, 21 Dec 2021 06:36:21 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id de30so12752988qkb.0;
        Tue, 21 Dec 2021 06:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4jATogAI/X/Ike2rZf+Yx9DRJFuDNaLWBLR/iU1PYg=;
        b=isPNMdg1x+7jQ6kJvjFOGC1jmsQGsRxBai79shTWIoUJpy7B5MAb9HwOwPa13fG+y/
         yCOJlIV0bukQ5NX1jafceyXqpxKTg5zHTldwdyeoEkdwAuO2db/SSLIf2x4Sh/29EBCu
         R1RW71rjBH2XiRdAMuKwDXv+8I7MXtCDq0iY5Lw4c0ooz3QmLaGWyqNNwsCQVODO+gg2
         R+hmFGwsYCFjfeHh7t6rvhNdum3egmHEZfZ6dGH4W7bGjdww7PGX8fi57ZVkQmlvEK+i
         rVZm/r5GA/4yHX9FxsXgGK16Jyv+1m5yMJdkfGc1M07EzhR1lgO9B+NiiNavJpQlRcmN
         UL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4jATogAI/X/Ike2rZf+Yx9DRJFuDNaLWBLR/iU1PYg=;
        b=Pu3CHnxGQkoJaFkp4VQMS4pTcYQL+6+HyPi2sW+gYmE5DIBMGB8AEdTjA1U2MqxJue
         heTgo3JLnrxeGxHuJj0Vv1nFRScPkxchc63rU9kKsjXkjsWcAkzPBuDb9DYbDO73ixtn
         xT08K4DmfaQyKQXdzULxsvlplraPXNFSad3G+CalBXU5or3pPmlMnib99qT1T4z0cGNp
         6Z3r+1hJF+t2BfzIweixj5mrTrL4HUMc1Sx4QU6tiB4/PL+k6iENocxfgc54MsLdx6YU
         ncSUQ+H5v59UZuV2HGuxeHiicXsc40hrntq5Fs+xIUUc08cF0npseTLWC4D5o+OU7wIU
         0z6Q==
X-Gm-Message-State: AOAM5319uudJRmz7i6iKEGnqqBJ4Wti/AiioEeHFaiqpcZwWgLCED5T5
        tM0x1gQT9tNZVq1v8IVA4CCGUHuma9k=
X-Google-Smtp-Source: ABdhPJxiZSUF3StAEgxIAHWnZdRI8ppfUx3rQSlT/4DKU3VFMKiHsWGo6KDEgTyGtc+OIMIj2vWmKg==
X-Received: by 2002:a05:620a:2989:: with SMTP id r9mr2134129qkp.630.1640097380278;
        Tue, 21 Dec 2021 06:36:20 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t15sm18246031qta.45.2021.12.21.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:36:19 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ceph: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue, 21 Dec 2021 14:36:14 +0000
Message-Id: <20211221143614.480385-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck warning:
./fs/ceph/debugfs.c: 390: 0-23: WARNING: congestion_kb_fops should be
defined with DEFINE_DEBUGFS_ATTRIBUTE

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
debugfs files.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/ceph/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 3cf7c9c1085b..64c4158c17c8 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -387,8 +387,8 @@ static int congestion_kb_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
-			congestion_kb_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
+			 congestion_kb_set, "%llu\n");
 
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
-- 
2.25.1

