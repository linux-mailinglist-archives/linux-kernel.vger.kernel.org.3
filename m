Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270FE50613F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbiDSAtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394AA22BD2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EB461380
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A3C385B5;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=oncJh3M/qJKkt9uJwEWa2eg5JrJkZlLZw/8s7rWHH+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgYLj+WhJYeQ02Dil3vBjG+6/gP5oG76r81/h0dgCLaQhse0gw8TU0qpuuZ9Vg+Mu
         kRHK2xvBxJN3c1kLTZiHNcYkSYwWM0b7xALCgzdbNgEbkddU6Ch6MOlKnr3Cj/GvYI
         9jLkRgs1y2V0jz7oI7FmJzc/zrTqbq+mZMLpjXS55wQX3oLm0vGn89DTx6erwvP5br
         /Ay0KgqcKPrdvDnKArpW7kemTUho988HMvhD85y7S9Y2vlZ6ZLu9YjrqNxNhfIvAbu
         16HscqNGMd25DzEezOY61N/N95rTg1nvNW0CLaE3xQ7XpYd12QyS725aLBIZPr5OVq
         qEfPl/mexOJuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 114565C0B86; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 06/61] tools/nolibc/sys: split the syscall definitions into their own file
Date:   Mon, 18 Apr 2022 17:41:30 -0700
Message-Id: <20220419004225.3952530-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The syscall definitions were moved to sys.h. They were arranged
in a more easily maintainable order, whereby the sys_xxx() and xxx()
functions were grouped together, which also enlights the occasional
mappings such as wait relying on wait4().

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h |  965 +-------------------------
 tools/include/nolibc/sys.h    | 1189 +++++++++++++++++++++++++++++++++
 2 files changed, 1192 insertions(+), 962 deletions(-)
 create mode 100644 tools/include/nolibc/sys.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index ccad3998d824..2af56ec760e2 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -83,869 +83,18 @@
 #ifndef _NOLIBC_H
 #define _NOLIBC_H
 
-/* standard type definitions */
 #include "std.h"
-
-/* system includes */
-#include <asm/unistd.h>
-#include <asm/signal.h>  // for SIGCHLD
-#include <asm/ioctls.h>
-#include <asm/errno.h>
-#include <linux/fs.h>
-#include <linux/loop.h>
-#include <linux/time.h>
 #include "arch.h"
 #include "types.h"
+#include "sys.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
 
-/* this way it will be removed if unused */
-static int errno;
-
-#ifndef NOLIBC_IGNORE_ERRNO
-#define SET_ERRNO(v) do { errno = (v); } while (0)
-#else
-#define SET_ERRNO(v) do { } while (0)
-#endif
-
-/* errno codes all ensure that they will not conflict with a valid pointer
- * because they all correspond to the highest addressable memory page.
- */
-#define MAX_ERRNO 4095
-
-
-/* Below are the C functions used to declare the raw syscalls. They try to be
- * architecture-agnostic, and return either a success or -errno. Declaring them
- * static will lead to them being inlined in most cases, but it's still possible
- * to reference them by a pointer if needed.
- */
-static __attribute__((unused))
-void *sys_brk(void *addr)
-{
-	return (void *)my_syscall1(__NR_brk, addr);
-}
-
-static __attribute__((noreturn,unused))
-void sys_exit(int status)
-{
-	my_syscall1(__NR_exit, status & 255);
-	while(1); // shut the "noreturn" warnings.
-}
-
-static __attribute__((unused))
-int sys_chdir(const char *path)
-{
-	return my_syscall1(__NR_chdir, path);
-}
-
-static __attribute__((unused))
-int sys_chmod(const char *path, mode_t mode)
-{
-#ifdef __NR_fchmodat
-	return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
-#elif defined(__NR_chmod)
-	return my_syscall2(__NR_chmod, path, mode);
-#else
-#error Neither __NR_fchmodat nor __NR_chmod defined, cannot implement sys_chmod()
-#endif
-}
-
-static __attribute__((unused))
-int sys_chown(const char *path, uid_t owner, gid_t group)
-{
-#ifdef __NR_fchownat
-	return my_syscall5(__NR_fchownat, AT_FDCWD, path, owner, group, 0);
-#elif defined(__NR_chown)
-	return my_syscall3(__NR_chown, path, owner, group);
-#else
-#error Neither __NR_fchownat nor __NR_chown defined, cannot implement sys_chown()
-#endif
-}
-
-static __attribute__((unused))
-int sys_chroot(const char *path)
-{
-	return my_syscall1(__NR_chroot, path);
-}
-
-static __attribute__((unused))
-int sys_close(int fd)
-{
-	return my_syscall1(__NR_close, fd);
-}
-
-static __attribute__((unused))
-int sys_dup(int fd)
-{
-	return my_syscall1(__NR_dup, fd);
-}
-
-#ifdef __NR_dup3
-static __attribute__((unused))
-int sys_dup3(int old, int new, int flags)
-{
-	return my_syscall3(__NR_dup3, old, new, flags);
-}
-#endif
-
-static __attribute__((unused))
-int sys_dup2(int old, int new)
-{
-#ifdef __NR_dup3
-	return my_syscall3(__NR_dup3, old, new, 0);
-#elif defined(__NR_dup2)
-	return my_syscall2(__NR_dup2, old, new);
-#else
-#error Neither __NR_dup3 nor __NR_dup2 defined, cannot implement sys_dup2()
-#endif
-}
-
-static __attribute__((unused))
-int sys_execve(const char *filename, char *const argv[], char *const envp[])
-{
-	return my_syscall3(__NR_execve, filename, argv, envp);
-}
-
-static __attribute__((unused))
-pid_t sys_fork(void)
-{
-#ifdef __NR_clone
-	/* note: some archs only have clone() and not fork(). Different archs
-	 * have a different API, but most archs have the flags on first arg and
-	 * will not use the rest with no other flag.
-	 */
-	return my_syscall5(__NR_clone, SIGCHLD, 0, 0, 0, 0);
-#elif defined(__NR_fork)
-	return my_syscall0(__NR_fork);
-#else
-#error Neither __NR_clone nor __NR_fork defined, cannot implement sys_fork()
-#endif
-}
-
-static __attribute__((unused))
-int sys_fsync(int fd)
-{
-	return my_syscall1(__NR_fsync, fd);
-}
-
-static __attribute__((unused))
-int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
-{
-	return my_syscall3(__NR_getdents64, fd, dirp, count);
-}
-
-static __attribute__((unused))
-pid_t sys_getpgid(pid_t pid)
-{
-	return my_syscall1(__NR_getpgid, pid);
-}
-
-static __attribute__((unused))
-pid_t sys_getpgrp(void)
-{
-	return sys_getpgid(0);
-}
-
-static __attribute__((unused))
-pid_t sys_getpid(void)
-{
-	return my_syscall0(__NR_getpid);
-}
-
-static __attribute__((unused))
-pid_t sys_gettid(void)
-{
-	return my_syscall0(__NR_gettid);
-}
-
-static __attribute__((unused))
-int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	return my_syscall2(__NR_gettimeofday, tv, tz);
-}
-
-static __attribute__((unused))
-int sys_ioctl(int fd, unsigned long req, void *value)
-{
-	return my_syscall3(__NR_ioctl, fd, req, value);
-}
-
-static __attribute__((unused))
-int sys_kill(pid_t pid, int signal)
-{
-	return my_syscall2(__NR_kill, pid, signal);
-}
-
-static __attribute__((unused))
-int sys_link(const char *old, const char *new)
-{
-#ifdef __NR_linkat
-	return my_syscall5(__NR_linkat, AT_FDCWD, old, AT_FDCWD, new, 0);
-#elif defined(__NR_link)
-	return my_syscall2(__NR_link, old, new);
-#else
-#error Neither __NR_linkat nor __NR_link defined, cannot implement sys_link()
-#endif
-}
-
-static __attribute__((unused))
-off_t sys_lseek(int fd, off_t offset, int whence)
-{
-	return my_syscall3(__NR_lseek, fd, offset, whence);
-}
-
-static __attribute__((unused))
-int sys_mkdir(const char *path, mode_t mode)
-{
-#ifdef __NR_mkdirat
-	return my_syscall3(__NR_mkdirat, AT_FDCWD, path, mode);
-#elif defined(__NR_mkdir)
-	return my_syscall2(__NR_mkdir, path, mode);
-#else
-#error Neither __NR_mkdirat nor __NR_mkdir defined, cannot implement sys_mkdir()
-#endif
-}
-
-static __attribute__((unused))
-long sys_mknod(const char *path, mode_t mode, dev_t dev)
-{
-#ifdef __NR_mknodat
-	return my_syscall4(__NR_mknodat, AT_FDCWD, path, mode, dev);
-#elif defined(__NR_mknod)
-	return my_syscall3(__NR_mknod, path, mode, dev);
-#else
-#error Neither __NR_mknodat nor __NR_mknod defined, cannot implement sys_mknod()
-#endif
-}
-
-static __attribute__((unused))
-int sys_mount(const char *src, const char *tgt, const char *fst,
-	      unsigned long flags, const void *data)
-{
-	return my_syscall5(__NR_mount, src, tgt, fst, flags, data);
-}
-
-static __attribute__((unused))
-int sys_open(const char *path, int flags, mode_t mode)
-{
-#ifdef __NR_openat
-	return my_syscall4(__NR_openat, AT_FDCWD, path, flags, mode);
-#elif defined(__NR_open)
-	return my_syscall3(__NR_open, path, flags, mode);
-#else
-#error Neither __NR_openat nor __NR_open defined, cannot implement sys_open()
-#endif
-}
-
-static __attribute__((unused))
-int sys_pivot_root(const char *new, const char *old)
-{
-	return my_syscall2(__NR_pivot_root, new, old);
-}
-
-static __attribute__((unused))
-int sys_poll(struct pollfd *fds, int nfds, int timeout)
-{
-#if defined(__NR_ppoll)
-	struct timespec t;
-
-	if (timeout >= 0) {
-		t.tv_sec  = timeout / 1000;
-		t.tv_nsec = (timeout % 1000) * 1000000;
-	}
-	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
-#elif defined(__NR_poll)
-	return my_syscall3(__NR_poll, fds, nfds, timeout);
-#else
-#error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
-#endif
-}
-
-static __attribute__((unused))
-ssize_t sys_read(int fd, void *buf, size_t count)
-{
-	return my_syscall3(__NR_read, fd, buf, count);
-}
-
-static __attribute__((unused))
-ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
-{
-	return my_syscall4(__NR_reboot, magic1, magic2, cmd, arg);
-}
-
-static __attribute__((unused))
-int sys_sched_yield(void)
-{
-	return my_syscall0(__NR_sched_yield);
-}
-
-static __attribute__((unused))
-int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
-{
-#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
-	struct sel_arg_struct {
-		unsigned long n;
-		fd_set *r, *w, *e;
-		struct timeval *t;
-	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
-	return my_syscall1(__NR_select, &arg);
-#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
-	struct timespec t;
-
-	if (timeout) {
-		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
-	}
-	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#elif defined(__NR__newselect) || defined(__NR_select)
-#ifndef __NR__newselect
-#define __NR__newselect __NR_select
-#endif
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
-#else
-#error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
-#endif
-}
-
-static __attribute__((unused))
-int sys_setpgid(pid_t pid, pid_t pgid)
-{
-	return my_syscall2(__NR_setpgid, pid, pgid);
-}
-
-static __attribute__((unused))
-pid_t sys_setsid(void)
-{
-	return my_syscall0(__NR_setsid);
-}
-
-static __attribute__((unused))
-int sys_stat(const char *path, struct stat *buf)
-{
-	struct sys_stat_struct stat;
-	long ret;
-
-#ifdef __NR_newfstatat
-	/* only solution for arm64 */
-	ret = my_syscall4(__NR_newfstatat, AT_FDCWD, path, &stat, 0);
-#elif defined(__NR_stat)
-	ret = my_syscall2(__NR_stat, path, &stat);
-#else
-#error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
-#endif
-	buf->st_dev     = stat.st_dev;
-	buf->st_ino     = stat.st_ino;
-	buf->st_mode    = stat.st_mode;
-	buf->st_nlink   = stat.st_nlink;
-	buf->st_uid     = stat.st_uid;
-	buf->st_gid     = stat.st_gid;
-	buf->st_rdev    = stat.st_rdev;
-	buf->st_size    = stat.st_size;
-	buf->st_blksize = stat.st_blksize;
-	buf->st_blocks  = stat.st_blocks;
-	buf->st_atime   = stat.st_atime;
-	buf->st_mtime   = stat.st_mtime;
-	buf->st_ctime   = stat.st_ctime;
-	return ret;
-}
-
-
-static __attribute__((unused))
-int sys_symlink(const char *old, const char *new)
-{
-#ifdef __NR_symlinkat
-	return my_syscall3(__NR_symlinkat, old, AT_FDCWD, new);
-#elif defined(__NR_symlink)
-	return my_syscall2(__NR_symlink, old, new);
-#else
-#error Neither __NR_symlinkat nor __NR_symlink defined, cannot implement sys_symlink()
-#endif
-}
-
-static __attribute__((unused))
-mode_t sys_umask(mode_t mode)
-{
-	return my_syscall1(__NR_umask, mode);
-}
-
-static __attribute__((unused))
-int sys_umount2(const char *path, int flags)
-{
-	return my_syscall2(__NR_umount2, path, flags);
-}
-
-static __attribute__((unused))
-int sys_unlink(const char *path)
-{
-#ifdef __NR_unlinkat
-	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, 0);
-#elif defined(__NR_unlink)
-	return my_syscall1(__NR_unlink, path);
-#else
-#error Neither __NR_unlinkat nor __NR_unlink defined, cannot implement sys_unlink()
-#endif
-}
-
-static __attribute__((unused))
-pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
-{
-	return my_syscall4(__NR_wait4, pid, status, options, rusage);
-}
-
-static __attribute__((unused))
-pid_t sys_waitpid(pid_t pid, int *status, int options)
-{
-	return sys_wait4(pid, status, options, 0);
-}
-
-static __attribute__((unused))
-pid_t sys_wait(int *status)
-{
-	return sys_waitpid(-1, status, 0);
-}
-
-static __attribute__((unused))
-ssize_t sys_write(int fd, const void *buf, size_t count)
-{
-	return my_syscall3(__NR_write, fd, buf, count);
-}
-
-
-/* Below are the libc-compatible syscalls which return x or -1 and set errno.
- * They rely on the functions above. Similarly they're marked static so that it
- * is possible to assign pointers to them if needed.
- */
-
-static __attribute__((unused))
-int brk(void *addr)
-{
-	void *ret = sys_brk(addr);
-
-	if (!ret) {
-		SET_ERRNO(ENOMEM);
-		return -1;
-	}
-	return 0;
-}
-
-static __attribute__((noreturn,unused))
-void exit(int status)
-{
-	sys_exit(status);
-}
-
-static __attribute__((unused))
-int chdir(const char *path)
-{
-	int ret = sys_chdir(path);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int chmod(const char *path, mode_t mode)
-{
-	int ret = sys_chmod(path, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int chown(const char *path, uid_t owner, gid_t group)
-{
-	int ret = sys_chown(path, owner, group);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int chroot(const char *path)
-{
-	int ret = sys_chroot(path);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int close(int fd)
-{
-	int ret = sys_close(fd);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int dup(int fd)
-{
-	int ret = sys_dup(fd);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int dup2(int old, int new)
-{
-	int ret = sys_dup2(old, new);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-#ifdef __NR_dup3
-static __attribute__((unused))
-int dup3(int old, int new, int flags)
-{
-	int ret = sys_dup3(old, new, flags);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-#endif
-
-static __attribute__((unused))
-int execve(const char *filename, char *const argv[], char *const envp[])
-{
-	int ret = sys_execve(filename, argv, envp);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t fork(void)
-{
-	pid_t ret = sys_fork();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int fsync(int fd)
-{
-	int ret = sys_fsync(fd);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int getdents64(int fd, struct linux_dirent64 *dirp, int count)
-{
-	int ret = sys_getdents64(fd, dirp, count);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t getpgid(pid_t pid)
-{
-	pid_t ret = sys_getpgid(pid);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t getpgrp(void)
-{
-	pid_t ret = sys_getpgrp();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t getpid(void)
-{
-	pid_t ret = sys_getpid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t gettid(void)
-{
-	pid_t ret = sys_gettid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	int ret = sys_gettimeofday(tv, tz);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int ioctl(int fd, unsigned long req, void *value)
-{
-	int ret = sys_ioctl(fd, req, value);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int kill(pid_t pid, int signal)
-{
-	int ret = sys_kill(pid, signal);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int link(const char *old, const char *new)
-{
-	int ret = sys_link(old, new);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
 static __attribute__((unused))
-off_t lseek(int fd, off_t offset, int whence)
-{
-	off_t ret = sys_lseek(fd, offset, whence);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int mkdir(const char *path, mode_t mode)
-{
-	int ret = sys_mkdir(path, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int mknod(const char *path, mode_t mode, dev_t dev)
-{
-	int ret = sys_mknod(path, mode, dev);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int mount(const char *src, const char *tgt,
-	  const char *fst, unsigned long flags,
-	  const void *data)
-{
-	int ret = sys_mount(src, tgt, fst, flags, data);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int open(const char *path, int flags, mode_t mode)
-{
-	int ret = sys_open(path, flags, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int pivot_root(const char *new, const char *old)
-{
-	int ret = sys_pivot_root(new, old);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int poll(struct pollfd *fds, int nfds, int timeout)
-{
-	int ret = sys_poll(fds, nfds, timeout);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-ssize_t read(int fd, void *buf, size_t count)
-{
-	ssize_t ret = sys_read(fd, buf, count);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int reboot(int cmd)
-{
-	int ret = sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-void *sbrk(intptr_t inc)
-{
-	void *ret;
-
-	/* first call to find current end */
-	if ((ret = sys_brk(0)) && (sys_brk(ret + inc) == ret + inc))
-		return ret + inc;
-
-	SET_ERRNO(ENOMEM);
-	return (void *)-1;
-}
-
-static __attribute__((unused))
-int sched_yield(void)
-{
-	int ret = sys_sched_yield();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
-{
-	int ret = sys_select(nfds, rfds, wfds, efds, timeout);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int setpgid(pid_t pid, pid_t pgid)
-{
-	int ret = sys_setpgid(pid, pgid);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t setsid(void)
+int tcsetpgrp(int fd, pid_t pid)
 {
-	pid_t ret = sys_setsid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
 static __attribute__((unused))
@@ -972,114 +121,6 @@ int msleep(unsigned int msecs)
 		return 0;
 }
 
-static __attribute__((unused))
-int stat(const char *path, struct stat *buf)
-{
-	int ret = sys_stat(path, buf);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int symlink(const char *old, const char *new)
-{
-	int ret = sys_symlink(old, new);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int tcsetpgrp(int fd, pid_t pid)
-{
-	return ioctl(fd, TIOCSPGRP, &pid);
-}
-
-static __attribute__((unused))
-mode_t umask(mode_t mode)
-{
-	return sys_umask(mode);
-}
-
-static __attribute__((unused))
-int umount2(const char *path, int flags)
-{
-	int ret = sys_umount2(path, flags);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-int unlink(const char *path)
-{
-	int ret = sys_unlink(path);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
-{
-	pid_t ret = sys_wait4(pid, status, options, rusage);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t waitpid(pid_t pid, int *status, int options)
-{
-	pid_t ret = sys_waitpid(pid, status, options);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-pid_t wait(int *status)
-{
-	pid_t ret = sys_wait(status);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
-static __attribute__((unused))
-ssize_t write(int fd, const void *buf, size_t count)
-{
-	ssize_t ret = sys_write(fd, buf, count);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
-}
-
 /* some size-optimized reimplementations of a few common str* and mem*
  * functions. They're marked static, except memcpy() and raise() which are used
  * by libgcc on ARM, so they are marked weak instead in order not to cause an
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
new file mode 100644
index 000000000000..98689f668ed3
--- /dev/null
+++ b/tools/include/nolibc/sys.h
@@ -0,0 +1,1189 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Syscall definitions for NOLIBC (those in man(2))
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_SYS_H
+#define _NOLIBC_SYS_H
+
+#include "std.h"
+
+/* system includes */
+#include <asm/unistd.h>
+#include <asm/signal.h>  // for SIGCHLD
+#include <asm/ioctls.h>
+#include <asm/errno.h>
+#include <linux/fs.h>
+#include <linux/loop.h>
+#include <linux/time.h>
+
+#include "arch.h"
+#include "types.h"
+
+/* this way it will be removed if unused */
+static int errno;
+
+#ifndef NOLIBC_IGNORE_ERRNO
+#define SET_ERRNO(v) do { errno = (v); } while (0)
+#else
+#define SET_ERRNO(v) do { } while (0)
+#endif
+
+
+/* errno codes all ensure that they will not conflict with a valid pointer
+ * because they all correspond to the highest addressable memory page.
+ */
+#define MAX_ERRNO 4095
+
+
+/* Functions in this file only describe syscalls. They're declared static so
+ * that the compiler usually decides to inline them while still being allowed
+ * to pass a pointer to one of their instances. Each syscall exists in two
+ * versions:
+ *   - the "internal" ones, which matches the raw syscall interface at the
+ *     kernel level, which may sometimes slightly differ from the documented
+ *     libc-level ones. For example most of them return either a valid value
+ *     or -errno. All of these are prefixed with "sys_". They may be called
+ *     by non-portable applications if desired.
+ *
+ *   - the "exported" ones, whose interface must closely match the one
+ *     documented in man(2), that applications are supposed to expect. These
+ *     ones rely on the internal ones, and set errno.
+ *
+ * Each syscall will be defined with the two functions, sorted in alphabetical
+ * order applied to the exported names.
+ *
+ * In case of doubt about the relevance of a function here, only those which
+ * set errno should be defined here. Wrappers like those appearing in man(3)
+ * should not be placed here.
+ */
+
+
+/*
+ * int brk(void *addr);
+ * void *sbrk(intptr_t inc)
+ */
+
+static __attribute__((unused))
+void *sys_brk(void *addr)
+{
+	return (void *)my_syscall1(__NR_brk, addr);
+}
+
+static __attribute__((unused))
+int brk(void *addr)
+{
+	void *ret = sys_brk(addr);
+
+	if (!ret) {
+		SET_ERRNO(ENOMEM);
+		return -1;
+	}
+	return 0;
+}
+
+static __attribute__((unused))
+void *sbrk(intptr_t inc)
+{
+	void *ret;
+
+	/* first call to find current end */
+	if ((ret = sys_brk(0)) && (sys_brk(ret + inc) == ret + inc))
+		return ret + inc;
+
+	SET_ERRNO(ENOMEM);
+	return (void *)-1;
+}
+
+
+/*
+ * int chdir(const char *path);
+ */
+
+static __attribute__((unused))
+int sys_chdir(const char *path)
+{
+	return my_syscall1(__NR_chdir, path);
+}
+
+static __attribute__((unused))
+int chdir(const char *path)
+{
+	int ret = sys_chdir(path);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int chmod(const char *path, mode_t mode);
+ */
+
+static __attribute__((unused))
+int sys_chmod(const char *path, mode_t mode)
+{
+#ifdef __NR_fchmodat
+	return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
+#elif defined(__NR_chmod)
+	return my_syscall2(__NR_chmod, path, mode);
+#else
+#error Neither __NR_fchmodat nor __NR_chmod defined, cannot implement sys_chmod()
+#endif
+}
+
+static __attribute__((unused))
+int chmod(const char *path, mode_t mode)
+{
+	int ret = sys_chmod(path, mode);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int chown(const char *path, uid_t owner, gid_t group);
+ */
+
+static __attribute__((unused))
+int sys_chown(const char *path, uid_t owner, gid_t group)
+{
+#ifdef __NR_fchownat
+	return my_syscall5(__NR_fchownat, AT_FDCWD, path, owner, group, 0);
+#elif defined(__NR_chown)
+	return my_syscall3(__NR_chown, path, owner, group);
+#else
+#error Neither __NR_fchownat nor __NR_chown defined, cannot implement sys_chown()
+#endif
+}
+
+static __attribute__((unused))
+int chown(const char *path, uid_t owner, gid_t group)
+{
+	int ret = sys_chown(path, owner, group);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int chroot(const char *path);
+ */
+
+static __attribute__((unused))
+int sys_chroot(const char *path)
+{
+	return my_syscall1(__NR_chroot, path);
+}
+
+static __attribute__((unused))
+int chroot(const char *path)
+{
+	int ret = sys_chroot(path);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int close(int fd);
+ */
+
+static __attribute__((unused))
+int sys_close(int fd)
+{
+	return my_syscall1(__NR_close, fd);
+}
+
+static __attribute__((unused))
+int close(int fd)
+{
+	int ret = sys_close(fd);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int dup(int fd);
+ */
+
+static __attribute__((unused))
+int sys_dup(int fd)
+{
+	return my_syscall1(__NR_dup, fd);
+}
+
+static __attribute__((unused))
+int dup(int fd)
+{
+	int ret = sys_dup(fd);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int dup2(int old, int new);
+ */
+
+static __attribute__((unused))
+int sys_dup2(int old, int new)
+{
+#ifdef __NR_dup3
+	return my_syscall3(__NR_dup3, old, new, 0);
+#elif defined(__NR_dup2)
+	return my_syscall2(__NR_dup2, old, new);
+#else
+#error Neither __NR_dup3 nor __NR_dup2 defined, cannot implement sys_dup2()
+#endif
+}
+
+static __attribute__((unused))
+int dup2(int old, int new)
+{
+	int ret = sys_dup2(old, new);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int dup3(int old, int new, int flags);
+ */
+
+#ifdef __NR_dup3
+static __attribute__((unused))
+int sys_dup3(int old, int new, int flags)
+{
+	return my_syscall3(__NR_dup3, old, new, flags);
+}
+
+static __attribute__((unused))
+int dup3(int old, int new, int flags)
+{
+	int ret = sys_dup3(old, new, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+#endif
+
+
+/*
+ * int execve(const char *filename, char *const argv[], char *const envp[]);
+ */
+
+static __attribute__((unused))
+int sys_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	return my_syscall3(__NR_execve, filename, argv, envp);
+}
+
+static __attribute__((unused))
+int execve(const char *filename, char *const argv[], char *const envp[])
+{
+	int ret = sys_execve(filename, argv, envp);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * void exit(int status);
+ */
+
+static __attribute__((noreturn,unused))
+void sys_exit(int status)
+{
+	my_syscall1(__NR_exit, status & 255);
+	while(1); // shut the "noreturn" warnings.
+}
+
+static __attribute__((noreturn,unused))
+void exit(int status)
+{
+	sys_exit(status);
+}
+
+
+/*
+ * pid_t fork(void);
+ */
+
+static __attribute__((unused))
+pid_t sys_fork(void)
+{
+#ifdef __NR_clone
+	/* note: some archs only have clone() and not fork(). Different archs
+	 * have a different API, but most archs have the flags on first arg and
+	 * will not use the rest with no other flag.
+	 */
+	return my_syscall5(__NR_clone, SIGCHLD, 0, 0, 0, 0);
+#elif defined(__NR_fork)
+	return my_syscall0(__NR_fork);
+#else
+#error Neither __NR_clone nor __NR_fork defined, cannot implement sys_fork()
+#endif
+}
+
+static __attribute__((unused))
+pid_t fork(void)
+{
+	pid_t ret = sys_fork();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int fsync(int fd);
+ */
+
+static __attribute__((unused))
+int sys_fsync(int fd)
+{
+	return my_syscall1(__NR_fsync, fd);
+}
+
+static __attribute__((unused))
+int fsync(int fd)
+{
+	int ret = sys_fsync(fd);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int getdents64(int fd, struct linux_dirent64 *dirp, int count);
+ */
+
+static __attribute__((unused))
+int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
+{
+	return my_syscall3(__NR_getdents64, fd, dirp, count);
+}
+
+static __attribute__((unused))
+int getdents64(int fd, struct linux_dirent64 *dirp, int count)
+{
+	int ret = sys_getdents64(fd, dirp, count);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * pid_t getpgid(pid_t pid);
+ */
+
+static __attribute__((unused))
+pid_t sys_getpgid(pid_t pid)
+{
+	return my_syscall1(__NR_getpgid, pid);
+}
+
+static __attribute__((unused))
+pid_t getpgid(pid_t pid)
+{
+	pid_t ret = sys_getpgid(pid);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * pid_t getpgrp(void);
+ */
+
+static __attribute__((unused))
+pid_t sys_getpgrp(void)
+{
+	return sys_getpgid(0);
+}
+
+static __attribute__((unused))
+pid_t getpgrp(void)
+{
+	pid_t ret = sys_getpgrp();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * pid_t getpid(void);
+ */
+
+static __attribute__((unused))
+pid_t sys_getpid(void)
+{
+	return my_syscall0(__NR_getpid);
+}
+
+static __attribute__((unused))
+pid_t getpid(void)
+{
+	pid_t ret = sys_getpid();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * pid_t gettid(void);
+ */
+
+static __attribute__((unused))
+pid_t sys_gettid(void)
+{
+	return my_syscall0(__NR_gettid);
+}
+
+static __attribute__((unused))
+pid_t gettid(void)
+{
+	pid_t ret = sys_gettid();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int gettimeofday(struct timeval *tv, struct timezone *tz);
+ */
+
+static __attribute__((unused))
+int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	return my_syscall2(__NR_gettimeofday, tv, tz);
+}
+
+static __attribute__((unused))
+int gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	int ret = sys_gettimeofday(tv, tz);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int ioctl(int fd, unsigned long req, void *value);
+ */
+
+static __attribute__((unused))
+int sys_ioctl(int fd, unsigned long req, void *value)
+{
+	return my_syscall3(__NR_ioctl, fd, req, value);
+}
+
+static __attribute__((unused))
+int ioctl(int fd, unsigned long req, void *value)
+{
+	int ret = sys_ioctl(fd, req, value);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+/*
+ * int kill(pid_t pid, int signal);
+ */
+
+static __attribute__((unused))
+int sys_kill(pid_t pid, int signal)
+{
+	return my_syscall2(__NR_kill, pid, signal);
+}
+
+static __attribute__((unused))
+int kill(pid_t pid, int signal)
+{
+	int ret = sys_kill(pid, signal);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int link(const char *old, const char *new);
+ */
+
+static __attribute__((unused))
+int sys_link(const char *old, const char *new)
+{
+#ifdef __NR_linkat
+	return my_syscall5(__NR_linkat, AT_FDCWD, old, AT_FDCWD, new, 0);
+#elif defined(__NR_link)
+	return my_syscall2(__NR_link, old, new);
+#else
+#error Neither __NR_linkat nor __NR_link defined, cannot implement sys_link()
+#endif
+}
+
+static __attribute__((unused))
+int link(const char *old, const char *new)
+{
+	int ret = sys_link(old, new);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * off_t lseek(int fd, off_t offset, int whence);
+ */
+
+static __attribute__((unused))
+off_t sys_lseek(int fd, off_t offset, int whence)
+{
+	return my_syscall3(__NR_lseek, fd, offset, whence);
+}
+
+static __attribute__((unused))
+off_t lseek(int fd, off_t offset, int whence)
+{
+	off_t ret = sys_lseek(fd, offset, whence);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int mkdir(const char *path, mode_t mode);
+ */
+
+static __attribute__((unused))
+int sys_mkdir(const char *path, mode_t mode)
+{
+#ifdef __NR_mkdirat
+	return my_syscall3(__NR_mkdirat, AT_FDCWD, path, mode);
+#elif defined(__NR_mkdir)
+	return my_syscall2(__NR_mkdir, path, mode);
+#else
+#error Neither __NR_mkdirat nor __NR_mkdir defined, cannot implement sys_mkdir()
+#endif
+}
+
+static __attribute__((unused))
+int mkdir(const char *path, mode_t mode)
+{
+	int ret = sys_mkdir(path, mode);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int mknod(const char *path, mode_t mode, dev_t dev);
+ */
+
+static __attribute__((unused))
+long sys_mknod(const char *path, mode_t mode, dev_t dev)
+{
+#ifdef __NR_mknodat
+	return my_syscall4(__NR_mknodat, AT_FDCWD, path, mode, dev);
+#elif defined(__NR_mknod)
+	return my_syscall3(__NR_mknod, path, mode, dev);
+#else
+#error Neither __NR_mknodat nor __NR_mknod defined, cannot implement sys_mknod()
+#endif
+}
+
+static __attribute__((unused))
+int mknod(const char *path, mode_t mode, dev_t dev)
+{
+	int ret = sys_mknod(path, mode, dev);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int mount(const char *source, const char *target,
+ *           const char *fstype, unsigned long flags,
+ *           const void *data);
+ */
+static __attribute__((unused))
+int sys_mount(const char *src, const char *tgt, const char *fst,
+                     unsigned long flags, const void *data)
+{
+	return my_syscall5(__NR_mount, src, tgt, fst, flags, data);
+}
+
+static __attribute__((unused))
+int mount(const char *src, const char *tgt,
+          const char *fst, unsigned long flags,
+          const void *data)
+{
+	int ret = sys_mount(src, tgt, fst, flags, data);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int open(const char *path, int flags, mode_t mode);
+ */
+
+static __attribute__((unused))
+int sys_open(const char *path, int flags, mode_t mode)
+{
+#ifdef __NR_openat
+	return my_syscall4(__NR_openat, AT_FDCWD, path, flags, mode);
+#elif defined(__NR_open)
+	return my_syscall3(__NR_open, path, flags, mode);
+#else
+#error Neither __NR_openat nor __NR_open defined, cannot implement sys_open()
+#endif
+}
+
+static __attribute__((unused))
+int open(const char *path, int flags, mode_t mode)
+{
+	int ret = sys_open(path, flags, mode);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int pivot_root(const char *new, const char *old);
+ */
+
+static __attribute__((unused))
+int sys_pivot_root(const char *new, const char *old)
+{
+	return my_syscall2(__NR_pivot_root, new, old);
+}
+
+static __attribute__((unused))
+int pivot_root(const char *new, const char *old)
+{
+	int ret = sys_pivot_root(new, old);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int poll(struct pollfd *fds, int nfds, int timeout);
+ */
+
+static __attribute__((unused))
+int sys_poll(struct pollfd *fds, int nfds, int timeout)
+{
+#if defined(__NR_ppoll)
+	struct timespec t;
+
+	if (timeout >= 0) {
+		t.tv_sec  = timeout / 1000;
+		t.tv_nsec = (timeout % 1000) * 1000000;
+	}
+	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
+#elif defined(__NR_poll)
+	return my_syscall3(__NR_poll, fds, nfds, timeout);
+#else
+#error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
+#endif
+}
+
+static __attribute__((unused))
+int poll(struct pollfd *fds, int nfds, int timeout)
+{
+	int ret = sys_poll(fds, nfds, timeout);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * ssize_t read(int fd, void *buf, size_t count);
+ */
+
+static __attribute__((unused))
+ssize_t sys_read(int fd, void *buf, size_t count)
+{
+	return my_syscall3(__NR_read, fd, buf, count);
+}
+
+static __attribute__((unused))
+ssize_t read(int fd, void *buf, size_t count)
+{
+	ssize_t ret = sys_read(fd, buf, count);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int reboot(int cmd);
+ * <cmd> is among LINUX_REBOOT_CMD_*
+ */
+
+static __attribute__((unused))
+ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
+{
+	return my_syscall4(__NR_reboot, magic1, magic2, cmd, arg);
+}
+
+static __attribute__((unused))
+int reboot(int cmd)
+{
+	int ret = sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int sched_yield(void);
+ */
+
+static __attribute__((unused))
+int sys_sched_yield(void)
+{
+	return my_syscall0(__NR_sched_yield);
+}
+
+static __attribute__((unused))
+int sched_yield(void)
+{
+	int ret = sys_sched_yield();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int select(int nfds, fd_set *read_fds, fd_set *write_fds,
+ *            fd_set *except_fds, struct timeval *timeout);
+ */
+
+static __attribute__((unused))
+int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
+{
+#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
+	struct sel_arg_struct {
+		unsigned long n;
+		fd_set *r, *w, *e;
+		struct timeval *t;
+	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
+	return my_syscall1(__NR_select, &arg);
+#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
+	struct timespec t;
+
+	if (timeout) {
+		t.tv_sec  = timeout->tv_sec;
+		t.tv_nsec = timeout->tv_usec * 1000;
+	}
+	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+#elif defined(__NR__newselect) || defined(__NR_select)
+#ifndef __NR__newselect
+#define __NR__newselect __NR_select
+#endif
+	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#else
+#error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
+#endif
+}
+
+static __attribute__((unused))
+int select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
+{
+	int ret = sys_select(nfds, rfds, wfds, efds, timeout);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int setpgid(pid_t pid, pid_t pgid);
+ */
+
+static __attribute__((unused))
+int sys_setpgid(pid_t pid, pid_t pgid)
+{
+	return my_syscall2(__NR_setpgid, pid, pgid);
+}
+
+static __attribute__((unused))
+int setpgid(pid_t pid, pid_t pgid)
+{
+	int ret = sys_setpgid(pid, pgid);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * pid_t setsid(void);
+ */
+
+static __attribute__((unused))
+pid_t sys_setsid(void)
+{
+	return my_syscall0(__NR_setsid);
+}
+
+static __attribute__((unused))
+pid_t setsid(void)
+{
+	pid_t ret = sys_setsid();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int stat(const char *path, struct stat *buf);
+ * Warning: the struct stat's layout is arch-dependent.
+ */
+
+static __attribute__((unused))
+int sys_stat(const char *path, struct stat *buf)
+{
+	struct sys_stat_struct stat;
+	long ret;
+
+#ifdef __NR_newfstatat
+	/* only solution for arm64 */
+	ret = my_syscall4(__NR_newfstatat, AT_FDCWD, path, &stat, 0);
+#elif defined(__NR_stat)
+	ret = my_syscall2(__NR_stat, path, &stat);
+#else
+#error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
+#endif
+	buf->st_dev     = stat.st_dev;
+	buf->st_ino     = stat.st_ino;
+	buf->st_mode    = stat.st_mode;
+	buf->st_nlink   = stat.st_nlink;
+	buf->st_uid     = stat.st_uid;
+	buf->st_gid     = stat.st_gid;
+	buf->st_rdev    = stat.st_rdev;
+	buf->st_size    = stat.st_size;
+	buf->st_blksize = stat.st_blksize;
+	buf->st_blocks  = stat.st_blocks;
+	buf->st_atime   = stat.st_atime;
+	buf->st_mtime   = stat.st_mtime;
+	buf->st_ctime   = stat.st_ctime;
+	return ret;
+}
+
+static __attribute__((unused))
+int stat(const char *path, struct stat *buf)
+{
+	int ret = sys_stat(path, buf);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int symlink(const char *old, const char *new);
+ */
+
+static __attribute__((unused))
+int sys_symlink(const char *old, const char *new)
+{
+#ifdef __NR_symlinkat
+	return my_syscall3(__NR_symlinkat, old, AT_FDCWD, new);
+#elif defined(__NR_symlink)
+	return my_syscall2(__NR_symlink, old, new);
+#else
+#error Neither __NR_symlinkat nor __NR_symlink defined, cannot implement sys_symlink()
+#endif
+}
+
+static __attribute__((unused))
+int symlink(const char *old, const char *new)
+{
+	int ret = sys_symlink(old, new);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * mode_t umask(mode_t mode);
+ */
+
+static __attribute__((unused))
+mode_t sys_umask(mode_t mode)
+{
+	return my_syscall1(__NR_umask, mode);
+}
+
+static __attribute__((unused))
+mode_t umask(mode_t mode)
+{
+	return sys_umask(mode);
+}
+
+
+/*
+ * int umount2(const char *path, int flags);
+ */
+
+static __attribute__((unused))
+int sys_umount2(const char *path, int flags)
+{
+	return my_syscall2(__NR_umount2, path, flags);
+}
+
+static __attribute__((unused))
+int umount2(const char *path, int flags)
+{
+	int ret = sys_umount2(path, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * int unlink(const char *path);
+ */
+
+static __attribute__((unused))
+int sys_unlink(const char *path)
+{
+#ifdef __NR_unlinkat
+	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, 0);
+#elif defined(__NR_unlink)
+	return my_syscall1(__NR_unlink, path);
+#else
+#error Neither __NR_unlinkat nor __NR_unlink defined, cannot implement sys_unlink()
+#endif
+}
+
+static __attribute__((unused))
+int unlink(const char *path)
+{
+	int ret = sys_unlink(path);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * pid_t wait(int *status);
+ * pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage);
+ * pid_t waitpid(pid_t pid, int *status, int options);
+ */
+
+static __attribute__((unused))
+pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
+{
+	return my_syscall4(__NR_wait4, pid, status, options, rusage);
+}
+
+static __attribute__((unused))
+pid_t wait(int *status)
+{
+	pid_t ret = sys_wait4(-1, status, 0, NULL);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+static __attribute__((unused))
+pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
+{
+	pid_t ret = sys_wait4(pid, status, options, rusage);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+static __attribute__((unused))
+pid_t waitpid(pid_t pid, int *status, int options)
+{
+	pid_t ret = sys_wait4(pid, status, options, NULL);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+/*
+ * ssize_t write(int fd, const void *buf, size_t count);
+ */
+
+static __attribute__((unused))
+ssize_t sys_write(int fd, const void *buf, size_t count)
+{
+	return my_syscall3(__NR_write, fd, buf, count);
+}
+
+static __attribute__((unused))
+ssize_t write(int fd, const void *buf, size_t count)
+{
+	ssize_t ret = sys_write(fd, buf, count);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
+#endif /* _NOLIBC_SYS_H */
-- 
2.31.1.189.g2e36527f23

