Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A2586F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiHARIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiHARIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:08:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6CC5F8D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:08:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso12703679pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZ45skYt+QsgiGTf4iZf0SoM7IKDU7UG5QSoVFTYwAc=;
        b=S1Rkuu/J6jIsBqpQF9a8DvfpIbwnSiUOHdlSoTNQU376k14NEV3caGP+nm1b1kY2lh
         sg428cIGSQwqZ7fBHHM2iZPgahmmlkl1hcDQfyali+bW/oMkV2aFrSNUgYaNfsidkLZf
         g1/ekzFmMOQNCsX9auIRZaSzCXjmRGZOOQnHHIuXWKj3+diImEBGjzJrfOWS/pz1tO7y
         ESAUK7BTm2FNY5IMpREGjNGQa4XrNhNsDCAn/+7IVzML16M2NRFzFw4IWc/RyvxTVgaL
         SpzGOkR2ydsBTxUE4rFtYX6253nagZFyGlzPeD6RdNWdocdEflKXpNYkSKfM2c4/vfpg
         XLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZ45skYt+QsgiGTf4iZf0SoM7IKDU7UG5QSoVFTYwAc=;
        b=cauX3i6mupg7Q7JwshxKz8silirWJk/SUcpZ32aiAeupoObP+0rbonBkdWmiGmzoBZ
         UhKhXMMV22msKMozvt1sqM5oGiIBeReF7pSUVECwvt9HniIUR+X86XHkaxUaRoMErxfV
         bzXsiNB7qmV6QIpHE7BPdTiWowMqGvn2b58+AaLN7w70zdQBKqvcOnD9rgoL2cmSxCz0
         zw1OkOfZkR2yzlCc7vJl0tDMS82AcOD5B5fVb9LbitoJ6JAp9DWnatGVWgwF1jribnkh
         OycFuj3s21JNnQCcaar5QhlWwpH+slvHzXaVbPziYj6tMf231Qpb/f3jt5vi9RZ5KZSC
         w5mA==
X-Gm-Message-State: ACgBeo1hhT+FCgNx6HpfXVuMadI2YefD0bQ4OLULMeYBVwQhcs5mUgeF
        D2KEOEa9mR4Vye2J5V8JfFWLSsihtUU=
X-Google-Smtp-Source: AA6agR42ymQ0MfxHchByUpL+k4EHuOPvSrtG10vX5VfJu6H2/wiCihFxnQpZj+Ujz5EmgnxNvK2pKg==
X-Received: by 2002:a17:90b:3a8b:b0:1f5:2048:cbab with SMTP id om11-20020a17090b3a8b00b001f52048cbabmr319291pjb.196.1659373694054;
        Mon, 01 Aug 2022 10:08:14 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:7c40:5eed:9318:104a])
        by smtp.gmail.com with ESMTPSA id f185-20020a6251c2000000b0052b9351737fsm9185056pfb.92.2022.08.01.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:08:13 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: revive F2FS_IOC_ABORT_VOLATILE_WRITE
Date:   Mon,  1 Aug 2022 10:08:08 -0700
Message-Id: <20220801170808.1692711-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

F2FS_IOC_ABORT_VOLATILE_WRITE was used to abort a atomic write before.
However it was removed accidentally. So revive it by changing the name,
since volatile write had gone.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Fiexes: 7bc155fec5b3("f2fs: kill volatile write support")
---
 fs/f2fs/file.c            | 30 ++++++++++++++++++++++++++++--
 include/uapi/linux/f2fs.h |  2 +-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8098ed890e94..29711e5b6983 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2109,6 +2109,31 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	return ret;
 }
 
+static int f2fs_ioc_abort_atomic_write(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
+	int ret;
+
+	if (!inode_owner_or_capable(mnt_userns, inode))
+		return -EACCES;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+
+	if (f2fs_is_atomic_file(inode))
+		f2fs_abort_atomic_write(inode, true);
+
+	inode_unlock(inode);
+
+	mnt_drop_write_file(filp);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	return ret;
+}
+
 static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -4054,9 +4079,10 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_start_atomic_write(filp);
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 		return f2fs_ioc_commit_atomic_write(filp);
+	case F2FS_IOC_ABORT_ATOMIC_WRITE:
+		return f2fs_ioc_abort_atomic_write(filp);
 	case F2FS_IOC_START_VOLATILE_WRITE:
 	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
-	case F2FS_IOC_ABORT_VOLATILE_WRITE:
 		return -EOPNOTSUPP;
 	case F2FS_IOC_SHUTDOWN:
 		return f2fs_ioc_shutdown(filp, arg);
@@ -4725,7 +4751,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 	case F2FS_IOC_START_VOLATILE_WRITE:
 	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
-	case F2FS_IOC_ABORT_VOLATILE_WRITE:
+	case F2FS_IOC_ABORT_ATOMIC_WRITE:
 	case F2FS_IOC_SHUTDOWN:
 	case FITRIM:
 	case FS_IOC_SET_ENCRYPTION_POLICY:
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 352a822d4370..3121d127d5aa 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -13,7 +13,7 @@
 #define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
 #define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
 #define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
-#define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
+#define F2FS_IOC_ABORT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
 #define F2FS_IOC_GARBAGE_COLLECT	_IOW(F2FS_IOCTL_MAGIC, 6, __u32)
 #define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
 #define F2FS_IOC_DEFRAGMENT		_IOWR(F2FS_IOCTL_MAGIC, 8,	\
-- 
2.37.1.455.g008518b4e5-goog

