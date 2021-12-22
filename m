Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0347D56E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbhLVQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbhLVQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:54:32 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12117C061574;
        Wed, 22 Dec 2021 08:54:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso3548965otf.12;
        Wed, 22 Dec 2021 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLeJv0YKrXEZUCTJ+MUC8IbEScS5fCd9zeuVvi4v7lw=;
        b=bUXhF68yFuBlsnma+zM30xTscXcxg6QkZpnURkEJ72944a8vMu5JRCnBB9MTOhkiz5
         Nhz0zBmZy/9U174b057z6LfWQhNqGDkg+IEuZqLODjwaRuLwIxEuGS7mHB8pt1TO1lH7
         XakkxN2foqoRP8YupNfH4CJlhdAGgV9BU14WF++D4QG93P2KUIPzK9IhmMRVIcpIek6A
         bjTKMq4KfhPJtkulC7sZLNY6BvLDz/b8sKVD001qWX6oflIllUcRtjnXl5wG0aGLbrJ8
         ei2FG7kczW4wsMKvtSdfgUA9HMzNwvsAV0lcjVsIr78r9saXs+ujGKFNQRCg7DOAgSHW
         CpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hLeJv0YKrXEZUCTJ+MUC8IbEScS5fCd9zeuVvi4v7lw=;
        b=BjtOpVhTcdV+dhln6iucedRKWLqLTQ2RBwQgode47FnPheta55RhNqgiJpZ2upugrA
         3gSdshyT7J19H/zNBeI0DQlMjgE9jrYt76l3qjthyXz+ghtyvQDP9Y9KNcpz4C4FZFMl
         2/b1l8hbabOq6ByasL/y3rsWaLppV0HL4jhIu8aGs3f3orFcaMbWSHEXceBkXfKH4CQK
         KA30X0NigpfO1ctCFgoLYcvV43LEwxZTV+/hGEZWjx8s8vbDJdD8U7Pspe6RfMJKz4UM
         SRPFsWDwg2PC/rdksIOgCp2GiDyJVr0rP5HJcgt9MbeDe+zzFeWva5ylGITH7otRqg+S
         RIpA==
X-Gm-Message-State: AOAM533l4Xu63hPLODCmlMMsCLTPFvwhQYYFke8omoIseH0NOM6AnnUE
        deP4kM6xcvl0X7yKsiEefhzBjM1Mk9w=
X-Google-Smtp-Source: ABdhPJxxVzbhdFZ7aSgqVuaYbLGli1vp6A1ad5gG0BbvFbQb4zT6acWMJNoWPP+55jQqdIl5JHnDzQ==
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr2609227otk.12.1640192071435;
        Wed, 22 Dec 2021 08:54:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g17sm460521oiy.14.2021.12.22.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 08:54:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] scsi: bsg: Ignore bsg queue registration failures again
Date:   Wed, 22 Dec 2021 08:54:27 -0800
Message-Id: <20211222165427.1855582-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5f7cf82c1d73 ("scsi: bsg: Fix errno when
scsi_bsg_register_queue() fails"), errors from registering the bsg queue
are no longer ignored but returned to the caller. At the same time, the
comment in the code still states that errors are ignored. On top of that,
the message preporting the problem is printed as dev_info, not dev_err.
Both suggest that errors from bsg queue registrations should indeed be
ignored.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jackie Liu <liuyun01@kylinos.cn>
Fixes: 5f7cf82c1d73 ("scsi: bsg: Fix errno when scsi_bsg_register_queue() fails"
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Commit 5f7cf82c1d73 has proliferated to stable releases, so this patch
should probably be backported as well.

Alternatives:
- revert commit 5f7cf82c1d73
- Change the comment to match the code, and print the message as error

 drivers/scsi/scsi_sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index d4edce930a4a..caa4ad1f893a 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1391,10 +1391,9 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 			 * We're treating error on bsg register as non-fatal, so
 			 * pretend nothing went wrong.
 			 */
-			error = PTR_ERR(sdev->bsg_dev);
 			sdev_printk(KERN_INFO, sdev,
-				    "Failed to register bsg queue, errno=%d\n",
-				    error);
+				    "Failed to register bsg queue, errno=%ld\n",
+				    PTR_ERR(sdev->bsg_dev));
 			sdev->bsg_dev = NULL;
 		}
 	}
-- 
2.33.0

