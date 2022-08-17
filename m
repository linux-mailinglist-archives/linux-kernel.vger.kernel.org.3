Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C02596DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiHQMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiHQMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F92E844DA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE9261508
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D249FC433C1;
        Wed, 17 Aug 2022 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660737718;
        bh=hMRCHnMJdsSoIi9HDP9ZK9JBT1dXk8ZU4Y6idgvRx0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=mBkG6O52spfeAMvhe1uP4eFVth/TP/3NSzz5ABpnupuntYhAM4gzmbD56wsiLWrpm
         WpkMY3R8vLgSN200lz1us9eOPjBrWFKUYgjgromHH0t6aXHWUQxNldNkfHbikHX5nl
         SwYMpS8nGUQKq5rIHpTxdLCPepYneDy7fdrjcpYmJhK9z/uWTCxJh4tVjYIedN0lfT
         eSGC1SFsyglm19MW4hToFV+LMWEXLX4TZfE76DrHAnIs+Ngdv2PjGAMNjQNF9iy9Qh
         Yi3bMRaBPdKfFItc9gv+fFTF7Vi6CDt9Bvh9CI//Jni5qsh27opVeORMDptPqZ3XwG
         Aj28UUqj+jydQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E19B4035A; Wed, 17 Aug 2022 09:01:55 -0300 (-03)
Date:   Wed, 17 Aug 2022 09:01:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dylan Yudaken <dylany@fb.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH FYI 1/1] perf beauty: Update copy of linux/socket.h with the
 kernel sources
Message-ID: <YvzYs+F+Xzq8Hvvp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  7fa875b8e53c288d ("net: copy from user before calling __copy_msghdr")
  ebe73a284f4de8c5 ("net: Allow custom iter handler in msghdr")
  7c701d92b2b5e517 ("skbuff: carry external ubuf_info in msghdr")
  c04245328dd7e915 ("net: make __sys_accept4_file() static")

That don't result in any changes in the tables generated from that
header.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/perf/trace/beauty/include/linux/socket.h' differs from latest version at 'include/linux/socket.h'
  diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Cc: David Ahern <dsahern@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Yajun Deng <yajun.deng@linux.dev>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/linux/socket.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 17311ad9f9af2479..de3701a2a2129dd6 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -14,6 +14,8 @@ struct file;
 struct pid;
 struct cred;
 struct socket;
+struct sock;
+struct sk_buff;
 
 #define __sockaddr_check_size(size)	\
 	BUILD_BUG_ON(((size) > sizeof(struct __kernel_sockaddr_storage)))
@@ -69,6 +71,9 @@ struct msghdr {
 	unsigned int	msg_flags;	/* flags on received message */
 	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
 	struct kiocb	*msg_iocb;	/* ptr to iocb for async requests */
+	struct ubuf_info *msg_ubuf;
+	int (*sg_from_iter)(struct sock *sk, struct sk_buff *skb,
+			    struct iov_iter *from, size_t length);
 };
 
 struct user_msghdr {
@@ -416,10 +421,9 @@ extern int recvmsg_copy_msghdr(struct msghdr *msg,
 			       struct user_msghdr __user *umsg, unsigned flags,
 			       struct sockaddr __user **uaddr,
 			       struct iovec **iov);
-extern int __copy_msghdr_from_user(struct msghdr *kmsg,
-				   struct user_msghdr __user *umsg,
-				   struct sockaddr __user **save_addr,
-				   struct iovec __user **uiov, size_t *nsegs);
+extern int __copy_msghdr(struct msghdr *kmsg,
+			 struct user_msghdr *umsg,
+			 struct sockaddr __user **save_addr);
 
 /* helpers which do the actual work for syscalls */
 extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
@@ -428,10 +432,6 @@ extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 extern int __sys_sendto(int fd, void __user *buff, size_t len,
 			unsigned int flags, struct sockaddr __user *addr,
 			int addr_len);
-extern int __sys_accept4_file(struct file *file, unsigned file_flags,
-			struct sockaddr __user *upeer_sockaddr,
-			 int __user *upeer_addrlen, int flags,
-			 unsigned long nofile);
 extern struct file *do_accept(struct file *file, unsigned file_flags,
 			      struct sockaddr __user *upeer_sockaddr,
 			      int __user *upeer_addrlen, int flags);
-- 
2.37.1

