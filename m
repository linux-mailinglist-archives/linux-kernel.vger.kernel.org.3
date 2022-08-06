Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8358B546
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiHFLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiHFLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:53:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF8C13F35;
        Sat,  6 Aug 2022 04:53:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so4750389plb.1;
        Sat, 06 Aug 2022 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=heBhDPAZZcza0ZAAL/XaeCAoRWcoC2O1hG9RrLQTw+Q=;
        b=clJZvg33Ms69X/Orul5iigRMffsjZe0LZadG/V5rejiXsUx+zh7+99cnmqK2WkM9K/
         MKkM5CGzq8tK5vn+noSD9xxUQrzdZu76/AwecixBztnEDdVH/+2DH+MIvBkM91rbbJ+T
         QSw6F1uVXbpTqDGejVprYVmdxQMrNvb0Ys16+4Oc6nth6fBVwlCCV2RmThK5wBHSLiEm
         ih8v+NI7Ybi862ov3KjFR9jTg3zJbVSeJqzTA+kQTb3CBsgq814YE76fI8KF+YCdK3E2
         XTGO+H2uFmPFKlAQDHDYtouyBRXiBmUxPmVioDi8XXMMujNMvfZA5p0ft3HQa8AyNdyV
         vw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=heBhDPAZZcza0ZAAL/XaeCAoRWcoC2O1hG9RrLQTw+Q=;
        b=foYA7VfX5qvXY0NPHMhrOv27aeZaUAJ71PBslPOdhqF9eK527V+03agSScNAThw6ax
         DVXg4znOCAUuarMLHwu0Z/Q9ecfjljbsdfOmdjhBmunX5e4+GDKOSF5YZpMJ55JcsKN/
         rHUqadoRU6HQh5PKwrJacMtSnzwgN85sHjUgdEcyVKV9zLDkhuqVuXn8UumZrXihq4Rz
         EH+a7VXKW0iOKOnLgE69pfanaviTZKLQtFy8jfYsgIvZokn0nq+NUduirQx+ghT5w3RU
         6KMrd9iaSlNZywWDnfb/btrmMEBZkjXtbmhgZZ8EuVml0oMULvBi9t8guM1LoCEce3zH
         1XlQ==
X-Gm-Message-State: ACgBeo2wcb987dYd3bUmQat1bJYQEZuYAAbgCMW7UpZEKPLwLDRl/xu9
        fx5Z4Fn/2hN485Kn3lewJdw=
X-Google-Smtp-Source: AA6agR4um04uQKprTicpQn3JoysmwEb/eRFeMNM0KJRhrbcz0we74+wG1SwPxOCFv1qw71h0QPvVGg==
X-Received: by 2002:a17:90b:33cb:b0:1f4:f635:93f8 with SMTP id lk11-20020a17090b33cb00b001f4f63593f8mr21164587pjb.74.1659786784785;
        Sat, 06 Aug 2022 04:53:04 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b0016c57657977sm4954649plk.41.2022.08.06.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 04:53:04 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND 1/1] loop: introduce LO_FLAGS_NODEALLOC
Date:   Sat,  6 Aug 2022 19:49:43 +0800
Message-Id: <20220806114943.8754-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806114943.8754-1-zhangboyang.id@gmail.com>
References: <20220806114943.8754-1-zhangboyang.id@gmail.com>
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

