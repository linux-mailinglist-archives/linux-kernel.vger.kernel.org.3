Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AE4D87AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiCNPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiCNPE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:04:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430B3E5F9;
        Mon, 14 Mar 2022 08:03:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t11so24444972wrm.5;
        Mon, 14 Mar 2022 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=s9afH/O5dsvmhKf0xLBy1pTIXzqvR2poyDjCQitPnEo=;
        b=qfRD3pKDrDX47pmXSjGhNqcjA7KM+hfWLwQM0iFWiIeul9+y0qGGCT1FHQdZRds8vE
         rlD8MF93CHJIRVUqf+UB7bHOrFpDrf+esCnBJBZd5HMW4Qsj8xLzYgIVo9oSLFQ63Ex6
         kyp6MMBK7Tnsnt5SRHWKZpREIkF/rHNqGdUlKhAYRli7ZkPQiF98SSn6NBFd9wjzPCvz
         qshV0Z88R9mJiX/I4yt1k1rVulf0TniklKm8pYqeRSo/kuymwRKuk0KoIAnhNY4+5rxo
         qZLiiXms1Q1OuiJtiSwt68dLbGNeOEIPdJ9jHl08i7QKOgNRuiz+Zp6jDGyJ0LwWA0qo
         Ge0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s9afH/O5dsvmhKf0xLBy1pTIXzqvR2poyDjCQitPnEo=;
        b=ofGLPVEYcpvbhZ5pYKSKoYQApAwmH6tz3K7tzUrZd7sGvMCGNflEyN5Nc8J/rXn4qm
         C+mQ+eyaf3S9CjaxI29XSad5i3wOubwDAmvwAWuiKvzxpdZK08W0w/l9OKFGE/jjfYo9
         ZcYqztIBq078RN/dbgnYO8ouHi+9ca3awHhTmkwrVyPJnizj19g8nYul6iF+bU8ZGiU/
         fHvUtJ7LbnXqFIBCk/5mcmNfc3zFh/LTm4xDv2qSNey/s25cgm6W1MQcrDfQ1iWi0u6o
         pXiDblVq2s0oAqsEldt1mGSv0HRCV9fFnIXyoT7JEdDjVYwJ51rIn7a8w3W8/U+4A2xY
         0ETA==
X-Gm-Message-State: AOAM532xSquo8tQPybGwFtK+krgVryHTO6HGlsE3awXYVA1V6N7S4xCc
        QiHhnf4TFWZ9uwekRj/Eqfc=
X-Google-Smtp-Source: ABdhPJx6tlK4XTUgp3t2NhLgW6fI5LZXMa6JxSyqNy1w53t5oFfFJVnfI1IC5qUXdBorh3/4e6raHg==
X-Received: by 2002:a05:6000:1868:b0:203:732f:d657 with SMTP id d8-20020a056000186800b00203732fd657mr16382494wri.664.1647270227888;
        Mon, 14 Mar 2022 08:03:47 -0700 (PDT)
Received: from felia.fritz.box (200116b82624ff0060a4091d550340a9.dip.versatel-1u1.de. [2001:16b8:2624:ff00:60a4:91d:5503:40a9])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b0038999b380e9sm14984749wme.38.2022.03.14.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:03:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] sr: simplify the local variable initialization in sr_block_open()
Date:   Mon, 14 Mar 2022 16:03:21 +0100
Message-Id: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 01d0c698536f ("sr: implement ->free_disk to simplify refcounting")
refactored sr_block_open(), initialized one variable with a duplicate
assignment (probably an unintended copy & paste duplication) and turned one
error case into an early return, which makes the initialization of the
return variable needless.

So, simplify the local variable initialization in sr_block_open() to make
the code a bit more clear.

No functional change. No change in resulting object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Christoph, please ack.

Jens, please pick this minor clean-up on your -next branch on top of the
commit above.

 drivers/scsi/sr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 00142095522a..5ba9df334968 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -483,9 +483,9 @@ static void sr_revalidate_disk(struct scsi_cd *cd)
 
 static int sr_block_open(struct block_device *bdev, fmode_t mode)
 {
-	struct scsi_cd *cd = cd = scsi_cd(bdev->bd_disk);
+	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
 	struct scsi_device *sdev = cd->device;
-	int ret = -ENXIO;
+	int ret;
 
 	if (scsi_device_get(cd->device))
 		return -ENXIO;
-- 
2.17.1

