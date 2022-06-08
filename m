Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66466542E39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiFHKrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiFHKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:47:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520C19D61D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:46:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o6so12215981plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8InSgeXLwfrcaHfRuxvIJANyDBCvKCk2nOrjxdkMIcU=;
        b=SUv17aoXPEtYR5RFG2kPuj0X9X4Z+T7ixPPSpyJ/qMi9HKO+QGXlCmY4HaNknzqeiW
         /3Iw9+p9eNacTPl+qwQyygH21Qfz3eXtDNysZGkIpNTX/MNa+KW/bLK+PlgKBPsgL01e
         J8JQwvcdoPjQ8JH6PcMDORtMgMBeNHiCQUhmi/v3qXyEiD/SHEwToQ5lpZ8TOFeS5q3Z
         NizlRPtwh1sd7TB9KYQhskY93DjBCpOqA2KYIeYoJ8rmuv2zp/qYh3iX/0ttpfITTrhG
         BfQYimdYu4Vqmk+P4usEZGhxXfaScCNobq84tpJC57TSfc3uhDIp+Vsfx4e6AwO5fz8k
         efng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8InSgeXLwfrcaHfRuxvIJANyDBCvKCk2nOrjxdkMIcU=;
        b=qFBJkFpfNmIDLfOcORFwWFR78XLsXftRsJmL7DcUcZUT8RvRZNPlG7SMirAPADpDQR
         3rzomXbZxvWj1zCYfb8ow7GpCm/WFp+8nFpbq+S2oU6MpWv6uBFiIjwCsPKeMlOvaWUz
         EdsTBpaWlGZLj2WVQwyXAooKL+Z+TvLCYCiyFdrMTZGrwgPAtHI+H/ozdFN3uN1m5Lpv
         /uZn3nps8LAHa3g9nLn4AfUd06+n4TtCGsmWlvBtK1E55BO9xJp0BYXKSly4v2ALcalL
         pqOMV2OW+RKhsx7lmm2AyR+qHeALzgoqlW9dhd6MxbCioq/RoEhNuRgjZQtQbShu+YH2
         Pt+Q==
X-Gm-Message-State: AOAM530OviAh57ig7UY3AhI4OwvI//+Yvq+EszluGGGvOeujCbrTv4yj
        r1gHOIJFKwwIsg2cgWDiLFzaCA==
X-Google-Smtp-Source: ABdhPJzP3FzTaPpt8WBSXwyU/ycJSySOlYjXjI4sfswEsIS2jvv35dS7APubdGQ/rp83piPd54p6Fw==
X-Received: by 2002:a17:90b:3845:b0:1e2:e175:be04 with SMTP id nl5-20020a17090b384500b001e2e175be04mr36968296pjb.50.1654685211279;
        Wed, 08 Jun 2022 03:46:51 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79413000000b0051be7a8c008sm10290275pfo.30.2022.06.08.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:46:50 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] fuse: add FOPEN_INVAL_ATTR
Date:   Wed,  8 Jun 2022 18:42:02 +0800
Message-Id: <20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that the fuse daemon can ask kernel to invalidate the attr cache on file
open.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/file.c            | 4 ++++
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fdcec3aa7830..9609d13ec351 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -213,6 +213,10 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		file_update_time(file);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	}
+
+	if (ff->open_flags & FOPEN_INVAL_ATTR)
+		fuse_invalidate_attr(inode);
+
 	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
 		fuse_link_write_file(file);
 }
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..0b0b7d308ddb 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -301,6 +301,7 @@ struct fuse_file_lock {
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_INVAL_ATTR: invalidate the attr cache on open
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -308,6 +309,7 @@ struct fuse_file_lock {
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_INVAL_ATTR	(1 << 6)
 
 /**
  * INIT request/reply flags
-- 
2.20.1

