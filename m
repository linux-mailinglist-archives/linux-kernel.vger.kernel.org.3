Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353F58B67E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiHFPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiHFPa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:30:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65655A2;
        Sat,  6 Aug 2022 08:30:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so5511433pjl.0;
        Sat, 06 Aug 2022 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WwqRaS4ZMA18FMv+frsjczvriEq4x14g9pyT+COva4M=;
        b=KVyzDflMIlDNpO21vQF49ICE0PdRi1LnTgv00O3qhnf5BqUuyH0Ac+jkg4HQQm88n4
         0Yys0pKtiradZo7jGXQipKflNF/fXpkhzXXVq4vp4IDyI1yc4VNI2ZF4hV5gxFOVCfvR
         bnDLFWQjHqP10eIEb+f1D5P1fhWrMBSWmhAeMT1BPis2XrLhdrzAlRbSafBq+awaK40c
         KWKaW+Z85XUIrM05Ar+ur+r/rRnXmvoHKj87TyQ+iZld4AohESh+OIF3h11Dh7kqTk7m
         mFGMTrwuOLO/11QZaqCI0c4ZBBjY1GqO8OOHJz2Xojozrx4TuH3p2pWUgw2cEnywH3P4
         fm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WwqRaS4ZMA18FMv+frsjczvriEq4x14g9pyT+COva4M=;
        b=QwQTNxeqHNIV8v9gNC43D5Iw1b+oujyE4RtKmk8rA1sIcHladRSM6mQdHhn1NV1i2D
         gZkrV6MEhBSRvaSHSGYE+2yxDsY2W88v9nHjtUHNmBq0fJwdLR4irE9xURa/xsYvkRO9
         glAIYL8YocC+JZ2FSx4wi5Wat5izvNv5Uc9QiSSwatBv8CthT2iC2OBPC9Hm37z5pWGA
         jLaYzC9R1BNRXEDMxcm05tmW7yBHDIx2A0CQ6BvqKxQr1grWa7zrMfv754FhZPvDAJeF
         TF+IE9C5VT+JHkGUlbFxgrTA8+/ttD4OukkLcg5ad5Px42SadIXQSuKS5xIo88YTPbgq
         wjBw==
X-Gm-Message-State: ACgBeo1mf+5+v762G6CIqyPLRjyYCjU603SC5Iyeo+r2qpSkW17YbAvZ
        u8sWNa5HGMc3GRBNy9pLUZY=
X-Google-Smtp-Source: AA6agR5RaLxSLER8EOF7ZvVGdQ8MlGo7hp4gkIbuennPyzXwd291qCsgoaHdpZw1COkFlSlBXQkDYQ==
X-Received: by 2002:a17:902:e804:b0:16f:4a25:b5be with SMTP id u4-20020a170902e80400b0016f4a25b5bemr11843570plg.171.1659799854983;
        Sat, 06 Aug 2022 08:30:54 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id ds23-20020a17090b08d700b001f3162e4e55sm4867886pjb.35.2022.08.06.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:30:54 -0700 (PDT)
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
Subject: [PATCH V2 1/1] loop: introduce LO_FLAGS_NO_DEALLOC
Date:   Sat,  6 Aug 2022 23:30:22 +0800
Message-Id: <20220806153022.83748-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806153022.83748-1-zhangboyang.id@gmail.com>
References: <20220806153022.83748-1-zhangboyang.id@gmail.com>
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

This patch introduces LO_FLAGS_NO_DEALLOC. With this flag set,
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
index 084f9b8a0ba3..36bd9906a154 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -483,11 +483,15 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		 * write zeroes the range.  Otherwise, punch them out.
 		 */
 		return lo_fallocate(lo, rq, pos,
-			(rq->cmd_flags & REQ_NOUNMAP) ?
+			((rq->cmd_flags & REQ_NOUNMAP) ||
+			 (lo->lo_flags & LO_FLAGS_NO_DEALLOC)) ?
 				FALLOC_FL_ZERO_RANGE :
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
-		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+		return lo_fallocate(lo, rq, pos,
+			(lo->lo_flags & LO_FLAGS_NO_DEALLOC) ?
+				FALLOC_FL_ZERO_RANGE :
+				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, WRITE);
@@ -719,12 +723,20 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
+static ssize_t loop_attr_no_dealloc_show(struct loop_device *lo, char *buf)
+{
+	int no_dealloc = (lo->lo_flags & LO_FLAGS_NO_DEALLOC);
+
+	return sysfs_emit(buf, "%s\n", no_dealloc ? "1" : "0");
+}
+
 LOOP_ATTR_RO(backing_file);
 LOOP_ATTR_RO(offset);
 LOOP_ATTR_RO(sizelimit);
 LOOP_ATTR_RO(autoclear);
 LOOP_ATTR_RO(partscan);
 LOOP_ATTR_RO(dio);
+LOOP_ATTR_RO(no_dealloc);
 
 static struct attribute *loop_attrs[] = {
 	&loop_attr_backing_file.attr,
@@ -733,6 +745,7 @@ static struct attribute *loop_attrs[] = {
 	&loop_attr_autoclear.attr,
 	&loop_attr_partscan.attr,
 	&loop_attr_dio.attr,
+	&loop_attr_no_dealloc.attr,
 	NULL,
 };
 
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 6f63527dd2ed..91a0a8b1f298 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -18,17 +18,24 @@ enum {
 	LO_FLAGS_AUTOCLEAR	= 4,
 	LO_FLAGS_PARTSCAN	= 8,
 	LO_FLAGS_DIRECT_IO	= 16,
+	LO_FLAGS_NO_DEALLOC	= 32,
 };
 
 /* LO_FLAGS that can be set using LOOP_SET_STATUS(64) */
-#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR | LO_FLAGS_PARTSCAN)
+#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR		\
+					| LO_FLAGS_PARTSCAN		\
+					| LO_FLAGS_NO_DEALLOC)
 
 /* LO_FLAGS that can be cleared using LOOP_SET_STATUS(64) */
-#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR)
+#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR		\
+					 | LO_FLAGS_NO_DEALLOC)
 
 /* LO_FLAGS that can be set using LOOP_CONFIGURE */
-#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY | LO_FLAGS_AUTOCLEAR \
-				       | LO_FLAGS_PARTSCAN | LO_FLAGS_DIRECT_IO)
+#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY		\
+				       | LO_FLAGS_AUTOCLEAR		\
+				       | LO_FLAGS_PARTSCAN		\
+				       | LO_FLAGS_DIRECT_IO		\
+				       | LO_FLAGS_NO_DEALLOC)
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <linux/types.h>	/* for __u64 */
-- 
2.30.2

