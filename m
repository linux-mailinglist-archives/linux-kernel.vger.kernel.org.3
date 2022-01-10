Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700F34894F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiAJJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiAJJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19625C06175A;
        Mon, 10 Jan 2022 01:12:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v25so10608824pge.2;
        Mon, 10 Jan 2022 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5uGAFhwG1PalEv/hF+X/ZtSoGm0z/W3W27BE5YAO4Hk=;
        b=HclcVXbL/P/hD+zMRRRq3PMc7Z0zkztb27qGLwdXrpjH168r+dmIDTe1bvQzBM6PN0
         CoqL+m6dM+vhPWm1ofsZfpwHjIhJu4EgZCJKZS2HCMxZ3SeEybPC/w+FNXugUmVkFzu4
         uEPnw2eXhxngyTVqLfNGMhCPTQBA+VFk3zdl/5nSQIJEWuDoDd7NDmiiBa/1nus/Z3QB
         B3Ta5CL/HOyXNOMI+RBvPgEjRm5JYJrRFNJrG3NI7f5MQB+C8bW6OZ23oJL5WdJyqPBT
         D3oeHOOlCOeJdj13Qv7kx9cRdNG4Kshbif/lq0n2m3qQC5B3nIq0a1MenIaK0r89IbnR
         0JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5uGAFhwG1PalEv/hF+X/ZtSoGm0z/W3W27BE5YAO4Hk=;
        b=UTdC1MQIIgTH/O62JqGiJT4UmRmKau7Bq1r/tKTjTrUlo7LD1X5ENtBEoF0cp/BdRs
         O1aYK6P7UpAWA1bDw2Zzz3twbKs9wvZZOSvGNkfjVTcBTeowxzyuO1Si9p2F0Yoly2F6
         5ssEuaCgQUqcYgWjY0Rh0dElwHjJHb2R/NQlCV0CVGBCctePpfhPLQDSnCk0x1B2S7fn
         dytuXTfII3RUrxY+XCxmYgx/t53dFH5pKkWAjq3qrYvFSFFV2EUfkVe4j//w+wwKDt8x
         g+6kpus9RWdf/ujOMqUHWwca8ORuhMUTH4SX8SKMXLYCav3zzBGN7hJDK+oJEDFtv21w
         /QSQ==
X-Gm-Message-State: AOAM530VOoHr4T5VjHCYtU95rYsBrAEZbsDDLEy0Im8gYLHrBdvBE4OD
        x3610CldFUoGaVvRPWgnO9Q=
X-Google-Smtp-Source: ABdhPJxvOYj/fwaErfsO6GCO2pBBDv3M4enh4tzXVYxkLKfbV68E2GHA1K7sLhRddzhPPP1seAlZaQ==
X-Received: by 2002:a63:7014:: with SMTP id l20mr1684639pgc.384.1641805948672;
        Mon, 10 Jan 2022 01:12:28 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:28 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] blk: rename ioprio.c to ioprio-common.c
Date:   Mon, 10 Jan 2022 17:10:42 +0800
Message-Id: <20220110091046.17010-10-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

In next patch, blk-ioprio.c is changed to a module named ioprio.ko.
Rename ioprio.c to ioprio-common.c to avoid same ioprio.o in Makefile

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Makefile                      | 2 +-
 block/{ioprio.c => ioprio-common.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename block/{ioprio.c => ioprio-common.c} (100%)

diff --git a/block/Makefile b/block/Makefile
index 8950913cbcc9..beacc3a03c8b 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -8,7 +8,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
+			genhd.o ioprio-common.o badblocks.o partitions/ blk-rq-qos.o \
 			disk-events.o blk-ia-ranges.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
diff --git a/block/ioprio.c b/block/ioprio-common.c
similarity index 100%
rename from block/ioprio.c
rename to block/ioprio-common.c
-- 
2.17.1

