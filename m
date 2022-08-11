Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE44590926
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiHKX0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiHKX0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:26:01 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0598F941;
        Thu, 11 Aug 2022 16:25:59 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id q14so9678913vke.9;
        Thu, 11 Aug 2022 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Z/3c/f13BD6UjeEAmo6vUxRREzPPnc4YEqQv9afkgVc=;
        b=Uy1/Wa7qyoxj3+x2u6VOkfR8q0VrissUQtRsubf7kkTf5Ntq+WSwaWFhexoWFqM/w+
         rTDTiGJZdXD7RmYSnXxOhiLh9IHQVAWPCjKVChjiwsdudtbmYW8e3mu2ENVHAx+Dd7kG
         ttimuBSd0PUZ/QrvMew8T/L4Y9dhnP3p5zhATaeGmg80capBbIF8ZBuSWxg0EFwcv98v
         EbfJ69V0yvixc7tq9YZ91FuTPSk0/TH+3Nt+4lUc68HUq8jZnDubLOHMn34SuwhvIri8
         UoX8bpTIsv0rtE4cPpXsNGxzMDBzeb+GUB8ewB53izYeVOZsrvLHiR8puT1GUYoCV0tq
         raFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Z/3c/f13BD6UjeEAmo6vUxRREzPPnc4YEqQv9afkgVc=;
        b=giCM5syvNmi7gMoMj/Pasp0s76bfDbIezqNzltolY8XB8eLWjGhmeZa5uXSZQkqPJ+
         Fk5zm1arc36PVMqgSwXhYRg2EUbtyyATefq7dcZ5YTmO75mqcQmbyrDho3E8kR9DYDk5
         DJksY96WDXhS2fQ+75QOMP/42DeUmvgFOAn1O0KwdXdQG1cgPfyHQ5n3e9c3P4uMtUfW
         eKyb5m7xY1RpasffM8xqIdUfxPqxLOzSr3Hb6J0/HpwvMm/yuCr37Cv3kxVWPG1easT9
         iwgB4re7lqZ4y4wyZt9LelIQdHjH4kiatQ7V1Vrxm0olPCs0ljMP+O/2jMqTZ7pI/Ijc
         hYVw==
X-Gm-Message-State: ACgBeo0hUC2ZgzrOZhQMGeqhprJ1VHLTv5ChUnE5Ef8IkM/k6ihwYu82
        t95ldfqquSFHPpGGfA+kIis=
X-Google-Smtp-Source: AA6agR7Xd9nIhNp3jx0UJrnrQCfSISfHh2FtRwIg12f5DR7H9eKiurWK8PGYvxm2WkQz5IWt/8gg0Q==
X-Received: by 2002:a1f:c117:0:b0:377:855a:4e9f with SMTP id r23-20020a1fc117000000b00377855a4e9fmr825613vkf.16.1660260357229;
        Thu, 11 Aug 2022 16:25:57 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:d33f:249:c106:90c1:7b7f])
        by smtp.gmail.com with ESMTPSA id g128-20020a1f2086000000b00375ecb78541sm502816vkg.12.2022.08.11.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:25:56 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Do not call blk_put_queue() if gendisk allocation fails
Date:   Thu, 11 Aug 2022 20:23:37 -0300
Message-Id: <20220811232338.254673-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 6f8191fdf41d ("block: simplify disk shutdown") removed the call
to blk_get_queue() during gendisk allocation but missed to remove the
corresponding cleanup code blk_put_queue() for it. Thus, if the gendisk
allocation fails, the request_queue refcount gets decremented and
reaches 0, causing blk_mq_release() to be called with a hctx still
alive. That triggers a WARNING report, as found by syzkaller:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 23016 at block/blk-mq.c:3881
blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3881
[...] stripped
RIP: 0010:blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3881
[...] stripped
Call Trace:
 <TASK>
 blk_release_queue+0x153/0x270 block/blk-sysfs.c:780
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:721
 __alloc_disk_node+0x4f7/0x610 block/genhd.c:1388
 __blk_mq_alloc_disk+0x13b/0x1f0 block/blk-mq.c:3961
 loop_add+0x3e2/0xaf0 drivers/block/loop.c:1978
 loop_control_ioctl+0x133/0x620 drivers/block/loop.c:2150
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
[...] stripped

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Reported-by: syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 block/genhd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b901fea1d55a..d36fabf0abc1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1341,7 +1341,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (!disk)
-		goto out_put_queue;
+		return NULL;
 
 	if (bioset_init(&disk->bio_split, BIO_POOL_SIZE, 0, 0))
 		goto out_free_disk;
@@ -1390,8 +1390,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	bioset_exit(&disk->bio_split);
 out_free_disk:
 	kfree(disk);
-out_put_queue:
-	blk_put_queue(q);
 	return NULL;
 }
 
-- 
2.34.1

