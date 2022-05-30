Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CBF537358
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiE3Bkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiE3Bkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:40:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2849F3EB9B
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 18:40:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so8907471pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7unC4ownPzSgIneOEus8VvlbiKaGr/5bsj+MLLARkw=;
        b=F+jcLhmMa1fdNwt934xZxIvqAZrp3oqK6FasgDl2yEX4zP18/6i2Z/r029sARrDkqm
         vzey0c9a2KdCguchIJnmk1FllnQMQgZosbAgpXnndjFotR0925XK3aMpsw3xKoLjdyut
         7jE5WSGjBeFo7Fi4+ULEMHNBxbHfmj04GS9Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7unC4ownPzSgIneOEus8VvlbiKaGr/5bsj+MLLARkw=;
        b=U1ajdoicqhbfqQAljqjNjQ3+JE1Kh0ICHpMqSpeL84CH6UmynmEAJZfJC3+1nH4ml7
         bBzwAQT/rYR0skYMetgAhPWUPJbHEPXRNb08LH0HZavvdA68E09Bqf4hqCnOp2pwgucM
         tdcWeSbKxpl0xtwY142C84OyMYyIA50Z8T93mQiauEamF675Xm5DcnM+vh+qoB2AmpQy
         UqSYnu26Vky7ygeuK+E4GwlSxieh4tURQeXCC+JRJzfERnaYsrsgxxG6LU+SrcUHKUKL
         o5UtKzEqJw7+5rOJ7GXPXM8ATx0A+H5dyFPCi11L2B3ZB80m0NwaA8ZKg8GiIePF8sq4
         v8uA==
X-Gm-Message-State: AOAM530B/AtUJUagJgwkhhhrWptDUkcQl6USqv5v7+f93+wAX0PpA6Q6
        K1YvggpsYX7k1ez60Ojt9L0W3g==
X-Google-Smtp-Source: ABdhPJwdJa+Pqh5Tbb+vDpYt+mvq0qnp6W55sOpBmdl0koBatfm81awmkOl+mUugzpDJBFnI8yAosw==
X-Received: by 2002:a65:668b:0:b0:3f6:4026:97cd with SMTP id b11-20020a65668b000000b003f6402697cdmr44684419pgw.420.1653874845626;
        Sun, 29 May 2022 18:40:45 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902eb0900b0015f2d549b46sm662285plb.237.2022.05.29.18.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 18:40:45 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v3 2/2] FUSE: Retire superblock on force unmount
Date:   Mon, 30 May 2022 11:39:58 +1000
Message-Id: <20220530113953.v3.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220530013958.577941-1-dlunev@chromium.org>
References: <20220530013958.577941-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force unmount of FUSE severes the connection with the user space, even
if there are still open files. Subsequent remount tries to re-use the
superblock held by the open files, which is meaningless in the FUSE case
after disconnect - reused super block doesn't have userspace counterpart
attached to it and is incapable of doing any IO.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

---

Changes in v3:
- No changes

Changes in v2:
- Use an exported function instead of directly modifying superblock

 fs/fuse/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff88..8875361544b2a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -476,8 +476,11 @@ static void fuse_umount_begin(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (!fc->no_force_umount)
-		fuse_abort_conn(fc);
+	if (fc->no_force_umount)
+		return;
+
+	fuse_abort_conn(fc);
+	retire_super(sb);
 }
 
 static void fuse_send_destroy(struct fuse_mount *fm)
-- 
2.31.0

