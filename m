Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E974AC64C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382907AbiBGQoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390693AbiBGQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:32 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0D12C0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:30 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GObV1014387;
        Mon, 7 Feb 2022 17:24:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 04/42] tools/nolibc/types: split syscall-specific definitions into their own files
Date:   Mon,  7 Feb 2022 17:23:16 +0100
Message-Id: <20220207162354.14293-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros and type definitions used by a number of syscalls were moved
to types.h where they will be easier to maintain. A few of them
are arch-specific and must not be moved there (e.g. O_*, sys_stat_struct).
A warning about them was placed at the top of the file.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 110 +---------------------------
 tools/include/nolibc/types.h  | 133 ++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 108 deletions(-)
 create mode 100644 tools/include/nolibc/types.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 186a78c25326..3719959e6f57 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -94,7 +94,9 @@
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
+#include "types.h"
 
+/* Used by programs to avoid std includes */
 #define NOLIBC
 
 /* this way it will be removed if unused */
@@ -111,114 +113,6 @@ static int errno;
  */
 #define MAX_ERRNO 4095
 
-/* for poll() */
-struct pollfd {
-	int fd;
-	short int events;
-	short int revents;
-};
-
-/* for getdents64() */
-struct linux_dirent64 {
-	uint64_t       d_ino;
-	int64_t        d_off;
-	unsigned short d_reclen;
-	unsigned char  d_type;
-	char           d_name[];
-};
-
-/* commonly an fd_set represents 256 FDs */
-#define FD_SETSIZE 256
-typedef struct { uint32_t fd32[FD_SETSIZE/32]; } fd_set;
-
-/* needed by wait4() */
-struct rusage {
-	struct timeval ru_utime;
-	struct timeval ru_stime;
-	long   ru_maxrss;
-	long   ru_ixrss;
-	long   ru_idrss;
-	long   ru_isrss;
-	long   ru_minflt;
-	long   ru_majflt;
-	long   ru_nswap;
-	long   ru_inblock;
-	long   ru_oublock;
-	long   ru_msgsnd;
-	long   ru_msgrcv;
-	long   ru_nsignals;
-	long   ru_nvcsw;
-	long   ru_nivcsw;
-};
-
-/* stat flags (WARNING, octal here) */
-#define S_IFDIR       0040000
-#define S_IFCHR       0020000
-#define S_IFBLK       0060000
-#define S_IFREG       0100000
-#define S_IFIFO       0010000
-#define S_IFLNK       0120000
-#define S_IFSOCK      0140000
-#define S_IFMT        0170000
-
-#define S_ISDIR(mode)  (((mode) & S_IFDIR) == S_IFDIR)
-#define S_ISCHR(mode)  (((mode) & S_IFCHR) == S_IFCHR)
-#define S_ISBLK(mode)  (((mode) & S_IFBLK) == S_IFBLK)
-#define S_ISREG(mode)  (((mode) & S_IFREG) == S_IFREG)
-#define S_ISFIFO(mode) (((mode) & S_IFIFO) == S_IFIFO)
-#define S_ISLNK(mode)  (((mode) & S_IFLNK) == S_IFLNK)
-#define S_ISSOCK(mode) (((mode) & S_IFSOCK) == S_IFSOCK)
-
-#define DT_UNKNOWN 0
-#define DT_FIFO    1
-#define DT_CHR     2
-#define DT_DIR     4
-#define DT_BLK     6
-#define DT_REG     8
-#define DT_LNK    10
-#define DT_SOCK   12
-
-/* all the *at functions */
-#ifndef AT_FDCWD
-#define AT_FDCWD             -100
-#endif
-
-/* lseek */
-#define SEEK_SET        0
-#define SEEK_CUR        1
-#define SEEK_END        2
-
-/* reboot */
-#define LINUX_REBOOT_MAGIC1         0xfee1dead
-#define LINUX_REBOOT_MAGIC2         0x28121969
-#define LINUX_REBOOT_CMD_HALT       0xcdef0123
-#define LINUX_REBOOT_CMD_POWER_OFF  0x4321fedc
-#define LINUX_REBOOT_CMD_RESTART    0x01234567
-#define LINUX_REBOOT_CMD_SW_SUSPEND 0xd000fce2
-
-
-/* The format of the struct as returned by the libc to the application, which
- * significantly differs from the format returned by the stat() syscall flavours.
- */
-struct stat {
-	dev_t     st_dev;     /* ID of device containing file */
-	ino_t     st_ino;     /* inode number */
-	mode_t    st_mode;    /* protection */
-	nlink_t   st_nlink;   /* number of hard links */
-	uid_t     st_uid;     /* user ID of owner */
-	gid_t     st_gid;     /* group ID of owner */
-	dev_t     st_rdev;    /* device ID (if special file) */
-	off_t     st_size;    /* total size, in bytes */
-	blksize_t st_blksize; /* blocksize for file system I/O */
-	blkcnt_t  st_blocks;  /* number of 512B blocks allocated */
-	time_t    st_atime;   /* time of last access */
-	time_t    st_mtime;   /* time of last modification */
-	time_t    st_ctime;   /* time of last status change */
-};
-
-#define WEXITSTATUS(status)   (((status) & 0xff00) >> 8)
-#define WIFEXITED(status)     (((status) & 0x7f) == 0)
-
 /* Below comes the architecture-specific code. For each architecture, we have
  * the syscall declarations and the _start code definition. This is the only
  * global part. On all architectures the kernel puts everything in the stack
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
new file mode 100644
index 000000000000..2f09abaf95f1
--- /dev/null
+++ b/tools/include/nolibc/types.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Special types used by various syscalls for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_TYPES_H
+#define _NOLIBC_TYPES_H
+
+#include "std.h"
+#include <linux/time.h>
+
+
+/* Only the generic macros and types may be defined here. The arch-specific
+ * ones such as the O_RDONLY and related macros used by fcntl() and open(), or
+ * the layout of sys_stat_struct must not be defined here.
+ */
+
+/* stat flags (WARNING, octal here) */
+#define S_IFDIR        0040000
+#define S_IFCHR        0020000
+#define S_IFBLK        0060000
+#define S_IFREG        0100000
+#define S_IFIFO        0010000
+#define S_IFLNK        0120000
+#define S_IFSOCK       0140000
+#define S_IFMT         0170000
+
+#define S_ISDIR(mode)  (((mode) & S_IFDIR)  == S_IFDIR)
+#define S_ISCHR(mode)  (((mode) & S_IFCHR)  == S_IFCHR)
+#define S_ISBLK(mode)  (((mode) & S_IFBLK)  == S_IFBLK)
+#define S_ISREG(mode)  (((mode) & S_IFREG)  == S_IFREG)
+#define S_ISFIFO(mode) (((mode) & S_IFIFO)  == S_IFIFO)
+#define S_ISLNK(mode)  (((mode) & S_IFLNK)  == S_IFLNK)
+#define S_ISSOCK(mode) (((mode) & S_IFSOCK) == S_IFSOCK)
+
+/* dirent types */
+#define DT_UNKNOWN     0x0
+#define DT_FIFO        0x1
+#define DT_CHR         0x2
+#define DT_DIR         0x4
+#define DT_BLK         0x6
+#define DT_REG         0x8
+#define DT_LNK         0xa
+#define DT_SOCK        0xc
+
+/* commonly an fd_set represents 256 FDs */
+#define FD_SETSIZE     256
+
+/* Special FD used by all the *at functions */
+#ifndef AT_FDCWD
+#define AT_FDCWD       (-100)
+#endif
+
+/* whence values for lseek() */
+#define SEEK_SET       0
+#define SEEK_CUR       1
+#define SEEK_END       2
+
+/* cmd for reboot() */
+#define LINUX_REBOOT_MAGIC1         0xfee1dead
+#define LINUX_REBOOT_MAGIC2         0x28121969
+#define LINUX_REBOOT_CMD_HALT       0xcdef0123
+#define LINUX_REBOOT_CMD_POWER_OFF  0x4321fedc
+#define LINUX_REBOOT_CMD_RESTART    0x01234567
+#define LINUX_REBOOT_CMD_SW_SUSPEND 0xd000fce2
+
+/* Macros used on waitpid()'s return status */
+#define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
+#define WIFEXITED(status)   (((status) & 0x7f) == 0)
+
+
+/* for select() */
+typedef struct {
+	uint32_t fd32[FD_SETSIZE / 32];
+} fd_set;
+
+/* for poll() */
+struct pollfd {
+	int fd;
+	short int events;
+	short int revents;
+};
+
+/* for getdents64() */
+struct linux_dirent64 {
+	uint64_t       d_ino;
+	int64_t        d_off;
+	unsigned short d_reclen;
+	unsigned char  d_type;
+	char           d_name[];
+};
+
+/* needed by wait4() */
+struct rusage {
+	struct timeval ru_utime;
+	struct timeval ru_stime;
+	long   ru_maxrss;
+	long   ru_ixrss;
+	long   ru_idrss;
+	long   ru_isrss;
+	long   ru_minflt;
+	long   ru_majflt;
+	long   ru_nswap;
+	long   ru_inblock;
+	long   ru_oublock;
+	long   ru_msgsnd;
+	long   ru_msgrcv;
+	long   ru_nsignals;
+	long   ru_nvcsw;
+	long   ru_nivcsw;
+};
+
+/* The format of the struct as returned by the libc to the application, which
+ * significantly differs from the format returned by the stat() syscall flavours.
+ */
+struct stat {
+	dev_t     st_dev;     /* ID of device containing file */
+	ino_t     st_ino;     /* inode number */
+	mode_t    st_mode;    /* protection */
+	nlink_t   st_nlink;   /* number of hard links */
+	uid_t     st_uid;     /* user ID of owner */
+	gid_t     st_gid;     /* group ID of owner */
+	dev_t     st_rdev;    /* device ID (if special file) */
+	off_t     st_size;    /* total size, in bytes */
+	blksize_t st_blksize; /* blocksize for file system I/O */
+	blkcnt_t  st_blocks;  /* number of 512B blocks allocated */
+	time_t    st_atime;   /* time of last access */
+	time_t    st_mtime;   /* time of last modification */
+	time_t    st_ctime;   /* time of last status change */
+};
+
+#endif /* _NOLIBC_TYPES_H */
-- 
2.35.1

