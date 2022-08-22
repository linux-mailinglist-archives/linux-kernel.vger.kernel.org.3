Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5197B59C925
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiHVTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiHVTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:43:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8854DF0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bYSHADKXuT6hRtqlYyek+21JpqIaNwDZT/qRjRIS5UQ=; b=oLfb6JHHL+eNYSD68T5Im/yz7E
        DoWrPMYasKPEd2e/6H6JfzsXg1Z5rU1u7qnGKbJ/cuXaFCyKVD/j9PMJqI8PW5kjE+fD7tGBol5E1
        n5OkLXaaEGxzS1h628k95Zb+SLuxIksEwS360AujaIU2zX+CYNis09l0Un0vLSd2g10zFudxN8QR5
        VhNLbgrFMuAeP+pAEfXc7vKK9w6H8T3K085opEit789WzV5ygG7fDFo9FxUE/WcjzUvraHctnz6Kv
        /UwXpMrP0xo7xjVBcgVxkIuUzDP4UxJ5m03wlod465DG254KkYFPPxzxQOgmyI5/v5bg5ZNZ4XsTr
        ozqPmIBg==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQDKO-00EbwY-Qz; Mon, 22 Aug 2022 19:43:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH] compat: update linux/compat.h and kernel/sys_ni.c
Date:   Mon, 22 Aug 2022 12:43:10 -0700
Message-Id: <20220822194310.31796-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add conditional syscalls entries in kernel/sys_ni.c
for any syscalls that are arch- or config-dependent.

Update the prototype entries in <linux/compat.h>.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/compat.h |   27 ++++++---------------------
 kernel/sys_ni.c        |   20 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 23 deletions(-)

--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -610,7 +610,7 @@ asmlinkage long compat_sys_fcntl64(unsig
 asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
 				 compat_ulong_t arg);
 
-/* fs/open.c */
+/* fs/statfs.c */
 asmlinkage long compat_sys_statfs(const char __user *pathname,
 				  struct compat_statfs __user *buf);
 asmlinkage long compat_sys_statfs64(const char __user *pathname,
@@ -620,6 +620,8 @@ asmlinkage long compat_sys_fstatfs(unsig
 				   struct compat_statfs __user *buf);
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
+
+/* fs/open.c */
 asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
 asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
 /* No generic prototype for truncate64, ftruncate64, fallocate */
@@ -640,17 +642,12 @@ asmlinkage ssize_t compat_sys_preadv(com
 asmlinkage ssize_t compat_sys_pwritev(compat_ulong_t fd,
 		const struct iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high);
-#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
 asmlinkage long compat_sys_preadv64(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos);
-#endif
-
-#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
 asmlinkage long compat_sys_pwritev64(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos);
-#endif
 
 /* fs/sendfile.c */
 asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
@@ -702,7 +699,7 @@ asmlinkage long compat_sys_waitid(int, c
 
 
 
-/* kernel/futex.c */
+/* kernel/futex/syscalls.c */
 asmlinkage long
 compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
 			   compat_size_t len);
@@ -816,7 +813,7 @@ asmlinkage long compat_sys_sendmsg(int f
 asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 				   unsigned int flags);
 
-/* mm/filemap.c: No generic prototype for readahead */
+/* mm/readahead.c: No generic prototype for readahead */
 
 /* security/keys/keyctl.c */
 asmlinkage long compat_sys_keyctl(u32 option,
@@ -857,18 +854,12 @@ asmlinkage ssize_t compat_sys_preadv2(co
 asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
 		const struct iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
-#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
 asmlinkage long  compat_sys_preadv64v2(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos, rwf_t flags);
-#endif
-
-#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
 asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos, rwf_t flags);
-#endif
-
 
 /*
  * Deprecated system calls which are still defined in
@@ -910,19 +901,13 @@ asmlinkage long compat_sys_old_select(st
 asmlinkage long compat_sys_ipc(u32, int, int, u32, compat_uptr_t, u32);
 
 /* obsolete: kernel/signal.c */
-#ifdef __ARCH_WANT_SYS_SIGPENDING
 asmlinkage long compat_sys_sigpending(compat_old_sigset_t __user *set);
-#endif
-
-#ifdef __ARCH_WANT_SYS_SIGPROCMASK
 asmlinkage long compat_sys_sigprocmask(int how, compat_old_sigset_t __user *nset,
 				       compat_old_sigset_t __user *oset);
-#endif
-#ifdef CONFIG_COMPAT_OLD_SIGACTION
+struct compat_old_sigaction;
 asmlinkage long compat_sys_sigaction(int sig,
                                    const struct compat_old_sigaction __user *act,
                                    struct compat_old_sigaction __user *oact);
-#endif
 
 /* obsolete: net/socket.c */
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -63,7 +63,7 @@ COND_SYSCALL_COMPAT(lookup_dcookie);
 /* fs/eventfd.c */
 COND_SYSCALL(eventfd2);
 
-/* fs/eventfd.c */
+/* fs/eventpoll.c */
 COND_SYSCALL(epoll_create1);
 COND_SYSCALL(epoll_ctl);
 COND_SYSCALL(epoll_pwait);
@@ -94,6 +94,9 @@ COND_SYSCALL(flock);
 /* fs/nfsctl.c */
 
 /* fs/open.c */
+COND_SYSCALL_COMPAT(truncate64);
+COND_SYSCALL_COMPAT(ftruncate64);
+COND_SYSCALL_COMPAT(fallocate);
 
 /* fs/pipe.c */
 
@@ -104,6 +107,10 @@ COND_SYSCALL(quotactl_fd);
 /* fs/readdir.c */
 
 /* fs/read_write.c */
+COND_SYSCALL_COMPAT(preadv64);
+COND_SYSCALL_COMPAT(pwritev64);
+COND_SYSCALL_COMPAT(pread64);
+COND_SYSCALL_COMPAT(pwrite64);
 
 /* fs/sendfile.c */
 
@@ -118,6 +125,7 @@ COND_SYSCALL_COMPAT(signalfd4);
 /* fs/stat.c */
 
 /* fs/sync.c */
+COND_SYSCALL_COMPAT(sync_file_range);
 
 /* fs/timerfd.c */
 COND_SYSCALL(timerfd_create);
@@ -173,6 +181,11 @@ COND_SYSCALL(syslog);
 
 /* kernel/sched/core.c */
 
+/* kernel/signal.c */
+COND_SYSCALL_COMPAT(sigpending);
+COND_SYSCALL_COMPAT(sigprocmask);
+COND_SYSCALL_COMPAT(sigaction);
+
 /* kernel/sys.c */
 COND_SYSCALL(setregid);
 COND_SYSCALL(setgid);
@@ -257,7 +270,8 @@ COND_SYSCALL_COMPAT(sendmsg);
 COND_SYSCALL(recvmsg);
 COND_SYSCALL_COMPAT(recvmsg);
 
-/* mm/filemap.c */
+/* mm/readahead.c */
+COND_SYSCALL_COMPAT(readahead);
 
 /* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
@@ -306,6 +320,8 @@ COND_SYSCALL(recvmmsg);
 COND_SYSCALL(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time64);
+COND_SYSCALL_COMPAT(preadv64v2);
+COND_SYSCALL_COMPAT(pwritev64v2);
 
 /*
  * Architecture specific syscalls: see further below
