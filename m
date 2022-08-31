Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788215A747F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiHaDeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaDeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:34:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556472851;
        Tue, 30 Aug 2022 20:34:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so12970748plq.12;
        Tue, 30 Aug 2022 20:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OA6ZBoW6tn54/FgmsdfdLrU3vD7MdBVPqn+LErflnVQ=;
        b=e2g6MN3EJpfYl45WC5dxQGRvivXW81wOQIEYjU2qfv81vB9FTvz/6upDepxVuhuya2
         +taNNFrBbvjxC0fp6LyH1SlxXlM7R9EdVnO4jiQBNyzy0VGa/K137Be/VPm01AAqK9ei
         BVS0Xmjz4NPcoXiVrqLfTYIIkMds9cXJ/vJ0MFTgY7qoJOB8P405Tr21LZZ2/g9NzUad
         aOvG4/eNUpqTTXMvH3nevgv/yJxX0U0ip3VEX2lRBrAj6A9SIqwdwwuYMHIn9Yp4lRGQ
         D6n7gLjN0v8+T8FbOOD4eCT73U385gPmdiYufueATdy7BPaxisevTC8NOrQUZavGhCib
         u6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OA6ZBoW6tn54/FgmsdfdLrU3vD7MdBVPqn+LErflnVQ=;
        b=DES5QrIj5x46KtsNwEbmSIuaiYkwQHfugOkaHijxR0f2wKVfxHk3UN5FVezsDRPXti
         WRbxit/5w79u73hz/22eSAWoZBNr4Cd9oQ0MnrPI8RVnUdLIM5jRn8DD5AHtK+ZXqR3V
         4G4EH+nfG5cC94x3NJqJNtC3Y0or8K2LD5P5v1fCV/lwPQnTu96tKz/cBnnU23kV7yh9
         wJv6sztSOHV5rt4PmnImSCy68dkYzK0JQXZOb3njnyCGto8sK2LrOese5U/0EKNO6ndP
         mw/Nv/yuHrbgqIEcVtf1Gf4XD4y+pgBz1ybBGcpyN6/SyP/1SMcqHVrh5wOW+TYvQG34
         StqQ==
X-Gm-Message-State: ACgBeo3z/2aqspWLXH6yPMZmS/HS/j5ufa7uvBBvI9gII/UVmanmLwcw
        AR/pTWkH3z781JynBymjIAM=
X-Google-Smtp-Source: AA6agR5tn6t50NcAH4dIghqyCwlDHVV7yw3QtH+YFO06ApdnNnZagxi12y3SaRc0nBJTuLru0llq0A==
X-Received: by 2002:a17:902:db05:b0:172:f759:f99d with SMTP id m5-20020a170902db0500b00172f759f99dmr23989099plx.76.1661916849880;
        Tue, 30 Aug 2022 20:34:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q5-20020aa79605000000b00537a6b81bb7sm10404829pfg.148.2022.08.30.20.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:34:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] nilfs2: Remove the unneeded result variable
Date:   Wed, 31 Aug 2022 03:34:03 +0000
Message-Id: <20220831033403.302184-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value nilfs_segctor_sync() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/nilfs2/segment.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 0afe0832c754..9abae2c9120e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2235,7 +2235,6 @@ int nilfs_construct_segment(struct super_block *sb)
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct nilfs_sc_info *sci = nilfs->ns_writer;
 	struct nilfs_transaction_info *ti;
-	int err;
 
 	if (!sci)
 		return -EROFS;
@@ -2243,8 +2242,7 @@ int nilfs_construct_segment(struct super_block *sb)
 	/* A call inside transactions causes a deadlock. */
 	BUG_ON((ti = current->journal_info) && ti->ti_magic == NILFS_TI_MAGIC);
 
-	err = nilfs_segctor_sync(sci);
-	return err;
+	return nilfs_segctor_sync(sci);
 }
 
 /**
-- 
2.25.1
