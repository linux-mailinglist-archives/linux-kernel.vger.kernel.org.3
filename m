Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE93658714C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiHATUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiHATUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:20:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419846273;
        Mon,  1 Aug 2022 12:20:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so10512475pgb.4;
        Mon, 01 Aug 2022 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=heBhDPAZZcza0ZAAL/XaeCAoRWcoC2O1hG9RrLQTw+Q=;
        b=FsrlOE4tsSZYBIhg7eL1cGLNkbr5s7AQ6MDD86FOtmiPsPlVzuukphx8rvCvD9lFrG
         OYVMyEmS45kDwd8iEqotzTxYfQZtdH9O86Z46Rni4GbggDC1CsEM0s33s/QGSnWkQiq8
         ieJTOtAzAsitMOtoBvKuDVqDK+NpqWs5eO9lrMy/iriWwE8H7QKSRoluPyjF+7wuYM2m
         XKgdnVbL+6FBR/vPZKushZ9U4ceplKg2nCF6+ptHc1SZutef8Kx6hwOQmWZV1LHEvn35
         9UQr6pO/J8Q7g+IoI8AqqKenCi9FwgE/MCBBmXlTX901iqMCPI3UscgT3E9llrn25Pzh
         L/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=heBhDPAZZcza0ZAAL/XaeCAoRWcoC2O1hG9RrLQTw+Q=;
        b=uwQBJDjo3dIf1vK9UugVk5dkD4Uqs2a5DhC+sHtxoDnAe5YCs8i92Sx5m9Y78V2ffU
         mqjKUP4wDq9Ep3R2NDWAr+hpJd8ga0g9SREN05OmqmrKwg27kCl3EAyQyLn/eMTvDXnb
         mr+sjfxzy3LKd26prsaVCEEHY7gMgc/YyQq9zSGOKQcexnxkDE8jA+ABFp34pUCjXzqU
         Tm3+QF5LtVPiESeOfDL6kA5zEw9o1tqmSZo+HKo0dTAPY7iZnTqeIPW8O1CFnKFTaLyS
         KCJ8oWDp64JEwxJHXhqK7nABRxqpEBNG6sxM96X1UIcpAlqbCVlqD212vDtw/6xgDo0z
         CAxw==
X-Gm-Message-State: AJIora8CsQex9JWFXB/7ZBgilxwBq6z6aCzAcNmgfCyQXaE1BbyF8dGe
        YIYKAiYnjhJeMWXobovV1DZ+s5dZLT8=
X-Google-Smtp-Source: AGRyM1vHqknvJ1u8gmAcJyP+QQSyrQnRqaiz75jjFE5Xhn8w0b7H3adnxYr7Xs+Mi40lMMuAhModng==
X-Received: by 2002:a05:6a00:14c1:b0:52b:4602:5af1 with SMTP id w1-20020a056a0014c100b0052b46025af1mr17111525pfu.24.1659381617595;
        Mon, 01 Aug 2022 12:20:17 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b0016b865ea2ddsm9849318pln.85.2022.08.01.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 12:20:17 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 6.0 RESEND] loop: introduce LO_FLAGS_NODEALLOC
Date:   Tue,  2 Aug 2022 03:20:00 +0800
Message-Id: <20220801192000.15365-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, for file-backed loop devices, REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES (without REQ_NOUNMAP) are implemented using
fallocate(FALLOC_FL_PUNCH_HOLE), which will cause the underlying file to
be sparse and disk space freed. The users have no choice to prevent this
this from happening.

This patch introduces LO_FLAGS_NODEALLOC. With this flag set,
REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES are forced to use
fallocate(FALLOC_FL_ZERO_RANGE). The disk space of underlying file is
kept allocated. This is useful if users, for example, want to use a
preallocated file as the backing file.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 drivers/block/loop.c      | 17 +++++++++++++++--
 include/uapi/linux/loop.h | 15 +++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 084f9b8a0ba3..a52ef0787202 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -483,11 +483,15 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		 * write zeroes the range.  Otherwise, punch them out.
 		 */
 		return lo_fallocate(lo, rq, pos,
-			(rq->cmd_flags & REQ_NOUNMAP) ?
+			((rq->cmd_flags & REQ_NOUNMAP) ||
+			 (lo->lo_flags & LO_FLAGS_NODEALLOC)) ?
 				FALLOC_FL_ZERO_RANGE :
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
-		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+		return lo_fallocate(lo, rq, pos,
+			(lo->lo_flags & LO_FLAGS_NODEALLOC) ?
+				FALLOC_FL_ZERO_RANGE :
+				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, WRITE);
@@ -719,12 +723,20 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
+static ssize_t loop_attr_nodealloc_show(struct loop_device *lo, char *buf)
+{
+	int nodealloc = (lo->lo_flags & LO_FLAGS_NODEALLOC);
+
+	return sysfs_emit(buf, "%s\n", nodealloc ? "1" : "0");
+}
+
 LOOP_ATTR_RO(backing_file);
 LOOP_ATTR_RO(offset);
 LOOP_ATTR_RO(sizelimit);
 LOOP_ATTR_RO(autoclear);
 LOOP_ATTR_RO(partscan);
 LOOP_ATTR_RO(dio);
+LOOP_ATTR_RO(nodealloc);
 
 static struct attribute *loop_attrs[] = {
 	&loop_attr_backing_file.attr,
@@ -733,6 +745,7 @@ static struct attribute *loop_attrs[] = {
 	&loop_attr_autoclear.attr,
 	&loop_attr_partscan.attr,
 	&loop_attr_dio.attr,
+	&loop_attr_nodealloc.attr,
 	NULL,
 };
 
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 6f63527dd2ed..a6afd06ffa07 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -18,17 +18,24 @@ enum {
 	LO_FLAGS_AUTOCLEAR	= 4,
 	LO_FLAGS_PARTSCAN	= 8,
 	LO_FLAGS_DIRECT_IO	= 16,
+	LO_FLAGS_NODEALLOC	= 32,
 };
 
 /* LO_FLAGS that can be set using LOOP_SET_STATUS(64) */
-#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR | LO_FLAGS_PARTSCAN)
+#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR		\
+					| LO_FLAGS_PARTSCAN		\
+					| LO_FLAGS_NODEALLOC)
 
 /* LO_FLAGS that can be cleared using LOOP_SET_STATUS(64) */
-#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR)
+#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR		\
+					 | LO_FLAGS_NODEALLOC)
 
 /* LO_FLAGS that can be set using LOOP_CONFIGURE */
-#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY | LO_FLAGS_AUTOCLEAR \
-				       | LO_FLAGS_PARTSCAN | LO_FLAGS_DIRECT_IO)
+#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY		\
+				       | LO_FLAGS_AUTOCLEAR		\
+				       | LO_FLAGS_PARTSCAN		\
+				       | LO_FLAGS_DIRECT_IO		\
+				       | LO_FLAGS_NODEALLOC)
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <linux/types.h>	/* for __u64 */
-- 
2.30.2

