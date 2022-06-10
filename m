Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93895546CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbiFJSqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbiFJSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBC27F892
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E48621FB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38642C34114;
        Fri, 10 Jun 2022 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654886802;
        bh=WXGBkUiTe50Bk0aDEY/TJ56Vy0QMGwI6PLwEWi8lGBY=;
        h=Date:From:To:Cc:Subject:From;
        b=VH3fVi2ogdd2mPfoQr4AfGNIEAW29o8QrxCH+5yzD73ztziIcAoSk1ICFL0w0Rq3M
         k45+y2MUKZxm9XgjPtWQhovvtid0I/1wXWNf3sp5vhCAMPxSJQk4aMmLPJ6sOaq0FW
         bmw2gxzcPL4eCzzol3sGdmC/4ALtzkC3csybiBsT9DCRFqRdk395mWY678d0aWs0ym
         9wE+qoL/JrZlueJiC+qSBLpkuHlbAh4VTmvyHTZWWOPfKDQRdPI7V34vn/l+526ese
         fNFt/N8coR7ATGZ+Bt9FoZJQ7L3f+hHZOVqFGIjJfp+whax+0IvxEkXksXVW4IEaaw
         QVShcID8iLatQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E57304096F; Fri, 10 Jun 2022 15:46:39 -0300 (-03)
Date:   Fri, 10 Jun 2022 15:46:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf beauty: Update copy of linux/socket.h with the
 kernel sources
Message-ID: <YqORj9d58AiGYl8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To pick the changes in:

  f94fd25cb0aaf77f ("tcp: pass back data left in socket after receive")

That don't result in any changes in the tables generated from that
header.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/perf/trace/beauty/include/linux/socket.h' differs from latest version at 'include/linux/socket.h'
  diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/linux/socket.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 6f85f5d957efea06..17311ad9f9af2479 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -50,6 +50,9 @@ struct linger {
 struct msghdr {
 	void		*msg_name;	/* ptr to socket address structure */
 	int		msg_namelen;	/* size of socket address structure */
+
+	int		msg_inq;	/* output, data left in socket */
+
 	struct iov_iter	msg_iter;	/* data */
 
 	/*
@@ -62,8 +65,9 @@ struct msghdr {
 		void __user	*msg_control_user;
 	};
 	bool		msg_control_is_user : 1;
-	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
+	bool		msg_get_inq : 1;/* return INQ after receive */
 	unsigned int	msg_flags;	/* flags on received message */
+	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
 	struct kiocb	*msg_iocb;	/* ptr to iocb for async requests */
 };
 
@@ -434,6 +438,7 @@ extern struct file *do_accept(struct file *file, unsigned file_flags,
 extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 			 int __user *upeer_addrlen, int flags);
 extern int __sys_socket(int family, int type, int protocol);
+extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
-- 
2.36.1

