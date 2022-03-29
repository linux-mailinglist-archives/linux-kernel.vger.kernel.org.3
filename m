Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238064EB492
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiC2UUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiC2UUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:20:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376EFD8D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:18:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s188-20020a6377c5000000b003825c503580so9052635pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2yu8s9+twNetMt5NlS8zweMIK4+TQmaTJETl40EHRC8=;
        b=UJdrFqjz6mv1eWLT+cULEAVSnhcS8zxCK76eCqtdWNA6Ki8oEwlK36rOX+hQEhBt4y
         FZ9bXQA24D+oVI/6Sb4zjevkkBiZKgv7nPDn8fqPvL1vuR58GAVxJ6tzA6uk9OPyyXTp
         1979NShvvW5VTDnB0xh/1ZosnVo0H9M0sY/BJw64cwMxIwdWeiZ+VVFE5eYybX/23uS1
         WfPZog6jE8ROUlTWixI9EkjPKaotx040NUKw4YHZ5LW/S3uJHXNShjVSIdi8uLvyxi0c
         WRGjXLNycnDFqMxR2xBUaunL4vY/u1nIoK1SzStwunxqn8Q/JEQgtELs9AaRO4viUik4
         49nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2yu8s9+twNetMt5NlS8zweMIK4+TQmaTJETl40EHRC8=;
        b=50IqIO7SBPG5NwULcv6YS9xaKePZsIIBM57nXjuWRwbwCwtwHOv7MQKGHU5aOuPfvF
         Un9xp543S2bFAnkV6AwJDNqNVy5nMn188R4UNz3YHX2lEgeMhtkUB4ZEmawNYIbgEWMI
         dlmnbh+IZ3TZjqZ5RFckAmIcY7Tq5JmL/JubNVrFfix7GoSTTxAv8NSZTff1rE78qPoE
         qQ5ntdCNxBuJyMb+2Zo/MEzZ3NeXA0I903MYQmZ07pQUWUenlE/KIjcEEq8t2MFYbmBO
         sg0AfKg1PEyKVfXyimsxMQLFeaGyJguvuQjQ4DfW7XBiIsS9Wqf/NZ3jrnOi83Ir9urj
         asuA==
X-Gm-Message-State: AOAM5339uyWMqZprA4nv9BT/Fb+Yd+F+zHDuXm9q/FD8ZGmAc9HKja27
        Kyxi+mnE5Wkhh+r4hEj+fpGRLOgs726Q6A==
X-Google-Smtp-Source: ABdhPJwfNMsqPO4NDOdl7Uoh2n5Oc64Lgkdf5ZR1Iv67xwzfC5UEY4jtUcq84/fNGxzwTQmP5VDGdqu0Rnbqzg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:f78d:b0:14f:ce61:eaf2 with SMTP
 id q13-20020a170902f78d00b0014fce61eaf2mr31997558pln.124.1648585103681; Tue,
 29 Mar 2022 13:18:23 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:18:15 +0000
Message-Id: <20220329201815.1347500-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] loop: fix ioctl calls using compat_loop_info
From:   Carlos Llamas <cmllamas@google.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for cryptoloop was deleted in commit 47e9624616c8 ("block:
remove support for cryptoloop and the xor transfer"), making the usage
of loop_info->lo_encrypt_type obsolete. However, this member was also
removed from the compat_loop_info definition and this breaks userspace
ioctl calls for 32-bit binaries and CONFIG_COMPAT=y.

This patch restores the compat_loop_info->lo_encrypt_type member and
marks it obsolete as well as in the uapi header definitions.

Fixes: 47e9624616c8 ("block: remove support for cryptoloop and the xor transfer")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/block/loop.c      | 1 +
 include/uapi/linux/loop.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3e636a75c83a..a58595f5ee2c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1591,6 +1591,7 @@ struct compat_loop_info {
 	compat_ulong_t	lo_inode;       /* ioctl r/o */
 	compat_dev_t	lo_rdevice;     /* ioctl r/o */
 	compat_int_t	lo_offset;
+	compat_int_t	lo_encrypt_type;        /* obsolete, ignored */
 	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
 	compat_int_t	lo_flags;       /* ioctl r/o */
 	char		lo_name[LO_NAME_SIZE];
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 24a1c45bd1ae..98e60801195e 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -45,7 +45,7 @@ struct loop_info {
 	unsigned long	   lo_inode; 		/* ioctl r/o */
 	__kernel_old_dev_t lo_rdevice; 		/* ioctl r/o */
 	int		   lo_offset;
-	int		   lo_encrypt_type;
+	int		   lo_encrypt_type;		/* obsolete, ignored */
 	int		   lo_encrypt_key_size; 	/* ioctl w/o */
 	int		   lo_flags;
 	char		   lo_name[LO_NAME_SIZE];
@@ -61,7 +61,7 @@ struct loop_info64 {
 	__u64		   lo_offset;
 	__u64		   lo_sizelimit;/* bytes, 0 == max available */
 	__u32		   lo_number;			/* ioctl r/o */
-	__u32		   lo_encrypt_type;
+	__u32		   lo_encrypt_type;		/* obsolete, ignored */
 	__u32		   lo_encrypt_key_size;		/* ioctl w/o */
 	__u32		   lo_flags;
 	__u8		   lo_file_name[LO_NAME_SIZE];
-- 
2.35.1.1021.g381101b075-goog

