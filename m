Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C9568346
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiGFJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiGFJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:15:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABAB7CE;
        Wed,  6 Jul 2022 02:15:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so19707343pjl.5;
        Wed, 06 Jul 2022 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heBhDPAZZcza0ZAAL/XaeCAoRWcoC2O1hG9RrLQTw+Q=;
        b=SiAFl/uCcoQQbxAciu9Sn4YY+1os4B3LfvgPMpNoFHJZET+MPChoGxCZJprfbp6v6E
         N91BbYFyo7Dqfm3lIBmveiOhD+UI0xRcD+KpbNlQxCThmRq2t8gPLgc8mc998KjSDckM
         F9jS+v2pA7zJ3z9dvpCGUa+jKi1DcttlBdrqXtgx3YiYAykwU+NE4ANj+FRM/xfGC+9w
         NS+unZ9EpTs56Wh0Vl/pH0V5Zm4MKHjHL2EZGXsqUTJGVUT6AfHqEO6K4ZUgXLoh/cHP
         7kunI1PBzYBi2NuBvTue8+z50mizOLVz3xAIznzywqFIO3TMGWo8fPjvLvvSQYcMIBH3
         Tfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heBhDPAZZcza0ZAAL/XaeCAoRWcoC2O1hG9RrLQTw+Q=;
        b=acnhygCblwKHl6pbSttNA7kALWB+EeoLOOw6YFuGept63nGx1t80R+h1sw/RHtFuNE
         3YORlQmhKInXrR4NJYwsOSuxWAEeCj5Yn0spd9cZWXcrsGzHuMCgFj13WCbgDxzzp4MJ
         HnhZ79Mk/KLN+hsrLmFH6cR1dEZfxF1hLiExoFtD0Bg6rTauyij5EKOO5KDVqonb8DtW
         qX5xB1VqaSOJZbPWUrkuXpZUg2NA327ZGwrOz45lBqp3dN379KDdYYBC0ZK8IQG6Tlqw
         49Ko3vqmZEu3e4KRgwlUdFNpXvdKB0Y7CF/WMtvtuTAJkD4ubHR0P3+z1Gf0lfhbUDGf
         IiiQ==
X-Gm-Message-State: AJIora8Iq1Y9IsfZeKCC9gyT63mTUABvpji6iwizs3iKrKOiONsw8Tg6
        IL1CyNMI9o+U8b6V2wEUwpYlO2iBXNxZow==
X-Google-Smtp-Source: AGRyM1sf/WnWaGWp85yrdFZgYzGzuzrJhJYkkNYI+LwYbZl0m4pyUiA2SsFaYprMKjDKb26Myuuwww==
X-Received: by 2002:a17:902:dad1:b0:16a:75cb:5d97 with SMTP id q17-20020a170902dad100b0016a75cb5d97mr46194698plx.64.1657098929770;
        Wed, 06 Jul 2022 02:15:29 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id y23-20020a63ce17000000b004123c6a084dsm5422582pgf.22.2022.07.06.02.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:15:28 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH] loop: introduce LO_FLAGS_NODEALLOC
Date:   Wed,  6 Jul 2022 17:14:55 +0800
Message-Id: <20220706091455.35063-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
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

